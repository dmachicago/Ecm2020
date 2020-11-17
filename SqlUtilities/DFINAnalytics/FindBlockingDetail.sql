
--* USEDFINAnalytics;
GO
DECLARE @runnow INT= 0;
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_TxMonitorTableIndexStats'
)
   AND @runnow = 1
    BEGIN

 /*declare @RunID BIGINT = NEXT VALUE FOR master_seq;*/

 DECLARE @RunID BIGINT;
 EXEC @RunID = dbo.UTIL_GetSeq;
 PRINT @RunID;
 DECLARE @command VARCHAR(1000);
 --SELECT @command = '--* USE?; declare @DB as int = DB_ID() ; exec sp_DFS_MonitorLocks ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
		SELECT @command = 'declare @DB as int = DB_ID() ; exec sp_DFS_MonitorLocks ' + CAST(@RunID AS NVARCHAR(25)) + ' ;';
 EXEC sp_MSforeachdb @command;
END;
go
/* drop TABLE [dbo].[DFS_TranLocks]*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TranLocks'
)
drop TABLE [dbo].[DFS_TranLocks];

    CREATE TABLE [dbo].[DFS_TranLocks]
    ([SPID]   [INT] NOT NULL, 
     [SvrName]  [NVARCHAR](150) NULL, 
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
     [UID]    UNIQUEIDENTIFIER DEFAULT NEWID()
    )
    ON [PRIMARY];
GO

--* USEmaster 
go
/* Select * from DFS_TranLocks
DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT @RunID;
exec sp_DFS_MonitorLocks @RunID
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DFS_MonitorLocks '
)
    DROP PROCEDURE sp_DFS_MonitorLocks;
GO

/*
 exec [DFINAnalytics].dbo.sp_DFS_MonitorLocks -99
 select * from [dbo].[DFS_TranLocks]
 */
 
CREATE PROCEDURE sp_DFS_MonitorLocks (@RunID INT)
AS
    BEGIN

 INSERT INTO [dbo].[DFS_TranLocks]
 ( [SPID], 
   [SvrName], 
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
   @@SERVERNAME, 
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
   NEWID()
   FROM sys.dm_tran_locks LOCKS
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
   WHERE resource_database_id = DB_ID()
   ORDER BY LOCKS.request_session_id;

/* W. Dale Miller
  DMA, Limited
  Offered under GNU License
  July 26, 2016*/

    END;