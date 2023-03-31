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
	DECLARE		@PartitionParameter AS DATE
	DECLARE		@NewPartitionParameter AS DATE
	DECLARE		@Partition_number AS INT
	DECLARE		@SQL AS NVARCHAR(2000)

-- Определение границы новой секции
	SET @NewPartitionParameter = DATEADD ( DAY, 1, @EndLoad )
-- Переменной @NewPartitionParameter присваивается значение @NewPartitionDate в формате OrderDateKey
	SET @PartitionParameter = @EndLoad

-- ШАГ 1. Определение файловых групп для схем секционирования
	SET @SQL = CONCAT (
			N'ALTER PARTITION SCHEME [PS_Order_Date_Data] NEXT USED [Order_'
		, CONVERT ( NVARCHAR(4), YEAR ( @NewPartitionParameter ) )
		, N'_Data]'
		)
	EXECUTE sp_executesql @SQL

	SET @SQL = CONCAT (
			N'ALTER PARTITION SCHEME [PS_Order_Date_Index] NEXT USED [Order_'
		, CONVERT ( NVARCHAR(4), YEAR ( @NewPartitionParameter ) )
		, N'_Index]'
		)
	EXECUTE sp_executesql @SQL

-- ШАГ 2. Создание новой секции
	IF NOT EXISTS ( SELECT 1 FROM [sys].[partition_range_values] WHERE [value] = @NewPartitionParameter )
	BEGIN
		ALTER PARTITION FUNCTION [PF_Order_Date] () SPLIT RANGE ( @NewPartitionParameter )
	END

	EXECUTE [Integration].[CreateLoadTableOrder]
		  @CutoffTime = @EndLoad
		, @IsMaitenance = 0;

-- Переменной @Partition_number присваивается номер предпоследней секции
	SET @Partition_number = $PARTITION.[PF_Order_Date] ( @PartitionParameter )

-- ШАГ 3. Загрузка данных в промежуточную таблицу
	--IF DATEDIFF ( DAY, @StartLoad, @EndLoad ) = 1
	--	BEGIN
	--		SET @StartLoad = @EndLoad
	--	END
		
	--INSERT INTO [Integration].[Order]
	--SELECT		  [OrderKey]					=	O.[OrderID]
	--			, [ProductKey]					=	ISNULL ( [ProductKey], -1 )
	--			, [CustomerKey]					=	ISNULL ( [CustomerKey], -1 )
	--			, [EmployeeKey]					=	ISNULL ( [EmployeeKey], -1 )
	--			, [OrderDateKey]				=	ISNULL ( [OrderDate], DATEFROMPARTS ( 1995, 12, 31 ) )
	--			, [RequiredDateKey]				=	ISNULL ( [RequiredDate], DATEFROMPARTS ( 1995, 12, 31 ) )
	--			, [ShippedDateKey]				=	ISNULL ( [ShippedDate], DATEFROMPARTS ( 1995, 12, 31 ) )
	--			, [UnitPrice]					=	ISNULL ( [UnitPrice], 0 )
	--			, [Quantity]					=	ISNULL ( [Quantity], 0 )
	--			, [Discount]					=	ISNULL ( [UnitPrice] * [Discount], 0 )
	--			, [SalesAmount]					=	ISNULL ( [UnitPrice] * [Quantity], 0 )
	--			, [SalesAmountWithDiscount]		=	ISNULL ( [UnitPrice] * ( [Quantity] - [Discount] ), 0 )
	--			, [LineageKey]					=	@LineageKey

	--FROM		[Landing].[Orders] AS O
	--LEFT JOIN	[Landing].[Order Details] AS OD ON O.[OrderID] = OD.[OrderID]
	--LEFT JOIN	[Dimension].[Customer] AS C ON C.[CustomerAlterKey] = O.[CustomerID]
	--			AND O.[OrderDate] BETWEEN C.[StartDate] AND ISNULL ( C.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
	--LEFT JOIN	[Dimension].[Employee] AS E ON E.[EmployeeAlterKey] = O.[EmployeeID]
	--			AND O.[OrderDate] BETWEEN E.[StartDate] AND ISNULL ( E.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
	--LEFT JOIN	[Dimension].[Product] AS P ON P.[ProductAlterKey] = OD.[ProductID]

	--WHERE		O.[ShippedDate] BETWEEN @StartLoad AND @EndLoad
-- ШАГ 4. Применение предложения SWITCH PARTITION для добавления новых записей за последний временной промежуток
	BEGIN TRANSACTION
		ALTER TABLE [Integration].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
-- ШАГ 5. Применение предложения MERGE для записей, обновлённых задним числом
--		  Если первичный ключ не совпадает, то создаются новая строка, если совпадает, то обновноляется совпавшая
		IF ( SELECT COUNT ( * ) FROM [Integration].[Order] ) > 0
		MERGE
			INTO [Fact].[Order] AS TRG
			USING [Integration].[Order] AS SRC
			ON	(
					SRC.[OrderKey]		=	TRG.[OrderKey]
				AND SRC.[ProductKey]	=	TRG.[ProductKey]
				)
			WHEN MATCHED THEN UPDATE SET
					  [OrderKey]				=	SRC.[OrderKey]
					, [ProductKey]				=	SRC.[ProductKey]
					, [CustomerKey]				=	SRC.[CustomerKey]
					, [EmployeeKey]				=	SRC.[EmployeeKey]
					, [OrderDateKey]			=	SRC.[OrderDateKey]
					, [RequiredDateKey]			=	SRC.[RequiredDateKey]
					, [ShippedDateKey]			=	SRC.[ShippedDateKey]
					, [UnitPrice]				=	SRC.[UnitPrice]
					, [Quantity]				=	SRC.[Quantity]
					, [Discount]				=	SRC.[Discount]
					, [SalesAmount]				=	SRC.[SalesAmount]
					, [SalesAmountWithDiscount]	=	SRC.[SalesAmountWithDiscount]
					, [LineageKey]				=	SRC.[LineageKey]
			WHEN NOT MATCHED BY TARGET THEN INSERT (
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

	EXECUTE [Integration].[DropLoadTableOrder];
END