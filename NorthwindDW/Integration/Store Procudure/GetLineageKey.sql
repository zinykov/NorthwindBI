CREATE PROCEDURE [Integration].[GetLineageKey]
    @TableName AS SYSNAME,
    @CutoffTime AS DATETIME2(7),
    @executionid AS NVARCHAR (50)
    WITH EXECUTE AS OWNER
AS
BEGIN
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
END;