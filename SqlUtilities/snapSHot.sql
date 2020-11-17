DECLARE @DBName VARCHAR(100) = (SELECT DB_NAME()),
		@RetentionInHours INT = 24,
		@SQL VARCHAR(1000)

DECLARE @Table TABLE(ID INT IDENTITY(1,1), SnapshotName VARCHAR(100))

DECLARE	@FilePath NVARCHAR(500) = 'SELECT @FilePath = REVERSE(SUBSTRING(REVERSE(filename),PATINDEX(''%[\]%'',REVERSE(filename)) ,100)) FROM ' + @DBName + '..sysfiles WHERE FileID = 1',
		@FileName NVARCHAR(500) = (SELECT @DBName + '_ss' + FORMAT(GETDATE(),'yyyyMMdd_HHmm')),
		@DataFile NVARCHAR(100) = 'SELECT @DataFile = name FROM ' + @DBName + '..sysfiles WHERE FileID = 1'

--Set Parameters
EXEC sp_executesql @FilePath, N'@FilePath NVARCHAR(500) out', @FilePath OUT
EXEC sp_executesql @DataFile, N'@DataFile NVARCHAR(500) out', @DataFile OUT

SET @SQL = 'CREATE DATABASE ' + @FileName + ' ON ( NAME = ' + @DataFile + ', FILENAME = ''' + @FilePath + @FileName + '.ss'' ) AS SNAPSHOT OF ' + @DBName

EXEC(@SQL)

--Find snapshots that are older than x hours
INSERT INTO @Table SELECT Name FROM sys.databases WHERE source_database_id IS NOT NULL AND create_date <= DATEADD(HOUR,-@RetentionInHours,GETDATE())

/******************************s**************************************************************************************************************************
1.  Loop through snapshots that need to be cleaned up.
2.  Kill any connections associated with the current snapshot being cleaned up
3.  Drop the snapshot

********************************************************************************************************************************************************/

DECLARE @TempTable TABLE (SPID INT, Status VARCHAR(100), Login VARCHAR(100), hostname VARCHAR(100), blkby VARCHAR(100),dbname VARCHAR(100),
command VARCHAR(MAX),cputime INT,diskio INT,lastbatch VARCHAR(100),programname VARCHAR(100),spid2 INT,requestid INT)

INSERT INTO @TempTable
EXEC sp_who2

DECLARE @spid INT,
		@DBID INT
	

SET @DBID = (SELECT TOP 1 ID FROM @Table)


WHILE @DBID IS NOT NULL BEGIN

				SET @DBName = (SELECT SnapshotName FROM @Table WHERE ID = @DBID)
				SET @spid = (SELECT TOP 1 spid FROM @temptable WHERE dbname = @DBName)

				WHILE @SPID IS NOT NULL BEGIN

					SET @SQL = 'KILL ' + CAST(@spid AS VARCHAR(100))
					EXEC(@SQL)

				SET @spid = (SELECT TOP 1 spid FROM @temptable WHERE dbname = @DBName AND SPID > @spid)
				END

				SET @DBID = (SELECT TOP 1 ID FROM @Table WHERE ID > @DBID)

				--Cleanup Snapshot
				SET @SQL = 'DROP DATABASE ' + @DBName
				EXEC(@SQL)
END


/********************************************************************************************************************************************************/



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
