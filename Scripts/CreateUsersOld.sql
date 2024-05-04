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

USE [$(DQS_STAGING_DATA_DatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DQS_STAGING_DATA_ServerName)\RDLexec' )
	BEGIN
		CREATE USER [$(DQS_STAGING_DATA_ServerName)\RDLexec] FOR LOGIN [$(DQS_STAGING_DATA_ServerName)\RDLexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(DQS_STAGING_DATA_ServerName)\RDLexec]
GO

USE [$(LogsDatabaseName)]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(LogsServerName)\RDLexec' )
	BEGIN
		CREATE USER [$(LogsServerName)\RDLexec] FOR LOGIN [$(LogsServerName)\RDLexec]
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