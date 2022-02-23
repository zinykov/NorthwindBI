/*
    Source for Date dimension columns is https://www.daxpatterns.com/standard-time-related-calculations/
*/
CREATE TABLE [Dimension].[Date]
(
	[DateID]            INT             NOT NULL, -- YYYYMMDD
    [AlterDateID]       DATE            NOT NULL, 
    [Year]              DATE            NOT NULL, -- End/Start Of Year date
    [YearQuarter]       NVARCHAR(10)    NOT NULL, -- QQ-YYYY
    [YearQuarterDate]   DATE            NOT NULL, --End/Start of Quarter date
    [Quarter]           NVARCHAR(5)     NOT NULL, -- QQ
    [YearMonth]         DATE            NOT NULL, -- End/Start of Month Date
    [Month]             DATE            NOT NULL, -- 1900, Month, 1
    [DayOfWeek]         DATE            NOT NULL, --1990, 1, Day

    CONSTRAINT [PK_Dimension_Date] PRIMARY KEY CLUSTERED ( [DateID] ASC )
)
