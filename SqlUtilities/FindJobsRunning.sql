EXEC sp_who2;
--dbcc inputbuffer (85)
--EXEC msdb.dbo.sp_stop_job job_proc_BASE_CMS_Email_KenticoCMS_1_ApplyCT
--EXEC msdb.dbo.sp_stop_job job_proc_BASE_CMS_MembershipUser_KenticoCMS_1_ApplyCT
--select * from msdb.dbo.sysjobhistory

-- ALTER TABLE BASE_HFit_TrackerWholeGrains DROP constraint FK00_BASE_CMS_user_To_BASE_HFit_TrackerWholeGrains

--FIND RUNNING JOBS
SELECT job.Name , 
       job.job_ID , 
       job.Originating_Server , 
       activity.run_requested_Date , 
       'Minutes Running: ' + CAST (DATEDIFF (minute , activity.run_requested_Date , GETDATE ()) AS nvarchar (50)) AS Elapsed,
	  'exec msdb..sp_stop_job ' + job.Name as KillCmd
  FROM
       msdb.dbo.sysjobs_view AS job
       INNER JOIN msdb.dbo.sysjobactivity AS activity
       ON job.job_id = activity.job_id
  WHERE run_Requested_date IS NOT NULL
    AND stop_execution_date IS NULL
    AND job.name LIKE 'job%'
    AND activity.run_requested_Date > GETDATE () - 1
  ORDER BY name;

--FIND COMPLETED JOBS
SELECT job.Name , 
       job.job_ID , 
       job.Originating_Server , 
       activity.run_requested_Date , 
       --'Minutes Running: ' + CAST (DATEDIFF (minute , activity.run_requested_Date , GETDATE ()) AS nvarchar (50)) AS Elapsed,
	  'exec msdb..sp_start_job ' + job.Name as RestartCmd
  FROM
       msdb.dbo.sysjobs_view AS job
       INNER JOIN msdb.dbo.sysjobactivity AS activity
       ON job.job_id = activity.job_id
  WHERE run_Requested_date IS NOT NULL
    AND stop_execution_date IS NOT NULL
    AND job.name LIKE 'job%'
    AND activity.run_requested_Date > GETDATE () - 1; 

--STOP ALL VIEW PULL JOBS
SELECT 'EXEC dbo.sp_stop_job ''' + job.Name + '''' + CHAR (10) + 'GO'
  FROM
       msdb.dbo.sysjobs_view AS job
       INNER JOIN msdb.dbo.sysjobactivity AS activity
       ON job.job_id = activity.job_id
  WHERE run_Requested_date IS NOT NULL
    AND stop_execution_date IS NULL
    AND job.name LIKE 'job_proc_view%';
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
