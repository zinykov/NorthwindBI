CREATE PROC [Integration].[UpdateProductChangingAttributes]
	  @Product AS NVARCHAR(50)
	, @Category AS NVARCHAR(50)
	, @AllAttributes AS NVARCHAR(MAX)
	, @LineageKey AS INT
	, @ProductAlterKey AS INT
AS BEGIN
	UPDATE [Dimension].[Product] SET
		  [Product] = @Product
		, [Category] = @Category
		, [AllAttributes] = @AllAttributes
		, [LineageKey] = @LineageKey
	WHERE [ProductAlterKey] = @ProductAlterKey;
END