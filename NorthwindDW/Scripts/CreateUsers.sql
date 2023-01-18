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

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\RDLexec' )
	BEGIN
		CREATE USER [$(DWHServerName)\RDLexec] FOR LOGIN [$(DWHServerName)\RDLexec]
			WITH DEFAULT_SCHEMA=[Reports]
	END
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\UserBI' )
	BEGIN
		CREATE USER [$(DWHServerName)\UserBI] FOR LOGIN [$(DWHServerName)\UserBI]
			WITH DEFAULT_SCHEMA=[Reports]
	END
GO

ALTER ROLE [dwh_user] ADD MEMBER [$(DWHServerName)\RDLexec]
GO
ALTER ROLE [dwh_user] ADD MEMBER [$(DWHServerName)\UserBI]
GO

USE [$(DQSDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\RDLexec' )
	BEGIN
		CREATE USER [$(DWHServerName)\RDLexec] FOR LOGIN [$(DWHServerName)\RDLexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(DWHServerName)\RDLexec]
GO

USE [$(MDSDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\$(AzAgentGroup)' )
	BEGIN
		CREATE USER [$(DWHServerName)\$(AzAgentGroup)] FOR LOGIN [$(DWHServerName)\$(AzAgentGroup)]
			WITH DEFAULT_SCHEMA=[stg]
	END
GO

GRANT SELECT ON SCHEMA::[stg] TO [$(DWHServerName)\$(AzAgentGroup)]
GO

GRANT EXECUTE ON SCHEMA::[stg] TO [$(DWHServerName)\$(AzAgentGroup)]
GO

--USE [Logs]
--GO

--IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\RDLexec' )
--	BEGIN
--		CREATE USER [$(DWHServerName)\RDLexec] FOR LOGIN [$(DWHServerName)\RDLexec]
--	END
--GO

--ALTER ROLE [db_datareader] ADD MEMBER [$(DWHServerName)\RDLexec]
--GO