CREATE PROCEDURE [Integration].[ExtractCustomerFromLanding] AS
BEGIN
	SELECT		  [CustomerAlterKey]
				, [Customer]
				, [ContactName]
				, [ContactTitle]
				, [Country]
				, [City]
				, [Phone]
				, [Fax]

	FROM		[Landing].[CustomerV]
END;
GO