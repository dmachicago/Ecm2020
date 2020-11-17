d:
cd D:\dev\SQL\DFINAnalytics\Batch_Files
set "IvpFile=D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql"
del  D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql

echo %IvpFile%

call AddSeparator.bat 1
set "TgtFile= D:\dev\SQL\DFINAnalytics\create_master_seq.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 1
set "TgtFile= D:\dev\SQL\DFINAnalytics\create_master_seq.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%


call AddSeparator.bat 10
set "TgtFile= D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 20
set "TgtFile= D:\dev\SQL\DFINAnalytics\PrintImmediate.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 30
set "TgtFile= D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 40
set "TgtFile= D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 50
set "TgtFile= D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 60
set "TgtFile= D:\dev\SQL\DFINAnalytics\createSeq2008.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 70
set "TgtFile= D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 80
set "TgtFile= D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 90
set "TgtFile= D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 100
set "TgtFile= D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 110
set "TgtFile= D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 120
set "TgtFile= D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 130
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 140
set "TgtFile= D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 150
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 160
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 170
set "TgtFile= D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 180
set "TgtFile= D:\dev\SQL\DFINAnalytics\findLocks.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 190
set "TgtFile= D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 200
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 210
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 220
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 230 
set "TgtFile= set "TgtFile= D:\dev\SQL\DFINAnalytics\PerformanceMonitorForProcs.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 240
set "TgtFile= D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 250
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 260
set "TgtFile= D:\dev\SQL\DFINAnalytics\UTIL_DefragAllIndexes.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 265
set "TgtFile= D:\dev\SQL\DFINAnalytics\sp_MeasurePerformanceInSP.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 268
set "TgtFile= D:\dev\SQL\DFINAnalytics\sp_UTIL_RebuildAllDbIndexes.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

call AddSeparator.bat 270

REM CREATE THE VIEWS
set "TgtFile= D:\dev\SQL\DFINAnalytics\Create_View_DFS_Workload.sql"

set "TgtFile= D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql"
echo -- FQN: %TgtFile% >> %IvpFile%
type GO >> %IvpFile%
type %TgtFile% >> %IvpFile%
type GO >> %IvpFile%

notepad %IvpFile%

