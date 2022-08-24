CREATE PROCEDURE [Integration].[ExtractCustomerFromLanding] AS
BEGIN
	INSERT INTO	  [Staging].[Customer]
	SELECT		  [CustomerAlterKey]	=	C.[CustomerID]
				, [Customer]			=	C.[CompanyName]
				, [ContactName]			=	C.[ContactName]
				, [ContactTitle]		=	C.[ContactTitle]
				, [Country]				=	C.[Country]
				, [City]				=	C.[City]
				, [Phone]				=	C.[Phone]
				, [Fax]					=	C.[Fax]

	FROM		[Landing].[Customers] AS C
END;
GO