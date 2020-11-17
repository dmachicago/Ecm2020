
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
            CREATE TABLE JOB_RUN_TIMES (jobname nvarchar (250) , 
                                        StartDate datetime , 
                                        RunTime datetime) 
        END;

    DECLARE
          @iCnt AS int = 0;
    DECLARE
          @iRunning AS int = 0 , 
          @msg nvarchar (500) ;
    WHILE @iRunning < 1000
        BEGIN
            DECLARE
                  @date datetime = GETDATE () ;
            SET @iRunning = @iRunning + 1;
            INSERT INTO JOB_RUN_TIMES (jobname , 
                                       StartDate , 
                                       RunTime) 
            SELECT j.name , 
                   @rundate , 
                   @date
              FROM
                   msdb.dbo.sysjobactivity AS ja
                   LEFT JOIN msdb.dbo.sysjobhistory AS jh
                   ON ja.job_history_id = jh.instance_id
                   JOIN msdb.dbo.sysjobs AS j
                   ON ja.job_id = j.job_id
                   JOIN msdb.dbo.sysjobsteps AS js
                   ON ja.job_id = js.job_id
                  AND ISNULL (ja.last_executed_step_id , 0) + 1 = js.step_id
              WHERE ja.session_id = (
                                     SELECT TOP 1 session_id
                                       FROM msdb.dbo.syssessions
                                       ORDER BY agent_start_date DESC)
                AND start_execution_date IS NOT NULL
                AND stop_execution_date IS NULL;

            SET @iCnt = (SELECT COUNT (*)
                           FROM
                                msdb.dbo.sysjobactivity AS ja
                                LEFT JOIN msdb.dbo.sysjobhistory AS jh
                                ON ja.job_history_id = jh.instance_id
                                JOIN msdb.dbo.sysjobs AS j
                                ON ja.job_id = j.job_id
                                JOIN msdb.dbo.sysjobsteps AS js
                                ON ja.job_id = js.job_id
                               AND ISNULL (ja.last_executed_step_id , 0) + 1 = js.step_id
                           WHERE ja.session_id = (
                                                  SELECT TOP 1 session_id
                                                    FROM msdb.dbo.syssessions
                                                    ORDER BY agent_start_date DESC)
                             AND start_execution_date IS NOT NULL
                             AND stop_execution_date IS NULL) ;

            WAITFOR DELAY '00:01:00';

            SET @msg = '# Active Jobs:  ' + CAST (@iCnt AS nvarchar (50)) + ' / ' + CAST (@iRunning AS nvarchar (50)) + ' mins.';
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
                    RETURN
                END;
        END;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
