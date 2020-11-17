
/*
with cte as 
(
  select 
      JobName,
      max(RUN_DATE) as RUN_DATE
  from view_JobExecutionTimes
  group by JobName
)
 select V.JobName, V.RUN_DATE, sum(V.ElapSec) as ElapSec, count(*) as StepCnt from view_JobExecutionTimes V
 join cte C 
    on V.JobName = C.JobName
    and V.RUN_DATE = C.RUN_DATE
 group by V.JobName, V.RUN_DATE
 order by V.JobName, V.RUN_DATE desc

select top 1 * from view_JobExecutionTimes where JobName like '%message[_]%' 
order by Run_Date desc

 select * from view_LastSuccessfulJobRunDate where MART_JOBS_Enabled = 1 
 and JobName like '%HFit_coachingsessioncompleted%'
 or JobName like '%messaging_message%'
 or JobName like '%hfit_schedulednotificationhistory%'
 order by LAstTimeJobRan desc 
 
 exec FindAllRunningJobs
 
 exec FindFailedJobs
*/
select * from MART_Jobs 
use DataMartPlatform
go
--Get execution times
alter view view_JobExecutionTimes
as
select 
 j.name as 'JobName',
 run_date,
 run_time,
 msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime',
 run_duration as ElapSec,
 M.CurrentlyEnabled
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobhistory h 
 ON j.job_id = h.job_id 
 join MART_Jobs M
    on M.name = j.name
where j.enabled = 1  --Only Enabled Jobs
go

-- SET ALL JOBS TO STORE JOB OUTPUT IN FILE AND WITH HISTORY
USE [msdb];
GO
EXEC msdb.dbo.sp_update_jobstep @job_name = 'job_proc_BASE_Board_Message_KenticoCMS_1_ApplyCT', @step_id = 2, @flags = 20;
GO

SELECT 'EXEC msdb.dbo.sp_update_jobstep @job_name=''' + JOB.NAME + ''', @step_id=' + CAST (STEP.STEP_ID AS nvarchar (10)) + ' , @flags=20 ' + CHAR (10) + 'GO' AS CMD
     , JOB.NAME AS JOB_NAME
     , STEP.STEP_ID AS STEP_NUMBER
     , STEP.STEP_NAME AS STEP_NAME
     , STEP.COMMAND AS STEP_QUERY
     , DATABASE_NAME
  FROM Msdb.dbo.SysJobs JOB
       INNER JOIN
       Msdb.dbo.SysJobSteps STEP
       ON STEP.Job_Id = JOB.Job_Id
  WHERE JOB.Enabled = 1
    AND JOB.Name LIKE 'job_proc%'
  ORDER BY JOB.NAME, STEP.STEP_ID;

GO

use DataMartPlatform
go

--FIND ALL RUNNING JOBS
--exec FindAllRunningJobs
ALTER PROCEDURE FindAllRunningJobs
AS SELECT ja.job_id
        , j.name AS job_name
        , ja.start_execution_date
        , ISNULL (last_executed_step_id, 0) + 1 AS CurrStepId
        , DATEDIFF (minute, ja.start_execution_date, GETDATE ()) AS RunMins
        , Js.step_name
     FROM msdb.dbo.sysjobactivity ja
          LEFT JOIN
          msdb.dbo.sysjobhistory jh
          ON ja.job_history_id = jh.instance_id
          JOIN
          msdb.dbo.sysjobs j
          ON ja.job_id = j.job_id
          JOIN
          msdb.dbo.sysjobsteps js
          ON ja.job_id = js.job_id
         AND ISNULL (ja.last_executed_step_id, 0) + 1 = js.step_id
     WHERE ja.session_id = (
           SELECT TOP 1 session_id
             FROM msdb.dbo.syssessions
             ORDER BY agent_start_date DESC)
       AND start_execution_date IS NOT NULL
       AND stop_execution_date IS NULL;

GO

/*
JOB STATS 1
*/

SELECT name
     , run_time
     , run_duration
     , CONVERT (datetime, CONVERT (char (8) , run_date) + ' ' + STUFF (STUFF (LEFT ('000000', 6 - LEN (run_time)) + CONVERT (varchar (6) , run_time) , 3, 0, ':') , 6, 0, ':')) AS start_time
     , DATEADD (MINUTE, DATEDIFF (MINUTE, '0:00:00', CONVERT (time, STUFF (STUFF (LEFT ('000000', 6 - LEN (run_duration)) + CONVERT (varchar (6) , run_duration) , 3, 0, ':') , 6, 0, ':'))) , CONVERT (datetime, CONVERT (char (8) , run_date) + ' ' + STUFF (STUFF (LEFT ('000000', 6 - LEN (run_time)) + CONVERT (varchar (6) , run_time) , 3, 0, ':') , 6, 0, ':'))) AS end_time
     , run_status
     , instance_id
  FROM msdb.dbo.sysjobhistory AS jh
       INNER JOIN
       msdb.dbo.sysjobs AS j
       ON jh.job_id = j.job_id
  WHERE step_id = 0
    AND name LIKE 'TEST%'
  ORDER BY 1, 2;

/*
JOB STATS 2
*/
go
create procedure proc_JobExecutionStats
as
SELECT name
     , start_execution_date AS start_time
     , stop_execution_date AS end_time
     , DATEDIFF (minute, start_execution_date, stop_execution_date) AS minutes
     , ISNULL (last_run_outcome, -1) AS run_status
  FROM msdb.dbo.sysjobactivity ja
       INNER JOIN
       msdb.dbo.sysjobs j
       ON ja.job_id = j.job_id
       LEFT JOIN
       msdb.dbo.sysjobsteps js
       ON js.job_id = ja.job_id
      AND ja.last_executed_step_id = js.step_id
  WHERE start_execution_date IS NOT NULL
    AND stop_execution_date IS NOT NULL
  -- and name like 'TEST%'
  order BY  start_time , name ;

GO

--Find the Last Successful SQL Server Agent Job Run Status, Date and Time
-- select * from view_LastSuccessfulJobRunDate where MART_JOBS_Enabled = 1 order by LAstTimeJobRan desc 
-- where [Job Name] like '%answer%'
-- select top 100 * from msdb.dbo.SYSJOBHISTORY
ALTER VIEW view_LastSuccessfulJobRunDate
AS SELECT SJ.NAME AS JobName
        , RUN_STATUS AS [Run Status]
        , MAX (msdb.DBO.AGENT_DATETIME (RUN_DATE, RUN_TIME)) AS LastTimeJobRan
	   , M.CurrentlyEnabled as MART_JOBS_Enabled
	   , SJ.StartTime
     FROM msdb.dbo.SYSJOBS SJ
          LEFT OUTER JOIN
          msdb.dbo.SYSJOBHISTORY JH
          ON SJ.job_id = JH.job_id
          INNER JOIN
          MART_JOBS M
          ON M.name = SJ.name
         --AND M.CurrentlyEnabled = 1
     WHERE JH.step_id = 0
       AND jh.run_status = 1
     GROUP BY SJ.name
            , JH.run_status,M.CurrentlyEnabled; 
GO

-- FIND LAST EXECUTION DATE
WITH TopRec
    AS (SELECT J.name
             , start_execution_date AS start_time
             , stop_execution_date AS end_time
             , DATEDIFF (minute, start_execution_date, stop_execution_date) AS minutes
             , ISNULL (last_run_outcome, -1) AS run_status
             , ROW_NUMBER () OVER (PARTITION BY J.name ORDER BY J.name) AS RN
          FROM msdb.dbo.sysjobactivity ja
               INNER JOIN
               msdb.dbo.sysjobs j
               ON ja.job_id = j.job_id
               LEFT JOIN
               msdb.dbo.sysjobsteps js
               ON js.job_id = ja.job_id
              AND ja.last_executed_step_id = js.step_id
               INNER JOIN
               MART_JOBS M
               ON j.name = M.name
              AND M.CurrentlyEnabled = 1
          WHERE start_execution_date IS NOT NULL 
    --AND stop_execution_date IS NOT NULL
    -- and name like 'TEST%'
    )
    SELECT T.*
      FROM TopRec T
      WHERE T.RN = 1
      ORDER BY T.start_time DESC, T.name; 


/*
JOB STATS 3
*/
go
create procedure FindAllRunTimesForToday
as
SELECT j.name AS 'JobName'
     , run_date
     , run_time
     , msdb.dbo.agent_datetime (run_date, run_time) AS 'RunDateTime'
     , run_duration
     , (run_duration / 10000 * 3600 + run_duration / 100 % 100 * 60 + run_duration % 100 + 31) / 60 AS 'RunDurationMinutes'
  FROM msdb.dbo.sysjobs j
       INNER JOIN
       msdb.dbo.sysjobhistory h
       ON j.job_id = h.job_id
	   inner join MART_Jobs M
	   on M.name = J.Name
  --AND j.enabled = 1  --Only Enabled Jobs
  where msdb.dbo.agent_datetime (run_date, run_time) > getdate() - 1
  ORDER BY JobName, RunDateTime DESC;

/*
JOB STATS 4
*/

USE msdb;
GO
SELECT j.name
     , step_name
     , CONVERT (datetime, CAST (run_date AS nvarchar (10))) AS RunDate
     , run_duration
     , SUBSTRING (CAST (REPLICATE ('0', 6 - LEN (run_duration)) + CAST (run_duration AS varchar) AS varchar) , 1, 2) + ':' + SUBSTRING (CAST (REPLICATE ('0', 6 - LEN (run_duration)) + CAST (run_duration AS varchar) AS varchar) , 3, 2) + ':' + SUBSTRING (CAST (REPLICATE ('0', 6 - LEN (run_duration)) + CAST (run_duration AS varchar) AS varchar) , 5, 2) AS 'hh:mm:ss'
  FROM sysjobs j, sysjobhistory jh
  WHERE j.job_id = jh.job_id
    AND j.name LIKE 'TEST%'
    AND jh.step_name LIKE '%outcome%'
    AND name LIKE '%TVAR'
    AND run_duration > 0
  ORDER BY j.name, run_date DESC, step_name DESC;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
