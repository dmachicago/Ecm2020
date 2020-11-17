-- Tasks running in parallel (filtering out MARS requests below):
SELECT *
FROM sys.dm_os_tasks AS t
WHERE t.session_id IN
(
    SELECT t1.session_id
    FROM sys.dm_os_tasks AS t1
    GROUP BY t1.session_id
    HAVING COUNT(*) > 1
           AND MIN(t1.request_id) = MAX(t1.request_id)
);

-- Requests running in parallel:
SELECT *
FROM sys.dm_exec_requests AS r
     JOIN
(
    SELECT t1.session_id, 
           MIN(t1.request_id)
    FROM sys.dm_os_tasks AS t1
    GROUP BY t1.session_id
    HAVING COUNT(*) > 1
           AND MIN(t1.request_id) = MAX(t1.request_id)
) AS t(session_id, request_id) ON r.session_id = t.session_id
                                  AND r.request_id = t.request_id;

--Here is a query that returns information about the wait queue of tasks that are waiting on some resource:
SELECT wt.session_id, 
       ot.task_state, 
       wt.wait_type, 
       wt.wait_duration_ms, 
       wt.blocking_session_id, 
       wt.resource_description, 
       es.host_name, 
       es.program_name
FROM sys.dm_os_waiting_tasks AS wt
     INNER JOIN sys.dm_os_tasks AS ot ON ot.task_address = wt.waiting_task_address
     INNER JOIN sys.dm_exec_sessions AS es ON es.session_id = wt.session_id
WHERE es.is_user_process = 1; 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016