CREATE VIEW [Landing].[ChangedCustomers] AS
	SELECT		  LC.[CustomerID]
				, LC.[CompanyName]
				, LC.[ContactName]
				, LC.[ContactTitle]
				, LC.[City]
				, LC.[Country]
				, LC.[Phone]
				, LC.[Fax]
	FROM		[Landing].[Customers] AS LC
	LEFT JOIN	[Hash].[Customers] AS HC ON LC.[CustomerID] = HC.[CustomerID]
	WHERE		LC.[HashDiff] <> HC.[HashDiff]
				OR HC.[CustomerID] IS NULL;