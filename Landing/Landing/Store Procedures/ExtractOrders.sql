CREATE PROCEDURE [Landing].[ExtractOrders] AS
BEGIN
	ALTER TABLE [Landing].[Orders] ADD CONSTRAINT [PK_Landing_Orders]
		PRIMARY KEY CLUSTERED ( [OrderID] ASC );

	UPDATE [Landing].[Orders]
	SET [CheckSum] = CHECKSUM (
		  [CustomerID]
		, [EmployeeID]
		, [OrderDate]
		, [RequiredDate]
		, [ShippedDate]
		, [ShipCity]
		, [ShipCountry]
	);

	SELECT		  LO.[OrderID]
				, LO.[CustomerID]
				, LO.[EmployeeID]
				, LO.[OrderDate]
				, LO.[RequiredDate]
				, LO.[ShippedDate]
				, LO.[ShipCity]
				, LO.[ShipCountry]
	FROM		[Landing].[Orders] AS LO
	LEFT JOIN	[Hash].[Orders] AS HO ON LO.[OrderID] = HO.[OrderID]
	WHERE		LO.[CheckSum] <> HO.[CheckSum]
				OR HO.[OrderID] IS NULL;
END