CREATE VIEW [Reports].[DimEmployee] AS
	SELECT		  [EmployeeKey]
				, [EmployeeAlterKey]
				, [Employee]
				, [Title]
				, [TitleOfCourtesy]
				, [City]
				, [Country]
				, [StartDate]
				, [EndDate]
				, [Current]
	
	FROM [Dimension].[Employee]