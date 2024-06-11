CREATE TABLE [Hash].[Categories]
(
    [CategoryID]        INT             NOT NULL,
    [HashDiff]          VARBINARY(64)   NOT NULL,

    CONSTRAINT [PK_Hash_Categories] PRIMARY KEY CLUSTERED ( [CategoryID] ASC )
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO