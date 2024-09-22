--sqlcmd -S $(DWHServerName) -d $(DWHDatabaseName) -i "$(System.DefaultWorkingDirectory)\_Build solution\drop\$(DWHDatabaseName)\Scripts\CreateRoles.sql" -v AzAgentGroup="$(AzAgentGroup)"
--:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

USE [master];
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[syslogins] WHERE [loginname] = N'$(DWHServerName)\PBIRSexec' )
	BEGIN
		CREATE LOGIN [$(DWHServerName)\PBIRSexec] FROM WINDOWS
	END;
GO

IF NOT EXISTS ( SELECT 1 FROM [sys].[syslogins] WHERE [loginname] = N'$(DWHServerName)\DataAnalyst' )
	BEGIN
		CREATE LOGIN [$(DWHServerName)\DataAnalyst] FROM WINDOWS
	END;
GO