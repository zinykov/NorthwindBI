--sqlcmd -S $(SSISServerName) -d $(SSISDatabaseName) -i "$(System.DefaultWorkingDirectory)\_Build solution\drop\Scripts\CreateEnvironment.sql" -v DBFilesPath="$(DBFilesPath)" DQSDatabaseName="$(DQSDatabaseName)" DQSServerName="$(DQSServerName)" DWHDatabaseName="$(DWHDatabaseName)" DWHServerName="$(DWHServerName)" ExternalFilesPath="$(ExternalFilesPath)" LogsDatabaseName="$(LogsDatabaseName)" LogsServerName="$(LogsServerName)" MDSDatabaseName="$(MDSDatabaseName)" MDSServerName="$(MDSServerName)" OLTPNorthwidPassword="$(OLTPNorthwidPassword)" RetrainWeeks="$(RetrainWeeks)" SSISDatabaseName="$(SSISDatabaseName)" BuildConfiguration="$(BuildConfiguration)" SSISFolderName="$(SSISFolderName)" SSISProjectName="$(SSISProjectName)" SSISServerName="$(SSISServerName)" XMLCalendarFolder="$(XMLCalendarFolder)" LandingDatabaseName="$(LandingDatabaseName)" LandingServerName="$(LandingServerName)" CutoffTime="$(CutoffTime)" LoadDateInitialEnd="$(LoadDateInitialEnd)"
--:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

IF NOT EXISTS ( SELECT 1 FROM [catalog].[folders] WHERE [name] = N'$(SSISFolderName)' )
BEGIN
	DECLARE @folder_id BIGINT
	EXECUTE	[catalog].[create_folder]
			  @folder_name = N'$(SSISFolderName)'
			, @folder_id = @folder_id OUTPUT
END;
GO

IF NOT EXISTS ( SELECT 1 FROM [catalog].[environments] WHERE [name] = N'$(BuildConfiguration)' )
BEGIN
	EXECUTE [catalog].[create_environment]
		  @environment_name = N'$(BuildConfiguration)'
		, @environment_description = N''
		, @folder_name = N'$(SSISFolderName)'
END;
GO

DECLARE @var sql_variant = N'$(DWHServerName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'DWHServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DWHServerName'
			, @sensitive=False
			, @description=N'Name of Data Warehouse server'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'DWHDatabaseName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DWHDatabaseName'
			, @sensitive=False
			, @description=N'Name of Data Warehouse database'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'DQS_STAGING_DATA_ServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DQS_STAGING_DATA_ServerName'
			, @sensitive=False
			, @description=N'Name of server with staging database where writing data after DQS cleansing'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'DQS_STAGING_DATA_DatabaseName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DQS_STAGING_DATA_DatabaseName'
			, @sensitive=False
			, @description=N'Name of staging database where writing data after DQS cleansing'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'DQSServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DQSServerName'
			, @sensitive=False
			, @description=N'Name of Data Quality Server'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'MDSServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'MDSServerName'
			, @sensitive=False
			, @description=N'Name of server with database used for Master data services'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'MDSDatabaseName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'MDSDatabaseName'
			, @sensitive=False
			, @description=N'Name of database used for Master data services catalog'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'DBFilesPath'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'DBFilesPath'
			, @sensitive=False
			, @description=N'Default path for new database files which are created in fact load packages'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'ExternalFilesPath'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'ExternalFilesPath'
			, @sensitive=False
			, @description=N'A file system location for saving data from data sources that don’t use SQL table as destination, logs files (SSIS log provider for Text files & Xevents trace files), CSV staging files, SQL scripts (needed for CI/CD), test results (needed for CI/CD)'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'XMLCalendarFolder'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
	  @variable_name=N'XMLCalendarFolder'
	, @sensitive=False
	, @description=N'Path to local repository of xmlcalendar project'
	, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'LogsServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LogsServerName'
			, @sensitive=False
			, @description=N'Name of server with database used for storing SSIS logs and Data Warehouse metadata'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'LogsDatabaseName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LogsDatabaseName'
			, @sensitive=False
			, @description=N'Name of database used for storing SSIS logs and Data Warehouse metadata'
			, @environment_name=N'$(BuildConfiguration)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var sql_variant = N'$(LandingServerName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'LandingServerName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LandingServerName'
			, @sensitive=False
			, @description=N'Name of server used for raw data from data sources'
			, @environment_name=N'$(BuildConfiguration)'
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
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'LandingDatabaseName'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LandingDatabaseName'
			, @sensitive=False
			, @description=N'Name of database used for storing SSIS logs and Data Warehouse metadata'
			, @environment_name=N'$(BuildConfiguration)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'String'
END;
GO

DECLARE @var datetime;
IF ( N'$(BuildConfiguration)' <> N'Release' ) SET @var = N'$(CutoffTime)';
ELSE SET @var = DATETIMEFROMPARTS ( 1995, 1, 1, 0, 0, 0, 0 );

IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'CutoffTime'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'CutoffTime'
			, @sensitive=False
			, @description=N'The cutoff date for the current incremental load. If the date specified is 1995-01-01, the default value (02:00:00 AM of the current date) is used.'
			, @environment_name=N'$(BuildConfiguration)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'DateTime'
END;
GO

DECLARE @var datetime;
IF ( N'$(BuildConfiguration)' <> N'Release' ) SET @var = N'$(LoadDateInitialEnd)';
ELSE SET @var = DATETIMEFROMPARTS ( 1995, 1, 1, 0, 0, 0, 0 );

IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(BuildConfiguration)'
	WHERE		EV.[name] = N'LoadDateInitialEnd'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LoadDateInitialEnd'
			, @sensitive=False
			, @description=N'Latest cutoff date for initial data load. The default value is 1995-01-01.'
			, @environment_name=N'$(BuildConfiguration)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'DateTime'
END;
GO