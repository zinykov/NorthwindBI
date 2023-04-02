CREATE PROCEDURE [Hash].[UpdateHashOrders]
	@CutoffTime AS DATE
AS BEGIN
	TRUNCATE TABLE [Hash].[Order Details];
	TRUNCATE TABLE [Hash].[Orders];

	INSERT INTO [Hash].[Orders]
	SELECT		  [OrderID]
				, [CheckSum]
	FROM		[Landing].[Orders]
	WHERE		[ShippedDate] <= @CutoffTime;

	INSERT INTO [Hash].[Order Details]
	SELECT		  [OrderID]
				, [ProductID]
				, [CheckSum]
	FROM		[Landing].[Order Details]
	WHERE		[OrderID] IN ( SELECT [OrderID] FROM [Hash].[Orders] );

	ALTER TABLE [Landing].[Order Details] DROP CONSTRAINT [PK_Landing_Order_Details];
	ALTER TABLE [Landing].[Orders] DROP CONSTRAINT [PK_Landing_Orders];
END