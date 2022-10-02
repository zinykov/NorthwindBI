CREATE PROCEDURE [Integration].[UpdateEmployeeChangingAttributes]
	  @EmployeeAlterKey AS INT
	, @LineageKey AS INT
	, @Name AS NVARCHAR(30)
	, @TitleOfCourtesy AS NVARCHAR(10)
	, @EndDate AS DATE
AS BEGIN
	UPDATE [Dimension].[Employee]
	SET [Name] = @Name, [TitleOfCourtesy] = @TitleOfCourtesy, [LineageKey] = @LineageKey
	WHERE	[EmployeeAlterKey] = @EmployeeAlterKey
END