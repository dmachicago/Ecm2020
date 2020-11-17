

GO
PRINT 'executing JOB_proc_HA_MasterUpdate.sql';
GO

DECLARE
      @jobId binary (16) ;
SELECT @jobId = job_id
  FROM msdb.dbo.sysjobs
  WHERE name = N'JOB proc_HA_MasterUpdate';
IF @jobId IS NOT NULL
    BEGIN EXEC msdb.dbo.sp_delete_job @jobId;
    END;

GO
DECLARE
      @DB AS nvarchar (100) = DB_NAME () ;

BEGIN TRANSACTION;
DECLARE
      @ReturnCode int;
SELECT @ReturnCode = 0;

IF NOT EXISTS (SELECT name
                 FROM msdb.dbo.syscategories
                 WHERE name = N'[Uncategorized (Local)]'
                   AND category_class = 1) 
    BEGIN EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB' , @type = N'LOCAL' , @name = N'[Uncategorized (Local)]';
        IF @@ERROR <> 0
        OR @ReturnCode <> 0
            BEGIN
                GOTO QuitWithRollback
            END;

    END;

DECLARE
      @jobId binary (16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = N'JOB proc_HA_MasterUpdate' , @enabled = 1 , @notify_level_eventlog = 2 , @notify_level_email = 2 , @notify_level_netsend = 0 , @notify_level_page = 0 , @delete_level = 0 , @description = N'Pull and apply all updates to the Master HA table in the MART database' , @category_name = N'[Uncategorized (Local)]' , @owner_login_name = N'sa' , @notify_email_operator_name = N'DBA_Notify' , @job_id = @jobId OUTPUT;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback
    END;

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId , @step_name = N'Step1 - proc_HA_MasterUpdate' , @step_id = 1 , @cmdexec_success_code = 0 , @on_success_action = 1 , @on_success_step_id = 0 , @on_fail_action = 2 , @on_fail_step_id = 0 , @retry_attempts = 0 , @retry_interval = 0 , @os_run_priority = 0 , @subsystem = N'TSQL' , @command = N'exec proc_HA_MasterUpdate' , @database_name = @DB , @flags = 4;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId , @start_step_id = 1;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId , @name = N'Schedule proc_HA_MasterUpdate' , @enabled = 1 , @freq_type = 4 , @freq_interval = 1 , @freq_subday_type = 8 , @freq_subday_interval = 6 , @freq_relative_interval = 0 , @freq_recurrence_factor = 0 , @active_start_date = 20160324 , @active_end_date = 99991231 , @active_start_time = 0 , @active_end_time = 235959 , @schedule_uid = N'1d503d9d-0c2d-46e6-a4a8-11ec18d8c115';
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId , @server_name = N'(local)';
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
PRINT 'Created JOB "JOB_proc_HA_MasterUpdate"';
GO