GO
PRINT '***  WORKING IN DATABASE ' + DB_NAME();
GO
IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveServers'
)
    BEGIN
        DROP TABLE ActiveServers;
        PRINT '*********** RESET table ActiveServers ***********';
END; 
GO
CREATE TABLE ActiveServers
([GroupName] [NVARCHAR](50) NOT NULL, 
 [isAzure]   [CHAR](1) NOT NULL, 
 [SvrName]   [NVARCHAR](250) NOT NULL, 
 [DBName]    [NVARCHAR](150) NOT NULL, 
 [UserID]    [NVARCHAR](50) NULL, 
 [pwd]       [NVARCHAR](50) NULL, 
 [UID]       [UNIQUEIDENTIFIER] NOT NULL, 
 [Enable]    [BIT] NULL
)
ON [PRIMARY];
ALTER TABLE [dbo].[ActiveServers]
ADD CONSTRAINT [DF_ActiveServers_UID] DEFAULT(NEWID()) FOR [UID];
ALTER TABLE [dbo].[ActiveServers]
ADD DEFAULT((1)) FOR [Enable];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewAwaitingJobs'
)
    BEGIN
        DROP VIEW viewAwaitingJobs;
END;
GO

/*
alter table [dbo].[ActiveJob] add [Enable] char(1) default 'Y';
update [dbo].[ActiveJob] set [Enable] = 'Y'
*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJob'
)
    BEGIN
        DROP TABLE ActiveJob;
END;
GO
CREATE TABLE [dbo].[ActiveJob]
([JobName]      [NVARCHAR](150) NOT NULL, 
 [disabled]     [CHAR](1) NULL, 
 [OncePerServer]     [CHAR](1) NULL default 'N', 
 [UID]          [UNIQUEIDENTIFIER] NOT NULL, 
 [ScheduleUnit] [NVARCHAR](25) NULL, 
 [ScheduleVal]  [INT] NULL, 
 [LastRunDate]  [DATETIME] NULL, 
 [NextRunDate]  [DATETIME] NULL, 
 [Enable]       CHAR(1) DEFAULT 'Y', 
 [RowNbr]       [INT] IDENTITY(1, 1) NOT NULL
)
ON [PRIMARY];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT('N') FOR [disabled];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT(NEWID()) FOR [UID];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT(GETDATE()) FOR [LastRunDate];
ALTER TABLE [dbo].[ActiveJob]
ADD DEFAULT(GETDATE()) FOR [NextRunDate];
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJob'
          AND COLUMN_NAME = 'Enable'
)
    BEGIN
        ALTER TABLE [dbo].[ActiveJob]
        ADD [Enable] CHAR(1) DEFAULT 'Y';
        UPDATE [dbo].[ActiveJob]
          SET 
              [Enable] = 'Y';
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
/*
drop table ActiveJobSchedule
*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobSchedule'
)
    BEGIN
        CREATE TABLE ActiveJobSchedule
        (SvrName     NVARCHAR(150) NOT NULL, 
         JobName     NVARCHAR(150) NOT NULL, 
         [Disabled]  CHAR(1) NOT NULL
                             DEFAULT 'N', 
         LastRunDate DATETIME NULL
                              DEFAULT GETDATE(), 
         NextRunDate DATETIME NULL
                              DEFAULT GETDATE()
        );
        CREATE UNIQUE INDEX pkActiveJobSchedule
        ON ActiveJobSchedule
        (SvrName, JobName
        );
        CREATE INDEX piActiveJobScheduleDisabled
        ON ActiveJobSchedule
        ([Disabled]
        );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobSetLastRunDate'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobSetLastRunDate;
END;
GO

/*
exec UTIL_ActiveJobSetLastRunDate 6
exec UTIL_ActiveJobSetLastRunDate 170
*/

CREATE PROCEDURE UTIL_ActiveJobSetLastRunDate(@JobName NVARCHAR(150))
AS
    BEGIN
        DECLARE @ScheduleUnit AS NVARCHAR(25)= '';
        DECLARE @ScheduleVal INT= 0;
        DECLARE @NextRunDate AS DATETIME= NULL;
        DECLARE @UpdateNow AS INT= 0;
        SET @ScheduleUnit =
        (
            SELECT ScheduleUnit
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        SET @ScheduleVal =
        (
            SELECT ScheduleVal
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        IF
           (@ScheduleUnit = 'sec'
           )
            BEGIN
                SET @NextRunDate = DATEADD(SECOND, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'min'
           )
            BEGIN
                SET @NextRunDate = DATEADD(MINUTE, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'hour'
           )
            BEGIN
                SET @NextRunDate = DATEADD(HOUR, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'day'
           )
            BEGIN
                SET @NextRunDate = DATEADD(DAY, @ScheduleVal, GETDATE());
                SET @UpdateNow = 1;
        END;
        IF
           (@UpdateNow = 1
           )
            BEGIN
                UPDATE [dbo].[ActiveJob]
                  SET 
                      [NextRunDate] = @NextRunDate
                WHERE JobName = @JobName;
        END;
        PRINT 'LastRunDate set to : ' + CAST(@NextRunDate AS NVARCHAR(60)) + ' on Job ' + @JobName;
    END;
GO

/*
exec UTIL_ActiveJobSetLastRunDate 'JOB_DFS_BoundQry_ProcessAllTables', '93b33429-854e-4d96-a001-2b0f4da547ba'
select * from ActiveJob 
delete from ActiveJob

select distinct isAzure +'|' + SvrName + '|' + DBName +'|' + isnull(UserID,'') + '|' + isnull(pwd,'') as [DATA]
from [dbo].[ActiveJob]

drop table ActiveJob;
drop table ActiveJobStep;
drop table ActiveJobExecutions;
*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobExecutions'
)
    BEGIN
        CREATE TABLE ActiveJobExecutions
        ([JobName]          NVARCHAR(150) NOT NULL, 
         [SvrName]          NVARCHAR(150) NOT NULL, 
         [DBName]           NVARCHAR(150) NOT NULL, 
         [StepName]         NVARCHAR(150) NOT NULL, 
         [JOBUID]           UNIQUEIDENTIFIER NOT NULL, 
         ExecutionDate      DATE DEFAULT GETDATE(), 
         StartExecutionDate DATETIME2 DEFAULT GETDATE(), 
         EndExecutionDate   DATETIME2 NULL, 
         NextRunDate        DATETIME2 NULL, 
         [ScheduleUnit]     NVARCHAR(25) NULL, 
         [ScheduleVal]      INT NULL, 
         elapsedMS          DECIMAL(18, 4) NULL, 
         elapsedSEC         DECIMAL(18, 4) NULL, 
         elapsedMIN         DECIMAL(18, 4) NULL, 
         elapsedHR          DECIMAL(18, 4) NULL, 
         JobRowNbr          INT NULL, 
         StepRowNbr         INT NULL, 
         RowNbr             INT IDENTITY(1, 1) NOT NULL
        );
        CREATE INDEX piActiveJobExecutionsRowNbr
        ON ActiveJobExecutions
        (SvrName, DBName, [JobName], [StepName], RowNbr
        );
        CREATE INDEX piActiveJobExecutions
        ON ActiveJobExecutions
        (SvrName, DBName, [StepName], [JobName], [JOBUID]
        );
        CREATE INDEX piActiveJobExecutionsUID
        ON ActiveJobExecutions
        (JobRowNbr, StepRowNbr
        );
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'RowNbr'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD RowNbr INT IDENTITY(1, 1) NOT NULL;
END;
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'NextRunDate'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD NextRunDate DATETIME NULL
                                 DEFAULT GETDATE();
END;
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'ScheduleUnit'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD ScheduleUnit NVARCHAR(25) NULL;
END;
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE TABLE_NAME = 'ActiveJobExecutions'
          AND COLUMN_NAME = 'ScheduleVal'
)
    BEGIN
        ALTER TABLE ActiveJobExecutions
        ADD ScheduleVal INT NULL;
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobExecutions'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobExecutions;
END;
GO

/*
delete from ActiveJobExecutions

declare @UID uniqueidentifier = newid();
print @UID
exec UTIL_ActiveJobExecutions 'S', 'XXX', 'Step01', 'MAIN_SERVER', 'MASTER_DB', '95B723BD-7110-4A40-BD21-2E65C8D317FE';
select top 100 * from ActiveJobExecutions ;
select top 100 * from ActiveJob order by lastRunDate desc ;
exec UTIL_ActiveJobExecutions 'E', 'XXX', 'Step01', 'MAIN_SERVER', 'MASTER_DB', '95B723BD-7110-4A40-BD21-2E65C8D317FE';
select * from ActiveJobExecutions ;
select datediff(millisecond, StartExecutionDate,EndExecutionDate) as DD from ActiveJobExecutions ;
select * from ActiveJob ;

this procedure is called with "function setTimer" within D:\dev\SQL\DFINAnalytics\PowerShell\JobsDFIN\modules\JOB_StdFunctions.ps1

*/

CREATE PROCEDURE UTIL_ActiveJobExecutions
(@action   CHAR(1), 
 @JobName  NVARCHAR(150), 
 @StepName NVARCHAR(150), 
 @SvrName  NVARCHAR(150), 
 @DBName   NVARCHAR(150), 
 @JOBUID   NVARCHAR(60)
)
AS
    BEGIN
        DECLARE @ScheduleUnit NVARCHAR(50)= '';
        DECLARE @ScheduleVal INT= -1;
        DECLARE @NextRunDate DATETIME;
        SET @ScheduleUnit =
        (
            SELECT ScheduleUnit
            FROM [dbo].[ActiveJob]
            WHERE Jobname = @Jobname
        );
        SET @ScheduleVal =
        (
            SELECT ScheduleVal
            FROM [dbo].[ActiveJob]
            WHERE Jobname = @Jobname
        );
        SET @NextRunDate =
        (
            SELECT dbo.CalcNextRunDate(@ScheduleUnit, @ScheduleVal)
        );
        IF
           (@action = 'S'
           )
            BEGIN
                INSERT INTO [dbo].[ActiveJobExecutions]
                ( [JobName], 
                  [SvrName], 
                  [DBName], 
                  [StepName], 
                  [JOBUID], 
                  [ExecutionDate], 
                  [StartExecutionDate], 
                  ScheduleUnit, 
                  ScheduleVal
                ) 
                VALUES
                (
                       @JobName
                     , @SvrName
                     , @DBName
                     , @StepName
                     , CAST(@JOBUID AS UNIQUEIDENTIFIER)
                     , GETDATE()
                     , GETDATE()
                     , @ScheduleUnit
                     , @ScheduleVal
                );
                PRINT 'ADDED: ' + @SvrName + ' @ ' + @DBName + ' @ ' + @StepName + ' @ ' + @JobName + ' @ ' + @JOBUID;
        END;
        IF
           (@action = 'E'
           )
            BEGIN
                UPDATE [ActiveJobExecutions]
                  SET 
                      [EndExecutionDate] = GETDATE(), 
                      elapsedMS = DATEDIFF(MILLISECOND, StartExecutionDate, GETDATE()), 
                      elapsedSEC = DATEDIFF(SECOND, StartExecutionDate, GETDATE()), 
                      elapsedMIN = DATEDIFF(MINUTE, StartExecutionDate, GETDATE()), 
                      elapsedHR = DATEDIFF(HOUR, StartExecutionDate, GETDATE()), 
                      NextRunDate = @NextRunDate
                WHERE JobName = @JobName
                      AND StepName = @StepName
                      AND SvrName = @SvrName
                      AND [EndExecutionDate] IS NULL;
                PRINT 'UPDATED: ' + @SvrName + ' @ ' + @DBName + ' @ ' + @StepName + ' @ ' + @JobName + ' @ ' + @JOBUID;
                UPDATE [dbo].[ActiveJob]
                  SET 
                      [LastRunDate] = GETDATE()
                WHERE JobName = @JobName;
                PRINT 'ActiveJob LastRunDate set to : ' + CAST(GETDATE() AS NVARCHAR(60));
        END;
    END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJob'
)
    BEGIN
        CREATE TABLE ActiveJob
        ([JobName]    NVARCHAR(150) NOT NULL, 
         [disabled]   CHAR(1) DEFAULT 'N', 
         [UID]        UNIQUEIDENTIFIER NOT NULL
                                       DEFAULT NEWID(), 
         ScheduleUnit NVARCHAR(25) NULL, 
         ScheduleVal  INT NULL, 
         LastRunDate  DATETIME DEFAULT GETDATE(), 
         NextRunDate  DATETIME DEFAULT GETDATE(), 
         RowNbr       INT IDENTITY(1, 1) NOT NULL
        );
        CREATE INDEX piActiveJob
        ON ActiveJob
        ([UID]
        );
        CREATE UNIQUE INDEX pk01ActiveJob
        ON ActiveJob
        (JobName
        );
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobStep'
)
    BEGIN
        CREATE TABLE ActiveJobStep
        ([JobName]      NVARCHAR(150) NOT NULL, 
         [StepName]     NVARCHAR(150) NOT NULL, 
         ExecutionOrder INT NULL
                            DEFAULT 1, 
         [StepSQL]      NVARCHAR(MAX) NOT NULL, 
         [disabled]     CHAR(1) DEFAULT 'N', 
         [RunIdReq]     CHAR(1) DEFAULT 'N', 
         [JOBUID]       UNIQUEIDENTIFIER NOT NULL, 
         AzureOK        CHAR(1) DEFAULT 'Y', 
         RowNbr         INT IDENTITY(1, 1) NOT NULL
        );
        CREATE UNIQUE INDEX pkActiveJobStep
        ON ActiveJobStep
        ([JobName], [StepName]
        );
END;
GO
IF NOT EXISTS
(
    SELECT column_name
    FROM INFORMATION_SCHEMA.columns
    WHERE table_name = 'ActiveJobStep'
          AND column_name = 'ExecutionOrder'
)
    BEGIN
        ALTER TABLE ActiveJobStep
        ADD ExecutionOrder INT NULL;
END;
GO
IF NOT EXISTS
(
    SELECT column_name
    FROM INFORMATION_SCHEMA.columns
    WHERE table_name = 'ActiveJobStep'
          AND column_name = 'JobName'
)
    BEGIN
        ALTER TABLE ActiveJobStep
        ADD JobName NVARCHAR(150) NULL;
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'pkActiveJobStep'
)
    BEGIN
        CREATE UNIQUE NONCLUSTERED INDEX [pkActiveJobStep]
        ON [dbo].[ActiveJobStep]
        ([JOBUID] ASC, [StepName] ASC
        ) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
        ON [PRIMARY];
END;
GO

/*alter table ActiveJobStep add JobName nvarchar(150)  null*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJob'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJob;
END;
GO
CREATE PROCEDURE UTIL_ActiveJob
(@JobName      NVARCHAR(150), 
 @ScheduleUnit NVARCHAR(25), 
 @ScheduleVal  INT, 
 @NextRunDate  DATETIME, 
 @JobDisabled  CHAR(1)       = 'N', 
 @StepName     NVARCHAR(150), 
 @StepDisabled CHAR(1)       = 'N', 
 @StepSQL      NVARCHAR(150), 
 @RunIdReq     CHAR(1)       = 'N', 
 @AzureOK      CHAR(1)       = 'Y'
)
AS
    BEGIN
        DECLARE @JobRowNbr INT= 0;
        DECLARE @StepRowNbr INT= 0;
        DECLARE @jobguid UNIQUEIDENTIFIER= NULL;
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveJob
            WHERE JobName = @JobName
        );
        IF
           (@cnt = 1
           )
            BEGIN
                UPDATE ActiveJob
                  SET 
                      ScheduleUnit = @ScheduleUnit, 
                      ScheduleVal = @ScheduleVal, 
                      [disabled] = @JobDisabled
                WHERE JobName = @JobName;
                PRINT 'UPDATING Job: ' + @JobName + ' SET TO ' + @JobDisabled;
        END;
            ELSE
            BEGIN
                PRINT 'ADDING Job: ' + @JobName;
                INSERT INTO ActiveJob
                ( JobName, 
                  ScheduleUnit, 
                  ScheduleVal, 
                  [disabled]
                ) 
                VALUES
                (
                       @JobName
                     , @ScheduleUnit
                     , @ScheduleVal
                     , @JobDisabled
                );
        END;
        SET @jobguid =
        (
            SELECT [UID]
            FROM ActiveJob
            WHERE JobName = @JobName
        );
        PRINT '@jobguid = ' + CAST(@jobguid AS NVARCHAR(60));
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveJobStep
            WHERE JobName = @JobName 
				  and StepName = @StepName
                  AND JOBUID = @jobguid
        );
        PRINT 'COUNT FROM ActiveJobStep = ' + CAST(@cnt AS NVARCHAR(50));
        IF
           (@cnt = 0
           )
            BEGIN
                PRINT 'ADDING Step: ' + @JobName + ' : '  + @StepName;
                INSERT INTO ActiveJobStep
                ( JobName, [StepName], 
                  [StepSQL], 
                  [disabled], 
                  [RunIdReq], 
                  [JOBUID], 
                  AzureOK
                ) 
                VALUES
                (
                     @JobName
					 ,  @StepName
                     , @StepSQL
                     , @StepDisabled
                     , @RunIdReq
                     , @jobguid
                     , @AzureOK
                );
        END;
            ELSE
            BEGIN
                PRINT 'UPDATING Step: ' + @StepName;
                UPDATE ActiveJobStep
                  SET 
                      [StepSQL] = @StepSQL, 
                      [disabled] = @StepDisabled, 
                      [RunIdReq] = @RunIdReq, 
                      AzureOK = @AzureOK
                WHERE StepName = @StepName
                      AND JOBUID = @jobguid;
        END;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveJob
        );
        PRINT 'COUNT FROM ActiveJob = ' + CAST(@cnt AS NVARCHAR(50));
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobFetch'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobFetch;
END;
GO

/*
	exec UTIL_ActiveJobFetch ;
*/

CREATE PROCEDURE UTIL_ActiveJobFetch(@JobName NVARCHAR(150) = NULL)
AS
    BEGIN
        IF(@JobName IS NULL)
            BEGIN
                SELECT AJ.[JobName], 
                       AJ.[disabled] AS JobDisabled, 
                       AJ.ScheduleUnit, 
                       AJ.ScheduleVal, 
                       AJ.LastRunDate, 
                       AJ.NextRunDate, 
                       AJS.[StepName], 
                       AJS.[StepSQL], 
                       AJS.[disabled] AS StepDisabled, 
                       [RunIdReq], 
                       AzureOK, 
                       AJS.RowNbr AS StepRownbr, 
                       AJ.RowNbr AS JobRownbr
                FROM ActiveJob AS AJ
                          JOIN ActiveJobStep AS AJS
                          ON [JOBUID] = [UID]
                WHERE AJ.[disabled] = 'N'
                      AND AJ.NextRunDate <= GETDATE()
                ORDER BY AJS.RowNbr;
        END;
            ELSE
            BEGIN
                SELECT AJ.[JobName], 
                       AJ.[disabled] AS JobDisabled, 
                       AJ.ScheduleUnit, 
                       AJ.ScheduleVal, 
                       AJ.LastRunDate, 
                       AJ.NextRunDate, 
                       AJS.[StepName], 
                       AJS.[StepSQL], 
                       AJS.[disabled] AS StepDisabled, 
                       [RunIdReq], 
                       AzureOK, 
                       AJS.RowNbr AS StepRownbr, 
                       AJ.RowNbr AS JobRownbr
                FROM ActiveJob AS AJ
                          JOIN ActiveJobStep AS AJS
                          ON [JOBUID] = [UID]
                WHERE AJ.[disabled] = 'N'
                      AND AJ.JobName = @JobName
                      AND AJ.NextRunDate <= GETDATE()
                ORDER BY AJS.RowNbr;
        END;
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobSchedule'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobSchedule;
END;
GO

/*
	truncate table ActiveJobSchedule
*/

CREATE PROCEDURE UTIL_ActiveJobSchedule
AS
    BEGIN
        DECLARE @SvrName NVARCHAR(250)= '';
        DECLARE @JobName NVARCHAR(250)= '';
        DECLARE @cnt INT= 0;
        DECLARE @SvrUID UNIQUEIDENTIFIER;
        DECLARE @JobUID UNIQUEIDENTIFIER;
        DECLARE cursorDb CURSOR
        FOR SELECT DISTINCT 
                   SvrName
            FROM ActiveServers;
        OPEN cursorDb;
        FETCH NEXT FROM cursorDb INTO @SvrName;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT @SvrName;
                DECLARE cursorJobs CURSOR
                FOR SELECT DISTINCT 
                           JobName
                    FROM ActiveJob;
                OPEN cursorJobs;
                FETCH NEXT FROM cursorJobs INTO @JobName;
                WHILE @@FETCH_STATUS = 0
                    BEGIN
                        PRINT @SvrName + ' : ' + @JobName;
                        SET @cnt =
                        (
                            SELECT COUNT(*)
                            FROM ActiveJobSchedule
                            WHERE SvrName = @SvrName
                                  AND JobName = @JobName
                        );
                        IF
                           (@cnt = 0
                           )
                            BEGIN
                                INSERT INTO [dbo].ActiveJobSchedule
                                ( SvrName, 
                                  JobName, 
                                  [Disabled], 
                                  [LastRunDate]
                                ) 
                                VALUES
                                (
                                       @SvrName
                                     , @JobName
                                     , 'N'
                                     , GETDATE()
                                );
                        END;
                        FETCH NEXT FROM cursorJobs INTO @JobName;
                    END;
                CLOSE cursorJobs;
                DEALLOCATE cursorJobs;
                FETCH NEXT FROM cursorDb INTO @SvrName;
            END;
        CLOSE cursorDb;
        DEALLOCATE cursorDb;
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveJobScheduleSetLastRunDate'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveJobScheduleSetLastRunDate;
END;
GO
CREATE PROCEDURE UTIL_ActiveJobScheduleSetLastRunDate
(@SvrName NVARCHAR(150), 
 @JobName NVARCHAR(150)
)
AS
    BEGIN
        DECLARE @ScheduleUnit AS NVARCHAR(25)= '';
        DECLARE @ScheduleVal INT= 0;
        DECLARE @NextRunDate AS DATETIME= NULL;
        DECLARE @UpdateNow AS INT= 0;
        DECLARE @now DATETIME= GETDATE();
        SET @ScheduleUnit =
        (
            SELECT ScheduleUnit
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        SET @ScheduleVal =
        (
            SELECT ScheduleVal
            FROM [dbo].[ActiveJob]
            WHERE JobName = @JobName
        );
        IF
           (@ScheduleUnit = 'sec'
           )
            BEGIN
                SET @NextRunDate = DATEADD(SECOND, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'min'
           )
            BEGIN
                SET @NextRunDate = DATEADD(MINUTE, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'hour'
           )
            BEGIN
                SET @NextRunDate = DATEADD(HOUR, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@ScheduleUnit = 'day'
           )
            BEGIN
                SET @NextRunDate = DATEADD(DAY, @ScheduleVal, @now);
                SET @UpdateNow = 1;
        END;
        IF
           (@UpdateNow = 1
           )
            BEGIN
                UPDATE [dbo].ActiveJobSchedule
                  SET 
                      [NextRunDate] = @NextRunDate, 
                      [lastRunDate] = @now
                WHERE SvrName = @SvrName
                      AND JobName = @JobName;
        END;

/*print 'ScheduleUnit: ' + @ScheduleUnit ;
		print 'ScheduleVal: ' + cast(@ScheduleVal as nvarchar(15));
		print 'Current Datetime: ' + CAST(GETDATE() AS NVARCHAR(60));*/

        PRINT 'LastRunDate set to : ' + CAST(@NextRunDate AS NVARCHAR(60)) + ' on SvrName: ' + @SvrName + ' @ JobName: ' + @JobName;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveDatabases'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveDatabases;
END;
GO

/*
SELECT *
FROM [ActiveServers];
exec UTIL_getActiveDatabases 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveDatabases(@TgtGroup NVARCHAR(50))
AS
    BEGIN
        IF
           (@TgtGroup != '*'
           )
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1
                      AND GroupName = @TgtGroup;
        END;
            ELSE
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1;
        END;
    END;
GO
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobs'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobs;
END;
GO

/*
exec UTIL_getActiveSvrJobs 
exec UTIL_getActiveSvrJobs 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveSvrJobs(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       MAX(NextRunDate) AS NextRunDate, 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK],
					   JobExecutionOrder
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         [DBUID], 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [StepName], 
                         [ExecutionOrder], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK],
						 JobExecutionOrder
                ORDER BY JobExecutionOrder,
					     SvrName, 
                         JobName, 
                         ExecutionOrder, 
                         NextRunDate DESC;
        END;
            ELSE
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       MAX(NextRunDate) AS NextRunDate, 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK],
					   JobExecutionOrder
                FROM [dbo].[viewAwaitingJobs]
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         [DBUID], 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [StepName], 
                         [ExecutionOrder], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK],
						 JobExecutionOrder
                ORDER BY JobExecutionOrder, SvrName, 
                         JobName, 
                         ExecutionOrder, 
                         NextRunDate DESC;
        END;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobsDelimited'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobsDelimited;
END;
GO

/*
exec UTIL_getActiveSvrJobsDelimited 
*/

CREATE PROCEDURE UTIL_getActiveSvrJobsDelimited(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        DECLARE @tblID INT= 0;
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SET @tblID = 1;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
                       ExecutionOrder
                INTO #TempJobs1
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
                         ExecutionOrder
                ORDER BY JobName, 
                         SvrName;
        END;
            ELSE
            BEGIN
                SET @tblID = 2;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
                       ExecutionOrder
                INTO #TempJobs2
                FROM [dbo].[viewAwaitingJobs]
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
                         ExecutionOrder
                ORDER BY JobName, 
                         SvrName;
        END;
        IF
           (@tblID = 1
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] + '|' + CAST(ExecutionOrder AS NVARCHAR(60)) + ';'
                FROM #TempJobs1;
        END;
        IF
           (@tblID = 2
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] + '|' + CAST(ExecutionOrder AS NVARCHAR(60)) + ';'
                FROM #TempJobs2;
        END;
    END;
GO

/*
select 'DECLARE @JobName NVARCHAR(150), @JobDisabled CHAR(1), @StepName NVARCHAR(150), @StepDisabled CHAR(1), @StepSQL NVARCHAR(150), @RunIdReq CHAR(1);'+char(10) as cmd
union
SELECT 'set @Jobname = ''' + AJ.[JobName] + ''';' +char(10) +
	   'set @JobDisabled = ''' + AJ.[disabled] + ''';' + char(10) +
	   'set @StepName = ''' + AJS.[StepName] + ''';' + char(10) +
	   'set @StepDisabled = ''' + AJS.[disabled] + ''';' + char(10) +
	   'set @StepSQL = ''' + AJS.[StepSQL] + ''';' + char(10) +
	   'set @RunIdReq = ''' + [RunIdReq]+ + ''';'  + char(10) +
	   'exec UTIL_ActiveJob @JobName, @ScheduleUnit,@ScheduleVal , @NextRunDate , @JobDisabled, @StepName, @StepDisabled, @StepSQL, @RunIdReq, @AzureOK;'+ char(10) as cmd
                FROM ActiveJob AJ
                          JOIN ActiveJobStep AJS
                          ON [JOBUID] = [UID]

TRUNCATE TABLE [dbo].[ActiveJob];
TRUNCATE TABLE [dbo].[ActiveJobStep];

*/

DECLARE @db NVARCHAR(150)= DB_NAME();
DECLARE @AddJobsToDatabase INT= 0;
IF
   (@db != 'DFINAnalytics'
   )
    BEGIN
        PRINT '>>> JOBS WILL NOT BE ADDED TO THIS DATABASE: ' + @DB + ', THEY EXIST IN DFINAnalytics database.';
END;
IF(@AddJobsToDatabase = 1
   AND @db = 'DFINAnalytics')
    BEGIN
        DECLARE @JobName NVARCHAR(150), @JobDisabled CHAR(1), @StepName NVARCHAR(150), @StepDisabled CHAR(1), @StepSQL NVARCHAR(150), @RunIdReq CHAR(1), @AzureOK CHAR(1);
        DECLARE @ScheduleUnit NVARCHAR(25), @ScheduleVal INT, @LastRunDate DATETIME, @NextRunDate DATETIME;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_JOB_UTIL_MonitorDeadlocks';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_DbMon_IndexVolitity';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_TxMonitorTableIndexStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_GetIndexStats';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_GetIndexStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_MonitorDeadlocks';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_DFS_DeadlockStats ';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_ParallelMonitor';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_ParallelMonitor';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
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
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_TempDbMonitor';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'UTIL_TempDbMonitor';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'N';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_TrackSessionWaitStats';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_DFS_WaitStats @RunID 30';
        SET @RunIdReq = 'N';
        SET @AzureOK = 'Y';
        SET @ScheduleUnit = 'min';
        SET @ScheduleVal = 10;
        SET @LastRunDate = NULL;
        SET @NextRunDate = GETDATE();
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'JOB_UTIL_TxMonitorTableStats';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_TxMonitorTableStats';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
        SET @Jobname = 'UTIL_TxMonitorIDX';
        SET @JobDisabled = 'N';
        SET @StepName = 'Step01';
        SET @StepDisabled = 'N';
        SET @StepSQL = 'sp_UTIL_TxMonitorIDX';
        SET @RunIdReq = 'Y';
        SET @AzureOK = 'Y';
        EXEC UTIL_ActiveJob 
             @JobName, 
             @ScheduleUnit, 
             @ScheduleVal, 
             @NextRunDate, 
             @JobDisabled, 
             @StepName, 
             @StepDisabled, 
             @StepSQL, 
             @RunIdReq, 
             @AzureOK;
END;
EXEC UTIL_ActiveJobSchedule;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveJobStep'
)
    BEGIN
        PRINT '*********** CREATING table ActiveJobStep ***********';
        CREATE TABLE ActiveJobStep
        ([StepName] NVARCHAR(150) NOT NULL, 
         [StepSQL]  NVARCHAR(MAX) NOT NULL, 
         [disabled] CHAR(1) DEFAULT 'N', 
         [RunIdReq] CHAR(1) DEFAULT 'N', 
         [JOBUID]   UNIQUEIDENTIFIER NOT NULL, 
         AzureOK    CHAR(1) DEFAULT 'Y', 
         RowNbr     INT IDENTITY(1, 1) NOT NULL
        );
        CREATE UNIQUE INDEX pkActiveJobStep
        ON ActiveJobStep
        ([JOBUID], [StepName]
        );
END;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.columns
    WHERE table_name = 'ActiveServers'
          AND COLUMN_NAME = 'Enable'
)
    BEGIN
        ALTER TABLE ActiveServers
        ADD [Enable] BIT NOT NULL
                         DEFAULT 1;
        UPDATE ActiveServers
          SET 
              [Enable] = 1;
END; 
GO

/*
after creating, execute D:\dev\SQL\DFINAnalytics\UTIL_ActiveDatabases.sql

select * from viewAwaitingJobs where SvrName like 'DFIN%'

select SvrName, DbName, JobName, StepName, count(*) as CNT
from viewAwaitingJobs
group by SvrName, DbName, JobName, StepName

*/

IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewActiveJobExecutions'
)
    BEGIN
        DROP VIEW viewActiveJobExecutions;
END;
GO
CREATE VIEW viewActiveJobExecutions
AS
     SELECT DISTINCT 
            SvrName, 
            DBName, 
            JobName, 
            StepName, 
            MAX(NextRunDate) AS NextRunDate
     FROM [dbo].[ActiveJobExecutions]
     GROUP BY SvrName, 
              DBName, 
              JobName, 
              StepName;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.views
    WHERE name = 'viewAwaitingJobs'
)
    BEGIN
        DROP VIEW viewAwaitingJobs;
END;
GO

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ActiveJob' and column_name = 'ExecutionOrder')
	alter table ActiveJob add ExecutionOrder int default 999;

go
CREATE VIEW viewAwaitingJobs
AS

/*
select count(*) from [dbo].[ActiveJob] AS AJ
select count(*) from [dbo].[ActiveJobStep] AS AJS
select count(*) from ActiveJobSchedule AS SCH
select count(*) from [dbo].[ActiveServers] AS SVR
select * from viewAwaitingJobs
*/

     SELECT DISTINCT 
            SVR.GroupName, 
            SVR.SvrName, 
            SVR.DBName, 
            AJ.[JobName], 
            SVR.UserID, 
            SVR.pwd, 
            SVR.isAzure, 
            SVR.UID AS DBUID, 
            AJ.[UID] AS JobUID, 
            AJ.[ScheduleUnit], 
            AJ.[ScheduleVal], 
            AJ.[LastRunDate], 
            --ISNULL(AJE.[NextRunDate], GETDATE() - 1) AS NextRunDate, 
			SCH.NextRunDate,
            AJS.[StepName], 
            AJS.ExecutionOrder, 
            AJS.[StepSQL], 
            AJS.[RunIdReq], 
            AJS.[AzureOK],
			AJ.OncePerServer,
			AJ.ExecutionOrder as JobExecutionOrder
     FROM [dbo].[ActiveJob] AS AJ
               JOIN [dbo].[ActiveJobStep] AS AJS
					ON AJ.JobName = AJS.JobName
					AND AJS.[disabled] = 'N'
               JOIN ActiveJobSchedule AS SCH
				ON SCH.JobName = AJ.JobName
               JOIN [dbo].[ActiveServers] AS SVR
					ON SVR.SvrName = SCH.SvrName
					AND SVR.[Enable] = 1
               --LEFT OUTER JOIN viewActiveJobExecutions AS AJE
               --ON AJE.JobName = SCH.JobName
               --   AND AJE.SvrName = SCH.SvrName
               --   AND AJE.StepName = AJS.StepName
     WHERE AJ.[disabled] = 'N'
	 
           AND SCH.[NextRunDate] <= GETDATE()
           --OR AJE.[NextRunDate] IS NULL;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveDatabases'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveDatabases;
END;
GO

/*
SELECT *
FROM [ActiveServers];
exec UTIL_getActiveDatabases 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveDatabases(@TgtGroup NVARCHAR(50))
AS
    BEGIN
        IF
           (@TgtGroup != '*'
           )
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1
                      AND GroupName = @TgtGroup;
        END;
            ELSE
            BEGIN
                SELECT SvrName, 
                       DBName, 
                       ISNULL(UserID, 'NA') AS UserID, 
                       ISNULL(pwd, 'NA') AS pwd, 
                       isAzure, 
                       [UID]
                FROM [dbo].[ActiveServers]
                WHERE [Enable] = 1;
        END;
    END;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobs'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobs;
END;
GO

/*
exec UTIL_getActiveSvrJobs 
exec UTIL_getActiveSvrJobs 'dfintest'
*/

CREATE PROCEDURE UTIL_getActiveSvrJobs(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK],
					   OncePerServer
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                ORDER BY SvrName, 
                         JobName, 
                         [ExecutionOrder];
        END;
            ELSE
            BEGIN
                SELECT [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       [DBUID], 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [ExecutionOrder], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK],
					   OncePerServer
                FROM [dbo].[viewAwaitingJobs]
                ORDER BY SvrName, 
                         JobName, 
                         [ExecutionOrder];
        END;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_getActiveSvrJobsDelimited'
)
    BEGIN
        DROP PROCEDURE UTIL_getActiveSvrJobsDelimited;
END;
GO

/*
exec UTIL_getActiveSvrJobsDelimited 
*/

CREATE PROCEDURE UTIL_getActiveSvrJobsDelimited(@TgtGroup NVARCHAR(50) = NULL)
AS
    BEGIN
        DECLARE @tblID INT= 0;
        IF(@TgtGroup IS NOT NULL)
            BEGIN
                SET @tblID = 1;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
					   OncePerServer,
                       ExecutionOrder
                INTO #TempJobs1
                FROM [dbo].[viewAwaitingJobs]
                WHERE GroupName = @TgtGroup
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
						 OncePerServer,
                         ExecutionOrder;
        END;
            ELSE
            BEGIN
                SET @tblID = 2;
                SELECT DISTINCT 
                       [GroupName], 
                       [SvrName], 
                       [DBName], 
                       [JobName], 
                       [UserID], 
                       [pwd], 
                       [isAzure], 
                       DBUID, 
                       [JobUID], 
                       [ScheduleUnit], 
                       [ScheduleVal], 
                       [LastRunDate], 
                       [NextRunDate], 
                       [StepName], 
                       [StepSQL], 
                       [RunIdReq], 
                       [AzureOK], 
					   OncePerServer,
                       ExecutionOrder
                INTO #TempJobs2
                FROM [dbo].[viewAwaitingJobs]
                GROUP BY [GroupName], 
                         [SvrName], 
                         [DBName], 
                         [JobName], 
                         [UserID], 
                         [pwd], 
                         [isAzure], 
                         DBUID, 
                         [JobUID], 
                         [ScheduleUnit], 
                         [ScheduleVal], 
                         [LastRunDate], 
                         [NextRunDate], 
                         [StepName], 
                         [StepSQL], 
                         [RunIdReq], 
                         [AzureOK], 
						 OncePerServer,
                         ExecutionOrder
                ORDER BY JobName, 
                         SvrName;
        END;
        IF
           (@tblID = 1
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] +'|' + OncePerServer  + '|' + CAST([ExecutionOrder] AS NVARCHAR(60)) +';'
                FROM #TempJobs1;
        END;
        IF
           (@tblID = 2
           )
            BEGIN
                SELECT [GroupName] + '|' + [SvrName] + '|' + [DBName] + '|' + [JobName] + '|' + [UserID] + '|' + [pwd] + '|' + [isAzure] + '|' + CAST(DBUID AS NVARCHAR(60)) + '|' + CAST([JobUID] AS NVARCHAR(60)) + '|' + [ScheduleUnit] + '|' + CAST([ScheduleVal] AS NVARCHAR(60)) + '|' + CAST([LastRunDate] AS NVARCHAR(60)) + '|' + CAST([NextRunDate] AS NVARCHAR(60)) + '|' + [StepName] + '|' + [StepSQL] + '|' + [RunIdReq] + '|' + [AzureOK] + '|' + OncePerServer + '|' + CAST([ExecutionOrder] AS NVARCHAR(60)) +';'
                FROM #TempJobs2;
        END;
    END;
GO

IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'CalcNextRunDate')
          AND type IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    BEGIN
        DROP FUNCTION CalcNextRunDate;
END;
GO

/*
declare @nextRunDate as datetime = null;
set @nextRunDate = (SELECT dbo.CalcNextRunDate('day',3));
print @nextRunDate ;
*/

CREATE FUNCTION dbo.CalcNextRunDate
(@Unit NVARCHAR(50), 
 @Val  INT
)
RETURNS DATETIME
WITH EXECUTE AS CALLER
AS
     BEGIN
         DECLARE @NextRunDate DATETIME= NULL;
         DECLARE @now DATETIME= GETDATE();
         DECLARE @ExtVal INT= 0;
         IF(@unit = 'hr'
            OR @unit = 'hour')
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(hour, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF(@unit = 'min'
            OR @unit = 'minute')
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(minute, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF(@unit = 'sec'
            OR @unit = 'second')
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(second, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'day'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(day, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'week'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(week, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'month'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(month, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         IF
            (@unit = 'quarter'
            )
             BEGIN
                 SET @NextRunDate =
                 (
                     SELECT DATEADD(quarter, @Val, @now) AS DateAdd
                 );
                 RETURN @NextRunDate;
         END;
         RETURN GETDATE() + 1;
     END;  
GO

/*
select * from ActiveJobStep where StepSql like '%sp_UTIL_GetIndexStats%' 

update ActiveJobStep set StepSql = StepSql + ' @RunID'  where StepSql = 'sp_UTIL_GetIndexStats' 
@RunID

*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_GetIndexStats'
)
    DROP PROCEDURE [dbo].[sp_UTIL_GetIndexStats];
GO
CREATE PROCEDURE [dbo].[sp_UTIL_GetIndexStats]
(@RunID        BIGINT, 
 @MaxWaitMS    INT    = 30, 
 @MaxWaitCount INT    = 2
)
AS
    BEGIN

/*declare @RunID     BIGINT = -50 ;
		declare @MaxWaitMS INT = 0;
		declare @MaxWaitCount INT = 0 ;*/

        INSERT INTO [dbo].[DFS_IndexStats]
        ( [SvrName], 
          [DB], 
          [Obj], 
          [IdxName], 
          [range_scan_count], 
          [singleton_lookup_count], 
          [row_lock_count], 
          [page_lock_count], 
          [TotNo_Of_Locks], 
          [row_lock_wait_count], 
          [page_lock_wait_count], 
          [TotNo_Of_Blocks], 
          [row_lock_wait_in_ms], 
          [page_lock_wait_in_ms], 
          [TotBlock_Wait_TimeMS], 
          [index_id], 
          [CreateDate], 
          [SSVER], 
          RunID, 
          [UID]
        ) 
               SELECT @@ServerName AS SvrName, 
                      DB_NAME() AS DB, 
                      OBJECT_NAME(IOS.object_id) AS Obj, 
                      i.Name AS IdxName, 
                      range_scan_count, 
                      singleton_lookup_count, 
                      row_lock_count, 
                      page_lock_count, 
                      row_lock_count + page_lock_count AS TotNo_Of_Locks, 
                      row_lock_wait_count, 
                      page_lock_wait_count, 
                      row_lock_wait_count + page_lock_wait_count AS TotNo_Of_Blocks, 
                      row_lock_wait_in_ms, 
                      page_lock_wait_in_ms, 
                      row_lock_wait_in_ms + page_lock_wait_in_ms AS TotBlock_Wait_TimeMS, 
                      IOS.index_id, 
                      GETDATE() AS CreateDate, 
                      @@version AS SSVER, 
                      @RunID AS RunID, 
                      NEWID() AS [UID]
               FROM sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL) IOS
                         JOIN sys.indexes I
                         ON I.index_id = IOS.index_id
               WHERE DB_NAME() NOT IN('master', 'model', 'msdb', 'tempdb', 'DBA')
               AND OBJECT_NAME(IOS.object_id) IS NOT NULL
               AND (row_lock_wait_count >= 0
                    OR page_lock_wait_count >= 0)
               AND (page_lock_wait_in_ms >= @MaxWaitMS
                    OR row_lock_wait_in_ms >= @MaxWaitMS);
    END;
GO
UPDATE ActiveJobStep
  SET 
      StepSql = StepSql + ' @RunID'
WHERE StepSql = 'sp_UTIL_GetIndexStats';
GO

