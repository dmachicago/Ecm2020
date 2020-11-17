-- UTIL_DatabaseAndFileSize.sql
--* USEDFINAnalytics;
GO
-- DROP TABLE [dbo].[DFS_DbFileSizing]
IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'DFS_DbFileSizing'
)
drop TABLE [dbo].[DFS_DbFileSizing]
go
    CREATE TABLE [dbo].[DFS_DbFileSizing]
    ([Svr]       [SYSNAME] NOT NULL, 
	[Database]       [SYSNAME] NOT NULL, 
     [File]           [SYSNAME] NOT NULL, 
     [size]           [INT] NOT NULL, 
     [SizeMB]         [INT] NULL, 
     [Database Total] [INT] NULL, 
     [max_size]       [INT] NOT NULL, 
     CreateDate       DATETIME DEFAULT GETDATE(), 
     RowNbr           INT IDENTITY(1, 1), 
     RunID            BIGINT,
	 [UID] uniqueidentifier default newid()
    )
    ON [PRIMARY];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_DFS_DbFileSizing_Azure'
)
    DROP PROCEDURE UTIL_DFS_DbFileSizing_Azure;
GO
-- exec UTIL_DFS_DbFileSizing_Azure
CREATE PROCEDURE UTIL_DFS_DbFileSizing_Azure
AS
    BEGIN
        DECLARE @RunID AS BIGINT= NEXT VALUE FOR master_seq;
        DECLARE @ExecutionDate DATETIME= GETDATE();
        INSERT INTO [dbo].[DFS_DbFileSizing]
        ([Svr],[Database], 
         [File], 
         [size], 
         [SizeMB], 
         [Database Total], 
         [max_size], 
         [CreateDate], 
         [RunID],
		 [UID]
        )
               SELECT @@SERVERNAME, d.[name] AS 'Database', 
                      m.name AS 'File', 
                      m.size, 
                      m.size * 8 / 1024 'SizeMB', 
                      SUM(m.size * 8 / 1024) OVER(PARTITION BY d.name) AS 'Database Total', 
                      m.max_size, 
                      create_date = getdate(), 
					  --create_date = @ExecutionDate, 
                      RunID = @RunID,
					  [UID] = newid()
               FROM sys.database_files m
                    INNER JOIN sys.databases d ON d.physical_database_name = m.physical_database_name
               WHERE d.name NOT IN('msdb', 'master', 'ReportServer', 'ReportServerTempDB', 'TempDB', 'model');
    END;

select top 10 * from sys.database_files
select top 10 * from sys.databases