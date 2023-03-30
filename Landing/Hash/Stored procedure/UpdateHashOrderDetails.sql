CREATE PROCEDURE [Hash].[UpdateHashOrderDetails] AS
BEGIN	
	TRUNCATE TABLE [Hash].[Order Details];

	INSERT INTO [Hash].[Order Details]
	SELECT		  [OrderID]
				, [ProductID]
				, [CheckSum]
	FROM		[Landing].[Order Details];
	
	ALTER TABLE [Landing].[Order Details] DROP CONSTRAINT [PK_Landing_Order_Details];
END