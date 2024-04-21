CREATE PROCEDURE [Landing].[CheckChangedCategories]
	@AreThereAnyChangesInCategories AS BIT OUTPUT
AS BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			ALTER TABLE [Landing].[Categories] ADD CONSTRAINT [PK_Landing_Categories]
				PRIMARY KEY CLUSTERED ( [CategoryID] ASC );

				UPDATE [Landing].[Categories]
				SET [HashDiff] =  HASHBYTES ( 
									  N'MD5'
									, ISNULL ( [CategoryName], N'' )
								);

				SET @AreThereAnyChangesInCategories = ( SELECT COUNT(*) FROM [Landing].[ChangedCategories] )
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END