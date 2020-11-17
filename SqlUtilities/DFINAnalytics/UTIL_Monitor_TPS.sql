
/* D:\dev\SQL\DFINAnalytics\UTIL_Monitor_TPS.sql */

--* USEDFINAnalytics;
GO
DECLARE @runnow INT= 0;
IF @runnow = 1
    BEGIN

/*declare @RunID BIGINT = NEXT VALUE FOR master_seq;
		truncate TABLE [dbo].[DFS_IndexStats];
		select top 100 * from [dbo].[DFS_IndexStats];
		*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; exec sp_UTIL_TxMonitorIDX ' + CAST(@RunID AS NVARCHAR(50)) + ' ; exec sp_UTIL_TxMonitorTableStats ' + CAST(@RunID AS NVARCHAR(25)) + ';';
 EXEC sp_MSforeachdb 
 @command;
END;
GO

/*
-- JOB NAME
JOB_DFS_TxMonitorIDX
-- JOB STEP
exec sp_UTIL_TxMonitorIDX -22
*/
/*
-- JOB NAME
JOB_UTIL_TxMonitorTableStats
-- JOB STEP
exec dbo.sp_UTIL_TxMonitorTableStats
*/
/*
-- =======================================================
DECLARE @command VARCHAR(1000);
SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec dbo.sp_UTIL_TxMonitorIDX @DB';
EXEC sp_MSforeachdb @command;
-- =======================================================
*/

--* USEDFINAnalytics;
GO
-- DROP TABLE [DFS_TxMonitorTableStats];

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorTableStats'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_TxMonitorTableStats]
 ([SVR]  [NVARCHAR](150) NULL, 
  [SchemaName]  [NVARCHAR](150) NULL, 
  [DBName]    [NVARCHAR](150) NULL, 
  [TableName] [NVARCHAR](150) NULL, 
  [IndexName] [SYSNAME] NULL, 
  [IndexID]   [INT] NOT NULL, 
  [user_seeks]  [BIGINT] NOT NULL, 
  [user_scans]  [BIGINT] NOT NULL, 
  [user_lookups]     [BIGINT] NOT NULL, 
  [user_updates]     [BIGINT] NOT NULL, 
  [last_user_seek]   [DATETIME] NULL, 
  [last_user_scan]   [DATETIME] NULL, 
  [last_user_lookup] [DATETIME] NULL, 
  [last_user_update] [DATETIME] NULL, 
  [DBID] [SMALLINT] NULL, 
  [ExecutionDate]    [DATETIME] NOT NULL, 
  [RunID]     [INT] NOT NULL, 
  [UID]  [UNIQUEIDENTIFIER] NULL
 )
 ON [PRIMARY];
END;
GO
-- drop		TABLE [dbo].[DFS_TxMonitorIDX]

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorIDX'
)
drop TABLE [dbo].[DFS_TxMonitorIDX]
go
 CREATE TABLE [dbo].[DFS_TxMonitorIDX]
 ([SvrName] [NVARCHAR](150) NULL, 
  [DBName]  [NVARCHAR](150) NULL, 
  [database_id]    [INT] NOT NULL, 
  [TableName] [NVARCHAR](150) NULL, 
  [UpdatedRows]    [BIGINT] NOT NULL, 
  [LastUpdateTime] [DATETIME] NULL, 
  CreateDate  DATETIME NULL
  DEFAULT GETDATE(), 
  ExecutionDate    DATETIME NOT NULL, 
  [UID]     UNIQUEIDENTIFIER NOT NULL, 
  RunID     INT NULL, 
  Rownbr    INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];

GO

/******************************************
Using sys.dm_db_index_usage_stats:
There's a handy dynamic management view called sys.dm_db_index_usage_stats that shows you
number of rows in both SELECT and DML statements against all the tables and indexes in your
database, either since the object was created or since the database instance was last restarted:
SELECT *
FROM sys.dm_db_index_usage_stats
******************************************/

--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TxMonitorIDX'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_TxMonitorIDX;
END;
GO

/*
exec sp_UTIL_TxMonitorIDX -22
*/

CREATE PROCEDURE sp_UTIL_TxMonitorIDX(@RunID INT)
AS
    BEGIN
		exec UTIL_RecordCount N'sp_UTIL_TxMonitorIDX';
 SET NOCOUNT ON;
 DECLARE @ExecutionDate DATETIME= GETDATE();
 -- Collect our working data
 INSERT INTO dbo.DFS_TxMonitorIDX ([SvrName],[DBName],[database_id],[TableName],[UpdatedRows],[LastUpdateTime],[CreateDate],[ExecutionDate],[UID],[RunID])
   SELECT @@SERVERNAME as SvrName, 
   DB_NAME() as DBName, 
   database_id, 
   OBJECT_NAME(us.object_id) AS TableName, 
   user_updates AS UpdatedRows, 
   last_user_update AS LastUpdateTime, 
   GETDATE() AS CreateDate, 
   ExecutionDate = GETDATE(), 
   [UID] = NEWID(), 
   RunID = -99
   FROM sys.dm_db_index_usage_stats AS us
 JOIN sys.indexes AS si ON us.object_id = si.object_id
      AND us.index_id = si.index_id
   --where database_id =  @DBID
   WHERE user_seeks + user_scans + user_lookups + user_updates > 0
  AND si.index_id IN(0, 1)
   ORDER BY OBJECT_NAME(us.object_id)
    END;
GO
-- drop procedure sp_UTIL_TxMonitorTableStats

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TxMonitorTableStats'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_TxMonitorTableStats;
END;
	GO

/*
exec dbo.sp_UTIL_TxMonitorTableStats -99
*/

CREATE PROCEDURE dbo.sp_UTIL_TxMonitorTableStats(@RunID INT)
AS
    BEGIN
		exec UTIL_RecordCount N'sp_UTIL_TxMonitorTableStats';
 IF OBJECT_ID('tempdb..#DFS_TxMonitorTableStats') IS NOT NULL
     BEGIN
  DROP TABLE #DFS_TxMonitorTableStats;
 END;
 DECLARE @DBID AS INT= DB_ID();
 DECLARE @ExecutionDate DATETIME= GETDATE();
 SELECT SVR = @@SERVERNAME, 
   SchemaName = OBJECT_SCHEMA_NAME(ius.object_id), 
   DBName = DB_NAME(), 
   TableName = OBJECT_NAME(ius.object_id), 
   si.name AS IndexName, 
   si.index_id AS IndexID, 
   ius.user_seeks, 
   ius.user_scans, 
   ius.user_lookups, 
   ius.user_updates, 
   ius.last_user_seek, 
   ius.last_user_scan, 
   ius.last_user_lookup, 
   ius.last_user_update, 
   DBID = DB_ID(), 
   ExecutionDate = GETDATE(), 
   RunID = @RunID, 
   [UID] = NEWID()
 INTO #DFS_TxMonitorTableStats
 FROM sys.dm_db_index_usage_stats AS ius
 JOIN sys.indexes AS si ON ius.object_id = si.object_id
      AND ius.index_id = si.index_id;
 DECLARE @rowcnt AS INT= 0;
 SET @rowcnt =
 (
     SELECT COUNT(*)
     FROM #DFS_TxMonitorTableStats
 );
 IF(@rowcnt > 0)
     BEGIN
  INSERT INTO dbo.DFS_TxMonitorTableStats
  ([SVR], 
   [SchemaName], 
   [DBName], 
   [TableName], 
   [IndexName], 
   [IndexID], 
   [user_seeks], 
   [user_scans], 
   [user_lookups], 
   [user_updates], 
   [last_user_seek], 
   [last_user_scan], 
   [last_user_lookup], 
   [last_user_update], 
   [DBID], 
   [ExecutionDate], 
   [RunID], 
   [UID]
  )
    SELECT [SVR], 
    [SchemaName], 
    [DBName], 
    [TableName], 
    [IndexName], 
    [IndexID], 
    [user_seeks], 
    [user_scans], 
    [user_lookups], 
    [user_updates], 
    [last_user_seek], 
    [last_user_scan], 
    [last_user_lookup], 
    [last_user_update], 
    [DBID], 
    [ExecutionDate], 
    [RunID], 
    [UID]
    FROM [dbo].#DFS_TxMonitorTableStats;
  IF OBJECT_ID('tempdb..#DFS_TxMonitorTableStats') IS NOT NULL
 BEGIN
   DROP TABLE #DFS_TxMonitorTableStats;
  END;
 END;
    END;

/*
 In the results, you'll have the following columns:
 TableName - The name of the table (the easiest column)
 IndexName - when populated, the name of the index. When it's NULL, it refers to a HEAP - a table without a clustered index IndexID -
  If this is 0, it's a HEAP (IndexName should also be NULL in these cases). When 1, this refers to a clustered index (meaning that the activity columns still all refer to the table data itself). When 2 or greater, this is a standard non-clustered index.
  User activity (the number of times each type of operation has been performed on the index/table):
  User Seeks - searched for a small number of rows - this is the most effecient index operation.
  User Scans - scanned through the whole index looking for rows that meet the WHERE criteria.
  User Lookups - query used the index to find a row number, then pulled data from the table itself to satisfy the query.
  User Updates - number of times the data in this index/table has been updated. Note that not every table update will update every query - if an update modifies a column that's not part of an index, the table
  update
     counter will increment
    , but the index counter will not User activity timestamps - these show the most recent occurance of each of the four types of "User" events 
*/

GO
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************