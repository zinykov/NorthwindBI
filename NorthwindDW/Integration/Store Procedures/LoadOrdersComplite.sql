CREATE PROCEDURE [Integration].[LoadOrdersComplite]
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
	DECLARE		@PartitionParameter AS INT
	DECLARE		@NewPartitionParameterDate AS DATE
	DECLARE		@NewPartitionParameter AS INT
	DECLARE		@Partition_number AS INT
	DECLARE		@SQL AS NVARCHAR(2000)

-- Определение границы новой секции
	SET @NewPartitionParameterDate = DATEADD ( DAY, 1, @EndLoad )
-- Переменной @NewPartitionParameter присваивается значение @NewPartitionDate в формате OrderDateKey
	SET @NewPartitionParameter = YEAR ( @NewPartitionParameterDate ) * 10000 + MONTH ( @NewPartitionParameterDate ) * 100 + DAY ( @NewPartitionParameterDate )
	SET @PartitionParameter = YEAR ( @EndLoad ) * 10000 + MONTH ( @EndLoad ) * 100 + DAY ( @EndLoad )

-- ШАГ 4. Применение предложения SWITCH PARTITION для добавления новых записей за последний временной промежуток
	BEGIN TRANSACTION
		ALTER TABLE [Integration].[Order] SWITCH PARTITION 2 TO [Fact].[Order] PARTITION 2
		ALTER TABLE [Integration].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
-- ШАГ 5. Применение предложения MERGE для записей, обновлённых задним числом
--		  Если первичный ключ не совпадает, то создаются новая строка, если совпадает, то обновноляется совпавшая
		IF ( SELECT COUNT ( * ) FROM [Integration].[Order] ) > 0
		MERGE
			INTO [Fact].[Order] AS TRG
			USING [Integration].[Order] AS SRC
			ON	(
					TRG.[OrderKey]		=	SRC.[OrderKey]
				AND TRG.[ProductKey]	=	SRC.[ProductKey]
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

	EXECUTE [Integration].[DropLoadTableOrder];
END