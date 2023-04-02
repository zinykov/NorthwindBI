CREATE PROCEDURE [Landing].[CreateOrdersHash]
	@CutoffTime AS DATE
AS BEGIN
	ALTER TABLE [Landing].[Orders] ADD CONSTRAINT [PK_Landing_Orders]
		PRIMARY KEY CLUSTERED ( [OrderID] ASC );
	ALTER TABLE [Landing].[Order Details] ADD CONSTRAINT [PK_Landing_Order_Details]
		PRIMARY KEY CLUSTERED ( [OrderID] ASC, [ProductID] ASC );

	UPDATE [Landing].[Orders]
	SET [CheckSum] = CHECKSUM (
		  [CustomerID]
		, [EmployeeID]
		, [OrderDate]
		, [RequiredDate]
		, [ShippedDate]
	)
	WHERE [ShippedDate] <= @CutoffTime;

	UPDATE [Landing].[Order Details]
	SET [CheckSum] = CHECKSUM (
		  [UnitPrice]
		, [Quantity]
		, [Discount]
	)
	WHERE [OrderID] IN ( SELECT [OrderID] FROM [Landing].[Orders] WHERE [ShippedDate] <= @CutoffTime );
END