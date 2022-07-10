CREATE PROCEDURE [Integration].[AddUnknownDate] AS
BEGIN
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
		    , [DayOfWeekNumber]
		    , [DayOfWeek]
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
				, [DayOfWeekNumber]
				, [DayOfWeek]
	FROM		[Integration].[GenerateDateDimensionColumns] ( DATEFROMPARTS ( 3999, 12, 31 ) )
END