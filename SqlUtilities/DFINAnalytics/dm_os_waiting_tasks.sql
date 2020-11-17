
/* Identify blocked sessions. Execute the Transact-SQL query in SQL Server Management Studio.*/

SELECT *
into DFS_BlockedTask
FROM sys.dm_os_waiting_tasks
WHERE blocking_session_id IS NOT NULL;