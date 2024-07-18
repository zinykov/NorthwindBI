CREATE PROCEDURE [Landing].[DropPrimaryKeyHolidays] AS
BEGIN
	DROP INDEX IF EXISTS [IX_Landing_Holidays_HashDiff] ON [Landing].[Holidays]
	ALTER TABLE [Landing].[Holidays] DROP CONSTRAINT IF EXISTS [PK_Landing_Holidays]
END