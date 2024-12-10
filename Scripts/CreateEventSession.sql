IF EXISTS ( SELECT 1 FROM sys.server_event_sessions WHERE [name] = 'Monitor Data Warehouse Query Activity' )
	DROP EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER;

CREATE EVENT SESSION [Monitor Data Warehouse Query Activity] ON SERVER 
	ADD EVENT [sqlserver].[sql_batch_completed] (
		SET collect_batch_text = (1)
		ACTION	(
					  [sqlserver].[client_app_name]
					, [sqlserver].[database_id]
					, [sqlserver].[database_name]
					, [sqlserver].[nt_username]
					, [sqlserver].[server_principal_name]
					, [sqlserver].[session_id]
				)
		WHERE	( [sqlserver].[like_i_sql_unicode_string] ( [sqlserver].[database_name], N'%Northwind%' ) )
	),
	ADD EVENT [sqlserver].[sql_statement_completed] (
		ACTION	(
					  [sqlserver].[client_app_name]
					, [sqlserver].[database_id]
					, [sqlserver].[database_name]
					, [sqlserver].[nt_username]
					, [sqlserver].[server_principal_name]
					, [sqlserver].[session_id]
				)
		WHERE	( [sqlserver].[like_i_sql_unicode_string] ( [sqlserver].[database_name], N'%Northwind%' ) )
	),
	ADD EVENT [sqlserver].[rpc_completed] (
		SET		collect_data_stream = (1)
		ACTION	(
					  [sqlserver].[client_app_name]
					, [sqlserver].[database_id]
					, [sqlserver].[database_name]
					, [sqlserver].[nt_username]
					, [sqlserver].[server_principal_name]
					, [sqlserver].[session_id]
				)
		WHERE	[sqlserver].[like_i_sql_unicode_string] ( [sqlserver].[database_name], N'%Northwind%' )
	)
	ADD TARGET [package0].[event_file] ( SET filename = N'$(ExternalFilesPath)\logs\Monitor Data Warehouse Query Activity.xel' )
	WITH	(
				  MAX_MEMORY = 4096 KB
				, EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS
				, MAX_DISPATCH_LATENCY = 30 SECONDS
				, MAX_EVENT_SIZE = 0 KB
				, MEMORY_PARTITION_MODE = NONE
				, TRACK_CAUSALITY = ON
				, STARTUP_STATE = OFF
			);