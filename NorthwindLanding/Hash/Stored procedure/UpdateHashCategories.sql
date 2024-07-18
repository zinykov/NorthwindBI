CREATE PROCEDURE [Hash].[UpdateHashCategories]
AS BEGIN
	DROP INDEX IF EXISTS [IX_Hash_Categories_HashDiff] ON [Hash].[Categories]
	ALTER TABLE [Hash].[Categories] DROP CONSTRAINT IF EXISTS [PK_Hash_Categories]

	TRUNCATE TABLE [Hash].[Categories]

	INSERT INTO [Hash].[Categories]
	SELECT		  [CategoryID]
				, [HashDiff]
	FROM		[Landing].[Categories]

	ALTER TABLE [Hash].[Categories] ADD CONSTRAINT [PK_Hash_Categories] PRIMARY KEY CLUSTERED ( [CategoryID] ASC )
	CREATE INDEX [IX_Hash_Categories_HashDiff] ON [Hash].[Categories] ( [HashDiff] ASC )
END