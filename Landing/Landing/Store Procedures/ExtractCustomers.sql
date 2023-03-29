CREATE PROCEDURE [Landing].[ExtractCustomers] AS
BEGIN
	UPDATE [Landing].[Customers]
	SET [CheckSum] = CHECKSUM (
		  [CompanyName]
		, [ContactName]
		, [ContactTitle]
		, [City]
		, [Country]
		, [Phone]
		, [Fax]
	);

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
	WHERE		LC.[CheckSum] <> HC.[CheckSum]
				OR HC.[CustomerID] IS NULL;
	
	TRUNCATE TABLE [Hash].[Customers];

	INSERT INTO [Hash].[Customers]
	SELECT		  LC.[CustomerID]
				, LC.[CheckSum]
	FROM		[Landing].[Customers] AS LC;
END