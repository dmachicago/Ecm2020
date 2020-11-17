USE DFINAnalytics;
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TableSizeAndRowCnt'
)
    BEGIN

        /* drop TABLE [dbo].[DFS_TableSizeAndRowCnt];*/

        CREATE TABLE [dbo].[DFS_TableSizeAndRowCnt]
        (SvrName         NVARCHAR(150) NOT NULL, 
         DBName          NVARCHAR(150) NOT NULL, 
         [TableName]     [SYSNAME] NOT NULL, 
         [SchemaName]    [SYSNAME] NULL, 
         [RowCounts]     [BIGINT] NULL, 
         [TotalSpaceKB]  [BIGINT] NULL, 
         [UsedSpaceKB]   [BIGINT] NULL, 
         [UnusedSpaceKB] [BIGINT] NULL, 
         [UID]           UNIQUEIDENTIFIER NOT NULL
                                          DEFAULT NEWID(), 
         CreateDate      DATETIME DEFAULT GETDATE() NOT NULL
        )
        ON [PRIMARY];
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'DFS_GetAllTableSizesAndRowCnt'
)
    DROP PROCEDURE DFS_GetAllTableSizesAndRowCnt;
GO
-- exec DFS_GetAllTableSizesAndRowCnt
CREATE PROCEDURE DFS_GetAllTableSizesAndRowCnt
AS
    BEGIN
        INSERT INTO [dbo].[DFS_TableSizeAndRowCnt]
        ( SvrName, 
          DBName, 
          [TableName], 
          [SchemaName], 
          [RowCounts], 
          [TotalSpaceKB], 
          [UsedSpaceKB], 
          [UnusedSpaceKB], 
          [UID], 
          CreateDate
        ) 
               SELECT @@servername AS SvrName, 
                      DB_NAME() AS DBName, 
                      t.NAME AS TableName, 
                      s.Name AS SchemaName, 
                      p.rows AS RowCounts, 
                      SUM(a.total_pages) * 8 AS TotalSpaceKB, 
                      SUM(a.used_pages) * 8 AS UsedSpaceKB, 
                      (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB, 
                      NEWID() AS [UID], 
                      GETDATE() AS createDate
               FROM sys.tables t
                         INNER JOIN sys.indexes i
                         ON t.OBJECT_ID = i.object_id
                              INNER JOIN sys.partitions p
                         ON i.object_id = p.OBJECT_ID
                            AND i.index_id = p.index_id
                                   INNER JOIN sys.allocation_units a
                         ON p.partition_id = a.container_id
                                        LEFT OUTER JOIN sys.schemas s
                         ON t.schema_id = s.schema_id
               WHERE t.NAME NOT LIKE 'dt%'
                     AND t.is_ms_shipped = 0
                     AND i.OBJECT_ID > 255
               GROUP BY t.Name, 
                        s.Name, 
                        p.Rows
               ORDER BY t.Name;
    END;