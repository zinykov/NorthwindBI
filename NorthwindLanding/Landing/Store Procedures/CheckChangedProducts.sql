CREATE PROCEDURE [Landing].[CheckChangedProducts]
	@AreThereAnyChangesInProducts AS BIT OUTPUT
AS BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			ALTER TABLE [Landing].[Products] ADD CONSTRAINT [PK_Landing_Products]
				PRIMARY KEY CLUSTERED ( [ProductID] ASC );

				UPDATE [Landing].[Products]
				SET [HashDiff] = CAST (
									 HASHBYTES ( 
										  N'MD5'
										, CONCAT (
											  ISNULL ( [ProductName], N'' ), N'#'
											, ISNULL ( [CategoryID], 0 )
										)
									)
									AS VARBINARY(100)
								);

				SET @AreThereAnyChangesInProducts = ( SELECT COUNT(*) FROM [Landing].[ChangedProducts] )
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END