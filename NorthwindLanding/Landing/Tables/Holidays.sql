CREATE TABLE [Landing].[Holidays]
(
	[Date]			DATE			NOT NULL,
	[DateType]		TINYINT			NOT NULL,
	[HolidayName]	NVARCHAR(255)	NULL,
    [HashDiff]      VARBINARY(100)  NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO