
USE [DFINAnalytics];
GO

/* drop TABLE [dbo].[DFS_TxMonitorTableStats];*/

IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TxMonitorTableStats'
)
    BEGIN
        CREATE TABLE dbo.DFS_TxMonitorTableStats
        (SvrName          NVARCHAR(128) NULL, 
         DBName           NVARCHAR(128) NULL, 
         SchemaName       NVARCHAR(150) NULL, 
         TableName        NVARCHAR(128) NULL, 
         IndexName        NVARCHAR(250) NULL, 
         IndexID          INT NULL, 
         user_seeks       BIGINT NULL, 
         user_scans       BIGINT NULL, 
         user_lookups     BIGINT NULL, 
         user_updates     BIGINT NULL, 
         last_user_seek   DATETIME NULL, 
         last_user_scan   DATETIME NULL, 
         last_user_lookup DATETIME NULL, 
         last_user_update DATETIME NULL, 
         DBID             INT NULL, 
         CreateDate       DATETIME NULL, 
         ExecutionDate    DATETIME NOT NULL, 
         UID              UNIQUEIDENTIFIER NOT NULL, 
         RunID            INT NULL, 
         Rownbr           INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
END;
GO
USE master;
GO

/*
select * from sys.databases;
exec dbo.sp_DBMON_TxMonitorTableStats 9;
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DBMON_TxMonitorTableStats'
)
    DROP PROCEDURE dbo.sp_DBMON_TxMonitorTableStats;
GO

/* exec sp_DBMON_TxMonitorTableStats*/
/*
select top 100 * from DFINAnalytics.dbo.DFS_TxMonitorTableStats
DECLARE @RunID INT ;
declare @cutoff int = 100;
DECLARE @Command NVARCHAR(200);
EXEC @RunID = sp_UTIL_GetSeq;
SET @Command = 'use ?; exec sp_DBMON_TxMonitorTableStats '+cast(@RunID as nvarchar(50))+', '+cast(@cutoff as nvarchar(50))+' ;';
EXEC sp_msForEachDb @Command;
*/

CREATE PROCEDURE dbo.sp_DBMON_TxMonitorTableStats
(@RunID  INT = -1, 
 @cutoff INT = 100
)
AS
    BEGIN

/*
		In the results, you'll have the following columns:
			TableName - The name of the table (the easiest column)
			IndexName - when populated, the name of the index. When it's NULL, 
				it refers to a HEAP - a table without a clustered index 
			IndexID - If this is 0, it's a HEAP (IndexName should also be NULL in these cases). 
				When 1, this refers to a clustered index (meaning that the activity columns 
				still all refer to the table data itself). When 2 or greater, this is a standard 
				non-clustered index.

			User activity (the number of times each type of operation has been performed 
			on the index/table):
			User Seeks - searched for a small number of rows - this is the most effecient 
				index operation.
			User Scans - scanned through the whole index looking for rows that meet the 
				WHERE criteria.
			User Lookups - query used the index to find a row number, then pulled data 
				from the table itself to satisfy the query.
			User Updates - number of times the data in this index/table has been updated. 
				Note that not every table update will update every query - if an update 
				modifies a column that's not part of an index, the table update counter 
				will increment , but the index counter will not User activity timestamps 
					- these show the most recent occurance of each of the four types of 
					"User" events         
		*/
        DECLARE @DBNAME AS NVARCHAR(150)= DB_NAME();
        DECLARE @DBID AS INT= DB_ID(@DBNAME);
        IF EXISTS
        (
            SELECT 1
            FROM DFINAnalytics.dbo.DFS_DB2Skip
            WHERE @DBNAME = DB
        )
            BEGIN
                PRINT 'SKIPPING: ' + @DBNAME;
                RETURN;
        END;

        /*DECLARE @RunID AS BIGINT= NEXT VALUE FOR master_seq;*/
        DECLARE @ExecutionDate DATETIME= GETDATE();
        INSERT INTO DFINAnalytics.dbo.DFS_TxMonitorTableStats
               SELECT @@SERVERNAME AS SvrName, 
                      DB_NAME() AS DBName, 
                      sch.name AS SchemaName, 
                      OBJECT_NAME(ius.object_id) AS TableName, 
                      si.name AS IndexName, 
                      si.index_id AS IndexID, 
                      ius.user_seeks, 
                      ius.user_scans, 
                      ius.user_lookups, 
                      ius.user_updates, 
                      ius.last_user_seek, 
                      ius.last_user_scan, 
                      ius.last_user_lookup, 
                      ius.last_user_update, 
                      DB_ID() AS DBID, 
                      GETDATE() AS CreateDate, 
                      GETDATE() AS ExecutionDate, 
                      NEWID() AS UID, 
                      RunID = @RunID
               FROM sys.dm_db_index_usage_stats ius
                         JOIN sys.indexes si
                         ON ius.object_id = si.object_id
                            AND ius.index_id = si.index_id
                              JOIN sys.objects AS O
                         ON O.object_id = ius.object_id
                                   JOIN sys.schemas AS sch
                         ON O.schema_id = sch.schema_id
               WHERE ius.user_seeks >= @cutoff
                     OR ius.user_scans >= @cutoff
                     OR ius.user_lookups >= @cutoff
                     OR ius.user_updates >= @cutoff;
    END;