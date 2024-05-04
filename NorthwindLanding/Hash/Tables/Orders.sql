CREATE TABLE [Hash].[Orders]
(
    [OrderID]      INT           NOT NULL,
    [CheckSum]     INT           NOT NULL,

    CONSTRAINT [PK_Hash_Orders] PRIMARY KEY CLUSTERED ( [OrderID] ASC )
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO