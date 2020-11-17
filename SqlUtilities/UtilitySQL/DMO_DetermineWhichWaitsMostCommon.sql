create proc UTIL_ListMostCommonWaits
as
select top 10 wait_type
, wait_time_ms
, Percentage = 100. * wait_time_ms/sum(wait_time_ms) OVER()
from sys.dm_os_wait_stats wt
where wt.wait_type NOT LIKE '%SLEEP%'
order by Percentage desc

--GRANT EXECUTE ON OBJECT::dbo.UTIL_ListMostCommonWaits TO public;