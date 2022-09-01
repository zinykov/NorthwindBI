CREATE VIEW [Landing].[Customer] AS
	SELECT		  [CustomerAlterKey]	=	C.[CustomerID]
				, [Customer]			=	C.[CompanyName]
				, [ContactName]			=	C.[ContactName]
				, [ContactTitle]		=	C.[ContactTitle]
				, [Country]				=	C.[Country]
				, [City]				=	C.[City]
				, [Phone]				=	C.[Phone]
				, [Fax]					=	C.[Fax]

	FROM		[Landing].[Customers] AS C