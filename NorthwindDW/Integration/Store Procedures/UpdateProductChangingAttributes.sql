CREATE PROC [Integration].[UpdateProductChangingAttributes]
	  @Product AS NVARCHAR(50)
	, @Category AS NVARCHAR(50)
	, @LineageKey AS INT
	, @ProductAlterKey AS INT
AS BEGIN
    --BEGIN TRY
    --    BEGIN TRANSACTION
			UPDATE [Dimension].[Product] SET [Product] = @Product, [Category] = @Category, [LineageKey] = @LineageKey WHERE [ProductAlterKey] = @ProductAlterKey;
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END