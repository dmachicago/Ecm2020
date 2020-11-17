
GO

/*
update DFS_PowershellJobSchedule set ExecutionOrder = RowNbr;
select * from DFS_PowershellJobSchedule order by RowNbr;
select distinct scheduleunit from DFS_PowershellJobSchedule;
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_PowershellJobSchedule'
)
    BEGIN
        DROP TABLE DFS_PowershellJobSchedule;
END;
GO
CREATE TABLE [dbo].[DFS_PowershellJobSchedule]
([Enabled]           INT NOT NULL
                         DEFAULT 1, 
 [FQN]               NVARCHAR(750) NOT NULL, 
 [psJobName]          NVARCHAR(75) NOT NULL, 
 [ScheduleUnit]      NVARCHAR(50) NOT NULL, 
 [ScheduleExecValue] INT NOT NULL, 
 [StartTime]         DATETIME NOT NULL, 
 [LastRunTime]       DATETIME NOT NULL, 
 [NextRunTime]       DATETIME NOT NULL, 
 [UID] [UNIQUEIDENTIFIER] NULL, 
 ExecutionOrder INT null,
 RunIdReq int null default 0,
 RowNbr              INT IDENTITY(1, 1) NOT NULL
)
ON [PRIMARY];
CREATE UNIQUE INDEX pkDFS_PowershellJobSchedule
ON DFS_PowershellJobSchedule
([UID], RunIdReq
);
CREATE UNIQUE INDEX uiDFS_PowershellJobSchedule
ON DFS_PowershellJobSchedule
([FQN],psJobName
);
GO

/*
year	yy, yyyy
quarter	qq, q
month	mm, m
dayofyear	dy, y
day	dd, d
week	wk, ww
weekday	dw, w
hour	hh
minute	mi, n
second	ss, s
millisecond	ms
microsecond	mcs
nanosecond	ns
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_PowershellJobSchedule'
)
    BEGIN
        DROP PROCEDURE UTIL_PowershellJobSchedule;
END;
GO
CREATE PROCEDURE UTIL_PowershellJobSchedule(@psJobName NVARCHAR(100))
AS
    BEGIN
        IF
           (@psJobName = '*'
           )
            BEGIN
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(year, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'year';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(quarter, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'quarter';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(dayofyear, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'dayofyear';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(day, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'day';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(WEEK, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'week';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(minute, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'minute';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(second, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'second';
                UPDATE DFS_PowershellJobSchedule
                  SET 
                      NextRunTime = DATEADD(millisecond, ScheduleExecValue, LastRunTime)
                WHERE ScheduleUnit = 'millisecond';
        END;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_PowershellJobScheduleLastRunTime'
)
    BEGIN
        DROP PROCEDURE UTIL_PowershellJobScheduleLastRunTime;
END;
GO
CREATE PROCEDURE UTIL_PowershellJobScheduleLastRunTime(@psJobName NVARCHAR(100))
AS
    BEGIN
        UPDATE DFS_PowershellJobSchedule
          SET 
              LastRunTime = GETDATE()
        WHERE psJobName = @psJobName;
    END;
GO

/*
POPULATE TABLE
*/

DECLARE @path NVARCHAR(2000)= 'D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\';
PRINT @path;
DECLARE @fqn NVARCHAR(2000)= @path;
DECLARE @psJobName NVARCHAR(100)= '';
SET @psJobName = 'JOB_DFS_BoundQry_ProcessAllTables.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 15
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_ UTIL_Monitor_TPS.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_ UTIL_ReorgFragmentedIndexes.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 7
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_CaptureWorstPerfQuery.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'hour'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_DFS_CleanDFSTables.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'hour'
     , 3
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_DFS_GetAllTableSizesAndRowCnt.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_DFS_MonitorLocks.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_JOB_UTIL_MonitorDeadlocks.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_MonitorWorkload.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 15
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DbMon_IndexVolitity.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DBSpace.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DBTableSpace.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_DFS_DbSize.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_GetIndexStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_MonitorDeadlocks.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_MonitorMostCommonWaits.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 30
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_ParallelMonitor.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 1
);
SET @psJobName = 'JOB_UTIL_QryPlanStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 30
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_TempDbMonitor.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 15
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 1
);
SET @psJobName = 'JOB_UTIL_TrackSessionWaitStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'minute'
     , 10
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);
SET @psJobName = 'JOB_UTIL_TxMonitorTableStats.ps1';
INSERT INTO [DFS_PowershellJobSchedule]
( [Enabled], 
  [FQN], 
  psJobName, 
  [ScheduleUnit], 
  [ScheduleExecValue], 
  [StartTime], 
  [LastRunTime], 
  [NextRunTime], 
  [UID], RunIdReq
) 
VALUES
(
       1
     , @fqn
     , @psJobName
     , 'day'
     , 1
     , GETDATE()
     , GETDATE()
     , GETDATE()
     , NEWID(), 0
);