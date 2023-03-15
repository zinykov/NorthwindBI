CREATE PROCEDURE [Maintenance].[OptimizeOrdersPartitionsMonthly]
        @CutoffTime AS DATE
AS BEGIN
/*
    Процедура объединяет секции таблицы фактов.

    Алгоритм:
        1. Проверка даты запуска, если 2 число месяца, то выполняется процедура.
        2. Опеределение границ диапазона слияния секций.
        3. Создание функции секционирования.
        4. Создание схемы секционирования.
        5. Создание копии таблицы фактов.
        6. Перенос строк данных из таблицы фактов в дублёр.
        7. Объединение секций в таблице фактов.
        8. Удаление CLUSTERED COLUMNSTORE INDEX в таблице-дублёре.
        9. Объединение секций в таблице-дублёре.
        10. Создание CLUSTERED COLUMNSTORE INDEX в таблице-дублёре.
        11. Определение номера секции для переноса в таблицу фактов.
        12. Перенос данных в таблицу фактов
        13. Удаление временных структур.
*/
	DECLARE @IsStartOptimization    AS BIT;
    DECLARE @IsSetFilegroupReadonly AS BIT;
    DECLARE @StartMonthDate         AS DATE;
	DECLARE @EndMonthDate	        AS DATE;
	DECLARE @PartitionNumber        AS INT;
    DECLARE @PartitionValue         AS DATE;
	
-- Проверка даты запуска
    EXECUTE [Maintenance].[CheckReferenceDate]
        @CutoffTime = @CutoffTime
      , @IsMonthlyOptimization = 1
      , @IsStartOptimization = @IsStartOptimization OUTPUT
      , @IsSetFilegroupReadonly = @IsSetFilegroupReadonly OUTPUT

    IF @IsStartOptimization = 0 RETURN 0;
    
-- Опеределение границ диапазона слияния секций.
    SET @EndMonthDate = EOMONTH ( @CutoffTime, -1 )
	SET @StartMonthDate = ( SELECT [StartOfMonth] FROM [Dimension].[Date] AS D WHERE [DateKey] = @EndMonthDate )

-- Создание копии таблицы фактов
		EXECUTE [Integration].[CreateLoadTableOrder]
			  @CutoffTime = @CutoffTime
			, @IsMaitenance = 1;

    DECLARE OptimizePartitions SCROLL CURSOR FOR
        SELECT		DISTINCT $PARTITION.[PF_Load_Order] ( CONVERT ( DATE, PRV.[value], 23 ) )
                    , CONVERT ( DATE, PRV.[value], 23 )

        FROM		[sys].[partition_range_values] AS PRV
        INNER JOIN	[sys].[partition_functions] AS PF ON PF.[function_id] = PRV.[function_id]
			        AND PF.[name] = N'PF_Load_Order'

        WHERE		PRV.[value] BETWEEN @StartMonthDate AND @EndMonthDate
        
	OPEN OptimizePartitions
-- Перенос строк данных из таблицы фактов в дублёр.
	    FETCH NEXT FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
        WHILE @@FETCH_STATUS = 0
		    BEGIN
    		    ALTER TABLE [Fact].[Order] SWITCH PARTITION @PartitionNumber TO [Integration].[Order] PARTITION @PartitionNumber
                FETCH NEXT FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
		    END

-- Объединение секций в таблице фактов	
        FETCH ABSOLUTE 2 FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
        WHILE @@FETCH_STATUS = 0
		    BEGIN
    		    ALTER PARTITION FUNCTION [PF_Order_Date] () MERGE RANGE ( @PartitionValue )
                FETCH NEXT FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
		    END
    CLOSE OptimizePartitions

-- Удаление CLUSTERED COLUMNSTORE INDEX в таблице-дублёре
	DROP INDEX [CCI_Integration_Order] ON [Integration].[Order];
	
-- Объединение секций в таблице-дублёре
	OPEN OptimizePartitions
	    FETCH ABSOLUTE 2 FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
        WHILE @@FETCH_STATUS = 0
			BEGIN
    			ALTER PARTITION FUNCTION [PF_Load_Order] () MERGE RANGE ( @PartitionValue )
                FETCH NEXT FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
			END
    CLOSE OptimizePartitions
    DEALLOCATE OptimizePartitions

-- Создание CLUSTERED COLUMNSTORE INDEX в таблице-дублёре
    CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Integration_Order] ON [Integration].[Order]
        ON [PS_Load_Order_Data] ( [ShippedDateKey] );

-- Определение номера секции для переноса в таблицу фактов
    SET @PartitionNumber = $PARTITION.[PF_Load_Order] ( @StartMonthDate )

-- Перенос данных в таблицу фактов
	ALTER TABLE [Integration].[Order] SWITCH PARTITION @PartitionNumber TO [Fact].[Order] PARTITION @PartitionNumber

-- Удаление временных структур
    EXECUTE [Integration].[DropLoadTableOrder];

    RETURN 0;
END