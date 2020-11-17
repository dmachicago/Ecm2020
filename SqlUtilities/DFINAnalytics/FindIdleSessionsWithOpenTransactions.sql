--Finding idle sessions that have open transactions and are idle. 
--An idle session is one that has no request currently running.

SELECT s.*
FROM sys.dm_exec_sessions AS s
WHERE EXISTS
(
    SELECT *
    FROM sys.dm_tran_session_transactions AS t
    WHERE t.session_id = s.session_id
)
 AND NOT EXISTS
(
    SELECT *
    FROM sys.dm_exec_requests AS r
    WHERE r.session_id = s.session_id
);