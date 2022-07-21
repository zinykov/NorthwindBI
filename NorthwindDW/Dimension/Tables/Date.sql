CREATE TABLE [Dimension].[Date]
(
	[DateKey]               INT             NOT NULL,
    [AlterDateKey]          DATE            NOT NULL,
    [Year]                  INT             NOT NULL,
    [YearQuarterNumber]     INT             NOT NULL,
    [YearQuarter]           NVARCHAR(10)    NOT NULL,
    [Quarter]               NVARCHAR(5)     NOT NULL,
    [YearMonth]             NVARCHAR(10)    NOT NULL,
    [YearMonthNumber]       INT             NOT NULL,
    [Month]                 NVARCHAR(10)    NOT NULL,
    [MonthNumber]           INT             NOT NULL,
    [DayOfMonth]            TINYINT         NOT NULL,
    [DayOfWeekNumber]       TINYINT         NOT NULL,
    [DayOfWeek]             NVARCHAR(5)     NOT NULL,
    [WeekNumber]            TINYINT         NOT NULL

    CONSTRAINT [PK_Dimension_Date] PRIMARY KEY CLUSTERED ( [DateKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Alter_Date_Key] ON [Dimension].[Date] ( [AlterDateKey] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Standart_Hierarchy] ON [Dimension].[Date] ( [Year] ASC, [YearQuarterNumber] ASC, [YearQuarter] ASC, [YearMonthNumber] ASC, [YearMonth] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Standart_Hierarchy2] ON [Dimension].[Date] ( [Year] ASC, [Quarter] ASC, [MonthNumber] ASC, [Month] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Quarter_of_Year] ON [Dimension].[Date] ( [YearQuarterNumber] ASC, [YearQuarter] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Month_of_Year] ON [Dimension].[Date] (  [YearMonthNumber] ASC, [YearMonth] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO