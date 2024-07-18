CREATE PROCEDURE [Landing].[CheckChangedCustomers]
	@AreThereAnyChangesInCustomers AS BIT OUTPUT
AS BEGIN
	ALTER TABLE [Landing].[Customers] ADD CONSTRAINT [PK_Landing_Customers]
		PRIMARY KEY CLUSTERED ( [CustomerID] ASC )

	UPDATE [Landing].[Customers]
	SET [HashDiff] = CAST (
							HASHBYTES ( 
							  N'SHA2_512'
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
						AS VARBINARY(64)
					)
	
	CREATE INDEX [IX_Landing_Customers_HashDiff] ON [Landing].[Customers] ( [HashDiff] ASC )

	SET @AreThereAnyChangesInCustomers = ( SELECT COUNT(*) FROM [Landing].[ChangedCustomers] )
END