select top 100 *
from PERFMON_PullTime_HIST H
join msdb.dbo.sysjobs J
on J.Name = 'JOB_'+H.ProcName
and J.enabled = 1
and H.ProcName like '%ApplyCT'
and ExecutionStartTime between getdate()-1 and getdate()
order by ExecutionStartTime desc


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
