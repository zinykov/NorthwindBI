CREATE VIEW [Reports].[Order]
	WITH SCHEMABINDING
AS
	SELECT		  [OrderKey]
				, [ProductKey]
				, [CustomerKey]
				, [EmployeeKey]
				, [OrderDateKey]
				, [RequiredDateKey]
				, [ShippedDateKey]
				, [UnitPrice]
				, [Quantity]
				, [Discount]
				, [SalesAmount]
				, [SalesAmountWithDiscount]
	
	FROM		[Fact].[Order]
	WITH (NOLOCK);