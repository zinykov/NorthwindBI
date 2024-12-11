--sqlcmd -S $(SSISServerName) -d $(SSISDatabaseName) -i "$(System.DefaultWorkingDirectory)\_Build solution\drop\Scripts\SetEnvironmentVars.sql" -v  BuildConfiguration="$(BuildConfiguration)" SSISFolderName="$(SSISFolderName)" SSISProjectName="$(SSISProjectName)"
--:r C:\Users\ZinukovD\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

DECLARE @reference_id AS BIGINT
EXECUTE	[SSISDB].[catalog].[create_environment_reference]
		  @environment_name = N'$(BuildConfiguration)'
		, @reference_id = @reference_id OUTPUT
		, @project_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @reference_type = R
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
		, @parameter_name = N'DQS_STAGING_DATA_DatabaseName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'DQS_STAGING_DATA_DatabaseName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'DQS_STAGING_DATA_ServerName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'DQS_STAGING_DATA_ServerName'
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

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'LandingDatabaseName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'LandingDatabaseName'
GO

EXECUTE	[SSISDB].[catalog].[set_object_parameter_value]
		  @object_type = 20
		, @parameter_name = N'LandingServerName'
		, @object_name = N'$(SSISProjectName)'
		, @folder_name = N'$(SSISFolderName)'
		, @project_name = N'$(SSISProjectName)'
		, @value_type = R
		, @parameter_value = N'LandingServerName'
GO

EXECUTE [SSISDB].[catalog].[set_object_parameter_value]
      @object_type=30
    , @parameter_name=N'CutoffTime'
    , @object_name=N'Maintenance copy DatabaseFiles.dtsx'
    , @folder_name=N'$(SSISFolderName)'
    , @project_name=N'$(SSISProjectName)'
    , @value_type=R
    , @parameter_value=N'CutoffTime'
GO

EXECUTE [SSISDB].[catalog].[set_object_parameter_value]
      @object_type=30
    , @parameter_name=N'LoadDateInitialEnd'
    , @object_name=N'Maintenance copy DatabaseFiles.dtsx'
    , @folder_name=N'$(SSISFolderName)'
    , @project_name=N'$(SSISProjectName)'
    , @value_type=R
    , @parameter_value=N'LoadDateInitialEnd'
GO

EXECUTE [SSISDB].[catalog].[set_object_parameter_value]
      @object_type=30
    , @parameter_name=N'CutoffTime'
    , @object_name=N'Transform and load.dtsx'
    , @folder_name=N'$(SSISFolderName)'
    , @project_name=N'$(SSISProjectName)'
    , @value_type=R
    , @parameter_value=N'CutoffTime'
GO

EXECUTE [SSISDB].[catalog].[set_object_parameter_value]
      @object_type=30
    , @parameter_name=N'LoadDateInitialEnd'
    , @object_name=N'Transform and load.dtsx'
    , @folder_name=N'$(SSISFolderName)'
    , @project_name=N'$(SSISProjectName)'
    , @value_type=R
    , @parameter_value=N'LoadDateInitialEnd'
GO