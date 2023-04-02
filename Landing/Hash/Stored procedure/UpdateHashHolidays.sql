CREATE PROCEDURE [Hash].[UpdateHashHolidays] AS
BEGIN
	TRUNCATE TABLE [Hash].[Holidays];

	INSERT INTO [Hash].[Holidays]
	SELECT		  [Date]
				, [CheckSum]
	FROM		[Landing].[Holidays];
	
	ALTER TABLE [Landing].[Holidays] DROP CONSTRAINT [PK_Landing_Holidays];
END