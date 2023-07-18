--:setvar AzAgentGroup VSTS_AgentService_G39071
--:setvar BackupFilesPath "C:\SSIS\NorthwindBI\Backups\"
--:setvar DBFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
--:setvar DQSDatabaseName DQS_STAGING_DATA
--:setvar DQSServerName SWIFT3
--:setvar DWHDatabaseName NorthwindDW
--:setvar DWHServerName SWIFT3
--:setvar LoadDateIncrementalEnd 1998-01-04
--:setvar LoadDateInitialEnd 1997-12-31
--:setvar ExternalFilesPath "C:\SSIS\NorthwindBI\"
--:setvar LogsDatabaseName Logs
--:setvar LogsServerName SWIFT3
--:setvar MDSDatabaseName MDS
--:setvar MDSServerName SWIFT3
--:setvar RetrainWeeks 3
--:setvar SSISDatabaseName SISSDB
--:setvar SSISEnvironmentName Release
--:setvar SSISFolderName NorthwindBI
--:setvar SSISProjectName NorthwindETL
--:setvar SSISServerName SWIFT3
--:setvar XMLCalendarFolder "C:\SSIS\xmlcalendar\"
--:setvar LandingDatabaseName Landing
--:setvar LandingServerName SWIFT3

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

DECLARE @var sql_variant = N'$(DQSDatabaseName)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'DQSDatabaseName'
)
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

DECLARE @var sql_variant = N'$(OLTPNorthwidPassword)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'OLTPNorthwidPassword'
)
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

DECLARE @var sql_variant = N'$(LoadDateIncrementelEnd)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'LoadDateIncrementelEnd'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LoadDateIncrementelEnd'
			, @sensitive=False
			, @description=N''
			, @environment_name=N'$(SSISEnvironmentName)'
			, @folder_name=N'$(SSISFolderName)'
			, @value=@var
			, @data_type=N'DateTime'
END;
GO

DECLARE @var datetime = N'$(LoadDateIncrementalEnd)'
IF NOT EXISTS (
	SELECT 1
	FROM		[catalog].[environment_variables] AS EV
	INNER JOIN	[catalog].[environments] AS E ON E.[environment_id] = EV.[environment_id]
				AND E.[name] = N'$(SSISEnvironmentName)'
	WHERE		EV.[name] = N'LoadDateIncrementalEnd'
)
BEGIN
	EXECUTE	[catalog].[create_environment_variable]
			  @variable_name=N'LoadDateIncrementalEnd'
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