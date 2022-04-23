CREATE PROCEDURE [Integration].[IncrementalOrdersLoad] AS
BEGIN
		ALTER PARTITION SCHEME [PS_Order_Date_Data]  
			NEXT USED [Fast_Fact_Data]

		ALTER PARTITION SCHEME [PS_Order_Date_Index]  
			NEXT USED [Fast_Fact_Index]

		DECLARE		@NewPartitionDate AS DATE
		DECLARE		@NewPartitionParameter AS INT

		SET			@NewPartitionDate = (
			SELECT		DATEADD ( DAY, 2, MAX ( D.[AlterDateKey] ) )
			FROM		[Fact].[Order] AS O
			INNER JOIN	[Dimension].[Date] AS D ON D.[DateKey] = O.[OrderDateKey]
		)

		SET		@NewPartitionParameter = YEAR ( @NewPartitionDate ) * 10000 + MONTH ( @NewPartitionDate ) * 100 + DAY ( @NewPartitionDate )

		IF NOT EXISTS ( SELECT 1 FROM [sys].[partition_range_values] WHERE [value] = @NewPartitionParameter )
		BEGIN
			ALTER PARTITION FUNCTION [PF_Order_Date] ()
				SPLIT RANGE ( @NewPartitionParameter )
			PRINT ( @NewPartitionParameter )
		END

	 -- Execute code to fill staging fact tables

		INSERT INTO [Staging].[Order]
		SELECT		  [OrderKey]					=	O.[OrderID]
					, [ProductKey]
					, [CustomerKey]
					, [EmployeeKey]
					, [OrderDateKey]				=	YEAR ( [OrderDate] ) * 10000 + MONTH ( [OrderDate] ) * 100 + DAY ( [OrderDate] )
					, [RequiredDateKey]				=	YEAR ( [RequiredDate] ) * 10000 + MONTH ( [RequiredDate] ) * 100 + DAY ( [RequiredDate] )
					, [ShippedDateKey]				=	YEAR ( [ShippedDate] ) * 10000 + MONTH ( [ShippedDate] ) * 100 + DAY ( [ShippedDate] )
					, [UnitPrice]
					, [Quantity]
					, [Discount]					=	[UnitPrice] * [Discount]
					, [SalesAmount]					=	[UnitPrice] * [Quantity]
					, [SalesAmountWithDiscount]		=	[UnitPrice] * [Quantity] - [Discount]

		FROM		[Landing].[Orders] AS O
		INNER JOIN	[Landing].[Order Details] AS OD ON O.[OrderID] = OD.[OrderID]
		INNER JOIN	[Dimension].[Customer] AS C ON C.[CustomerAlterKey] = O.[CustomerID]
					AND O.[OrderDate] BETWEEN C.[StartDate] AND ISNULL ( C.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
		INNER JOIN	[Dimension].[Employee] AS E ON E.[EmployeeAlterKey] = O.[EmployeeID]
					AND O.[OrderDate] BETWEEN E.[StartDate] AND ISNULL ( E.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )
		INNER JOIN	[Dimension].[Product] AS P ON P.[ProductAlterKey] = OD.[ProductID]
					AND O.[OrderDate] BETWEEN P.[StartDate] AND ISNULL ( P.[EndDate], DATEFROMPARTS ( 3999, 12, 31 ) )

		WHERE		YEAR ( [OrderDate] ) * 10000 + MONTH ( [OrderDate] ) * 100 + DAY ( [OrderDate] ) = @NewPartitionParameter - 1

		DECLARE @Partition_number AS INT

		SET @Partition_number = (
			SELECT		TOP (1) partition_number -1
			FROM		sys.partitions
			WHERE		object_id = OBJECT_ID ( CONCAT ( DB_NAME (), N'.Staging.Order' ) )			
			ORDER BY	partition_number DESC
		)

		ALTER TABLE [Staging].[Order] SWITCH PARTITION @Partition_number TO [Fact].[Order] PARTITION @Partition_number
END