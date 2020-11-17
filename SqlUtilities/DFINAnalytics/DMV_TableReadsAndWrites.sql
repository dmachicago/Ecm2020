
/*
--DMV_TableReadsAndWrites.sql
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to --* USEas long as the copyright is retained in the code.
*/
/* exec sp_UTIL_TrackTblReadsWrites */
--* USEDFINAnalytics;
GO

/* drop table [DFS_TableReadWrites]*/

IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TableReadWrites'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_TableReadWrites]
 ([ServerName]    [NVARCHAR](150) NULL, 
  [DBName] [NVARCHAR](150) NULL, 
  [TableName]     [NVARCHAR](150) NULL, 
  [Reads]  [BIGINT] NULL, 
  [Writes] [BIGINT] NULL, 
  [Reads&Writes]  [BIGINT] NULL, 
  [SampleDays]    [NUMERIC](18, 7) NULL, 
  [SampleSeconds] [INT] NULL, 
  [RunDate]  [DATETIME] NOT NULL, 
  [SSVER]  [NVARCHAR](250) NULL, 
  [RowID]  [BIGINT] IDENTITY(1, 1) NOT NULL, 
  [UID]    [UNIQUEIDENTIFIER] NULL, 
  [RunID]  [INT] NULL
 )
 ON [PRIMARY];
 CREATE INDEX idxDFS_TableReadWrites
 ON DFS_TableReadWrites
 ([DBName], [TableName]
 );
END;
GO

if not exists (Select 1 from information_schema.columns where table_name = 'DFS_TableReadWrites' and COLUMN_NAME = 'UID')
begin 
	alter table DFS_TableReadWrites add [UID] uniqueidentifier null default newid();
end 

if not exists (Select 1 from information_schema.columns where table_name = 'DFS_TableReadWrites' and COLUMN_NAME = 'RunID')
begin 
	alter table DFS_TableReadWrites add [RunID] int null ;
end 


--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_TrackTblReadsWrites'
)
    BEGIN
 DROP PROCEDURE sp_UTIL_TrackTblReadsWrites;
END;
GO

/*
-- Table Reads and Writes 
-- Heap tables out of scope for this query. Heaps do not have indexes. 
-- Only lists tables referenced since the last server restart 
-- exec sp_UTIL_TrackTblReadsWrites

--JOB_UTIL_TrackTblReadsWrites
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT @RunID;
DECLARE @command VARCHAR(1000);
SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; print db_name(); exec master.dbo.sp_UTIL_TrackTblReadsWrites ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
EXEC master.sys.sp_MSforeachdb @command;
*/
/* select * from DFS_TableReadWrites*/

--* USEmaster;
GO
CREATE PROCEDURE sp_UTIL_TrackTblReadsWrites(@RunID INT)
AS
     IF DB_NAME() IN('master', 'tempdb', 'msdb', 'model', 'DBA')
  BEGIN
 PRINT 'Skipping DB : ' + DB_NAME();
 RETURN;
     END;
    BEGIN
 EXEC dbo.UTIL_RecordCount 
 'sp_UTIL_TrackTblReadsWrites';
 PRINT 'Processing DB : ' + DB_NAME();
 DECLARE @i AS INT;
 SET @i =
 (
     SELECT COUNT(*)
     FROM dbo.[DFS_TableReadWrites]
 );
 PRINT 'Starting rows: ' + CAST(@i AS NVARCHAR(15));
 INSERT INTO dbo.[DFS_TableReadWrites]
 ( [ServerName], 
   [DBName], 
   [TableName], 
   [Reads], 
   [Writes], 
   [Reads&Writes], 
   [SampleDays], 
   [SampleSeconds], 
   [RunDate], 
   SSVER, 
   [UID], 
   RunID
 ) 
   SELECT @@ServerName AS ServerName, 
   DB_NAME() AS DBName, 
   OBJECT_NAME(ddius.object_id) AS TableName, 
   SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups) AS Reads, 
   SUM(ddius.user_updates) AS Writes, 
   SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups + ddius.user_updates) AS [Reads&Writes], 
   (
     SELECT DATEDIFF(s, create_date, GETDATE()) / 86400.0
     FROM sys.databases
     WHERE name = 'tempdb'
   ) AS SampleDays, 
   (
     SELECT DATEDIFF(s, create_date, GETDATE()) AS SecoundsRunnig
     FROM sys.databases
     WHERE name = 'tempdb'
   ) AS SampleSeconds, 
   GETDATE() AS RunDate, 
   @@version AS SSVER, 
   NEWID() AS [UID], 
   @RunID AS RunID
   FROM sys.dm_db_index_usage_stats ddius
    INNER JOIN sys.indexes i
    ON ddius.object_id = i.object_id
  AND i.index_id = ddius.index_id
   WHERE OBJECTPROPERTY(ddius.object_id, 'IsUserTable') = 1
  AND ddius.database_id = DB_ID()
   GROUP BY OBJECT_NAME(ddius.object_id)
   ORDER BY [Reads&Writes] DESC;
 SET @i =
 (
     SELECT COUNT(*)
     FROM dbo.[DFS_TableReadWrites]
 );
 PRINT 'Ending rows: ' + CAST(@i AS NVARCHAR(15));
    END;
GO
--* USEDFINAnalytics;
GO
IF EXISTS
(
    SELECT table_name
    FROM INFORMATION_SCHEMA.tables
    WHERE TABLE_NAME = 'vTrackTblReadsWrites'
)
    BEGIN
 DROP VIEW dbo.vTrackTblReadsWrites;
END;
GO
CREATE VIEW dbo.vTrackTblReadsWrites
AS
     SELECT [ServerName], 
     [DBName], 
     [TableName], 
     [Reads], 
     [Writes], 
     [Reads&Writes], 
     [SampleDays], 
     [SampleSeconds], 
     [RunDate], 
     [UID], 
     [RowID]
     FROM [dbo].[DFS_TableReadWrites];

/*order BY TableName, 
  RunDate, 
  DBName, 
  ServerName;*/

GO

/* W. Dale Miller
 DMA, Limited
 Offered under GNU License
 July 26, 2016*/