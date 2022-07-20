CREATE VIEW [Reports].[DimCustomer] AS
	SELECT		  [CustomerKey]
				, [CustomerAlterKey]
				, [Customer]
				, [ContactName]
				, [ContactTitle]
				, [Country]
				, [City]
				, [Phone]
				, [Fax]
				, [StartDate]
				, [EndDate]
				, [Current]
	
	FROM		[Dimension].[Customer];