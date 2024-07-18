CREATE PROCEDURE [Hash].[UpdateHashProducts]
AS BEGIN
	DROP INDEX IF EXISTS [IX_Hash_Products_HashDiff] ON [Hash].[Products]
	ALTER TABLE [Hash].[Products] DROP CONSTRAINT IF EXISTS [PK_Hash_Products]

	TRUNCATE TABLE [Hash].[Products]

	INSERT INTO [Hash].[Products]
	SELECT		  [ProductID]
				, [HashDiff]
	FROM		[Landing].[Products]

	ALTER TABLE [Hash].[Products] ADD CONSTRAINT [PK_Hash_Products] PRIMARY KEY CLUSTERED ( [ProductID] ASC )
	CREATE INDEX [IX_Hash_Products_HashDiff] ON [Hash].[Products] ( [HashDiff] ASC )
END