--:setvar AzAgentGroup VSTS_AgentService_G39071
--:setvar DQSDatabaseName DQS_STAGING_DATA
--:setvar DQSServerName SWIFT3
--:setvar DWHDatabaseName NorthwindDW
--:setvar DWHServerName SWIFT3
--:setvar MDSDatabaseName MDS
--:setvar MDSServerName SWIFT3
--:setvar SSISDatabaseName SISSDB
--:setvar SSISEnvironmentName SWIFT3
--:setvar SSISFolderName NorthwindETL
--:setvar SSISProjectName NorthwindETL
--:setvar SSISServerName SWIFT3

USE [$(DWHDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\PBIRSexec' )
	BEGIN
		CREATE USER [$(DWHServerName)\PBIRSexec] FOR LOGIN [$(DWHServerName)\PBIRSexec]
			WITH DEFAULT_SCHEMA=[Reports]
	END
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\DataAnalyst' )
	BEGIN
		CREATE USER [$(DWHServerName)\DataAnalyst] FOR LOGIN [$(DWHServerName)\DataAnalyst]
			WITH DEFAULT_SCHEMA=[Reports]
	END
GO

ALTER ROLE [dwh_user] ADD MEMBER [$(DWHServerName)\PBIRSexec]
GO
ALTER ROLE [dwh_user] ADD MEMBER [$(DWHServerName)\DataAnalyst]
GO

USE [$(DQSDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DQSServerName)\PBIRSexec' )
	BEGIN
		CREATE USER [$(DQSServerName)\PBIRSexec] FOR LOGIN [$(DQSServerName)\PBIRSexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(DQSServerName)\PBIRSexec]
GO

USE [Logs]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\PBIRSexec' )
	BEGIN
		CREATE USER [$(DWHServerName)\PBIRSexec] FOR LOGIN [$(DWHServerName)\PBIRSexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(DWHServerName)\PBIRSexec]
GO

USE [$(MDSDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(MDSServerName)\$(AzAgentGroup)' )
	BEGIN
		CREATE USER [$(MDSServerName)\$(AzAgentGroup)] FOR LOGIN [$(MDSServerName)\$(AzAgentGroup)]
			WITH DEFAULT_SCHEMA=[stg]
	END
GO

GRANT SELECT ON SCHEMA::[stg] TO [$(MDSServerName)\$(AzAgentGroup)]
GO

GRANT EXECUTE ON SCHEMA::[stg] TO [$(MDSServerName)\$(AzAgentGroup)]
GO