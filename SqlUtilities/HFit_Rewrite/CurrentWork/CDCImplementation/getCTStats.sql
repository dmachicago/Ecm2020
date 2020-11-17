

-- exec getCTStats
alter procedure getCTStats (@DaysOfHistory as int = 1)
as
select TblName,min(ExecutionStartTime) as StartDate, max(ExecutionEndDate) as EndDate, datediff(mi,min(ExecutionStartTime), max(ExecutionEndDate)) as RunMinutes,  sum(InsertCount) as Inserts, sum(DeleteCount) as Deletes, Sum(UpdateCount) as Updates, sum(InsertCount) as Inserts, sum(DeleteCount+ InsertCount + UpdateCount) as Totals 
from PERFMON_PullTime_HIST 
where ExecutionEndDate > getdate()-@DaysOfHistory
group by TblName
go

-- exec getCTStatsByDBNAME
alter procedure getCTStatsByDBNAME (@DaysOfHistory as int = 1)
as
select DBMS, TblName,min(ExecutionStartTime) as StartDate, max(ExecutionEndDate) as EndDate, datediff(mi,min(ExecutionStartTime), max(ExecutionEndDate)) as RunMinutes, sum(InsertCount) as Inserts, sum(DeleteCount) as Deletes, Sum(UpdateCount) as Updates, sum(InsertCount) as Inserts, sum(DeleteCount+ InsertCount + UpdateCount) as Totals 
from PERFMON_PullTime_HIST 
where ExecutionEndDate > getdate()-@DaysOfHistory
group by DBMS, TblName

go

-- exec getCTStatsByDate '06/01/2016', '06/30/2016'
alter procedure getCTStatsByDate (@StartDate varchar(50), @EndDate varchar(50))
as
select TblName,min(ExecutionStartTime) as StartDate, max(ExecutionEndDate) as EndDate, datediff(mi,min(ExecutionStartTime), max(ExecutionEndDate)) as RunMinutes, sum(InsertCount) as Inserts, sum(DeleteCount) as Deletes, Sum(UpdateCount) as Updates, sum(InsertCount) as Inserts, sum(DeleteCount+ InsertCount + UpdateCount) as Totals 
from PERFMON_PullTime_HIST 
where ExecutionEndDate between @StartDate and @EndDate
group by TblName

-- select top 100 * from PERFMON_PullTime_HIST