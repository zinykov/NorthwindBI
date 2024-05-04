CREATE PROCEDURE [Landing].[CheckChangedHolidays]
	@AreThereAnyChangesInHolidays AS BIT OUTPUT
AS BEGIN
	--BEGIN TRY
	--	BEGIN TRANSACTION
			ALTER TABLE [Landing].[Holidays] ADD CONSTRAINT [PK_Landing_Holidays]
				PRIMARY KEY CLUSTERED ( [Date] ASC );

				UPDATE [Landing].[Holidays]
				SET [HashDiff] = CAST (
									 HASHBYTES ( 
										  N'MD5'
										, CONCAT (
											  ISNULL ( [DateType], N'' ), N'#'
											, ISNULL ( [HolidayName], N'' )
										)
									)
									AS VARBINARY(100)
								);

				SET @AreThereAnyChangesInHolidays = ( SELECT COUNT(*) FROM [Landing].[ChangedHolidays] )
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END