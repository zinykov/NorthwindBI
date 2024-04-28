CREATE VIEW [Landing].[ChangedHolidays] AS
	SELECT		  LH.[Date]
				, LH.[DateType]
				, LH.[HolidayName]
	FROM		[Landing].[Holidays] AS LH
	LEFT JOIN	[Hash].[Holidays] AS HH ON LH.[Date] = HH.[Date]
	WHERE		LH.[HashDiff] <> HH.[HashDiff]
				OR HH.[Date] IS NULL;
GO