--GenerateJobDisableEnableStmts
SELECT 'exec msdb..sp_update_job @job_name = '''+NAME+''', @enabled = 0' FROM msdb..sysjobs
--generate enable
SELECT 'exec msdb..sp_update_job @job_name = '''+NAME+''', @enabled = 1' FROM msdb..sysjobs

--Find all enabled Jobs
SELECT * FROM msdb..sysjobs where Enabled = 1 

--Find all disabled Jobs
SELECT * FROM msdb..sysjobs where Enabled = 0 

