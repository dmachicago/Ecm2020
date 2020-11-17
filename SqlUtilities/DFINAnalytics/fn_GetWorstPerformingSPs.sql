
go
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetWorstPerformingSPs]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[fn_GetWorstPerformingSPs]
go

/*====================================================+========
-- Description:  Returns TOP N worst performing stored procedures	
-- 
   SELECT * FROM dbo.fn_GetWorstPerformingSPs(5, 'test', 30)	
====================================================+========*/
CREATE FUNCTION [dbo].[fn_GetWorstPerformingSPs] (
   @n SMALLINT = 10,
   @dbname SYSNAME = '%',
   @avg_time_threshhold INT = 0
	)
RETURNS TABLE
AS
RETURN (
   SELECT TOP (@n) 
      DB_NAME (database_id) AS DBName,
      OBJECT_SCHEMA_NAME (object_id, database_id) AS [Schema_Name],
      OBJECT_NAME (object_id, database_id) AS [Object_Name],
      total_elapsed_time / execution_count AS Avg_Elapsed_Time,
      (total_physical_reads + total_logical_reads) / execution_count AS Avg_Reads,
      execution_count AS Execution_Count,
      t.text AS Query_Text,
      H.query_plan AS Query_Plan
   FROM 
      sys.dm_exec_procedure_stats
      CROSS APPLY sys.dm_exec_sql_text(sql_handle) T
      CROSS APPLY sys.dm_exec_query_plan(plan_handle) H
   WHERE 
      LOWER(DB_NAME(database_id)) LIKE LOWER(@dbname) 
      AND total_elapsed_time / execution_count > @avg_time_threshhold 
      AND LOWER(DB_NAME (database_id)) NOT IN ('master','tempdb','model','msdb','resource')
   ORDER BY 
       avg_elapsed_time DESC
       )
GO

