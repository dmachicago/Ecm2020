--* USEDFINAnalytics;
go
-- drop view view_SessionStatus
-- select top 100 * from sys.dm_exec_connections
-- select * from view_SessionStatus where SPID = 60

if exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'view_SessionStatus')
drop VIEW view_SessionStatus;
go
CREATE VIEW view_SessionStatus
AS
     SELECT S.Session_id AS [SPID], 
     S.STATUS, 
			SP.blocked,
			SP.waittime,
			SP.LastWaitType,
			S.cpu_time, 
     S.reads AS SessionReads, 
     S.writes AS SessionWrites, 
     S.total_elapsed_time, 
     C.num_reads AS ConnectionReads, 
     C.num_writes AS ConnectionWrites, 
     U.database_id, 
     U.user_objects_alloc_page_count, 
     U.user_objects_dealloc_page_count, 
     U.internal_objects_alloc_page_count, 
     U.internal_objects_dealloc_page_count, 
     SP.cmd AS CmdState, 
			db_name(SP.dbid) AS DBNAME,
			WT.[definition] AS LastWaitTypeDEF,
     st.[text] AS CmdSQL
     /*,p.[query_plan] */
     FROM   sys.dm_exec_sessions S
     JOIN sys.dm_exec_connections C
  ON C.session_id = S.session_id
     JOIN sys.dm_db_session_space_usage U
  ON U.session_id = S.session_id
     JOIN sys.sysprocesses SP
  ON SP.spid = S.session_id
     CROSS APPLY sys.dm_exec_sql_text(SP.sql_handle) st
	 left outer join [dbo].[DFS_WaitTypes] WT on SP.LastWaitType = WT.typecode
	 /*
	 SELECT TOP 100 * FROM  sys.dm_exec_sessions
	 SELECT TOP 100 * FROM  sys.sysprocesses
	 */
/*CROSS APPLY sys.dm_exec_query_plan(SP.sql_handle) p*/
