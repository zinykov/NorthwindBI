CREATE PROCEDURE [Integration].[TrancateDWH] AS
BEGIN	
	DELETE FROM [Fact].[Order]
	DELETE FROM [Staging].[Order]
	DELETE FROM [Dimension].[Customer]
	DELETE FROM [Dimension].[Employee]
	DELETE FROM [Dimension].[Product]
	DELETE FROM [Dimension].[Date]
	DELETE FROM [Integration].[Lineage]

	ALTER SEQUENCE [Sequences].[CustomerKey] RESTART WITH 1
	ALTER SEQUENCE [Sequences].[EmployeeKey] RESTART WITH 1
	ALTER SEQUENCE [Sequences].[LineageKey] RESTART WITH 1
	ALTER SEQUENCE [Sequences].[ProductKey] RESTART WITH 1
END;
GO