CREATE PROCEDURE [Landing].[ExtractProducts] AS
BEGIN
	UPDATE [Landing].[Products]
	SET [CheckSum] = CHECKSUM (
		  [ProductName]
		, [CategoryID]
	);

	SELECT		  LP.[ProductID]
				, LP.[ProductName]
				, LP.[CategoryID]
	FROM		[Landing].[Products] AS LP
	LEFT JOIN	[Hash].[Products] AS HP ON LP.[ProductID] = HP.[ProductID]
	WHERE		LP.[CheckSum] <> HP.[CheckSum]
				OR HP.[ProductID] IS NULL;
	
	TRUNCATE TABLE [Hash].[Products];

	INSERT INTO [Hash].[Products]
	SELECT		  LP.[ProductID]
				, LP.[CheckSum]
	FROM		[Landing].[Products] AS LP;
END