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

    CONSTRAINT [PK_Staging_Order] PRIMARY KEY NONCLUSTERED ( [OrderKey] ASC, [OrderDateKey] ASC, [ProductKey] ASC )
        ON [PS_Order_Date_Index] ( [OrderDateKey] )
);
GO

CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Staging_Order] ON [Staging].[Order]
    ON [PS_Order_Date_Data] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Order_Date_Key] ON [Staging].[Order] ( [OrderDateKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Required_Date_Key] ON [Staging].[Order] ( [RequiredDateKey] )
   WHERE [OrderDateKey] >= 19970101
   ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Shipped_Date_Key] ON [Staging].[Order] ( [ShippedDateKey] )
    WHERE [OrderDateKey] >= 19970101
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Cusotmer_Key] ON [Staging].[Order] ( [CustomerKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Employee_Key] ON [Staging].[Order] ( [EmployeeKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Staging_Order_Product_Key] ON [Staging].[Order] ( [ProductKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO