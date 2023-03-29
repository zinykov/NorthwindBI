CREATE PROCEDURE [Landing].[ExtractHolidays] AS
BEGIN
	UPDATE [Landing].[Holidays]
	SET [CheckSum] = CHECKSUM (
		  [Date]
		, [DateType]
		, [HolidayName]
	);

	SELECT		  LH.[Date]
				, LH.[DateType]
				, LH.[HolidayName]
	FROM		[Landing].[Holidays] AS LH
	LEFT JOIN	[Hash].[Holidays] AS HH ON LH.[Date] = HH.[Date]
	WHERE		LH.[CheckSum] <> HH.[CheckSum]
				OR HH.[Date] IS NULL;
	
	TRUNCATE TABLE [Hash].[Holidays];

	INSERT INTO [Hash].[Holidays]
	SELECT		  LH.[Date]
				, LH.[CheckSum]
	FROM		[Landing].[Holidays] AS LH;
END