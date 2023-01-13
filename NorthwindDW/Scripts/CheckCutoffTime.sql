:setvar Cutofftime '1998-01-31'

SELECT	[AlterDateKey]
FROM	[Dimension].[Date]
WHERE	[DayOfWeekNumber] = 6
		AND [DayOfMonth] BETWEEN 2 AND 8
		AND [MonthNumber] = 1
        AND [Year] = YEAR ( $(Cutofftime) )