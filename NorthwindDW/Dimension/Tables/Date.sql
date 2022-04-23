/*
    Source for Date dimension columns is https://www.daxpatterns.com/standard-time-related-calculations/
*/
CREATE TABLE [Dimension].[Date]
(
	[DateKey]           INT             NOT NULL, -- YYYYMMDD
    [AlterDateKey]      DATE            NOT NULL, 
    [Year]              DATE            NOT NULL, -- End/Start Of Year date
    [YearQuarter]       NVARCHAR(10)    NOT NULL, -- QQ-YYYY
    [YearQuarterDate]   DATE            NOT NULL, --End/Start of Quarter date
    [Quarter]           NVARCHAR(5)     NOT NULL, -- QQ
    [YearMonth]         DATE            NOT NULL, -- End/Start of Month Date
    [Month]             DATE            NOT NULL, -- 1900, Month, 1
    [DayOfWeek]         DATE            NOT NULL, --1990, 1, Day

    CONSTRAINT [PK_Dimension_Date] PRIMARY KEY CLUSTERED ( [DateKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Alter_Date_Key] ON [Dimension].[Date] ( [AlterDateKey] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Standart_Hierarchy] ON [Dimension].[Date] ( [Year] ASC, [Quarter] ASC, [Month] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Quarter_of_Year] ON [Dimension].[Date] ( [YearQuarterDate] ASC, [YearQuarter] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Month_of_Year] ON [Dimension].[Date] ( [YearMonth] )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO