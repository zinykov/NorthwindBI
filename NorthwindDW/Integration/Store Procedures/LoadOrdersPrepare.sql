CREATE PROCEDURE [Integration].[LoadOrdersPrepare]
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

-- ШАГ 1. Определение файловых групп для схем секционирования
	SET @SQL = CONCAT (
			N'ALTER PARTITION SCHEME [PS_Order_Date_Data] NEXT USED [Order_'
		, CONVERT ( NVARCHAR(4), YEAR ( @NewPartitionParameterDate ) )
		, N'_Data]'
		)
	EXECUTE sp_executesql @SQL

	SET @SQL = CONCAT (
			N'ALTER PARTITION SCHEME [PS_Order_Date_Index] NEXT USED [Order_'
		, CONVERT ( NVARCHAR(4), YEAR ( @NewPartitionParameterDate ) )
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
	IF DATEDIFF ( DAY, @StartLoad, @EndLoad ) = 1
		BEGIN
			SET @StartLoad = @EndLoad
		END
END