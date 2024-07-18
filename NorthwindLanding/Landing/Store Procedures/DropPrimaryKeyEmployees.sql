CREATE PROCEDURE [Landing].[DropPrimaryKeyEmployees] AS
BEGIN
	DROP INDEX IF EXISTS [IX_Landing_Employees_HashDiff] ON [Landing].[Employees]
	ALTER TABLE [Landing].[Employees] DROP CONSTRAINT IF EXISTS [PK_Landing_Employees]
END