GO

/*exec sp_who2
declare @spid as int = 52;*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_InspectParallelCpuUsage'
)
    DROP PROCEDURE sp_InspectParallelCpuUsage;
GO
CREATE PROCEDURE sp_InspectParallelCpuUsage(@spid AS INT)
AS
    BEGIN

/*
ANSWERS: How many CPUs is my query using
The scheduler_id column is key. Each scheduler is mapped to one of my virtual CPU cores.
*/
        SELECT ost.session_id, 
               ost.scheduler_id, 
               w.worker_address, 
               ost.task_state, 
               wt.wait_type, 
               wt.wait_duration_ms
        FROM sys.dm_os_tasks ost
                  LEFT JOIN sys.dm_os_workers w
                  ON ost.worker_address = w.worker_address
                       LEFT JOIN sys.dm_os_waiting_tasks wt
                  ON w.task_address = wt.waiting_task_address
        WHERE ost.session_id = @spid
        ORDER BY scheduler_id;

        /******************************************************************************/
/*
If I run my query with ‘actual execution plans’ enabled, I can spy on my 
query using the sys.dm_exec_query_profiles DMV like this:
*/
        SELECT ost.session_id, 
               ost.scheduler_id, 
               w.worker_address, 
               qp.node_id, 
               qp.physical_operator_name, 
               ost.task_state, 
               wt.wait_type, 
               wt.wait_duration_ms, 
               qp.cpu_time_ms
        FROM sys.dm_os_tasks ost
                  LEFT JOIN sys.dm_os_workers w
                  ON ost.worker_address = w.worker_address
                       LEFT JOIN sys.dm_os_waiting_tasks wt
                  ON w.task_address = wt.waiting_task_address
                     AND wt.session_id = ost.session_id
                            LEFT JOIN sys.dm_exec_query_profiles qp
                  ON w.task_address = qp.task_address
        WHERE ost.session_id = @spid
        ORDER BY scheduler_id, 
                 worker_address, 
                 node_id;
    END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_CountParallelCpuUsage'
)
    DROP PROCEDURE sp_CountParallelCpuUsage;
GO
/*
exec sp_CountParallelCpuUsage
*/
CREATE PROCEDURE sp_CountParallelCpuUsage
AS
    BEGIN
		/*
		ANSWERS: How many CPUs each SPID is using
		Using the output here, it is easy to spot potential parallel execution issues before or after they happen.
		*/
        SELECT DISTINCT 
               ost.session_id, 
               COUNT(ost.scheduler_id) AS CPUs_USED
        FROM sys.dm_os_tasks ost
                  LEFT JOIN sys.dm_os_workers w
                  ON ost.worker_address = w.worker_address
                       LEFT JOIN sys.dm_os_waiting_tasks wt
                  ON w.task_address = wt.waiting_task_address
        GROUP BY ost.session_id
        ORDER BY 2 DESC, 
                 session_id;
    END;