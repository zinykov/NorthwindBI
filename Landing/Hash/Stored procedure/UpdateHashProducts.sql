CREATE PROCEDURE [Hash].[UpdateHashProducts] AS
BEGIN
	TRUNCATE TABLE [Hash].[Products];

	INSERT INTO [Hash].[Products]
	SELECT		  [ProductID]
				, [CheckSum]
	FROM		[Landing].[Products];
	
	ALTER TABLE [Landing].[Products] DROP CONSTRAINT [PK_Landing_Products];
END