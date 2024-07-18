CREATE TABLE [Hash].[Order Details]
(
    [OrderID]           INT             NOT NULL,
    [ProductID]         INT             NOT NULL,
    [HashDiff]          VARBINARY(64)   NOT NULL
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO