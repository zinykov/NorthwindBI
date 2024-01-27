--IF EXISTS ( SELECT * FROM sys.server_event_sessions WHERE [name] = N'MySession' )
--    BEGIN
--        DROP EVENT SESSION [MySession] ON SERVER;
--    END;
--GO

--CREATE EVENT SESSION [MySession]
--    ON SERVER
--    ADD EVENT sqlserver.sql_statement_completed
--    (
--        ACTION ( sqlserver.sql_text )
--        WHERE (
--            [sqlserver].[like_i_sql_unicode_string] ( [sqlserver].[sql_text], N'%SELECT%HAVING%' )
--        )
--    )
--    ADD TARGET package0.event_file (
--        SET
--              FILENAME = N'C:\Windows\Temp\MySession_Target.xel'
--            , max_file_size = (2)
--            , max_rollover_files = (2)
--    )
--    WITH (
--          MAX_MEMORY = 2048 KB
--        , EVENT_RETENTION_MODE = ALLOW_MULTIPLE_EVENT_LOSS
--        , MAX_DISPATCH_LATENCY = 3 SECONDS
--        , MAX_EVENT_SIZE = 0 KB
--        , MEMORY_PARTITION_MODE = NONE
--        , TRACK_CAUSALITY = OFF
--        , STARTUP_STATE = OFF
--    );
--GO

--ALTER EVENT SESSION [MySession]
--    ON SERVER
--    STATE = START;
--GO

--SELECT        C.[name]
--            ,  COUNT(*) AS [Count-Per-Column-Repeated-Name]
--FROM        sys.syscolumns AS C
--INNER JOIN  sys.sysobjects AS O ON O.[id] = C.[id]
--WHERE       O.[type] = 'V'
--            AND C.[name] LIKE N'%event%'
--GROUP BY    C.[name]
--HAVING      COUNT(*) >= 3
--ORDER BY    C.[name];
--GO

--SELECT        C.[name]
--            ,  COUNT(*) AS [Count-Per-Column-Repeated-Name]
--FROM        sys.syscolumns AS C
--INNER JOIN  sys.sysobjects AS O ON O.[id] = C.[id]
--WHERE       O.[type] = 'V'
--            AND C.[name] LIKE N'%event%'
--GROUP BY    C.[name]
--HAVING      COUNT(*) >= 2
--ORDER BY    C.[name];
--GO

--ALTER EVENT SESSION [MySession]
--    ON SERVER
--    STATE = STOP;
--GO

--DECLARE @FilePath AS NVARCHAR(260) = N'C:\Windows\Temp\MySession_Target_0_133507587223670000.xel';

--SELECT        CAST ( [event_data] AS xml ).value('(/event/action/value)[1]', 'NVARCHAR(MAX)') AS [statement]
--FROM        sys.fn_xe_file_target_read_file(
--                @FilePath
--              , null
--              , null
--              , null
--            );
--GO

SELECT * FROM sys.traces;  
GO

USE [master];
GO

DECLARE @trace_id INT = 1;  

SELECT        DISTINCT el.eventid
            , em.package_name
            , em.xe_event_name AS 'event'
            , el.columnid
            , ec.xe_action_name AS 'action'
FROM        (
                sys.fn_trace_geteventinfo ( @trace_id ) AS el
                LEFT JOIN   sys.trace_xe_event_map AS em ON el.eventid = em.trace_event_id
            )
LEFT JOIN   sys.trace_xe_action_map AS ec ON el.columnid = ec.trace_column_id  
WHERE       em.xe_event_name IS NOT NULL
            AND ec.xe_action_name IS NOT NULL;