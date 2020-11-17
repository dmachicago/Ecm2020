
--exec sp_helplogins
--@owner_login_name

go
print 'Creating proc_MonitorLogStats.SQL' ;
go

/*
DBCC SQLPERF( logspace );
*/

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'spSQLPerf' )
    BEGIN
        DROP PROCEDURE
             spSQLPerf
    END;
GO

CREATE PROC dbo.spSQLPerf
AS
BEGIN
    DBCC SQLPERF( logspace );
END;
GO

/*
exec spGetSQLPerfStats ;
go
select * from logSpaceStats order by id desc
*/
IF NOT EXISTS ( SELECT
                       name
                  FROM sys.tables
                  WHERE name = 'logSpaceStats' )
    BEGIN
        CREATE TABLE dbo.logSpaceStats
        (
                     id int IDENTITY ( 1 , 1 ) ,
                     logDate datetime DEFAULT GETDATE( ) ,
                     databaseName sysname ,
                     logSize decimal( 18 , 5 ) ,
                     logUsed decimal( 18 , 5 )
        );
    END;
GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'spGetSQLPerfStats' )
    BEGIN
        DROP PROCEDURE
             spGetSQLPerfStats
    END;
GO

CREATE PROC dbo.spGetSQLPerfStats
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #tFileList
    (
                 databaseName sysname ,
                 logSize decimal( 18 , 5 ) ,
                 logUsed decimal( 18 , 5 ) ,
                 status int
    );

    INSERT INTO #tFileList
    EXEC spSQLPerf;

    INSERT INTO logSpaceStats (
           databaseName ,
           logSize ,
           logUsed )
    SELECT
           databasename ,
           logSize ,
           logUsed
      FROM #tFileList;

    DROP TABLE
         #tFileList;
END;
GO

EXEC spGetSQLPerfStats;

--SELECT * FROM dbo.logSpaceStats;

GO

PRINT 'Creating JOB job_MonitorLogStats' ;
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
   @JNAME AS nvarchar (100) = 'job_MonitorLogStats_' + @TGTDB;

IF EXISTS (SELECT job_id 
            FROM msdb.dbo.sysjobs_view 
            WHERE name = @JNAME)
begin
    EXEC msdb..sp_delete_job @job_name = @JNAME;
end;


/****** Object:  Job [job_MonitorLogStats]    Script Date: 6/14/2015 8:10:16 AM ******/
BEGIN TRANSACTION
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 6/14/2015 8:10:16 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name= @JNAME, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Track the daily SQL log growth', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'ALIEN15\wmiller', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [acquireStats]    Script Date: 6/14/2015 8:10:17 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'acquireStats', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC spGetSQLPerfStats;', 
		@database_name= @TGTDB, 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'LogMonitorSchedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150614, 
		@active_end_date=99991231, 
		@active_start_time=210000, 
		@active_end_time=235959, 
		@schedule_uid=N'7fc5fb9d-207b-4814-97c2-0a512a65c47e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:


go
--select * from view_logSpaceStats
if exists (select name from sys.views where name = 'view_logSpaceStats')
    drop view view_logSpaceStats ;
go
create view view_logSpaceStats
as
SELECT [id]
      ,[logDate] as LogEntryDate
      ,[databaseName]
      ,[logSize] as LogSizeMB
      ,[logUsed] as LogPctUsed
  FROM [dbo].[logSpaceStats]
GO

print 'Created proc_MonitorLogStats.SQL' ;

go


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
