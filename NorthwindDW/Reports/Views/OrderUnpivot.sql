CREATE VIEW [Reports].[OrderUnpivot]
	WITH SCHEMABINDING
AS 
	SELECT		  [OrderKey]
				, [DateType]					=	CASE [DateType]
														WHEN 'OrderDateKey'		THEN 'OrderDate'
														WHEN 'RequiredDateKey'	THEN 'RequiredDate'
														WHEN 'ShippedDateKey'	THEN 'ShippedDate'
													END
				, [DateKey]
				, [ProductKey]
				, [CustomerKey]
				, [EmployeeKey]
				, [UnitPrice]
				, [Quantity]
				, [Discount]
				, [SalesAmount]
				, [SalesAmountWithDiscount]
	
	FROM		(
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
				) AS O
	UNPIVOT		(
					[DateKey] FOR [DateType] IN ( 
						  [OrderDateKey]
						, [RequiredDateKey]
						, [ShippedDateKey]
					)
				) AS UNPVT;
GO