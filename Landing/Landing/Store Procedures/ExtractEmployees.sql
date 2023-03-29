CREATE PROCEDURE [Landing].[ExtractEmployees] AS
BEGIN
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
	
	TRUNCATE TABLE [Hash].[Employees];

	INSERT INTO [Hash].[Employees]
	SELECT		  LE.[EmployeeID]
				, LE.[CheckSum]
	FROM		[Landing].[Employees] AS LE;
END