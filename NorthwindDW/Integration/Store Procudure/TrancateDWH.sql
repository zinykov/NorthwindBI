CREATE PROCEDURE [Integration].[TrancateDWH] AS
BEGIN	
	DELETE FROM [Fact].[Order]
	DELETE FROM [Staging].[Order]
	DELETE FROM [Dimension].[Customer]
	DELETE FROM [Dimension].[Employee]
	DELETE FROM [Dimension].[Product]
	DELETE FROM [Dimension].[Date]
END;
GO