CREATE PROCEDURE [Reports].[SalesReportForEmployee]
	@EmployeeAlterKey AS INT
AS BEGIN
	SELECT		  D.[Year]
				, D.[MonthNumber]
				, D.[Month]
				, [SalesAmountWithDiscount]	= SUM ( O.[SalesAmountWithDiscount] )
				, [SalesAmount]				= SUM ( O.[SalesAmount] )
				, [Discount]				= SUM ( O.[Discount] )
	FROM		[Reports].[FactOrder] AS O
	INNER JOIN	[Reports].[DimDate] AS D ON D.[DateKey] = O.[OrderDateKey]
	INNER JOIN	[Reports].[DimEmployee] AS E ON E.[EmployeeKey] = O.[EmployeeKey]
	WHERE		E.[EmployeeAlterKey] = @EmployeeAlterKey
	GROUP BY	  D.[Year]
				, D.[MonthNumber]
				, D.[Month]
	ORDER BY	  D.[Year] DESC
				, D.[MonthNumber] DESC
END