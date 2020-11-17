--* USEDFINAnalytics;

/*UTIL_DBMon_EachDB.sql*/

DECLARE @runnow INT= 0;

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'UTIL_TxMonitorTableIndexStats'
   )
   AND 
   @runnow = 1
    BEGIN

 /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 PRINT @RunID;
 DECLARE @command VARCHAR(1000);
 SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec sp_UTIL_TxMonitorTableIndexStats ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
 EXEC sp_MSforeachdb @command;
END;

/* =======================================================
 DROP TABLE [DFS_TxMonitorTableIndexStats];*/

IF EXISTS ( SELECT 1
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_NAME = 'DFS_TxMonitorTableIndexStats'
   ) 
    BEGIN
 DROP TABLE [dbo].[DFS_TxMonitorTableIndexStats]
END;
GO

CREATE TABLE [dbo].[DFS_TxMonitorTableIndexStats] ( 
 [SVR]  [NVARCHAR](150) NULL , 
 [SchemaName]  [NVARCHAR](150) NULL , 
 [DBName]    [NVARCHAR](150) NULL , 
 [TableName] [NVARCHAR](150) NULL , 
 [IndexName] [SYSNAME] NULL , 
 [IndexID]   [INT] NOT NULL , 
 [user_seeks]  [BIGINT] NOT NULL , 
 [user_scans]  [BIGINT] NOT NULL , 
 [user_lookups]     [BIGINT] NOT NULL , 
 [user_updates]     [BIGINT] NOT NULL , 
 [last_user_seek]   [DATETIME] NULL , 
 [last_user_scan]   [DATETIME] NULL , 
 [last_user_lookup] [DATETIME] NULL , 
 [last_user_update] [DATETIME] NULL , 
 [DBID] [SMALLINT] NULL , 
 [ExecutionDate]    [DATETIME] NOT NULL , 
 [RunID]     [INT] NOT NULL , 
 [UID]  UNIQUEIDENTIFIER DEFAULT NEWID() , 
 RowNbr INT IDENTITY(1 , 1) NOT NULL
   ) 
ON [PRIMARY];

CREATE INDEX [IDX_TxMonitorTableStats_UID] ON [dbo].[DFS_TxMonitorTableIndexStats] ( [UID] , [ExecutionDate]
   ) 
  ON [primary];

CREATE NONCLUSTERED INDEX [IDX_TxMonitorTableStats_RID] ON [dbo].[DFS_TxMonitorTableIndexStats] ( [RunID] ASC , [ExecutionDate] ASC
  ) 
  WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON
     ) ON [PRIMARY];
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

IF EXISTS ( SELECT 1
     FROM sys.procedures
     WHERE name = 'sp_UTIL_TxMonitorTableIndexStats'
   ) 
    BEGIN
 DROP PROCEDURE sp_UTIL_TxMonitorTableIndexStats;
END;
GO

/*
----* USE[AW2016];
declare @RunID BIGINT = NEXT VALUE FOR master_seq;
exec @RunID = dbo.UTIL_GetSeq 
print @RunID
exec sp_UTIL_TxMonitorTableIndexStats @RunID;
select * from [dbo].[DFS_TxMonitorTableIndexStats]
*/

CREATE PROCEDURE dbo.sp_UTIL_TxMonitorTableIndexStats ( 
   @RunID BIGINT
  ) 
AS
    BEGIN
		declare @StartCount int = 0 
		declare @EndCount int = 0 
		declare @ProcessedCount int = 0 
 DECLARE @DBID AS INT= DB_ID();
 DECLARE @ExecutionDate DATETIME= GETDATE();
 DECLARE @sql NVARCHAR(4000);

		set @StartCount = (select count(*) from [dbo].[DFS_TxMonitorTableIndexStats]);

		INSERT INTO [dbo].[DFS_TxMonitorTableIndexStats]
   SELECT @@SERVERNAME AS SvrName, 
   sch.name, 
   DB_NAME() AS DBName, 
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
   DBID = DB_ID(), 
   ExecutionDate = GETDATE(), 
   RunID = @RunID , 
   [UID] = NEWID()
   FROM sys.dm_db_index_usage_stats AS ius
    JOIN sys.indexes AS si
    ON ius.object_id = si.object_id
  AND ius.index_id = si.index_id
    JOIN sys.objects AS O
    ON O.object_id = ius.object_id
  JOIN sys.schemas AS sch
    ON O.schema_id = sch.schema_id;
 
		set @EndCount = (select count(*) from [dbo].[DFS_TxMonitorTableIndexStats]);
		set @ProcessedCount = @EndCount - @StartCount
		print 'Total Records Added: ' + cast(@ProcessedCount as nvarchar(50));

-- SET @sql = 'INSERT INTO [dbo].[DFS_TxMonitorTableIndexStats]
--   SELECT @@SERVERNAME AS SvrName, 
--   sch.name, 
--   DB_NAME() AS DBName, 
--   OBJECT_NAME(ius.object_id) AS TableName, 
--   si.name AS IndexName, 
--   si.index_id AS IndexID, 
--   ius.user_seeks, 
--   ius.user_scans, 
--   ius.user_lookups, 
--   ius.user_updates, 
--   ius.last_user_seek, 
--   ius.last_user_scan, 
--   ius.last_user_lookup, 
--   ius.last_user_update, 
--   DBID = DB_ID(), 
--   ExecutionDate = GETDATE(), 
--   RunID = ' + CAST(@RunID AS NVARCHAR(50)) + ', 
--   [UID] = NEWID()
--   FROM sys.dm_db_index_usage_stats AS ius
--    JOIN sys.indexes AS si
--    ON ius.object_id = si.object_id
--  AND ius.index_id = si.index_id
--    JOIN sys.objects AS O
--    ON O.object_id = ius.object_id
--  JOIN sys.schemas AS sch
--    ON O.schema_id = sch.schema_id;
--';
-- EXECUTE sp_executesql @sql;
    END;
GO

--* USEDFINAnalytics;

/* W. Dale Miller
  DMA, Limited
  Offered under GNU License
  July 26, 2016*/
