
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT es.session_id AS session_id, 
  COALESCE(es.original_login_name, 'No Info') AS login_name, 
  COALESCE(es.host_name, 'No Info') AS hostname, 
  COALESCE(es.last_request_end_time, es.last_request_start_time) AS last_batch, 
  es.STATUS, 
  COALESCE(er.blocking_session_id, 0) AS blocked_by, 
  COALESCE(er.wait_type, 'MISCELLANEOUS') AS waittype, 
  COALESCE(er.wait_time, 0) AS waittime, 
  COALESCE(er.last_wait_type, 'MISCELLANEOUS') AS lastwaittype, 
  COALESCE(er.wait_resource, '') AS waitresource, 
  COALESCE(DB_NAME(er.database_id), 'No Info') AS dbid, 
  COALESCE(er.command, 'AWAITING COMMAND') AS cmd, 
  sql_text = st.text, 
  transaction_isolation = CASE es.transaction_isolation_level
  WHEN 0
  THEN 'Unspecified'
  WHEN 1
  THEN 'Read Uncommitted'
  WHEN 2
  THEN 'Read Committed'
  WHEN 3
  THEN 'Repeatable'
  WHEN 4
  THEN 'Serializable'
  WHEN 5
  THEN 'Snapshot'
     END, 
  COALESCE(es.cpu_time, 0) + COALESCE(er.cpu_time, 0) AS cpu, 
  COALESCE(es.reads, 0) + COALESCE(es.writes, 0) + COALESCE(er.reads, 0) + COALESCE(er.writes, 0) AS physical_io, 
  COALESCE(er.open_transaction_count, -1) AS open_tran, 
  COALESCE(es.program_name, '') AS program_name, 
  es.login_time
FROM sys.dm_exec_sessions AS es
     LEFT OUTER JOIN sys.dm_exec_connections AS ec ON es.session_id = ec.session_id
     LEFT OUTER JOIN sys.dm_exec_requests AS er ON es.session_id = er.session_id
     LEFT OUTER JOIN sys.server_principals AS sp ON es.security_id = sp.sid
     LEFT OUTER JOIN sys.dm_os_tasks AS ota ON es.session_id = ota.session_id
     LEFT OUTER JOIN sys.dm_os_threads AS oth ON ota.worker_address = oth.worker_address
     CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS st
WHERE es.is_user_process = 1
 AND es.session_id <> @@spid
UNION
SELECT es.session_id AS session_id, 
  COALESCE(es.original_login_name, 'No Info') AS login_name, 
  COALESCE(es.host_name, 'No Info') AS hostname, 
  COALESCE(es.last_request_end_time, es.last_request_start_time) AS last_batch, 
  es.STATUS, 
  COALESCE(er.blocking_session_id, 0) AS blocked_by, 
  COALESCE(er.wait_type, 'MISCELLANEOUS') AS waittype, 
  COALESCE(er.wait_time, 0) AS waittime, 
  COALESCE(er.last_wait_type, 'MISCELLANEOUS') AS lastwaittype, 
  COALESCE(er.wait_resource, '') AS waitresource, 
  COALESCE(DB_NAME(er.database_id), 'No Info') AS dbid, 
  COALESCE(er.command, 'AWAITING COMMAND') AS cmd, 
  sql_text = st.text, 
  transaction_isolation = CASE es.transaction_isolation_level
  WHEN 0
  THEN 'Unspecified'
  WHEN 1
  THEN 'Read Uncommitted'
  WHEN 2
  THEN 'Read Committed'
  WHEN 3
  THEN 'Repeatable'
  WHEN 4
  THEN 'Serializable'
  WHEN 5
  THEN 'Snapshot'
     END, 
  COALESCE(es.cpu_time, 0) + COALESCE(er.cpu_time, 0) AS cpu, 
  COALESCE(es.reads, 0) + COALESCE(es.writes, 0) + COALESCE(er.reads, 0) + COALESCE(er.writes, 0) AS physical_io, 
  COALESCE(er.open_transaction_count, -1) AS open_tran, 
  COALESCE(es.program_name, '') AS program_name, 
  es.login_time
FROM sys.dm_exec_sessions AS es
     INNER JOIN sys.dm_exec_requests AS ec2 ON es.session_id = ec2.blocking_session_id
     LEFT OUTER JOIN sys.dm_exec_connections AS ec ON es.session_id = ec.session_id
     LEFT OUTER JOIN sys.dm_exec_requests AS er ON es.session_id = er.session_id
     LEFT OUTER JOIN sys.server_principals AS sp ON es.security_id = sp.sid
     LEFT OUTER JOIN sys.dm_os_tasks AS ota ON es.session_id = ota.session_id
     LEFT OUTER JOIN sys.dm_os_threads AS oth ON ota.worker_address = oth.worker_address
     CROSS APPLY sys.dm_exec_sql_text(ec.most_recent_sql_handle) AS st
WHERE es.is_user_process = 1
 AND es.session_id <> @@spid;
