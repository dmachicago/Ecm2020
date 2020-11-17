

-- exec get_Last_Job_Execution_Status
alter procedure get_Last_Job_Execution_Status
as
SELECT DISTINCT j.Name AS "JobName" , 
                s.step_name  ,
			 s.step_id, 
			 CASE h.run_status
                    WHEN 0
                        THEN 'Failed'
                    WHEN 1
                        THEN 'Successful'
                    WHEN 3
                        THEN 'Cancelled'
                    WHEN 4
                        THEN 'In Progress'
                END AS LAST_RunStatus,
                h.run_date AS LastStatusDate , 
                h.run_time AS LastStatusTime , 
                h.run_duration AS LastStatusDuration           
  FROM msdb..sysJobHistory AS h
  join  msdb..sysJobs AS j
  on j.job_id = h.job_id --, msdb..sysjobsteps s
    AND h.step_id = 1
    --AND j.enabled = 1
    AND h.run_date = (
                      SELECT MAX (hi.run_date)
                        FROM msdb..sysJobHistory AS hi
                        WHERE h.job_id = hi.job_id)
    AND h.run_time = (SELECT MAX (hj.run_time)
                        FROM msdb..sysJobHistory AS hj
                        WHERE h.job_id = hj.job_id)
join msdb..sysjobsteps s
on s.job_id = j.job_id
                     ORDER BY 1 desc, 2, 3, 4 desc