CREATE PROCEDURE [Hash].[UpdateHashCustomers]
AS BEGIN
	DROP INDEX IF EXISTS [IX_Hash_Customers_HashDiff] ON [Hash].[Customers]
	ALTER TABLE [Hash].[Customers] DROP CONSTRAINT IF EXISTS [PK_Hash_Customers]

	TRUNCATE TABLE [Hash].[Customers]

	INSERT INTO [Hash].[Customers]
	SELECT		  [CustomerID]
				, [HashDiff]
	FROM		[Landing].[Customers]

	ALTER TABLE [Hash].[Customers] ADD CONSTRAINT [PK_Hash_Customers] PRIMARY KEY CLUSTERED ( [CustomerID] ASC )
	CREATE INDEX [IX_Hash_Customers_HashDiff] ON [Hash].[Customers] ( [HashDiff] ASC )
END