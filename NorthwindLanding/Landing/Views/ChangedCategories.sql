CREATE VIEW [Landing].[ChangedCategories] AS
	SELECT		  LC.[CategoryID]
				, LC.[CategoryName]
	FROM		[Landing].[Categories] AS LC
	LEFT JOIN	[Hash].[Categories] AS HC ON LC.[CategoryID] = HC.[CategoryID]
	WHERE		LC.[HashDiff] <> HC.[HashDiff]
				OR HC.[CategoryID] IS NULL;