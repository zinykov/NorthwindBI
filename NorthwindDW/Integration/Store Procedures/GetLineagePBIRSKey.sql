CREATE PROCEDURE [Integration].[GetLineagePBIRSKey]
    @ReportName  AS SYSNAME,
    @ReportPath  AS NVARCHAR(255),
    @ReportType  AS NVARCHAR(10),
    @executionid AS NVARCHAR(50)
AS BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @RefreshStartedWhen AS DATETIME2(7) = SYSDATETIME();

    INSERT [Integration].[LineagePBIRS] (
        [RefreshStarted]
        , [ReportName]
        , [ReportPath]
        , [ReportType]
        , [RefreshCompleted]
        , [WasSuccessful]
        , [ExecutionId]
    )
    OUTPUT
        inserted.[LineageKey] AS [LineageKey]
    VALUES
        (
        @RefreshStartedWhen
        , @ReportName
        , @ReportPath
        , @ReportType
        , NULL
        , 0 -- По умолчанию False, пока не подтвердим успех
        , @executionid
        );
END;