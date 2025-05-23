﻿CREATE PROCEDURE [Integration].[GetLineageKey]
    @TableName AS SYSNAME,
    @CutoffTime AS DATETIME2(7),
    @executionid AS NVARCHAR (50)
AS BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @DataLoadStartedWhen AS DATETIME2(7) = SYSDATETIME();

    INSERT Integration.Lineage (
          [DataLoadStarted]
        , [TableName]
        , [DataLoadCompleted]
        , [WasSuccessful]
        , [CutoffTime]
        , [ExecutionId]
    )
    OUTPUT
        inserted.[LineageKey] AS [LineageKey]
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