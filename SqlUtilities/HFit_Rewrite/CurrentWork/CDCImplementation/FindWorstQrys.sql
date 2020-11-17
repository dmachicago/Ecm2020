
--*************************************************************
--Find MOST executed queries
--*************************************************************
SELECT TOP 50
        QrySytats.execution_count
        ,OBJECT_NAME(objectid)
        ,query_text = SUBSTRING(
                    SqlDDL.text,
                    QrySytats.statement_start_offset/2,         
                    (CASE WHEN QrySytats.statement_end_offset = -1 
                        THEN len(CONVERT(nvarchar(MAX), SqlDDL.text)) * 2 
                        ELSE QrySytats.statement_end_offset 
                        END - QrySytats.statement_start_offset)/2) 
        ,SqlDDL.dbid
        ,dbname = db_name(SqlDDL.dbid)
        ,SqlDDL.objectid 
FROM sys.dm_exec_query_stats QrySytats
CROSS APPLY sys.dm_exec_sql_text(QrySytats.sql_handle) AS SqlDDL
ORDER BY QrySytats.execution_count DESC


--*************************************************************
--Find WORST executing queries
--*************************************************************
SELECT TOP 10
    total_worker_time/execution_count AS Avg_CPU_Time
        ,execution_count
        ,total_elapsed_time/execution_count as AVG_Run_Time
        ,(SELECT
              SUBSTRING(text,statement_start_offset/2,(CASE
                                                           WHEN statement_end_offset = -1 THEN LEN(CONVERT(nvarchar(max), text)) * 2 
                                                           ELSE statement_end_offset 
                                                       END -statement_start_offset)/2
                       ) FROM sys.dm_exec_sql_text(sql_handle)
         ) AS query_text 
FROM sys.dm_exec_query_stats 

--pick your criteria

ORDER BY Avg_CPU_Time DESC
--ORDER BY AVG_Run_Time DESC
--ORDER BY execution_count DESC