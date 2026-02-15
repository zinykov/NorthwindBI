PRINT 'Processing PBIRS Reports Registry...';

EXEC [Reports].[UpsertRegistryPBIRSReports] 
      @ReportName = 'Sales Analytics'
    , @ReportPath = '/sales/SalesV3'
    , @ReportType = 'PBI'
    , @Priority   = 10;