CREATE PROCEDURE [Hash].[UpdateHashCategories] AS
BEGIN	
	TRUNCATE TABLE [Hash].[Categories];

	INSERT INTO [Hash].[Categories]
	SELECT		  [CategoryID]
				, [CheckSum]
	FROM		[Landing].[Categories];
	
	ALTER TABLE [Landing].[Categories] DROP CONSTRAINT [PK_Landing_Categories];
END