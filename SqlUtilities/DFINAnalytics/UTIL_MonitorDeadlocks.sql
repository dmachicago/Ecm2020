
/*
exec sp_UTIL_DFS_DeadlockStats
go
SELECT *
FROM dbo.DFS_DeadlockStats
*/

----* USEmaster;
GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_DeadlockStats'
)
   AND @runnow = 1
    BEGIN
 /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 PRINT @RunID;
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; exec sp_UTIL_DFS_DeadlockStats ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
 EXEC sp_MSforeachdb 
 @command;
END;
go

----* USEDFINAnalytics;
go
--drop table dbo.DFS_DeadlockStats
IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_DeadlockStats'
)
	DROP TABLE DFS_DeadlockStats;

CREATE TABLE DFS_DeadlockStats
    (SPID INT, 
     STATUS VARCHAR(1000) NULL, 
     Login  SYSNAME NULL, 
     HostName    SYSNAME NULL, 
     BlkBy  SYSNAME NULL, 
     DBName SYSNAME NULL, 
     Command     VARCHAR(1000) NULL, 
     CPUTime     INT NULL, 
     DiskIO INT NULL, 
     LastBatch   VARCHAR(1000) NULL, 
     ProgramName VARCHAR(1000) NULL, 
     SPID2  INT, 
     REQUESTID   INT NULL, 
     RunDate     DATETIME DEFAULT GETDATE(), 
     RunID  INT, 
     [UID] uniqueidentifier default newid()
    );
	create index PI_DFS_DeadlockStats on DFS_DeadlockStats (RunID, [UID]) ;
	create index PI_DFS_DeadlockStatsUID on DFS_DeadlockStats ([UID]) ;

GO
----* USEmaster
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_DFS_DeadlockStats'
)
    DROP PROCEDURE sp_UTIL_DFS_DeadlockStats;
GO
-- exec sp_UTIL_DFS_DeadlockStats
CREATE PROCEDURE sp_UTIL_DFS_DeadlockStats (@RunID int)
AS
    BEGIN
 IF OBJECT_ID('tempdb..#tempDFS_DeadlockStats') IS NOT NULL
     DROP TABLE #tempDFS_DeadlockStats;
 CREATE TABLE #tempDFS_DeadlockStats
 (SPID INT, 
  STATUS VARCHAR(1000) NULL, 
  Login  SYSNAME NULL, 
  HostName    SYSNAME NULL, 
  BlkBy  SYSNAME NULL, 
  DBName SYSNAME NULL, 
  Command     VARCHAR(1000) NULL, 
  CPUTime     INT NULL, 
  DiskIO INT NULL, 
  LastBatch   VARCHAR(1000) NULL, 
  ProgramName VARCHAR(1000) NULL, 
  SPID2  INT, 
  REQUESTID   INT NULL --comment out for SQL 2000 databases
 );
 -- select * from #tempDFS_DeadlockStats
 INSERT INTO #tempDFS_DeadlockStats
 EXEC sp_who2;
 
 --SET @RUNID = 78;
 INSERT INTO dbo.DFS_DeadlockStats
   SELECT SPID, 
   STATUS, 
   Login, 
   HostName, 
   BlkBy, 
   DBName, 
   Command, 
   CPUTime, 
   DiskIO, 
   LastBatch, 
   ProgramName, 
   SPID2, 
   REQUESTID, 
   GETDATE(), 
   RunID = @RUNID,
					  NEWID() AS [UID]
   FROM #tempDFS_DeadlockStats;
 --WHERE DBName = 'DFINAnalytics';
 UPDATE dbo.DFS_DeadlockStats
   SET 
  BlkBy = NULL
 WHERE LTRIM(blkby) = '.';

 --SELECT * FROM dbo.DFS_DeadlockStats;
 --update dbo.DFS_DeadlockStats set BlkBy = 264 where RowID = 260

 DECLARE @BlockedSPIDS TABLE(BlockedSpid uniqueidentifier);
 INSERT INTO @BlockedSPIDS(BlockedSpid)
 (
     --select cast(blkby as int) as BlockedSpid from dbo.DFS_DeadlockStats where blkby is not null
     SELECT [UID] AS BlockedSpid
     FROM dbo.DFS_DeadlockStats
     WHERE blkby IS NOT NULL
    AND RunID = @RUNID
 );
 --select * from @BlockedSPIDS;

 DECLARE @BlockingSPIDS TABLE(BlockedingSpid uniqueidentifier);
 INSERT INTO @BlockingSPIDS(BlockedingSpid)
 (
     --select cast(blkby as int) as BlockedSpid from dbo.DFS_DeadlockStats where blkby is not null
     SELECT [UID] AS BlockedingSpid
     FROM dbo.DFS_DeadlockStats
     WHERE [UID] IN
     (
  SELECT BlockedSpid
  FROM @BlockedSPIDS
     )
 );
 --select * from @BlockingSPIDS;

 UPDATE dbo.DFS_DeadlockStats
   SET 
  BlkBy = 'X'
 WHERE dbo.DFS_DeadlockStats.[UID] IN
 (
     SELECT BlockedingSpid
     FROM @BlockingSPIDS
 );
 DELETE FROM dbo.DFS_DeadlockStats
 WHERE BlkBy IS NULL
  AND RUNID = @RUNID;
    END;
GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
