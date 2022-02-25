CREATE VIEW [Fact].[OrderUnpvtV] WITH SCHEMABINDING AS (
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
				) AS UNPVT
);
GO

CREATE UNIQUE CLUSTERED INDEX [UCIX_Fact_Order_Unpvt] ON [Fact].[OrderUnpvtV] ( [OrderKey] ASC, [DateType] ASC, [DateKey] ASC );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Unpvt_Date_Key] ON [Fact].[OrderUnpvtV] ( [DateKey] ASC );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Unpvt_Product_Key] ON [Fact].[OrderUnpvtV] ( [ProductKey] ASC );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Unpvt_Customer_Key] ON [Fact].[OrderUnpvtV] ( [CustomerKey] ASC );
GO

CREATE NONCLUSTERED INDEX [IX_Fact_Order_Unpvt_Employee_Key] ON [Fact].[OrderUnpvtV] ( [EmployeeKey] ASC );
GO