--GenerateJobDisableEnableStmts
SELECT 'exec msdb..sp_update_job @job_name = '''+NAME+''', @enabled = 0' FROM msdb..sysjobs
--generate enable
SELECT 'exec msdb..sp_update_job @job_name = '''+NAME+''', @enabled = 1' FROM msdb..sysjobs

--Find all enabled Jobs
SELECT * FROM msdb..sysjobs where Enabled = 1 

--Find all disabled Jobs
SELECT * FROM msdb..sysjobs where Enabled = 0 


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
