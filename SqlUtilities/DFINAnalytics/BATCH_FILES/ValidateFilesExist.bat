d:
cd D:\dev\SQL\DFINAnalytics\BATCH_FILES
set "VFile=D:\dev\SQL\DFINAnalytics\BATCH_FILES\Verification.TXT" >> %VFile%
del  "VFile=D:\dev\SQL\DFINAnalytics\BATCH_FILES\Verification.TXT"

echo %VFile%
echo off
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\create_master_seq.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\PrintImmediate.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql"

CALL ckFileExists "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\createSeq2008.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\findLocks.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\PerformanceMonitorForProcs.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql"

REM CREATE THE VIEWS
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\Create_View_DFS_Workload.sql"
CALL ckFileExists "D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql"
echo on

rem notepad %VFile% 
