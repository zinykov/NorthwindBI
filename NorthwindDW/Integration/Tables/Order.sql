CREATE TABLE [Integration].[Order]
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

    CONSTRAINT [PK_Fack_Order] PRIMARY KEY NONCLUSTERED ( [OrderKey] ASC, [OrderDateKey] ASC, [ProductKey] ASC ) ON [PS_Order_Date_Index] ( [OrderDateKey] )
);
GO

CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Integration_Order] ON [Integration].[Order]
    ON [PS_Order_Date_Data] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Integration_Order_Order_Date_Key] ON [Integration].[Order] ( [OrderDateKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Integration_Order_Required_Date_Key] ON [Integration].[Order] ( [RequiredDateKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Integration_Order_Shipped_Date_Key] ON [Integration].[Order] ( [ShippedDateKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Integration_Order_Cusotmer_Key] ON [Integration].[Order] ( [CustomerKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Integration_Order_Employee_Key] ON [Integration].[Order] ( [EmployeeKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Integration_Order_Product_Key] ON [Integration].[Order] ( [ProductKey] )
    ON [PS_Order_Date_Index] ( [OrderDateKey] );
GO