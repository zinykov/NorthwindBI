CREATE TABLE [Hash].[Holidays]
(
	[Date]			DATE			NOT NULL,
    [CheckSum]      INT             NOT NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO