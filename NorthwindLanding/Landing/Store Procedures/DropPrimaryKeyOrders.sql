CREATE PROCEDURE [Landing].[DropPrimaryKeyOrders]
AS BEGIN
	DROP INDEX IF EXISTS [IX_Landing_Orders_HashDiff] ON [Landing].[Orders]
	ALTER TABLE [Landing].[Orders] DROP CONSTRAINT IF EXISTS [PK_Landing_Orders]

	DROP INDEX IF EXISTS [IX_Landing_Order_Details_HashDiff] ON [Landing].[Order Details]
	ALTER TABLE [Landing].[Order Details] DROP CONSTRAINT IF EXISTS [PK_Landing_Order_Details]
END