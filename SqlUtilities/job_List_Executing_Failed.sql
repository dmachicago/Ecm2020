
-- EXEC msdb.dbo.sp_stop_job N'job_proc_view_EDW_HealthAssesment_KenticoCMS_1'
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
AND stop_execution_date is null
order by ja.start_execution_date

-- EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingAuditLog_KenticoCMS_2_ApplyCT"
select 'EXEC msdb.dbo.sp_start_job "' + j.name + '"'
 --run_date,run_time,msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime',run_duration
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobhistory h 
 ON j.job_id = h.job_id 
where j.enabled = 1  --Only Enabled Jobs
and h.message like '%job failed%'
order by JobName--, RunDateTime desc



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
