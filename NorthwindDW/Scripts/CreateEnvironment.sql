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
--:setvar SSISEnvironmentName SWIFT3
--:setvar SSISFolderName NorthwindETL
--:setvar SSISProjectName NorthwindETL
--:setvar SSISServerName SWIFT3

IF NOT EXISTS ( SELECT 1 FROM [catalog].[folders] WHERE [name] = N'$(SSISFolderName)' )
BEGIN
	DECLARE @folder_id BIGINT
	EXECUTE	[catalog].[create_folder]
			  @folder_name = N'$(SSISFolderName)'
			, @folder_id = @folder_id OUTPUT
END;
GO

IF NOT EXISTS ( SELECT 1 FROM [catalog].[environments] WHERE [name] = N'$(SSISEnvironmentName)' )
BEGIN
	EXECUTE [catalog].[create_environment]
		  @environment_name = N'$(SSISEnvironmentName)'
		, @environment_description = N''
		, @folder_name = N'$(SSISFolderName)'
END;
GO

DECLARE @var sql_variant = N'$(DWHServerName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'DWHServerName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DWHServerName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(DWHDatabaseName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'DWHDatabaseName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DWHDatabaseName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(DQSServerName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'DQSServerName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DQSServerName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(DQSDatabaseName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'DQSDatabaseName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DQSDatabaseName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(MDSServerName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'MDSServerName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'MDSServerName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(MDSDatabaseName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'MDSDatabaseName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'MDSDatabaseName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(ExternalFilesPath)\Northwind Data Profile.xml'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'DataProfilingConnectionString' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DataProfilingConnectionString'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(DBFilesPath)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'DBFilesPath' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DBFilesPath'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(BackupFilesPath)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'BackupFilesPath' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'BackupFilesPath'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(ExternalFilesPath)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'ExternalFilesPath' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'ExternalFilesPath'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(OLTPNorthwidPassword)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'OLTPNorthwidPassword' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'OLTPNorthwidPassword'
			, @sensitive=True
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'C:\SSIS\xmlcalendar'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'XMLCalendarFolder' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
	  @variable_name=N'XMLCalendarFolder'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'$(SSISEnvironmentName)'
	, @folder_name=N'$(SSISFolderName)'
	, @value=@var
	, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(LogsServerName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'LogsServerName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LogsServerName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(LogsDatabaseName)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'LogsDatabaseName' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LogsDatabaseName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO



DECLARE @var smallint = N'$(RetrainWeeks)'
IF NOT EXISTS ( SELECT 1 FROM [catalog].[environment_variables] WHERE [name] = N'RetrainWeeks' )
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'RetrainWeeks'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'Int16'
END;
GO