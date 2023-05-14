CREATE PROCEDURE [Integration].[TruncateDWH] AS
BEGIN
	SET NOCOUNT ON;

	ALTER TABLE [Dimension].[Customer] DROP CONSTRAINT [FK_Dimension_Customer_Lineage_Key_Integration_Lineage];
	ALTER TABLE [Dimension].[Employee] DROP CONSTRAINT [FK_Dimension_Employees_Lineage_Key_Integration_Lineage];
	ALTER TABLE [Dimension].[Product] DROP CONSTRAINT [FK_Dimension_Product_Lineage_Key_Integration_Lineage];
	ALTER TABLE [Fact].[Order] DROP CONSTRAINT [FK_Fact_Order_Customer_Key_Dimension_Customer];
	ALTER TABLE [Fact].[Order] DROP CONSTRAINT [FK_Fact_Order_Employee_Key_Dimension_Employee];
	ALTER TABLE [Fact].[Order] DROP CONSTRAINT [FK_Fact_Order_Product_Key_Dimension_Product];
	ALTER TABLE [Fact].[Order] DROP CONSTRAINT [FK_Fact_Order_Order_Date_Key_Dimension_Date];
	ALTER TABLE [Fact].[Order] DROP CONSTRAINT [FK_Fact_Order_Required_Date_Key_Dimension_Date];
	ALTER TABLE [Fact].[Order] DROP CONSTRAINT [FK_Fact_Order_Shipped_Date_Key_Dimension_Date];
	ALTER TABLE [Fact].[Order] DROP CONSTRAINT [FK_Fact_Order_Lineage_Key_Integration_Lineage];
	
	TRUNCATE TABLE [Fact].[Order];
	TRUNCATE TABLE [Dimension].[Customer];
	TRUNCATE TABLE [Dimension].[Employee];
	TRUNCATE TABLE [Dimension].[Product];
	TRUNCATE TABLE [Dimension].[Date];
	TRUNCATE TABLE [Integration].[Lineage];
	TRUNCATE TABLE [Integration].[ErrorLog];

	ALTER TABLE [Dimension].[Customer] ADD CONSTRAINT [FK_Dimension_Customer_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] );
	ALTER TABLE [Dimension].[Employee] ADD CONSTRAINT [FK_Dimension_Employees_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] );
	ALTER TABLE [Dimension].[Product] ADD CONSTRAINT [FK_Dimension_Product_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] );
	ALTER TABLE [Fact].[Order] ADD CONSTRAINT [FK_Fact_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] );
	ALTER TABLE [Fact].[Order] ADD CONSTRAINT [FK_Fact_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] );
	ALTER TABLE [Fact].[Order] ADD CONSTRAINT [FK_Fact_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductKey] );
	ALTER TABLE [Fact].[Order] ADD CONSTRAINT [FK_Fact_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] );
	ALTER TABLE [Fact].[Order] ADD CONSTRAINT [FK_Fact_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] );
	ALTER TABLE [Fact].[Order] ADD CONSTRAINT [FK_Fact_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] );
	ALTER TABLE [Fact].[Order] ADD CONSTRAINT [FK_Fact_Order_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] );
	
	ALTER SEQUENCE [Sequences].[CustomerKey] RESTART WITH 1;
	ALTER SEQUENCE [Sequences].[EmployeeKey] RESTART WITH 1;
	ALTER SEQUENCE [Sequences].[LineageKey] RESTART WITH 1;
	ALTER SEQUENCE [Sequences].[ProductKey] RESTART WITH 1;

	SET NOCOUNT OFF;
END;
GO