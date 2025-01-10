--:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

SELECT      *
FROM        (
                SELECT        [timestamp_utc] AT TIME ZONE N'Russian Standard Time' AS [timestamp]
                            , CAST ( [event_data] AS XML ).value( '(/event/action[@name="database_name"]/value)[1]', 'NVARCHAR(128)' ) AS [database_name]
                            , CAST ( [event_data] AS XML ).value( '(/event/action[@name="nt_username"]/value)[1]', 'NVARCHAR(128)' ) AS [nt_username]
                            , CAST ( [event_data] AS XML ).value( '(/event/action[@name="client_app_name"]/value)[1]', 'NVARCHAR(128)' ) AS [client_app_name]
                            , [object_name]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="duration"]/value)[1]', 'BIGINT' ) AS [duration]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="page_server_reads"]/value)[1]', 'BIGINT' ) AS [page_server_reads]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="physical_reads"]/value)[1]', 'BIGINT' ) AS [physical_reads]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="logical_reads"]/value)[1]', 'BIGINT' ) AS [logical_reads]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="writes"]/value)[1]', 'BIGINT' ) AS [writes]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="spills"]/value)[1]', 'BIGINT' ) AS [spills]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="row_count"]/value)[1]', 'BIGINT' ) AS [row_count]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="statement"]/value)[1]', 'NVARCHAR(MAX)' ) AS [statement]
                FROM        sys.fn_xe_file_target_read_file(
                                N'C:\Users\zinyk\source\repos\Northwind_BI_Solution\logs\Monitor Data Warehouse Query Activity_0_133780718769910000.xel'
                              , null
                              , null
                              , null
                            )
                WHERE       CAST ( [event_data] AS XML ).exist( '(/event/data[@name="statement"]/value)[1]' ) = 1

                UNION ALL

                SELECT        [timestamp_utc] AT TIME ZONE N'Russian Standard Time'
                            , CAST ( [event_data] AS XML ).value( '(/event/action[@name="database_name"]/value)[1]', 'NVARCHAR(128)' ) AS [database_name]
                            , CAST ( [event_data] AS XML ).value( '(/event/action[@name="nt_username"]/value)[1]', 'NVARCHAR(128)' ) AS [nt_username]
                            , CAST ( [event_data] AS XML ).value( '(/event/action[@name="client_app_name"]/value)[1]', 'NVARCHAR(128)' ) AS [client_app_name]
                            , [object_name]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="duration"]/value)[1]', 'BIGINT' ) AS [duration]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="page_server_reads"]/value)[1]', 'BIGINT' ) AS [page_server_reads]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="physical_reads"]/value)[1]', 'BIGINT' ) AS [physical_reads]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="logical_reads"]/value)[1]', 'BIGINT' ) AS [logical_reads]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="writes"]/value)[1]', 'BIGINT' ) AS [writes]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="spills"]/value)[1]', 'BIGINT' ) AS [spills]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="row_count"]/value)[1]', 'BIGINT' ) AS [row_count]
                            , CAST ( [event_data] AS XML ).value( '(/event/data[@name="batch_text"]/value)[1]', 'NVARCHAR(MAX)' ) AS [statement]
                FROM        sys.fn_xe_file_target_read_file(
                                N'C:\Users\zinyk\source\repos\Northwind_BI_Solution\logs\Monitor Data Warehouse Query Activity_0_133780718769910000.xel'
                              , null
                              , null
                              , null
                            )
                WHERE       CAST ( [event_data] AS XML ).exist( '(/event/data[@name="batch_text"]/value)[1]' ) = 1
            ) AS T1
ORDER BY    [timestamp] ASC;