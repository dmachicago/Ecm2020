
SELECT
       'Disabled Jobs' AS Status
     ,@@servername AS ServerName
     ,name AS JobName
     ,date_modified AS LastModifiedDate
FROM msdb.dbo.sysjobs WITH (NOLOCK) 
WHERE
      enabled = 0 AND name LIKE '%1[_]ApplyCT';

SELECT
       'Enabled Jobs' AS Status
     ,@@servername AS ServerName
     ,name AS JobName
     ,date_modified AS LastModifiedDate
	,'EXEC msdb..sp_start_job @job_name = ''' + name + '''' + CHAR (10) + 'GO' AS StartCmd
FROM msdb.dbo.sysjobs WITH (NOLOCK) 
WHERE
      enabled = 1 AND name LIKE '%[_]1' AND name NOT LIKE '%proc_view%' AND name LIKE 'job%';

SELECT
       'EXEC msdb..sp_update_job @job_name = ''' + name + ''', @enabled = 0 ;' + CHAR (10) + 'GO'
FROM msdb.dbo.sysjobs WITH (NOLOCK) 
WHERE
      enabled = 1
      --AND name LIKE '%staging%'
      AND name LIKE 'job%' AND name LIKE '%[_]2';

SELECT
       'EXEC sp.start_job @job_name = ''' + name + '''' + CHAR (10) + 'GO'
FROM msdb.dbo.sysjobs WITH (NOLOCK) 
WHERE
      enabled = 1 AND name LIKE '%job_proc_BASE_HFit_Tracker%';

--*******************************************************************
-- GET JOB RUN DURATION
select top 10
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
and run_date >=20160607
order by JobName, RunDateTime desc
--*******************************************************************
-- FIND LAST SUCCESSFUL RUN OF A JOB and DURATION
Use msdb
GO
SELECT 
    SJ.NAME AS [Job Name]
    ,RUN_STATUS AS [Run Status]
    ,MAX(DBO.AGENT_DATETIME(RUN_DATE, RUN_TIME)) AS [Last_Time_Job_Ran]
    ,JH.run_duration
    ,((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) 
          as 'RunDurationMinutes'
FROM 
    dbo.SYSJOBS SJ 
        LEFT OUTER JOIN dbo.SYSJOBHISTORY JH
    ON SJ.job_id = JH.job_id
        WHERE JH.step_id = 0
            AND jh.run_status = 1
                GROUP BY SJ.name, JH.run_status,JH.run_duration 
                    ORDER BY [Last_Time_Job_Ran] DESC

--*******************************************************************
-- EXEC dbo.sp_start_job N'Weekly Sales Data Backup' ;
USE MSDB;

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
     sysjobhistory AS SJH
          JOIN sysjobs AS SJ
          ON
       SJH.job_id = sj.job_id
WHERE
       DATEADD (S , run_time / 10000 * 60 * 60 + (run_time - run_time / 10000 * 10000) / 100 * 60 + run_time - run_time / 100 * 100 , CONVERT (DATETIME , RTRIM (run_date) , 113)) >= DATEADD (d , -1 , GETDATE ()) AND
       SJH.run_status = 0 AND name LIKE 'job_proc%' AND enabled = 1
       --and SJH.[message] like '%Invalid column name%'
       AND step_id = 0	  
ORDER BY
         run_date desc ,name , run_time desc  ;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
