SELECT sJOB.name AS JobName , 
       CASE sJSTP.last_run_outcome
           WHEN 0
               THEN 'Failed'
           WHEN 1
               THEN 'Succeeded'
           WHEN 2
               THEN 'Retry'
           WHEN 3
               THEN 'Canceled'
           WHEN 5
               THEN 'Unknown'
       END AS LastRunStatus , 
       sJSTP.step_id AS StepNo , 
       sJOB.job_id AS JobID , 
       sJSTP.step_uid AS StepID , 
       sJSTP.step_name AS StepName , 
       STUFF (STUFF (RIGHT ('000000' + CAST (sJSTP.last_run_duration AS varchar (6)) , 6) , 3 , 0 , ':') , 6 , 0 , ':') AS [LastRunDuration (HH:MM:SS)] , 
       sJSTP.last_run_retries AS LastRunRetryAttempts , 
       CASE sJSTP.last_run_date
           WHEN 0
               THEN NULL
       ELSE CAST (CAST (sJSTP.last_run_date AS char (8)) + ' ' + STUFF (STUFF (RIGHT ('000000' + CAST (sJSTP.last_run_time AS varchar (6)) , 6) , 3 , 0 , ':') , 6 , 0 , ':') AS datetime)
       END AS LastRunDateTime
  FROM
       msdb.dbo.sysjobsteps AS sJSTP
       INNER JOIN msdb.dbo.sysjobs AS sJOB
       ON sJSTP.job_id = sJOB.job_id
where sJSTP.last_run_date > 0 
and sJOB.enabled = 1 
  ORDER BY JobName , StepNo;
