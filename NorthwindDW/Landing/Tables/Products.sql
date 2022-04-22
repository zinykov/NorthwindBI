CREATE TABLE [Landing].[Products]
(
    [ProductID]   INT           NOT NULL,
    [ProductName] NVARCHAR (40) NOT NULL,
    [SupplierID]  INT           NULL,
    [CategoryID]  INT           NULL,
    [UnitPrice]   MONEY         NULL
)
    ON [PRIMARY]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO