CREATE VIEW [Reports].[DimEmployee] AS
	SELECT		  [EmployeeKey]
				, [EmployeeAlterKey]
				, [Name]
				, [Title]
				, [TitleOfCourtesy]
				, [City]
				, [Country]
				, [StartDate]
				, [EndDate]
				, [Current]
	
	FROM [Dimension].[Employee]