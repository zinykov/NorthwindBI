CREATE PROCEDURE [Landing].[ExtractOrderDetails] AS
BEGIN
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
	
	TRUNCATE TABLE [Hash].[Order Details];

	INSERT INTO [Hash].[Order Details]
	SELECT		  LOD.[OrderID]
				, LOD.[ProductID]
				, LOD.[CheckSum]
	FROM		[Landing].[Order Details] AS LOD;
END