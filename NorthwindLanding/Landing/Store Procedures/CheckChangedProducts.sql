CREATE PROCEDURE [Landing].[CheckChangedProducts]
	@AreThereAnyChangesInProducts AS BIT OUTPUT
AS BEGIN
	ALTER TABLE [Landing].[Products] ADD CONSTRAINT [PK_Landing_Products] PRIMARY KEY CLUSTERED ( [ProductID] ASC );

	UPDATE [Landing].[Products]
	SET [HashDiff] = CAST (
							HASHBYTES ( 
								  N'SHA2_512'
								, CONCAT (
									  ISNULL ( [ProductName], N'' ), N'#'
									, ISNULL ( [CategoryID], 0 )
							)
						)
						AS VARBINARY(64)
					);

	SET @AreThereAnyChangesInProducts = ( SELECT COUNT(*) FROM [Landing].[ChangedProducts] )
END