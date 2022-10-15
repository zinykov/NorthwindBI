CREATE PROCEDURE [Integration].[UpdateEmployeeAttributesAndMetadata]
	  @EmployeeAlterKey AS INT
	, @LineageKey AS INT
	, @Employee AS NVARCHAR(30)
	, @TitleOfCourtesy AS NVARCHAR(10)
	, @EndDate AS DATE
AS BEGIN
	UPDATE [Dimension].[Employee]
	SET [Employee] = @Employee, [TitleOfCourtesy] = @TitleOfCourtesy, [LineageKey] = @LineageKey
	WHERE	[EmployeeAlterKey] = @EmployeeAlterKey

	UPDATE [Dimension].[Employee]
	SET [EndDate] = @EndDate, [Current] = 0, [LineageKey] = @LineageKey
	WHERE	[Current] = 1 AND [EmployeeAlterKey] = @EmployeeAlterKey
END