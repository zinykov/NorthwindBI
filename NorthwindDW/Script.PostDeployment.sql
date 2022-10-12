/*
Шаблон скрипта после развертывания							
--------------------------------------------------------------------------------------
 В данном файле содержатся инструкции SQL, которые будут добавлены в скрипт построения.		
 Используйте синтаксис SQLCMD для включения файла в скрипт после развертывания.			
 Пример:      :r .\myfile.sql								
 Используйте синтаксис SQLCMD для создания ссылки на переменную в скрипте после развертывания.		
 Пример:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
ALTER DATABASE [$(DatabaseName)]
    MODIFY FILEGROUP [Default_FG] DEFAULT;
GO

GRANT SELECT ON SCHEMA::[Reports] TO [dwh_user];  
GO

GRANT EXECUTE ON SCHEMA::[Reports] TO [dwh_user];  
GO

IF NOT EXISTS ( SELECT 1 FROM sys.resource_governor_resource_pools WHERE [name] = N'High Priority' )
    CREATE RESOURCE POOL [High Priority]
        WITH (
              min_cpu_percent       = 20
            , max_cpu_percent       = 90
            , min_memory_percent    = 50
            , max_memory_percent    = 90
            , min_iops_per_volume   = 50
            , max_iops_per_volume   = 100
        );
GO

IF NOT EXISTS ( SELECT 1 FROM sys.resource_governor_resource_pools WHERE [name] = N'Low Priority' )
    CREATE RESOURCE POOL [Low Priority]
        WITH (
              min_cpu_percent       = 0
            , max_cpu_percent       = 50
            , min_memory_percent    = 0
            , max_memory_percent    = 50
            , min_iops_per_volume   = 0
            , max_iops_per_volume   = 20
        );
GO

IF NOT EXISTS ( SELECT 1 FROM sys.resource_governor_workload_groups WHERE [name] = N'User Queries' )
    CREATE WORKLOAD GROUP [User Queries]
	    WITH (
		      group_max_requests                = 10
		    , importance                        = Low
		    , request_max_cpu_time_sec          = 50
		    , request_max_memory_grant_percent  = 50
		    , request_memory_grant_timeout_sec  = 20
		    , max_dop                           = 1
	    )
	    USING [Low Priority];
GO

IF NOT EXISTS ( SELECT 1 FROM sys.resource_governor_workload_groups WHERE [name] = N'ETL' )
    CREATE WORKLOAD GROUP [ETL]
        WITH (
              group_max_requests                = 100
            , importance                        = High
            , request_max_cpu_time_sec          = 80
            , request_max_memory_grant_percent  = 80
            , request_memory_grant_timeout_sec  = 30
            , max_dop                           = 4
        )
        USING [High Priority];
GO

USE [master];
GO

IF NOT EXISTS ( SELECT 1 FROM sys.objects WHERE type = 'FN' AND name = 'fn_classify_apps' )
    EXECUTE SQL 'CREATE FUNCTION [dbo].[fn_classify_apps]() RETURNS sysname
	    WITH SCHEMABINDING
    AS BEGIN
	    DECLARE @retval sysname

	    IF (
		    APP_NAME () LIKE ''%SQL Server%'' 
		    AND USER_NAME () IN ( ''SWIFT3\AzPipelineAgent'',''SWIFT3\SQLAGENT'',''SWIFT3\RDLexec'' )
		    AND DAY ( GETDATE () ) = 1 
		    AND DATEPART ( HOUR, GETDATE () ) BETWEEN 1 AND 2
	    )
		    SET @retval = ''ETL'';
	    ELSE
		    SET @retval = ''User Queries'';
	
	    RETURN @retval;
    END
    
    ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = dbo.fn_classify_apps);
    ALTER RESOURCE GOVERNOR RECONFIGURE;'
GO