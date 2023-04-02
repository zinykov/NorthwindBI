CREATE TABLE [Hash].[Customers]
(
    [CustomerID]        NCHAR(5)        NOT NULL,
    [CheckSum]          INT             NOT NULL,

    CONSTRAINT [PK_Hash_Customers] PRIMARY KEY CLUSTERED ( [CustomerID] ASC )
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO