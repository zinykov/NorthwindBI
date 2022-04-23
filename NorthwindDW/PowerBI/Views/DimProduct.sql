CREATE VIEW [PowerBI].[DimProduct] AS
	SELECT		  [ProductKey]
				, [ProductAlterKey]
				, [Product]
				, [Category]
				, [StartDate]
				, [EndDate]
				, [Current]
	
	FROM		[Dimension].[Product];