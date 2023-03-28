CREATE PROCEDURE [Landing].[ExtractCategories] AS
BEGIN
	SELECT		  LC.[CategoryID]
				, LC.[CategoryName]
	FROM		[Landing].[Categories] AS LC
	LEFT JOIN	[Hash].[Categories] AS HC ON LC.[CategoryID] = HC.[CategoryID]
	WHERE		CHECKSUM ( LC.[CategoryID], LC.[CategoryName] ) <> HC.[CheckSum]
				OR HC.[CategoryID] IS NULL;

	TRUNCATE TABLE [Hash].[Categories];

	INSERT INTO [Hash].[Categories]
	SELECT		  LC.[CategoryID]
				, CHECKSUM ( LC.[CategoryID], LC.[CategoryName] )
	FROM		[Landing].[Categories] AS LC;
END