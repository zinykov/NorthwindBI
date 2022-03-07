CREATE PROCEDURE [Integration].[DeleteRows] AS
BEGIN	
	DELETE FROM [Fact].[Order]
	DELETE FROM [Dimension].[Customer]
	DELETE FROM [Dimension].[Employee]
	DELETE FROM [Dimension].[Product]
END;
GO