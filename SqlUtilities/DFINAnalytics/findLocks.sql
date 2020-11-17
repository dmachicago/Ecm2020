--* USEDFINAnalytics
go

/* IF NEEDED, RUN THIS
go
sp_configure 'Show Advanced Options', 1
GO
RECONFIGURE
GO
sp_configure 'Ad Hoc Distributed Queries', 1
GO
RECONFIGURE
*/
/*
exec sp_who2 

select spid, status, Blocked,  open_tran, waitresource, waittype, waittime, cmd, lastwaittype
from dbo.sysprocesses
where Blocked <> 0

dbcc inputbuffer (21)
dbcc inputbuffer (64)

exec sp_lock 56
exec sp_lock 
*/

-- UTIL_findLocks;
GO

IF EXISTS ( SELECT name
     FROM sys.procedures
     WHERE name = 'UTIL_findLocks'
   ) 
    BEGIN
 DROP PROCEDURE UTIL_findLocks;
END;
GO

-- exec UTIL_findLocks
CREATE PROCEDURE UTIL_findLocks
AS
    BEGIN
 SET NOCOUNT ON;
 IF OBJECT_ID('TempDB.dbo.#TempLocks') IS NOT NULL
		DROP TABLE #TempLocks;

 --declare @tsql as nvarchar(1000) = '' ;
 --declare @tcmd as nvarchar(1000) = 'exec sp_lock 63' ;
 --set  @tsql = @tsql + ' SELECT * INTO #TempLocks ' + char(10) ;
 --set  @tsql = @tsql + ' FROM OPENROWSET (''SQLNCLI'', ''Server=localhost;Trusted_Connection=yes;'', '''+@tcmd+''' ) ;' ;
 --exec (@tsql) ;

 IF OBJECT_ID('TempDB.dbo.#TEmpBlocked') IS NOT NULL
     DROP TABLE #TEmpBlocked;
 
 SELECT spid , STATUS , blocked , open_tran , waitresource , waittype , waittime , cmd , lastwaittype
 INTO #TempBlocked
 FROM dbo.sysprocesses
 WHERE blocked <> 0;
 IF ( SELECT COUNT(*)
 FROM #TempBlocked
    ) = 0
     BEGIN
  PRINT 'NO Blocks found.';
  RETURN;
 END;

 --    SELECT
 --    * INTO
 --    #TempBlocked
 --    FROM OPENROWSET ('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;', 'select spid, status, Blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype
 --from dbo.sysprocesses
 --where Blocked <> 0') ;
 --select * from #TempBlocked

 DECLARE @lastwaittype NVARCHAR(1000)= '';
 DECLARE @CMD NVARCHAR(1000)= '';
 DECLARE @waitresource NVARCHAR(1000)= '';
 DECLARE @waittype BINARY(2)= NULL;
 DECLARE @waittime BIGINT= NULL;
 DECLARE @open_tran INT= 0;
 DECLARE @Blocked INT= 0;
 DECLARE @spid INT= 0;
 DECLARE @status AS NVARCHAR(100)= '';
 DECLARE @spid2 AS INT= NULL;
 DECLARE @dbid AS INT= NULL;
 DECLARE @txtObjId AS NVARCHAR(100)= NULL;
 DECLARE @ObjId AS INT= NULL;
 DECLARE @InDid AS INT= NULL;
 DECLARE @Type AS NVARCHAR(100)= NULL;
 DECLARE @Resource AS NVARCHAR(100)= NULL;
 DECLARE @Mode AS NVARCHAR(100)= NULL;
 DECLARE @Status2 AS NVARCHAR(100)= NULL;
 DECLARE @MyParm AS NVARCHAR(100)= NULL;
 DECLARE @MySql AS NVARCHAR(4000)= NULL;
 DECLARE C CURSOR
 FOR SELECT spid , STATUS , Blocked , open_tran , waitresource , waittype , waittime , cmd , lastwaittype
     FROM #TEmpBlocked;
 OPEN C;
 FETCH NEXT FROM C INTO @spid , @status , @Blocked , @open_tran , @waitresource , @waittype , @waittime , @cmd , @lastwaittype;
 PRINT '@spid';
 PRINT @spid;
 WHILE @@FETCH_STATUS = 0
     BEGIN

  --print 'SPID: ' + cast(@spid as nvarchar(50)) ;
  SET @waitresource = LTRIM(@waitresource);
  SET @waitresource = RTRIM(@waitresource);
  --print '-' + @waitresource + '-'
  SET @MyParm = 'EXEC SP_LOCK ' + CAST(@Blocked AS NVARCHAR(50));
  PRINT '@MyParm: ' + @MyParm;
  BEGIN TRY
 DROP TABLE #TempLocks;
  END TRY
  BEGIN CATCH
 EXEC sp_PrintImmediate 'filling table #TempLocks ';
  END CATCH;

  --declare @MySql nvarchar(1000) = '' ;
  --declare @Blocked as int = 50 ;
  --declare @MyParm nvarchar(1000) = 'EXEC SP_LOCK ' + cast(@Blocked as nvarchar(50)) ;

  SET @MySql = 'SELECT * INTO #TempLocks ';
  SET @MySql = @MySql + '   FROM OPENROWSET (''SQLNCLI'', ''Server=localhost;Trusted_Connection=yes;'', ''' + @MyParm + ''' ) '; 
  --print @MySql ;
  EXEC (@MySql);
  DECLARE C2 CURSOR
  FOR SELECT spid , dbid , ObjId , InDid , Type , resource , Mode , STATUS
 FROM #TempLocks;
  OPEN C2;
  FETCH NEXT FROM C2 INTO @spid2 , @dbid , @ObjId , @InDid , @Type , @resource , @Mode , @Status2;
  WHILE @@FETCH_STATUS = 0
 BEGIN
   SET @txtObjId = CAST(@ObjId AS NVARCHAR(50));
   --print @txtObjId +',' + @Status2 ;
   IF CHARINDEX(@txtObjId , @waitresource) > 0
 AND 
 @txtObjId <> '0'
  BEGIN
    PRINT 'SPID ' + CAST(@spid AS NVARCHAR(50)) + ' is blocking ' + CAST(@Blocked AS NVARCHAR(50)) + ', at the ' + @Type + ' Level, with a Mode of ' + @mode + ' and a status of ' + @Status2 + ' / from COMMAND: ' + @cmd;
   END;
   FETCH NEXT FROM C2 INTO @spid2 , @dbid , @ObjId , @InDid , @Type , @resource , @Mode , @status2;
 END;
  CLOSE C2;
  DEALLOCATE C2;
  FETCH NEXT FROM C INTO @spid , @status , @Blocked , @open_tran , @waitresource , @waittype , @waittime , @cmd , @lastwaittype;
     END;
 CLOSE C;
 DEALLOCATE C;
 SET NOCOUNT OFF;
    END;
GO

PRINT 'Executed findLocks.sql';
GO

/*
SELECT * INTO #TempLocks    FROM OPENROWSET ('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;', 'EXEC SP_LOCK 53' ) 
select * from #TempLocks
*/

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016PRINT '--- "D:\dev\SQL\DFINAnalytics\findLocks.sql"' 
