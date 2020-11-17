USE [DataMartPlatform];
GO

/****** Object:  StoredProcedure [dbo].[FindFailedJobs]    Script Date: 8/15/2016 7:53:43 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

ALTER PROCEDURE dbo.FindFailedJobs
AS 
    SELECT name AS [Job Name]
        , CONVERT (varchar, DATEADD (S, run_time / 10000 * 60 * 60 + (run_time - run_time / 10000 * 10000) / 100 * 60 + run_time - run_time / 100 * 100, CONVERT (datetime, RTRIM (run_date) , 113)) , 100) AS StartTime
        , CASE
          WHEN enabled = 1
              THEN 'Enabled'
              ELSE 'Disabled'
          END AS JobStatus
        , CASE
          WHEN SJH.run_status = 0
              THEN 'Failed'
          WHEN SJH.run_status = 1
              THEN 'Succeeded'
          WHEN SJH.run_status = 2
              THEN 'Retry'
          WHEN SJH.run_status = 3
              THEN 'Cancelled'
              ELSE 'Unknown'
          END AS RunStatus
        , SJH.message
        , 'EXEC msdb..sp_start_job @job_name = ''' + name + '''' + CHAR (10) + 'GO' AS RestartCmd
	   , 'EXEC ' + substring(name,5,9999) + CHAR (10) 
		  + 'EXEC ' + replace (substring(name,5,9999), 'KenticoCMS_1', 'KenticoCMS_2') + CHAR (10) 
		  + 'EXEC ' + replace (substring(name,5,9999), 'KenticoCMS_1', 'KenticoCMS_3') + CHAR (10) 
		  + 'EXEC proc_RemoveHashCodeDuplicateRows BASE_' + replace(substring(name,10,9999), '_KenticoCMS_1', '') + CHAR (10) AS RunCmd
        , CASE
          WHEN CHARINDEX ('_view_', name) > 0
              THEN 'EXEC proc_GenBaseTableFromView ''KenticoCMS_1'',''' + SUBSTRING (name, 10, 9999) + ''', ''no'', 0, 0'
              ELSE 'EXEC proc_CreateBaseTable ''KenticoCMS_1'',''' + SUBSTRING (name, 15, 9999) + ''', 0'
          END AS RegenCmd
        , 'EXEC proc_ResetTableCTVersionToLatest ''PROD'',''KenticoCMS_1'',''' + SUBSTRING (name, 15, 9999) + ''', 0' AS ResetVerCmd
        , run_time AS RunTime
        , 'exec proc_genPullChangesProc "KenticoCMS_1", "' + SUBSTRING (name, 10, 9999) + '", 0 ,1 ' AS RegenPullChangesDDL
     FROM msdb..sysjobhistory AS SJH
          JOIN
          msdb..sysjobs AS SJ
          ON SJH.job_id = sj.job_id
     WHERE DATEADD (S, run_time / 10000 * 60 * 60 + (run_time - run_time / 10000 * 10000) / 100 * 60 + run_time - run_time / 100 * 100, CONVERT (datetime, RTRIM (run_date) , 113)) >= DATEADD (d, -1, GETDATE ())
       AND SJH.run_status = 0
       AND name LIKE 'job_proc%'
       AND enabled = 1
           --and SJH.[message] like '%Invalid column name%'
       AND step_id = 0
     ORDER BY name, run_time DESC, run_date;


