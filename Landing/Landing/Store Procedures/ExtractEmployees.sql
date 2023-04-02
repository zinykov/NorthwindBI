CREATE PROCEDURE [Landing].[ExtractEmployees] AS
BEGIN
	ALTER TABLE [Landing].[Employees] ADD CONSTRAINT [PK_Landing_Employees]
		PRIMARY KEY CLUSTERED ( [EmployeeID] ASC );

	UPDATE [Landing].[Employees]
	SET [CheckSum] = CHECKSUM (
		  [LastName]
		, [FirstName]
		, [Title]
		, [TitleOfCourtesy]
		, [City]
		, [Country]
	);

	SELECT		  LE.[EmployeeID]
				, LE.[LastName]
				, LE.[FirstName]
				, LE.[Title]
				, LE.[TitleOfCourtesy]
				, LE.[City]
				, LE.[Country]
	FROM		[Landing].[Employees] AS LE
	LEFT JOIN	[Hash].[Employees] AS HE ON LE.[EmployeeID] = HE.[EmployeeID]
	WHERE		LE.[CheckSum] <> HE.[CheckSum]
				OR HE.[EmployeeID] IS NULL;
END