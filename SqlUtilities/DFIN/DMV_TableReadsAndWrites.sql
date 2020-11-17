/*
--DMV_TableReadsAndWrites.sql
Developed W. Dale Miller 
Copyright @DMA, Ltd, July 26, 2012 all rights reserved.
Licensed under the MIT Open Code License
Free to use as long as the copyright is retained in the code.
*/

--exec sp_UTIL_TrackTblReadsWrites
USE [DFINAnalytics];
GO

-- drop table [DFS_TableReadWrites]
IF NOT EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_TableReadWrites'
)
    BEGIN
        CREATE TABLE dbo.[DFS_TableReadWrites]
        ([ServerName]    [NVARCHAR](128) NULL, 
         [DBName]        [NVARCHAR](128) NULL, 
         [TableName]     [NVARCHAR](128) NULL, 
         [Reads]         [BIGINT] NULL, 
         [Writes]        [BIGINT] NULL, 
         [Reads&Writes]  [BIGINT] NULL, 
         [SampleDays]    [NUMERIC](18, 7) NULL, 
         [SampleSeconds] [INT] NULL, 
         [RunDate]       [DATETIME] NOT NULL, 
         RowID           BIGINT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
		create index idxDFS_TableReadWrites on DFS_TableReadWrites ([DBName], [TableName]);
END;
GO
USE master;
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
-- Table Reads and Writes 
-- Heap tables out of scope for this query. Heaps do not have indexes. 
-- Only lists tables referenced since the last server restart 
-- exec sp_UTIL_TrackTblReadsWrites

CREATE PROCEDURE sp_UTIL_TrackTblReadsWrites
AS

	if DB_NAME() in ('master', 'tempdb', 'msdb', 'model', 'DBA')
	begin
		print 'Skipping DB : ' + DB_NAME() ;
		return;
		end
    BEGIN
        INSERT INTO DFINAnalytics.dbo.[DFS_TableReadWrites]
        ([ServerName], 
         [DBName], 
         [TableName], 
         [Reads], 
         [Writes], 
         [Reads&Writes], 
         [SampleDays], 
         [SampleSeconds], 
         [RunDate]
        )
               SELECT @@ServerName AS ServerName, 
                      DB_NAME() AS DBName, 
                      OBJECT_NAME(ddius.object_id) AS TableName, 
                      SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups) AS Reads, 
                      SUM(ddius.user_updates) AS Writes, 
                      SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups + ddius.user_updates) AS [Reads&Writes], 
               (
                   SELECT DATEDIFF(s, create_date, GETDATE()) / 86400.0
                   FROM master.sys.databases
                   WHERE name = 'tempdb'
               ) AS SampleDays, 
               (
                   SELECT DATEDIFF(s, create_date, GETDATE()) AS SecoundsRunnig
                   FROM master.sys.databases
                   WHERE name = 'tempdb'
               ) AS SampleSeconds, 
                      GETDATE() AS RunDate
               FROM sys.dm_db_index_usage_stats ddius
                    INNER JOIN sys.indexes i ON ddius.object_id = i.object_id
                                                AND i.index_id = ddius.index_id
               WHERE OBJECTPROPERTY(ddius.object_id, 'IsUserTable') = 1
                     AND ddius.database_id = DB_ID()
               GROUP BY OBJECT_NAME(ddius.object_id)
               ORDER BY [Reads&Writes] DESC;
    END;
GO
USE [DFINAnalytics]
go
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
            [RowID]
     FROM DFINAnalytics.[dbo].[DFS_TableReadWrites];

--order BY TableName, 
--       RunDate, 
--       DBName, 
--       ServerName;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

