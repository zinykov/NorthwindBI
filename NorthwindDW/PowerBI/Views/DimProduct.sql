CREATE VIEW [PowerBI].[DimProduct] AS
	SELECT		  [ProductKey]
				, [ProductAlterKey]
				, [Product]
				, [Category]
	
	FROM		[Dimension].[Product];