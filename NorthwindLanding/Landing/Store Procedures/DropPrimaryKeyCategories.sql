CREATE PROCEDURE [Landing].[DropPrimaryKeyCategories] AS
BEGIN
	DROP INDEX IF EXISTS [IX_Landing_Categories_HashDiff] ON [Landing].[Categories]
	ALTER TABLE [Landing].[Categories] DROP CONSTRAINT IF EXISTS [PK_Landing_Categories]
END