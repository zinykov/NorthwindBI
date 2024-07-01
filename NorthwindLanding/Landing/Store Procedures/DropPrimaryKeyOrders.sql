CREATE PROCEDURE [Landing].[DropPrimaryKeyOrders]
AS BEGIN
	ALTER TABLE [Landing].[Orders] DROP CONSTRAINT [PK_Landing_Orders]
	ALTER TABLE [Landing].[Order Details] DROP CONSTRAINT [PK_Landing_Order_Details]
END