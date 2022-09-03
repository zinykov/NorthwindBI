CREATE PROCEDURE [Integration].[ExtractEmployeeFromLanding] AS
BEGIN
	SELECT		  [EmployeeAlterKey]
				, [Name]
				, [Title]
				, [TitleOfCourtesy]
				, [City]
				, [Country]

	FROM		[Landing].[EmployeeV]
END;
GO