CREATE FUNCTION [Integration].[GenerateDateDimensionColumns] ( @Date DATE )
RETURNS @returntable TABLE
(
	--Day
    [DateKey]               DATE            NOT NULL,
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
    [IOSWeekNumber]         TINYINT         NOT NULL,
    [StartOfWeek]           DATE            NOT NULL,
    [EndOfWeek]             DATE            NOT NULL,
    --Holiday
    [Holiday]               NVARCHAR(100)   NULL,
    [WorkDayType]           NVARCHAR(25)    NULL,--NOT NULL,
    [WorkDayHours]          TINYINT         NULL--NOT NULL
)
AS BEGIN
    DECLARE @YearNumber AS SMALLINT         = YEAR ( @Date )
    DECLARE @QuarterNumber AS TINYINT       = DATEPART ( QQ, @Date )
    DECLARE @MonthNumber AS TINYINT         = MONTH ( @Date )
    DECLARE @DayNumber AS TINYINT           = DATEPART ( DD, @Date )
    DECLARE @StartOfYear AS DATE            = DATEFROMPARTS ( @YearNumber, 1, 1 )
    DECLARE @StartOfQuarter AS DATE         = DATEFROMPARTS ( @YearNumber, @QuarterNumber * 3 - 2, 1 )
    DECLARE @DayOfWeekNumber AS TINYINT     = DATEPART ( DW , @Date )
    DECLARE @StartOfWeek AS DATE            = DATEADD ( DAY, - @DayOfWeekNumber + 1, @Date )
    DECLARE @EndOfWeek AS DATE              = DATEADD ( DAY, 6, @StartOfWeek )
    DECLARE @Holiday AS NVARCHAR(100)       = ( SELECT TOP(1) CASE WHEN [Holiday] = N'' THEN NULL ELSE [Holiday] END FROM [Integration].[Holiday] WHERE [Date] = @Date )
    DECLARE @WorkDayType AS NVARCHAR(25)    = ( SELECT TOP(1) [WorkDayType] FROM [Integration].[Holiday] WHERE [Date] = @Date )
    DECLARE @WorkDayHours AS TINYINT        = ( SELECT TOP(1) [WorkDayHours] FROM [Integration].[Holiday] WHERE [Date] = @Date )

	INSERT @returntable
	        --Day
    SELECT    [DateKey]             = @Date
            , [DayOfMonth]          = @DayNumber
            , [DayOfWeek]           = FORMAT ( @Date, 'ddd' )
            , [DayOfWeekNumber]     = @DayOfWeekNumber
            , [DayOfQuarterNumber]  = DATEDIFF ( DAY, @StartOfQuarter, @Date ) + 1
            , [DayOfYearNumber]     = DATEDIFF ( DAY, @StartOfYear, @Date ) + 1
            --Year
            , [Year]                = @YearNumber
            , [StartOfYear]         = @StartOfYear
            , [EndOfYear]           = DATEFROMPARTS ( @YearNumber, 12, 31 )
            --Quarter
            , [Quarter]             = CONCAT ( 'Q', @QuarterNumber )
            , [YearQuarter]         = CONCAT ( 'Q', @QuarterNumber, ' - ', @YearNumber )
            , [YearQuarterNumber]   = @YearNumber * 4 + @QuarterNumber - 1
            , [StartOfQuarter]      = @StartOfQuarter
            , [EndOfQuarter]        = EOMONTH ( @StartOfQuarter, 2 )
            --Month
            , [Month]               = DATENAME ( MONTH, @Date )
            , [Mon]                 = SUBSTRING ( DATENAME ( MONTH, @Date ), 1, 3 )
            , [MonthNumber]         = @MonthNumber
            , [YearMonth]           = CONCAT ( SUBSTRING ( DATENAME ( MONTH, @Date ), 1, 3 ), ' - ', @YearNumber )
            , [StartOfMonth]        = DATEFROMPARTS ( @YearNumber, @MonthNumber, 1 )
            , [EndOfMonth]          = EOMONTH ( @Date, 0 )
            --Week
            , [Week]                = CONCAT ( FORMAT ( @StartOfWeek, 'dd.MM.yyyy' ), ' - ',  FORMAT ( @EndOfWeek, 'dd.MM.yyyy' ) )
            , [IOSWeekNumber]       = DATEPART ( ISOWK, @Date )
            , [StartOfWeek]         = @StartOfWeek
            , [EndOfWeek]           = @EndOfWeek
            --Holiday
            , [Holiday]             = @Holiday
            , [WorkDayType]         = CASE
                                        WHEN @WorkDayType IS NULL AND @DayOfWeekNumber > 5 THEN N'Выходной'
                                        WHEN @WorkDayType IS NULL AND @DayOfWeekNumber <= 5 THEN N'Рабочий'
                                        ELSE @WorkDayType
                                      END
            , [WorkDayHours]        = CASE
                                        WHEN @WorkDayHours IS NULL AND @DayOfWeekNumber > 5 THEN 0
                                        WHEN @WorkDayHours IS NULL AND @DayOfWeekNumber <= 5 THEN 8
                                        ELSE @WorkDayHours
                                      END
	RETURN
END;