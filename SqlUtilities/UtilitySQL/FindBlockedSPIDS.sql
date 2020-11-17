exec sp_who2
exec sp_who

go
create proc UTIL_ListQryTextBySpid (@SPID int)
as
--Exec UTIL_ListQryBySpid 306  
--To see the last statement sent from a client to an SQL Server instance run: (for example for the blocking session ID)
DBCC INPUTBUFFER(@SPID )
GO
GRANT EXECUTE ON OBJECT::dbo.UTIL_ListQryTextBySpid TO public;
GO

create proc UTIL_ListCurrentRunningQueries
as
--Lists all currently running queries in SQL Server and their text
SELECT r.session_id,
	s.host_name,
	s.login_name,
	s.original_login_name,
	r.status,
	r.command,
	r.cpu_time,
	r.total_elapsed_time,
	t.text as Query_Text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
GO
GRANT EXECUTE ON OBJECT::dbo.UTIL_ListMostCommonWaits TO public;
GO
create proc UTIL_ListQueryAndBlocks
as
--Lists database name that requests are executing against and blocking session ID for blocked queries:
--exec UTIL_ListQueryAndBlocks
SELECT r.session_id,
	r.blocking_session_id,
	r.cpu_time,
	r.total_elapsed_time,
	DB_NAME(r.database_id) AS Database_Name,
	s.host_name,
	s.login_name,
	s.original_login_name,
	r.status,
	r.command,	
	t.text as Query_Text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
GO
GRANT EXECUTE ON OBJECT::dbo.UTIL_ListQueryAndBlocks TO public;
GO
create proc UTIL_ListBlocks
as
--Only running queries that are blocked and session ID of blocking queries:
SELECT r.session_id,
	r.blocking_session_id,
	DB_NAME(r.database_id) AS Database_Name,
	s.host_name,
	s.login_name,
	s.original_login_name,
	r.status,
	r.command,
	r.cpu_time,
	r.total_elapsed_time,
	t.text as Query_Text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(sql_handle) t
INNER JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
WHERE r.blocking_session_id <> 0
GO
GRANT EXECUTE ON OBJECT::dbo.UTIL_ListBlocks TO public;
GO

create proc UTIL_ListMostCommonWaits
as
--Display the top 10 most frequent WAITS occuring in the DB
select top 10 wait_type
	, wait_time_ms
	, Percentage = 100. * wait_time_ms/sum(wait_time_ms) OVER()
from sys.dm_os_wait_stats wt
where wt.wait_type NOT LIKE '%SLEEP%'
order by Percentage desc
GO
GRANT EXECUTE ON OBJECT::dbo.UTIL_ListMostCommonWaits TO public;