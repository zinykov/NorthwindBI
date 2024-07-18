CREATE PROCEDURE [Landing].[DropPrimaryKeyProducts] AS
BEGIN
	DROP INDEX IF EXISTS [IX_Landing_Products_HashDiff] ON [Landing].[Products]
	ALTER TABLE [Landing].[Products] DROP CONSTRAINT IF EXISTS [PK_Landing_Products]
END