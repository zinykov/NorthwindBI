CREATE VIEW [PowerBI].[SalesByCalendarV] WITH SCHEMABINDING AS (
	SELECT		  D.[Year]
				, D.[Quarter]
				, D.[Month]
				, [UnitPrice]					=	SUM ( ISNULL ( O.[UnitPrice], 0 ) )
				, [Quantity]					=	SUM ( ISNULL ( O.[Quantity], 0 ) )
				, [Discount]					=	SUM ( ISNULL ( O.[Discount], 0 ) )
				, [SalesAmount]					=	SUM ( ISNULL ( O.[SalesAmount], 0 ) )
				, [SalesAmountWithDiscount]		=	SUM ( ISNULL ( O.[SalesAmountWithDiscount], 0 ) )
				, [COUNT_BIG]					=	COUNT_BIG ( * )
	
	FROM		[Fact].[Order] AS O
	INNER JOIN	[Dimension].[Date] AS D ON D.[DateKey] = O.[OrderDateKey]

	GROUP BY	  D.[Year]
				, D.[Quarter]
				, D.[Month]
	);
GO

CREATE UNIQUE CLUSTERED INDEX [UCIX_PowerBI_By_Calender] ON [PowerBI].[SalesByCalendarV] ( [Year] DESC, [Quarter] DESC, [Month] DESC )
    ON [PRIMARY];
GO