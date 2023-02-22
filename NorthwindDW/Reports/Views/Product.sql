CREATE VIEW [Reports].[Product]
	WITH SCHEMABINDING
AS
	SELECT		  [ProductKey]
				, [ProductAlterKey]
				, [Product]
				, [Category]
	
	FROM		[Dimension].[Product]
	WITH (NOLOCK);