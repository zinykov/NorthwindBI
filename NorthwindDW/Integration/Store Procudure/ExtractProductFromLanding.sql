﻿CREATE PROCEDURE [Integration].[ExtractProductFromLanding] AS
BEGIN
	SELECT		  [ProductAlterKey]		=	P.[ProductID]
				, [Product]				=	P.[ProductName]
				, [Category]			=	C.[CategoryName]

	FROM		[Landing].[Products] AS P
	INNER JOIN	[Landing].[Categories] AS C ON C.[CategoryID] = P.[CategoryID]
END;
GO