CREATE PROCEDURE [Landing].[ExtractCustomers] AS
BEGIN
	ALTER TABLE [Landing].[Customers] ADD CONSTRAINT [PK_Landing_Customers]
		PRIMARY KEY CLUSTERED ( [CustomerID] ASC );

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
END