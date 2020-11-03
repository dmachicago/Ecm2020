-- Drop all column statistics on all tables.  We join sys.tables to ensure 
-- these are user (not system) tables.  Note that statistics for indexes 
-- cannot be dropped; the index itself has to be dropped to get rid of its 
-- statistics. 
DECLARE @Sql        NVARCHAR(MAX)       SET @Sql       = ''
DECLARE @TableName  sysname             SET @TableName = ''
DECLARE @StatsName  sysname             SET @StatsName = ''

DECLARE cur CURSOR LOCAL FOR
SELECT OBJECT_NAME(s.object_id)   AS 'TableName'
     , s.name                     AS 'StatsName'
  FROM sys.stats     s 
  JOIN sys.tables    t
    ON s.object_id = t.object_id
 WHERE s.object_id > 100
   AND s.name NOT IN 
         (SELECT name FROM sys.indexes WHERE object_id = s.object_id)

OPEN cur
FETCH NEXT FROM cur INTO @TableName, @StatsName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @Sql = 'DROP STATISTICS ' + QUOTENAME(@TableName) + '.' + QUOTENAME(@StatsName)
    PRINT @Sql
    EXEC sp_executesql @Sql
    FETCH NEXT FROM cur INTO @TableName, @StatsName
END

CLOSE cur 
DEALLOCATE cur 

-- Create the statistics for all tables and columns in the database that don't 
-- already exist.  This is much easier than using CREATE STATISTICS on each 
-- table, as you can only do 16 columns at a time, and have to name them each. 
RAISERROR('Creating statistics on all tables and columns that are missing them', 10, 1) WITH NOWAIT, LOG
EXEC sp_createstats @indexonly = 'NO', @fullscan = 'FULLSCAN', @norecompute ='NO'

-- Set the automatic UPDATE STATISTICS setting to 'ON' for all indexes and 
-- statistics for all tables and indexed views in the database. 
RAISERROR('Running sp_autostats for all tables...', 10, 1) WITH NOWAIT, LOG
EXEC sp_MSforeachtable '  PRINT ''?''   EXEC sp_autostats ''?'', @flagc = ''ON'' '

-- Display the new names of the column indexes. 
SELECT OBJECT_NAME(s.object_id)   AS 'TableName'
     , s.name                     AS 'StatsName'
  FROM sys.stats     s 
  JOIN sys.tables    t
    ON s.object_id = t.object_id
 WHERE s.object_id > 100
   AND s.name NOT IN 
         (SELECT name FROM sys.indexes WHERE object_id = s.object_id)