﻿CREATE PROCEDURE [Maintenance].[OptimizeOrdersPartitionsMonthly]
      @CutoffTime AS DATE
AS
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
BEGIN
	DECLARE @ReferenceDate          AS DATE;
    DECLARE @IsStartOptimization    AS BIT;
    DECLARE @StartMonthDate         AS DATE;
	DECLARE @EndMonthDate	        AS DATE;
	DECLARE @StartKey		        AS INT;
	DECLARE @EndKey			        AS INT;
	DECLARE @Bondaries		        AS NVARCHAR(2000);
	DECLARE @CreatePF		        AS NVARCHAR(4000);
	DECLARE @CreatePS		        AS NVARCHAR(4000);
    DECLARE @FileDataGroups         AS NVARCHAR(2000);
    DECLARE @FileIndexGroups        AS NVARCHAR(2000);
    DECLARE @PartitionNumber        AS INT;
    DECLARE @PartitionValue         AS INT;
    DECLARE @YearNumber             AS INT;
	
-- Проверка даты запуска
    EXECUTE [Maintenance].[CheckReferenceDate]
        @CutoffTime = @CutoffTime
      , @IsMonthlyOptimization = 1
      , @IsStartOptimization = @IsStartOptimization OUTPUT

    IF @IsStartOptimization = 0 RETURN 0;
    
-- Опеределение границ диапазона слияния секций.
    SET @EndMonthDate = EOMONTH ( @CutoffTime, -1 )
	SET @StartMonthDate = ( SELECT [StartOfMonth] FROM [Dimension].[Date] AS D WHERE [AlterDateKey] = @EndMonthDate )
	SET @StartKey = ( SELECT [DateKey] FROM [Dimension].[Date] AS D WHERE [AlterDateKey] = @StartMonthDate )
	SET @EndKey = ( SELECT [DateKey] FROM [Dimension].[Date] AS D WHERE [AlterDateKey] = @EndMonthDate )
    SET @YearNumber = YEAR ( @EndMonthDate )

	SELECT  @Bondaries = COALESCE ( @Bondaries + ',', '' ) + CONVERT ( NVARCHAR(8), [value] )
    FROM    [sys].[partition_range_values];

-- Создание функции секционирования
	SET @CreatePF = CONCAT ( N'CREATE PARTITION FUNCTION [PF_Optimize_Partitions] ( INT ) AS RANGE RIGHT FOR VALUES ( ', @Bondaries, ' )' )
	EXECUTE sp_executesql @CreatePF;

-- Создание схемы секционирования
    SET @CreatePS = CONCAT ( N'CREATE PARTITION SCHEME [PS_Optimize_Partitions_Data] AS PARTITION [PF_Optimize_Partitions] ALL TO ( [Order_', @YearNumber, N'_Data] )' );
    EXECUTE sp_executesql @CreatePS

    SET @CreatePS = CONCAT ( N'CREATE PARTITION SCHEME [PS_Optimize_Partitions_Index] AS PARTITION [PF_Optimize_Partitions] ALL TO ( [Order_', @YearNumber, N'_Index] )' );
    EXECUTE sp_executesql @CreatePS

-- Создание копии таблицы фактов
	CREATE TABLE [Maintenance].[Order]
    (
	    [OrderKey]                      INT             NOT NULL,
        [ProductKey]                    INT             NOT NULL,
        [CustomerKey]                   INT             NULL, 
        [EmployeeKey]                   INT             NULL,
        [OrderDateKey]                  INT             NOT NULL, 
        [RequiredDateKey]               INT             NULL, 
        [ShippedDateKey]                INT             NULL,
        [UnitPrice]                     MONEY           NULL,
        [Quantity]                      INT             NULL,
        [Discount]                      MONEY           NULL,
        [SalesAmount]                   MONEY           NULL,
        [SalesAmountWithDiscount]       MONEY           NULL,
        [LineageKey]                    INT             NULL,

        CONSTRAINT [FK_Maintenance_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] ),
        CONSTRAINT [FK_Maintenance_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] ),
        CONSTRAINT [FK_Maintenance_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductKey] ),
        CONSTRAINT [FK_Maintenance_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
        CONSTRAINT [FK_Maintenance_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
        CONSTRAINT [FK_Maintenance_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
        CONSTRAINT [FK_Maintenance_Order_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] )
    )
    ON [PS_Optimize_Partitions_Data] ( [OrderDateKey] );

    CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Maintenance_Order] ON [Maintenance].[Order]
        ON [PS_Optimize_Partitions_Data] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Maintenance_Order_Order_Date_Key] ON [Maintenance].[Order] ( [OrderDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Optimize_Partitions_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Maintenance_Order_Required_Date_Key] ON [Maintenance].[Order] ( [RequiredDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Optimize_Partitions_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Maintenance_Order_Shipped_Date_Key] ON [Maintenance].[Order] ( [ShippedDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Optimize_Partitions_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Maintenance_Order_Cusotmer_Key] ON [Maintenance].[Order] ( [CustomerKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Optimize_Partitions_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Maintenance_Order_Employee_Key] ON [Maintenance].[Order] ( [EmployeeKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Optimize_Partitions_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Maintenance_Order_Product_Key] ON [Maintenance].[Order] ( [ProductKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Optimize_Partitions_Index] ( [OrderDateKey] );

    DECLARE OptimizePartitions SCROLL CURSOR FOR
        SELECT		DISTINCT $PARTITION.[PF_Optimize_Partitions] ( CAST ( PRV.[value] AS INT ) )
                    , CAST ( PRV.[value] AS INT )

        FROM		[sys].[partition_range_values] AS PRV
        INNER JOIN	[sys].[partition_functions] AS PF ON PF.[function_id] = PRV.[function_id]
			        AND PF.[name] = N'PF_Optimize_Partitions'

        WHERE		PRV.[value] BETWEEN @StartKey AND @EndKey
        
	OPEN OptimizePartitions
-- Перенос строк данных из таблицы фактов в дублёр.
	    FETCH NEXT FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
        WHILE @@FETCH_STATUS = 0
		    BEGIN
    		    ALTER TABLE [Fact].[Order] SWITCH PARTITION @PartitionNumber TO [Maintenance].[Order] PARTITION @PartitionNumber
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
	DROP INDEX [CCI_Maintenance_Order] ON [Maintenance].[Order];
	
-- Объединение секций в таблице-дублёре
	OPEN OptimizePartitions
	    FETCH ABSOLUTE 2 FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
        WHILE @@FETCH_STATUS = 0
			BEGIN
    			ALTER PARTITION FUNCTION [PF_Optimize_Partitions] () MERGE RANGE ( @PartitionValue )
                FETCH NEXT FROM OptimizePartitions INTO @PartitionNumber, @PartitionValue
			END
    CLOSE OptimizePartitions
    DEALLOCATE OptimizePartitions

-- Создание CLUSTERED COLUMNSTORE INDEX в таблице-дублёре
    CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Maintenance_Order] ON [Maintenance].[Order]
        ON [PS_Optimize_Partitions_Data] ( [OrderDateKey] );

-- Определение номера секции для переноса в таблицу фактов
    SET @PartitionNumber = $PARTITION.[PF_Optimize_Partitions] ( @StartKey )

-- Перенос данных в таблицу фактов
	ALTER TABLE [Maintenance].[Order] SWITCH PARTITION @PartitionNumber TO [Fact].[Order] PARTITION @PartitionNumber

-- Удаление временных структур
	DROP TABLE [Maintenance].[Order];
	DROP PARTITION SCHEME [PS_Optimize_Partitions_Data];
	DROP PARTITION SCHEME [PS_Optimize_Partitions_Index];
	DROP PARTITION FUNCTION [PF_Optimize_Partitions];

    RETURN 0;
END