
-- FIND ACTIVELY RUNNING QUERIES
SELECT sqltext.TEXT as ActiveQuery,
req.session_id,
req.status,
req.command,
req.cpu_time,
req.total_elapsed_time
FROM sys.dm_exec_requests req
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS sqltext

-- GET JOBS AND THEIR COMPLETION DATES & RUN TIMES
SELECT
    ja.job_id,
    j.name AS job_name,
    ja.start_execution_date,      
	ja.stop_execution_date, 
	datediff(minute, ja.start_execution_date,ja.stop_execution_date) elapsed_minutes,     
    ISNULL(last_executed_step_id,0)+1 AS current_executed_step_id,
    Js.step_name
FROM msdb.dbo.sysjobactivity ja 
LEFT JOIN msdb.dbo.sysjobhistory jh 
    ON ja.job_history_id = jh.instance_id
JOIN msdb.dbo.sysjobs j 
ON ja.job_id = j.job_id
JOIN msdb.dbo.sysjobsteps js
    ON ja.job_id = js.job_id
    AND ISNULL(ja.last_executed_step_id,0)+1 = js.step_id
WHERE ja.session_id = (SELECT TOP 1 session_id FROM msdb.dbo.syssessions ORDER BY agent_start_date DESC)
AND start_execution_date is not null
AND stop_execution_date is not null;

-- GET ACTIVELY RUNNING JOBS
SELECT
    ja.job_id,
    j.name AS job_name,
    ja.start_execution_date,      
    ISNULL(last_executed_step_id,0)+1 AS current_executed_step_id,
    Js.step_name
FROM msdb.dbo.sysjobactivity ja 
LEFT JOIN msdb.dbo.sysjobhistory jh 
    ON ja.job_history_id = jh.instance_id
JOIN msdb.dbo.sysjobs j 
ON ja.job_id = j.job_id
JOIN msdb.dbo.sysjobsteps js
    ON ja.job_id = js.job_id
    AND ISNULL(ja.last_executed_step_id,0)+1 = js.step_id
WHERE ja.session_id = (SELECT TOP 1 session_id FROM msdb.dbo.syssessions ORDER BY agent_start_date DESC)
AND start_execution_date is not null
AND stop_execution_date is null;

-- GET BASIC JOB HISTORY
select 
 j.name as 'JobName',
 run_date,
 run_time,
 msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime',
 run_duration,
 ((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) 
          as 'RunDurationMinutes'
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobhistory h 
 ON j.job_id = h.job_id 
where j.enabled = 1  --Only Enabled Jobs
order by JobName, RunDateTime desc

-- BASIC JOB EXECUTION STATS
select 
 j.name as 'JobName',
 --j.run_status ,
 s.step_id as 'Step',
 s.step_name as 'StepName',
 msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime',
 ((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) 
         as 'RunDurationMinutes'
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobsteps s 
 ON j.job_id = s.job_id
INNER JOIN msdb.dbo.sysjobhistory h 
 ON s.job_id = h.job_id 
 AND s.step_id = h.step_id 
 AND h.step_id <> 0
where j.enabled = 1   --Only Enabled Jobs
--and j.name = 'TestJob' --Uncomment to search for a single job
and msdb.dbo.agent_datetime(run_date, run_time) 
BETWEEN getdate() -2  and getdate() --Uncomment for date range queries
order by JobName, RunDateTime desc


-- GET FAILED JOBS WITHIN LAST 2 DAYS
    SELECT   Job.instance_id
        ,SysJobs.job_id
        ,SysJobs.name as 'JOB_NAME'
        ,SysJobSteps.step_name as 'STEP_NAME'
        ,Job.run_status
        ,Job.sql_message_id
        ,Job.sql_severity
        ,Job.message
        ,Job.exec_date
        ,Job.run_duration
        ,Job.server
        ,SysJobSteps.output_file_name
    FROM    (SELECT Instance.instance_id
        ,DBSysJobHistory.job_id
        ,DBSysJobHistory.step_id
        ,DBSysJobHistory.sql_message_id
        ,DBSysJobHistory.sql_severity
        ,DBSysJobHistory.message
        ,(CASE DBSysJobHistory.run_status
            WHEN 0 THEN 'Failed'
            WHEN 1 THEN 'Succeeded'
            WHEN 2 THEN 'Retry'
            WHEN 3 THEN 'Canceled'
            WHEN 4 THEN 'In progress'
        END) as run_status
        ,((SUBSTRING(CAST(DBSysJobHistory.run_date AS VARCHAR(8)), 5, 2) + '/'
        + SUBSTRING(CAST(DBSysJobHistory.run_date AS VARCHAR(8)), 7, 2) + '/'
        + SUBSTRING(CAST(DBSysJobHistory.run_date AS VARCHAR(8)), 1, 4) + ' '
        + SUBSTRING((REPLICATE('0',6-LEN(CAST(DBSysJobHistory.run_time AS varchar)))
        + CAST(DBSysJobHistory.run_time AS VARCHAR)), 1, 2) + ':'
        + SUBSTRING((REPLICATE('0',6-LEN(CAST(DBSysJobHistory.run_time AS VARCHAR)))
        + CAST(DBSysJobHistory.run_time AS VARCHAR)), 3, 2) + ':'
        + SUBSTRING((REPLICATE('0',6-LEN(CAST(DBSysJobHistory.run_time as varchar)))
        + CAST(DBSysJobHistory.run_time AS VARCHAR)), 5, 2))) AS 'exec_date'
        ,DBSysJobHistory.run_duration
	   , ((DBSysJobHistory.run_duration/10000*3600 + (DBSysJobHistory.run_duration/100)%100*60 + DBSysJobHistory.run_duration%100 + 31 ) / 60) as 'RunDurationMinutes'
        ,DBSysJobHistory.retries_attempted
        ,DBSysJobHistory.server
        FROM msdb.dbo.sysjobhistory DBSysJobHistory
        JOIN (SELECT DBSysJobHistory.job_id
            ,DBSysJobHistory.step_id
            ,MAX(DBSysJobHistory.instance_id) as instance_id
            FROM msdb.dbo.sysjobhistory DBSysJobHistory
            GROUP BY DBSysJobHistory.job_id
            ,DBSysJobHistory.step_id
            ) AS Instance ON DBSysJobHistory.instance_id = Instance.instance_id
        --WHERE DBSysJobHistory.run_status <> 1
        ) AS Job
    JOIN msdb.dbo.sysjobs SysJobs
       ON (Job.job_id = SysJobs.job_id)
    JOIN msdb.dbo.sysjobsteps SysJobSteps
       ON (Job.job_id = SysJobSteps.job_id AND Job.step_id = SysJobSteps.step_id)
WHERE Job.exec_date > GETDATE() -2
    GO

    Executed as user: NT SERVICE\SQLSERVERAGENT. Could not find stored procedure 'proc_CT_DIM_HFit_TrackerDailySteps'. [SQLSTATE 42000] (Error 2812).  The step failed.