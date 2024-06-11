CREATE VIEW [Landing].[ChangedOrders] AS
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
	WHERE		(
					LO.[HashDiff] <> HO.[HashDiff]
					OR HO.[OrderID] IS NULL
				) OR (
					LOD.[HashDiff] <> HOD.[HashDiff]
					OR HOD.[OrderID] IS NULL
				)