

-- use kenticoCMS_DataMArt
GO
PRINT 'Executing proc_GenJobTrackerTableSync.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_GenJobTrackerTableSync') 
    BEGIN
        PRINT 'DROPPING and Reinstalling proc_GenJobTrackerTableSync.sql';
        DROP PROCEDURE
             proc_GenJobTrackerTableSync;
    END;
GO
-- exec proc_GenJobTrackerTableSync 3, 'proc_BASE_CMS_Document_KenticoCMS_2_Insert'
CREATE PROCEDURE proc_GenJobTrackerTableSync
(
       @Interval AS INT = 5
     , @ProcName AS NVARCHAR (250)) 
AS
BEGIN

    DECLARE @DB AS NVARCHAR (250) = DB_NAME() ;
    DECLARE @JobName AS NVARCHAR (250) = 'job_' + @ProcName;
    DECLARE @StepName AS NVARCHAR (250) = N'RUN ' + @ProcName;
    DECLARE @SchedName AS NVARCHAR (250) = 'SCHED ' + @ProcName;
    DECLARE @CMD AS NVARCHAR (250) = 'exec ' + @ProcName;
    DECLARE @JobGuid AS NVARCHAR (50) = CAST (NEWID () AS NVARCHAR (50)) ;
    DECLARE @StartTime AS NVARCHAR (50) = '0';

    print 'GENERATING JOB: ' + @JobName ;

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = @JobName) 
        BEGIN
            EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule = 1;
        END;

    --20000 is 2:00 AM 
    --20500 is 2:05 AM 
    --21000 is 2:10 AM 
    SET @StartTime = @Interval * 250 + 20000 ;
    
    --print '@StartTime: ' + cast(@StartTime as nvarchar(50)) ;

    BEGIN TRANSACTION;
    DECLARE @ReturnCode INT;
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
                BEGIN GOTO QuitWithRollback;
                END;

        END;

    DECLARE @jobId BINARY (16) ;
    EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JobName,
    @enabled = 1,
    @notify_level_eventlog = 0,
    @notify_level_email = 2,
    @notify_level_netsend = 2,
    @notify_level_page = 0,
    @delete_level = 0,
    @description = N'No description available.',
    @category_name = N'[Uncategorized (Local)]',
    @owner_login_name = N'sa',
    @notify_email_operator_name = N'DBA_Notify',
    @notify_netsend_operator_name = N'DBA_Email', @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) 
        BEGIN 
		  GOTO QuitWithRollback;
        END;

    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId, @step_name = @StepName,
    @step_id = 1,
    @cmdexec_success_code = 0,
    @on_success_action = 1,
    @on_success_step_id = 0,
    @on_fail_action = 2,
    @on_fail_step_id = 0,
    @retry_attempts = 0,
    @retry_interval = 10,
    @os_run_priority = 0, @subsystem = N'TSQL',
    @command = @CMD,
    @database_name = @DB ,
    @flags = 0;
    IF @@ERROR <> 0
    OR @ReturnCode <> 0
        BEGIN GOTO QuitWithRollback;
        END;
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;
    IF @@ERROR <> 0
    OR @ReturnCode <> 0
        BEGIN GOTO QuitWithRollback;
        END;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = @SchedName,
    @enabled = 1,
    @freq_type = 4,
    @freq_interval = 1,
    @freq_subday_type = 1,
    @freq_subday_interval = 0,
    @freq_relative_interval = 0,
    @freq_recurrence_factor = 0,
    @active_start_date = 20160205,
    @active_end_date = 99991231,
    @active_start_time = @StartTime,
    @active_end_time = 235959,
    @schedule_uid = @JobGuid;
    IF @@ERROR <> 0
    OR @ReturnCode <> 0
        BEGIN GOTO QuitWithRollback;
        END;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF @@ERROR <> 0
    OR @ReturnCode <> 0
        BEGIN GOTO QuitWithRollback;
        END;
    COMMIT TRANSACTION;
    GOTO EndSave;
    QuitWithRollback:
    IF @@TRANCOUNT > 0
        BEGIN ROLLBACK TRANSACTION;
        END;
    EndSave:
print 'Created JOB: ' + @JobName ;
END;
GO
PRINT 'Executed proc_GenJobTrackerTableSync.sql';
GO
