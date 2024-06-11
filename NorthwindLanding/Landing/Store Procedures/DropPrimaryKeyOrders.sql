CREATE PROCEDURE [Landing].[DropPrimaryKeyOrders]
AS BEGIN
	DROP INDEX [IX_Landing_Orders_Order_Date] ON [Landing].[Orders]
	ALTER TABLE [Landing].[Orders] DROP CONSTRAINT [PK_Landing_Orders]
	ALTER TABLE [Landing].[Order Details] DROP CONSTRAINT [PK_Landing_Order_Details]
END