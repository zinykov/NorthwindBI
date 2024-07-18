CREATE PROCEDURE [Landing].[CheckChangedCategories]
	@AreThereAnyChangesInCategories AS BIT OUTPUT
AS BEGIN
	ALTER TABLE [Landing].[Categories] ADD CONSTRAINT [PK_Landing_Categories]
		PRIMARY KEY CLUSTERED ( [CategoryID] ASC )

	UPDATE [Landing].[Categories]
	SET [HashDiff] = CAST (
						HASHBYTES ( 
							  N'SHA2_512'
							, ISNULL ( [CategoryName], N'' )
						)
						AS VARBINARY(64)
					)
	
	CREATE INDEX [IX_Landing_Categories_HashDiff] ON [Landing].[Categories] ( [HashDiff] ASC )

	SET @AreThereAnyChangesInCategories = ( SELECT COUNT(*) FROM [Landing].[ChangedCategories] )
END