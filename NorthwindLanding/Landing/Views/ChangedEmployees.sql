CREATE VIEW [Landing].[ChangedEmployees] AS
	SELECT		  LE.[EmployeeID]
				, LE.[LastName]
				, LE.[FirstName]
				, LE.[Title]
				, LE.[TitleOfCourtesy]
				, LE.[City]
				, LE.[Country]
	FROM		[Landing].[Employees] AS LE
	LEFT JOIN	[Hash].[Employees] AS HE ON LE.[EmployeeID] = HE.[EmployeeID]
	WHERE		LE.[HashDiff] <> HE.[HashDiff]
				OR HE.[EmployeeID] IS NULL;