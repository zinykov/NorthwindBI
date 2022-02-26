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

    CONSTRAINT [PK_Integration_Order] PRIMARY KEY NONCLUSTERED ( [OrderKey] ASC, [OrderDateKey] ASC ) ON [PS_Order_Date_Data] ( [OrderDateKey] ),
    
    CONSTRAINT [FK_Integration_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] ),
    CONSTRAINT [FK_Integration_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] ),
    CONSTRAINT [FK_Integration_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductKey] ),
    CONSTRAINT [FK_Integration_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
    CONSTRAINT [FK_Integration_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
    CONSTRAINT [FK_Integration_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] )
) 
    ON [PS_Order_Date_Data] ( [OrderDateKey] );
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