CREATE TABLE [Hash].[Customers]
(
    [CustomerID]        NCHAR(5)        NOT NULL,
    [HashDiff]          VARBINARY(100)  NOT NULL,

    CONSTRAINT [PK_Hash_Customers] PRIMARY KEY CLUSTERED ( [CustomerID] ASC )
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO