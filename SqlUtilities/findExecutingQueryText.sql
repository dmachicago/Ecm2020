SELECT sqltext.TEXT , 
       req.session_id , 
       req.status , 
       req.command , 
       req.cpu_time , 
       req.total_elapsed_time
  FROM
       sys.dm_exec_requests AS req CROSS APPLY sys.dm_exec_sql_text (sql_handle) AS sqltext;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
