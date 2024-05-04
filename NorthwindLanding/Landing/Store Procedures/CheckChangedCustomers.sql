CREATE PROCEDURE [Landing].[CheckChangedCustomers]
	@AreThereAnyChangesInCustomers AS BIT OUTPUT
AS BEGIN
	--BEGIN TRY
	--	BEGIN TRANSACTION
			ALTER TABLE [Landing].[Customers] ADD CONSTRAINT [PK_Landing_Customers]
				PRIMARY KEY CLUSTERED ( [CustomerID] ASC );

				UPDATE [Landing].[Customers]
				SET [HashDiff] = CAST (
									 HASHBYTES ( 
										  N'MD5'
										, CONCAT (
											  ISNULL ( [CompanyName], N'' ), N'#'
											, ISNULL ( [ContactName], N'' ), N'#'
											, ISNULL ( [ContactTitle], N'' ), N'#'
											, ISNULL ( [City], N'' ), N'#'
											, ISNULL ( [Country], N'' ), N'#'
											, ISNULL ( [Phone], N'' ), N'#'
											, ISNULL ( [Fax], N'' )
										)
									)
									AS VARBINARY(100)
								);

				SET @AreThereAnyChangesInCustomers = ( SELECT COUNT(*) FROM [Landing].[ChangedCustomers] )
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END