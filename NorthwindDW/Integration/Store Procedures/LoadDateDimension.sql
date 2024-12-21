CREATE PROCEDURE [Integration].[LoadDateDimension]
	  @StartDate INT
	, @EndDate INT
AS BEGIN
	SET NOCOUNT ON
    SET XACT_ABORT ON
    SET DATEFIRST 1
    	
	DECLARE @DateCounter DATE	=	DATEFROMPARTS (  @StartDate, 1, 1 )

	WHILE @DateCounter <= DATEFROMPARTS ( @EndDate, 12, 31 )
	BEGIN
		IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Date] WHERE [DateKey] = @DateCounter )
		BEGIN
			INSERT [Dimension].[Date] (
				  [DateKey]
                , [DayOfMonth]
                , [DayOfWeek]
                , [DayOfWeekNumber]
                , [DayOfQuarterNumber]
                , [DayOfYearNumber]
                , [Year]
                , [StartOfYear]
                , [EndOfYear]
                , [Quarter]
                , [YearQuarter]
                , [YearQuarterNumber]
                , [StartOfQuarter]
                , [EndOfQuarter]
                , [Month]
                , [Mon]
                , [MonthNumber]
                , [YearMonth]
                , [StartOfMonth]
                , [EndOfMonth]
                , [Week]
                , [ISOWeekNumber]
                , [StartOfWeek]
                , [EndOfWeek]
                , [Holiday]
                , [WorkDayType]
                , [WorkDayHours]
			) SELECT	  [DateKey]
                        , [DayOfMonth]
                        , [DayOfWeek]
                        , [DayOfWeekNumber]
                        , [DayOfQuarterNumber]
                        , [DayOfYearNumber]
                        , [Year]
                        , [StartOfYear]
                        , [EndOfYear]
                        , [Quarter]
                        , [YearQuarter]
                        , [YearQuarterNumber]
                        , [StartOfQuarter]
                        , [EndOfQuarter]
                        , [Month]
                        , [Mon]
                        , [MonthNumber]
                        , [YearMonth]
                        , [StartOfMonth]
                        , [EndOfMonth]
                        , [Week]
                        , [ISOWeekNumber]
                        , [StartOfWeek]
                        , [EndOfWeek]
                        , [Holiday]
                        , [WorkDayType]
                        , [WorkDayHours]
				FROM		[Integration].[GenerateDateDimensionColumns] ( @DateCounter )
		END
		SET @DateCounter = DATEADD ( DAY, 1, @DateCounter )
	END
END