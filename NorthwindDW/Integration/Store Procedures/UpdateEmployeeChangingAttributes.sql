CREATE PROCEDURE [Integration].[UpdateEmployeeChangingAttributes]
	  @EmployeeAlterKey AS INT
	, @LineageKey AS INT
	, @Employee AS NVARCHAR(30)
	, @TitleOfCourtesy AS NVARCHAR(10)
	, @EndDate AS DATE
AS BEGIN
    --BEGIN TRY
    --    BEGIN TRANSACTION
			UPDATE [Dimension].[Employee]
			SET [Employee] = @Employee, [TitleOfCourtesy] = @TitleOfCourtesy, [LineageKey] = @LineageKey
			WHERE	[EmployeeAlterKey] = @EmployeeAlterKey;
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END