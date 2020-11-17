-- W. Dale Miller July 26, 2012
SET NOCOUNT ON;
GO

-- select top 10 * from master.dbo.sysprocesses 
-- Count the locks

IF EXISTS
(
    SELECT Name
    FROM   tempdb..sysobjects
    WHERE  name LIKE '#Hold_sp_lock%'
)
    DROP TABLE #Hold_sp_lock;

CREATE TABLE #Hold_sp_lock
(spid     INT, 
 dbid     INT, 
 ObjId    INT, 
 IndId    SMALLINT, 
 Type     VARCHAR(20), 
 Resource VARCHAR(50), 
 Mode     VARCHAR(20), 
 [STATUS]   VARCHAR(20)
);

INSERT INTO #Hold_sp_lock
EXEC sp_lock;
SELECT COUNT(spid) AS lock_count, 
  SPID, 
  Type, 
  CAST(DB_NAME(DBID) AS VARCHAR(30)) AS DBName, 
  mode
FROM   #Hold_sp_lock
GROUP BY SPID, 
  Type, 
  DB_NAME(DBID), 
  MODE
ORDER BY lock_count DESC, 
  DBName, 
  SPID, 
  MODE;

		 
--Show any blocked or blocking processes

IF EXISTS
(
    SELECT Name
    FROM   tempdb..sysobjects
    WHERE  name LIKE '#Catch_SPID%'
)
    --If So Drop it
    DROP TABLE #Catch_SPID;
GO
CREATE TABLE #Catch_SPID
(bSPID INT, 
 BLK_Status CHAR(10)
);
GO
INSERT INTO #Catch_SPID
SELECT DISTINCT 
  SPID, 
  'BLOCKED'
FROM     master.dbo.sysprocesses
WHERE   blocked <> 0
UNION
SELECT DISTINCT 
  blocked, 
  'BLOCKING'
FROM   master.dbo.sysprocesses
WHERE  blocked <> 0;
DECLARE @tSPID INT;
DECLARE @blkst CHAR(10);
SELECT TOP 1 @tSPID = bSPID, 
 @blkst = BLK_Status
FROM  #Catch_SPID;

select H.* from #Hold_sp_lock H ;
--join #Catch_SPID C H.spid on C.spid;

WHILE(@@ROWCOUNT > 0)
    BEGIN
 PRINT 'DBCC Results for SPID ' + CAST(@tSPID AS VARCHAR(5)) + '( ' + RTRIM(@blkst) + ' )';
 PRINT '-----------------------------------';
 PRINT '';
 DBCC INPUTBUFFER(@tSPID);
 SELECT TOP 1 @tSPID = bSPID, 
  @blkst = BLK_Status
 FROM  #Catch_SPID
 WHERE bSPID > @tSPID
 ORDER BY bSPID;
    END;