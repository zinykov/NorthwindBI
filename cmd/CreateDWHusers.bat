::setvar AzAgentGroup VSTS_AgentService_G39071
::setvar BackupFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\"
::setvar DBFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
::setvar DQSDatabaseName DQS_STAGING_DATA
::setvar DQSServerName SWIFT3
::setvar DWHDatabaseName NorthwindDW
::setvar DWHServerName SWIFT3
::setvar ExternalFilesPath "C:\SSIS\NorthwindBI\"
::setvar LogsDatabaseName Logs
::setvar LogsServerName SWIFT3
::setvar MDSDatabaseName MDS
::setvar MDSServerName SWIFT3
::setvar RetrainWeeks 3
::setvar SSISDatabaseName SISSDB
::setvar SSISEnvironmentName SWIFT3
::setvar SSISFolderName NorthwindETL
::setvar SSISProjectName NorthwindETL
::setvar SSISServerName SWIFT3
sqlcmd -S $(DWHServerName) -d $(DWHDatabaseName) -i "$(System.DefaultWorkingDirectory)\_Build solution\drop\$(DWHDatabaseName)\Scripts\CreateUsers.sql" -v DWHServerName=$(DWHServerName) AzAgentGroup=$(AzAgentGroup)