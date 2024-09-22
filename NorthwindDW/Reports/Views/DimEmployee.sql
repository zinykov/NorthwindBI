CREATE VIEW [Reports].[DimEmployee]
	WITH SCHEMABINDING
AS
	SELECT		  [EmployeeKey]
				, [EmployeeAlterKey]
				, [Employee]
				, [Title]
				, [TitleOfCourtesy]
				, [City]
				, [Country]
	
	FROM [Dimension].[Employee]
	WITH (NOLOCK);