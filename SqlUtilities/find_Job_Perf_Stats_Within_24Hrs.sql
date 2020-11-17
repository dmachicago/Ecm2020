select *
from PERFMON_PullTime_HIST H
join msdb.dbo.sysjobs J
on J.Name = 'JOB_'+H.ProcName
and J.enabled = 1
and H.ProcName like '%ApplyCT'
and InsertCount > 0
and ExecutionStartTime between getdate()-1 and getdate()


INNER JOIN
    (SELECT ProcName, MAX(ExecutionStartTime) AS MaxDateTime
    FROM PERFMON_PullTime_HIST
    GROUP BY home) groupedtt 


order by ExecutionStartTime desc

SELECT tt.*
FROM from PERFMON_PullTime_HIST H
INNER JOIN
    (SELECT home, MAX(datetime) AS MaxDateTime
    FROM topten
    GROUP BY home) groupedtt 
ON tt.home = groupedtt.home 
AND tt.datetime = groupedtt.MaxDateTime

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

