exec RunAllMARTJobs
go
exec FindAllRunningJobs
go
exec FindFailedJobs
go
select  DBMS, TblName, ExecutionStartTime, TotalTimeMinutes, InsertCount, DeleteCount, UpdateCount 
from PERFMON_PullTime_HIST
where ExecutionStartTime between '10-15-2016' and getdate() -1 
and DBMS = 'KenticoCMS_1'
and (InsertCount > 0 or DeleteCount > 0 or UpdateCount > 0)
order by tblname asc ,ExecutionStartTime  desc
go
exec msdb..sp_stop_job @job_name = 'JOB_PROC_Activate_Monitor_BR'