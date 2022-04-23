CREATE PROCEDURE [Integration].[ExtractOrdersFromLanding] AS
BEGIN
	SELECT		  [OrderKey]					=	O.[OrderID]
				, [ProductKey]
				, [CustomerKey]
				, [EmployeeKey]
				, [OrderDateKey]				=	YEAR ( [OrderDate] ) * 10000 + MONTH ( [OrderDate] ) * 100 + DAY ( [OrderDate] )
				, [RequiredDateKey]				=	YEAR ( [RequiredDate] ) * 10000 + MONTH ( [RequiredDate] ) * 100 + DAY ( [RequiredDate] )
				, [ShippedDateKey]				=	YEAR ( [ShippedDate] ) * 10000 + MONTH ( [ShippedDate] ) * 100 + DAY ( [ShippedDate] )
				, [UnitPrice]
				, [Quantity]
				, [Discount]					=	[UnitPrice] * [Discount]
				, [SalesAmount]					=	[UnitPrice] * [Quantity]
				, [SalesAmountWithDiscount]		=	[UnitPrice] * [Quantity] - [Discount]

	FROM		[Landing].[Orders] AS O
	INNER JOIN	[Landing].[Order Details] AS OD ON O.[OrderID] = OD.[OrderID]
	INNER JOIN	[Dimension].[Customer] AS C ON C.[CustomerAlterKey] = O.[CustomerID]
				AND O.[OrderDate] BETWEEN C.[StartDate] AND ISNULL ( C.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
	INNER JOIN	[Dimension].[Employee] AS E ON E.[EmployeeAlterKey] = O.[EmployeeID]
				AND O.[OrderDate] BETWEEN E.[StartDate] AND ISNULL ( E.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
	INNER JOIN	[Dimension].[Product] AS P ON P.[ProductAlterKey] = OD.[ProductID]
				AND O.[OrderDate] BETWEEN P.[StartDate] AND ISNULL ( P.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )

	WHERE		O.[OrderDate] < DATEFROMPARTS ( 1998, 05, 01 )
END;
GO