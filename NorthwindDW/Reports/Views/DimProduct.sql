CREATE VIEW [Reports].[DimProduct] AS
	SELECT		  [ProductKey]
				, [ProductAlterKey]
				, [Product]
				, [Category]
	
	FROM		[Dimension].[Product];