

go
print 'executing ' ;
go

if exists (select name from sys.procedures where name = 'ShowFailedJobs')
    drop procedure ShowFailedJobs ;
go
-- exec ShowFailedJobs
create procedure ShowFailedJobs
as
SELECT
       name AS [Job Name]
     ,CONVERT (VARCHAR , DATEADD (S , run_time / 10000 * 60 * 60 + (run_time - run_time / 10000 * 10000) / 100 * 60 + run_time - run_time / 100 * 100 , CONVERT (DATETIME , RTRIM (run_date) , 113)) , 100) AS StartTime
     ,CASE
      WHEN enabled = 1
          THEN 'Enabled'
      ELSE 'Disabled'
      END AS JobStatus
     ,CASE
      WHEN
       SJH.run_status = 0
          THEN 'Failed'
      WHEN
       SJH.run_status = 1
          THEN 'Succeeded'
      WHEN
       SJH.run_status = 2
          THEN 'Retry'
      WHEN
       SJH.run_status = 3
          THEN 'Cancelled'
      ELSE 'Unknown'
      END AS RunStatus
     ,SJH.message
     ,'EXEC msdb..sp_start_job @job_name = ''' + name + '''' + CHAR (10) + 'GO' AS RestartCmd
     ,CASE
      WHEN
       CHARINDEX ('_view_' , name) > 0
          THEN 'EXEC proc_GenBaseTableFromView ''KenticoCMS_1'',''' + SUBSTRING (name , 10 , 9999) + ''', ''no'', 0, 0'
      ELSE 'EXEC proc_CreateBaseTable ''KenticoCMS_1'',''' + SUBSTRING (name , 15 , 9999) + ''', 0'
      END AS RegenCmd,
	 'EXEC proc_ResetTableCTVersionToLatest ''PROD'',''KenticoCMS_1'',''' + SUBSTRING (name , 15 , 9999) + ''', 0' AS ResetVerCmd,
	 run_time as RunTime,
	 'exec proc_genPullChangesProc "KenticoCMS_1", "'+SUBSTRING (name , 10 , 9999)+'", 0 ,1 ' as RegenPullChangesDDL,
	 'EXEC msdb.dbo.sp_update_job @job_name = N'''+name+''',@enabled = 0; ' as DisableCmd 
FROM
     msdb..sysjobhistory AS SJH
          JOIN msdb..sysjobs AS SJ
          ON
       SJH.job_id = sj.job_id
WHERE
       DATEADD (S , run_time / 10000 * 60 * 60 + (run_time - run_time / 10000 * 10000) / 100 * 60 + run_time - run_time / 100 * 100 , CONVERT (DATETIME , RTRIM (run_date) , 113)) >= DATEADD (d , -1 , GETDATE ()) AND
       SJH.run_status = 0 AND name LIKE 'job_proc%' AND enabled = 1
       --and SJH.[message] like '%Invalid column name%'
       AND step_id = 0	  
ORDER BY
         name , run_time desc, run_date ;

go
print 'executing ' ;
go
