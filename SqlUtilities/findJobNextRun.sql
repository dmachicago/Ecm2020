
  SELECT 
		ja.session_id,                
		ja.job_id,
		j.name AS job_name,
		ja.run_requested_date,        
		ja.run_requested_source,      
		ja.queued_date,               
		ja.start_execution_date,      
		ja.last_executed_step_id,     
		ja.last_executed_step_date,   
		ja.stop_execution_date,       
		ja.next_scheduled_run_date,
		ja.job_history_id,            
		jh.message,
		jh.run_status,
		jh.operator_id_emailed,
		jh.operator_id_netsent,
		jh.operator_id_paged
 FROM
    (msdb.dbo.sysjobactivity ja LEFT JOIN msdb.dbo.sysjobhistory jh ON ja.job_history_id = jh.instance_id)
    join msdb.dbo.sysjobs_view j on ja.job_id = j.job_id
  WHERE
    j.name like '%EDW%' and ja.run_requested_date is not null
order by j.name desc , ja.session_id desc
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
