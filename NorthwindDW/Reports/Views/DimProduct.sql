CREATE VIEW [Reports].[DimProduct]
	WITH SCHEMABINDING
AS
	SELECT		  [ProductKey]
				, [ProductAlterKey]
				, [Product]
				, [Category]
	
	FROM		[Dimension].[Product]
	WITH (NOLOCK);