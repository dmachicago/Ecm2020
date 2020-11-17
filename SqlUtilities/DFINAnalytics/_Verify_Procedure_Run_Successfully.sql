--select 'EXEC ' + name +';' as cmd from sys.procedures
--exec sp_who2
EXEC UTIL_ListQryTextBySpid 63;
EXEC UTIL_getRunningQueryText 63;
EXEC UTIL_ListCurrentRunningQueries;
EXEC UTIL_ListQueryAndBlocks;
EXEC UTIL_ListBlocks;
EXEC UTIL_ListMostCommonWaits;
EXEC UTIL_DFS_DeadlockStats;
EXEC sp_UTIL_GetSeq;
EXEC sp_ckProcessDB;
EXEC sp_DFS_SuggestMissingIndexes;
EXEC sp_DFS_FindMissingFKIndexes;
EXEC sp_UTIL_TrackTblReadsWrites;
EXEC sp_UTIL_GetIndexStats;
EXEC sp_UTIL_CPU_BoundQry2000;
EXEC sp_UTIL_IO_BoundQry2000;
EXEC sp_UTIL_MSTR_BoundQry2000;
EXEC sp_UTIL_RebuildAllDbIndexes;
EXEC sp_UTIL_MonitorWorkload;
EXEC sp_DFS_MonitorLocks;

EXEC sp_UTIL_TableGrowthHistory -1;

declare @UID nvarchar(60) = (select newid());
EXEC sp_PerfMonitor 'start', -1, @UID, 'TEST', 'LOC1' ;
EXEC sp_PerfMonitor 'stop', -1, 'XXXX', 'TEST', 'LOC1' ;

EXEC sp_UTIL_TxMonitorTableStats;
EXEC sp_UTIL_TxMonitorIDX;
--EXEC sp_UTIL_ReorgFragmentedIndexes;
--exec sp_UTIL_RebuildAllDbIndexes;
EXEC sp_PrintImmediate N'TESTING';
