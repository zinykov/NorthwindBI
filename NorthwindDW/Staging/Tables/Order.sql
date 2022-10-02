CREATE TABLE [Staging].[Order]
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

    CONSTRAINT [FK_Staging_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] ),
    CONSTRAINT [FK_Staging_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] ),
    CONSTRAINT [FK_Staging_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductKey] ),
    CONSTRAINT [FK_Staging_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
    CONSTRAINT [FK_Staging_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
    CONSTRAINT [FK_Staging_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
    CONSTRAINT [FK_Staging_Order_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] )
);
GO

CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Staging_Order] ON [Staging].[Order]
    WITH (
          DATA_COMPRESSION = COLUMNSTORE ON PARTITIONS ( 3,4,5,6,7,8,9 )
        , DATA_COMPRESSION = COLUMNSTORE_ARCHIVE ON PARTITIONS ( 1,2 )
    )
    ON [PS_Order_Date_Data] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Order_Date_Key] ON [Staging].[Order] ( [OrderDateKey] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Required_Date_Key] ON [Staging].[Order] ( [RequiredDateKey] )
   WHERE [OrderDateKey] >= 19970101
   WITH ( DATA_COMPRESSION = PAGE )
   ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Shipped_Date_Key] ON [Staging].[Order] ( [ShippedDateKey] )
    WHERE [OrderDateKey] >= 19970101
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Cusotmer_Key] ON [Staging].[Order] ( [CustomerKey] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Employee_Key] ON [Staging].[Order] ( [EmployeeKey] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Product_Key] ON [Staging].[Order] ( [ProductKey] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO