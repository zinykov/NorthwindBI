CREATE PROCEDURE [Hash].[UpdateHashOrders]
	@CutoffTime AS DATE
AS BEGIN
	TRUNCATE TABLE [Hash].[Order Details];
	TRUNCATE TABLE [Hash].[Orders];

	INSERT INTO [Hash].[Orders]
	SELECT		  [OrderID]
				, [HashDiff]
	FROM		[Landing].[Orders]

	INSERT INTO [Hash].[Order Details]
	SELECT		  [OrderID]
				, [ProductID]
				, [HashDiff]
	FROM		[Landing].[Order Details]
END