

go 
print 'Executing proc_RerunJobIfNeeded' ;
go
if exists (select name from sys.procedures where name = 'proc_RerunJobIfNeeded')
    drop procedure proc_RerunJobIfNeeded ;
go

create procedure proc_RerunJobIfNeeded
as
SELECT j.name	 --, jh.run_status
into #JobRerun
  FROM
       msdb.dbo.sysjobs AS j
       INNER JOIN msdb.dbo.sysjobsteps AS js
       ON js.job_id = j.job_id
       INNER JOIN msdb.dbo.sysjobhistory AS jh
       ON jh.job_id = j.job_id
  WHERE 
    jh.run_status = 0
    and j.name NOT LIKE 'instrument%'
    AND j.name NOT LIKE 'DBAPlatform%'
except
SELECT j.name	 --, jh.run_status
  FROM
       msdb.dbo.sysjobs AS j
       INNER JOIN msdb.dbo.sysjobsteps AS js
       ON js.job_id = j.job_id
       INNER JOIN msdb.dbo.sysjobhistory AS jh
       ON jh.job_id = j.job_id
  WHERE 
    jh.run_status = 1
    and j.name NOT LIKE 'instrument%'
    AND j.name NOT LIKE 'DBAPlatform%'
order by j.name 

declare @MySql as nvarchar(max) ;
declare @DBNAME as nvarchar(250) = 'KenticoCMS_2' ;
declare @T as nvarchar(250) = '' ;
declare C cursor for
    select name from #JobRerun ;
    
    OPEN C;

    FETCH NEXT FROM C INTO @T ;

 WHILE
           @@FETCH_STATUS = 0
       begin
		  set @MySql = 'exec proc_isJobEnvironmentReady '''+@T+'''' ;
		  exec (@MySql) ;
            FETCH NEXT FROM C INTO @T ;
        END

close C;
deallocate C; 
go
print 'Executed proc_RerunJobIfNeeded' ;
go
