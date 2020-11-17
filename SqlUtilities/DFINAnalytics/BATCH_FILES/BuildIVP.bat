d:
cd D:\dev\SQL\DFINAnalytics\Batch_Files
set "IvpFile=D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql"
del  D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql

echo %IvpFile%

call concatfile "D:\dev\SQL\DFINAnalytics\create_master_seq.sql" %IvpFile% 10
call concatfile "D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql" >> %IvpFile% 20
call concatfile "D:\dev\SQL\DFINAnalytics\PrintImmediate.sql" >> %IvpFile% 30
call concatfile "D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql" >> %IvpFile% 40
call concatfile "D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql" >> %IvpFile% 50
call concatfile "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql" >> %IvpFile% 60
call concatfile "D:\dev\SQL\DFINAnalytics\createSeq2008.sql" >> %IvpFile% 70
call concatfile "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql" >> %IvpFile% 80
call concatfile "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql" >> %IvpFile% 90
call concatfile "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql" >> %IvpFile% 100
call concatfile "D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql" >> %IvpFile% 110
call concatfile "D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql" >> %IvpFile% 120
call concatfile "D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql" >> %IvpFile% 130
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql" >> %IvpFile% 140
call concatfile "D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql" >> %IvpFile% 150
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql" >> %IvpFile% 160
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql" >> %IvpFile% 170
call concatfile "D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql" >> %IvpFile% 180
call concatfile "D:\dev\SQL\DFINAnalytics\findLocks.sql" >> %IvpFile% 190
call concatfile "D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql" >> %IvpFile% 200
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql" >> %IvpFile% 210
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql" >> %IvpFile% 220
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql" >> %IvpFile% 230
call concatfile "call concatfile "D:\dev\SQL\DFINAnalytics\PerformanceMonitorForProcs.sql" >> %IvpFile% 240
call concatfile "D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql" >> %IvpFile% 250 
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql" >> %IvpFile%260
call concatfile "D:\dev\SQL\DFINAnalytics\UTIL_DefragAllIndexes.sql" >> %IvpFile% 270
call concatfile "D:\dev\SQL\DFINAnalytics\sp_MeasurePerformanceInSP.sql" >> %IvpFile% 280
call concatfile "D:\dev\SQL\DFINAnalytics\sp_UTIL_RebuildAllDbIndexes.sql" >> %IvpFile% 290

REM CREATE THE VIEWS
REM call concatfile "D:\dev\SQL\DFINAnalytics\Create_View_DFS_Workload.sql" >> %IvpFile%

call concatfile "D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql" >> %IvpFile% 300

notepad %IvpFile%

