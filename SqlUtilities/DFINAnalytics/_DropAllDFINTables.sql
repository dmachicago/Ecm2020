go
--Select 'if exists (select 1 from sys.tables where name = ''' + name +''')' +char(10) + '    drop table ' + name + ';' as CMD from sys.tables  where name like 'DFS%'
go
declare @DropAllTables int = 0 ;
if (@DropAllTables = 1)
Begin
		if exists (select 1 from sys.tables where name = 'PerfMonitor')
			drop table PerfMonitor;
		if exists (select 1 from sys.tables where name = 'DFS_TableGrowthHistory')
			drop table DFS_TableGrowthHistory;
		if exists (select 1 from sys.tables where name = 'DFS_CleanedDFSTables')
			drop table DFS_CleanedDFSTables;
		if exists (select 1 from sys.tables where name = 'DFS_TxMonitorTableStats')
			drop table DFS_TxMonitorTableStats;
		if exists (select 1 from sys.tables where name = 'DFS_TxMonitorIDX')
			drop table DFS_TxMonitorIDX;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragProgress')
			drop table DFS_IndexFragProgress;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragErrors')
			drop table DFS_IndexFragErrors;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragHist')
			drop table DFS_IndexFragHist;
		if exists (select 1 from sys.tables where name = 'DFS_CPU_BoundQry')
			drop table DFS_CPU_BoundQry;
		if exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry')
			drop table DFS_IO_BoundQry;
		if exists (select 1 from sys.tables where name = 'DFS_QryPlanBridge')
			drop table DFS_QryPlanBridge;
		if exists (select 1 from sys.tables where name = 'DFS_WaitStats')
			drop table DFS_WaitStats;
		if exists (select 1 from sys.tables where name = 'DFS_TableSizeAndRowCnt')
			drop table DFS_TableSizeAndRowCnt;
		if exists (select 1 from sys.tables where name = 'DFS_TestDBContext')
			drop table DFS_TestDBContext;
		if exists (select 1 from sys.tables where name = 'DFS_TempProcErrors')
			drop table DFS_TempProcErrors;
		if exists (select 1 from sys.tables where name = 'DFS_RecordCount')
			drop table DFS_RecordCount;
		if exists (select 1 from sys.tables where name = 'DFS_DB2Skip')
			drop table DFS_DB2Skip;
		if exists (select 1 from sys.tables where name = 'DFS_DBVersion')
			drop table DFS_DBVersion;
		if exists (select 1 from sys.tables where name = 'DFS_WaitTypes')
			drop table DFS_WaitTypes;
		if exists (select 1 from sys.tables where name = 'DFS_MissingIndexes')
			drop table DFS_MissingIndexes;
		if exists (select 1 from sys.tables where name = 'DFS_MissingFKIndexes')
			drop table DFS_MissingFKIndexes;
		if exists (select 1 from sys.tables where name = 'DFS_TableReadWrites')
			drop table DFS_TableReadWrites;
		if exists (select 1 from sys.tables where name = 'DFS_QryOptStats')
			drop table DFS_QryOptStats;
		if exists (select 1 from sys.tables where name = 'DFS_IndexStats')
			drop table DFS_IndexStats;
		if exists (select 1 from sys.tables where name = 'DFS_IO_BoundQry2000')
			drop table DFS_IO_BoundQry2000;
		if exists (select 1 from sys.tables where name = 'DFS_CPU_BoundQry2000')
			drop table DFS_CPU_BoundQry2000;
		if exists (select 1 from sys.tables where name = 'DFS_Workload')
			drop table DFS_Workload;
		if exists (select 1 from sys.tables where name = 'DFS_BlockingHistory')
			drop table DFS_BlockingHistory;
		if exists (select 1 from sys.tables where name = 'DFS_TranLocks')
			drop table DFS_TranLocks;
		if exists (select 1 from sys.tables where name = 'DFS_SequenceTABLE')
			drop table DFS_SequenceTABLE;
		if exists (select 1 from sys.tables where name = 'DFS_DeadlockStats')
			drop table DFS_DeadlockStats;
		if exists (select 1 from sys.tables where name = 'DFS_IndexFragReorgHistory')
			drop table DFS_IndexFragReorgHistory;
end

go