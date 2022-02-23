CREATE TABLE [Fact].[Order]
(
	[OrderID]                       INT             NOT NULL,
    [ProductID]                     INT             NOT NULL,
    [CustomerID]                    INT             NULL, 
    [EmployeeID]                    INT             NULL,
    [OrderDateID]                   INT             NOT NULL, 
    [RequiredDateID]                INT             NULL, 
    [ShippedDateID]                 INT             NULL,
    [UnitPrice]                     MONEY           NULL,
    [Quantity]                      INT             NULL,
    [Discount]                      MONEY           NULL,
    [SalesAmount]                   MONEY           NULL,
    [SalesAmountWithDiscount]       MONEY           NULL,

    CONSTRAINT [PK_Fack_Order] PRIMARY KEY NONCLUSTERED ( [OrderID] ASC, [OrderDateID] ASC ),
    
    CONSTRAINT [FK_Fact_Order_Customer_ID_Dimension_Customer] FOREIGN KEY ( [CustomerID] ) REFERENCES [Dimension].[Customer] ( [CustomerID] ),
    CONSTRAINT [FK_Fact_Order_Employee_ID_Dimension_Employee] FOREIGN KEY ( [EmployeeID] ) REFERENCES [Dimension].[Employee] ( [EmployeeID] ),
    CONSTRAINT [FK_Fact_Order_Product_ID_Dimension_Product] FOREIGN KEY ( [ProductID] ) REFERENCES [Dimension].[Product] ( [ProductID] ),
    CONSTRAINT [FK_Fact_Order_Order_Date_ID_Dimension_Date] FOREIGN KEY ( [OrderDateID] ) REFERENCES [Dimension].[Date] ( [DateID] ),
    CONSTRAINT [FK_Fact_Order_Required_Date_ID_Dimension_Date] FOREIGN KEY ( [RequiredDateID] ) REFERENCES [Dimension].[Date] ( [DateID] ),
    CONSTRAINT [FK_Fact_Order_Shipped_Date_ID_Dimension_Date] FOREIGN KEY ( [ShippedDateID] ) REFERENCES [Dimension].[Date] ( [DateID] )
)
