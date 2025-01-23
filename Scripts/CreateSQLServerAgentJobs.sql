--:r C:\Users\zinyk\source\repos\Northwind_BI_Solution\Scripts\VariableGroup.sql

BEGIN TRANSACTION
	DECLARE @ReturnCode INT = 0;
	IF NOT EXISTS ( SELECT [name] FROM [dbo].[syscategories] WHERE [name] = N'$(SSISFolderName)' AND category_class = 1 )
		BEGIN
			EXECUTE @ReturnCode = [dbo].sp_add_category
				  @class = N'JOB'
				, @type = N'LOCAL'
				, @name = N'$(SSISFolderName)'
			IF (@@ERROR <> 0 OR @ReturnCode <> 0)
				GOTO QuitWithRollback
		END

	DECLARE @jobId BINARY(16);

	EXECUTE @ReturnCode = [dbo].sp_add_job
		  @job_name = N'$(SSISFolderName).ExtractNorthwind(упрощённая)'
		, @enabled = 0
		, @notify_level_eventlog = 0
		, @notify_level_email = 0
		, @notify_level_netsend = 0
		, @notify_level_page = 0
		, @delete_level = 0
		, @description = N'Ingest data from Northwind(упрощённая) data source.'
		, @category_name = N'$(SSISFolderName)'
		, @owner_login_name = N'$(SSISServerName)\$(AzPipelineAgent)'
		, @job_id = @jobId OUTPUT

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobstep
		  @job_id = @jobId
		, @step_name = N'Extract Northwind (упрощённая)'
		, @step_id = 1
		, @cmdEXECUTE_success_code = 0
		, @on_success_action = 1
		, @on_success_step_id = 0
		, @on_fail_action = 2
		, @on_fail_step_id = 0
		, @retry_attempts = 0
		, @retry_interval = 0
		, @os_run_priority = 0
		, @subsystem=N'SSIS'
		, @command=N'/ISSERVER "\"\SSISDB\$(SSISFolderName)\$(SSISProjectName)\Extract Northwind (упрощённая).dtsx\"" /SERVER "\"$(SSISServerName)\"" /ENVREFERENCE 6 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
		, @database_name=N'master'
		, @flags=0

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_update_job
		  @job_id = @jobId
		, @start_step_id = 1

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobschedule
		  @job_id = @jobId
		, @name = N'Schedule'
		, @enabled = 0
		, @freq_type = 4
		, @freq_interval = 1
		, @freq_subday_type = 1
		, @freq_subday_interval = 0
		, @freq_relative_interval = 0
		, @freq_recurrence_factor = 0
		, @active_start_date = 20241211
		, @active_end_date = 99991231
		, @active_start_time = 10000
		, @active_end_time = 235959
		, @schedule_uid = N'9821b857-0304-43f2-8dd0-4dab83fda4bb'

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobserver
		  @job_id = @jobId
		, @server_name = N'(local)'

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave

QuitWithRollback:
    IF ( @@TRANCOUNT > 0 ) ROLLBACK TRANSACTION

EndSave:
GO

BEGIN TRANSACTION
	DECLARE @ReturnCode INT = 0;
	IF NOT EXISTS ( SELECT [name] FROM [dbo].[syscategories] WHERE [name] = N'$(SSISFolderName)' AND category_class = 1 )
		BEGIN
			EXECUTE @ReturnCode = [dbo].sp_add_category
				  @class = N'JOB'
				, @type = N'LOCAL'
				, @name = N'$(SSISFolderName)'
			IF (@@ERROR <> 0 OR @ReturnCode <> 0)
				GOTO QuitWithRollback
		END

	DECLARE @jobId BINARY(16);

	EXECUTE @ReturnCode = [dbo].sp_add_job
		  @job_name = N'$(SSISFolderName).ExtractXmlcalendar'
		, @enabled = 0
		, @notify_level_eventlog = 0
		, @notify_level_email = 0
		, @notify_level_netsend = 0
		, @notify_level_page = 0
		, @delete_level = 0
		, @description = N'Ingest data from Xmlcalendar.ru'
		, @category_name = N'$(SSISFolderName)'
		, @owner_login_name = N'$(SSISServerName)\$(AzPipelineAgent)'
		, @job_id = @jobId OUTPUT

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobstep
		  @job_id = @jobId
		, @step_name = N'Extract Xmlcalendar'
		, @step_id = 1
		, @cmdEXECUTE_success_code = 0
		, @on_success_action = 1
		, @on_success_step_id = 0
		, @on_fail_action = 2
		, @on_fail_step_id = 0
		, @retry_attempts = 0
		, @retry_interval = 0
		, @os_run_priority = 0
		, @subsystem = N'SSIS'
		, @command = N'/ISSERVER "\"\SSISDB\$(SSISFolderName)\$(SSISProjectName)\Extract Xmlcalendar.dtsx\"" /SERVER "\"$(SSISServerName)\"" /ENVREFERENCE 6 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
		, @database_name = N'master'
		, @flags = 0

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_update_job
		  @job_id = @jobId
		, @start_step_id = 1

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobschedule
		  @job_id = @jobId
		, @name = N'Schedule'
		, @enabled = 0
		, @freq_type = 4
		, @freq_interval = 1
		, @freq_subday_type = 1
		, @freq_subday_interval = 0
		, @freq_relative_interval = 0
		, @freq_recurrence_factor = 0
		, @active_start_date = 20241211
		, @active_end_date = 99991231
		, @active_start_time = 10000
		, @active_end_time = 235959
		, @schedule_uid = N'f3385fe3-2e8b-4477-a549-bba9c0e2ab26'

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobserver
		  @job_id = @jobId
		, @server_name = N'(local)'
	
	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave

QuitWithRollback:
    IF ( @@TRANCOUNT > 0 ) ROLLBACK TRANSACTION

EndSave:
GO

BEGIN TRANSACTION
	DECLARE @ReturnCode INT = 0;
	IF NOT EXISTS ( SELECT [name] FROM [dbo].[syscategories] WHERE [name] = N'$(SSISFolderName)' AND category_class = 1 )
		BEGIN
			EXECUTE @ReturnCode = [dbo].sp_add_category
				  @class = N'JOB'
				, @type = N'LOCAL'
				, @name = N'$(SSISFolderName)'
			IF (@@ERROR <> 0 OR @ReturnCode <> 0)
				GOTO QuitWithRollback
		END

	DECLARE @jobId BINARY(16);

	EXECUTE @ReturnCode = [dbo].sp_add_job
		  @job_name = N'$(SSISFolderName).TransformAndLoad'
		, @enabled=0
		, @notify_level_eventlog=0
		, @notify_level_email=0
		, @notify_level_netsend=0
		, @notify_level_page=0
		, @delete_level=0
		, @description=N'Load new portion of data into DWH & maintenance DWH'
		, @category_name=N'$(SSISFolderName)'
		, @owner_login_name=N'$(SSISServerName)\$(AzPipelineAgent)'
		, @job_id = @jobId OUTPUT

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobstep
		  @job_id = @jobId
		, @step_name = N'Transform and load'
		, @step_id = 1
		, @cmdEXECUTE_success_code = 0
		, @on_success_action = 3
		, @on_success_step_id = 0
		, @on_fail_action = 2
		, @on_fail_step_id = 0
		, @retry_attempts = 0
		, @retry_interval = 0
		, @os_run_priority = 0
		, @subsystem = N'SSIS'
		, @command = N'/ISSERVER "\"\SSISDB\$(SSISFolderName)\$(SSISProjectName)\Transform and load.dtsx\"" /SERVER "\"$(SSISServerName)\"" /ENVREFERENCE 6 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E'
		, @database_name = N'master'
		, @flags = 0

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobstep @job_id=@jobId, @step_name=N'DWH Maintenance', 
		@step_id = 2, 
		@cmdEXECUTE_success_code = 0, 
		@on_success_action = 3, 
		@on_success_step_id = 0, 
		@on_fail_action = 2, 
		@on_fail_step_id = 0, 
		@retry_attempts = 0, 
		@retry_interval = 0, 
		@os_run_priority = 0, @subsystem = N'SSIS', 
		@command = N'/SQL "\"\Maintenance Plans\$(SSISFolderName)\"" /SERVER "\"$(SSISServerName)\"" /CHECKPOINTING OFF /SET "\"\Package\DWH Maintenance.Disable\"";false /REPORTING E', 
		@database_name = N'master', 
		@flags = 0

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobstep @job_id=@jobId, @step_name=N'Copy DatabaseFiles info', 
		@step_id = 3, 
		@cmdEXECUTE_success_code = 0, 
		@on_success_action = 1, 
		@on_success_step_id = 0, 
		@on_fail_action = 2, 
		@on_fail_step_id = 0, 
		@retry_attempts = 0, 
		@retry_interval = 0, 
		@os_run_priority = 0, @subsystem = N'SSIS', 
		@command = N'/ISSERVER "\"\SSISDB\$(SSISFolderName)\$(SSISProjectName)\Maintenance copy DatabaseFiles.dtsx\"" /SERVER "\"$(SSISServerName)\"" /ENVREFERENCE 6 /Par "\"$ServerOption::LOGGING_LEVEL(Int16)\"";1 /Par "\"$ServerOption::SYNCHRONIZED(Boolean)\"";True /CALLERINFO SQLAGENT /REPORTING E', 
		@database_name = N'master', 
		@flags = 0

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_update_job @job_id = @jobId, @start_step_id = 1

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobschedule @job_id=@jobId, @name=N'Schedule', 
		@enabled = 0, 
		@freq_type = 4, 
		@freq_interval = 1, 
		@freq_subday_type = 1, 
		@freq_subday_interval = 0, 
		@freq_relative_interval = 0, 
		@freq_recurrence_factor = 0, 
		@active_start_date = 20241211, 
		@active_end_date = 99991231, 
		@active_start_time = 20000, 
		@active_end_time = 235959, 
		@schedule_uid = N'9f1eb36b-d859-41e2-ab5a-f804ec2f4770'

	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback

	EXECUTE @ReturnCode = [dbo].sp_add_jobserver
		  @job_id = @jobId
		, @server_name = N'(local)'
	
	IF ( @@ERROR <> 0 OR @ReturnCode <> 0 )
		GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave

QuitWithRollback:
    IF ( @@TRANCOUNT > 0 ) ROLLBACK TRANSACTION

EndSave:
GO