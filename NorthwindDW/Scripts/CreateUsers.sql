--:setvar DWHServerName SWIFT3
--:setvar AzAgentGroup VSTS_AgentService_G39071

USE [NorthwindDW]
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

USE [DQS_STAGING_DATA]
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[sysusers] WHERE [name] = '$(DWHServerName)\RDLexec' )
	BEGIN
		CREATE USER [$(DWHServerName)\RDLexec] FOR LOGIN [$(DWHServerName)\RDLexec]
			WITH DEFAULT_SCHEMA=[dbo]
	END
GO

ALTER ROLE [db_datareader] ADD MEMBER [$(DWHServerName)\RDLexec]
GO

USE [MDS]
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