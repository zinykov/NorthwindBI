CREATE PROCEDURE [Hash].[UpdateHashOrders]
AS BEGIN
	DROP INDEX IF EXISTS [IX_Hash_Orders_HashDiff] ON [Hash].[Orders]
	ALTER TABLE [Hash].[Orders] DROP CONSTRAINT IF EXISTS [PK_Hash_Orders]

	TRUNCATE TABLE [Hash].[Orders]

	INSERT INTO [Hash].[Orders]
	SELECT		  [OrderID]
				, [HashDiff]
	FROM		[Landing].[Orders]

	ALTER TABLE [Hash].[Orders] ADD CONSTRAINT [PK_Hash_Orders] PRIMARY KEY CLUSTERED ( [OrderID] ASC )
	CREATE INDEX [IX_Hash_Orders_HashDiff] ON [Hash].[Orders] ( [HashDiff] ASC )

	
	DROP INDEX IF EXISTS [IX_Hash_Order_Details_HashDiff] ON [Hash].[Order Details]
	ALTER TABLE [Hash].[Order Details] DROP CONSTRAINT IF EXISTS [PK_Hash_Order_Details]

	TRUNCATE TABLE [Hash].[Order Details]

	INSERT INTO [Hash].[Order Details]
	SELECT		  [OrderID]
				, [ProductID]
				, [HashDiff]
	FROM		[Landing].[Order Details]

	ALTER TABLE [Hash].[Order Details] ADD CONSTRAINT [PK_Hash_Order_Details] PRIMARY KEY CLUSTERED ( [OrderID] ASC, [ProductID] ASC )
	CREATE INDEX [IX_Hash_Order_Details_HashDiff] ON [Hash].[Order Details] ( [HashDiff] ASC )
END