

--* USEDFINAnalytics;
GO

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = '_Emergency_StartAllAnalyticsJobs'
   ) 
    BEGIN
 DROP PROCEDURE _Emergency_StartAllAnalyticsJobs;
END;
GO
-- exec _Emergency_StartAllAnalyticsJobs
CREATE PROCEDURE _Emergency_StartAllAnalyticsJobs
AS
    BEGIN

 /* SELECT 'exec _Emergency_StartAllAnalyticsJobs  N'''+  [name] + ''';' FROM msdb.dbo.sysjobs where name like 'JOB_%';*/

 EXEC msdb.dbo.sp_start_job N'JOB_ UTIL_DefragAllIndexes';
 EXEC msdb.dbo.sp_start_job N'JOB_ UTIL_Monitor_TPS';
 EXEC msdb.dbo.sp_start_job N'JOB_ UTIL_ReorgFragmentedIndexes';
 EXEC msdb.dbo.sp_start_job N'JOB_DBMON_TxMonitorTableStats';
 EXEC msdb.dbo.sp_start_job N'JOB_DFS_CleanDFSTables';
 EXEC msdb.dbo.sp_start_job N'JOB_DFS_GetAllTableSizesAndRowCnt';
 EXEC msdb.dbo.sp_start_job N'JOB_DFS_MonitorLocks';
 EXEC msdb.dbo.sp_start_job N'JOB_MonitorWorkload';
 EXEC msdb.dbo.sp_start_job N'JOB_UTIL_DbMon_IndexVolitity';
 EXEC msdb.dbo.sp_start_job N'JOB_UTIL_DFS_DbSize';
 EXEC msdb.dbo.sp_start_job N'JOB_UTIL_GetIndexStats';
 EXEC msdb.dbo.sp_start_job N'JOB_UTIL_MonitorDeadlocks';
 EXEC msdb.dbo.sp_start_job N'JOB_UTIL_QryPlanStats';
 EXEC msdb.dbo.sp_start_job N'JOB_UTIL_TrackSessionWaitStats';
 EXEC msdb.dbo.sp_start_job N'JOB_UTIL_WorstPerformingQuerries';
		EXEC msdb.dbo.sp_start_job N'UTIL_DBMon_EachDB';
    END;