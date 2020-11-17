
--UTIL_DBMon_EachDB.sql
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_TxMonitorTblUpdates'
)
   AND @runnow = 1
    BEGIN
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec dbo.UTIL_DFS_TxMonitorTblUpdates @DB';
 EXEC sp_MSforeachdb 
 @command;
END;
-- =======================================================

--* USEDFINAnalytics;
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
--drop table [DFS_TxMonitorTableStats]

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'DFS_TxMonitorTableStats'
)
    BEGIN
 CREATE TABLE dbo.DFS_TxMonitorTableStats
 (SvrName   NVARCHAR(150) NULL, 
  DBName    NVARCHAR(150) NULL, 
  SchemaName  NVARCHAR(150) NULL, 
  TableName NVARCHAR(150) NULL, 
  IndexName NVARCHAR(150) NULL, 
  IndexID   INT NULL, 
  user_seeks  BIGINT NULL, 
  user_scans  BIGINT NULL, 
  user_lookups     BIGINT NULL, 
  user_updates     BIGINT NULL, 
  last_user_seek   DATETIME NULL, 
  last_user_scan   DATETIME NULL, 
  last_user_lookup DATETIME NULL, 
  last_user_update DATETIME NULL, 
  DBID INT NULL, 
  CreateDate  DATETIME NULL
  DEFAULT GETDATE(), 
  ExecutionDate    DATETIME NOT NULL, 
  RunID     INT NULL, 
		 [UID] uniqueidentifier default newid(),
  RowNbr    INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
END;
GO

/******************************************
Using sys.dm_db_index_usage_stats:
There's a handy dynamic management view called sys.dm_db_index_usage_stats that shows you
number of rows in both SELECT and DML statements against all the tables and indexes in your
database, either since the object was created or since the database instance was last restarted:
SELECT *
FROM sys.dm_db_index_usage_stats
******************************************/

-- drop procedure DBMON_TxMonitorTableStats
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DBMON_TxMonitorTableStats'
)
   AND @runnow = 1
    BEGIN
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec dbo.DBMON_TxMonitorTableStats @DB';
 EXEC sp_MSforeachdb 
 @command;
END;
go

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DBMON_TxMonitorTableStats'
)
    BEGIN
 DROP PROCEDURE dbo.DBMON_TxMonitorTableStats;
END;
GO

/*
select * from sys.databases;
exec dbo.DBMON_TxMonitorTableStats 9;
*/

CREATE PROCEDURE dbo.DBMON_TxMonitorTableStats(@DBID AS INT)
AS
    BEGIN

/*
		In the results, you'll have the following columns:
			TableName - The name of the table (the easiest column)
			IndexName - when populated, the name of the index. When it's NULL, 
				it refers to a HEAP - a table without a clustered index 
			IndexID - If this is 0, it's a HEAP (IndexName should also be NULL in these cases). 
				When 1, this refers to a clustered index (meaning that the activity columns 
				still all refer to the table data itself). When 2 or greater, this is a standard 
				non-clustered index.

			User activity (the number of times each type of operation has been performed 
			on the index/table):
			User Seeks - searched for a small number of rows - this is the most effecient 
				index operation.
			User Scans - scanned through the whole index looking for rows that meet the 
				WHERE criteria.
			User Lookups - query used the index to find a row number, then pulled data 
				from the table itself to satisfy the query.
			User Updates - number of times the data in this index/table has been updated. 
				Note that not every table update will update every query - if an update 
				modifies a column that's not part of an index, the table update counter 
				will increment , but the index counter will not User activity timestamps 
					- these show the most recent occurance of each of the four types of 
					"User" events  
		*/

 DECLARE @RunID AS BIGINT= NEXT VALUE FOR master_seq;
 DECLARE @ExecutionDate DATETIME= GETDATE();
 INSERT INTO dbo.DFS_TxMonitorTableStats
   SELECT @@SERVERNAME, 
   DB_NAME(@DBID), 
					  sch.name as SchemaName,
   OBJECT_NAME(ius.object_id) AS TableName, 
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
   RunID = @RunID,
					  [UID] = newid()
   FROM sys.dm_db_index_usage_stats ius
 JOIN sys.indexes si ON ius.object_id = si.object_id
   AND ius.index_id = si.index_id
 JOIN sys.objects AS O ON O.object_id = ius.object_id
 JOIN sys.schemas AS sch ON O.schema_id = sch.schema_id
   WHERE database_id = @DBID;
    END;
GO
--* USEDFINAnalytics;
GO
-- drop table DFS_TxMonitorTblUpdates;

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TxMonitorTblUpdates'
)
    BEGIN
 --* USEDFINAnalytics;
 CREATE TABLE dbo.DFS_TxMonitorTblUpdates
 (SVR     NVARCHAR(150) NULL, 
  database_id    INT NOT NULL, 
		 SchemaName  NVARCHAR(150) NULL, 
  DBname  NVARCHAR(150) NULL, 
  TableName NVARCHAR(150) NULL, 
  user_lookups   INT NULL, 
  user_scans     INT NULL, 
  user_seeks     INT NULL, 
  UpdatedRows    BIGINT NOT NULL, 
  LastUpdateTime DATETIME NULL, 
  CreateDate     DATETIME NULL, 
  ExecutionDate  DATETIME NOT NULL, 
  RowID   BIGINT IDENTITY(1, 1) NOT NULL, 
  RunID   INT NULL
 )
 ON [PRIMARY];
 ALTER TABLE dbo.DFS_TxMonitorTblUpdates
 ADD DEFAULT GETDATE() FOR CreateDate;
END;
GO
--**********************************************************************************************
--Making the leap to "transactions per second"
--**********************************************************************************************
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_TxMonitorTblUpdates'
)
    BEGIN
 DROP PROCEDURE UTIL_DFS_TxMonitorTblUpdates;
END;
GO

DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_TxMonitorTblUpdates'
)
   AND @runnow = 1
    BEGIN
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec dbo.UTIL_DFS_TxMonitorTblUpdates @DB';
 EXEC sp_MSforeachdb 
 @command;
END;
go
-- select * from sys.dm_db_index_usage_stats 
CREATE PROCEDURE UTIL_DFS_TxMonitorTblUpdates(@DBID AS INT)
AS
    BEGIN
 SET NOCOUNT ON;
 DECLARE @RunID AS BIGINT= NEXT VALUE FOR master_seq;
 DECLARE @ExecutionDate DATETIME= GETDATE();
 -- Collect our working data
 INSERT INTO dbo.DFS_TxMonitorTblUpdates
   SELECT @@SERVERNAME, 
   database_id, 
					  sch.name as SchemaName,
   DB_NAME(database_id), 
   OBJECT_NAME(us.object_id) AS TableName, 
   us.user_lookups, 
   us.user_scans, 
   user_seeks, 
   user_updates AS UpdatedRows, 
   last_user_update AS LastUpdateTime, 
   GETDATE() AS CreateDate, 
   ExecutionDate = @ExecutionDate, 
   RunID = @RunID,
					  [UID] = newid()
   FROM sys.dm_db_index_usage_stats us
 JOIN sys.indexes si ON us.object_id = si.object_id
   AND us.index_id = si.index_id
   JOIN sys.objects AS O ON O.object_id = si.object_id
 JOIN sys.schemas AS sch ON O.schema_id = sch.schema_id
   WHERE user_seeks + user_scans + user_lookups + user_updates > 0
  AND si.index_id IN(0, 1)
   ORDER BY OBJECT_NAME(us.object_id);
    END;
 -- W. Dale Miller
 -- DMA, Limited
 -- Offered under GNU License
 -- July 26, 2016
