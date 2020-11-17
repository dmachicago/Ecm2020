
-- drop table DFS_TableStats
-- exec DFS_MonitorTableStats

--* USEDFINAnalytics;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_TableStats'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_TableStats]
 ([ServerName]    [NVARCHAR](150) NULL, 
  [DBName] [NVARCHAR](150) NULL, 
  [TableName]     [NVARCHAR](150) NULL, 
  [Reads]  [INT] NULL, 
  [Writes] [INT] NULL, 
  [ReadsWrites]   [INT] NULL, 
  [SampleDays]    [DECIMAL](18, 8) NULL, 
  [SampleSeconds] [INT] NULL, 
  [RunDate]  [DATETIME] NULL,
		 [UID] uniqueidentifier default newid(),
		 [RowID] bigint identity (1,1) not null
 )
 ON [PRIMARY];
 ALTER TABLE [dbo].[DFS_TableStats]
 ADD CONSTRAINT [DF_DFS_TableStats_RunDate] DEFAULT(GETDATE()) FOR [RunDate];
END;
GO

/*
 Statistics from Dynamic Management Views are cleared out each time the SQL 
 Server restarts (wait and latch statistics can also be cleared out manually). 
 The longer the server has been up, the more reliable the statistics. 
 Place more confidence on statistics that are over 30 days (assumes the 
 tables have been through a month end cycle) and a lot less confidence if they 
 are less than 7 days.
 Table Reads and Writes 
 Heap tables out of scope for this query. Heaps do not have indexes. 
 Only lists tables referenced since the last server restart 
 This query uses a cursor to identify all the user databases on the server 
 Consolidates individual database results into a report, using a temp table. 
 UTIL_GetAllDBTblStats.sql
 */
 -- exec DFS_MonitorTableStats
IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'DFS_MonitorTableStats')
DROP PROCEDURE DFS_MonitorTableStats;
go
CREATE PROCEDURE DFS_MonitorTableStats
AS
    BEGIN
 DECLARE DBNameCursor CURSOR
 FOR SELECT Name
     FROM sys.databases
     WHERE Name NOT IN('master', 'model', 'msdb', 'tempdb', 'distribution')
     ORDER BY Name;
 DECLARE @DBName NVARCHAR(150) = db_name();
 DECLARE @cmd VARCHAR(4000);
 IF OBJECT_ID(N'tempdb..#TempResults') IS NOT NULL
     BEGIN
  DROP TABLE #TempResults;
 END;
 CREATE TABLE #TempResults
 (ServerName    NVARCHAR(150), 
  DBName NVARCHAR(150), 
  TableName     NVARCHAR(150), 
  Reads  INT, 
  Writes INT, 
  ReadsWrites   INT, 
  SampleDays    DECIMAL(18, 8), 
  SampleSeconds INT
 );
 OPEN DBNameCursor;
 FETCH NEXT FROM DBNameCursor INTO @DBName;
 WHILE @@fetch_status = 0
     BEGIN 
  ---------------------------------------------------- 
  -- Print @DBName 
  SELECT @cmd = '--* USE' + @DBName + '; ';
  SELECT @cmd = @cmd + ' Insert Into #TempResults 
	SELECT @@ServerName AS ServerName, 
	DB_NAME() AS DBName, 
	object_name(ddius.object_id) AS TableName , 
	SUM(ddius.user_seeks 
	+ ddius.user_scans 
	+ ddius.user_lookups) AS Reads, 
	SUM(ddius.user_updates) as Writes, 
	SUM(ddius.user_seeks 
	+ ddius.user_scans 
	+ ddius.user_lookups 
	+ ddius.user_updates) as ReadsWrites, 
	(SELECT datediff(s,create_date, GETDATE()) / 86400.0 
	FROM sys.databases WHERE name = ''tempdb'') AS SampleDays, 
	(SELECT datediff(s,create_date, GETDATE()) 
	FROM sys.databases WHERE name = ''tempdb'') as SampleSeconds 
	FROM sys.dm_db_index_usage_stats ddius 
	INNER JOIN sys.indexes i
	ON ddius.object_id = i.object_id 
	AND i.index_id = ddius.index_id 
	WHERE objectproperty(ddius.object_id,''IsUserTable'') = 1 --True 
	AND ddius.database_id = db_id() 
	GROUP BY object_name(ddius.object_id) 
	ORDER BY ReadsWrites DESC;'; 
  --PRINT @cmd 
  EXECUTE (@cmd); 
  ----------------------------------------------------- 
  FETCH NEXT FROM DBNameCursor INTO @DBName;
     END;
 CLOSE DBNameCursor;
 DEALLOCATE DBNameCursor;
 INSERT INTO dbo.DFS_TableStats
 ([ServerName], 
  [DBName], 
  [TableName], 
  [Reads], 
  [Writes], 
  [ReadsWrites], 
  [SampleDays], 
  [SampleSeconds]
 )
   SELECT *
   FROM #TempResults
   ORDER BY DBName, 
   TableName; 		
		DROP TABLE #TempResults; 
    END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

