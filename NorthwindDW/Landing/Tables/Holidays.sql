CREATE TABLE [Landing].[Holidays]
(
	[Date]			NVARCHAR(255)	NOT NULL,
	[DateType]		NVARCHAR(255)	NOT NULL,
	[HolidayName]	NVARCHAR(255)	NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO