
-- GET JOB RUN TIMES
SELECT
    j.name AS job_name,
    ja.start_execution_date,   
	ja.stop_execution_date, 
	datediff(minute,ja.start_execution_date,ja.stop_execution_date) as MinutesDuration,
    ISNULL(last_executed_step_id,0)+1 AS current_executed_step_id,
    Js.step_name,
	ja.job_id    
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

select getdate()	--2016-04-13 20:57:06.590
EXEC msdb..sp_stop_job N'JOB proc_HA_MasterUpdate' ;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
