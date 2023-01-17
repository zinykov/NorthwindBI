EXECUTE [SSISDB].[catalog].[create_environment]
	  @environment_name=N'SWIFT3'
	, @environment_description=N''
	, @folder_name=N'20767';
GO

DECLARE @var sql_variant = N'SWIFT3'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'DWHServerName'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'NorthwindDW'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'DWHDatabaseName'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'SWIFT3'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'DQSServerName'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'DQS_STAGING_DATA'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'DQSDatabaseName'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'SWIFT3'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'MDSServerName'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'MDS'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'MDSDatabaseName'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'C:\Users\zinyk\source\repos\Northwind_BI_Solution\NorthwindETL\Northwind Data Profile.xml'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'DataProfilingConnectionString'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'DBFilePath'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'C:\SSIS\NorthwindDW\'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'ExternalFilesPath'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N''
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'OLTPNorthwidPassword'
	, @sensitive=True
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO

DECLARE @var sql_variant = N'C:\SSIS\xmlcalendar'
EXEC [SSISDB].[catalog].[create_environment_variable]
	  @variable_name=N'XMLCalendarFolder'
	, @sensitive=False
	, @description=N''
	, @environment_name=N'SWIFT3'
	, @folder_name=N'20767'
	, @value=@var
	, @data_type=N'String';
GO