/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [StepName]
      ,[StepSQL]
      ,[disabled]
      ,[RunIdReq]
      ,[JOBUID]
      ,[AzureOK]
      ,[RowNbr]
      ,[JobName]
  FROM [DFINAnalytics].[dbo].[ActiveJobStep]
  order by JobName

JOB_UTIL_QryPlanStats
$qry = "exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000' ;
exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000' ;
exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry' ;
exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry' ;

UTIL_UpdateQryPlansAndText sp_UTIL_DFS_WaitStats


update [dbo].[ActiveJobStep] set JobName = 'JOB_UpdateQryPlans' where StepSql like 'UTIL_UpdateQryPlansAndText%';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_TxMonitorTableStats' where StepSql = 'sp_UTIL_TxMonitorIDX';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_TxMonitorTableStats' where StepSql = 'sp_UTIL_TxMonitorTableStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_TrackSessionWaitStats' where StepSql like  'sp_UTIL_DFS_WaitStats%';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_TempDbMonitor' where StepSql = 'UTIL_TempDbMonitor';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_ReorgFragmentedIndexes' where StepSql = 'sp_UTIL_ReorgFragmentedIndexes';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_QryPlanStats' where StepSql = 'UTIL_QryPlanStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_ParallelMonitor' where StepSql = 'UTIL_ParallelMonitor';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_MonitorMostCommonWaits' where StepSql = 'UTIL_MonitorMostCommonWaits';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_MonitorMostCommonWaits' where StepSql = 'sp_UTIL_TxMonitorTableStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_MonitorDeadlocks' where StepSql = 'sp_UTIL_DFS_DeadlockStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_Monitor_TPS' where StepSql = 'sp_UTIL_TxMonitorIDX';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_Monitor_TPS' where StepSql = 'sp_UTIL_TxMonitorTableStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_GetIndexStats' where StepSql = 'sp_UTIL_GetIndexStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_DFS_DbSize' where StepSql = 'UTIL_DFS_DbFileSizing';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_DBTableSpace' where StepSql = 'UTIL_DBTableSpace';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_DBSpace' where StepSql = 'UTIL_DBSpace';
update [dbo].[ActiveJobStep] set JobName = 'JOB_UTIL_DbMon_IndexVolitity' where StepSql = 'sp_UTIL_TxMonitorTableIndexStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_MonitorWorkload' where StepSql = 'UTIL_MonitorWorkload';
update [dbo].[ActiveJobStep] set JobName = 'JOB_JOB_UTIL_MonitorDeadlocks' where StepSql = 'sp_UTIL_DFS_DeadlockStats';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_MonitorLocks' where StepSql = 'sp_DFS_MonitorLocks';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_GetAllTableSizesAndRowCnt' where StepSql = 'DFS_GetAllTableSizesAndRowCnt';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_CleanDFSTables' where StepSql = 'UTIL_CleanDFSTables';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_BoundQry_ProcessAllTables' where StepSql = 'DFS_CPU_BoundQry2000_ProcessTable';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_BoundQry_ProcessAllTables' where StepSql = 'DFS_IO_BoundQry2000_ProcessTable';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_BoundQry_ProcessAllTables' where StepSql = 'UTIL_DFS_CPU_BoundQry';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_BoundQry_ProcessAllTables' where StepSql = 'UTIL_IO_BoundQry';
update [dbo].[ActiveJobStep] set JobName = 'JOB_DFS_BoundQry_ProcessAllTables' where StepSql = 'sp_UTIL_MSTR_BoundQry2000';
update [dbo].[ActiveJobStep] set JobName = 'JOB_CaptureWorstPerfQuery' where StepSql = 'sp_UTIL_MSTR_BoundQry2000';





update [dbo].[ActiveJobStep] set JobName = 
  where StepSql = 'YY'
  and JobName = 'ZZ'