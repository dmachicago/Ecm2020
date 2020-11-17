select distinct jobname, StartDate, count(*) * 10 / 60 as Minutes, count(*) as CNT
from JOB_RUN_TIMES 
group by jobname,StartDate
order by 3 desc, jobname 


select jobname, datediff(minute, min(RunTime),max(RunTime)) elapsed_numutes, Min(RunTime) as StartTime, max(runtime) as EndTime
from JOB_RUN_TIMES 
group by jobname,StartDate
order by jobname, StartDate desc