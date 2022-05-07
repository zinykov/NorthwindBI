CREATE FUNCTION [Integration].[GenerateDateDimensionColumns] ( @Date DATE )
RETURNS @returntable TABLE
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
    [DayOfWeekNumber]       TINYINT         NOT NULL,
    [DayOfWeek]             NVARCHAR(5)     NOT NULL
)
AS BEGIN
    DECLARE @YearNumber SMALLINT            =   YEAR ( @Date )
    DECLARE @QuarterNumber TINYINT          =   DATEPART ( qq, @Date )
    DECLARE @MonthNumber TINYINT            =   MONTH ( @Date )
    DECLARE @WeekDayNumber TINYINT          =   DATEPART ( dw , @Date ) - CASE WHEN @@DATEFIRST = 7 THEN 1 ELSE 0 END
    DECLARE @DayNumber TINYINT              =   DATEPART ( dd, @Date )

	INSERT @returntable
	SELECT    [DateKey]             =   @YearNumber * 10000 + @MonthNumber * 100 + @DayNumber
            , [AlterDateKey]        =   @Date
            , [Year]                =   @YearNumber
            , [YearQuarterNumber]   =   @YearNumber * 4 + @QuarterNumber - 1
            , [YearQuarter]         =   CONCAT ( 'Q', @QuarterNumber, ' - ', @YearNumber )
            , [Quarter]             =   CONCAT ( 'Q', @QuarterNumber )
            , [YearMonth]           =   CONCAT ( SUBSTRING ( DATENAME ( MONTH, @Date ), 1, 3 ), ' - ', @YearNumber )
            , [YearMonthNumber]     =   @YearNumber * 12 + @MonthNumber - 1
            , [Month]               =   SUBSTRING ( DATENAME ( MONTH, @Date ), 1, 3 )
            , [MonthNumber]         =   @MonthNumber
            , [DayOfWeekNumber]     =   @WeekDayNumber
            , [DayOfWeek]           =   FORMAT ( @Date, 'dd', 'ru-ru' )
	RETURN
END;