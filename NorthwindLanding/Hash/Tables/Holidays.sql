CREATE TABLE [Hash].[Holidays]
(
	[Date]			DATE			NOT NULL,
    [HashDiff]      VARBINARY(64)   NOT NULL

    CONSTRAINT [PK_Hash_Holidays] PRIMARY KEY CLUSTERED ( [Date] ASC )
)
    ON [Hash_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO