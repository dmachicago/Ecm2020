SELECT query_plan FROM sys.dm_exec_requests
CROSS APPLY sys.dm_exec_query_plan(plan_handle)
WHERE session_id = 135