-- W. Dale Miller @ 2016
--* USEDFINAnalytics; -- replace your dbname
GO

-- drop table DFS_TableGrowthHistory
IF NOT EXISTS
(
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'DFS_TableGrowthHistory'
)
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
GO
-- exec dbo.UTIL_GetTableRowsSize 'AP_ProductionAF_Data'
CREATE PROCEDURE dbo.UTIL_GetTableRowsSize
AS
    BEGIN
 SELECT [DBNAME] = db_name(), 
   s.Name AS SchemaName, 
   t.Name AS TableName, 
   p.rows AS RowCounts, 
   CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
   CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
   CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
 FROM sys.tables t
 INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
 INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID
    AND i.index_id = p.index_id
 INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
 INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
 GROUP BY t.Name, 
   s.Name, 
   p.Rows;
 --ORDER BY s.Name, t.Name

    END;
GO
-- Unmodified source:
SELECT s.Name AS SchemaName, 
  t.Name AS TableName, 
  p.rows AS RowCounts, 
  CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Used_MB, 
  CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS Unused_MB, 
  CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS Total_MB
INTO DFS_TableGrowthHistory
FROM sys.tables t
     INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
     INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID
   AND i.index_id = p.index_id
     INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
     INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
GROUP BY t.Name, 
  s.Name, 
  p.Rows
ORDER BY s.Name, 
  t.Name;
GO