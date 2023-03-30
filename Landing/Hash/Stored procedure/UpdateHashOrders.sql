CREATE PROCEDURE [Hash].[UpdateHashOrders] AS
BEGIN
	TRUNCATE TABLE [Hash].[Orders];

	INSERT INTO [Hash].[Orders]
	SELECT		  [OrderID]
				, [CheckSum]
	FROM		[Landing].[Orders];
	
	ALTER TABLE [Landing].[Orders] DROP CONSTRAINT [PK_Landing_Orders];
END