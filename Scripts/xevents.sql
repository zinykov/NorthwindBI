:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

--DECLARE @FilePath AS NVARCHAR(260) = N'$(ExternalFilesPath)\Monitoring\XeventsSessions\Monitor Data Warehouse Query Activity.xel';

--USE [NorthwindDW];

--IF NOT EXISTS ( SELECT 1 FROM sys.server_event_sessions WHERE [name] = 'Monitor Data Warehouse Query Activity' )
--BEGIN
--	CREATE EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER 
--		ADD EVENT [sqlserver].[sql_batch_completed] (
--			SET collect_batch_text = (1)
--			ACTION	(
--						  [sqlserver].[client_app_name]
--						, [sqlserver].[database_id]
--						, [sqlserver].[database_name]
--						, [sqlserver].[nt_username]
--						, [sqlserver].[server_principal_name]
--						, [sqlserver].[session_id]
--					)
--			WHERE	( [sqlserver].[like_i_sql_unicode_string] ( [sqlserver].[database_name], N'%Northwind%' ) )
--		),
--		ADD EVENT [sqlserver].[sql_statement_completed] (
--			ACTION	(
--						  [sqlserver].[client_app_name]
--						, [sqlserver].[database_id]
--						, [sqlserver].[database_name]
--						, [sqlserver].[nt_username]
--						, [sqlserver].[server_principal_name]
--						, [sqlserver].[session_id]
--					)
--			WHERE	( [sqlserver].[like_i_sql_unicode_string] ( [sqlserver].[database_name], N'%Northwind%' ) )
--		),
--		ADD EVENT [sqlserver].[rpc_completed] (
--			SET		collect_data_stream = (1)
--			ACTION	(
--						  [sqlserver].[client_app_name]
--						, [sqlserver].[database_id]
--						, [sqlserver].[database_name]
--						, [sqlserver].[nt_username]
--						, [sqlserver].[server_principal_name]
--						, [sqlserver].[session_id]
--					)
--			WHERE	[sqlserver].[like_i_sql_unicode_string] ( [sqlserver].[database_name], N'%Northwind%' )
--		)
--		ADD TARGET [package0].[event_file] ( SET filename = N'Monitor Data Warehouse Query Activity' )
--		WITH	(
--					  MAX_MEMORY = 4096 KB
--					, EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS
--					, MAX_DISPATCH_LATENCY = 30 SECONDS
--					, MAX_EVENT_SIZE = 0 KB
--					, MEMORY_PARTITION_MODE = NONE
--					, TRACK_CAUSALITY = ON
--					, STARTUP_STATE = OFF
--				)
--END;

--ALTER EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER
--    STATE = START;

--USE [NorthwindDW];

--SELECT        C.[name]
--            ,  COUNT(*) AS [Count-Per-Column-Repeated-Name]
--FROM        sys.syscolumns AS C
--INNER JOIN  sys.sysobjects AS O ON O.[id] = C.[id]
--WHERE       O.[type] = 'V'
--            AND C.[name] LIKE N'%event%'
--GROUP BY    C.[name]
--HAVING      COUNT(*) >= 3
--ORDER BY    C.[name];

--SELECT        C.[name]
--            ,  COUNT(*) AS [Count-Per-Column-Repeated-Name]
--FROM        sys.syscolumns AS C
--INNER JOIN  sys.sysobjects AS O ON O.[id] = C.[id]
--WHERE       O.[type] = 'V'
--            AND C.[name] LIKE N'%event%'
--GROUP BY    C.[name]
--HAVING      COUNT(*) >= 2
--ORDER BY    C.[name];

--ALTER EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER
--    STATE = STOP;

SELECT        CAST ( [event_data] AS xml ).value('(/event[@name="sql_statement_completed"]/data[@name="statement"]/value)[1]', 'NVARCHAR(MAX)') AS [statement]
FROM        sys.fn_xe_file_target_read_file(
                N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log\Monitor Data Warehouse Query Activity_0_133772117223190000.xel'
              , null
              , null
              , null
            );
SELECT        CAST ( [event_data] AS xml )--.value('(/event[@name="sql_batch_completed"]/data[@name="batch_text"]/value)[1]', 'NVARCHAR(MAX)') AS [batch_text]
FROM        sys.fn_xe_file_target_read_file(
                N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log\Monitor Data Warehouse Query Activity_0_133772117223190000.xel'
              , null
              , null
              , null
            );
GO

--SELECT * FROM sys.traces;  
--GO

--USE [master];
--GO

--DECLARE @trace_id INT = 1;  

--SELECT        DISTINCT el.eventid
--            , em.package_name
--            , em.xe_event_name AS 'event'
--            , el.columnid
--            , ec.xe_action_name AS 'action'
--FROM        (
--                sys.fn_trace_geteventinfo ( @trace_id ) AS el
--                LEFT JOIN   sys.trace_xe_event_map AS em ON el.eventid = em.trace_event_id
--            )
--LEFT JOIN   sys.trace_xe_action_map AS ec ON el.columnid = ec.trace_column_id  
--WHERE       em.xe_event_name IS NOT NULL
--            AND ec.xe_action_name IS NOT NULL;