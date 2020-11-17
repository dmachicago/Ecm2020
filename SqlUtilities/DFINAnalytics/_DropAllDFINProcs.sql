
go
--Select 'if exists (select 1 from sys.procedures where name = ''' + name +''')' +char(10) + '    drop procedure ' + name + ';' as CMD from sys.procedures where name like 'DFS%'
--Select 'if exists (select 1 from sys.procedures where name = ''' + name +''')' +char(10) + '    drop procedure ' + name + ';' as CMD from sys.procedures order by name;
go
declare @DropAllProcs int = 0 ;
if (@DropAllProcs = 1)
Begin
	if exists (select 1 from sys.procedures where name = 'UTIL_UpdateQryPlansAndText')
		DROP PROCEDURE UTIL_UpdateQryPlansAndText;
	
	if exists (select 1 from sys.procedures where name = 'DFS_IO_BoundQry2000_ProcessTable')
		drop procedure DFS_IO_BoundQry2000_ProcessTable;
	if exists (select 1 from sys.procedures where name = 'DFS_CPU_BoundQry2000_ProcessTable')
		drop procedure DFS_CPU_BoundQry2000_ProcessTable;
	if exists (select 1 from sys.procedures where name = 'DFS_GetAllTableSizesAndRowCnt')
		drop procedure DFS_GetAllTableSizesAndRowCnt;
	if exists (select 1 from sys.procedures where name = 'DFS_MonitorTableStats')
		drop procedure DFS_MonitorTableStats;
	if exists (select 1 from sys.procedures where name = 'DFS_MonitorLocks')
		drop procedure DFS_MonitorLocks;
	if exists (select 1 from sys.procedures where name = '_CreateTempProc')
		drop procedure _CreateTempProc;
	if exists (select 1 from sys.procedures where name = '_Emergency_StartAllAnalyticsJobs')
		drop procedure _Emergency_StartAllAnalyticsJobs;
	if exists (select 1 from sys.procedures where name = '_GetProcDependencies')
		drop procedure _GetProcDependencies;
	if exists (select 1 from sys.procedures where name = 'az_foreach_worker')
		drop procedure az_foreach_worker;
	if exists (select 1 from sys.procedures where name = 'az_foreachdb')
		drop procedure az_foreachdb;
	if exists (select 1 from sys.procedures where name = 'az_foreachtable')
		drop procedure az_foreachtable;
	if exists (select 1 from sys.procedures where name = 'azure_sp_MSforeachdb')
		drop procedure azure_sp_MSforeachdb;
	if exists (select 1 from sys.procedures where name = 'Azure_sp_MSforeachdb
	')
		drop procedure Azure_sp_MSforeachdb
	;
	if exists (select 1 from sys.procedures where name = 'DMA_ForEachDB')
		drop procedure DMA_ForEachDB;
	if exists (select 1 from sys.procedures where name = 'genInsertStatements')
		drop procedure genInsertStatements;
	if exists (select 1 from sys.procedures where name = 'GetSEQUENCE')
		drop procedure GetSEQUENCE;
	if exists (select 1 from sys.procedures where name = 'PrintImmediate')
		drop procedure PrintImmediate;
	if exists (select 1 from sys.procedures where name = 'sp_ckProcessDB')
		drop procedure sp_ckProcessDB;
	if exists (select 1 from sys.procedures where name = 'sp_DFS_FindMissingFKIndexes')
		drop procedure sp_DFS_FindMissingFKIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_DFS_MonitorLocks')
		drop procedure sp_DFS_MonitorLocks;
	if exists (select 1 from sys.procedures where name = 'sp_DFS_SuggestMissingIndexes')
		drop procedure sp_DFS_SuggestMissingIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_foreachdb')
		drop procedure sp_foreachdb;
	if exists (select 1 from sys.procedures where name = 'sp_foreachdb_TempDB')
		drop procedure sp_foreachdb_TempDB;
	if exists (select 1 from sys.procedures where name = 'sp_MeasurePerformanceInSP')
		drop procedure sp_MeasurePerformanceInSP;
	if exists (select 1 from sys.procedures where name = 'sp_PrintImmediate')
		drop procedure sp_PrintImmediate;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_CPU_BoundQry')
		drop procedure sp_UTIL_CPU_BoundQry;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_CPU_BoundQry2000')
		drop procedure sp_UTIL_CPU_BoundQry2000;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_DFS_DeadlockStats')
		drop procedure sp_UTIL_DFS_DeadlockStats;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_DFS_WaitStats')
		drop procedure sp_UTIL_DFS_WaitStats;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_GetIndexStats')
		drop procedure sp_UTIL_GetIndexStats;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_GetSeq')
		drop procedure sp_UTIL_GetSeq;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_IO_BoundQry')
		drop procedure sp_UTIL_IO_BoundQry;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_IO_BoundQry2000')
		drop procedure sp_UTIL_IO_BoundQry2000;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_MSTR_BoundQry2000')
		drop procedure sp_UTIL_MSTR_BoundQry2000;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_RebuildAllDbIndexes')
		drop procedure sp_UTIL_RebuildAllDbIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_RebuildAllDbIndexUsingDBCC')
		drop procedure sp_UTIL_RebuildAllDbIndexUsingDBCC;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_ReorgFragmentedIndexes')
		drop procedure sp_UTIL_ReorgFragmentedIndexes;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TableGrowthHistory')
		drop procedure sp_UTIL_TableGrowthHistory;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TrackTblReadsWrites')
		drop procedure sp_UTIL_TrackTblReadsWrites;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TxMonitorIDX')
		drop procedure sp_UTIL_TxMonitorIDX;
	if exists (select 1 from sys.procedures where name = 'sp_UTIL_TxMonitorTableStats')
		drop procedure sp_UTIL_TxMonitorTableStats;
	if exists (select 1 from sys.procedures where name = 'spDemoDBContext')
		drop procedure spDemoDBContext;
	if exists (select 1 from sys.procedures where name = 'test_GetAllTableNames')
		drop procedure test_GetAllTableNames;
	if exists (select 1 from sys.procedures where name = 'test_GetNbr1')
		drop procedure test_GetNbr1;
	if exists (select 1 from sys.procedures where name = 'usp_GetErrorInfo')
		drop procedure usp_GetErrorInfo;
	if exists (select 1 from sys.procedures where name = 'UTIL_ADD_DFS_QrysPlans')
		drop procedure UTIL_ADD_DFS_QrysPlans;
	if exists (select 1 from sys.procedures where name = 'UTIL_CleanDFSTables')
		drop procedure UTIL_CleanDFSTables;
	if exists (select 1 from sys.procedures where name = 'UTIL_CleanUpOneTable')
		drop procedure UTIL_CleanUpOneTable;
	if exists (select 1 from sys.procedures where name = 'UTIL_DefragAllIndexes')
		drop procedure UTIL_DefragAllIndexes;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_CPU_BoundQry')
		drop procedure UTIL_DFS_CPU_BoundQry;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_DbFileSizing')
		drop procedure UTIL_DFS_DbFileSizing;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_DBVersion')
		drop procedure UTIL_DFS_DBVersion;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_DeadlockStats')
		drop procedure UTIL_DFS_DeadlockStats;
	if exists (select 1 from sys.procedures where name = 'UTIL_DFS_TxMonitorTblUpdates')
		drop procedure UTIL_DFS_TxMonitorTblUpdates;
	if exists (select 1 from sys.procedures where name = 'UTIL_findLocks')
		drop procedure UTIL_findLocks;
	if exists (select 1 from sys.procedures where name = 'UTIL_GetErrorInfo')
		drop procedure UTIL_GetErrorInfo;
	if exists (select 1 from sys.procedures where name = 'UTIL_getRunningQueryText')
		drop procedure UTIL_getRunningQueryText;
	if exists (select 1 from sys.procedures where name = 'UTIL_GetSeq')
		drop procedure UTIL_GetSeq;
	if exists (select 1 from sys.procedures where name = 'UTIL_GetTableRowsSize')
		drop procedure UTIL_GetTableRowsSize;
	if exists (select 1 from sys.procedures where name = 'UTIL_IO_BoundQry')
		drop procedure UTIL_IO_BoundQry;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListBlocks')
		drop procedure UTIL_ListBlocks;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListCurrentRunningQueries')
		drop procedure UTIL_ListCurrentRunningQueries;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListMostCommonWaits')
		drop procedure UTIL_ListMostCommonWaits;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListQryTextBySpid')
		drop procedure UTIL_ListQryTextBySpid;
	if exists (select 1 from sys.procedures where name = 'UTIL_ListQueryAndBlocks')
		drop procedure UTIL_ListQueryAndBlocks;
	if exists (select 1 from sys.procedures where name = 'UTIL_MonitorWorkload')
		drop procedure UTIL_MonitorWorkload;
	if exists (select 1 from sys.procedures where name = 'UTIL_MSforeachdb')
		drop procedure UTIL_MSforeachdb;
	if exists (select 1 from sys.procedures where name = 'UTIL_Process_QrysPlans')
		drop procedure UTIL_Process_QrysPlans;
	if exists (select 1 from sys.procedures where name = 'UTIL_QryPlanStats')
		drop procedure UTIL_QryPlanStats;
	if exists (select 1 from sys.procedures where name = 'UTIL_RecordCount')
		drop procedure UTIL_RecordCount;
	if exists (select 1 from sys.procedures where name = 'UTIL_TableGrowthHistory')
		drop procedure UTIL_TableGrowthHistory;
	if exists (select 1 from sys.procedures where name = 'UTIL_TestDBContext')
		drop procedure UTIL_TestDBContext;
	if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCall')
		drop procedure UTIL_TestDBProcCall;
	if exists (select 1 from sys.procedures where name = 'UTIL_TestDBProcCallWithParms')
		drop procedure UTIL_TestDBProcCallWithParms;
end