
--* USEDFINAnalytics;
GO
--* USEmaster;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_UTIL_RebuildAllDbIndexes'
)
    DROP PROCEDURE sp_UTIL_RebuildAllDbIndexes;
	GO

/*
--* USE[AW2016]
--* USEDFINAnalytics
exec sp_UTIL_RebuildAllDbIndexes
*/

CREATE PROCEDURE sp_UTIL_RebuildAllDbIndexes
AS
    BEGIN
 PRINT 'USING: ' + DB_NAME();
		DECLARE @DBName VARCHAR(250);
 DECLARE @tblName VARCHAR(250);
 DECLARE @schemaName VARCHAR(250);
 DECLARE @idxName VARCHAR(250);
 
		DECLARE @Tables TABLE
 (DatabaseName SYSNAME, 
  SchemaName   SYSNAME, 
  TableName    SYSNAME
 );
 INSERT INTO @Tables
 (DatabaseName, 
  SchemaName, 
  TableName
 )
 EXEC sp_msforeachdb 
 'select ''?'', s.name, t.name from [?].sys.tables t inner join [?].sys.schemas s on t.schema_id = s.schema_id';
 
		--SELECT * FROM @Tables where DatabaseName not in ('msdb','tempdb','DBA','model', 'master', 'ReportServer', 'ReportServerTempDB') ORDER BY 1, 2, 3;

		delete from @Tables where DatabaseName in ('msdb','tempdb','DBA','model', 'master', 'ReportServer', 'ReportServerTempDB')

 --SELECT 'ALTER INDEX ALL ON ' + TABLE_SCHEMA + '.' + TABLE_NAME + ' rebuild;' AS cmd
 --INTO #CMDS
 
		DECLARE tbl CURSOR
 FOR SELECT DatabaseName, SchemaName, TableName
     FROM @Tables where DatabaseName not in ('msdb','tempdb','DBA','model');
 OPEN tbl;
 
		DECLARE @msg NVARCHAR(1000);
 DECLARE @stmt NVARCHAR(1000);
 FETCH NEXT FROM tbl INTO @DBName,@schemaName, @tblName ;
 WHILE @@FETCH_STATUS = 0
     BEGIN
				set @stmt = 'ALTER INDEX ALL ON ' +@DBName+'.' + @schemaName + '.' + @tblName + ' rebuild;' 
  --SET @msg = 'Processing: ' + DB_NAME() + '.' + @schemaName + '.' + @tblname;
  --EXEC sp_printimmediate @msg;
  EXEC sp_printimmediate @stmt;
  BEGIN TRY
 EXEC sp_executesql 
    @stmt;
  END TRY
  BEGIN CATCH
 SET @msg = 'ERROR Processing: ' + @stmt;
 EXEC sp_printimmediate 
    @msg;
  END CATCH;
  FETCH NEXT FROM tbl INTO @DBName,@schemaName, @tblName ;
     END;
 CLOSE tbl;
 DEALLOCATE tbl;
    END;