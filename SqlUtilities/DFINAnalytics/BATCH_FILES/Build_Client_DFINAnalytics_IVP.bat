echo off
d:
cd D:\dev\SQL\DFINAnalytics\Batch_Files
set "IvpFile=D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql"
del  D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql

echo %IvpFile%

call AddSeparator.bat 1
echo print 'D:\dev\SQL\DFINAnalytics\_DropAllDFINTables.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\_DropAllDFINTables.sql" >> %IvpFile%

call AddSeparator.bat 2
echo print 'D:\dev\SQL\DFINAnalytics\_DropAllDFINProcs.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\_DropAllDFINProcs.sql" >> %IvpFile%

REM call AddSeparator.bat 0
REM echo print 'FQN: D:\dev\SQL\DFINAnalytics\_CreateAllDfinTables.sql' >> %IvpFile%
REM type "D:\dev\SQL\DFINAnalytics\_CreateAllDfinTables.sql" >> %IvpFile%

REM call AddSeparator.bat 1
REM type "D:\dev\SQL\DFINAnalytics\_CreateDFIN_User.sql" >> %IvpFile%

call AddSeparator.bat 2
echo print 'D:\dev\SQL\DFINAnalytics\Func_genInsertSql.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\Func_genInsertSql.sql" >> %IvpFile%

call AddSeparator.bat 3
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_ADD_DFS_QrysPlans.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_ADD_DFS_QrysPlans.sql" >> %IvpFile%

call AddSeparator.bat 4
echo print 'D:\dev\SQL\DFINAnalytics\_GetProcDependencies.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\_GetProcDependencies.sql" >> %IvpFile%

call AddSeparator.bat 5
echo print 'FQN: D:\dev\SQL\DFINAnalytics\create_master_seq.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\create_master_seq.sql" >> %IvpFile%

call AddSeparator.bat 6
echo print 'FQN: D:\dev\SQL\DFINAnalytics\TestDBConnection.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\TestDBConnection.sql" >> %IvpFile%

call AddSeparator.bat 10
echo print 'FQN: D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\sp_UTIL_GetSeq.sql" >> %IvpFile%

call AddSeparator.bat 10.1
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_ActiveDatabases.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_ActiveDatabases.sql" >> %IvpFile%


call AddSeparator.bat 11
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_GetSeq.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_GetSeq.sql" >> %IvpFile%

call AddSeparator.bat 12
echo print 'FQN: D:\dev\SQL\DFINAnalytics\_CreateTempProc.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\_CreateTempProc.sql" >> %IvpFile%

call AddSeparator.bat 13
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_DbMon_IndexVolitity.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_DbMon_IndexVolitity.sql" >> %IvpFile%

call AddSeparator.bat 14
echo print 'D:\dev\SQL\DFINAnalytics\azure_sp_MSforeachdb.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\azure_sp_MSforeachdb.sql" >> %IvpFile%

call AddSeparator.bat 15
echo print 'FQN: D:\dev\SQL\DFINAnalytics\UTIL_RecordCount.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_RecordCount.sql" >> %IvpFile%

call AddSeparator.bat 16
echo print 'FQN: D:\dev\SQL\DFINAnalytics\UTIL_DatabaseAndFileSize.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_DatabaseAndFileSize.sql" >> %IvpFile%

call AddSeparator.bat 17
echo print 'FQN: D:\dev\SQL\DFINAnalytics\UTIL_DB_And_Table_Size_Monitor.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_DB_And_Table_Size_Monitor.sql" >> %IvpFile%

rem call AddSeparator.bat 18
rem echo print 'FQN: D:\dev\SQL\DFINAnalytics\UTIL_DFS_DbFileSizing_Azure.sql' >> %IvpFile%
rem type "D:\dev\SQL\DFINAnalytics\UTIL_DFS_DbFileSizing_Azure.sql" >> %IvpFile%

call AddSeparator.bat 19
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_DetermineWhichWaitsMostCommon.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_DetermineWhichWaitsMostCommon.sql" >> %IvpFile%

call AddSeparator.bat 20
echo print 'D:\dev\SQL\DFINAnalytics\PrintImmediate.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\PrintImmediate.sql" >> %IvpFile%

call AddSeparator.bat 21
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_SavePullCnt.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_SavePullCnt.sql" >> %IvpFile%

call AddSeparator.bat 25
echo print 'D:\dev\SQL\DFINAnalytics\findTempDbContention.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\findTempDbContention.sql" >> %IvpFile%

call AddSeparator.bat 26
echo print 'D:\dev\SQL\DFINAnalytics\FindParallelism.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\FindParallelism.sql" >> %IvpFile%

call AddSeparator.bat 27
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_SsisExecHist.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_SsisExecHist.sql" >> %IvpFile%

call AddSeparator.bat 28
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_getActiveDatabases.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_getActiveDatabases.sql" >> %IvpFile%

call AddSeparator.bat 29
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_ActiveJobs.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_ActiveJobs.sql" >> %IvpFile%


call AddSeparator.bat 30
echo print 'D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\CREATE_DFS_DB2Skip.sql" >> %IvpFile%

call AddSeparator.bat 31
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_PowershellJobSchedule.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_PowershellJobSchedule.sql" >> %IvpFile%

call AddSeparator.bat 40
echo print 'D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\sp_ckProcessDB.sql" >> %IvpFile%

call AddSeparator.bat 50
echo print 'D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DFS_DBVersion.sql" >> %IvpFile%

call AddSeparator.bat 60
echo print 'D:\dev\SQL\DFINAnalytics\createSeq2008.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\createSeq2008.sql" >> %IvpFile%

call AddSeparator.bat 70
echo print 'D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql" >> %IvpFile%

call AddSeparator.bat 80
echo print 'D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql" >> %IvpFile%

call AddSeparator.bat 90
echo print 'D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingFKIndexes.sql" >> %IvpFile%

call AddSeparator.bat 100
echo print 'D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DMV_TableReadsAndWrites.sql" >> %IvpFile%

call AddSeparator.bat 110
echo print 'D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DVM_IdentifyQueriesCandidatesForOptimization.sql" >> %IvpFile%

call AddSeparator.bat 120
echo print 'D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\find_Blocking_History.sql" >> %IvpFile%

call AddSeparator.bat 130
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_WorstPerformingQuerries2008.sql" >> %IvpFile%

call AddSeparator.bat 140
echo print 'D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\FindBlockingDetail.sql" >> %IvpFile%

call AddSeparator.bat 150
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_RebuildAllDbIndexUsingDBCC.sql" >> %IvpFile%

call AddSeparator.bat 160
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_MonitorWorkload.sql" >> %IvpFile%

call AddSeparator.bat 170
echo print 'D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\FindBlockedSPIDS.sql" >> %IvpFile%

call AddSeparator.bat 180
echo print 'D:\dev\SQL\DFINAnalytics\findLocks.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\findLocks.sql" >> %IvpFile%

call AddSeparator.bat 190
echo print 'D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\MonitorBlockingDetail.sql" >> %IvpFile%

call AddSeparator.bat 200
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_MonitorDeadlocks.sql" >> %IvpFile%

call AddSeparator.bat 210
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_ReorgFragmentedIndexes.sql" >> %IvpFile%

call AddSeparator.bat 220
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql" >> %IvpFile%

call AddSeparator.bat 230 
echo print 'type 'D:\dev\SQL\DFINAnalytics\PerformanceMonitorForProcs.sql" >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\PerformanceMonitorForProcs.sql" >> %IvpFile%

call AddSeparator.bat 240
echo print 'D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DFS_CleanDFSTables.sql" >> %IvpFile%

call AddSeparator.bat 250
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql" >> %IvpFile%

call AddSeparator.bat 260
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_DefragAllIndexes.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_DefragAllIndexes.sql" >> %IvpFile%

call AddSeparator.bat 270
echo print 'D:\dev\SQL\DFINAnalytics\sp_MeasurePerformanceInSP.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\sp_MeasurePerformanceInSP.sql" >> %IvpFile%

call AddSeparator.bat 280
echo print 'D:\dev\SQL\DFINAnalytics\sp_UTIL_RebuildAllDbIndexes.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\sp_UTIL_RebuildAllDbIndexes.sql" >> %IvpFile%

call AddSeparator.bat 281
echo print 'D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry2000_ProcessTable.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry2000_ProcessTable.sql" >> %IvpFile%

call AddSeparator.bat 282
echo print 'D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry2000_ProcessTable.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry2000_ProcessTable.sql" >> %IvpFile%


call AddSeparator.bat 283
echo print 'D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry_ProcessTable.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DFS_CPU_BoundQry_ProcessTable.sql" >> %IvpFile%

call AddSeparator.bat 284
echo print 'D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry_ProcessTable.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DFS_IO_BoundQry_ProcessTable.sql" >> %IvpFile%

call AddSeparator.bat 284
echo print 'D:\dev\SQL\DFINAnalytics\dm_exec_session_wait_stats.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\dm_exec_session_wait_stats.sql" >> %IvpFile%


REM CREATE THE VIEWS
rem echo print 'D:\dev\SQL\DFINAnalytics\Create_View_DFS_Workload.sql" >> %IvpFile%
REM type "D:\dev\SQL\DFINAnalytics\Create_View_DFS_Workload.sql" >> %IvpFile%

call AddSeparator.bat 290
echo print 'D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\create_view_SessionStatus.sql" >> %IvpFile%

call AddSeparator.bat 291
echo print 'D:\dev\SQL\DFINAnalytics\DFS_GetAllTableSizesAndRowCnt.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DFS_GetAllTableSizesAndRowCnt.sql" >> %IvpFile%

call AddSeparator.bat 292
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_UpdateQryPlansAndText.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_UpdateQryPlansAndText.sql" >> %IvpFile%

call AddSeparator.bat 295
echo print 'D:\dev\SQL\DFINAnalytics\createActiveServersTable.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\createActiveServersTable.sql" >> %IvpFile%

call AddSeparator.bat 300
echo print 'D:\dev\SQL\DFINAnalytics\VerifyUIDIndexes.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\VerifyUIDIndexes.sql" >> %IvpFile%


call AddSeparator.bat 301
echo print 'D:\dev\SQL\DFINAnalytics\ParallelExecutionStatsOnSPID.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\ParallelExecutionStatsOnSPID.sql" >> %IvpFile%

call AddSeparator.bat 302
echo print 'D:\dev\SQL\DFINAnalytics\createActiveServerJobsInsertProcs.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\createActiveServerJobsInsertProcs.sql" >> %IvpFile%

call AddSeparator.bat 303
echo print 'D:\dev\SQL\DFINAnalytics\_FillActiveServerTablesData.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\_FillActiveServerTablesData.sql" >> %IvpFile%

call AddSeparator.bat 304
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_SSIS_RunStats.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_SSIS_RunStats.sql" >> %IvpFile%

call AddSeparator.bat 305
echo print 'D:\dev\SQL\DFINAnalytics\viewDFS_QryOptStats.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\viewDFS_QryOptStats.sql" >> %IvpFile%

call AddSeparator.bat 306
echo print 'D:\dev\SQL\DFINAnalytics\UTIL_RecordGrowthHistory.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\UTIL_RecordGrowthHistory.sql" >> %IvpFile%

call AddSeparator.bat 307
echo print 'D:\dev\SQL\DFINAnalytics\_populateActiveServersTable.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\_populateActiveServersTable.sql" >> %IvpFile%

call AddSeparator.bat 308
echo print 'D:\dev\SQL\DFINAnalytics\fn_GetWorstPerformingSPs.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\fn_GetWorstPerformingSPs.sql" >> %IvpFile%

call AddSeparator.bat 309
echo print 'D:\dev\SQL\DFINAnalytics\DatabaseUsage.sql' >> %IvpFile%
type "D:\dev\SQL\DFINAnalytics\DatabaseUsage.sql" >> %IvpFile%

REM call AddSeparator.bat 300
REM type "D:\dev\SQL\DFINAnalytics\Jobs\MasterJobsScript.sql" >> %IvpFile%

call AddSeparator.bat 310
echo print 'exec UTIL_DFS_DBVersion' >> %IvpFile%
echo exec UTIL_DFS_DBVersion; >> %IvpFile%

delete D:\dev\SQL\DFINAnalytics\_IVP_DFSAnalytics.sql
copy IVP_DFINAnalytics D:\dev\SQL\DFINAnalytics\_IVP_DFSAnalytics.sql


echo on
rem notepad %IvpFile%
