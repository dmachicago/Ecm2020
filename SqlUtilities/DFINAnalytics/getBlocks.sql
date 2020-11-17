
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
select spid, status, blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype
from dbo.sysprocesses
where blocked <> 0

dbcc inputbuffer (21)
dbcc inputbuffer (64)

exec sp_lock 21
*/

begin try
    drop table #TempLocks
end try
begin catch
    print 'Dropping #TempLocks ';
end catch

SELECT * INTO #TempLocks FROM OPENROWSET('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;',
'exec sp_lock 21') ;
-- select * from #TempLocks
--SELECT * INTO TEMP_Blocked FROM OPENROWSET('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;',
--'select spid, status, blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype
--from dbo.sysprocesses
--where blocked <> 0')

begin try
    drop table #TEmpBlocked ;
end try
begin catch
    print 'Dropping #TempLocks ';
end catch
SELECT * INTO #TempBlocked FROM OPENROWSET('SQLNCLI', 'Server=localhost;Trusted_Connection=yes;',
'select spid, status, blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype
from dbo.sysprocesses
where blocked <> 0') ;
-- select * from #TempBlocked

declare @lastwaittype nvarchar(1000) = '' ;
declare @CMD nvarchar(1000) = '' ;
declare @waitresource nvarchar(1000) = '' ;
declare @waittype binary(2) = null ;
declare @waittime bigint = null ;
declare @open_tran int = 0 ; 
declare @blocked int = 0 ; 
declare @spid int = 0 ; 
declare @status as nvarchar(100) = '' ;

declare @spid2 as int = null;
declare @dbid  as int = null;
declare @txtObjId as nvarchar(100) = null ;
declare  @ObjId as int = null;
declare  @InDid as int = null;
declare @Type as nvarchar(100) = null ;
declare @Resource as nvarchar(100) = null ;
declare @Mode as nvarchar(100) = null ;
declare @Status2 as nvarchar(100) = null ;

DECLARE C CURSOR
    FOR SELECT spid, [status], blocked, open_tran, waitresource, waittype, waittime, cmd, lastwaittype FROM #TEmpBlocked
OPEN C

FETCH NEXT FROM C 
INTO @spid, @status, @blocked, @open_tran, @waitresource, @waittype, @waittime, @cmd, @lastwaittype

WHILE @@FETCH_STATUS = 0
BEGIN
    print 'SPID: ' + cast(@spid as nvarchar(50)) ;

    set @waitresource = Ltrim(@waitresource);
    set @waitresource = Rtrim(@waitresource);
    print '-' + @waitresource + '-'
    
    DECLARE C2 CURSOR FOR 
	   SELECT spid, [dbid], [ObjId], InDid, [Type], [resource], [Mode], [status] FROM #TempLocks ;
    open C2 ;

    FETCH NEXT FROM C2
	   INTO @spid2, @dbid, @ObjId, @InDid, @Type, @resource, @Mode, @Status2 ;

    WHILE @@FETCH_STATUS = 0
    BEGIN

	   set @txtObjId = cast(@ObjId as nvarchar(50)) ;
	   print @txtObjId +',' + @Status2 ;
	   if charindex(@txtObjId, @waitresource) > 0 and @txtObjId <> '0' 
	   begin 
    		  print 'SPID ' + cast(@spid as nvarchar(50)) + ' is blocking ' + cast(@blocked as nvarchar(50)) + ', at the ' + @Type + ' Level, with a Mode of ' + @mode + ' and a status of ' + @Status2 ;
	   end 

 FETCH NEXT FROM C2
	   INTO @spid2, @dbid, @ObjId, @InDid, @Type, @resource, @Mode, @status2 ;
    END;
    CLOSE C2 ;
    DEALLOCATE C2 ;
    FETCH NEXT FROM C INTO @spid, @status, @blocked, @open_tran, @waitresource, @waittype, @waittime, @cmd, @lastwaittype    
END ;

CLOSE C
DEALLOCATE C


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
