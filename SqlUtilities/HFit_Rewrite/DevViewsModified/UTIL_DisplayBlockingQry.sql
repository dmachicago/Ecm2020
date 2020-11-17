
print ('Processing: UTIL_DisplayBlockingQry ') ;
go


if exists(select name from sysobjects where name = 'UTIL_DisplayBlockingQry' and type = 'P')
BEGIN
	drop procedure UTIL_DisplayBlockingQry ;
END
GO



--*******************************************
--W. Dale Miller
--July 26, 2010
--*******************************************
create proc [dbo].[UTIL_DisplayBlockingQry]
as
SELECT
SYSDB.name DBName,
TLOCK.request_session_id,
TWAIT.blocking_session_id,
OBJECT_NAME(p.OBJECT_ID) BlockedObjectName,
TLOCK.resource_type,
h1.TEXT AS RequestingText,
h2.TEXT AS BlockingTest,
TLOCK.request_mode
FROM sys.dm_tran_locks AS TLOCK
INNER JOIN sys.databases SYSDB ON SYSDB.database_id = TLOCK.resource_database_id
INNER JOIN sys.dm_os_waiting_tasks AS TWAIT ON TLOCK.lock_owner_address = TWAIT.resource_address
INNER JOIN sys.partitions AS p ON p.hobt_id = TLOCK.resource_associated_entity_id
INNER JOIN sys.dm_exec_connections ec1 ON ec1.session_id = TLOCK.request_session_id
INNER JOIN sys.dm_exec_connections ec2 ON ec2.session_id = TWAIT.blocking_session_id
CROSS APPLY sys.dm_exec_sql_text(ec1.most_recent_sql_handle) AS h1
CROSS APPLY sys.dm_exec_sql_text(ec2.most_recent_sql_handle) AS h2

GO


