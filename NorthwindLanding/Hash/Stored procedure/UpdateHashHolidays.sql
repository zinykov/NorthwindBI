CREATE PROCEDURE [Hash].[UpdateHashHolidays]
AS BEGIN
	DROP INDEX IF EXISTS [IX_Hash_Holidays_HashDiff] ON [Hash].[Holidays]
	ALTER TABLE [Hash].[Holidays] DROP CONSTRAINT IF EXISTS [PK_Hash_Holidays]

	TRUNCATE TABLE [Hash].[Holidays]

	INSERT INTO [Hash].[Holidays]
	SELECT		  [Date]
				, [HashDiff]
	FROM		[Landing].[Holidays]

	ALTER TABLE [Hash].[Holidays] ADD CONSTRAINT [PK_Hash_Holidays] PRIMARY KEY CLUSTERED ( [Date] ASC )
	CREATE INDEX [IX_Hash_Holidays_HashDiff] ON [Hash].[Holidays] ( [HashDiff] ASC )
END