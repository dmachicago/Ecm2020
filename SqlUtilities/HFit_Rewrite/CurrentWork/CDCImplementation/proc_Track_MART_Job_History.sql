
-- proc_Track_MART_Job_History.sql

/*****************
 Create TempTable 
*****************/

-- exec proc_Track_MART_Job_History
ALTER PROCEDURE proc_Track_MART_Job_History
AS
BEGIN
    IF EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = 'MART_Job_Execution_History') 
        BEGIN
            GOTO MART_Job_History_EXISTS;
        END;

    -- drop table MART_Job_Execution_History
    CREATE TABLE MART_Job_Execution_History (job_id uniqueidentifier , 
                                             job_name nvarchar (2000) , 
                                             step_id int , 
                                             step_name nvarchar (1000) , 
                                             step_uid uniqueidentifier , 
                                             date_created datetime , 
                                             date_modified datetime , 
                                             log_size bigint , 
                                             log nvarchar (max) , 
                                             last_run_status int , 
                                             JobStatus nvarchar (25) , 
                                             ExecutionStartDate datetime , 
                                             ExecutionEndDate datetime , 
                                             EntryDate datetime DEFAULT GETDATE () , 
                                             RowIdentity bigint IDENTITY (1 , 1) 
                                                                NOT NULL) ;
    CREATE UNIQUE INDEX UI_MART_Job_History ON MART_Job_Execution_History (job_id , step_id , date_created , date_modified) ;
    MART_Job_History_EXISTS:

    IF OBJECT_ID ('TEMPDB..#MART_Job_Execution_History') IS NOT NULL
        BEGIN
            DROP TABLE #MART_Job_Execution_History;
        END;

    CREATE TABLE #MART_Job_Execution_History (job_id uniqueidentifier , 
                                              job_name nvarchar (2000) , 
                                              step_id int , 
                                              step_name nvarchar (1000) , 
                                              step_uid uniqueidentifier , 
                                              date_created datetime , 
                                              date_modified datetime , 
                                              log_size bigint , 
                                              log nvarchar (max)) ;

    DECLARE
          @job_id uniqueidentifier , 
          @job_name nvarchar (2000) , 
          @Name nvarchar (2000) , 
          @step_id int , 
          @step_name nvarchar (1000) , 
          @step_uid uniqueidentifier , 
          @date_created datetime , 
          @date_modified datetime , 
          @start_time datetime , 
          @end_time datetime , 
          @log_size bigint , 
          @log nvarchar (max) , 
          @minutes int = 0 , 
          @last_run_status int = 0 , 
          @JobStatus nvarchar (50) = '';
    DECLARE
          @Tjob_id uniqueidentifier , 
          @Tjob_name nvarchar (2000) , 
          @Tstep_id int , 
          @Tstep_name nvarchar (1000) , 
          @Tstep_uid uniqueidentifier , 
          @Tdate_created datetime , 
          @Tdate_modified datetime , 
          @Tlog_size bigint , 
          @Tlog nvarchar (max) ;

    DECLARE
          @MySql AS nvarchar (max) = '';
    DECLARE
          @T AS nvarchar (250) = '';
    DECLARE CursorExecutedJobs CURSOR
        FOR SELECT name , 
                   j.job_id , 
                   start_execution_date AS start_time , 
                   stop_execution_date AS end_time , 
                   DATEDIFF (minute , start_execution_date , stop_execution_date) AS minutes , 
                   last_run_outcome , 
                   CASE last_run_outcome
                       WHEN 0
                           THEN 'Failed'
                       WHEN 1
                           THEN 'Success'
                       WHEN 2
                           THEN 'Retry'
                       WHEN 3
                           THEN 'Cancelled'
                       WHEN 5
                           THEN 'Unknown'
                   ELSE 'Undetermined'
                   END AS RunStatus
            --'INSERT INTO MART_JOB_ERRORS (job_id , job_name , step_id , step_name , step_uid , date_created , date_modified , log_size , [log] )' + char(10) +  'EXEC msdb..sp_help_jobsteplog @job_name ='''+j.name+'''' + char(10) + 'GO' as InsertCMD
              FROM
                   msdb.dbo.sysjobactivity AS ja
                   INNER JOIN msdb.dbo.sysjobs AS j
                   ON ja.job_id = j.job_id
                   LEFT JOIN msdb.dbo.sysjobsteps AS js
                   ON js.job_id = ja.job_id
                  AND ja.last_executed_step_id = js.step_id
              WHERE start_execution_date IS NOT NULL
                AND stop_execution_date IS NOT NULL
                AND stop_execution_date > GETDATE () - 1;

    OPEN CursorExecutedJobs;

    FETCH NEXT FROM CursorExecutedJobs INTO @Name , @job_id , @start_time , @end_time , @minutes , @last_run_status , @JobStatus;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            truncate TABLE #MART_Job_Execution_History;
            -- EXEC msdb..sp_help_jobsteplog @job_name = 'job_proc_view_EDW_CoachingPPTAvailable_KenticoCMS_3' ;
            SET @MySql = 'INSERT INTO #MART_Job_Execution_History (job_id , job_name , step_id , step_name , step_uid , date_created , date_modified , log_size , [log] ) ' + CHAR (10) + 'EXEC msdb..sp_help_jobsteplog @job_name = N''' + @Name + '''';
            PRINT @MySql;
            EXEC (@MySql) ;
            IF (SELECT COUNT (*)
                  FROM #MART_Job_Execution_History) > 0
                BEGIN
                    DECLARE CursorTemp CURSOR
                        FOR SELECT job_id , 
                                   job_name , 
                                   step_id , 
                                   step_name , 
                                   step_uid , 
                                   date_created , 
                                   date_modified , 
                                   log_size , 
                                   [log]
                              FROM #MART_Job_Execution_History;
				OPEN CursorTemp;
                    FETCH NEXT FROM CursorTemp INTO @Tjob_id , @Tjob_name , @Tstep_id , @Tstep_name , @Tstep_uid , @Tdate_created , @Tdate_modified , @Tlog_size , @Tlog;
					print '@Tjob_name: ' + @Tjob_name ;
                    WHILE @@FETCH_STATUS = 0
                        BEGIN
								print '@Tjob_name: ' + @Tjob_name ;
                            IF (SELECT COUNT (1)
                                  FROM MART_Job_Execution_History
                                  WHERE job_id = @Tjob_id
                                    AND step_id = @Tstep_id
                                    AND date_created = @Tdate_created
                                    AND date_modified = @Tdate_modified) = 0
                                BEGIN
                                    INSERT INTO MART_Job_Execution_History (job_id , 
                                                                            job_name , 
                                                                            step_id , 
                                                                            step_name , 
                                                                            step_uid , 
                                                                            date_created , 
                                                                            date_modified , 
                                                                            log_size , 
                                                                            log , 
                                                                            last_run_status , 
                                                                            JobStatus , 
                                                                            ExecutionStartDate , 
                                                                            ExecutionEndDate) 
                                    VALUES (@Tjob_id , 
                                            @Tjob_name , 
                                            @Tstep_id , 
                                            @Tstep_name , 
                                            @Tstep_uid , 
                                            @Tdate_created , 
                                            @Tdate_modified , 
                                            @Tlog_size , 
                                            @Tlog , 
                                            @last_run_status , 
                                            @JobStatus , 
                                            @start_time , 
                                            @end_time) ;
                                END;
                            ELSE
                                BEGIN
                                    IF (SELECT ExecutionEndDate
                                          FROM MART_Job_Execution_History
                                          WHERE job_id = @Tjob_id
                                            AND step_id = @Tstep_id
                                            AND date_created = @Tdate_created
                                            AND date_modified = @Tdate_modified) IS NULL
                                        BEGIN
                                            UPDATE MART_Job_Execution_History
                                              SET ExecutionEndDate = @end_time
                                              WHERE job_id = @Tjob_id
                                                AND step_id = @Tstep_id
                                                AND date_created = @Tdate_created
                                                AND date_modified = @Tdate_modified;
                                        END;
                                END;
                            FETCH NEXT FROM CursorTemp INTO @Tjob_id , @Tjob_name , @Tstep_id , @Tstep_name , @Tstep_uid , @Tdate_created , @Tdate_modified , @Tlog_size , @Tlog;
                        END;
				    CLOSE CursorTemp;
				    DEALLOCATE CursorTemp;
                END;

            FETCH NEXT FROM CursorExecutedJobs INTO @Name , @job_id , @start_time , @end_time , @minutes , @last_run_status , @JobStatus;

        END;

    CLOSE CursorExecutedJobs;
    DEALLOCATE CursorExecutedJobs;

--/*************************************
-- Run SP and Insert Value in TempTable 
--*************************************/

--    INSERT INTO #MART_Job_Execution_History (job_id , 
--                                             job_name , 
--                                             step_id , 
--                                             step_name , 
--                                             step_uid , 
--                                             date_created , 
--                                             date_modified , 
--                                             log_size , 
--                                             log) 
--    EXEC msdb..sp_help_jobsteplog @job_name = N'job_proc_BASE_HFit_RewardsAwardUserDetailArchive_KenticoCMS_1_ApplyCT';
END;

GO

