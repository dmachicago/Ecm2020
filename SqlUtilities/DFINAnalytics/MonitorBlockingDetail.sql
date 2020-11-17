
/*
REPLACED BY FindBlockingDetail.sql
*/
--* USEDFINAnalytics;
GO
-- drop table [dbo].[DFS_TranLocks]
IF EXISTS
(
    SELECT 1
    FROM   sys.tables
    WHERE  name = 'DFS_TranLocks'
)
	DROP TABLE [dbo].[DFS_TranLocks];


CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]   [INT] NOT NULL, 
     [DatabaseName]  [NVARCHAR](150) NULL, 
     [LockedObjectName]     [SYSNAME] NOT NULL, 
     [LockedObjectId]  [INT] NOT NULL, 
     [LockedResource]  [NVARCHAR](60) NOT NULL, 
     [LockType] [NVARCHAR](60) NOT NULL, 
     [SqlStatementText]     [NVARCHAR](MAX) NULL, 
     [LoginName]     [NVARCHAR](150) NOT NULL, 
     [HostName] [NVARCHAR](150) NULL, 
     [IsUserTransaction]    [BIT] NOT NULL, 
     [TransactionName] [NVARCHAR](32) NOT NULL, 
     [AuthenticationMethod] [NVARCHAR](40) NOT NULL, 
     RunID    INT NULL, 
     CreateDate DATETIME DEFAULT GETDATE(), 
	 [UID] uniqueidentifier default newid()
     --RowNbr   INT IDENTITY(1, 1)
    )
    ON [PRIMARY] ;

	CREATE INDEX pi_DFS_TranLocks ON DFS_TranLocks ([uid]);

GO

--* USEMASTER;
GO
-- Select top 20 * from DFS_TranLocks order by RowNbr desc
-- exec sp_DFS_MonitorLocks 
IF EXISTS
(
    SELECT 1
    FROM   sys.procedures
    WHERE  name = 'sp_DFS_MonitorLocks '
)
    DROP PROCEDURE sp_DFS_MonitorLocks;
GO

--* USEmaster;
go
-- exec sp_DFS_MonitorLocks
-- select top 20 * from [DFS_TranLocks] order by RowNbr desc;
IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = 'sp_DFS_MonitorLocks')
drop PROCEDURE sp_DFS_MonitorLocks;
go
CREATE PROCEDURE sp_DFS_MonitorLocks
AS
begin
     DECLARE @RunID INT;
     EXEC @RunID = dbo.UTIL_GetSeq;
     INSERT INTO dbo.[DFS_TranLocks]
     ([SPID], 
 [DatabaseName], 
 [LockedObjectName], 
 [LockedObjectId], 
 [LockedResource], 
 [LockType], 
 [SqlStatementText], 
 [LoginName], 
 [HostName], 
 [IsUserTransaction], 
 [TransactionName], 
 [AuthenticationMethod], 
 [RunID], 
 [CreateDate],
	  [UID]
     )
     SELECT LOCKS.request_session_id AS SPID, 
     DB_NAME(LOCKS.resource_database_id) AS DatabaseName, 
     OBJ.Name AS LockedObjectName, 
     P.object_id AS LockedObjectId, 
     LOCKS.resource_type AS LockedResource, 
     LOCKS.request_mode AS LockType, 
     ST.text AS SqlStatementText, 
     ES.login_name AS LoginName, 
     ES.host_name AS HostName, 
     SESSIONTX.is_user_transaction AS IsUserTransaction, 
     ATX.name AS TransactionName, 
     CN.auth_scheme AS AuthenticationMethod, 
     @RunID, 
     GETDATE(),
			newid()
     FROM   sys.dm_tran_locks LOCKS
     JOIN sys.partitions P
  ON P.hobt_id = LOCKS.resource_associated_entity_id
     JOIN sys.objects OBJ
  ON OBJ.object_id = P.object_id
     JOIN sys.dm_exec_sessions ES
  ON ES.session_id = LOCKS.request_session_id
     JOIN sys.dm_tran_session_transactions SESSIONTX
  ON ES.session_id = SESSIONTX.session_id
     JOIN sys.dm_tran_active_transactions ATX
  ON SESSIONTX.transaction_id = ATX.transaction_id
     JOIN sys.dm_exec_connections CN
  ON CN.session_id = ES.session_id
     CROSS APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
     WHERE  resource_database_id = DB_ID()
     ORDER BY LOCKS.request_session_id;

	 update dbo.[DFS_TranLocks] set RunID = @RunID, CreateDate = getdate() where RunID is null

     -- W. Dale Miller
     -- DMA, Limited
     -- Offered under GNU License
     -- July 26, 2016
end
