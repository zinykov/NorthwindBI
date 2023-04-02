CREATE TABLE [Hash].[Products]
(
    [ProductID]   INT           NOT NULL,
    [CheckSum]    INT           NOT NULL,

    CONSTRAINT [PK_Hash_Products] PRIMARY KEY CLUSTERED ( [ProductID] ASC )
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO