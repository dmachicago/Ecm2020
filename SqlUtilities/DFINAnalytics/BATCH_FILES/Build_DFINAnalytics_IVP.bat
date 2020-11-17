d:
cd D:\dev\SQL\DFINAnalytics\Batch_Files
set "IvpFile=D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql"
del  D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql

echo %IvpFile%

type "D:\dev\SQL\DFINAnalytics\create_master_seq.sql" >> %IvpFile%
call AddSeparator.bat 10
type "D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql" >> %IvpFile%
call AddSeparator.bat 20
type "D:\dev\SQL\DFINAnalytics\PrintImmediate.sql" >> %IvpFile%
call AddSeparator.bat 30
type "D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql" >> %IvpFile%
call AddSeparator.bat 40
type "D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql" >> %IvpFile%
call AddSeparator.bat 50

type "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql" >> %IvpFile%
call AddSeparator.bat 60

type "D:\dev\SQL\DFINAnalytics\createSeq2008.sql" >> %IvpFile%
call AddSeparator.bat 70

type "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql" >> %IvpFile%
call AddSeparator.bat 80

type "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql" >> %IvpFile%
call AddSeparator.bat 90

type "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql" >> %IvpFile%
call AddSeparator.bat 100

type "D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql" >> %IvpFile%
call AddSeparator.bat 110

type "D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql" >> %IvpFile%
call AddSeparator.bat 120

type "D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql" >> %IvpFile%
call AddSeparator.bat 130

type "D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql" >> %IvpFile%
call AddSeparator.bat 140

type "D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql" >> %IvpFile%
call AddSeparator.bat 150

type "D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql" >> %IvpFile%
call AddSeparator.bat 160

type "D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql" >> %IvpFile%
call AddSeparator.bat 170

type "D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql" >> %IvpFile%
call AddSeparator.bat 180

type "D:\dev\SQL\DFINAnalytics\findLocks.sql" >> %IvpFile%
call AddSeparator.bat 190

type "D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql" >> %IvpFile%
call AddSeparator.bat 200

type "D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql" >> %IvpFile%
call AddSeparator.bat 210

type "D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql" >> %IvpFile%
call AddSeparator.bat 220

type "D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql" >> %IvpFile%
call AddSeparator.bat 230 

type "type "D:\dev\SQL\DFINAnalytics\PerformanceMonitorForProcs.sql" >> %IvpFile%
call AddSeparator.bat 240

type "D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql" >> %IvpFile%
call AddSeparator.bat 250

type "D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql" >> %IvpFile%
call AddSeparator.bat 260

type "D:\dev\SQL\DFINAnalytics\UTIL_DefragAllIndexes.sql" >> %IvpFile%
call AddSeparator.bat 265

type "D:\dev\SQL\DFINAnalytics\sp_MeasurePerformanceInSP.sql" >> %IvpFile%
call AddSeparator.bat 268

type "D:\dev\SQL\DFINAnalytics\sp_UTIL_RebuildAllDbIndexes.sql" >> %IvpFile%
call AddSeparator.bat 269

REM CREATE THE VIEWS
REM type "D:\dev\SQL\DFINAnalytics\Create_View_DFS_Workload.sql" >> %IvpFile%

call AddSeparator.bat 270

type "D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql" >> %IvpFile%

notepad %IvpFile%

