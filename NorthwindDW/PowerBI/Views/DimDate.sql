CREATE VIEW [PowerBI].[DimDate] AS
	SELECT		  [DateKey]
				, [AlterDateKey]
				, [Year]
				, [YearQuarter]
				, [YearQuarterDate]
				, [Quarter]
				, [YearMonth]
				, [Month]
				, [DayOfWeek]
	
	FROM		[Dimension].[Date]