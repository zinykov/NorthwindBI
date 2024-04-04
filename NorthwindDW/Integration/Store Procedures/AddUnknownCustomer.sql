CREATE PROCEDURE [Integration].[AddUnknownCustomer]
      @StartDate AS DATE
    , @LineageKey AS INT
AS BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            IF NOT EXISTS ( SELECT 1 FROM [Dimension].[Customer] WHERE [CustomerKey] = -1 )
            INSERT INTO [Dimension].[Customer] (
                  [CustomerKey]
                , [CustomerAlterKey]
                , [Customer]
                , [ContactName]
                , [ContactTitle]
                , [Country]
                , [City]
                , [Phone]
                , [Fax]
                , [StartDate]
                , [EndDate]
                , [Current]
                , [LineageKey]
            ) VALUES (
                  -1
                , 'N/A'
                , 'N/A'
                , 'N/A'
                , NULL
                , NULL
                , NULL
                , NULL
                , NULL
                , @StartDate
                , NULL
                , 1
                , @LineageKey
            );
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		THROW 50002, @Msg, 1;
    END CATCH
END