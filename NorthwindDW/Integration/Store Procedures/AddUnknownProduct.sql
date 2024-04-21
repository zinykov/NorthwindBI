CREATE PROCEDURE [Integration].[AddUnknownProduct]
      @StartDate AS DATE
    , @LineageKey AS INT
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Product] WHERE [ProductKey] = -1 )
            INSERT INTO [Dimension].[Product] (
                  [ProductKey]
                , [ProductAlterKey]
                , [Product]
                , [Category]
                , [LineageKey]
            ) VALUES (
                  -1
                , -1
                , 'N/A'
                , 'N/A'
                , @LineageKey
            )
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END