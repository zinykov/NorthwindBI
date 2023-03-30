CREATE PROCEDURE [Landing].[ExtractHolidays] AS
BEGIN
	ALTER TABLE [Landing].[Holidays] ADD CONSTRAINT [PK_Landing_Holidays]
		PRIMARY KEY CLUSTERED ( [Date] ASC );

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
END