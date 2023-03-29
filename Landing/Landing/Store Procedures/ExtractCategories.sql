CREATE PROCEDURE [Landing].[ExtractCategories] AS
BEGIN
	UPDATE [Landing].[Categories]
	SET [CheckSum] = CHECKSUM ( [CategoryName] );

	SELECT		  LC.[CategoryID]
				, LC.[CategoryName]
	FROM		[Landing].[Categories] AS LC
	LEFT JOIN	[Hash].[Categories] AS HC ON LC.[CategoryID] = HC.[CategoryID]
	WHERE		LC.[CheckSum] <> HC.[CheckSum]
				OR HC.[CategoryID] IS NULL;
	
	TRUNCATE TABLE [Hash].[Categories];

	INSERT INTO [Hash].[Categories]
	SELECT		  LC.[CategoryID]
				, LC.[CheckSum]
	FROM		[Landing].[Categories] AS LC;
END