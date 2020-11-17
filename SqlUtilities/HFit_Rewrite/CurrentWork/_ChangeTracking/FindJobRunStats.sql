use DataMartPlatform;
go
/*
select * 
 FROM msdb.dbo.sysjobs j
          INNER JOIN
          msdb.dbo.sysjobhistory h
          ON j.job_id = h.job_id
*/
-- exec FindJobRunStats
create PROCEDURE FindJobRunStats
AS SELECT j.name AS 'JobName'
	   , h.step_id
	   , h.step_name
        , run_date
        , run_time
        , msdb.dbo.agent_datetime (run_date, run_time) AS 'RunDateTime'
        , run_duration  --duration stored in HHMMSS :  2 digits would be just seconds
        , cast((run_duration / 10000 * 3600 + run_duration / 100 % 100 * 60 + run_duration % 100 + 31) as decimal(10,2)) / 60 AS 'TotalMinutes' INTO #temp_stats
     FROM msdb.dbo.sysjobs j
          INNER JOIN
          msdb.dbo.sysjobhistory h
          ON j.job_id = h.job_id
          INNER JOIN
          MART_Jobs M
          ON M.name = J.Name
     --AND j.enabled = 1  --Only Enabled Jobs
     WHERE msdb.dbo.agent_datetime (run_date, run_time) > GETDATE () - 1
		  and step_id > 0
     ORDER BY JobName ASC, step_id ASC, RunDateTime ASC;

SELECT *
  FROM #temp_stats;

SELECT SUM (TotalMinutes) AS ExecutionMinutes
     , MIN (RunDateTime) jobs_start_time
     , MAX (RunDateTime) jobs_end_time
     , DATEDIFF (minute, MIN (RunDateTime) , MAX (RunDateTime)) as ElapMinute
	, cast(DATEDIFF (hour, MIN (RunDateTime) , MAX (RunDateTime)) as decimal(10,2)) as ElapHours
	, cast(SUM (TotalMinutes) as decimal(10,2)) / 60 as ExecutionHours
  FROM #temp_stats;

SELECT jobName
     , cast(SUM (TotalMinutes) as decimal(10,2)) AS ExecutionMinutes
     , MIN (RunDateTime) job_start_time
     , MAX (RunDateTime) job_end_time
     , cast(DATEDIFF (minute, MIN (RunDateTime) , MAX (RunDateTime)) as decimal(10,2)) as ElapSecs
	, cast(DATEDIFF (minute, MIN (RunDateTime) , MAX (RunDateTime))as decimal(10,2) ) / 60  as ElapMin
  FROM #temp_stats
  GROUP BY jobName
  ORDER BY 5 DESC;

