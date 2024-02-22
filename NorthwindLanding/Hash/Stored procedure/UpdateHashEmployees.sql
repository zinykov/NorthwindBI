CREATE PROCEDURE [Hash].[UpdateHashEmployees] AS
BEGIN
	TRUNCATE TABLE [Hash].[Employees];

	INSERT INTO [Hash].[Employees]
	SELECT		  [EmployeeID]
				, [CheckSum]
	FROM		[Landing].[Employees];

	ALTER TABLE [Landing].[Employees] DROP CONSTRAINT [PK_Landing_Employees];
END