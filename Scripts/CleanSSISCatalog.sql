--:setvar AzAgentGroup VSTS_AgentService_G39071
--:setvar BackupFilesPath "C:\SSIS\NorthwindBI\Backups\"
--:setvar DBFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
--:setvar DQSDatabaseName DQS_STAGING_DATA
--:setvar DQSServerName SWIFT3
--:setvar DWHDatabaseName NorthwindDW
--:setvar DWHServerName SWIFT3
--:setvar LoadDateIncrementalEnd 1998-05-06
--:setvar LoadDateInitialEnd 1997-12-31
--:setvar ExternalFilesPath "C:\SSIS\NorthwindBI\"
--:setvar LogsDatabaseName Logs
--:setvar LogsServerName SWIFT3
--:setvar MDSDatabaseName MDS
--:setvar MDSServerName SWIFT3
--:setvar RetrainWeeks 3
--:setvar SSISDatabaseName SISSDB
--:setvar SSISEnvironmentName Release
--:setvar SSISFolderName NorthwindBI
--:setvar SSISProjectName NorthwindETL
--:setvar SSISServerName SWIFT3
--:setvar XMLCalendarFolder "C:\SSIS\xmlcalendar\"
--:setvar LandingDatabaseName Landing
--:setvar LandingServerName SWIFT3

EXECUTE [catalog].[delete_project] @project_name=N'$(SSISProjectName)', @folder_name=N'$(SSISFolderName)';
GO

EXECUTE [catalog].[delete_environment] @folder_name=N'$(SSISFolderName)', @environment_name=N'$(SSISEnvironmentName)';
GO

EXECUTE [catalog].[delete_folder] @folder_name=N'$(SSISFolderName)';
GO