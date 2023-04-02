CREATE PROCEDURE [Landing].[ExtractProducts] AS
BEGIN
	ALTER TABLE [Landing].[Products] ADD CONSTRAINT [PK_Landing_Products]
		PRIMARY KEY CLUSTERED ( [ProductID] ASC );

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
END