USE [DataMartPlatform];
GO

/****** Object:  StoredProcedure [dbo].[RunAllMARTJobs]    Script Date: 2/14/2017 7:33:33 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- exec RunAllMARTJobs 
ALTER PROCEDURE dbo.RunAllMARTJobs (@WithDelay bit = 0) 
AS
BEGIN
    DECLARE
           @RetStatus int;
    --EXEC sp_sp_start_job_wait @job_name = 'job_proc_view_CMS_USER_KenticoCMS_PRD_1' , @WaitTime = '00:02:00' , @JobCompletionStatus = @RetStatus;
    BEGIN TRY
        CREATE TABLE #ACTIVE_CT_JOBS (jobname nvarchar (250) NOT NULL) ;
        CREATE INDEX IDX_ACTIVE_JOBS ON #ACTIVE_CT_JOBS (jobname) ;
    END TRY
    BEGIN CATCH
        PRINT 'INIT #ACTIVE_CT_JOBS';
    END CATCH;

    BEGIN TRY
        CREATE TABLE #RUNNING_JOBS (jobname nvarchar (250)) ;
        CREATE INDEX IDX_RUNNING_JOBS ON #RUNNING_JOBS (jobname) ;
    END TRY
    BEGIN CATCH
        PRINT 'INIT #RUNNING_JOBS';
    END CATCH;

    IF @WithDelay = 1
        BEGIN EXEC sp_sp_start_job_wait @job_name = 'JOB_PROC_Activate_Monitor_BR', @WaitTime = '00:02:00', @JobCompletionStatus = @RetStatus;
        END;

    DECLARE
           @MySql AS nvarchar (max) 
         , @JNAME AS nvarchar (250) 
         , @T AS nvarchar (250) = '';

    DECLARE C CURSOR
        FOR SELECT name
                 , 'EXEC msdb..sp_start_job ''' + name + ''''
              FROM msdb.dbo.sysjobs AS job
              WHERE name LIKE 'job[_]proc[_]%'
                AND name LIKE '%[_]1%'
                AND name NOT LIKE '%[_]delete'
                AND name NOT LIKE 'JOB_PROC_Activate_Monitor_BR'
                AND enabled = 1;

    OPEN C;
    FETCH NEXT FROM C INTO @JNAME, @T;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = @T;
            EXEC printimmediate @MySQl;
            BEGIN TRY
                EXEC (@MySql) ;
                INSERT INTO #ACTIVE_CT_JOBS (jobname) 
                VALUES
                       (@JNAME) ;
            END TRY
            BEGIN CATCH
                PRINT 'ERROR: ' + @JNAME + ' failed to execute.';
            END CATCH;
            FETCH NEXT FROM C INTO @JNAME, @T;
        END;

    CLOSE C;
    DEALLOCATE C;

    DECLARE
           @RunningJobCnt AS int = 9999
         , @MaxCnt AS int = 999
         , @CurrCnt AS int = 0
         , @msg nvarchar (2000) = NULL
         , @flgBuildCube AS bit = 0
         , @flgAutomateCubeBuild AS bit = 1;

    DELETE FROM #RUNNING_JOBS;

    WHILE @RunningJobCnt > 0
      AND @CurrCnt < @MaxCnt
      AND @flgAutomateCubeBuild = 1
        BEGIN
            IF @RunningJobCnt = 0
                BEGIN
                    SET @Msg = 'MONITORING CT Jobs - when complete, will launch CUBE build...';
                    EXEC PrintImmediate @msg;
                END;
            --Get all RUNNING JOBS W/O
            INSERT INTO #RUNNING_JOBS (jobname) 
            SELECT j.name AS job_name
              FROM msdb.dbo.sysjobactivity ja
                   LEFT JOIN
                   msdb.dbo.sysjobhistory jh
                   ON ja.job_history_id = jh.instance_id
                   JOIN
                   msdb.dbo.sysjobs j
                   ON ja.job_id = j.job_id
                   JOIN
                   msdb.dbo.sysjobsteps js
                   ON ja.job_id = js.job_id
                  AND ISNULL (ja.last_executed_step_id, 0) + 1 = js.step_id
              WHERE ja.session_id = (
                    SELECT TOP 1 session_id
                      FROM msdb.dbo.syssessions
                      ORDER BY agent_start_date DESC)
                AND start_execution_date IS NOT NULL
                AND stop_execution_date IS NULL;

            --Remove all CT jobs from #ACTIVE_CT_JOBS where the JOB is NOT found in #RUNNING_JOBS
            DELETE FROM #ACTIVE_CT_JOBS
            WHERE jobname NOT IN (SELECT jobname
                                    FROM #RUNNING_JOBS) ;

            --Count ALL Active CT jobs
            SET @RunningJobCnt = (SELECT COUNT (*)
                                    FROM #ACTIVE_CT_JOBS) ;

            SET @msg = '#Currently running CT Jobs: ' + CAST (@RunningJobCnt AS nvarchar (50)) ;
            EXEC PrintImmediate @msg;

            IF @RunningJobCnt = 0
                BEGIN
                    SET @flgBuildCube = 1;
                END;
            ELSE
                BEGIN
                    WAITFOR DELAY '00:00:30';
                END;

            DELETE FROM #RUNNING_JOBS;
            SET @CurrCnt = @CurrCnt + 1;

        END;

    IF @flgBuildCube = 1
        BEGIN EXEC msdb..sp_start_job N'DBAPlatform - Process Cubes';
        END;
    ELSE
        BEGIN
            PRINT 'NOTICE : DID NOT launch cube build.';
        END;
END;

 
