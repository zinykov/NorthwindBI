--sqlcmd -S $(SSISServerName) -d $(SSISDatabaseName) -i "$(System.DefaultWorkingDirectory)\_Build solution\drop\Scripts\CreateEnvironment.sql" -v BackupFilesPath="$(BackupFilesPath)" DBFilesPath="$(DBFilesPath)" DQSDatabaseName="$(DQSDatabaseName)" DQSServerName="$(DQSServerName)" DWHDatabaseName="$(DWHDatabaseName)" DWHServerName="$(DWHServerName)" ExternalFilesPath="$(ExternalFilesPath)" LogsDatabaseName="$(LogsDatabaseName)" LogsServerName="$(LogsServerName)" MDSDatabaseName="$(MDSDatabaseName)" MDSServerName="$(MDSServerName)" OLTPNorthwidPassword="$(OLTPNorthwidPassword)" RetrainWeeks="$(RetrainWeeks)" SSISDatabaseName="$(SSISDatabaseName)" SSISEnvironmentName="$(SSISEnvironmentName)" SSISFolderName="$(SSISFolderName)" SSISProjectName="$(SSISProjectName)" SSISServerName="$(SSISServerName)" XMLCalendarFolder="$(XMLCalendarFolder)" LandingDatabaseName="$(LandingDatabaseName)" LandingServerName="$(LandingServerName)" CutoffTime="$(CutoffTime)" LoadDateInitialEnd="$(LoadDateInitialEnd)"
--:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'DWHServerName'
)
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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'DWHDatabaseName'
)
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

DECLARE @var sql_variant = N'$(DQS_STAGING_DATA_ServerName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'DQS_STAGING_DATA_ServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DQS_STAGING_DATA_ServerName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(DQS_STAGING_DATA_DatabaseName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'DQS_STAGING_DATA_DatabaseName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DQS_STAGING_DATA_DatabaseName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(DQSServerName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'DQSServerName'
)
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

DECLARE @var sql_variant = N'$(MDSServerName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'MDSServerName'
)
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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'MDSDatabaseName'
)
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

DECLARE @var sql_variant = N'$(DBFilesPath)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'DBFilesPath'
)
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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'BackupFilesPath'
)
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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'ExternalFilesPath'
)
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

DECLARE @var sql_variant = N'$(XMLCalendarFolder)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'XMLCalendarFolder'
)
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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'LogsServerName'
)
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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'LogsDatabaseName'
)
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
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'RetrainWeeks'
)
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

DECLARE @var sql_variant = N'$(LandingServerName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'LandingServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LandingServerName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(LandingDatabaseName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'LandingDatabaseName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LandingDatabaseName'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var datetime = N'$(CutoffTime)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'CutoffTime'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'CutoffTime'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'DateTime'
END;
GO

DECLARE @var datetime = N'$(LoadDateInitialEnd)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'LoadDateInitialEnd'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LoadDateInitialEnd'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'DateTime'
END;
GO