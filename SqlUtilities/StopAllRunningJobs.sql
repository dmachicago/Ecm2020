SELECT 'EXEC msdb.dbo.sp_stop_job ['+job.Name +'] ' + char(10) + 'GO' as cmd
     , job.Name 
     , job.job_ID
     , job.Originating_Server
     , activity.run_requested_Date
     , 'Minutes Running: ' + CAST (DATEDIFF (minute, activity.run_requested_Date, GETDATE ()) AS NVARCHAR (50)) AS Elapsed
       FROM msdb.dbo.sysjobs_view AS job
                INNER JOIN msdb.dbo.sysjobactivity AS activity
                    ON job.job_id = activity.job_id
       WHERE
       run_Requested_date IS NOT NULL
   AND stop_execution_date IS NULL;
--AND job.name like 'SchemaMonitorReport%'





EXEC msdb.dbo.sp_stop_job [job_proc_view_EDW_CoachingDetail_KenticoCMS_1] 
GO
EXEC msdb.dbo.sp_stop_job [job_proc_view_HFit_HealthAssesmentUserResponses_KenticoCMS_3] 
GO
EXEC msdb.dbo.sp_stop_job [job_proc_view_EDW_BioMetrics_KenticoCMS_1] 
GO
EXEC msdb.dbo.sp_stop_job [job_proc_view_EDW_BioMetrics_KenticoCMS_2] 
GO
EXEC msdb.dbo.sp_stop_job [job_proc_view_EDW_BioMetrics_KenticoCMS_3] 
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
