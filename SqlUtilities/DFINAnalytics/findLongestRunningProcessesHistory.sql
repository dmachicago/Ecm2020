
-- select top 20 * from [DFINAnalytics_TranLocks] order by Rownbr desc

select * 
from sys.dm_exec_sessions S  
join sys.dm_exec_connections C on S.session_id = C.session_id
--left outer join sys.dm_exec_query_stats qs on qs.sql_handle = C.most_recent_sql_handle
--CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
--CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
where S.total_elapsed_time >= 200000 ;
