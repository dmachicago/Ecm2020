USE msdb;
GO

SELECT j.name , 
       js.step_name , 
       jh.sql_severity , 
       jh.message , 
       jh.run_date , 
       jh.run_time , 
	  jh.run_status,
	  jh.run_duration as DurationHHMMSS ,
       j.enabled,
	  getdate() as CurrentTime
  FROM
       msdb.dbo.sysjobs AS j
       INNER JOIN msdb.dbo.sysjobsteps AS js
       ON js.job_id = j.job_id
       INNER JOIN msdb.dbo.sysjobhistory AS jh
       ON jh.job_id = j.job_id
  WHERE j.name NOT LIKE 'instrument%'
	   and j.name NOT LIKE 'DBAPlatform%'
	   and jh.message not like '%NOTE: Failed to notify%'
	   and jh.run_status = 0
	   and run_date = 20160515
  ORDER BY j.name , js.step_name , run_date DESC;

-- Rerun failed jobs 
SELECT j.name, 'EXEC proc_isJobEnvironmentReady ' + j.name + ',1' as StartJob, 
		  'EXEC dbo.' + substring(j.name,5,999) as ExecProc  ,
		  max(jh.run_status) 
  FROM
       msdb.dbo.sysjobs AS j
       INNER JOIN msdb.dbo.sysjobsteps AS js
       ON js.job_id = j.job_id
       INNER JOIN msdb.dbo.sysjobhistory AS jh
       ON jh.job_id = j.job_id
  WHERE 
    jh.run_status = 0
    and j.name NOT LIKE 'instrument%'
    AND j.name NOT LIKE 'DBAPlatform%'
group by j.name

--Enable/Disable Failed Job
SELECT DISTINCT 'EXEC dbo.sp_update_job @job_name = ''' + j.name + ''', @enabled =1 '
  FROM
       msdb.dbo.sysjobs AS j
       INNER JOIN msdb.dbo.sysjobsteps AS js
       ON js.job_id = j.job_id
       INNER JOIN msdb.dbo.sysjobhistory AS jh
       ON jh.job_id = j.job_id
  WHERE jh.run_status = 0
    AND j.name NOT LIKE 'instrument%';

EXEC msdb.dbo.sp_help_jobhistory @job_name = N'job_proc_BASE_CMS_UserSettings_KenticoCMS_1_ApplyCT';

--use DAtaMartPlatform
--go
-- exec proc_RegenBaseTableFromView View_hfit_challenge_Joined
--exec proc_RegenBaseTableFromView View_CMS_User_With_HFitCoachingSettings

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
