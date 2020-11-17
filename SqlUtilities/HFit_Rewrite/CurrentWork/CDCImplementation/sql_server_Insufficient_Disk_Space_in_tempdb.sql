--Determining the Amount of Free Space in tempdb
--The following query returns the total number of free pages and total free space in megabytes (MB) available in all files in tempdb.
SELECT SUM(unallocated_extent_page_count) AS [free pages], 
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage;

--Determining the Amount Space Used by the Version Store
--The following query returns the total number of pages used by the version store and the total space in MB used by the version store in tempdb.
SELECT SUM(version_store_reserved_page_count) AS [version store pages used],
(SUM(version_store_reserved_page_count)*1.0/128) AS [version store space in MB]
FROM sys.dm_db_file_space_usage;


--Determining the Longest Running Transaction
--If the version store is using a lot of space in tempdb, you must determine what is the longest running transaction. Use this query to list the active transactions in order, by longest running transaction.
--A long running transaction that is not related to an online index operation requires a large version store. This version store keeps all the versions generated since the transaction started. Online index build transactions can take a long time to finish, but a separate version store dedicated to online index operations is used. Therefore, these operations do not prevent the versions from other transactions from being removed. 
SELECT transaction_id
FROM sys.dm_tran_active_snapshot_database_transactions 
ORDER BY elapsed_time_seconds DESC;

--Determining the Amount of Space Used by Internal Objects
--The following query returns the total number of pages used by internal objects and the total space in MB used by internal objects in tempdb.
SELECT SUM(internal_object_reserved_page_count) AS [internal object pages used],
(SUM(internal_object_reserved_page_count)*1.0/128) AS [internal object space in MB]
FROM sys.dm_db_file_space_usage;

--Determining the Amount of Space Used by User Objects
--The following query returns the total number of pages used by user objects and the total space used by user objects in tempdb.
SELECT SUM(user_object_reserved_page_count) AS [user object pages used],
(SUM(user_object_reserved_page_count)*1.0/128) AS [user object space in MB]
FROM sys.dm_db_file_space_usage;

--Determining the Total Amount of Space (Free and Used)
--The following query returns the total amount of disk space used by all files in tempdb.
SELECT SUM(size)*1.0/128 AS [size in MB]
FROM tempdb.sys.database_files

go
--The following example creates the view all_task_usage. When queried, the view returns the total space used by internal objects in all currently running tasks in tempdb.
CREATE VIEW all_task_usage
AS 
    SELECT session_id, 
      SUM(internal_objects_alloc_page_count) AS task_internal_objects_alloc_page_count,
      SUM(internal_objects_dealloc_page_count) AS task_internal_objects_dealloc_page_count 
    FROM sys.dm_db_task_space_usage 
    GROUP BY session_id;
GO

--Obtaining the space consumed by internal objects in the current session for both running and completed tasks
--The following example creates the view all_session_usage. When queried, the view returns the space used by all internal objects running and completed tasks in tempdb.
CREATE VIEW all_session_usage 
AS
    SELECT R1.session_id,
        R1.internal_objects_alloc_page_count 
        + R2.task_internal_objects_alloc_page_count AS session_internal_objects_alloc_page_count,
        R1.internal_objects_dealloc_page_count 
        + R2.task_internal_objects_dealloc_page_count AS session_internal_objects_dealloc_page_count
    FROM sys.dm_db_session_space_usage AS R1 
    INNER JOIN all_task_usage AS R2 ON R1.session_id = R2.session_id;
GO

--An alternative to using SQL Server Profiler is to run DBCC INPUTBUFFER once every three minutes for all the sessions, as shown in the following example.
DECLARE @max int;
DECLARE @i int;
SELECT @max = max (session_id)
FROM sys.dm_exec_sessions
SET @i = 51
  WHILE @i <= @max BEGIN
         IF EXISTS (SELECT session_id FROM sys.dm_exec_sessions
                    WHERE session_id=@i)
         DBCC INPUTBUFFER (@i)
         SET @i=@i+1
         END;

go

/*
Sometimes just looking at the input buffer or the SQL Server Profiler event SQL:BatchCompleted does not always tell which query is using most of the disk space in tempdb. The following methods can be used to find this answer, but these methods require collecting more data than the procedures defined in Method 1.
To continue with this method, set up a SQL Server Agent Job job that polls from the sys.dm_db_task_space_usage dynamic management view. The polling interval should be short, once a minute, as compared to Method 1. This short interval is because sys.dm_db_task_space_usage does not return data if the query (task) is not currently running.
In the polling query, the view defined on the sys.dm_db_task_space_usage dynamic management view is joined with sys.dm_exec_requests to return the sql_handle, statement_start_offset, statement_end_offset, and plan_handle columns.
*/
CREATE VIEW all_request_usage
AS 
  SELECT session_id, request_id, 
      SUM(internal_objects_alloc_page_count) AS request_internal_objects_alloc_page_count,
      SUM(internal_objects_dealloc_page_count)AS request_internal_objects_dealloc_page_count 
  FROM sys.dm_db_task_space_usage 
  GROUP BY session_id, request_id;
GO
CREATE VIEW all_query_usage
AS
  SELECT R1.session_id, R1.request_id, 
      R1.request_internal_objects_alloc_page_count, R1.request_internal_objects_dealloc_page_count,
      R2.sql_handle, R2.statement_start_offset, R2.statement_end_offset, R2.plan_handle
  FROM all_request_usage R1
  INNER JOIN sys.dm_exec_requests R2 ON R1.session_id = R2.session_id and R1.request_id = R2.request_id;
GO
--If the query plan is in cache, you can retrieve the Transact-SQL text of the query and the query execution plan in XML showplan format at any time. To obtain the Transact-SQL text of the query that is executed, use the sql_handle value and the sys.dm_exec_sql_text dynamic management function. To obtain the query plan execution, use the plan_handle value and the sys.dm_exec_query_plan dynamic management function.
SELECT * FROM sys.dm_exec_sql_text(@sql_handle);
SELECT * FROM sys.dm_exec_query_plan(@plan_handle);
go

--A. Using the polling method
--Poll from the view all_query_usage, and run the following query to obtain the query text:
SELECT R1.sql_handle, R2.text 
FROM all_query_usage AS R1
OUTER APPLY sys.dm_exec_sql_text(R1.sql_handle) AS R2;

--Because sql_handle should be unique for each unique batch, you do not have to save duplicate sql_handle entries.
--To save the plan handle and XML plan, run the following query.
SELECT R1.plan_handle, R2.query_plan 
FROM all_query_usage AS R1
OUTER APPLY sys.dm_exec_query_plan(R1.plan_handle) AS R2;