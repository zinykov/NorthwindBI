CREATE PROCEDURE [Hash].[UpdateHashEmployees]
AS BEGIN
	--BEGIN TRY
	--	BEGIN TRANSACTION
			TRUNCATE TABLE [Hash].[Employees];

			INSERT INTO [Hash].[Employees]
			SELECT		  [EmployeeID]
						, [HashDiff]
			FROM		[Landing].[Employees];
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END