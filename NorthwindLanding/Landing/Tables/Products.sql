CREATE TABLE [Landing].[Products]
(
    [ProductID]   INT           NOT NULL,
    [ProductName] NVARCHAR(40)  NOT NULL,
    [SupplierID]  INT           NULL,
    [CategoryID]  INT           NULL,
    [UnitPrice]   MONEY         NULL,
    [HashDiff]    VARBINARY(64) NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO