/*
-- W. Dale Miller
-- @ July 26, 2016
--DMV_SuggestMissingIndexes.sql
--The indexing related DMVs store statistics that SQL Server uses recommend 
--indexes that could offer performance benefits, based on previously executed queries.
--Do not add these indexes blindly. I would review and question each index suggested. 
--Included column my come with a high cost of maintaining duplicate data.
-- Missing Indexes DMV Suggestions 
*/

/*
DECLARE @Command NVARCHAR(200);
set @Command = '--* USE?; exec sp_DFS_SuggestMissingIndexes ;';
exec sp_msForEachDb @Command;
*/
-- drop table DFS_MissingIndexes
--* USEDFINAnalytics;
GO
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_MissingIndexes'
)
    BEGIN
 CREATE TABLE [dbo].[DFS_MissingIndexes]
 ([ServerName] [NVARCHAR](150) NULL, 
  [DBName]   [NVARCHAR](150) NULL, 
  [Affected_table]  [SYSNAME] NOT NULL, 
  [K]   [INT] NULL, 
  [Keys]     [NVARCHAR](4000) NULL, 
  [INCLUDE]  [NVARCHAR](4000) NULL, 
  [sql_statement]   [NVARCHAR](4000) NULL, 
  [user_seeks] [BIGINT] NOT NULL, 
  [user_scans] [BIGINT] NOT NULL, 
  [est_impact] [BIGINT] NULL, 
  [avg_user_impact] [FLOAT] NULL, 
  [last_user_seek]  [DATETIME] NULL, 
  [SecondsUptime]   [INT] NULL, 
  CreateDate DATETIME DEFAULT GETDATE(),
		 [UID] uniqueidentifier default newid(), 
  RowNbr     INT IDENTITY(1, 1) NOT NULL
 )
 ON [PRIMARY];
 CREATE INDEX idxDFS_SuggestMissingIndexes ON DFS_MissingIndexes(DBName, Affected_table);
END;
GO

--* USEmaster;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_SuggestMissingIndexes'
)
    DROP PROCEDURE sp_DFS_SuggestMissingIndexes;
GO
-- exec sp_DFS_SuggestMissingIndexes;
CREATE PROCEDURE sp_DFS_SuggestMissingIndexes
AS
    BEGIN
 PRINT 'INSIDE: ' + DB_NAME();
 INSERT INTO [dbo].[DFS_MissingIndexes]
 ([ServerName], 
  [DBName], 
  [Affected_table], 
  [K], 
  [Keys], 
  [INCLUDE], 
  [sql_statement], 
  [user_seeks], 
  [user_scans], 
  [est_impact], 
  [avg_user_impact], 
  [last_user_seek], 
  [SecondsUptime], 
  [CreateDate]
 )
   SELECT @@ServerName AS ServerName, 
   DB_NAME() AS DBName, 
   t.name AS 'Affected_table', 
   LEN(ISNULL(ddmid.equality_columns, N'') + CASE
  WHEN ddmid.equality_columns IS NOT NULL
     AND ddmid.inequality_columns IS NOT NULL
  THEN ','
  ELSE ''
   END) - LEN(REPLACE(ISNULL(ddmid.equality_columns, N'') + CASE
     WHEN ddmid.equality_columns IS NOT NULL
   AND ddmid.inequality_columns IS NOT NULL
     THEN ','
     ELSE ''
      END, ',', '')) + 1 AS K, 
   COALESCE(ddmid.equality_columns, '') + CASE
    WHEN ddmid.equality_columns IS NOT NULL
    AND ddmid.inequality_columns IS NOT NULL
    THEN ','
    ELSE ''
  END + COALESCE(ddmid.inequality_columns, '') AS Keys, 
   COALESCE(ddmid.included_columns, '') AS INCLUDE, 
   'Create NonClustered Index IX_' + t.name + '_missing_' + CAST(ddmid.index_handle AS VARCHAR(20)) + ' On ' + ddmid.[statement] COLLATE database_default + ' (' + ISNULL(ddmid.equality_columns, '') + CASE
         WHEN ddmid.equality_columns IS NOT NULL
       AND ddmid.inequality_columns IS NOT NULL
         THEN ','
         ELSE ''
     END + ISNULL(ddmid.inequality_columns, '') + ')' + ISNULL(' Include (' + ddmid.included_columns + ');', ';') AS sql_statement, 
   ddmigs.user_seeks, 
   ddmigs.user_scans, 
   CAST((ddmigs.user_seeks + ddmigs.user_scans) * ddmigs.avg_user_impact AS BIGINT) AS 'est_impact', 
   avg_user_impact, 
   ddmigs.last_user_seek, 
   (
     SELECT DATEDIFF(Second, create_date, GETDATE()) Seconds
     FROM sys.databases
     WHERE name = 'tempdb'
   ) SecondsUptime, 
   GETDATE()
   FROM sys.dm_db_missing_index_groups ddmig
 INNER JOIN sys.dm_db_missing_index_group_stats ddmigs ON ddmigs.group_handle = ddmig.index_group_handle
 INNER JOIN sys.dm_db_missing_index_details ddmid ON ddmig.index_handle = ddmid.index_handle
 INNER JOIN sys.tables t ON ddmid.OBJECT_ID = t.OBJECT_ID
   WHERE ddmid.database_id = DB_ID()
   ORDER BY est_impact DESC;
 DELETE FROM [dbo].[DFS_MissingIndexes]
 WHERE [DBName] IN('msdb', 'model', 'tempdb', 'master', 'dba');
    END;
	GO

--************************************************************************
-- select * from dbo.DFS_MissingIndexes ;
PRINT '--- "D:\dev\SQL\DFINAnalytics\DMV_SuggestMissingIndexes.sql"' 
