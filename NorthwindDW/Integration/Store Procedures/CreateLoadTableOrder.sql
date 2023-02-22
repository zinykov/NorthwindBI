CREATE PROCEDURE [Integration].[CreateLoadTableOrder]
      @CutoffTime AS DATE
    , @IsMaitenance AS BIT
AS BEGIN
	DECLARE @EndMonthDate	        AS DATE;
	DECLARE @Bondaries		        AS NVARCHAR(2000);
	DECLARE @CreatePF		        AS NVARCHAR(4000);
	DECLARE @CreatePS		        AS NVARCHAR(4000);
    DECLARE @YearNumber             AS INT;
	
-- Опеределение границ диапазона слияния секций.
    IF ( @IsMaitenance = 1 )
        BEGIN
            SET @EndMonthDate = EOMONTH ( @CutoffTime, -1 )
        END
    ELSE
        BEGIN
            SET @EndMonthDate = EOMONTH ( @CutoffTime, 0 )
        END
	SET @YearNumber = YEAR ( @EndMonthDate )

	SELECT  @Bondaries = COALESCE ( @Bondaries + ',', '' ) + CONVERT ( NVARCHAR(8), [value] )
    FROM    [sys].[partition_range_values];

-- Создание функции секционирования
	SET @CreatePF = CONCAT ( N'CREATE PARTITION FUNCTION [PF_Load_Order] ( INT ) AS RANGE RIGHT FOR VALUES ( ', @Bondaries, ' )' )
	EXECUTE sp_executesql @CreatePF;

-- Создание схемы секционирования
    SET @CreatePS = CONCAT ( N'CREATE PARTITION SCHEME [PS_Load_Order_Data] AS PARTITION [PF_Load_Order] ALL TO ( [Order_', @YearNumber, N'_Data] )' );
    EXECUTE sp_executesql @CreatePS

    SET @CreatePS = CONCAT ( N'CREATE PARTITION SCHEME [PS_Load_Order_Index] AS PARTITION [PF_Load_Order] ALL TO ( [Order_', @YearNumber, N'_Index] )' );
    EXECUTE sp_executesql @CreatePS

-- Создание копии таблицы фактов
	CREATE TABLE [Integration].[Order] (
	    [OrderKey]                      INT             NOT NULL,
        [ProductKey]                    INT             NOT NULL,
        [CustomerKey]                   INT             NULL, 
        [EmployeeKey]                   INT             NULL,
        [OrderDateKey]                  INT             NULL, 
        [RequiredDateKey]               INT             NULL, 
        [ShippedDateKey]                INT             NULL,
        [UnitPrice]                     MONEY           NULL,
        [Quantity]                      INT             NULL,
        [Discount]                      MONEY           NULL,
        [SalesAmount]                   MONEY           NULL,
        [SalesAmountWithDiscount]       MONEY           NULL,
        [LineageKey]                    INT             NULL,

        CONSTRAINT [FK_Integration_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] ),
        CONSTRAINT [FK_Integration_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] ),
        CONSTRAINT [FK_Integration_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductKey] ),
        CONSTRAINT [FK_Integration_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
        CONSTRAINT [FK_Integration_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
        CONSTRAINT [FK_Integration_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
        CONSTRAINT [FK_Integration_Order_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] )
    )
    ON [PS_Load_Order_Data] ( [OrderDateKey] );

    CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Integration_Order] ON [Integration].[Order]
        ON [PS_Load_Order_Data] ( [ShippedDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Order_Date_Key] ON [Integration].[Order] ( [OrderDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [ShippedDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Required_Date_Key] ON [Integration].[Order] ( [RequiredDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [ShippedDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Shipped_Date_Key] ON [Integration].[Order] ( [ShippedDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [ShippedDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Cusotmer_Key] ON [Integration].[Order] ( [CustomerKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [ShippedDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Employee_Key] ON [Integration].[Order] ( [EmployeeKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [ShippedDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Product_Key] ON [Integration].[Order] ( [ProductKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [ShippedDateKey] );

	RETURN 0;
END