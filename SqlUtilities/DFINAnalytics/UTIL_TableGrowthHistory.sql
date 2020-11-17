-- W. Dale Miller @ 2016
--* USE DFINAnalytics; -- replace your dbname
GO

-- drop table DFS_TableGrowthHistory
-- select top 1000 * from DFS_TableGrowthHistory order by DBname, TableName, Rownbr desc;
-- select count(*) from DFS_TableGrowthHistory ;
IF EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'DFS_TableGrowthHistory'
)
drop table DFS_TableGrowthHistory;

    CREATE TABLE [dbo].[DFS_TableGrowthHistory]
    ([SvrName]    [SYSNAME] NOT NULL, 
     [DBName]     [SYSNAME] NOT NULL, 
     [SchemaName] [SYSNAME] NOT NULL, 
     [TableName]  [SYSNAME] NOT NULL, 
     [RowCounts]  [BIGINT] NOT NULL, 
     [Used_MB]    [NUMERIC](36, 2) NULL, 
     [Unused_MB]  [NUMERIC](36, 2) NULL, 
     [Total_MB]   [NUMERIC](36, 2) NULL, 
     RunID NVARCHAR(60) NULL, 
     CreateDate   DATETIME DEFAULT GETDATE(),
	 [UID] uniqueidentifier default newid(), 
     RowNbr  INT IDENTITY(1, 1) NOT NULL
    )
    ON [PRIMARY];


CREATE INDEX pidx_DFS_TableGrowthHistory
ON DFS_TableGrowthHistory
(DBname, TableName, Rownbr
);

-- select * from viewTableGrowthStats
IF EXISTS
(
    SELECT 1
    FROM   information_schema.tables
    WHERE  table_name = 'viewTableGrowthStats'
)
    DROP VIEW viewTableGrowthStats;
GO
CREATE VIEW viewTableGrowthStats
AS
     SELECT DBName, 
     SchemaName, 
     TableName, 
     MIN(RowCounts) StartRowCnt, 
     MAX(RowCounts) EndRowCnt, 
     MAX(RowCounts) - MIN(RowCounts) AS RowGrowth, 
     MIN(Used_MB) StartMB, 
     MAX(Used_MB) EndMB, 
     MAX(Used_MB) - MIN(Used_MB) AS MBGrowth, 
     DATEDIFF(DAY, MIN(CreateDate), MAX(CreateDate)) AS OverNbrDays
     FROM   DFS_TableGrowthHistory
     GROUP BY DBName, 
  SchemaName, 
  TableName;
GO

--* USE master;
go

IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_UTIL_TableGrowthHistory'
)
    DROP PROCEDURE sp_UTIL_TableGrowthHistory;
GO
/*
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
DECLARE @command NVARCHAR(1000);
SELECT @command = '--* USE?; exec sp_UTIL_TableGrowthHistory ' + CAST(@RunID AS NVARCHAR(10)) ;
print @command;
EXEC sp_MSforeachdb @command;
*/
create PROCEDURE dbo.sp_UTIL_TableGrowthHistory (@RunID int )
AS
    BEGIN
		DECLARE @DBNAME NVARCHAR(100)= DB_NAME();
 DECLARE @x INT;
 EXEC @x = sp_ckProcessDB;
 IF(@x < 1)
     RETURN;
 DECLARE @msg NVARCHAR(1000);
 SET @msg = 'Processing DB: ' + @DBNAME;
 EXEC [dbo].[printimmediate] 
 @msg;
 DECLARE @stmt NVARCHAR(4000);
 INSERT INTO [dbo].[DFS_TableGrowthHistory]
 ([SvrName], 
  [DBName], 
  [SchemaName], 
  [TableName], 
  [RowCounts], 
  [Used_MB], 
  [Unused_MB], 
  [Total_MB], 
  [RunID], 
  [CreateDate]
 )
 SELECT @@ServerName, 
   [DBNAME] = DB_NAME(), 
   s.Name AS SchemaName, 
   t.Name AS TableName, 
   p.rows AS RowCounts, 
   CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
   CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
   CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB, 
   RunId = cast(@RunId as nvarchar(10)), 
   CreateDate = GETDATE()
 FROM   sys.tables t
 INNER JOIN sys.indexes i
     ON t.OBJECT_ID = i.object_id
 INNER JOIN sys.partitions p
     ON i.object_id = p.OBJECT_ID
   AND i.index_id = p.index_id
 INNER JOIN sys.allocation_units a
     ON p.partition_id = a.container_id
 INNER JOIN sys.schemas s
     ON t.schema_id = s.schema_id
 GROUP BY t.Name, 
   s.Name, 
   p.Rows;
 --ORDER BY s.Name, t.Name ';
    END;
GO

-- Unmodified source:
--SELECT
--s.Name AS SchemaName,
--t.Name AS TableName,
--p.rows AS RowCounts,
--CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB,
--CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB,
--CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
--into DFS_TableGrowthHistory
--FROM sys.tables t
--INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
--INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
--INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
--INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
--GROUP BY t.Name, s.Name, p.Rows
--ORDER BY s.Name, t.Name
--GOPRINT '--- "D:\dev\SQL\DFINAnalytics\UTIL_TableGrowthHistory.sql"' 
