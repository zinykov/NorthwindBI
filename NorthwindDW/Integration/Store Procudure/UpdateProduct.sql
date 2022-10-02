CREATE PROC [Integration].[UpdateProductChangingAttributes]
	  @Product AS NVARCHAR(50)
	, @Category AS NVARCHAR(50)
	, @LineageKey AS INT
	, @ProductAlterKey AS INT
AS
BEGIN
	UPDATE [Dimension].[Product] SET [Product] = @Product, [Category] = @Category, [LineageKey] = @LineageKey WHERE [ProductAlterKey] = @ProductAlterKey
END