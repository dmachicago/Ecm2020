
SELECT tsql.text , 
       r.total_elapsed_time , 
       r.plan_handle , 
       r.blocking_session_id , 
       DB_NAME (r.database_id) AS DBName , 
	  'DBCC INPUTBUFFER(' + cast(s.session_id as nvarchar(50)) + ')' as DBCC_CMD,
	  'SELECT *FROM sys.dm_exec_query_plan(' + CONVERT( VARCHAR(MAX), plan_handle, 1)  + ')' as SysPlan_CMD,
       *
  FROM
       sys.dm_exec_sessions AS s
       LEFT JOIN sys.dm_exec_connections AS c
       ON s.session_id = c.session_id
       LEFT JOIN sys.dm_db_task_space_usage AS tsu
       ON tsu.session_id = s.session_id
       LEFT JOIN sys.dm_os_tasks AS t
       ON t.session_id = tsu.session_id
      AND t.request_id = tsu.request_id
       LEFT JOIN sys.dm_exec_requests AS r
       ON r.session_id = tsu.session_id
      AND r.request_id = tsu.request_id
       OUTER APPLY sys.dm_exec_sql_text (r.sql_handle) AS TSQL
  --WHERE r.blocking_session_id IS NOT NULL
  WHERE s.status <> 'sleeping'
  --WHERE DB_NAME(r.database_id) = 'KenticoCMSCloudtst2'
  ORDER BY DBName;

  DBCC INPUTBUFFER(85)
DBCC INPUTBUFFER(87)
DBCC INPUTBUFFER(93)
DBCC INPUTBUFFER(95)
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
