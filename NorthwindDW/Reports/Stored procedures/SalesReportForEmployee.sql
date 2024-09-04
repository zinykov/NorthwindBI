CREATE PROCEDURE [Reports].[SalesReportForEmployee]
	@EmployeeAlterKey AS INT
AS BEGIN
	SELECT		  D.[Year]
				, D.[MonthNumber]
				, D.[Month]
				, [IsMonthTotal]			= GROUPING ( D.[MonthNumber] )
				, [SalesAmountWithDiscount]	= SUM ( O.[SalesAmountWithDiscount] )
				, [SalesAmount]				= SUM ( O.[SalesAmount] )
				, [Discount]				= SUM ( O.[Discount] ) / SUM ( O.[SalesAmountWithDiscount] ) 
	FROM		[Reports].[Order] AS O
	INNER JOIN	[Reports].[Date] AS D ON D.[DateKey] = O.[OrderDateKey]
	INNER JOIN	[Reports].[Employee] AS E ON E.[EmployeeKey] = O.[EmployeeKey]
	WHERE		E.[EmployeeAlterKey] = @EmployeeAlterKey
	GROUP BY	  D.[Year]
				, ROLLUP ( ( D.[MonthNumber], D.[Month] ) )
	ORDER BY	  D.[Year] DESC
				, D.[MonthNumber] DESC
END
