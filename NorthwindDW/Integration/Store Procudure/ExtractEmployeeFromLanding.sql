CREATE PROCEDURE [Integration].[ExtractEmployeeFromLanding] AS
BEGIN
	INSERT INTO	  [Staging].[Employee]
	SELECT		  [EmployeeAlterKey]	=	E.[EmployeeID]
				, [Name]				=	CONCAT ( E.[FirstName], ' ', E.[LastName] )
				, [Title]				=	E.[Title]
				, [TitleOfCourtesy]		=	E.[TitleOfCourtesy]
				, [City]				=	E.[City]
				, [Country]				=	E.[Country]

	FROM		[Landing].[Employees] AS E
END;
GO