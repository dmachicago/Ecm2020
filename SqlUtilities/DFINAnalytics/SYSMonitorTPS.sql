
/*
-- =======================================================
DECLARE @command varchar(1000);
SELECT
   @command = '--* USE?; declare @DB as int = DB_ID() ; exec dbo.sp_DBMON_TxMonitorIDX @DB'
;

EXEC sp_MSforeachdb
   @command;
-- =======================================================
*/

--* USEDFINAnalytics;
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- drop table [DFS_TxMonitorTableStats]
IF not EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TxMonitorTableStats'
)
    CREATE TABLE [dbo].[DFS_TxMonitorTableStats]
    (RowNbr INT IDENTITY(1, 1), 
     [TableName] [NVARCHAR](150) NULL, 
     [IndexName] [NVARCHAR](250) NULL, 
     [IndexID]   [INT] NULL, 
     [user_seeks]  [BIGINT] NULL, 
     [user_scans]  [BIGINT] NULL, 
     [user_lookups]     [BIGINT] NULL, 
     [user_updates]     [BIGINT] NULL, 
     [last_user_seek]   [DATETIME] NULL, 
     [last_user_scan]   [DATETIME] NULL, 
     [last_user_lookup] [DATETIME] NULL, 
     [last_user_update] [DATETIME] NULL, 
     [DBID] [INT] NULL, 
     CreateDate  DATETIME NULL
     DEFAULT GETDATE(), 
     ExecutionDate DATETIME NOT NULL,
	 [UID] uniqueidentifier default newid()
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
go
-- drop procedure DFS_TxMonitorTableStats
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TxMonitorTableStats'
)
    DROP PROCEDURE sp_UTIL_TxMonitorTableStats;
GO
-- exec dbo.sp_UTIL_TxMonitorTableStats
CREATE PROCEDURE dbo.sp_UTIL_TxMonitorTableStats
AS
    BEGIN
		declare @DBID AS INT = db_id();
 DECLARE @ExecutionDate DATETIME= GETDATE();
 INSERT INTO [dbo].[DFS_TxMonitorTableStats]
   SELECT OBJECT_NAME(ius.object_id) AS TableName, 
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
   DBID = @DBID, 
   GETDATE(), 
   ExecutionDate = @ExecutionDate,
					  [UID] = newid()
   FROM sys.dm_db_index_usage_stats ius
 JOIN sys.indexes si ON ius.object_id = si.object_id
   AND ius.index_id = si.index_id
   WHERE database_id = @DBID;
    END;
 -- In the results, you'll have the following columns:
 -- TableName - The name of the table (the easiest column)
 -- IndexName - when populated, the name of the index. When it's NULL, it refers to a HEAP - a table without a clustered index IndexID -
 --  If this is 0, it's a HEAP (IndexName should also be NULL in these cases). When 1, this refers to a clustered index (meaning that the activity columns still all refer to the table data itself). When 2 or greater, this is a standard non-clustered index.
 -- User activity (the number of times each type of operation has been performed on the index/table):
 --  User Seeks - searched for a small number of rows - this is the most effecient index operation.
 --  User Scans - scanned through the whole index looking for rows that meet the WHERE criteria.
 --  User Lookups - query used the index to find a row number, then pulled data from the table itself to satisfy the query.
 --  User Updates - number of times the data in this index/table has been updated. Note that not every table update will update every query - if an update modifies a column that's not part of an index, the table
 --  update
 --     counter will increment
 --    , but the index counter will not User activity timestamps - these show the most recent occurance of each of the four types of "User" events */
 -- select name, database_id FROM SYS.DATABASES where name not in ('master', 'tempdb', 'model', 'msdb', 'ReportServer', 'ReportServerTempDB');
 -- exec sp_DBMON_TxMonitorIDX (@DBID as int)
 --
go
 --* USEDFINAnalytics;
GO
-- drop table DFS_TxMonitorIDX
IF not EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TxMonitorIDX'
)
CREATE TABLE [dbo].[DFS_TxMonitorIDX]
(RowNbr    INT IDENTITY(1, 1), 
 [database_id]    [INT] NOT NULL, 
 [TableName] [NVARCHAR](150) NULL, 
 [UpdatedRows]    [BIGINT] NOT NULL, 
 [LastUpdateTime] [DATETIME] NULL, 
 CreateDate  DATETIME NULL
 DEFAULT GETDATE(), 
 ExecutionDate    DATETIME NOT NULL,
 [UID] uniqueidentifier default newid()
)
ON [PRIMARY];
GO
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************
--* USEmaster 
go
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DBMON_TxMonitorIDX'
)
    DROP PROCEDURE sp_DBMON_TxMonitorIDX;
GO
-- exec master.dbo.sp_DBMON_TxMonitorIDX
create PROCEDURE sp_DBMON_TxMonitorIDX
AS
    BEGIN
		declare @DBID AS INT = db_id();
 SET NOCOUNT ON;
 DECLARE @ExecutionDate DATETIME= GETDATE();
 -- Collect our working data
 INSERT INTO dbo.DFS_TxMonitorIDX
   SELECT database_id, 
   OBJECT_NAME(us.object_id) AS TableName, 
   user_updates AS UpdatedRows, 
   last_user_update AS LastUpdateTime, 
   GETDATE() AS CreateDate, 
   ExecutionDate = @ExecutionDate,
					  [UID] = newid()
   FROM sys.dm_db_index_usage_stats us
 JOIN sys.indexes si ON us.object_id = si.object_id
   AND us.index_id = si.index_id
   --where database_id =  @DBID
   WHERE user_seeks + user_scans + user_lookups + user_updates > 0
  AND si.index_id IN(0, 1)
   ORDER BY OBJECT_NAME(us.object_id);
    END;