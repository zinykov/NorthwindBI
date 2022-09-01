CREATE PROCEDURE [Integration].[ExtractCustomerFromLanding] AS
BEGIN
	SELECT		  C.[CustomerAlterKey]
				, C.[Customer]
				, C.[ContactName]
				, C.[ContactTitle]
				, C.[Country]
				, C.[City]
				, C.[Phone]
				, C.[Fax]

	FROM		[Landing].[Customer] AS C
END;
GO