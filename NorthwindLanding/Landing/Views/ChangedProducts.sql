CREATE VIEW [Landing].[ChangedProducts] AS
	SELECT		  LP.[ProductID]
				, LP.[ProductName]
				, LP.[CategoryID]
	FROM		[Landing].[Products] AS LP
	LEFT JOIN	[Hash].[Products] AS HP ON LP.[ProductID] = HP.[ProductID]
	WHERE		LP.[HashDiff] <> HP.[HashDiff]
				OR HP.[ProductID] IS NULL;