::setvar AzAgentGroup VSTS_AgentService_G39071
::setvar BackupFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\"
::setvar DBFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
::setvar DQSDatabaseName DQS_STAGING_DATA
::setvar DQSServerName SWIFT3
::setvar DWHDatabaseName NorthwindDW
::setvar DWHServerName SWIFT3
::setvar EndLoadDate "1998-01-10"
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
::setvar XMLCalendarFolder "C:\SSIS\xmlcalendar\"
sqlcmd -S $(SSISServerName) -d $(SSISDatabaseName) -i "$(System.DefaultWorkingDirectory)\_Build solution\drop\$(DWHDatabaseName)\Scripts\CreateEnvironment.sql" -v BackupFilesPath="$(BackupFilesPath)" DBFilesPath="$(DBFilesPath)" DQSDatabaseName="$(DQSDatabaseName)" DQSServerName="$(DQSServerName)" DWHDatabaseName="$(DWHDatabaseName)" DWHServerName="$(DWHServerName)" EndLoadDate="$(EndLoadDate)" ExternalFilesPath="$(ExternalFilesPath)" LogsDatabaseName="$(LogsDatabaseName)" LogsServerName="$(LogsServerName)" MDSDatabaseName="$(MDSDatabaseName)" MDSServerName="$(MDSServerName)" OLTPNorthwidPassword="$(OLTPNorthwidPassword)" RetrainWeeks="$(RetrainWeeks)" SSISDatabaseName="$(SSISDatabaseName)" SSISEnvironmentName="$(SSISEnvironmentName)" SSISFolderName="$(SSISFolderName)" SSISProjectName="$(SSISProjectName)" SSISServerName="$(SSISServerName)" XMLCalendarFolder="$(XMLCalendarFolder)"