CREATE TABLE [Hash].[Customers]
(
    [CustomerID]        NCHAR(5)        NOT NULL,
    [HashDiff]          VARBINARY(64)   NOT NULL
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO