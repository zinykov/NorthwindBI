CREATE PROCEDURE [Integration].[TruncateStaging] AS
BEGIN
	SET NOCOUNT ON;

	ALTER TABLE [Staging].[Order] DROP CONSTRAINT [FK_Staging_Order_Customer_Key_Dimension_Customer];
	ALTER TABLE [Staging].[Order] DROP CONSTRAINT [FK_Staging_Order_Employee_Key_Dimension_Employee];
	ALTER TABLE [Staging].[Order] DROP CONSTRAINT [FK_Staging_Order_Product_Key_Dimension_Product];
	ALTER TABLE [Staging].[Order] DROP CONSTRAINT [FK_Staging_Order_Order_Date_Key_Dimension_Date];
	ALTER TABLE [Staging].[Order] DROP CONSTRAINT [FK_Staging_Order_Required_Date_Key_Dimension_Date];
	ALTER TABLE [Staging].[Order] DROP CONSTRAINT [FK_Staging_Order_Shipped_Date_Key_Dimension_Date];
	ALTER TABLE [Staging].[Order] DROP CONSTRAINT [FK_Staging_Order_Lineage_Key_Integration_Lineage];

	TRUNCATE TABLE [Staging].[Customer];
	TRUNCATE TABLE [Staging].[Employee];
	TRUNCATE TABLE [Staging].[Product];
	TRUNCATE TABLE [Staging].[Order];
	TRUNCATE TABLE [DQS_STAGING_DATA].[dbo].[Customer];
	TRUNCATE TABLE [DQS_STAGING_DATA].[dbo].[Employee];
	TRUNCATE TABLE [DQS_STAGING_DATA].[dbo].[Product];

	ALTER TABLE [Staging].[Order] ADD CONSTRAINT [FK_Staging_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] );
	ALTER TABLE [Staging].[Order] ADD CONSTRAINT [FK_Staging_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] );
	ALTER TABLE [Staging].[Order] ADD CONSTRAINT [FK_Staging_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductKey] );
	ALTER TABLE [Staging].[Order] ADD CONSTRAINT [FK_Staging_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] );
	ALTER TABLE [Staging].[Order] ADD CONSTRAINT [FK_Staging_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] );
	ALTER TABLE [Staging].[Order] ADD CONSTRAINT [FK_Staging_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] );
	ALTER TABLE [Staging].[Order] ADD CONSTRAINT [FK_Staging_Order_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] );

	SET NOCOUNT OFF;
END;
GO