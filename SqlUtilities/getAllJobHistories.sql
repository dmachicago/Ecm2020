USE msdb
Go 
if (object_id('tempdb..#TEMP_JOB_HIST') is not null)
	drop table #TEMP_JOB_HIST;

SELECT j.name JobName, 
       h.step_name StepName, 
       CONVERT(CHAR(10), CAST(STR(h.run_date, 8, 0) AS DATETIME), 111) RunDate, 
       STUFF(STUFF(RIGHT('000000' + CAST(h.run_time AS VARCHAR(6)), 6), 5, 0, ':'), 3, 0, ':') RunTime, 
       h.run_duration StepDuration,
       CASE h.run_status
           WHEN 0
           THEN 'failed'
           WHEN 1
           THEN 'Succeded'
           WHEN 2
           THEN 'Retry'
           WHEN 3
           THEN 'Cancelled'
           WHEN 4
           THEN 'In Progress'
       END AS ExecutionStatus, 
       h.message MessageGenerated, 
       j.job_id
INTO #TEMP_JOB_HIST
FROM sysjobhistory h
     INNER JOIN sysjobs j ON j.job_id = h.job_id
ORDER BY j.name, 
         h.run_date, 
         h.run_time;
GO

select * from #TEMP_JOB_HIST order by JobName, RunDate, RunTime, StepName
--select * from #TEMP_JOB_HIST where MessageGenerated like '%HFit_LKP_TrackerSleepPlanTechniques%'



SELECT *
FROM #TEMP_JOB_HIST
WHERE JobName IN (SELECT [name] FROM msdb.dbo.sysjobs)
select * from #TEMP_JOB_HIST order by JobName, RunDate, RunTime, StepName

--The job failed.  The Job was invoked by Schedule 303 (SCHED proc_View_CONTENT_PressRelease_Joined_KenticoCMS_1').  The last step to run was step 1 (RUN proc_View_CONTENT_PressRelease_Joined_KenticoCMS_1').  NOTE: Failed to notify 'DBA_Email' via network popup.  NOTE: Failed to notify 'DBA_Notify' via email.
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

