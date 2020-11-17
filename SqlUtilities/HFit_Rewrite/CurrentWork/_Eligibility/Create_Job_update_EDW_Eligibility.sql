
GO
-- use KenticoCMS_Prod3
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());

DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

--USE [msdb]
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

--This statement is here so that if the old version exists, it will be removed.
IF EXISTS (SELECT
                  job_id
                  FROM msdb.dbo.sysjobs_view
                  WHERE name = 'JOB_Update_EDW_Eligibility') 
    BEGIN
        PRINT 'Dropping JOB JOB_Update_EDW_Eligibility';
        EXEC msdb.dbo.sp_delete_job @job_name = 'JOB_Update_EDW_Eligibility', @delete_unused_schedule = 1;
    END;

IF EXISTS (SELECT
                  job_id
                  FROM msdb.dbo.sysjobs_view
                  WHERE name = @Jname) 
    BEGIN
        PRINT 'Dropping JOB JOB_Update_EDW_Eligibility';
        EXEC msdb.dbo.sp_delete_job @job_name = @Jname, @delete_unused_schedule = 1;
    END;
ELSE
    BEGIN
        PRINT 'JOB_Update_EDW_Eligibility DOES NOT exists.';
    END;
GO

PRINT 'Creating JOB JOB_Update_EDW_Eligibility';
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

DECLARE @jobId binary (16) ;
EXEC msdb.dbo.sp_add_job @job_name = @Jname,
@enabled = 1,
@notify_level_eventlog = 0,
@notify_level_email = 2,
@notify_level_netsend = 2,
@notify_level_page = 2,
@delete_level = 0,
@description = N'Updates the daily status of the PPT eligibility allowing for the EDW to track current and expired eligibilities.',
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'SA', @job_id = @jobId OUTPUT;
--select @jobId
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

DECLARE @ServerName nvarchar (80) ;
SET @ServerName = (SELECT
                          @@SERVERNAME );
EXEC msdb.dbo.sp_add_jobserver @job_name = @Jname, @server_name = @ServerName;
GO
--USE [msdb]
GO

DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

EXEC msdb.dbo.sp_add_jobstep @job_name = @Jname, @step_name = N'update the eligibility history',
@step_id = 1,
@cmdexec_success_code = 0,
@on_success_action = 1,
@on_fail_action = 2,
@retry_attempts = 0,
@retry_interval = 0,
@os_run_priority = 0, @subsystem = N'TSQL',
@command = N'exec proc_build_EDW_Eligibility',
@database_name = @DBN,
@flags = 0;
GO
--USE [msdb]

GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

EXEC msdb.dbo.sp_update_job @job_name = @Jname,
@enabled = 1,
@start_step_id = 1,
@notify_level_eventlog = 0,
@notify_level_email = 2,
@notify_level_netsend = 2,
@notify_level_page = 2,
@delete_level = 0,
@description = N'Updates the daily status of the PPT eligibility allowing for the EDW to track current and expired eligibilities.',
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'SA',
@notify_email_operator_name = N'DBA_Email',
@notify_netsend_operator_name = N'',
@notify_page_operator_name = N'';
GO
--USE [msdb]
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

DECLARE @schedule_id int;
EXEC msdb.dbo.sp_add_jobschedule @job_name = @Jname, @name = N'Schedule for Update EDW Eligibility',
@enabled = 1,
@freq_type = 4,
@freq_interval = 1,
@freq_subday_type = 1,
@freq_subday_interval = 0,
@freq_relative_interval = 0,
@freq_recurrence_factor = 1,
@active_start_date = 20150204,
@active_end_date = 99991231,
@active_start_time = 190000,
@active_end_time = 235959, @schedule_id = @schedule_id OUTPUT;
--select @schedule_id
GO


