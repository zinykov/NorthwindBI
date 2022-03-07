CREATE FUNCTION [Integration].[GenerateDateDimensionColumns] ( @Date DATE )
RETURNS @returntable TABLE
(
	[DateKey]           INT             NOT NULL, -- YYYYMMDD
    [AlterDateKey]      DATE            NOT NULL, 
    [Year]              DATE            NOT NULL, -- End/Start Of Year date
    [YearQuarter]       NVARCHAR(10)    NOT NULL, -- QQ-YYYY
    [YearQuarterDate]   DATE            NOT NULL, -- End/Start of Quarter date
    [Quarter]           NVARCHAR(5)     NOT NULL, -- QQ
    [YearMonth]         DATE            NOT NULL, -- End/Start of Month Date
    [Month]             DATE            NOT NULL, -- 1900, Month, 1
    [DayOfWeek]         DATE            NOT NULL  -- 1990, 1, Day
)
AS BEGIN
    DECLARE @year SMALLINT          =   YEAR ( @Date )
    DECLARE @month TINYINT          =   MONTH ( @Date )
    DECLARE @quarter TINYINT        =   DATEPART ( qq, @Date )
    DECLARE @weekday TINYINT        =   DATEPART ( dw , @Date ) - CASE WHEN @@DATEFIRST = 7 THEN 1 ELSE 0 END
    DECLARE @day TINYINT            =   DAY ( @Date )

	INSERT @returntable
	SELECT    [DateKey]             =   @year * 10000 + @month * 100 + @day
            , [AlterDateKey]        =   @Date
            , [Year]                =   DATEFROMPARTS ( @year, 12, 31 )
            , [YearQuarter]         =   CONCAT ( 'Q', @quarter, '-', @year )
            , [YearQuarterDate]     =   EOMONTH ( DATEFROMPARTS ( @year, @quarter * 3, 1 ) )
            , [Quarter]             =   CONCAT ( 'Q', @quarter )
            , [YearMonth]           =   EOMONTH ( @Date )
            , [Month]               =   DATEFROMPARTS ( 1900, @month, 1 )
            , [DayOfWeek]           =   DATEFROMPARTS ( 1900, 1, CASE @weekday WHEN 0 THEN 7 ELSE @weekday END )
	RETURN
END;