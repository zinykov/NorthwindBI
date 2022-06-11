CREATE PROCEDURE Integration.GetLineageKey
    @TableName      SYSNAME,
    @NewCutoffTime  DATETIME2(7)
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
    )
    OUTPUT
        inserted.[LineageKey] as LineageKey
    VALUES
        (
              @DataLoadStartedWhen
            , @TableName
            , NULL
            , 0
            , @NewCutoffTime
        );
END;