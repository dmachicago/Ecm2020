


go
/*
select 'set @icnt = (select count(*) from ['+name+']);' +char(10) +
'insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('''+name+''', @icnt) ; ' as cmd 
from sys.tables 
where name not in ('sysdiagrams', 'sysssislog')
order by name ;

select * from DFS_RecordGrowthHistory order by TblName, CreateDate desc

drop table DFS_RecordGrowthHistory;
*/

go
if not exists (select 1 from sys.tables where name = 'DFS_RecordGrowthHistory') 
create table DFS_RecordGrowthHistory (
	TblName nvarchar(150) not null,
	SvrName  nvarchar(150) null,
	DBNAme  nvarchar(150) null,
	NbrRows bigint ,
	CreateDate datetime null default getdate()
)

go

if exists (select 1 from sys.procedures where name = 'UTIL_RecordGrowthHistory')
	drop procedure UTIL_RecordGrowthHistory;
go

/*
exec UTIL_RecordGrowthHistory ;
*/
create procedure UTIL_RecordGrowthHistory
AS
BEGIN

		declare @icnt int = 0 ;

		set @icnt = (select count(*) from [ActiveJob]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJob', @icnt) ; 
		set @icnt = (select count(*) from [ActiveJobExecutions]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJobExecutions', @icnt) ; 
		set @icnt = (select count(*) from [ActiveJobSchedule]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJobSchedule', @icnt) ; 
		set @icnt = (select count(*) from [ActiveJobStep]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveJobStep', @icnt) ; 
		set @icnt = (select count(*) from [ActiveServers]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('ActiveServers', @icnt) ; 
		set @icnt = (select count(*) from [DFIN_TRACKED_DATABASE_PROCS]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFIN_TRACKED_DATABASE_PROCS', @icnt) ; 
		set @icnt = (select count(*) from [DFIN_TRACKED_DATABASES]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFIN_TRACKED_DATABASES', @icnt) ; 
		set @icnt = (select count(*) from [DFS_$ActiveDatabases]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_$ActiveDatabases', @icnt) ; 
		set @icnt = (select count(*) from [DFS_BlockingHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_BlockingHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_CleanedDFSTables]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_CleanedDFSTables', @icnt) ; 
		set @icnt = (select count(*) from [DFS_CPU_BoundQry]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_CPU_BoundQry', @icnt) ; 
		set @icnt = (select count(*) from [DFS_CPU_BoundQry2000]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_CPU_BoundQry2000', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DB2Skip]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DB2Skip', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DbFileSizing]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DbFileSizing', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DBSpace]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DBSpace', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DBTableSpace]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DBTableSpace', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DBVersion]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DBVersion', @icnt) ; 
		set @icnt = (select count(*) from [DFS_DeadlockStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_DeadlockStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragErrors]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragErrors', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragHist]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragHist', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragProgress]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragProgress', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexFragReorgHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexFragReorgHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexReorgCmds]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexReorgCmds', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IndexStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IndexStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IO_BoundQry]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IO_BoundQry', @icnt) ; 
		set @icnt = (select count(*) from [DFS_IO_BoundQry2000]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_IO_BoundQry2000', @icnt) ; 
		set @icnt = (select count(*) from [DFS_MissingFKIndexes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_MissingFKIndexes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_MissingIndexes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_MissingIndexes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_MonitorMostCommonWaits]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_MonitorMostCommonWaits', @icnt) ; 
		set @icnt = (select count(*) from [DFS_ParallelMonitor]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_ParallelMonitor', @icnt) ; 
		set @icnt = (select count(*) from [DFS_PerfMonitor]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_PerfMonitor', @icnt) ; 
		set @icnt = (select count(*) from [DFS_PowershellJobSchedule]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_PowershellJobSchedule', @icnt) ; 
		set @icnt = (select count(*) from [DFS_PullCounts]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_PullCounts', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryOptStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryOptStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryOptStatsExistingHashes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryOptStatsExistingHashes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryOptStatsHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryOptStatsHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QryPlanBridge]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QryPlanBridge', @icnt) ; 
		set @icnt = (select count(*) from [DFS_QrysPlans]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_QrysPlans', @icnt) ; 
		set @icnt = (select count(*) from [DFS_RecordCount]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_RecordCount', @icnt) ; 
		set @icnt = (select count(*) from [DFS_RecordGrowthHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_RecordGrowthHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SEQ]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SEQ', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SequenceTABLE]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SequenceTABLE', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SSIS_RunStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SSIS_RunStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_SsisExecHist]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_SsisExecHist', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableGrowthHistory]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableGrowthHistory', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableReadWrites]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableReadWrites', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableSizeAndRowCnt]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableSizeAndRowCnt', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TableStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TableStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TempDbMonitor]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TempDbMonitor', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TempProcErrors]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TempProcErrors', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TestDBContext]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TestDBContext', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TranLocks]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TranLocks', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorIDX]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorIDX', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorTableIndexStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorTableIndexStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorTableStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorTableStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_TxMonitorTblUpdates]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_TxMonitorTblUpdates', @icnt) ; 
		set @icnt = (select count(*) from [DFS_WaitStats]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_WaitStats', @icnt) ; 
		set @icnt = (select count(*) from [DFS_WaitTypes]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_WaitTypes', @icnt) ; 
		set @icnt = (select count(*) from [DFS_Workload]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('DFS_Workload', @icnt) ; 
		set @icnt = (select count(*) from [SequenceTABLE]);
		insert into DFS_RecordGrowthHistory (TblName, NbrRows) values  ('SequenceTABLE', @icnt) ; 

end
go
