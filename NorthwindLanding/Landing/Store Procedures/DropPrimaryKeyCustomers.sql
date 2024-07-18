CREATE PROCEDURE [Landing].[DropPrimaryKeyCustomers] AS
BEGIN
	DROP INDEX IF EXISTS [IX_Landing_Customers_HashDiff] ON [Landing].[Customers]
	ALTER TABLE [Landing].[Customers] DROP CONSTRAINT IF EXISTS [PK_Landing_Customers]
END