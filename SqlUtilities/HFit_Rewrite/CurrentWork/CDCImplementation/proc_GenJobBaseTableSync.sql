
-- use KenticoCMS_Datamart_2
go
print 'Executing proc_GenJobBaseTableSync.sql'
go

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_GenJobBaseTableSync') 
    BEGIN
    print 'DROPPING and Reinstalling proc_GenJobBaseTableSync.sql'
        DROP PROCEDURE	   --DROPPING and Reinstalling proc_GenJobBaseTableSync.sql
             proc_GenJobBaseTableSync;
    END;
GO
-- exec proc_GenJobBaseTableSync 3, 'proc_BASE_CMS_Document_KenticoCMS_2_Insert'
CREATE PROCEDURE proc_GenJobBaseTableSync
(
     @Interval AS int = 1
   , @ProcName AS nvarchar (250)) 
AS
BEGIN

    DECLARE @JobName AS nvarchar (250) = 'job_' + @ProcName;
    DECLARE @StepName AS nvarchar (250) = N'RUN ' + @ProcName;
    DECLARE @SchedName AS nvarchar (250) = 'SCHED ' + @ProcName;
    DECLARE @CMD AS nvarchar (250) = 'exec ' + @ProcName;
    DECLARE @JobGuid AS nvarchar (50) = CAST (NEWID () AS nvarchar (50)) ;
    DECLARE @StartTime AS nvarchar(50) = '0';
    DECLARE @DBNAME AS nvarchar(50) = DB_NAME();

    IF EXISTS (SELECT
                      job_id
                      FROM msdb.dbo.sysjobs_view
                      WHERE name = @JobName) 
        BEGIN
            EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule = 1;
        END;

    IF CHARINDEX ('_1_', @ProcName) > 0
        BEGIN
	   set @Interval = 1 ;
            SET @StartTime = '1000';
        END;
  IF CHARINDEX ('_2_', @ProcName) > 0
        BEGIN
    set @Interval = 2 ;
            SET  @StartTime = '002000';
        END;
  IF CHARINDEX ('_3_', @ProcName) > 0
        BEGIN
    set @Interval = 3 ;
            SET  @StartTime = '003000';
        END;
    IF @Interval = 1
        BEGIN
            SET @StartTime = 1000;
        END;
    IF @Interval = 2
        BEGIN
            SET  @StartTime = 2000;
        END;
    IF @Interval = 3
        BEGIN
            SET @StartTime = 3000;
        END;

    --print '@StartTime: ' + cast(@StartTime as nvarchar(50)) ;

    BEGIN TRANSACTION;
    DECLARE @ReturnCode int;
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

    DECLARE @jobId binary (16) ;
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
    @notify_netsend_operator_name = N'DBA_Email', @job_id = @jobId OUTPUT;
    IF @@ERROR <> 0
    OR @ReturnCode <> 0
        BEGIN GOTO QuitWithRollback;
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
    @database_name = @DBNAME,
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
    @active_start_date = 20151114,
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

END;
go
print 'Executed proc_GenJobBaseTableSync.sql'
go
