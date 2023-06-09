﻿CREATE TABLE [Landing].[Holidays]
(
	[Date]			DATE			NOT NULL,
	[DateType]		TINYINT			NOT NULL,
	[HolidayName]	NVARCHAR(255)	NULL,
    [CheckSum]      INT             NULL
)
    ON [Landing_FG]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO