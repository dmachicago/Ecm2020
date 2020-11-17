
select  TblName, InsertCount, UpdateCount, DeleteCount, TotalTimeMinutes, ProcName, ExecutionStartTime
from PERFMON_PullTime_HIST
where ExecutionStartTime > getdate() -1 
order by TblName, ExecutionStartTime desc

select  *
from PERFMON_PullTime_HIST
where ExecutionStartTime between '10-16-2016' and '10-18-2016'
and (InsertCount > 0 or DeleteCount > 0 or UpdateCount > 0)
and DBMS = 'KenticoCMS_1'
order by TblName, ExecutionStartTime desc

select  *
from PERFMON_PullTime_HIST
where ExecutionStartTime > getdate() -1 
and DBMS = 'KenticoCMS_3'
and (InsertCount > 0 or DeleteCount > 0 or UpdateCount > 0)
order by  ExecutionStartTime, tblname desc

select count(*) from BASE_cms_user_del
select count(*) from BASE_HFit_CoachingHealthInterest_del

select top 100 * from BASE_HFit_GoalOutcome_del
