DECLARE @TempTable TABLE (SPID INT, Status VARCHAR(100), Login VARCHAR(100), hostname VARCHAR(100), blkby VARCHAR(100),dbname VARCHAR(100),
command VARCHAR(MAX),cputime INT,diskio INT,lastbatch VARCHAR(100),programname VARCHAR(100),spid2 INT,requestid INT)

DECLARE @SQL VARCHAR(100)

INSERT INTO @TempTable
EXEC sp_who2


DECLARE @spid INT
 
SET @spid = (SELECT TOP 1 spid FROM @temptable WHERE dbname = 'KenticoCMS_MigrationTest')

WHILE @SPID IS NOT NULL BEGIN

 SET @SQL = 'KILL ' + CAST(@spid AS VARCHAR(100))
 EXEC(@SQL)

SET @spid = (SELECT TOP 1 spid FROM @temptable WHERE dbname = 'KenticoCMS_MigrationTest' AND SPID > @spid)
END

/* ADD Snapshot Restore Stmt below here */
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
