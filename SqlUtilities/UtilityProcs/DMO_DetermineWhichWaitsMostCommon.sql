create proc UTIL_MonitorMostCommonWaits
as
select top 10  @@servername as SVR, db_name() as DBName, wait_type
, wait_time_ms
, Percentage = 100. * wait_time_ms/sum(wait_time_ms) OVER()
, getdate() as CreateDate
, newid() as [UID] 
from sys.dm_os_wait_stats wt
where wt.wait_type NOT LIKE '%SLEEP%'
order by Percentage desc

--GRANT EXECUTE ON OBJECT::dbo.UTIL_MonitorMostCommonWaits TO public;