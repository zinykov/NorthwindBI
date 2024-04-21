CREATE TABLE [Hash].[Products]
(
    [ProductID]   INT               NOT NULL,
    [HashDiff]    VARBINARY(MAX)    NULL,

    CONSTRAINT [PK_Hash_Products] PRIMARY KEY CLUSTERED ( [ProductID] ASC )
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO