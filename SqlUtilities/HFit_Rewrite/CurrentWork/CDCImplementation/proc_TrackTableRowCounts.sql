
-- select 'Truncate Table ' + table_name + char(10) + 'GO' + char(10) from INFORMATION_SCHEMA.TABLES where tbale_name like '%_del'
-- use KenticoCMS_Datamart_2
GO
PRINT 'Executing proc_TrackTableRowCounts.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_TrackTableRowCounts') 
    BEGIN
        DROP PROCEDURE
             proc_TrackTableRowCounts;
    END;
GO

CREATE PROCEDURE proc_TrackTableRowCounts
AS
BEGIN

/*******************************************************************************
Author:	  W. Dale Miller
Contact:	  wdalemiller@gmail.com
Use:		  exec proc_TrackTableRowCounts

select top 100 * from MART_TableRowCounts order by TblRowCount desc, TblName asc
*******************************************************************************/
    -- truncate table MART_TableRowCounts
    IF NOT EXISTS (SELECT
                          name
                   FROM sys.tables
                   WHERE
                          name = 'MART_TableRowCounts') 
        BEGIN
            CREATE TABLE MART_TableRowCounts (
                         TblName NVARCHAR (250) 
                       , TblRowCount BIGINT
                       , OnDate DATETIME2 (7)) ;
            CREATE CLUSTERED INDEX PI_MART_TableRowCounts ON MART_TableRowCounts (TblName) ;
        END;

    DECLARE
    @i AS BIGINT
  , @j AS BIGINT
  , @k AS BIGINT
  , @MySql AS NVARCHAR (MAX) 
  , @T AS NVARCHAR (250) = ''
  , @T1 AS NVARCHAR (250) = ''
  , @msg AS NVARCHAR (MAX) ;

    SET @j = (SELECT
                     COUNT (1) 
              FROM sys.tables) ;

    SET @k = 0;
    DECLARE C CURSOR
        FOR
            SELECT
                   name
            FROM sys.tables;

    OPEN C;

    FETCH NEXT FROM C INTO @T;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @K = @k + 1;
            SET  @T1 = @T;
            SET @T = '[' + @T + ']';
            EXEC @i = proc_QuickRowCount @T;
            SET @msg = 'Processing: ' + @T + ' / ' + CAST (@k AS NVARCHAR (50)) + ' of ' + CAST (@j AS NVARCHAR (50)) + ' - #Recs: ' + CAST (@i AS NVARCHAR (50)) ;
            EXEC PrintImmediate @msg;
            INSERT INTO MART_TableRowCounts (
                   TblName
                 , TblRowCount
                 , OnDate) 
            VALUES (@T1 , @i , GETDATE ()) ;

            FETCH NEXT FROM C INTO @T;
        END;

    CLOSE C;
    DEALLOCATE C;
END;

GO
PRINT 'From within proc_TrackTableRowCounts.sql - creating job "JOB_TrackTableRowCounts" ';
GO

/**************************************************************************************
***** Object:  Job [JOB_TrackTableRowCounts]    Script Date: 3/10/2016 9:23:27 AM *****
**************************************************************************************/
IF EXISTS (SELECT
                  job_id
           FROM msdb.dbo.sysjobs_view
           WHERE
                  name = N'JOB_TrackTableRowCounts') 
    BEGIN
        EXEC msdb..sp_delete_job
        @job_name = N'JOB_TrackTableRowCounts'
    END;
GO

/**************************************************************************************
***** Object:  Job [JOB_TrackTableRowCounts]    Script Date: 3/10/2016 9:23:27 AM *****
**************************************************************************************/
BEGIN TRANSACTION;
DECLARE @DBNAME AS NVARCHAR (250) = DB_NAME () ;
DECLARE @ReturnCode INT;
SELECT
       @ReturnCode = 0;

/***********************************************************************************************
***** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 3/10/2016 9:23:28 AM *****
***********************************************************************************************/
IF NOT EXISTS (SELECT
                      name
               FROM msdb.dbo.syscategories
               WHERE
                      name = N'[Uncategorized (Local)]' AND
                      category_class = 1) 
    BEGIN
        EXEC @ReturnCode = msdb.dbo.sp_add_category @class = N'JOB', @type = N'LOCAL', @name = N'[Uncategorized (Local)]';
        IF
           @@ERROR <> 0 OR @ReturnCode <> 0
            BEGIN GOTO QuitWithRollback
            END;

    END;

DECLARE @jobId BINARY (16) ;
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name = N'JOB_TrackTableRowCounts',
@enabled = 1,
@notify_level_eventlog = 0,
@notify_level_email = 0,
@notify_level_netsend = 0,
@notify_level_page = 0,
@delete_level = 0,
@description = N'No description available.',
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'sa', @job_id = @jobId OUTPUT;
IF
   @@ERROR <> 0 OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;

/********************************************************************************************
***** Object:  Step [RUN proc_TrackTableRowCounts]    Script Date: 3/10/2016 9:23:30 AM *****
********************************************************************************************/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @jobId, @step_name = N'RUN proc_TrackTableRowCounts',
@step_id = 1,
@cmdexec_success_code = 0,
@on_success_action = 1,
@on_success_step_id = 0,
@on_fail_action = 2,
@on_fail_step_id = 0,
@retry_attempts = 0,
@retry_interval = 0,
@os_run_priority = 0, @subsystem = N'TSQL',
@command = N'exec proc_TrackTableRowCounts',
@database_name = @DBNAME,
@flags = 0;
IF
   @@ERROR <> 0 OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;
IF
   @@ERROR <> 0 OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @jobId, @name = N'Schedule TrackTableRowCounts',
@enabled = 1,
@freq_type = 4,
@freq_interval = 1,
@freq_subday_type = 1,
@freq_subday_interval = 0,
@freq_relative_interval = 0,
@freq_recurrence_factor = 0,
@active_start_date = 20160310,
@active_end_date = 99991231,
@active_start_time = 170000,
@active_end_time = 235959,
@schedule_uid = N'100bd66b-62a8-4463-afd5-b7b3602dc91c';
IF
   @@ERROR <> 0 OR @ReturnCode <> 0
    BEGIN GOTO QuitWithRollback
    END;
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
IF
   @@ERROR <> 0 OR @ReturnCode <> 0
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
PRINT 'Executed proc_TrackTableRowCounts.sql';
GO