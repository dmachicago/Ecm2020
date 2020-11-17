create proc UTIL_ListCurrentWaits 
as
--WDM 2/01/2013 :  Displays waits that are in effect right now.
--USE exec UTIL_ListCurrentWaits
SELECT wt.session_id
	, wt.wait_type
	, er.wait_resource
	, wt.wait_duration_ms
	, st.text
	, er.start_time
FROM sys.dm_os_waiting_tasks wt

	INNER JOIN sys.dm_exec_requests er on wt.waiting_task_address = er.task_address
	OUTER APPLY sys.dm_exec_sql_text(er.sql_handle) st

where wt.wait_type NOT LIKE '%SLEEP%'
and wt.session_id >= 50
ORDER BY wt.wait_duration_ms desc

go 

GRANT EXECUTE ON OBJECT::dbo.UTIL_ListCurrentWaits TO public;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
