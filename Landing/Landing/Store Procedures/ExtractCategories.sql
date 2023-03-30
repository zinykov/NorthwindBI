CREATE PROCEDURE [Landing].[ExtractCategories] AS
BEGIN
	ALTER TABLE [Landing].[Categories] ADD CONSTRAINT [PK_Landing_Categories]
		PRIMARY KEY CLUSTERED ( [CategoryID] ASC );

	UPDATE [Landing].[Categories]
	SET [CheckSum] = CHECKSUM ( [CategoryName] );

	SELECT		  LC.[CategoryID]
				, LC.[CategoryName]
	FROM		[Landing].[Categories] AS LC
	LEFT JOIN	[Hash].[Categories] AS HC ON LC.[CategoryID] = HC.[CategoryID]
	WHERE		LC.[CheckSum] <> HC.[CheckSum]
				OR HC.[CategoryID] IS NULL;
END