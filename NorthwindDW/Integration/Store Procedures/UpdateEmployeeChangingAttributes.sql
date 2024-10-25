CREATE PROCEDURE [Integration].[UpdateEmployeeChangingAttributes]
	  @EmployeeAlterKey AS INT
	, @LineageKey AS INT
	, @Employee AS NVARCHAR(30)
	, @Title AS NVARCHAR(30)
	, @AllAttributies AS NVARCHAR(MAX)
	, @TitleOfCourtesy AS NVARCHAR(10)
	, @EndDate AS DATE
AS BEGIN
	UPDATE	[Dimension].[Employee]
	SET		  [Employee] = @Employee
			, [Title] = @Title
			, [TitleOfCourtesy] = @TitleOfCourtesy
			, [AllAttributies] = @AllAttributies
			, [LineageKey] = @LineageKey
	WHERE	[EmployeeAlterKey] = @EmployeeAlterKey;
END