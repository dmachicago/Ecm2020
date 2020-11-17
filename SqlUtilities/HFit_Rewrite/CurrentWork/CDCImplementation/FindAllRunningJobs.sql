
--exec FindAllRunningJobs
SELECT *
  FROM view_LastSuccessfulJobRunDate
  WHERE MART_JOBS_Enabled = 1
  ORDER BY LAstTimeJobRan DESC; 
GO
SELECT *
  FROM view_MartCompare;
GO
EXEC msdb.dbo.sp_help_job @execution_status = 1;
GO
EXEC FindRunningJobsTime;
GO
FindAllRunTimesForToday;
GO
CREATE TABLE #MyTempTable (name nvarchar (500) 
                         , start_time datetime
                         , end_time datetime
                         , minutes int
                         , run_status int) ;
INSERT INTO #MyTempTable
EXEC proc_JobExecutionStats;
SELECT *
  FROM #MyTempTable T
       JOIN
       Mart_Jobs J
       ON T.name = J.name
  WHERE start_time >= GETDATE () - 1
  ORDER BY minutes DESC;

GO

--EXEC dbo.sp_stop_job N'job_proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_ApplyCT'
--EXEC msdb.dbo.sp_stop_job N'JOB_PROC_Activate_Monitor_BR'

-- job_proc_BASE_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_ApplyCT
GO
CREATE VIEW view_MartCompare
AS SELECT *
     FROM TBL_DIFF1
   UNION
   SELECT *
     FROM TBL_DIFF2
   UNION
   SELECT *
     FROM TBL_DIFF3
   UNION
   SELECT *
     FROM TBL_DIFF4;
GO
