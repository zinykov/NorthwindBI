CREATE PROCEDURE [Integration].[IncrementalOrdersLoadTEST]
	@NewPartitionParameter AS INT
AS
/*
	Процедура производит добавочное обновления таблицы фактов Fact.Order

	Переменные:
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
		DECLARE		@Partition_number AS INT

-- Переменной @Partition_number присваивается номер предпоследней секции
		SET @Partition_number = (
			SELECT		TOP (1) partition_number -1
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
			ALTER PARTITION FUNCTION [PF_Order_Date] ()
				SPLIT RANGE ( @NewPartitionParameter )
			PRINT ( @NewPartitionParameter )
		END

-- ШАГ 3. Загрузка данных в промежуточную таблицу
		INSERT INTO [Staging].[Order]
		SELECT		  [OrderKey]					=	O.[OrderID]
					, [ProductKey]
					, [CustomerKey]
					, [EmployeeKey]
					, [OrderDateKey]				=	YEAR ( [OrderDate] ) * 10000 + MONTH ( [OrderDate] ) * 100 + DAY ( [OrderDate] )
					, [RequiredDateKey]				=	YEAR ( [RequiredDate] ) * 10000 + MONTH ( [RequiredDate] ) * 100 + DAY ( [RequiredDate] )
					, [ShippedDateKey]				=	YEAR ( [ShippedDate] ) * 10000 + MONTH ( [ShippedDate] ) * 100 + DAY ( [ShippedDate] )
					, [UnitPrice]
					, [Quantity]
					, [Discount]					=	[UnitPrice] * [Discount]
					, [SalesAmount]					=	[UnitPrice] * [Quantity]
					, [SalesAmountWithDiscount]		=	[UnitPrice] * [Quantity] - [Discount]

		FROM		[Landing].[Orders] AS O
		INNER JOIN	[Landing].[Order Details] AS OD ON O.[OrderID] = OD.[OrderID]
		INNER JOIN	[Dimension].[Customer] AS C ON C.[CustomerAlterKey] = O.[CustomerID]
					AND O.[OrderDate] BETWEEN C.[StartDate] AND ISNULL ( C.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
		INNER JOIN	[Dimension].[Employee] AS E ON E.[EmployeeAlterKey] = O.[EmployeeID]
					AND O.[OrderDate] BETWEEN E.[StartDate] AND ISNULL ( E.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
		INNER JOIN	[Dimension].[Product] AS P ON P.[ProductAlterKey] = OD.[ProductID]
					AND O.[OrderDate] BETWEEN P.[StartDate] AND ISNULL ( P.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )

		WHERE		YEAR ( [OrderDate] ) * 10000 + MONTH ( [OrderDate] ) * 100 + DAY ( [OrderDate] ) = @NewPartitionParameter - 1

-- ШАГ 4. Применение предложения SWITCH PARTITION для добавления новых записей за последний временной промежуток
		ALTER TABLE [Staging].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number

-- ШАГ 5. Применение предложения MERGE для записей, обновлённых задним числом
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
				);
END