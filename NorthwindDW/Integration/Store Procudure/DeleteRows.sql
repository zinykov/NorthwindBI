CREATE PROCEDURE [Integration].[DeleteRows] AS
	
	DELETE FROM [Fact].[Order]

	DELETE FROM [Dimension].[Customer]

	DELETE FROM [Dimension].[Employee]

	DELETE FROM [Dimension].[Product];

GO