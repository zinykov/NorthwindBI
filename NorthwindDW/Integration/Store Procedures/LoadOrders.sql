CREATE PROCEDURE [Integration].[LoadOrders]
	  @StartLoad AS DATE
	, @EndLoad AS DATE
	, @LineageKey AS INT
AS
/*
	Процедура производит добавочное обновления таблицы фактов Fact.Order

	Переменные:
		@NewPartitionDate (дата) - новая граница секций в формате даты
		@NewPartitionParameter (целочисленное) - новая граница секции в формате OrderDateKey
		@Partition_number (целочисленное) - определение номера секции для предложения SWITCH PARTITION

	Алгоритм:
		1. Определение файловых групп для схем секционирования
		2. Создание новой секции
		3. Загрузка данных в промежуточную таблицу
		4. Применение предложения SWITCH PARTITION для добавления новых записей за последний временной промежуток
		5. Применение предложения MERGE для записей, обновлённых задним числом
*/
BEGIN
-- Объявление переменных
		DECLARE		@NewPartitionParameterDate AS DATE
		DECLARE		@NewPartitionParameter AS INT
		DECLARE		@Partition_number AS INT

-- Определение границы новой секции
	SET @NewPartitionParameterDate = DATEADD ( DAY, 1, @EndLoad )
-- Переменной @NewPartitionParameter присваивается значение @NewPartitionDate в формате OrderDateKey
		SET @NewPartitionParameter = YEAR ( @NewPartitionParameterDate ) * 10000 + MONTH ( @NewPartitionParameterDate ) * 100 + DAY ( @NewPartitionParameterDate )

-- Переменной @Partition_number присваивается номер предпоследней секции
		SET @Partition_number = (
			SELECT		TOP (1) partition_number
			FROM		sys.partitions
			WHERE		object_id = OBJECT_ID ( CONCAT ( DB_NAME (), N'.Staging.Order' ) )			
			ORDER BY	partition_number DESC
		)

-- ШАГ 1. Определение файловых групп для схем секционирования
		ALTER PARTITION SCHEME [PS_Order_Date_Data]  
			NEXT USED [Fast_Fact_Data]

		ALTER PARTITION SCHEME [PS_Order_Date_Index]  
			NEXT USED [Fast_Fact_Index]

-- ШАГ 2. Создание новой секции
		IF NOT EXISTS ( SELECT 1 FROM [sys].[partition_range_values] WHERE [value] = @NewPartitionParameter )
		BEGIN
			ALTER PARTITION FUNCTION [PF_Order_Date] () SPLIT RANGE ( @NewPartitionParameter )
		END

-- ШАГ 3. Загрузка данных в промежуточную таблицу
		IF DATEDIFF ( DAY, @StartLoad, @EndLoad ) = 1
			BEGIN
				SET @StartLoad = @EndLoad
			END
		
		INSERT INTO [Staging].[Order]
		SELECT		  [OrderKey]					=	O.[OrderID]
					, [ProductKey]					=	ISNULL ( [ProductKey], -1 )
					, [CustomerKey]					=	ISNULL ( [CustomerKey], -1 )
					, [EmployeeKey]					=	ISNULL ( [EmployeeKey], -1 )
					, [OrderDateKey]				=	ISNULL ( YEAR ( [OrderDate] ) * 10000 + MONTH ( [OrderDate] ) * 100 + DAY ( [OrderDate] ), 19960101 )
					, [RequiredDateKey]				=	ISNULL ( YEAR ( [RequiredDate] ) * 10000 + MONTH ( [RequiredDate] ) * 100 + DAY ( [RequiredDate] ), 19960101 )
					, [ShippedDateKey]				=	ISNULL ( YEAR ( [ShippedDate] ) * 10000 + MONTH ( [ShippedDate] ) * 100 + DAY ( [ShippedDate] ), 19960101 )
					, [UnitPrice]					=	ISNULL ( [UnitPrice], 0 )
					, [Quantity]					=	ISNULL ( [Quantity], 0 )
					, [Discount]					=	ISNULL ( [UnitPrice] * [Discount], 0 )
					, [SalesAmount]					=	ISNULL ( [UnitPrice] * [Quantity], 0 )
					, [SalesAmountWithDiscount]		=	ISNULL ( [UnitPrice] * ( [Quantity] - [Discount] ), 0 )
					, [LineageKey]					=	@LineageKey

		FROM		[Landing].[Orders] AS O
		LEFT JOIN	[Landing].[Order Details] AS OD ON O.[OrderID] = OD.[OrderID]
		LEFT JOIN	[Dimension].[Customer] AS C ON C.[CustomerAlterKey] = O.[CustomerID]
					AND O.[OrderDate] BETWEEN C.[StartDate] AND C.[EndDate]
		LEFT JOIN	[Dimension].[Employee] AS E ON E.[EmployeeAlterKey] = O.[EmployeeID]
					AND O.[OrderDate] BETWEEN E.[StartDate] AND E.[EndDate]
		LEFT JOIN	[Dimension].[Product] AS P ON P.[ProductAlterKey] = OD.[ProductID]

		WHERE		O.[OrderDate] BETWEEN @StartLoad AND @EndLoad
-- ШАГ 4. Применение предложения SWITCH PARTITION для добавления новых записей за последний временной промежуток
		BEGIN TRANSACTION
			ALTER TABLE [Staging].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
-- ШАГ 5. Применение предложения MERGE для записей, обновлённых задним числом
--		  Если первичный ключ не совпадает, то создаются новая строка, если совпадает, то обновноляется совпавшая
			IF ( SELECT COUNT ( * ) FROM [Staging].[Order] ) > 0
			MERGE
				INTO [Fact].[Order] AS TRG
				USING [Staging].[Order] AS SRC
				ON	(
						TRG.[OrderKey]		=	SRC.[OrderKey]
					AND TRG.[ProductKey]	=	SRC.[ProductKey]
					AND TRG.[OrderDateKey]	=	SRC.[OrderDateKey]
					)
				WHEN MATCHED THEN UPDATE SET
						  TRG.[OrderKey]				=	SRC.[OrderKey]
						, TRG.[ProductKey]				=	SRC.[ProductKey]
						, TRG.[CustomerKey]				=	SRC.[CustomerKey]
						, TRG.[EmployeeKey]				=	SRC.[EmployeeKey]
						, TRG.[OrderDateKey]			=	SRC.[OrderDateKey]
						, TRG.[RequiredDateKey]			=	SRC.[RequiredDateKey]
						, TRG.[ShippedDateKey]			=	SRC.[ShippedDateKey]
						, TRG.[UnitPrice]				=	SRC.[UnitPrice]
						, TRG.[Quantity]				=	SRC.[Quantity]
						, TRG.[Discount]				=	SRC.[Discount]
						, TRG.[SalesAmount]				=	SRC.[SalesAmount]
						, TRG.[SalesAmountWithDiscount]	=	SRC.[SalesAmountWithDiscount]
						, TRG.[LineageKey]				=	SRC.[LineageKey]
			
				WHEN NOT MATCHED THEN INSERT (
						  [OrderKey]
						, [ProductKey]
						, [CustomerKey]
						, [EmployeeKey]
						, [OrderDateKey]
						, [RequiredDateKey]
						, [ShippedDateKey]
						, [UnitPrice]
						, [Quantity]
						, [Discount]
						, [SalesAmount]
						, [SalesAmountWithDiscount]
						, [LineageKey]
					) VALUES (
						  SRC.[OrderKey]
						, SRC.[ProductKey]
						, SRC.[CustomerKey]
						, SRC.[EmployeeKey]
						, SRC.[OrderDateKey]
						, SRC.[RequiredDateKey]
						, SRC.[ShippedDateKey]
						, SRC.[UnitPrice]
						, SRC.[Quantity]
						, SRC.[Discount]
						, SRC.[SalesAmount]
						, SRC.[SalesAmountWithDiscount]
						, SRC.[LineageKey]
					);
		COMMIT
END