CREATE PROCEDURE [Integration].[GetStartDate]
	@TableName AS NVARCHAR(30)
AS BEGIN
    --BEGIN TRY
    --    BEGIN TRANSACTION
	        IF EXISTS ( SELECT 1 FROM [Integration].[Lineage] WHERE [TableName] = @TableName AND [WasSuccessful] = 1 )
		        SELECT StartLoadDate = MAX ( [CutoffTime] ) FROM [Integration].[Lineage] WHERE [TableName] = @TableName AND [WasSuccessful] = 1
	        ELSE SELECT StartLoadDate = DATEFROMPARTS ( 1996, 1, 1 );
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END
