
--exec monitor_running_jobs_per_minute
alter PROCEDURE monitor_running_jobs_per_minute
AS
BEGIN
    -- select * from JOB_RUN_TIMES
    DECLARE
           @rundate datetime = GETDATE () ;
    IF NOT EXISTS (SELECT NAME
                     FROM SYS.TABLES
                     WHERE NAME = 'JOB_RUN_TIMES') 
        BEGIN	   
            CREATE TABLE JOB_RUN_TIMES (jobname nvarchar (250) 
                                      , StartDate datetime
                                      , RunTime datetime
                                      , job_id uniqueidentifier
                                      , step_id int
                                      , loop_cnt int
                                      , runid uniqueidentifier
                                      , ElapsedSecs int) ;
            CREATE INDEX PI_JOB_RUN_TIMES ON JOB_RUN_TIMES (runid, job_id, step_id) ;
        END;

    DECLARE
           @iCnt AS int = 0
         , @runid AS uniqueidentifier = NEWID () 
         , @date datetime
         , @ElapsedSecs int = 0
         , @job_id uniqueidentifier = null
         , @step_id int = 0;
    DECLARE
           @iRunning AS int = 0
         , @msg nvarchar (500) ;
    WHILE @iRunning < 1000
        BEGIN
            SET @ElapsedSecs = DATEDIFF (s, @rundate, GETDATE ()) ;
            SET @date = GETDATE () ;
            SET @iRunning = @iRunning+1;
            IF NOT EXISTS (SELECT job_id
                             FROM JOB_RUN_TIMES
                             WHERE runid = @runid
                               AND job_id = @job_id
                               AND step_id = @step_id) 
                BEGIN
                    INSERT INTO JOB_RUN_TIMES (jobname
                                             , StartDate
                                             , RunTime
                                             , job_id
                                             , step_id
                                             , loop_cnt
                                             , runid
                                             , ElapsedSecs) 
                    SELECT j.name
                         , @rundate
                         , @date
                         , j.job_id
                         , js.step_id
                         , @iRunning
                         , @runid
                         , @ElapsedSecs
                      FROM msdb.dbo.sysjobactivity AS ja
                           LEFT JOIN
                           msdb.dbo.sysjobhistory AS jh
                           ON ja.job_history_id = jh.instance_id
                           JOIN
                           msdb.dbo.sysjobs AS j
                           ON ja.job_id = j.job_id
                           JOIN
                           msdb.dbo.sysjobsteps AS js
                           ON ja.job_id = js.job_id
                          AND ISNULL (ja.last_executed_step_id, 0) +1 = js.step_id
                      WHERE ja.session_id = (
                            SELECT TOP 1 session_id
                              FROM msdb.dbo.syssessions
                              ORDER BY agent_start_date DESC)
                        AND start_execution_date IS NOT NULL
                        AND stop_execution_date IS NULL;
                END;
            ELSE
                BEGIN
                    UPDATE JOB_RUN_TIMES
                      SET RunTime = @date
                        , loop_cnt = @iRunning
                        , ElapsedSecs = @ElapsedSecs
                    WHERE job_id = @job_id
                      AND step_id = @step_id
                      AND runid = @runid;

                END;

            SET @iCnt = (SELECT COUNT (*)
                           FROM msdb.dbo.sysjobactivity AS ja
                                LEFT JOIN
                                msdb.dbo.sysjobhistory AS jh
                                ON ja.job_history_id = jh.instance_id
                                JOIN
                                msdb.dbo.sysjobs AS j
                                ON ja.job_id = j.job_id
                                JOIN
                                msdb.dbo.sysjobsteps AS js
                                ON ja.job_id = js.job_id
                               AND ISNULL (ja.last_executed_step_id, 0) +1 = js.step_id
                           WHERE ja.session_id = (
                                 SELECT TOP 1 session_id
                                   FROM msdb.dbo.syssessions
                                   ORDER BY agent_start_date DESC)
                             AND start_execution_date IS NOT NULL
                             AND stop_execution_date IS NULL) ;

            WAITFOR DELAY '00:01:00';

            SET @msg = '# Active Jobs:  '+CAST (@iCnt AS nvarchar (50)) +' / '+CAST (@iRunning*10 AS nvarchar (50)) +' minutes.';
            --SELECT
            --		j.name, @rundate, @date 
            --		FROM msdb.dbo.sysjobactivity ja 
            --		LEFT JOIN msdb.dbo.sysjobhistory jh 
            --			ON ja.job_history_id = jh.instance_id
            --		JOIN msdb.dbo.sysjobs j 
            --		ON ja.job_id = j.job_id
            --		JOIN msdb.dbo.sysjobsteps js
            --			ON ja.job_id = js.job_id
            --			AND ISNULL(ja.last_executed_step_id,0)+1 = js.step_id
            --		WHERE ja.session_id = (SELECT TOP 1 session_id FROM msdb.dbo.syssessions ORDER BY agent_start_date DESC)
            --		AND start_execution_date is not null
            --		AND stop_execution_date is null ;
            EXEC PrintImmediate @msg;
            IF @iCnt = 0
                BEGIN
                    RETURN;
                END;
        END;
END;