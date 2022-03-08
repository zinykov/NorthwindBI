CREATE TABLE [dbo].[Orders] (
    [OrderID]      INT           IDENTITY (1, 1) NOT NULL,
    [CustomerID]   NCHAR (5)     NULL,
    [EmployeeID]   INT           NULL,
    [OrderDate]    DATETIME      NULL,
    [RequiredDate] DATETIME      NULL,
    [ShippedDate]  DATETIME      NULL,
    [ShipCity]     NVARCHAR (15) NULL,
    [ShipCountry]  NVARCHAR (15) NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_Orders_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID])
);


GO
CREATE NONCLUSTERED INDEX [CustomerID]
    ON [dbo].[Orders]([CustomerID] ASC);


GO
CREATE NONCLUSTERED INDEX [CustomersOrders]
    ON [dbo].[Orders]([CustomerID] ASC);


GO
CREATE NONCLUSTERED INDEX [EmployeeID]
    ON [dbo].[Orders]([EmployeeID] ASC);


GO
CREATE NONCLUSTERED INDEX [EmployeesOrders]
    ON [dbo].[Orders]([EmployeeID] ASC);


GO
CREATE NONCLUSTERED INDEX [OrderDate]
    ON [dbo].[Orders]([OrderDate] ASC);


GO
CREATE NONCLUSTERED INDEX [ShippedDate]
    ON [dbo].[Orders]([ShippedDate] ASC);

