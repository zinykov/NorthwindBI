--:setvar AzAgentGroup VSTS_AgentService_G39071
--:setvar BackupFilesPath "C:\Users\zinyk\source\repos\Northwind_BI_Solution\Backup"
--:setvar DBFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
--:setvar DQSDatabaseName DQS_STAGING_DATA
--:setvar DQSServerName SWIFT3
--:setvar DWHDatabaseName NorthwindDW
--:setvar DWHServerName SWIFT3
--:setvar ExternalFilesPath "C:\Users\zinyk\source\repos\Northwind_BI_Solution\"
--:setvar LogsDatabaseName NorthwindLogs
--:setvar LogsServerName SWIFT3
--:setvar MDSDatabaseName MDS
--:setvar MDSServerName SWIFT3
--:setvar RetrainWeeks 3
--:setvar SSISDatabaseName SISSDB
--:setvar SSISEnvironmentName Release
--:setvar SSISFolderName NorthwindBI
--:setvar SSISProjectName NorthwindETL
--:setvar SSISServerName SWIFT3
--:setvar LandingDatabaseName NorthwindLanding
--:setvar LandingServerName SWIFT3

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

ALTER ROLE [UserBI] ADD MEMBER [$(DWHServerName)\RDLexec]
GO

ALTER ROLE [UserBI] ADD MEMBER [$(DWHServerName)\UserBI]
GO

GRANT EXECUTE ON SCHEMA::[Reports] TO [$(DWHServerName)\RDLexec]
GO

USE [$(DQSDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DQSServerName)\RDLexec' )
	BEGIN
		CREATE USER [$(DQSServerName)\RDLexec] FOR LOGIN [$(DQSServerName)\RDLexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(DQSServerName)\RDLexec]
GO

USE [$(LogsDatabaseName)]
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

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(MDSServerName)\$(AzAgentGroup)' )
	BEGIN
		CREATE USER [$(MDSServerName)\$(AzAgentGroup)] FOR LOGIN [$(MDSServerName)\$(AzAgentGroup)]
			WITH DEFAULT_SCHEMA=[stg]
	END
GO

ALTER ROLE [$(AzAgentGroup)] ADD MEMBER [$(MDSServerName)\$(AzAgentGroup)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(MDSServerName)\RDLexec' )
	BEGIN
		CREATE USER [$(MDSServerName)\RDLexec] FOR LOGIN [$(MDSServerName)\RDLexec]
			WITH DEFAULT_SCHEMA=[mdm]
	END
GO

ALTER ROLE [RDLexec] ADD MEMBER [$(MDSServerName)\RDLexec]
GO

USE [$(LandingDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(LandingServerName)\$(AzAgentGroup)' )
	BEGIN
		CREATE USER [$(LandingServerName)\$(AzAgentGroup)] FOR LOGIN [$(LandingServerName)\$(AzAgentGroup)]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(LandingServerName)\$(AzAgentGroup)]
GO

ALTER ROLE [db_datawriter] ADD MEMBER [$(LandingServerName)\$(AzAgentGroup)]
GO