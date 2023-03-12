CREATE PROCEDURE [Landing].[ExtractOrders]
	  @StartLoad AS DATE
	, @EndLoad AS DATE
	, @LineageKey AS INT
AS BEGIN
	SELECT		  [OrderKey]					=	O.[OrderID]
				, [ProductID]					=	ISNULL ( [ProductID], -1 )
				, [CustomerID]					=	ISNULL ( [CustomerID], -1 )
				, [EmployeeID]					=	ISNULL ( [EmployeeID], -1 )
				, [OrderDateKey]				=	ISNULL ( YEAR ( [OrderDate] ) * 10000 + MONTH ( [OrderDate] ) * 100 + DAY ( [OrderDate] ), 19951231 )
				, [RequiredDateKey]				=	ISNULL ( YEAR ( [RequiredDate] ) * 10000 + MONTH ( [RequiredDate] ) * 100 + DAY ( [RequiredDate] ), 19951231 )
				, [ShippedDateKey]				=	ISNULL ( YEAR ( [ShippedDate] ) * 10000 + MONTH ( [ShippedDate] ) * 100 + DAY ( [ShippedDate] ), 19951231 )
				, [UnitPrice]					=	ISNULL ( [UnitPrice], 0 )
				, [Quantity]					=	ISNULL ( [Quantity], 0 )
				, [Discount]					=	ISNULL ( [UnitPrice] * [Discount], 0 )
				, [SalesAmount]					=	ISNULL ( [UnitPrice] * [Quantity], 0 )
				, [SalesAmountWithDiscount]		=	ISNULL ( [UnitPrice] * ( [Quantity] - [Discount] ), 0 )
				, [LineageKey]					=	@LineageKey

	FROM		[Landing].[Orders] AS O
	LEFT JOIN	[Landing].[Order Details] AS OD ON O.[OrderID] = OD.[OrderID]

	WHERE		O.[ShippedDate] BETWEEN @StartLoad AND @EndLoad
END