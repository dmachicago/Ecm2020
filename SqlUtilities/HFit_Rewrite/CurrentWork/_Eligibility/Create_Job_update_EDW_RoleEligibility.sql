
GO
-- use KenticoCMS_Prod3
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;

GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;

--This statement is here so that if the old version exists, it will be removed.
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = 'JOB_Update_EDW_RoleEligibility')
BEGIN
    print ('Dropping JOB JOB_Update_EDW_RoleEligibility');
    EXEC msdb.dbo.sp_delete_job @job_name='JOB_Update_EDW_RoleEligibility', @delete_unused_schedule=1
END

IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @Jname)
BEGIN
    print ('Dropping JOB JOB_Update_EDW_RoleEligibility');
    EXEC msdb.dbo.sp_delete_job @job_name=@Jname, @delete_unused_schedule=1
END
ELSE
    print ('JOB_Update_EDW_RoleEligibility DOES NOT exist, creating new instance.');
GO

print ('Creating JOB JOB_Update_EDW_RoleEligibility');
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=@Jname, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Update PPT eilgibility daily based upon ROLE.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBA_Email',
		@job_id = @jobId OUTPUT
--select @jobId
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


declare @SVRNAME nvarchar(100) ;
set @SVRNAME = (select @@SERVERNAME);

EXEC msdb.dbo.sp_add_jobserver @job_name=@Jname, @server_name = @SVRNAME
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


EXEC msdb.dbo.sp_add_jobstep @job_name=@Jname, @step_name=N'Update ROLE Eligibility', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec proc_EDW_RoleEligibilityDaily;
		  exec proc_EDW_RoleEligibilityStarted;
		  exec proc_EDW_RoleEligibilityExpired;', 
		@database_name=@DBN, 
		@flags=0
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


EXEC msdb.dbo.sp_update_job @job_name=@Jname, 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Update PPT eilgibility daily based upon ROLE.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBA_Email', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N''
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=@Jname, @name=N'EDW_Role_Eligibility_Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=12, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20150409, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
--select @schedule_id
GO
print ('JOB_Update_EDW_RoleEligibility CREATED.');
go 
