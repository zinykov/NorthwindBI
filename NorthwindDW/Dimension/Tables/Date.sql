CREATE TABLE [Dimension].[Date]
(
	--Day
    [DateKey]               INT             NOT NULL,
    [AlterDateKey]          DATE            NOT NULL,
    [DayOfMonth]            TINYINT         NOT NULL,
    [DayOfWeek]             NVARCHAR(5)     NOT NULL,
    [DayOfWeekNumber]       TINYINT         NOT NULL,
    [DayOfQuarterNumber]    TINYINT         NOT NULL,
    [DayOfYearNumber]       SMALLINT        NOT NULL,
    --Year
    [Year]                  SMALLINT        NOT NULL,
    [StartOfYear]           DATE            NOT NULL,
    [EndOfYear]             DATE            NOT NULL,
    --Quarter
    [Quarter]               NVARCHAR(5)     NOT NULL,
    [YearQuarter]           NVARCHAR(10)    NOT NULL,
    [YearQuarterNumber]     INT             NOT NULL,
    [StartOfQuarter]        DATE            NOT NULL,
    [EndOfQuarter]          DATE            NOT NULL,
    --Month
    [Month]                 NVARCHAR(10)    NOT NULL,
    [Mon]                   NVARCHAR(5)     NOT NULL,
    [MonthNumber]           TINYINT         NOT NULL,
    [YearMonth]             NVARCHAR(10)    NOT NULL,
    [StartOfMonth]          DATE            NOT NULL,
    [EndOfMonth]            DATE            NOT NULL,
    --Week
    [Week]                  NVARCHAR(50)    NOT NULL,
    [WeekNumber]            TINYINT         NOT NULL,
    [StartOfWeek]           DATE            NOT NULL,
    [EndOfWeek]             DATE            NOT NULL,
    --Holiday
    [Holiday]               NVARCHAR(50)    NULL,
    [WorkDayType]           NVARCHAR(25)    NULL,--NOT NULL,
    [WorkDayHours]          TINYINT         NULL--NOT NULL

    CONSTRAINT [PK_Dimension_Date] PRIMARY KEY CLUSTERED ( [DateKey] ASC )
)
    ON [Dimention_Data]
    WITH ( DATA_COMPRESSION = PAGE ) ;
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Alter_Date_Key] ON [Dimension].[Date] ( [AlterDateKey] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Standart_Hierarchy] ON [Dimension].[Date] ( [Year] ASC, [YearQuarterNumber] ASC, [YearQuarter] ASC, [StartOfMonth] ASC, [YearMonth] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO

CREATE NONCLUSTERED INDEX [IX_Dimension_Date_Standart_Hierarchy2] ON [Dimension].[Date] ( [Year] ASC, [Quarter] ASC, [MonthNumber] ASC, [Month] ASC )
    WITH ( DATA_COMPRESSION = PAGE )
    ON [Dimention_Index];
GO