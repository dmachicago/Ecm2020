
print('Processing job_EDW_GenerateMetadata');
go

IF not EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'job_EDW_GenerateMetadata')
BEGIN
	drop procedure job_EDW_GenerateMetadata ;
END
GO


IF not EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'job_EDW_GenerateMetadata')
BEGIN
	USE [msdb]

	/****** Object:  Job [job_EDW_GenerateMetadata]    Script Date: 8/20/2014 3:10:41 PM ******/
	BEGIN TRANSACTION
	DECLARE @DBNAME nvarchar(100)
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	--********************************************************************************
	set @DBNAME = 'KenticoCMS_DEV'
	--********************************************************************************

	/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 8/20/2014 3:10:41 PM ******/
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'job_EDW_GenerateMetadata', 
			@enabled=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=0, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description=N'Generate the metadata for the EDW team for Tracker Data', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'DMiller', @job_id = @jobId OUTPUT
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	/****** Object:  Step [Extract Kentico Metadata]    Script Date: 8/20/2014 3:10:42 PM ******/
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Extract Kentico Metadata', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'TSQL', 
			@command=N'exec Proc_EDW_GenerateMetadata', 
			@database_name= @DBNAME,
			@flags=0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Extract Metadata Schedule', 
			@enabled=1, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=0, 
			@active_start_date=20140820, 
			@active_end_date=99991231, 
			@active_start_time=230000, 
			@active_end_time=235959, 
			@schedule_uid=N'ccba070c-ad61-4dec-8f4c-1e33722b43f6'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	COMMIT TRANSACTION
	GOTO EndSave
	QuitWithRollback:
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	EndSave:

END

use KenticoCMS_DEV

