CREATE PROCEDURE [Integration].[GetLineageKey]
    @TableName AS SYSNAME,
    @CutoffTime AS DATETIME2(7),
    @executionid AS NVARCHAR (50)
AS BEGIN
    --BEGIN TRY
    --    BEGIN TRANSACTION
            SET NOCOUNT ON;
            SET XACT_ABORT ON;

            DECLARE @DataLoadStartedWhen DATETIME2(7) = SYSDATETIME();

            INSERT Integration.Lineage (
                  [DataLoadStarted]
                , [TableName]
                , [DataLoadCompleted]
                , [WasSuccessful]
                , [CutoffTime]
                , [ExecutionId]
            )
            OUTPUT
                inserted.[LineageKey] as LineageKey
            VALUES
                (
                      @DataLoadStartedWhen
                    , @TableName
                    , NULL
                    , 0
                    , @CutoffTime
                    , @executionid
                );
  --      COMMIT TRANSACTION;
  --  END TRY
  --  BEGIN CATCH
  --      ROLLBACK TRANSACTION;
  --      DECLARE @Msg AS NVARCHAR(2048) = FORMATMESSAGE(50002, ERROR_NUMBER(), ERROR_LINE(), ERROR_MESSAGE());
		--THROW 50002, @Msg, 1;
  --  END CATCH
END;