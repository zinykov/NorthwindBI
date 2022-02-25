CREATE TABLE [Fact].[Order]
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

    CONSTRAINT [PK_Fack_Order] PRIMARY KEY NONCLUSTERED ( [OrderKey] ASC, [OrderDateKey] ASC ),
    
    CONSTRAINT [FK_Fact_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] ),
    CONSTRAINT [FK_Fact_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] ),
    CONSTRAINT [FK_Fact_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductID] ),
    CONSTRAINT [FK_Fact_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
    CONSTRAINT [FK_Fact_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] ),
    CONSTRAINT [FK_Fact_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] )
);
GO

CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Fact_Order] ON [Fact].[Order];
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Cusotmer_Key] ON [Fact].[Order] ( [CustomerKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Employee_Key] ON [Fact].[Order] ( [EmployeeKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Product_Key] ON [Fact].[Order] ( [ProductKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Order_Date_Key] ON [Fact].[Order] ( [OrderDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Required_Date_Key] ON [Fact].[Order] ( [RequiredDateKey] );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Shipped_Date_Key] ON [Fact].[Order] ( [ShippedDateKey] );
GO