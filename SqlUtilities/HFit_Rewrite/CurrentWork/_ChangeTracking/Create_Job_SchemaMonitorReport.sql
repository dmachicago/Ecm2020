
GO
PRINT 'FQN: Create_Job_SchemaMonitorReport.SQL';
PRINT 'Processing Job SchemaMonitorReport';
GO

IF EXISTS (SELECT
				  job_id
			 FROM msdb.dbo.sysjobs_view
			 WHERE name = N'SchemaMonitorReport') 
	BEGIN EXEC msdb.dbo.sp_delete_job @job_name = N'SchemaMonitorReport', @delete_unused_schedule = 1;
	END;
GO

/**********************************************************************************
***** Object:  Job [SchemaMonitorReport]    Script Date: 2/24/2015 2:23:59 PM *****
**********************************************************************************/

declare @DB as nvarchar(254) = DB_NAME() ;

BEGIN TRANSACTION;
DECLARE @ReturnCode int;
SELECT
	   @ReturnCode = 0;

/***********************************************************************************************
***** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 2/24/2015 2:24:00 PM *****
***********************************************************************************************/

IF NOT EXISTS (SELECT
					  name
				 FROM msdb.dbo.syscategories
				 WHERE name = N'[Uncategorized (Local)]'
				   AND category_class = 1) 
	BEGIN EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB', @type = N'LOCAL', @name = N'[Uncategorized (Local)]';
		IF @@ERROR <> 0
		OR @ReturnCode <> 0
			BEGIN
				GOTO QuitWithRollback
			END;
	END;
DECLARE @jobId binary (16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = N'SchemaMonitorReport', @enabled = 1, @notify_level_eventlog = 2, @notify_level_email = 0, @notify_level_netsend = 0, @notify_level_page = 0, @delete_level = 0, @description = N'No description available.', @category_name = N'[Uncategorized (Local)]', @owner_login_name = N'sa', @job_id = @jobId OUTPUT;
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;

/**********************************************************************************************
***** Object:  Step [execute sp_SchemaMonitorReport]    Script Date: 2/24/2015 2:24:01 PM *****
**********************************************************************************************/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId, @step_name = N'execute sp_SchemaMonitorReport', @step_id = 1, @cmdexec_success_code = 0, @on_success_action = 1, @on_success_step_id = 0, @on_fail_action = 2, @on_fail_step_id = 0, @retry_attempts = 0, @retry_interval = 0, @os_run_priority = 0, @subsystem = N'TSQL', @command = N'exec sp_SchemaMonitorReport', @database_name = @DB, @flags = 0;
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = N'SchemaMonitorReport Schedule', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20141017, @active_end_date = 99991231, @active_start_time = 220000, @active_end_time = 235959, @schedule_uid = N'd64376a9-39f9-4344-b403-5526b03d70d7';
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = N'SchemaMonitorReport Schedule', @enabled = 1, @freq_type = 4, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_start_date = 20141017, @active_end_date = 99991231, @active_start_time = 220000, @active_end_time = 235959, @schedule_uid = N'37dd0949-b104-47c6-864c-2df7b166d28f';
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
IF @@ERROR <> 0
OR @ReturnCode <> 0
	BEGIN
		GOTO QuitWithRollback
	END;
COMMIT TRANSACTION;
GOTO EndSave;
QuitWithRollback:
IF @@TRANCOUNT > 0
	BEGIN
		ROLLBACK TRANSACTION
	END;
EndSave:
GO

--DECLARE @CurrDB AS nvarchar (250) = (SELECT TOP 1
--											CurrDB
--									   FROM #SMR_CurrDB) ;
--DECLARE @MSQL AS nvarchar (250) = 'USE ' + @CurrDB;
--EXEC (@MSQL) ;
PRINT 'Switched back to DB ' + DB_NAME () ;
GO
PRINT 'Job SchemaMonitorReport created.';
