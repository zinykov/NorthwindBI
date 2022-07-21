CREATE PROCEDURE [Integration].[AddUnknownDate] AS
BEGIN
	IF NOT EXISTS ( SELECT * FROM [Dimension].[Date] WHERE [DateKey] = 19960101 )
	INSERT [Dimension].[Date] (
			  [DateKey]
		    , [AlterDateKey]
		    , [Year]
		    , [YearQuarterNumber]
		    , [YearQuarter]
		    , [Quarter]
		    , [YearMonth]
		    , [YearMonthNumber]
		    , [Month]
		    , [MonthNumber]
			, [DayOfMonth]
		    , [DayOfWeekNumber]
		    , [DayOfWeek]
			, [WeekNumber]
	) SELECT	  [DateKey]
				, [AlterDateKey]
				, [Year]
				, [YearQuarterNumber]
				, [YearQuarter]
				, [Quarter]
				, [YearMonth]
				, [YearMonthNumber]
				, [Month]
				, [MonthNumber]
				, [DayOfMonth]
				, [DayOfWeekNumber]
				, [DayOfWeek]
				, [WeekNumber]
	FROM		[Integration].[GenerateDateDimensionColumns] ( DATEFROMPARTS ( 1996, 1, 1 ) )
END