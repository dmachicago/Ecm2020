


GO
print '***********************************************************************************'
print 'This file replaced by D:\dev\SQL\DFINAnalytics\UTIL_getActiveDatabases.sql '
print '***********************************************************************************'
go

DECLARE @InitActiveJobs int= 1;

IF(@InitActiveJobs = 1 and db_name() = 'DFINAnalytics')
BEGIN
	delete from ActiveJobStep;

	DECLARE @JobName nvarchar(150), @JobDisabled char(1), @StepName nvarchar(150), @StepDisabled char(1), @StepSQL nvarchar(150), @RunIdReq char(1), @AzureOK char(1);
	DECLARE @ScheduleUnit nvarchar(25), @ScheduleVal int, @LastRunDate datetime, @NextRunDate datetime;
	SET @Jobname = 'JOB_CaptureWorstPerfQuery';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_MSTR_BoundQry2000';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step02';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step03';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step04';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step05';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'DFS_CPU_BoundQry2000_ProcessTable';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step06';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'DFS_IO_BoundQry2000_ProcessTable';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step07';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DFS_CPU_BoundQry';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_BoundQry_ProcessAllTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step08';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_IO_BoundQry';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_CleanDFSTables';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_CleanDFSTables';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'hour';
	SET @ScheduleVal = 12;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_GetAllTableSizesAndRowCnt';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'DFS_GetAllTableSizesAndRowCnt';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 1;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_DFS_MonitorLocks';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_DFS_MonitorLocks';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 5;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_JOB_UTIL_MonitorDeadlocks';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_MonitorWorkload';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_MonitorWorkload';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 10;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DbMon_IndexVolitity';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_TxMonitorTableIndexStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DBSpace';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DBSpace';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 7;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DBTableSpace';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DBTableSpace';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 1;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_DFS_DbSize';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_DFS_DbFileSizing';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'N';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 1;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_GetIndexStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_GetIndexStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_MonitorDeadlocks';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats ';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_MonitorMostCommonWaits';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_MonitorMostCommonWaits';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 15;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_ParallelMonitor';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_ParallelMonitor';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_QryPlanStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_QryPlanStats';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 30;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_ReorgFragmentedIndexes';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_ReorgFragmentedIndexes';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'day';
	SET @ScheduleVal = 7;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_TempDbMonitor';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'UTIL_TempDbMonitor';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'N';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_TrackSessionWaitStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_DFS_WaitStats @RunID , 30';
	SET @RunIdReq = 'N';
	SET @AzureOK = 'Y';
	SET @ScheduleUnit = 'min';
	SET @ScheduleVal = 10;
	SET @LastRunDate = NULL;
	SET @NextRunDate = GETDATE();
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'JOB_UTIL_TxMonitorTableStats';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_TxMonitorTableStats';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
	SET @Jobname = 'UTIL_TxMonitorIDX';
	SET @JobDisabled = 'N';
	SET @StepName = 'Step01';
	SET @StepDisabled = 'N';
	SET @StepSQL = 'sp_UTIL_TxMonitorIDX';
	SET @RunIdReq = 'Y';
	SET @AzureOK = 'Y';
	EXEC UTIL_ActiveJob @JobName, @ScheduleUnit, @ScheduleVal, @NextRunDate, @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;
END;

GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJob'
          AND COLUMN_NAME = 'OncePerServer'
)
    BEGIN
        ALTER TABLE [dbo].[ActiveJob]
        ADD OncePerServer CHAR(1) DEFAULT 'N';
END;
GO

UPDATE [dbo].[ActiveJob]
          SET 
              [OncePerServer] = 'N';

UPDATE [dbo].[ActiveJob]
          SET 
              [OncePerServer] = 'Y'
where JobName = 'JOB_UTIL_DBUsage';

go

EXEC UTIL_ActiveJobSchedule;