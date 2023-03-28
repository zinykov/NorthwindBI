CREATE PROCEDURE [Landing].[ExtractCategories] AS
BEGIN
	UPDATE [Landing].[Categories]
	SET [CheckSum] = CHECKSUM ( [CategoryID], [CategoryName] );

	CREATE INDEX [IX_Landing_Categories_Hash] ON [Landing].[Categories] ( [CheckSum] )
		INCLUDE ( [CategoryID], [CategoryName] );
	
	SELECT		  LC.[CategoryID]
				, LC.[CategoryName]
	FROM		[Landing].[Categories] AS LC
	LEFT JOIN	[Hash].[Categories] AS HC ON LC.[CategoryID] = HC.[CategoryID]
	WHERE		LC.[CheckSum] <> HC.[CheckSum]
				OR HC.[CategoryID] IS NULL;
	
	DROP INDEX [IX_Hash_Categories_Hash] ON [Hash].[Categories];

	TRUNCATE TABLE [Hash].[Categories];

	INSERT INTO [Hash].[Categories]
	SELECT		  LC.[CategoryID]
				, LC.[CheckSum]
	FROM		[Landing].[Categories] AS LC;

	CREATE INDEX [IX_Hash_Categories_Hash] ON [Hash].[Categories] ( [CheckSum] )
		INCLUDE ( [CategoryID] );

	DROP INDEX [IX_Landing_Categories_Hash] ON [Landing].[Categories];
END