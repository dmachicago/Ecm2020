
GO
PRINT 'From CreateJobPullEdwData.sql';
PRINT 'Creating : job_EDW_GetFACTData_HA_' + DB_NAME();
GO

/****** Object:  Job [job_EDW_GetFACTData]    Script Date: 3/28/2015 12:29:16 PM ******/

BEGIN TRANSACTION;
DECLARE
   @DB  AS nvarchar (100) = DB_NAME (),
   @JobName AS nvarchar (100) = '',
    @JNAME AS nvarchar (100) = '',
   @ReturnCode int;

SELECT
       @ReturnCode = 0;

SET @JobName = 'job_EDW_GetFACTData_HA_' + @DB;
print('CREATING Procedure ' + @JobName) ;
set @JNAME = @JobName ;
IF EXISTS (SELECT
                  job_id
                  FROM msdb.dbo.sysjobs_view
             WHERE name = @JNAME) 
    BEGIN
	   print('UPDATING Procedure ' + @JobName) ;
        EXEC msdb.dbo.sp_delete_job @job_name = @JNAME, @delete_unused_schedule = 1
    END;

/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 3/28/2015 12:29:16 PM ******/

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
   @jobId binary (16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JobName,
@enabled = 1,
@notify_level_eventlog = 0,
@notify_level_email = 2,
@notify_level_netsend = 0,
@notify_level_page = 0,
@delete_level = 0,
@description = N'No description available.',
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'DMiller',
@notify_email_operator_name = N'DBA_Notify', @job_id = @jobId OUTPUT;
IF @@ERROR <> 0
OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;

/****** Object:  Step [PullThedata]    Script Date: 3/28/2015 12:29:17 PM ******/

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId, @step_name = N'PullThedata',
@step_id = 1,
@cmdexec_success_code = 0,
@on_success_action = 1,
@on_success_step_id = 0,
@on_fail_action = 2,
@on_fail_step_id = 0,
@retry_attempts = 0,
@retry_interval = 0,
@os_run_priority = 0, @subsystem = N'TSQL',
@command = N'exec proc_STAGING_EDW_HA_Changes 0 ',
@database_name = @DB,
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
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = N'Edw Staging Data Schedule',
@enabled = 1,
@freq_type = 4,
@freq_interval = 1,
@freq_subday_type = 8,
@freq_subday_interval = 8,
@freq_relative_interval = 0,
@freq_recurrence_factor = 0,
@active_start_date = 20150328,
@active_end_date = 99991231,
@active_start_time = 0,
@active_end_time = 235959
--@schedule_uid = N'1de52534-38dc-4155-baf3-0eb7259df6c1';
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

GO

PRINT 'CREATED : job_EDW_GetFACTData_HA_ ' + DB_NAME();;

GO

