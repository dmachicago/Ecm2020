
GO
PRINT 'Executing create_job_proc_CT_DIM_$Master.sql';
GO

IF EXISTS (SELECT name
             FROM msdb..sysjobs
             WHERE name = 'job_proc_CT_DIM_$Master') 
    BEGIN
        PRINT 'job_proc_CT_DIM_$Master already exists, aborting...';
        GOTO job_proc_CT_DIM_$Master_Exists;
    END;

DECLARE
      @DB AS nvarchar (250) = DB_NAME () ; 

/****** Obj@DBect:  Job [job_proc_CT_DIM_$Master]    Script Date: 4/12/2016 1:42:58 PM ******/

BEGIN TRANSACTION;
DECLARE
      @ReturnCode int;
SELECT @ReturnCode = 0;

/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 4/12/2016 1:42:58 PM ******/

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
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = N'job_proc_CT_DIM_$Master' , @enabled = 1 , @notify_level_eventlog = 0 , @notify_level_email = 0 , @notify_level_netsend = 0 , @notify_level_page = 0 , @delete_level = 0 , @description = N'No description available.' , @category_name = N'[Uncategorized (Local)]' , @owner_login_name = N'SA' , @job_id = @jobId OUTPUT;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN
        GOTO QuitWithRollback
    END;

/****** Object:  Step [StartUp]    Script Date: 4/12/2016 1:43:02 PM ******/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId , @step_name = N'StartUp' , @step_id = 1 , @cmdexec_success_code = 0 , @on_success_action = 1 , @on_success_step_id = 0 , @on_fail_action = 2 , @on_fail_step_id = 0 , @retry_attempts = 0 , @retry_interval = 0 , @os_run_priority = 0 , @subsystem = N'TSQL' , @command = N'exec PrintImmediate ''Starting CT_CIM_$Master''' , @database_name = @DB , @flags = 0;
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
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId , @name = N'CT_DIM_Master' , @enabled = 1 , @freq_type = 4 , @freq_interval = 1 , @freq_subday_type = 8 , @freq_subday_interval = 24 , @freq_relative_interval = 0 , @freq_recurrence_factor = 0 , @active_start_date = 20160412 , @active_end_date = 99991231 , @active_start_time = 183000 , @active_end_time = 235959 , @schedule_uid = N'cdd84993-26a3-4ec7-9e0b-707b673f8e6c';
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

job_proc_CT_DIM_$Master_Exists:

GO
PRINT 'Executed create_job_proc_CT_DIM_$Master.sql';
GO
