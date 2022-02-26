CREATE VIEW [PowerBI].[SalesByCalendarV] WITH SCHEMABINDING AS (
	SELECT		  D.[Year]
				, D.[Quarter]
				, D.[Month]
				, [UnitPrice]					=	SUM ( O.[UnitPrice] )
				, [Quantity]					=	SUM ( O.[Quantity] )
				, [Discount]					=	SUM ( O.[Discount] )
				, [SalesAmount]					=	SUM ( O.[SalesAmount] )
				, [SalesAmountWithDiscount]		=	SUM ( O.[SalesAmountWithDiscount] )
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