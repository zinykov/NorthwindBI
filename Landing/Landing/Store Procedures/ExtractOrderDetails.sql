CREATE PROCEDURE [Landing].[ExtractOrderDetails] AS
BEGIN
	ALTER TABLE [Landing].[Order Details] ADD CONSTRAINT [PK_Landing_Order_Details]
		PRIMARY KEY CLUSTERED ( [OrderID] ASC, [ProductID] ASC );

	UPDATE [Landing].[Order Details]
	SET [CheckSum] = CHECKSUM (
		  [UnitPrice]
		, [Quantity]
		, [Discount]
	);

	SELECT		  LOD.[OrderID]
				, LOD.[ProductID]
				, LOD.[UnitPrice]
				, LOD.[Quantity]
				, LOD.[Discount]
	FROM		[Landing].[Order Details] AS LOD
	LEFT JOIN	[Hash].[Order Details] AS HOD ON LOD.[OrderID] = HOD.[OrderID]
				AND LOD.[ProductID] = HOD.[ProductID]
	WHERE		LOD.[CheckSum] <> HOD.[CheckSum]
				OR HOD.[OrderID] IS NULL;
END