go
PRINT 'Creating JOB job_EDW_GetStagingData_Trackers' ;
GO

BEGIN TRANSACTION;
DECLARE
   @ReturnCode int;
SELECT
       @ReturnCode = 0;

IF NOT EXISTS (SELECT
                      name
                      FROM msdb.dbo.syscategories
                 WHERE name = N'[Uncategorized (Local)]'
                   AND category_class = 1) 
    BEGIN
        EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB', @type = N'LOCAL', @name = N'[Uncategorized (Local)]';
        IF @@ERROR <> 0
        OR @ReturnCode <> 0
            BEGIN GOTO QuitWithRollback
            END;

    END;

DECLARE
   @TGTDB AS nvarchar (50) = DB_NAME () ;
DECLARE
   @JNAME AS nvarchar (100) = 'job_EDW_GetStagingData_Trackers_' + @TGTDB;

IF EXISTS (SELECT
                  job_id
                  FROM msdb.dbo.sysjobs_view
             WHERE name = @JNAME) 
    BEGIN
        EXEC msdb.dbo.sp_delete_job @job_name = @JNAME, @delete_unused_schedule = 1
    END;

DECLARE
   @jobId binary (16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JNAME,
@enabled = 1,
@notify_level_eventlog = 2,
@notify_level_email = 2,
@notify_level_netsend = 0,
@notify_level_page = 0,
@delete_level = 0,
@description = N'No description available.',
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'sa',
@notify_email_operator_name = N'DBA_Notify', @job_id = @jobId OUTPUT;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;

/****** Object:  Step [Load_EDW_Trackers]    Script Date: 4/12/2015 9:59:37 AM ******/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId, @step_name = N'Load_EDW_Trackers',
@step_id = 1,
@cmdexec_success_code = 0,
@on_success_action = 1,
@on_success_step_id = 0,
@on_fail_action = 2,
@on_fail_step_id = 0,
@retry_attempts = 0,
@retry_interval = 0,
@os_run_priority = 0, @subsystem = N'TSQL',
@command = N'exec proc_STAGING_EDW_CompositeTracker;',
@database_name = @TGTDB,
@flags = 0;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = N'Schedule_EDW_Trackers',
@enabled = 1,
@freq_type = 4,
@freq_interval = 1,
@freq_subday_type = 8,
@freq_subday_interval = 8,
@freq_relative_interval = 0,
@freq_recurrence_factor = 0,
@active_start_date = 20150412,
@active_end_date = 99991231,
@active_start_time = 10000,
@active_end_time = 235959
--@schedule_uid = N'afcb6980-89fe-4a08-ad03-6598bd55454a';
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;
COMMIT TRANSACTION;
GOTO EndSave;
QuitWithRollback:
IF @@TRANCOUNT > 0
    BEGIN ROLLBACK TRANSACTION
    END;
EndSave:

PRINT 'CREATED JOB ' + @JNAME;

GO



