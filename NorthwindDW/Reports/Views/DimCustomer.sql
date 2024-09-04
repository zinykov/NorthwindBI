CREATE VIEW [Reports].[DimCustomer]
	WITH SCHEMABINDING
AS
	SELECT		  [CustomerKey]
				, [CustomerAlterKey]
				, [Customer]
				, [ContactName]
				, [ContactTitle]
				, [Country]
				, [City]
				, [Phone]
				, [Fax]
	
	FROM		[Dimension].[Customer]
	WITH (NOLOCK);