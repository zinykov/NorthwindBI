CREATE PROCEDURE [Landing].[ExtractOrders] AS
BEGIN
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
	
	TRUNCATE TABLE [Hash].[Orders];

	INSERT INTO [Hash].[Orders]
	SELECT		  LO.[OrderID]
				, LO.[CheckSum]
	FROM		[Landing].[Orders] AS LO;
END