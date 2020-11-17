
/*
-- --* USEBNYUK_ProductionAR_Port
-- W. Dale Miller
-- @ July 26, 2016
--As a general best practice, it is recommended to have an index associated 
--with each foreign key. This facilitates faster table joins, which are 
--typically joined on foreign key columns anyway. Indexes on foreign keys 
--also facilitate faster deletes. If these supporting indexes are missing, 
--SQL will perform a table scale on the related table each time a record in 
--the first table is deleted.
-- Foreign Keys missing indexes 
-- Note this script only works for creating single column indexes. 
-- Multiple FK columns are out of scope for this script. 
*/
/*
DECLARE @Command NVARCHAR(200);
SET @Command = '--* USE?; exec sp_DFS_FindMissingFKIndexes ;';
EXEC sp_msForEachDb @Command;
GO
*/
/** USEDFINAnalytics;*/

GO

/*
drop TABLE [dbo].[DFS_MissingFKIndexes];
*/

IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables
    WHERE table_name = 'DFS_MissingFKIndexes'
)
    DROP TABLE [dbo].[DFS_MissingFKIndexes];
CREATE TABLE [dbo].[DFS_MissingFKIndexes]
(SVR             [NVARCHAR](150) NULL, 
 [DBName]        [NVARCHAR](150) NULL, 
 SSVER           [NVARCHAR](250) NULL, 
 [FK_Constraint] [SYSNAME] NOT NULL, 
 [FK_Table]      [SYSNAME] NOT NULL, 
 [FK_Column]     [NVARCHAR](150) NULL, 
 [ParentTable]   [SYSNAME] NOT NULL, 
 [ParentColumn]  [NVARCHAR](150) NULL, 
 [IndexName]     [SYSNAME] NULL, 
 [SQL]           [NVARCHAR](1571) NULL, 
 [CreateDate]    [DATETIME] NOT NULL, 
 [UID]           UNIQUEIDENTIFIER DEFAULT NEWID()
)
ON [PRIMARY];
CREATE INDEX pi_DFS_MissingFKIndexes
ON DFS_MissingFKIndexes
([UID]
);

/** USEmaster;*/

GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_FindMissingFKIndexes'
)
    BEGIN
        DROP PROCEDURE sp_DFS_FindMissingFKIndexes;
END;
GO

/* drop table dbo..DFS_MissingFKIndexes*/

CREATE PROCEDURE sp_DFS_FindMissingFKIndexes
AS
    BEGIN
        PRINT 'INSIDE: ' + DB_NAME();
        INSERT INTO dbo.DFS_MissingFKIndexes
               SELECT @@servername AS SVR, 
                      DB_NAME() AS DBName, 
                      @@VERSION AS SSVER, 
                      rc.Constraint_Name AS FK_Constraint,

                      /* rc.Constraint_Catalog AS FK_Database, rc.Constraint_Schema AS FKSch, */
                      ccu.Table_Name AS FK_Table, 
                      ccu.Column_Name AS FK_Column, 
                      ccu2.Table_Name AS ParentTable, 
                      ccu2.Column_Name AS ParentColumn, 
                      I.Name AS IndexName,
                      CASE
                          WHEN I.Name IS NULL
                          THEN 'IF NOT EXISTS (SELECT * FROM sys.indexes
	   WHERE object_id = OBJECT_ID(N''' + RC.Constraint_Schema + '.' + ccu.Table_Name + ''') AND name = N''IX_' + ccu.Table_Name + '_' + ccu.Column_Name + ''') ' + 'CREATE NONCLUSTERED INDEX IX_' + ccu.Table_Name + '_' + ccu.Column_Name + ' ON ' + rc.Constraint_Schema + '.' + ccu.Table_Name + '( ' + ccu.Column_Name + ' ASC ) WITH (PAD_INDEX = OFF, 
	  STATISTICS_NORECOMPUTE = OFF,
	  SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF,
	  DROP_EXISTING = OFF, ONLINE = ON);'
                          ELSE ''
                      END AS SQL, 
                      GETDATE() AS CreateDate, 
                      NEWID() AS [UID]
               FROM information_schema.referential_constraints AS RC
                         JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu
                         ON rc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
                              JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS ccu2
                         ON rc.UNIQUE_CONSTRAINT_NAME = ccu2.CONSTRAINT_NAME
                                   LEFT JOIN sys.columns AS c
                         ON ccu.Column_Name = C.name
                            AND ccu.Table_Name = OBJECT_NAME(C.OBJECT_ID)
                                        LEFT JOIN sys.index_columns AS ic
                         ON C.OBJECT_ID = IC.OBJECT_ID
                            AND c.column_id = ic.column_id
                            AND index_column_id = 1
                                             LEFT JOIN sys.indexes AS i
                         ON IC.OBJECT_ID = i.OBJECT_ID
                            AND ic.index_Id = i.index_Id
               WHERE I.name IS NULL
               ORDER BY FK_table, 
                        ParentTable, 
                        ParentColumn;
        DELETE FROM [dbo].DFS_MissingFKIndexes
        WHERE [DBName] IN('msdb', 'model', 'tempdb', 'master', 'dba');
    END;
GO