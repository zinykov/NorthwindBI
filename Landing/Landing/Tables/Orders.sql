CREATE TABLE [Landing].[Orders]
(
    [OrderID]      INT           NOT NULL,
    [CustomerID]   NCHAR (5)     NULL,
    [EmployeeID]   INT           NULL,
    [OrderDate]    DATETIME      NULL,
    [RequiredDate] DATETIME      NULL,
    [ShippedDate]  DATETIME      NULL,
    [ShipCity]     NVARCHAR (15) NULL,
    [ShipCountry]  NVARCHAR (15) NULL,
    [CheckSum]     INT           NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO