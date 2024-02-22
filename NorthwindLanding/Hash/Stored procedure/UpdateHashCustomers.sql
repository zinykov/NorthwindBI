CREATE PROCEDURE [Hash].[UpdateHashCustomers] AS
BEGIN
	TRUNCATE TABLE [Hash].[Customers];

	INSERT INTO [Hash].[Customers]
	SELECT		  [CustomerID]
				, [CheckSum]
	FROM		[Landing].[Customers];

	ALTER TABLE [Landing].[Customers] DROP CONSTRAINT [PK_Landing_Customers];
END