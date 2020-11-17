SELECT s.*, r.*
, offsettext = CASE WHEN r.statement_start_offset = 0 and r.statement_end_offset= 0 THEN NULL
ELSE SUBSTRING ( est.[text], r.statement_start_offset/2 + 1,
CASE WHEN r.statement_end_offset = -1
THEN LEN (CONVERT(nvarchar(max), est.[text]))
ELSE r.statement_end_offset/2 - r.statement_start_offset/2 + 1 END)
END
FROM sys.dm_exec_sessions s
INNER JOIN sys.dm_exec_requests r on r.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text (r.sql_handle) est