CREATE PROCEDURE [Integration].[CreateLoadTableOrder]
      @CutoffTime AS DATE
    , @IsMaitenance AS BIT
AS BEGIN
	DECLARE @EndMonthDate	        AS DATE;
	DECLARE @Bondaries		        AS NVARCHAR(MAX);
    DECLARE @FileGroupNamesData     AS NVARCHAR(MAX);
    DECLARE @FileGroupNamesIndex    AS NVARCHAR(MAX);
	DECLARE @CreatePF		        AS NVARCHAR(MAX);
	DECLARE @CreatePS		        AS NVARCHAR(MAX);
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

	SELECT		@Bondaries = COALESCE ( @Bondaries + ',', '' ) + CONCAT ( N' CAST ( ''', CAST ( CONVERT ( DATE, [value], 23 ) AS NVARCHAR(10) ), N''' AS DATE )' )
    FROM		sys.partition_range_values AS PRV
	INNER JOIN	sys.partition_functions AS PS ON PS.[function_id] = PRV.[function_id]
	WHERE		PS.[name] = N'PF_Order_Date';
	
-- Создание функции секционирования
	SET @CreatePF = CONCAT ( N'CREATE PARTITION FUNCTION [PF_Load_Order] ( DATE ) AS RANGE RIGHT FOR VALUES ( ', @Bondaries, ' )' )
	EXECUTE sp_executesql @CreatePF;

-- Создание схемы секционирования
    SELECT		  @FileGroupNamesData = 
					COALESCE ( @FileGroupNamesData + ',', '' )
					+ QUOTENAME (  CASE
										WHEN COALESCE ( FG.[is_read_only], FGP.[is_read_only] ) = CAST ( 1 AS BIT )
										THEN CONCAT ( N'Order_', @YearNumber, N'_Data' )
										ELSE COALESCE ( FG.[name], FGP.[name] )
									END
					)
	
	FROM		sys.tables AS T
	INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
	LEFT JOIN	sys.partitions AS P ON T.[object_id] = P.[object_id]
	LEFT JOIN	sys.indexes AS I ON T.[object_id] = I.[object_id]
				AND P.[index_id] = I.[index_id]
	LEFT JOIN	sys.data_spaces AS DS ON DS.[data_space_id] = I.[data_space_id]
	LEFT JOIN	sys.partition_schemes AS PS ON PS.[data_space_id] = DS.[data_space_id]
	LEFT JOIN	sys.partition_functions AS PF ON PF.[function_id] = PS.[function_id]
	LEFT JOIN	sys.destination_data_spaces AS DDS ON DDS.[partition_scheme_id] = PS.[data_space_id]
				AND DDS.[destination_id] = P.[partition_number]
	LEFT JOIN	sys.filegroups AS FG ON FG.[data_space_id] = I.[data_space_id]
	LEFT JOIN	sys.filegroups AS FGP ON FGP.[data_space_id] = DDS.[data_space_id]
	
	WHERE		OBJECTPROPERTY ( P.[object_id], 'ISMSShipped') = 0
			    AND S.[name] = 'Fact'
				AND T.[name] = 'Order'
				AND I.[index_id] = 1
	
	ORDER BY	  P.[partition_number]

    SET @CreatePS = CONCAT ( N'CREATE PARTITION SCHEME [PS_Load_Order_Data] AS PARTITION [PF_Load_Order] TO ( ', @FileGroupNamesData, N' )' );
    EXECUTE sp_executesql @CreatePS
    
    SELECT		  @FileGroupNamesIndex = 
					COALESCE ( @FileGroupNamesIndex + ',', '' )
					+ QUOTENAME (  CASE
										WHEN COALESCE ( FG.[is_read_only], FGP.[is_read_only] ) = CAST ( 1 AS BIT )
										THEN CONCAT ( N'Order_', @YearNumber, N'_Index' )
										ELSE COALESCE ( FG.[name], FGP.[name] )
									END
					)
	
	FROM		sys.tables AS T
	INNER JOIN	sys.schemas AS S ON T.[schema_id] = S.[schema_id]
	LEFT JOIN	sys.partitions AS P ON T.[object_id] = P.[object_id]
	LEFT JOIN	sys.indexes AS I ON T.[object_id] = I.[object_id]
				AND P.[index_id] = I.[index_id]
	LEFT JOIN	sys.data_spaces AS DS ON DS.[data_space_id] = I.[data_space_id]
	LEFT JOIN	sys.partition_schemes AS PS ON PS.[data_space_id] = DS.[data_space_id]
	LEFT JOIN	sys.partition_functions AS PF ON PF.[function_id] = PS.[function_id]
	LEFT JOIN	sys.destination_data_spaces AS DDS ON DDS.[partition_scheme_id] = PS.[data_space_id]
				AND DDS.[destination_id] = P.[partition_number]
	LEFT JOIN	sys.filegroups AS FG ON FG.[data_space_id] = I.[data_space_id]
	LEFT JOIN	sys.filegroups AS FGP ON FGP.[data_space_id] = DDS.[data_space_id]
	
	WHERE		OBJECTPROPERTY ( P.[object_id], 'ISMSShipped') = 0
			    AND S.[name] = 'Fact'
				AND T.[name] = 'Order'
				AND I.[index_id] = 2
	
	ORDER BY	  P.[partition_number]

    SET @CreatePS = CONCAT ( N'CREATE PARTITION SCHEME [PS_Load_Order_Index] AS PARTITION [PF_Load_Order] TO ( ', @FileGroupNamesIndex, N' )' );
    EXECUTE sp_executesql @CreatePS

-- Создание копии таблицы фактов
	CREATE TABLE [Integration].[Order] (
	    [OrderKey]                      INT             NOT NULL,
        [ProductKey]                    INT             NOT NULL,
        [CustomerKey]                   INT             NULL, 
        [EmployeeKey]                   INT             NULL,
        [OrderDateKey]                  DATE			NULL, 
        [RequiredDateKey]               DATE			NULL, 
        [ShippedDateKey]                DATE			NULL, 
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
    ON [PS_Load_Order_Data] ( [ShippedDateKey] );

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