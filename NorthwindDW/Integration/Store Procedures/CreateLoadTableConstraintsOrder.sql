CREATE PROCEDURE [Integration].[CreateLoadTableConstraintsOrder]
AS BEGIN
	ALTER TABLE [Integration].[Order]
        ADD CONSTRAINT [FK_Integration_Order_Customer_Key_Dimension_Customer] FOREIGN KEY ( [CustomerKey] ) REFERENCES [Dimension].[Customer] ( [CustomerKey] )
	ALTER TABLE [Integration].[Order]
        ADD CONSTRAINT [FK_Integration_Order_Employee_Key_Dimension_Employee] FOREIGN KEY ( [EmployeeKey] ) REFERENCES [Dimension].[Employee] ( [EmployeeKey] )
	ALTER TABLE [Integration].[Order]
        ADD CONSTRAINT [FK_Integration_Order_Product_Key_Dimension_Product] FOREIGN KEY ( [ProductKey] ) REFERENCES [Dimension].[Product] ( [ProductKey] )
	ALTER TABLE [Integration].[Order]
        ADD CONSTRAINT [FK_Integration_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY ( [OrderDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] )
	ALTER TABLE [Integration].[Order]
        ADD CONSTRAINT [FK_Integration_Order_Required_Date_Key_Dimension_Date] FOREIGN KEY ( [RequiredDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] )
	ALTER TABLE [Integration].[Order]
        ADD CONSTRAINT [FK_Integration_Order_Shipped_Date_Key_Dimension_Date] FOREIGN KEY ( [ShippedDateKey] ) REFERENCES [Dimension].[Date] ( [DateKey] )
	ALTER TABLE [Integration].[Order]
        ADD CONSTRAINT [FK_Integration_Order_Lineage_Key_Integration_Lineage] FOREIGN KEY ( [LineageKey] ) REFERENCES [Integration].[Lineage] ( [LineageKey] )

    CREATE CLUSTERED COLUMNSTORE INDEX [CCI_Integration_Order] ON [Integration].[Order]
        ON [PS_Load_Order_Data] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Order_Date_Key] ON [Integration].[Order] ( [OrderDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Required_Date_Key] ON [Integration].[Order] ( [RequiredDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Shipped_Date_Key] ON [Integration].[Order] ( [ShippedDateKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Cusotmer_Key] ON [Integration].[Order] ( [CustomerKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Employee_Key] ON [Integration].[Order] ( [EmployeeKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [OrderDateKey] );

    CREATE NONCLUSTERED INDEX [IX_Integration_Order_Product_Key] ON [Integration].[Order] ( [ProductKey] )
        WITH ( DATA_COMPRESSION = PAGE )
        ON [PS_Load_Order_Index] ( [OrderDateKey] );
END