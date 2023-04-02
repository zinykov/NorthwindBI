CREATE TABLE [Hash].[Categories]
(
    [CategoryID]        INT             NOT NULL,
    [CheckSum]          INT             NOT NULL,

    CONSTRAINT [PK_Hash_Categories] PRIMARY KEY CLUSTERED ( [CategoryID] ASC )
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO