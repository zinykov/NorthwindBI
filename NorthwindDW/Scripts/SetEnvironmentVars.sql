:setvar AzAgentGroup VSTS_AgentService_G39071
:setvar BackupFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\"
:setvar DBFilesPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DQSDatabaseName DQS_STAGING_DATA
:setvar DQSServerName SWIFT3
:setvar DWHDatabaseName NorthwindDW
:setvar DWHServerName SWIFT3
:setvar EndLoadDate 1998-01-10
:setvar ExternalFilesPath "C:\SSIS\NorthwindBI\"
:setvar LogsDatabaseName Logs
:setvar LogsServerName SWIFT3
:setvar MDSDatabaseName MDS
:setvar MDSServerName SWIFT3
:setvar RetrainWeeks 3
:setvar SSISDatabaseName SISSDB
:setvar SSISEnvironmentName Release
:setvar SSISFolderName NorthwindBI
:setvar SSISProjectName NorthwindETL
:setvar SSISServerName SWIFT3

DECLARE @reference_id AS BIGINT
EXECUTE	[SSISDB].[catalog].[create_environment_reference]
		  @environment_name = N'$(SSISEnvironmentName)'
		, @reference_id = @reference_id OUTPUT
		, @project_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @reference_type = R
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'CM.OLTP_ADO_NET.Password'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'OLTPNorthwidPassword'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'DBFilesPath'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'DBFilesPath'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'BackupFilesPath'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'BackupFilesPath'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'DQSDatabaseName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'DQSDatabaseName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'DQSServerName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'DQSServerName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'DWHDatabaseName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'DWHDatabaseName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'DWHServerName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'DWHServerName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'ExternalFilesPath'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'ExternalFilesPath'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'MDSDatabaseName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'MDSDatabaseName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'MDSServerName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'MDSServerName'
GO

EXECUTE [SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'XMLCalendarFolder'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'XMLCalendarFolder'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'RetrainWeeks'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'RetrainWeeks'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'LogsDatabaseName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'LogsDatabaseName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'LogsServerName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'LogsServerName'
GO

EXECUTE [SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'EndLoadDate'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'EndLoadDate'
GO