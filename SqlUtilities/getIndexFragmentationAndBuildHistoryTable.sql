USE [AP_ProductionAF_Data];
DECLARE @MaxPct DECIMAL(6, 2)= 25.5;
SELECT avg_fragmentation_in_percent, 
       D.name AS DBNAME, 
       S.name AS [Schema], 
       T.name AS [Table], 
       I.name AS [IndexName]
INTO #temp_index_stats
FROM   sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS IdxStats
       JOIN sys.tables T ON T.object_id = IdxStats.object_id
       JOIN sys.databases D ON D.database_id = IdxStats.database_id
       JOIN sys.indexes I ON T.object_id = I.object_id
                             AND I.name IS NOT NULL
       JOIN sys.schemas S ON T.schema_id = S.schema_id
WHERE  avg_fragmentation_in_percent > @MaxPct;
SELECT *
FROM   #temp_index_stats;
SELECT 'USE ' + [DBNAME] + ';' + CHAR(10) + 'GO' + CHAR(10) + 'ALTER INDEX ' + IndexName + ' ON ' + [Table] + ' REORGANIZE;' + CHAR(10) + 'GO' AS CMD
FROM   #temp_index_stats;
SELECT 'USE ' + [DBNAME] + ';' + CHAR(10) + 'GO' + CHAR(10) + 'ALTER INDEX ' + IndexName + ' ON ' + [Table] + ' REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON);' + CHAR(10) + 'GO' AS CMD
FROM   #temp_index_stats;
USE master;
SELECT COUNT(*)
FROM   SSC_Production3_Log.dbo.AuditBatch;

/****** Script for SelectTopNRows command from SSMS  ******/

SELECT [DBName], 
       [Schema], 
       [Table], 
       [Index], 
       [OnlineReorg], 
       [Success], 
       [Rundate], 
       [RunID], 
       [Stmt], 
       [RowNbr]
FROM   [master].[dbo].[DFS_IndexFragReorgHistory]
ORDER BY [RowNbr] DESC;
--SSC_Production3_Log / AuditBatch