CREATE PROCEDURE [Hash].[UpdateHashCustomers]
AS BEGIN
	--BEGIN TRY
	--	BEGIN TRANSACTION
			TRUNCATE TABLE [Hash].[Customers];

			INSERT INTO [Hash].[Customers]
			SELECT		  [CustomerID]
						, [HashDiff]
			FROM		[Landing].[Customers];
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END