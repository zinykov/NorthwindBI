CREATE PROCEDURE [Reports].[UpsertRegistryPBIRSReports]
      @ReportName   SYSNAME
    , @ReportPath   NVARCHAR(255)
    , @ReportType   NVARCHAR(3)
    , @IsActive     BIT = 1
    , @Priority     INT = 10
WITH EXECUTE AS OWNER
AS BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    MERGE
        INTO [Integration].[RegistryPBIRSReports] AS TRG
        USING (
            SELECT    @ReportName AS [ReportName]
                    , @ReportPath AS [ReportPath]
                    , @ReportType AS [ReportType]
                    , @IsActive AS [IsActive]
                    , @Priority AS [Priority]
        ) AS SRC ON TRG.[ReportPath] = SRC.[ReportPath]
        WHEN MATCHED THEN UPDATE SET
              [ReportName] = SRC.[ReportName]
            , [ReportType] = SRC.[ReportType]
            , [Priority]   = SRC.[Priority]
            , [IsActive]   = @IsActive
        WHEN NOT MATCHED BY TARGET THEN INSERT (
              [ReportName]
            , [ReportPath]
            , [ReportType]
            , [IsActive]
            , [Priority]
        ) VALUES (
              SRC.[ReportName]
            , SRC.[ReportPath]
            , SRC.[ReportType]
            , SRC.[IsActive]
            , SRC.[Priority]
        );

    PRINT '   - Report registered: ' + @ReportName + ' ( ' + @ReportType + ' )';
END;
GO