--:setvar DomainName N-MSC-478

IF NOT EXISTS ( SELECT 1 FROM sys.resource_governor_resource_pools WHERE [name] = N'High Priority' )
    CREATE RESOURCE POOL [High Priority]
        WITH (
              min_cpu_percent       = 20
            , max_cpu_percent       = 90
            , min_memory_percent    = 20
            , max_memory_percent    = 90
            , min_iops_per_volume   = 65536
            , max_iops_per_volume   = 0
        );
ELSE
    ALTER RESOURCE POOL [High Priority]
        WITH (
              min_cpu_percent       = 20
            , max_cpu_percent       = 90
            , min_memory_percent    = 20
            , max_memory_percent    = 90
            , min_iops_per_volume   = 65536
            , max_iops_per_volume   = 0
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
            , max_iops_per_volume   = 65536
        );
ELSE
    ALTER RESOURCE POOL [Low Priority]
        WITH (
              min_cpu_percent       = 0
            , max_cpu_percent       = 50
            , min_memory_percent    = 0
            , max_memory_percent    = 50
            , min_iops_per_volume   = 0
            , max_iops_per_volume   = 65536
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
ELSE
    ALTER WORKLOAD GROUP [User Queries]
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
ELSE
    ALTER WORKLOAD GROUP [ETL]
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

ALTER RESOURCE GOVERNOR WITH ( CLASSIFIER_FUNCTION = NULL );
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO

CREATE OR ALTER FUNCTION [dbo].[fn_classify]() RETURNS sysname
    WITH SCHEMABINDING
AS BEGIN
	DECLARE @retval sysname

	IF (
		--APP_NAME () LIKE '%SQL Server%' AND 
        USER_NAME () IN (
              'dbo'
            , '$(DomainName)\AzPipelineAgent'
            , '$(DomainName)\SQLAGENT'
            , '$(DomainName)\RDLexec'
            , '$(DomainName)\ZinukovD'
        )
		--AND DATEPART ( HOUR, GETDATE () ) BETWEEN 0 AND 8
	)
		SET @retval = 'ETL';
	ELSE
		SET @retval = 'User Queries';
	
	RETURN @retval;
END
GO

ALTER RESOURCE GOVERNOR WITH ( CLASSIFIER_FUNCTION = dbo.fn_classify );
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO