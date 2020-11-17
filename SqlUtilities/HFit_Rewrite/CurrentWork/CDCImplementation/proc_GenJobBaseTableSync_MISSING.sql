
-- use KenticoCMS_Datamart_2 
-- exec proc_GenJobBaseTableSync_MISSING
GO
PRINT 'Executing proc_GenJobBaseTableSync_MISSING.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GenJobBaseTableSync_MISSING') 
    BEGIN
        DROP PROCEDURE
             proc_GenJobBaseTableSync_MISSING
    END;
GO
CREATE PROCEDURE proc_GenJobBaseTableSync_MISSING
AS
BEGIN
    print 'proc_GenJobBaseTableSync determined to be missing, recreating.';
    DECLARE
           @SS AS NVARCHAR (MAX) = '' + char (10) ;

    SET @SS = @SS + 'CREATE PROCEDURE proc_GenJobBaseTableSync' + char (10) ;
    SET @SS = @SS + '(' + char (10) ;
    SET @SS = @SS + '     @Interval AS int = 1' + char (10) ;
    SET @SS = @SS + '   , @ProcName AS nvarchar (250)) ' + char (10) ;
    SET @SS = @SS + 'AS' + char (10) ;
    SET @SS = @SS + 'BEGIN' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    DECLARE @JobName AS nvarchar (250) = `job_` + @ProcName;' + char (10) ;
    SET @SS = @SS + '    DECLARE @StepName AS nvarchar (250) = N`RUN ` + @ProcName;' + char (10) ;
    SET @SS = @SS + '    DECLARE @SchedName AS nvarchar (250) = `SCHED ` + @ProcName;' + char (10) ;
    SET @SS = @SS + '    DECLARE @CMD AS nvarchar (250) = `exec ` + @ProcName;' + char (10) ;
    SET @SS = @SS + '    DECLARE @JobGuid AS nvarchar (50) = CAST (NEWID () AS nvarchar (50)) ;' + char (10) ;
    SET @SS = @SS + '    DECLARE @StartTime AS nvarchar(50) = `0`;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    IF EXISTS (SELECT' + char (10) ;
    SET @SS = @SS + '                      job_id' + char (10) ;
    SET @SS = @SS + '                      FROM msdb.dbo.sysjobs_view' + char (10) ;
    SET @SS = @SS + '                      WHERE name = @JobName) ' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '            EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule = 1;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    IF CHARINDEX (`_1_`, @ProcName) > 0' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '	   set @Interval = 1 ;' + char (10) ;
    SET @SS = @SS + '            SET @StartTime = `1000`;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '  IF CHARINDEX (`_2_`, @ProcName) > 0' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '    set @Interval = 2 ;' + char (10) ;
    SET @SS = @SS + '            SET  @StartTime = `002000`;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '  IF CHARINDEX (`_3_`, @ProcName) > 0' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '    set @Interval = 3 ;' + char (10) ;
    SET @SS = @SS + '            SET  @StartTime = `003000`;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    IF @Interval = 1' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '            SET @StartTime = 1000;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    IF @Interval = 2' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '            SET  @StartTime = 2000;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    IF @Interval = 3' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '            SET @StartTime = 3000;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    --print `@StartTime: ` + cast(@StartTime as nvarchar(50)) ;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    BEGIN TRANSACTION;' + char (10) ;
    SET @SS = @SS + '    DECLARE @ReturnCode int;' + char (10) ;
    SET @SS = @SS + '    SELECT' + char (10) ;
    SET @SS = @SS + '           @ReturnCode = 0;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    IF NOT EXISTS (SELECT' + char (10) ;
    SET @SS = @SS + '                          name' + char (10) ;
    SET @SS = @SS + '                          FROM msdb.dbo.syscategories' + char (10) ;
    SET @SS = @SS + '                          WHERE name = N`[Uncategorized (Local)]`' + char (10) ;
    SET @SS = @SS + '                            AND category_class = 1) ' + char (10) ;
    SET @SS = @SS + '        BEGIN' + char (10) ;
    SET @SS = @SS + '            EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N`JOB`, @type = N`LOCAL`, @name = N`[Uncategorized (Local)]`;' + char (10) ;
    SET @SS = @SS + '            IF @@ERROR <> 0' + char (10) ;
    SET @SS = @SS + '            OR @ReturnCode <> 0' + char (10) ;
    SET @SS = @SS + '                BEGIN GOTO QuitWithRollback;' + char (10) ;
    SET @SS = @SS + '                END;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    DECLARE @jobId binary (16) ;' + char (10) ;
    SET @SS = @SS + '    EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = @JobName,' + char (10) ;
    SET @SS = @SS + '    @enabled = 1,' + char (10) ;
    SET @SS = @SS + '    @notify_level_eventlog = 0,' + char (10) ;
    SET @SS = @SS + '    @notify_level_email = 2,' + char (10) ;
    SET @SS = @SS + '    @notify_level_netsend = 2,' + char (10) ;
    SET @SS = @SS + '    @notify_level_page = 0,' + char (10) ;
    SET @SS = @SS + '    @delete_level = 0,' + char (10) ;
    SET @SS = @SS + '    @description = N`No description available.`,' + char (10) ;
    SET @SS = @SS + '    @category_name = N`[Uncategorized (Local)]`,' + char (10) ;
    SET @SS = @SS + '    @owner_login_name = N`sa`,' + char (10) ;
    SET @SS = @SS + '    @notify_email_operator_name = N`DBA_Notify`,' + char (10) ;
    SET @SS = @SS + '    @notify_netsend_operator_name = N`DBA_Email`, @job_id = @jobId OUTPUT;' + char (10) ;
    SET @SS = @SS + '    IF @@ERROR <> 0' + char (10) ;
    SET @SS = @SS + '    OR @ReturnCode <> 0' + char (10) ;
    SET @SS = @SS + '        BEGIN GOTO QuitWithRollback;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + '    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId, @step_name = @StepName,' + char (10) ;
    SET @SS = @SS + '    @step_id = 1,' + char (10) ;
    SET @SS = @SS + '    @cmdexec_success_code = 0,' + char (10) ;
    SET @SS = @SS + '    @on_success_action = 1,' + char (10) ;
    SET @SS = @SS + '    @on_success_step_id = 0,' + char (10) ;
    SET @SS = @SS + '    @on_fail_action = 2,' + char (10) ;
    SET @SS = @SS + '    @on_fail_step_id = 0,' + char (10) ;
    SET @SS = @SS + '    @retry_attempts = 0,' + char (10) ;
    SET @SS = @SS + '    @retry_interval = 10,' + char (10) ;
    SET @SS = @SS + '    @os_run_priority = 0, @subsystem = N`TSQL`,' + char (10) ;
    SET @SS = @SS + '    @command = @CMD,' + char (10) ;
    SET @SS = @SS + '    @database_name = N`KenticoCMS_DataMart_2`,' + char (10) ;
    SET @SS = @SS + '    @flags = 0;' + char (10) ;
    SET @SS = @SS + '    IF @@ERROR <> 0' + char (10) ;
    SET @SS = @SS + '    OR @ReturnCode <> 0' + char (10) ;
    SET @SS = @SS + '        BEGIN GOTO QuitWithRollback;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;' + char (10) ;
    SET @SS = @SS + '    IF @@ERROR <> 0' + char (10) ;
    SET @SS = @SS + '    OR @ReturnCode <> 0' + char (10) ;
    SET @SS = @SS + '        BEGIN GOTO QuitWithRollback;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = @SchedName,' + char (10) ;
    SET @SS = @SS + '    @enabled = 1,' + char (10) ;
    SET @SS = @SS + '    @freq_type = 4,' + char (10) ;
    SET @SS = @SS + '    @freq_interval = 1,' + char (10) ;
    SET @SS = @SS + '    @freq_subday_type = 1,' + char (10) ;
    SET @SS = @SS + '    @freq_subday_interval = 0,' + char (10) ;
    SET @SS = @SS + '    @freq_relative_interval = 0,' + char (10) ;
    SET @SS = @SS + '    @freq_recurrence_factor = 0,' + char (10) ;
    SET @SS = @SS + '    @active_start_date = 20151114,' + char (10) ;
    SET @SS = @SS + '    @active_end_date = 99991231,' + char (10) ;
    SET @SS = @SS + '    @active_start_time = @StartTime,' + char (10) ;
    SET @SS = @SS + '    @active_end_time = 235959,' + char (10) ;
    SET @SS = @SS + '    @schedule_uid = @JobGuid;' + char (10) ;
    SET @SS = @SS + '    IF @@ERROR <> 0' + char (10) ;
    SET @SS = @SS + '    OR @ReturnCode <> 0' + char (10) ;
    SET @SS = @SS + '        BEGIN GOTO QuitWithRollback;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N`(local)`;' + char (10) ;
    SET @SS = @SS + '    IF @@ERROR <> 0' + char (10) ;
    SET @SS = @SS + '    OR @ReturnCode <> 0' + char (10) ;
    SET @SS = @SS + '        BEGIN GOTO QuitWithRollback;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    COMMIT TRANSACTION;' + char (10) ;
    SET @SS = @SS + '    GOTO EndSave;' + char (10) ;
    SET @SS = @SS + '    QuitWithRollback:' + char (10) ;
    SET @SS = @SS + '    IF @@TRANCOUNT > 0' + char (10) ;
    SET @SS = @SS + '        BEGIN ROLLBACK TRANSACTION;' + char (10) ;
    SET @SS = @SS + '        END;' + char (10) ;
    SET @SS = @SS + '    EndSave:' + char (10) ;
    SET @SS = @SS + '' + char (10) ;
    SET @SS = @SS + 'END;' + char (10) ;

    SET @SS = replace (@SS , '`' , '''') ;
    EXEC (@SS) ;

END;

GO
PRINT 'Executed proc_GenJobBaseTableSync_MISSING.sql';
GO