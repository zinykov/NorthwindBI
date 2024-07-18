CREATE PROCEDURE [Hash].[UpdateHashEmployees]
AS BEGIN
	DROP INDEX IF EXISTS [IX_Hash_Employees_HashDiff] ON [Hash].[Employees]
	ALTER TABLE [Hash].[Employees] DROP CONSTRAINT IF EXISTS [PK_Hash_Employees]

	TRUNCATE TABLE [Hash].[Employees]

	INSERT INTO [Hash].[Employees]
	SELECT		  [EmployeeID]
				, [HashDiff]
	FROM		[Landing].[Employees]

	ALTER TABLE [Hash].[Employees] ADD CONSTRAINT [PK_Hash_Employees] PRIMARY KEY CLUSTERED ( [EmployeeID] ASC )
	CREATE INDEX [IX_Hash_Employees_HashDiff] ON [Hash].[Employees] ( [HashDiff] ASC )
END