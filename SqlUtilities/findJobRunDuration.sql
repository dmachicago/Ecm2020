SELECT
       j.name AS 'JobName'
     ,--run_date,
       --run_time,
       msdb.dbo.agent_datetime (run_date, run_time) AS 'RunDateTime'
     ,run_duration AS 'HHMMSS'
       FROM
           msdb.dbo.sysjobs AS j
               INNER JOIN msdb.dbo.sysjobhistory AS h
                   ON j.job_id = h.job_id
       WHERE j.enabled = 1  --Only Enabled Jobs
         AND j.name LIKE 'job_proc_FACT%'
       ORDER BY
                JobName, RunDateTime DESC;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
