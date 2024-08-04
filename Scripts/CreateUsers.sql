--:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

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

GRANT SELECT ON sys.sql_expression_dependencies TO [dwh_user];
GO

ALTER ROLE [dwh_user] ADD MEMBER [$(DWHServerName)\PBIRSexec]
GO
ALTER ROLE [dwh_user] ADD MEMBER [$(DWHServerName)\DataAnalyst]
GO

USE [$(DQS_STAGING_DATA_DatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DQS_STAGING_DATA_ServerName)\PBIRSexec' )
	BEGIN
		CREATE USER [$(DQS_STAGING_DATA_ServerName)\PBIRSexec] FOR LOGIN [$(DQS_STAGING_DATA_ServerName)\PBIRSexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(DQS_STAGING_DATA_ServerName)\PBIRSexec]
GO

USE [$(LogsDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(LogsServerName)\PBIRSexec' )
	BEGIN
		CREATE USER [$(LogsServerName)\PBIRSexec] FOR LOGIN [$(LogsServerName)\PBIRSexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(LogsServerName)\PBIRSexec]
GO

USE [$(MDSDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(MDSServerName)\PBIRSexec' )
	BEGIN
		CREATE USER [$(MDSServerName)\PBIRSexec] FOR LOGIN [$(MDSServerName)\PBIRSexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [RDLexec] ADD MEMBER [$(MDSServerName)\PBIRSexec];
GO

USE [$(LandingDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(LandingServerName)\PBIRSexec' )
	BEGIN
		CREATE USER [$(LandingServerName)\PBIRSexec] FOR LOGIN [$(LandingServerName)\PBIRSexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(LandingServerName)\PBIRSexec]
GO