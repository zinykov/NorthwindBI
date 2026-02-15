CREATE PROCEDURE [Integration].[GetPBIRSReportsRegistry]
AS BEGIN
    SET NOCOUNT ON;

    SELECT        [ReportName]
                , [ReportPath]
    FROM        [Integration].[RegistryPBIRSReports]
    WHERE       [IsActive] = 1
                AND [ReportType] = N'PBI'
    ORDER BY    [Priority] ASC;

    SELECT        [ReportName]
                , [ReportPath]
    FROM        [Integration].[RegistryPBIRSReports]
    WHERE       [IsActive] = 1
                AND [ReportType] = N'RDL'
    ORDER BY    [Priority] ASC;
END