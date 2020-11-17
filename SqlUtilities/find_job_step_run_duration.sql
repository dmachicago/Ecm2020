USE msdb
Go 
SELECT j.name JobName,h.step_name StepName, 
h.run_date,
CONVERT(CHAR(10), CAST(STR(h.run_date,8, 0) AS dateTIME), 111) RunDate, 
STUFF(STUFF(RIGHT('000000' + CAST ( h.run_time AS VARCHAR(6 ) ) ,6),5,0,':'),3,0,':') RunTime, 
STUFF(STUFF(RIGHT('000000' + CAST ( h.run_duration AS VARCHAR(6 ) ) ,6),5,0,':'),3,0,':') RunDuration, 
--h.run_duration StepDuration,
case h.run_status 
when 0 then 'failed'
when 1 then 'Succeded' 
when 2 then 'Retry' 
when 3 then 'Cancelled' 
when 4 then 'In Progress' 
end as ExecutionStatus, 
h.message MessageGenerated
FROM sysjobhistory h inner join sysjobs j
ON j.job_id = h.job_id
--and cast(h.run_date as datetime) >= getdate() -1 
ORDER BY h.run_date desc, h.run_time desc,  j.name
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
