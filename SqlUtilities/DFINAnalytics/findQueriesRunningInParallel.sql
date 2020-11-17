
/*
Check for possible issues caused by running in parallel.

W. Dale Miller
July 2017
DMA, Limited
*/

SELECT TOP 15 PLN.dbid, 
              PLN.objectid, 
              PLN.query_plan, 
              QRY.encrypted, 
              QRY.TEXT, 
              PLANCACHE.usecounts, 
              PLANCACHE.size_in_bytes, 
              PLANCACHE.plan_handle, 
              HASHBYTES('sha1', SUBSTRING(QRY.TEXT, 1, 4000)) AS SqlHash
FROM sys.dm_exec_cached_plans AS PLANCACHE
          CROSS APPLY sys.dm_exec_query_plan(PLANCACHE.plan_handle) AS PLN
               CROSS APPLY sys.dm_exec_sql_text(PLANCACHE.plan_handle) AS QRY
WHERE PLANCACHE.cacheobjtype = 'Compiled Plan'
      AND PLN.query_plan.value('declare namespace
PLN="http://schemas.microsoft.com/sqlserver/2004/07/showplan"; max(//PLN:RelOp/@Parallel)', 'float') > 0
ORDER BY usecounts DESC, 
         size_in_bytes DESC;
SELECT *
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255;