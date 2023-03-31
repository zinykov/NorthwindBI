CREATE PROCEDURE [Landing].[ExtractOrders]
	  @StartLoad AS DATE
	, @EndLoad AS DATE
AS BEGIN
	IF DATEDIFF ( DAY, @StartLoad, @EndLoad ) = 1
		BEGIN
			SET @StartLoad = @EndLoad
		END

	SELECT		  LO.[OrderID]
				, LO.[CustomerID]
				, LO.[EmployeeID]
				, LOD.[ProductID]
				, LO.[OrderDate]
				, LO.[RequiredDate]
				, LO.[ShippedDate]
				, LOD.[UnitPrice]
				, LOD.[Quantity]
				, LOD.[Discount]
	FROM		[Landing].[Orders] AS LO
	LEFT JOIN	[Landing].[Order Details] AS LOD ON LO.[OrderID] = LOD.[OrderID]
	LEFT JOIN	[Hash].[Orders] AS HO ON LO.[OrderID] = HO.[OrderID]
	LEFT JOIN	[Hash].[Order Details] AS HOD ON LOD.[OrderID] = HOD.[OrderID]
	WHERE		( LO.[CheckSum] <> HO.[CheckSum]
				OR HO.[OrderID] IS NULL )
				AND ( LOD.[CheckSum] <> HOD.[CheckSum]
				OR HOD.[OrderID] IS NULL )
				AND LO.[ShippedDate] BETWEEN @StartLoad AND @EndLoad;
END