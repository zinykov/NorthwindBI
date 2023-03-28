--:setvar AzAgentGroup VSTS_AgentService_G39071
--:setvar BackupFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\"
--:setvar DBFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
--:setvar DQSDatabaseName DQS_STAGING_DATA
--:setvar DQSServerName SWIFT3
--:setvar DWHDatabaseName NorthwindDW
--:setvar DWHServerName SWIFT3
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
--:setvar LandingDatabaseName Landing
--:setvar LandingServerName SWIFT3

USE [$(MDSDatabaseName)]
GO

IF NOT EXISTS (
				SELECT      1
				FROM        [sys].[database_role_members] AS DBRM
				INNER JOIN  [sys].[database_principals] AS R
							ON DBRM.[role_principal_id] = R.[principal_id]
				WHERE       R.[name] = '$(AzAgentGroup)'
)
	BEGIN
		CREATE ROLE [$(AzAgentGroup)] AUTHORIZATION [dbo]
	END
GO

GRANT SELECT ON SCHEMA::[stg] TO [$(AzAgentGroup)]
GO

GRANT EXECUTE ON SCHEMA::[stg] TO [$(AzAgentGroup)]
GO

IF NOT EXISTS (
				SELECT      1
				FROM        [sys].[database_role_members] AS DBRM
				INNER JOIN  [sys].[database_principals] AS R
							ON DBRM.[role_principal_id] = R.[principal_id]
				WHERE       R.[name] = 'RDLexec'
)
	BEGIN
		CREATE ROLE [RDLexec] AUTHORIZATION [dbo]
	END
GO

GRANT SELECT ON [mdm].[MasterCustomer] TO [RDLexec]
GO

GRANT SELECT ON [mdm].[MasterEmployee] TO [RDLexec]
GO

GRANT SELECT ON [mdm].[MasterHolidays] TO [RDLexec]
GO

GRANT SELECT ON [mdm].[MasterProduct] TO [RDLexec]
GO

GRANT SELECT ON SCHEMA::[stg] TO [RDLexec]
GO