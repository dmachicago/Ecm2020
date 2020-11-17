
--* USEDFINAnalytics;
GO
-- truncate table DFS_WaitTypes
-- select count(*) from DFS_WaitTypes
IF NOT EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_WaitTypes'
)
    BEGIN
 CREATE TABLE DFS_WaitTypes
 (typecode   NVARCHAR(50) NOT NULL, 
  definition NVARCHAR(MAX) NOT NULL,
 );
 CREATE INDEX pk_DFS_WaitTypes ON DFS_WaitTypes(typecode);
END;
GO
SET NOCOUNT ON;

truncate table DFS_WaitTypes;

INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ABR', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AM_INDBUILD_ALLOCATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AM_SCHEMAMGR_UNSHARED_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASSEMBLY_FILTER_HASHTABLE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASSEMBLY_LOAD', 
 'Occurs during exclusive access to assembly loading.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_DISKPOOL_LOCK', 
 'Occurs when there is an attempt to synchronize parallel threads that are performing tasks such as creating or initializing a file.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_IO_COMPLETION', 
 'Occurs when a task is waiting for I/Os to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_NETWORK_IO', 
 'Occurs on network writes when the task is blocked behind the network. Verify that the client is processing data from the server.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_COMPLETION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_CONTEXT_READ', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_OP_CONTEXT_WRITE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ASYNC_SOCKETDUP_IO', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_GROUPCACHE_LOCK', 
 'Occurs when there is a wait on a lock that controls access to a special cache. The cache contains information about which audits are being used to audit each audit action group.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_LOGINCACHE_LOCK', 
 'Occurs when there is a wait on a lock that controls access to a special cache. The cache contains information about which audits are being used to audit login audit action groups.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_ON_DEMAND_TARGET_LOCK', 
 'Occurs when there is a wait on a lock that is used to ensure single initialization of audit related Extended Event targets.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('AUDIT_XE_SESSION_MGR', 
 'Occurs when there is a wait on a lock that is used to synchronize the starting and stopping of audit related Extended Events sessions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUP', 
 'Occurs when a task is blocked as part of backup processing.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUP_OPERATOR', 
 'Occurs when a task is waiting for a tape mount. To view the tape status, query sys.dm_io_backup_tapes. If a mount operation is not pending, this wait type may indicate a hardware problem with the tape drive.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPBUFFER', 
 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a tape mount.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPIO', 
 'Occurs when a backup task is waiting for data, or is waiting for a buffer in which to store data. This type is not typical, except when a task is waiting for a tape mount.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BACKUPTHREAD', 
 'Occurs when a task is waiting for a backup task to finish. Wait times may be long, from several minutes to several hours. If the task that is being waited on is in an I/O process, this type does not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BAD_PAGE_PROCESS', 
 'Occurs when the background suspect page logger is trying to avoid running more than every five seconds. Excessive suspect pages cause the logger to run frequently.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BLOB_METADATA', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPALLOCATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPBUILD', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPREPARTITION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BMPREPLICATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BPSORT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_CONNECTION_RECEIVE_TASK', 
 'Occurs when waiting for access to receive a message on a connection endpoint. Receive access to the endpoint is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_DISPATCHER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_ENDPOINT_STATE_MUTEX', 
 'Occurs when there is contention to access the state of a Service Broker connection endpoint. Access to the state for changes is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_EVENTHANDLER', 
 'Occurs when a task is waiting in the primary event handler of the Service Broker. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_FORWARDER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_INIT', 
 'Occurs when initializing Service Broker in each active database. This should occur infrequently.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_MASTERSTART', 
 'Occurs when a task is waiting for the primary event handler of the Service Broker to start. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_RECEIVE_WAITFOR', 
 'Occurs when the RECEIVE WAITFOR is waiting. This may mean that either no messages are ready to be received in the queue or a lock contention is preventing it from receiving messages from the queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_REGISTERALLENDPOINTS', 
 'Occurs during the initialization of a Service Broker connection endpoint. This should occur very briefly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_SERVICE', 
 'Occurs when the Service Broker destination list that is associated with a target service is updated or re-prioritized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_SHUTDOWN', 
 'Occurs when there is a planned shutdown of Service Broker. This should occur very briefly, if at all.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_START', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_STOP', 
 'Occurs when the Service Broker queue task handler tries to shut down the task. The state check is serialized and must be in a running state beforehand.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TASK_SUBMIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TO_FLUSH', 
 'Occurs when the Service Broker lazy flusher flushes the in-memory transmission objects to a work table.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_OBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_TABLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMISSION_WORK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BROKER_TRANSMITTER', 
 'Occurs when the Service Broker transmitter is waiting for work. Service Broker has a component known as the Transmitter which schedules messages from multiple dialogs to be sent across the wire over one or more connection endpoints. The transmitter has 2 dedicated threads for this purpose. This wait type is charged when these transmitter threads are waiting for dialog messages to be sent using the transport connections. High values of waiting_tasks_count for this wait type point to intermittent work for these transmitter threads and are not indications of any performance problem. If service broker is not used at all, waiting_tasks_count should be 2 (for the 2 transmitter threads) and wait_time_ms should be twice the duration since instance startup. See Service broker wait stats.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('BUILTIN_HASHKEY_MUTEX', 
 'May occur after startup of instance, while internal data structures are initializing. Will not recur once data structures have initialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHANGE_TRACKING_WAITFORCHANGES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_PRINT_RECORD', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_SCANNER_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_INITIALIZATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_SINGLE_SCAN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECK_TABLES_THREAD_BARRIER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHECKPOINT_QUEUE', 
 'Occurs while the checkpoint task is waiting for the next checkpoint request.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CHKPT', 
 'Occurs at server startup to tell the checkpoint thread that it can start.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLEAR_DB', 
 'Occurs during operations that change the state of a database, such as opening or closing a database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_AUTO_EVENT', 
 'Occurs when a task is currently performing common language runtime (CLR) execution and is waiting for a particular autoevent to be initiated. Long waits are typical, and do not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_CRST', 
 'Occurs when a task is currently performing CLR execution and is waiting to enter a critical section of the task that is currently being used by another task.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_JOIN', 
 'Occurs when a task is currently performing CLR execution and waiting for another task to end. This wait state occurs when there is a join between tasks.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MANUAL_EVENT', 
 'Occurs when a task is currently performing CLR execution and is waiting for a specific manual event to be initiated.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MEMORY_SPY', 
 'Occurs during a wait on lock acquisition for a data structure that is used to record all virtual memory allocations that come from CLR. The data structure is locked to maintain its integrity if there is parallel access.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_MONITOR', 
 'Occurs when a task is currently performing CLR execution and is waiting to obtain a lock on the monitor.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_RWLOCK_READER', 
 'Occurs when a task is currently performing CLR execution and is waiting for a reader lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_RWLOCK_WRITER', 
 'Occurs when a task is currently performing CLR execution and is waiting for a writer lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_SEMAPHORE', 
 'Occurs when a task is currently performing CLR execution and is waiting for a semaphore.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLR_TASK_START', 
 'Occurs while waiting for a CLR task to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CLRHOST_STATE_ACCESS', 
 'Occurs where there is a wait to acquire exclusive access to the CLR-hosting data structures. This wait type occurs while setting up or tearing down the CLR runtime.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CMEMPARTITIONED', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CMEMTHREAD', 
 'Occurs when a task is waiting on a thread-safe memory object. The wait time might increase when there is contention caused by multiple tasks trying to allocate memory from the same memory object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COLUMNSTORE_BUILD_THROTTLE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COLUMNSTORE_COLUMNDATASET_SESSION_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COMMIT_TABLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CONNECTION_ENDPOINT_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('COUNTRECOVERYMGR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CREATE_DATINISERVICE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXCONSUMER', 
 'Occurs with parallel query plans when a consumer thread waits for a producer thread to send rows. This is a normal part of parallel query execution.: Applies to: SQL Server (Starting with SQL Server 2016 (13.x) SP2, SQL Server 2017 (14.x) CU3), SQL Database'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXPACKET', 
 'Occurs with parallel query plans when synchronizing the query processor exchange iterator, and when producing and consuming rows. If waiting is excessive and cannot be reduced by tuning the query (such as adding indexes), consider adjusting the cost threshold for parallelism or lowering the degree of parallelism.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('CXROWSET_SYNC', 
 'Occurs during a parallel range scan.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DAC_INIT', 
 'Occurs while the dedicated administrator connection is initializing.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBCC_SCALE_OUT_EXPR_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_DBM_EVENT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_DBM_MUTEX', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_EVENTS_QUEUE', 
 'Occurs when database mirroring waits for events to process.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_SEND', 
 'Occurs when a task is waiting for a communications backlog at the network layer to clear to be able to send messages. Indicates that the communications layer is starting to become overloaded and affect the database mirroring data throughput.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRROR_WORKER_QUEUE', 
 'Indicates that the database mirroring worker task is waiting for more work.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBMIRRORING_CMD', 
 'Occurs when a task is waiting for log records to be flushed to disk. This wait state is expected to be held for long periods of time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBSEEDING_FLOWCONTROL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DBSEEDING_OPERATION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEADLOCK_ENUM_MUTEX', 
 'Occurs when the deadlock monitor and sys.dm_os_waiting_tasks try to make sure that SQL Server is not running multiple deadlock searches at the same time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEADLOCK_TASK_SEARCH', 
 'Large waiting time on this resource indicates that the server is executing queries on top of sys.dm_os_waiting_tasks, and these queries are blocking deadlock monitor from running deadlock search. This wait type is used by deadlock monitor only. Queries on top of sys.dm_os_waiting_tasks --* USEDEADLOCK_ENUM_MUTEX.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DEBUG', 
 'Occurs during Transact-SQL and CLR debugging for internal synchronization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRECTLOGCONSUMER_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_POLL', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DIRTY_PAGE_TABLE_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISABLE_VERSIONING', 
 'Occurs when SQL Server polls the version transaction manager to see whether the timestamp of the earliest active transaction is later than the timestamp of when the state started changing. If this is this case, all the snapshot transactions that were started before the ALTER DATABASE statement was run have finished. This wait state is used when SQL Server disables versioning by using the ALTER DATABASE statement.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISKIO_SUSPEND', 
 'Occurs when a task is waiting to access a file when an external backup is active. This is reported for each waiting user process. A count larger than five per user process may indicate that the external backup is taking too much time to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISPATCHER_PRIORITY_QUEUE_SEMAPHORE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DISPATCHER_QUEUE_SEMAPHORE', 
 'Occurs when a thread from the dispatcher pool is waiting for more work to process. The wait time for this wait type is expected to increase when the dispatcher is idle.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DLL_LOADING_MUTEX', 
 'Occurs once while waiting for the XML parser DLL to load.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DPT_ENTRY_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DROP_DATABASE_TIMER_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DROPTEMP', 
 'Occurs between attempts to drop a temporary object if the previous attempt failed. The wait duration grows exponentially with each failed drop attempt.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC', 
 'Occurs when a task is waiting on an event that is used to manage state transition. This state controls when the recovery of Microsoft Distributed Transaction Coordinator (MS DTC) transactions occurs after SQL Server receives notification that the MS DTC service has become unavailable.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_ABORT_REQUEST', 
 'Occurs in a MS DTC worker session when the session is waiting to take ownership of a MS DTC transaction. After MS DTC owns the transaction, the session can roll back the transaction. Generally, the session will wait for another session that is using the transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_RESOLVE', 
 'Occurs when a recovery task is waiting for the master database in a cross-database transaction so that the task can query the outcome of the transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_STATE', 
 'Occurs when a task is waiting on an event that protects changes to the internal MS DTC global state object. This state should be held for very short periods of time.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_TMDOWN_REQUEST', 
 'Occurs in a MS DTC worker session when SQL Server receives notification that the MS DTC service is not available. First, the worker will wait for the MS DTC recovery process to start. Then, the worker waits to obtain the outcome of the distributed transaction that the worker is working on. This may continue until the connection with the MS DTC service has been reestablished.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTC_WAITFOR_OUTCOME', 
 'Occurs when recovery tasks wait for MS DTC to become active to enable the resolution of prepared transactions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_ENLIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_PREPARE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_TM', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCNEW_TRANSACTION_ENLISTMENT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DTCPNTSYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMP_LOG_COORDINATOR', 
 'Occurs when a main task is waiting for a subtask to generate data. Ordinarily, this state does not occur. A long wait indicates an unexpected blockage. The subtask should be investigated.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMP_LOG_COORDINATOR_QUEUE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('DUMPTRIGGER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EC', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EE_PMOLOCK', 
 'Occurs during synchronization of certain types of memory allocations during statement execution.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EE_SPECPROC_MAP_INIT', 
 'Occurs during synchronization of internal procedure hash table creation. This wait can only occur during the initial accessing of the hash table after the SQL Server instance starts.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ENABLE_EMPTY_VERSIONING', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ENABLE_VERSIONING', 
 'Occurs when SQL Server waits for all update transactions in this database to finish before declaring the database ready to transition to snapshot isolation allowed state. This state is used when SQL Server enables snapshot isolation by using the ALTER DATABASE statement.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ERROR_REPORTING_MANAGER', 
 'Occurs during synchronization of multiple concurrent error log initializations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXCHANGE', 
 'Occurs during synchronization in the query processor exchange iterator during parallel queries.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXECSYNC', 
 'Occurs during parallel queries while synchronizing in query processor in areas not related to the exchange iterator. Examples of such areas are bitmaps, large binary objects (LOBs), and the spool iterator. LOBs may frequently --* USEthis wait state.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXECUTION_PIPE_EVENT_INTERNAL', 
 'Occurs during synchronization between producer and consumer parts of batch execution that are submitted through the connection context.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_RG_UPDATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_NETWORK_IO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through current.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_PREPARE_SERVICE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_SCRIPT_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('EXTERNAL_WAIT_ON_LAUNCHER,', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_HADR_TRANSPORT_CONNECTION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_CONTROLLER_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_CONTROLLER_STATE_AND_CONFIG', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_PUBLISHER_EVENT_PUBLISH', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_REPLICA_PUBLISHER_SUBSCRIBER_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FABRIC_WAIT_FOR_BUILD_REPLICA_EVENT_PROCESSING', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FAILPOINT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FCB_REPLICA_READ', 
 'Occurs when the reads of a snapshot (or a temporary snapshot created by DBCC) sparse file are synchronized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FCB_REPLICA_WRITE', 
 'Occurs when the pushing or pulling of a page to a snapshot (or a temporary snapshot created by DBCC) sparse file is synchronized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FEATURE_SWITCHES_UPDATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_DB_KILL_FLAG', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_DB_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_FIND', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_PARENT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_RELEASE_CACHED_ENTRIES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FCB_STATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_FILEOBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NSO_TABLE_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_NTFS_STORE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RECOVERY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RSFX_COMM', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_RSFX_WAIT_FOR_MEMORY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STARTUP_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_DB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_ROWSET_LIST', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FFT_STORE_TABLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILE_VALIDATION_THREADS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CHUNKER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_CHUNKER_INIT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_FCB', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_FILE_OBJECT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILESTREAM_WORKITEM_QUEUE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FILETABLE_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FOREIGN_REDO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through current.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FORWARDER_TRANSITION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_FC_RWLOCK', 
 'Occurs when there is a wait by the FILESTREAM garbage collector to do either of the following:'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_GARBAGE_COLLECTOR_SHUTDOWN', 
 'Occurs when the FILESTREAM garbage collector is waiting for cleanup tasks to be completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_HEADER_RWLOCK', 
 'Occurs when there is a wait to acquire access to the FILESTREAM header of a FILESTREAM data container to either read or update contents in the FILESTREAM header file (Filestream.hdr).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FS_LOGTRUNC_RWLOCK', 
 'Occurs when there is a wait to acquire access to FILESTREAM log truncation to do either of the following:'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSA_FORCE_OWN_XACT', 
 'Occurs when a FILESTREAM file I/O operation needs to bind to the associated transaction, but the transaction is currently owned by another session.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSAGENT', 
 'Occurs when a FILESTREAM file I/O operation is waiting for a FILESTREAM agent resource that is being used by another file I/O operation.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSTR_CONFIG_MUTEX', 
 'Occurs when there is a wait for another FILESTREAM feature reconfiguration to be completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FSTR_CONFIG_RWLOCK', 
 'Occurs when there is a wait to serialize access to the FILESTREAM configuration parameters.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_COMPROWSET_RWLOCK', 
 'Full-text is waiting on fragment metadata operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTS_RWLOCK', 
 'Full-text is waiting on internal synchronization. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTS_SCHEDULER_IDLE_WAIT', 
 'Full-text scheduler sleep wait type. The scheduler is idle.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTSHC_MUTEX', 
 'Full-text is waiting on an fdhost control operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_IFTSISM_MUTEX', 
 'Full-text is waiting on communication operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_MASTER_MERGE', 
 'Full-text is waiting on master merge operation. Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_MASTER_MERGE_COORDINATOR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_METADATA_MUTEX', 
 'Documented for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_PROPERTYLIST_CACHE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FT_RESTART_CRAWL', 
 'Occurs when a full-text crawl needs to restart from a last known good point to recover from a transient failure. The wait lets the worker tasks currently working on that population to complete or exit the current step.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('FULLTEXT GATHERER', 
 'Occurs during synchronization of full-text operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GDMA_GET_RESOURCE_OWNER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GHOSTCLEANUP_UPDATE_STATS', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GHOSTCLEANUPSYNCMGR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CANCEL', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CLOSE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_CONSUMER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_QUERY_PRODUCER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_TRAN_CREATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GLOBAL_TRAN_UCS_SESSION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('GUARDIAN', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AG_MUTEX', 
 'Occurs when an Always On DDL statement or Windows Server Failover Clustering command is waiting for exclusive read/write access to the configuration of an availability group.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_CRITICAL_SECTION_ENTRY', 
 'Occurs when an Always On DDL statement or Windows Server Failover Clustering command is waiting for exclusive read/write access to the runtime state of the local replica of the associated availability group.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_MANAGER_MUTEX', 
 'Occurs when an availability replica shutdown is waiting for startup to complete or an availability replica startup is waiting for shutdown to complete. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_AR_UNLOAD_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_ARCONTROLLER_NOTIFICATIONS_SUBSCRIBER_LIST', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the list of event subscribers. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_BACKUP_BULK_LOCK', 
 'The Always On primary database received a backup request from a secondary database and is waiting for the background thread to finish processing the request on acquiring or releasing the BulkOp lock.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_BACKUP_QUEUE', 
 'The backup background thread of the Always On primary database is waiting for a new work request from the secondary database. (typically, this occurs when the primary database is holding the BulkOp log and is waiting for the secondary database to indicate that the primary database can release the lock).,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_CLUSAPI_CALL', 
 'A SQL Server thread is waiting to switch from non-preemptive mode (scheduled by SQL Server) to preemptive mode (scheduled by the operating system) in order to invoke Windows Server Failover Clustering APIs.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_COMPRESSED_CACHE_SYNC', 
 'Waiting for access to the cache of compressed log blocks that is used to avoid redundant compression of the log blocks sent to multiple secondary databases.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_CONNECTIVITY_INFO', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_FLOW_CONTROL', 
 'Waiting for messages to be sent to the partner when the maximum number of queued messages has been reached. Indicates that the log scans are running faster than the network sends. This is an issue only if network sends are slower than expected.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_VERSIONING_STATE', 
 'Occurs on the versioning state change of an Always On secondary database. This wait is for internal data structures and is usually is very short with no direct effect on data access.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_RESTART', 
 'Waiting for the database to restart under Always On Availability Groups control. Under normal conditions, this is not a customer issue because waits are expected here.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DATABASE_WAIT_FOR_TRANSITION_TO_VERSIONING', 
 'A query on object(s) in a readable secondary database of an Always On availability group is blocked on row versioning while waiting for commit or rollback of all transactions that were in-flight when the secondary replica was enabled for read workloads. This wait type guarantees that row versions are available before execution of a query under snapshot isolation.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_COMMAND', 
 'Waiting for responses to conversational messages (which require an explicit response from the other side, using the Always On conversational message infrastructure). A number of different message types --* USEthis wait type.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_OP_COMPLETION_SYNC', 
 'Waiting for responses to conversational messages (which require an explicit response from the other side, using the Always On conversational message infrastructure). A number of different message types --* USEthis wait type.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DB_OP_START_SYNC', 
 'An Always On DDL statement or a Windows Server Failover Clustering command is waiting for serialized access to an availability database and its runtime state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBR_SUBSCRIBER', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the runtime state of an event subscriber that corresponds to an availability database. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBR_SUBSCRIBER_FILTER_LIST', 
 'The publisher for an availability replica event (such as a state change or configuration change) is waiting for exclusive read/write access to the list of event subscribers that correspond to availability databases. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSEEDING', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSEEDING_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_DBSTATECHANGE_SYNC', 
 'Concurrency control wait for updating the internal state of the database replica.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FABRIC_CALLBACK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_BLOCK_FLUSH', 
 'The FILESTREAM Always On transport manager is waiting until processing of a log block is finished.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_FILE_CLOSE', 
 'The FILESTREAM Always On transport manager is waiting until the next FILESTREAM file gets processed and its handle gets closed.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_FILE_REQUEST', 
 'An Always On secondary replica is waiting for the primary replica to send all requested FILESTREAM files during UNDO.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_IOMGR', 
 'The FILESTREAM Always On transport manager is waiting for R/W lock that protects the FILESTREAM Always On I/O manager during startup or shutdown.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_IOMGR_IOCOMPLETION', 
 'The FILESTREAM Always On I/O manager is waiting for I/O completion.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_MANAGER', 
 'The FILESTREAM Always On transport manager is waiting for the R/W lock that protects the FILESTREAM Always On transport manager during startup or shutdown.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_FILESTREAM_PREPROC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_GROUP_COMMIT', 
 'Transaction commit processing is waiting to allow a group commit so that multiple commit log records can be put into a single log block. This wait is an expected condition that optimizes the log I/O, capture, and send operations.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGCAPTURE_SYNC', 
 'Concurrency control around the log capture or apply object when creating or destroying scans. This is an expected wait when partners change state or connection status.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGCAPTURE_WAIT', 
 'Waiting for log records to become available. Can occur either when waiting for new log records to be generated by connections or for I/O completion when reading log not in the cache. This is an expected wait if the log scan is caught up to the end of log or is reading from disk.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_LOGPROGRESS_SYNC', 
 'Concurrency control wait when updating the log progress status of database replicas.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_DEQUEUE', 
 'A background task that processes Windows Server Failover Clustering notifications is waiting for the next notification. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_EXCLUSIVE_ACCESS', 
 'The Always On availability replica manager is waiting for serialized access to the runtime state of a background task that processes Windows Server Failover Clustering notifications. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_STARTUP_SYNC', 
 'A background task is waiting for the completion of the startup of a background task that processes Windows Server Failover Clustering notifications. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_NOTIFICATION_WORKER_TERMINATION_SYNC', 
 'A background task is waiting for the termination of a background task that processes Windows Server Failover Clustering notifications. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_PARTNER_SYNC', 
 'Concurrency control wait on the partner list.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_READ_ALL_NETWORKS', 
 'Waiting to get read or write access to the list of WSFC networks. Internal --* USEonly. Note: The engine keeps a list of WSFC networks that is used in dynamic management views (such as sys.dm_hadr_cluster_networks) or to validate Always On Transact-SQL statements that reference WSFC network information. This list is updated upon engine startup, WSFC related notifications, and internal Always On restart (for example, losing and regaining of WSFC quorum). Tasks will usually be blocked when an update in that list is in progress. ,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_RECOVERY_WAIT_FOR_CONNECTION', 
 'Waiting for the secondary database to connect to the primary database before running recovery. This is an expected wait, which can lengthen if the connection to the primary is slow to establish.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_RECOVERY_WAIT_FOR_UNDO', 
 'Database recovery is waiting for the secondary database to finish the reverting and initializing phase to bring it back to the common log point with the primary database. This is an expected wait after failovers.Undo progress can be tracked through the Windows System Monitor (perfmon.exe) and dynamic management views.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_REPLICAINFO_SYNC', 
 'Waiting for concurrency control to update the current replica state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_CANCELLATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_FILE_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_LIMIT_BACKUPS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_SYNC_COMPLETION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_TIMEOUT_TASK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SEEDING_WAIT_FOR_COMPLETION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SYNC_COMMIT', 
 'Waiting for transaction commit processing for the synchronized secondary databases to harden the log. This wait is also reflected by the Transaction Delay performance counter. This wait type is expected for synchronized availability groups and indicates the time to send, write, and acknowledge log to the secondary databases.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_SYNCHRONIZING_THROTTLE', 
 'Waiting for transaction commit processing to allow a synchronizing secondary database to catch up to the primary end of log in order to transition to the synchronized state. This is an expected wait when a secondary database is catching up.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TDS_LISTENER_SYNC', 
 'Either the internal Always On system or the WSFC cluster will request that listeners are started or stopped. The processing of this request is always asynchronous, and there is a mechanism to remove redundant requests. There are also moments that this process is suspended because of configuration changes. All waits related with this listener synchronization mechanism --* USEthis wait type. Internal --* USEonly.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TDS_LISTENER_SYNC_PROCESSING', 
 'Used at the end of an Always On Transact-SQL statement that requires starting and/or stopping anavailability group listener. Since the start/stop operation is done asynchronously, the user thread will block using this wait type until the situation of the listener is known.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_LOG_SIZE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_SEEDING', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_THROTTLE_LOG_RATE_SEND_RECV_QUEUE_SIZE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TIMER_TASK', 
 'Waiting to get the lock on the timer task object and is also used for the actual waits between times that work is being performed. For example, for a task that runs every 10 seconds, after one execution, Always On Availability Groups waits about 10 seconds to reschedule the task, and the wait is included here.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_DBRLIST', 
 'Waiting for access to the transport layer`s database replica list. Used for the spinlock that grants access to it.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_FLOW_CONTROL', 
 'Waiting when the number of outstanding unacknowledged Always On messages is over the out flow control threshold. This is on an availability replica-to-replica basis (not on a database-to-database basis).,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_TRANSPORT_SESSION', 
 'Always On Availability Groups is waiting while changing or accessing the underlying transport state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_WORK_POOL', 
 'Concurrency control wait on the Always On Availability Groups background work task object.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_WORK_QUEUE', 
 'Always On Availability Groups background worker thread waiting for new work to be assigned. This is an expected wait when there are ready workers waiting for new work, which is the normal state.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HADR_XRF_STACK_ACCESS', 
 'Accessing (look up, add, and delete) the extended recovery fork stack for an Always On availability database.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HCCO_CACHE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HK_RESTORE_FILEMAP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HKCS_PARALLEL_MIGRATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HKCS_PARALLEL_RECOVERY', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTBUILD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTDELETE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTMEMO', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTREINIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTREPARTITION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_ENUMERATION', 
 'Occurs at startup to enumerate the HTTP endpoints to start HTTP.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_START', 
 'Occurs when a connection is waiting for HTTP to complete initialization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('HTTP_STORAGE_CONNECTION', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IMPPROV_IOWAIT', 
 'Occurs when SQL Server waits for a bulkload I/O to finish.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('INSTANCE_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('INTERNAL_TESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_AUDIT_MUTEX', 
 'Occurs during synchronization of trace event buffers.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_COMPLETION', 
 'Occurs while waiting for I/O operations to complete. This wait type generally represents non-data page I/Os. Data page I/O completion waits appear as PAGEIOLATCH_* waits.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_QUEUE_LIMIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IO_RETRY', 
 'Occurs when an I/O operation such as a read or a write to disk fails because of insufficient resources, and is then retried.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('IOAFF_RANGE_QUEUE', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KSOURCE_WAKEUP', 
 'Used by the service control task while waiting for requests from the Service Control Manager. Long waits are expected and do not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_ENLISTMENT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_RECOVERY_MANAGER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('KTM_RECOVERY_RESOLUTION', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_DT', 
 'Occurs when waiting for a DT (destroy) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_EX', 
 'Occurs when waiting for an EX (exclusive) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_KP', 
 'Occurs when waiting for a KP (keep) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_SH', 
 'Occurs when waiting for an SH (share) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LATCH_UP', 
 'Occurs when waiting for an UP (update) latch. This does not include buffer latches or transaction mark latches. A listing of LATCH_* waits is available in sys.dm_os_latch_stats. Note that sys.dm_os_latch_stats groups LATCH_NL, LATCH_SH, LATCH_UP, LATCH_EX, and LATCH_DT waits together.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LAZYWRITER_SLEEP', 
 'Occurs when lazywriter tasks are suspended. This is a measure of the time spent by background tasks that are waiting. Do not consider this state when you are looking for user stalls.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_BU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Bulk Update (BU) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IS_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Shared (IS) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Update (IU) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_IX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Intent Exclusive (IX) lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL', 
 'Occurs when a task is waiting to acquire a NULL lock on the current key value, and an Insert Range lock between the current and previous key. A NULL lock on the key is an instant release lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a NULL lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. A NULL lock on the key is an instant release lock. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_NL_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a NULL lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. A NULL lock on the key is an instant release lock. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S', 
 'Occurs when a task is waiting to acquire a shared lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a shared lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a shared lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U', 
 'Task is waiting to acquire an Update lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U_ABORT_BLOCKERS', 
 'Task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_U_LOW_PRIORITY', 
 'Task is waiting to acquire an Update lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock on the current key value, and an Insert Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers on the current key value, and an Insert Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RIn_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority on the current key value, and an Insert Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S', 
 'Occurs when a task is waiting to acquire a Shared lock on the current key value, and a Shared Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers on the current key value, and a Shared Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority on the current key value, and a Shared Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U', 
 'Occurs when a task is waiting to acquire an Update lock on the current key value, and an Update Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Update Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RS_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority on the current key value, and an Update Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S', 
 'Occurs when a task is waiting to acquire a Shared lock on the current key value, and an Exclusive Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers on the current key value, and an Exclusive Range with Abort Blockers lock between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority on the current key value, and an Exclusive Range with Low Priority lock between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U', 
 'Occurs when a task is waiting to acquire an Update lock on the current key value, and an Exclusive range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers on the current key value, and an Exclusive range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority on the current key value, and an Exclusive range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock on the current key value, and an Exclusive Range lock between the current and previous key.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers on the current key value, and an Exclusive Range lock with Abort Blockers between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_RX_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority on the current key value, and an Exclusive Range lock with Low Priority between the current and previous key. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S', 
 'Occurs when a task is waiting to acquire a Shared lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M', 
 'Occurs when a task is waiting to acquire a Schema Modify lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Schema Modify lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_M_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Schema Modify lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S', 
 'Occurs when a task is waiting to acquire a Schema Share lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Schema Share lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SCH_S_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Schema Share lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIU_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared With Intent Update lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_SIX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire a Shared With Intent Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U', 
 'Occurs when a task is waiting to acquire an Update lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_U_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_UIX_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Update With Intent Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X', 
 'Occurs when a task is waiting to acquire an Exclusive lock.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X_ABORT_BLOCKERS', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Abort Blockers. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LCK_M_X_LOW_PRIORITY', 
 'Occurs when a task is waiting to acquire an Exclusive lock with Low Priority. (Related to the low priority wait option of ALTER TABLE and ALTER INDEX.),: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOG_POOL_SCAN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGBUFFER', 
 'Occurs when a task is waiting for space in the log buffer to store a log record. Consistently high values may indicate that the log devices cannot keep up with the amount of log being generated by the server.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGCAPTURE_LOGPOOLTRUNCPOINT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGGENERATION', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR', 
 'Occurs when a task is waiting for any outstanding log I/Os to finish before shutting down the log while closing the database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_FLUSH', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_PMM_LOG', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_QUEUE', 
 'Occurs while the log writer task waits for work requests.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGMGR_RESERVE_APPEND', 
 'Occurs when a task is waiting to see whether log truncation frees up log space to enable the task to write a new log record. Consider increasing the size of the log file(s) for the affected database to reduce this wait.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CACHESIZE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CONSUMER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_CONSUMERSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_FREEPOOLS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_MGRSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOL_REPLACEMENTSET', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOGPOOLREFCOUNTEDOBJECT_REFDONE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('LOWFAIL_MEMMGR_QUEUE', 
 'Occurs while waiting for memory to be available for use.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MD_AGENT_YIELD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MD_LAZYCACHE_RWLOCK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MEMORY_ALLOCATION_EXT', 
 'Occurs while allocating memory from either the internal SQL Server memory pool or the operation system.,: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MEMORY_GRANT_UPDATE', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('METADATA_LAZYCACHE_RWLOCK', 
 'TBD: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MIGRATIONBUFFER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MISCELLANEOUS', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MISCELLANEOUS', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_DQ', 
 'Occurs when a task is waiting for a distributed query operation to finish. This is used to detect potential Multiple Active Result Set (MARS) application deadlocks. The wait ends when the distributed query call finishes.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XACT_MGR_MUTEX', 
 'Occurs when a task is waiting to obtain ownership of the session transaction manager to perform a session level transaction operation.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XACT_MUTEX', 
 'Occurs during synchronization of transaction usage. A request must acquire the mutex before it can --* USEthe transaction.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSQL_XP', 
 'Occurs when a task is waiting for an extended stored procedure to end. SQL Server uses this wait state to detect potential MARS application deadlocks. The wait stops when the extended stored procedure call ends.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('MSSEARCH', 
 'Occurs during Full-Text Search calls. This wait ends when the full-text operation completes. It does not indicate contention, but rather the duration of full-text operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NET_WAITFOR_PACKET', 
 'Occurs when a connection is waiting for a network packet during a network read.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NETWORKSXMLMGRLOAD', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('NODE_CACHE_MUTEX', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('OLEDB', 
 'Occurs when SQL Server calls the SQL Server Native Client OLE DB Provider. This wait type is not used for synchronization. Instead, it indicates the duration of calls to the OLE DB provider.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ONDEMAND_TASK_QUEUE', 
 'Occurs while a background task waits for high priority system task requests. Long wait times indicate that there have been no high priority requests to process, and should not cause concern.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_DT', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Destroy mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_EX', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Exclusive mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_KP', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Keep mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_SH', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Shared mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGEIOLATCH_UP', 
 'Occurs when a task is waiting on a latch for a buffer that is in an I/O request. The latch request is in Update mode. Long waits may indicate problems with the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_DT', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Destroy mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_EX', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Exclusive mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_KP', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Keep mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_NL', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_SH', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Shared mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PAGELATCH_UP', 
 'Occurs when a task is waiting on a latch for a buffer that is not in an I/O request. The latch request is in Update mode.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_BACKUP_QUEUE', 
 'Occurs when serializing output produced by RESTORE HEADERONLY, RESTORE FILELISTONLY, or RESTORE LABELONLY.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_DRAIN_WORKER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_FLOW_CONTROL', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_LOG_CACHE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_TRAN_LIST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_TRAN_TURN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_WORKER_SYNC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PARALLEL_REDO_WORKER_WAIT_WORK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PERFORMANCE_COUNTERS_RWLOCK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PHYSICAL_SEEDING_DMV', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('POOL_LOG_RATE_GOVERNOR', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ABR', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_AUDIT_ACCESS_EVENTLOG', 
 'Occurs when the SQL Server Operating System (SQLOS) scheduler switches to preemptive mode to write an audit event to the Windows event log.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_AUDIT_ACCESS_SECLOG', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to write an audit event to the Windows Security log.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPMEDIA', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close backup media.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPTAPE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close a tape backup device.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLOSEBACKUPVDIDEVICE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to close a virtual backup device.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CLUSAPI_CLUSTERRESOURCECONTROL', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to perform Windows failover cluster operations.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_COCREATEINSTANCE', 
 'Occurs when the SQLOS scheduler switches to preemptive mode to create a COM object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_COGETCLASSOBJECT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_CREATEACCESSOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_DELETEROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETCOMMANDTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETNEXTROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETRESULT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_GETROWSBYBOOKMARK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBFLUSH', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBREADAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBSETSIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBSTAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBUNLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_LBWRITEAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_QUERYINTERFACE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASEACCESSOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASEROWS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RELEASESESSION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_RESTARTPOSITION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SEQSTRMREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SEQSTRMREADANDWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETDATAFAILURE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETPARAMETERINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_SETPARAMETERPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSEEKANDREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSEEKANDWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSETSIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMSTAT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_COM_STRMUNLOCKREGION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CONSOLEWRITE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_CREATEPARAM', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DEBUG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSADDLINK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSLINKEXISTCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSLINKHEALTHCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSREMOVELINK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSREMOVEROOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTFOLDERCHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DFSROOTSHARECHECK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ABORT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ABORTREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_BEGINTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_COMMITREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_ENLIST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_DTC_PREPAREREQUESTDONE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FILESIZEGET', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_ABORTTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_COMMITTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSAOLEDB_STARTTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_FSRECOVER_UNCONDITIONALUNDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_GETRMINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HADR_LEASE_MECHANISM', 
 'Always On Availability Groups lease manager scheduling for CSS diagnostics.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HTTP_EVENT_WAIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_HTTP_REQUEST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_LOCKMONITOR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_MSS_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ODBCOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLE_UNINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_ABORTORCOMMITTRAN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_ABORTTRAN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETDATASOURCE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETLITERALINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETPROPERTYINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_GETSCHEMALOCK', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_JOINTRANSACTION', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_RELEASE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDB_SETPROPERTIES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OLEDBOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ACCEPTSECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ACQUIRECREDENTIALSHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHENTICATIONOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHORIZATIONOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZGETINFORMATIONFROMCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZINITIALIZECONTEXTFROMSID', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_AUTHZINITIALIZERESOURCEMANAGER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_BACKUPREAD', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CLOSEHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CLUSTEROPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COMOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COMPLETEAUTHTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_COPYFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CREATEDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CREATEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTACQUIRECONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTIMPORTKEY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_CRYPTOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DECRYPTMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DELETEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DELETESECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DEVICEIOCONTROL', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DEVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DIRSVC_NETWORKOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DISCONNECTNAMEDPIPE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DOMAINSERVICESOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DSGETDCNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_DTCOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_ENCRYPTMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FILEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FINDFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FLUSHFILEBUFFERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FORMATMESSAGE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FREECREDENTIALSHANDLE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_FREELIBRARY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GENERICOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETADDRINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETCOMPRESSEDFILESIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETDISKFREESPACE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFILEATTRIBUTES', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFILESIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETFINALFILEPATHBYHANDLE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETLONGPATHNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETPROCADDRESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETVOLUMENAMEFORVOLUMEMOUNTPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_GETVOLUMEPATHNAME', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_INITIALIZESECURITYCONTEXT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LIBRARYOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOADLIBRARY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOGONUSER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_LOOKUPACCOUNTSID', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_MESSAGEQUEUEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_MOVEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETGROUPGETUSERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETLOCALGROUPGETMEMBERS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERGETGROUPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERGETLOCALGROUPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETUSERMODALSGET', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_NETVALIDATEPASSWORDPOLICYFREE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_OPENDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PDH_WMI_INIT', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PIPEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_PROCESSOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYCONTEXTATTRIBUTES', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYREGISTRY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_QUERYSECURITYCONTEXTTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REMOVEDIRECTORY', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REPORTEVENT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_REVERTTOSELF', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_RSFXDEVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SECURITYOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SERVICEOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETENDOFFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETFILEPOINTER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETFILEVALIDDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SETNAMEDSECURITYINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SQLCLROPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_SQMLAUNCH', 
 'TBD: Applies to: SQL Server 2008 R2 through SQL Server 2016 (13.x).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VERIFYSIGNATURE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VERIFYTRUST', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_VSSOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WAITFORSINGLEOBJECT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WINSOCKOPS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WRITEFILE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WRITEFILEGATHER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_OS_WSASETLASTERROR', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_REENLIST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_RESIZELOG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ROLLFORWARDREDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_ROLLFORWARDUNDO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SB_STOPENDPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SERVER_STARTUP', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SETRMINFO', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SHAREDMEM_GETDATA', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SNIOPEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SOSHOST', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SOSTESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_SP_SERVER_DIAGNOSTICS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STARTRM', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STREAMFCB_CHECKPOINT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STREAMFCB_RECOVER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_STRESSDRIVER', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_TESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_TRANSIMPORT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_UNMARSHALPROPAGATIONTOKEN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_VSS_CREATESNAPSHOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_VSS_CREATEVOLUMESNAPSHOT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CALLBACKEXECUTE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CX_FILE_OPEN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_CX_HTTP_CALL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_DISPATCHER', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_ENGINEINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_GETTARGETSTATE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_SESSIONCOMMIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TARGETFINALIZE', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TARGETINIT', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XE_TIMERRUN', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PREEMPTIVE_XETESTING', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PRINT_ROLLBACK_PROGRESS', 
 'Used to wait while user processes are ended in a database that has been transitioned by using the ALTER DATABASE termination clause. For more information, see ALTER DATABASE (Transact-SQL).'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PRU_ROLLBACK_DEFERRED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_ALL_COMPONENTS_INITIALIZED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_COOP_SCAN', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_DIRECTLOGCONSUMER_GETNEXT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_EVENT_SESSION_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_FABRIC_REPLICA_CONTROLLER_DATA_LOSS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_ACTION_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_CHANGE_NOTIFIER_TERMINATION_SYNC', 
 'Occurs when a background task is waiting for the termination of the background task that receives (via polling) Windows Server Failover Clustering notifications.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_CLUSTER_INTEGRATION', 
 'An append, replace, and/or remove operation is waiting to grab a write lock on an Always On internal list (such as a list of networks, network addresses, or availability group listeners). Internal --* USEonly,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_FAILOVER_COMPLETED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_JOIN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_OFFLINE_COMPLETED', 
 'An Always On drop availability group operation is waiting for the target availability group to go offline before destroying Windows Server Failover Clustering objects.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_ONLINE_COMPLETED', 
 'An Always On create or failover availability group operation is waiting for the target availability group to come online.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_POST_ONLINE_COMPLETED', 
 'An Always On drop availability group operation is waiting for the termination of any background task that was scheduled as part of a previous command. For example, there may be a background task that is transitioning availability databases to the primary role. The DROP AVAILABILITY GROUP DDL must wait for this background task to terminate in order to avoid race conditions.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_SERVER_READY_CONNECTIONS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADR_WORKITEM_COMPLETED', 
 'Internal wait by a thread waiting for an async work task to complete. This is an expected wait and is for CSS use.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_HADRSIM', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_LOG_CONSOLIDATION_IO', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_LOG_CONSOLIDATION_POLL', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_LOGIN_STATS', 
 'Occurs during internal synchronization in metadata on login stats.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_RELATION_CACHE', 
 'Occurs during internal synchronization in metadata on table or index.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_SERVER_CACHE', 
 'Occurs during internal synchronization in metadata on linked servers.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_MD_UPGRADE_CONFIG', 
 'Occurs during internal synchronization in upgrading server wide configurations.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_PREEMPTIVE_APP_USAGE_TIMER', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_PREEMPTIVE_AUDIT_ACCESS_WINDOWSLOG', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_QRY_BPMEMORY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_REPLICA_ONLINE_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_RESOURCE_SEMAPHORE_FT_PARALLEL_QUERY_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_SBS_FILE_OPERATION', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_XTP_FSSTORAGE_MAINTENANCE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('PWAIT_XTP_HOST_STORAGE_WAIT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_CHECK_CONSISTENCY_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_PERSIST_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_PERSIST_TASK_START', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_ASYNC_QUEUE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_BCKG_TASK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_BLOOM_FILTER', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_CTXS', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_DB_DISK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_DYN_VECTOR', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_EXCLUSIVE_ACCESS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_HOST_INIT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_LOADDB', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_PERSIST_TASK_MAIN_LOOP_SLEEP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_QDS_CAPTURE_INIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_SHUTDOWN_QUEUE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_STMT', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_STMT_DISK', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_TASK_SHUTDOWN', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QDS_TASK_START', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QE_WARN_LIST_SYNC', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QPJOB_KILL', 
 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL as the update was starting to run. The terminating thread is suspended, waiting for it to start listening for KILL commands. A good value is less than one second.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QPJOB_WAITFOR_ABORT', 
 'Indicates that an asynchronous automatic statistics update was canceled by a call to KILL when it was running. The update has now completed but is suspended until the terminating thread message coordination is complete. This is an ordinary but rare state, and should be very short. A good value is less than one second.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_MEM_GRANT_INFO_MUTEX', 
 'Occurs when Query Execution memory management tries to control access to static grant information list. This state lists information about the current granted and waiting memory requests. This state is a simple access control state. There should never be a long wait on this state. If this mutex is not released, all new memory-using queries will stop responding.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_PARALLEL_THREAD_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QRY_PROFILE_LIST_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_ERRHDL_SERVICE_DONE', 
 'Identified for informational purposes only. Not supported.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_WAIT_ERRHDL_SERVICE', 
 'Identified for informational purposes only. Not supported.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_EXECUTION_INDEX_SORT_EVENT_OPEN', 
 'Occurs in certain cases when offline create index build is run in parallel, and the different worker threads that are sorting synchronize access to the sort files.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_MGR_MUTEX', 
 'Occurs during synchronization of the garbage collection queue in the Query Notification Manager.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_SUBSCRIPTION_MUTEX', 
 'Occurs during state synchronization for transactions in Query Notifications.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_TABLE_MGR_MUTEX', 
 'Occurs during internal synchronization within the Query Notification Manager.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_NOTIFICATION_UNITTEST_MUTEX', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_OPTIMIZER_PRINT_MUTEX', 
 'Occurs during synchronization of query optimizer diagnostic output production. This wait type only occurs if diagnostic settings have been enabled under direction of Microsoft Product Support.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_TASK_ENQUEUE_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('QUERY_TRACEOUT', 
 'Identified for informational purposes only. Not supported. Future compatibility is not guaranteed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RBIO_WAIT_VLF', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RECOVER_CHANGEDB', 
 'Occurs during synchronization of database status in warm standby database.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RECOVERY_MGR_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REDO_THREAD_PENDING_WORK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REDO_THREAD_SYNC', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_BLOCK_IO', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_MIGRATION_DMV', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_SCHEMA_DMV', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REMOTE_DATA_ARCHIVE_SCHEMA_TASK_QUEUE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_CACHE_ACCESS', 
 'Occurs during synchronization on a replication article cache. During these waits, the replication log reader stalls, and data definition language (DDL) statements on a published table are blocked.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_HISTORYCACHE_ACCESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_SCHEMA_ACCESS', 
 'Occurs during synchronization of replication schema version information. This state exists when DDL statements are executed on the replicated object, and when the log reader builds or consumes versioned schema based on DDL occurrence. Contention can be seen on this wait type if you have many published databases on a single publisher with transactional replication and the published databases are very active.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANFSINFO_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANHASHTABLE_ACCESS', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPL_TRANTEXTINFO_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REPLICA_WRITES', 
 'Occurs while a task waits for completion of page writes to database snapshots or DBCC replicas.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REQUEST_DISPENSER_PAUSE', 
 'Occurs when a task is waiting for all outstanding I/O to complete, so that I/O to a file can be frozen for snapshot backup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('REQUEST_FOR_DEADLOCK_SEARCH', 
 'Occurs while the deadlock monitor waits to start the next deadlock search. This wait is expected between deadlock detections, and lengthy total waiting time on this resource does not indicate a problem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESERVED_MEMORY_ALLOCATION_EXT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESMGR_THROTTLED', 
 'Occurs when a new request comes in and is throttled based on the GROUP_MAX_REQUESTS setting.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_GOVERNOR_IDLE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_QUEUE', 
 'Occurs during synchronization of various internal resource queues.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE', 
 'Occurs when a query memory request cannot be granted immediately due to other concurrent queries. High waits and wait times may indicate excessive number of concurrent queries, or excessive memory request amounts.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_MUTEX', 
 'Occurs while a query waits for its request for a thread reservation to be fulfilled. It also occurs when synchronizing query compile and memory grant requests.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_QUERY_COMPILE', 
 'Occurs when the number of concurrent query compilations reaches a throttling limit. High waits and wait times may indicate excessive compilations, recompiles, or uncachable plans.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESOURCE_SEMAPHORE_SMALL_QUERY', 
 'Occurs when memory request by a small query cannot be granted immediately due to other concurrent queries. Wait time should not exceed more than a few seconds, because the server transfers the request to the main query memory pool if it fails to grant the requested memory within a few seconds. High waits may indicate an excessive number of concurrent small queries while the main memory pool is blocked by waiting queries.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESTORE_FILEHANDLECACHE_ENTRYLOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RESTORE_FILEHANDLECACHE_LOCK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RG_RECONFIG', 
 'TBD'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ROWGROUP_OP_STATS', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('ROWGROUP_VERSION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('RTDATA_LIST', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_CARGO', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_SERVICE_SETUP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SATELLITE_TASK', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_DISPATCH', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_RECEIVE_TRANSPORT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SBS_TRANSPORT', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SCAN_CHAR_HASH_ARRAY_INITIALIZATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEC_DROP_TEMP_KEY', 
 'Occurs after a failed attempt to drop a temporary security key before a retry attempt.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_CNG_PROVIDER_MUTEX', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_CRYPTO_CONTEXT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_DBE_STATE_MUTEX', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_KEYRING_RWLOCK', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_MUTEX', 
 'Occurs when there is a wait for mutexes that control access to the global list of Extensible Key Management (EKM) cryptographic providers and the session-scoped list of EKM sessions.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SECURITY_RULETABLE_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEMPLAT_DSI_BUILD', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEQUENCE_GENERATION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SEQUENTIAL_GUID', 
 'Occurs while a new sequential GUID is being obtained.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SERVER_IDLE_CHECK', 
 'Occurs during synchronization of SQL Server instance idle status when a resource monitor is attempting to declare a SQL Server instance as idle or trying to wake up.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SERVER_RECONFIGURE', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SESSION_WAIT_STATS_CHILDREN', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SHARED_DELTASTORE_CREATION', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SHUTDOWN', 
 'Occurs while a shutdown statement waits for active connections to exit.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_BPOOL_FLUSH', 
 'Occurs when a checkpoint is throttling the issuance of new I/Os in order to avoid flooding the disk subsystem.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_BUFFERPOOL_HELPLW', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_DBSTARTUP', 
 'Occurs during database startup while waiting for all databases to recover.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_DCOMSTARTUP', 
 'Occurs once at most during SQL Server instance startup while waiting for DCOM initialization to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERDBREADY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERMDREADY', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MASTERUPGRADED', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MEMORYPOOL_ALLOCATEPAGES', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_MSDBSTARTUP', 
 'Occurs when SQL Trace waits for the msdb database to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_RETRY_VIRTUALALLOC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_SYSTEMTASK', 
 'Occurs during the start of a background task while waiting for tempdb to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_TASK', 
 'Occurs when a task sleeps while waiting for a generic event to occur.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_TEMPDBSTARTUP', 
 'Occurs while a task waits for tempdb to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLEEP_WORKSPACE_ALLOCATEPAGE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SLO_UPDATE', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SMSYNC', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_CONN_DUP', 
 'TBD: Applies to: SQL Server 2014 (12.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_CRITICAL_SECTION', 
 'Occurs during internal synchronization within SQL Server networking components.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_HTTP_WAITFOR_0_DISCON', 
 'Occurs during SQL Server shutdown, while waiting for outstanding HTTP connections to exit.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_LISTENER_ACCESS', 
 'Occurs while waiting for non-uniform memory access (NUMA) nodes to update state change. Access to state change is serialized.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_TASK_COMPLETION', 
 'Occurs when there is a wait for all tasks to finish during a NUMA node state change.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SNI_WRITE_ASYNC', 
 'TBD: Applies to: SQL Server 2017 (14.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOAP_READ', 
 'Occurs while waiting for an HTTP network read to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOAP_WRITE', 
 'Occurs while waiting for an HTTP network write to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOCKETDUPLICATEQUEUE_CLEANUP', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_CALLBACK_REMOVAL', 
 'Occurs while performing synchronization on a callback list in order to remove a callback. It is not expected for this counter to change after server initialization is completed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_DISPATCHER_MUTEX', 
 'Occurs during internal synchronization of the dispatcher pool. This includes when the pool is being adjusted.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_LOCALALLOCATORLIST', 
 'Occurs during internal synchronization in the SQL Server memory manager.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_MEMORY_TOPLEVELBLOCKALLOCATOR', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_MEMORY_USAGE_ADJUSTMENT', 
 'Occurs when memory usage is being adjusted among pools.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_OBJECT_STORE_DESTROY_MUTEX', 
 'Occurs during internal synchronization in memory pools when destroying objects from the pool.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_PHYS_PAGE_CACHE', 
 'Accounts for the time a thread waits to acquire the mutex it must acquire before it allocates physical pages or before it returns those pages to the operating system. Waits on this type only appear if the instance of SQL Server uses AWE memory.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_PROCESS_AFFINITY_MUTEX', 
 'Occurs during synchronizing of access to process affinity settings.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_RESERVEDMEMBLOCKLIST', 
 'Occurs during internal synchronization in the SQL Server memory manager.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SCHEDULER_YIELD', 
 'Occurs when a task voluntarily yields the scheduler for other tasks to execute. During this wait the task is waiting for its quantum to be renewed.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SMALL_PAGE_ALLOC', 
 'Occurs during the allocation and freeing of memory that is managed by some memory objects.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_STACKSTORE_INIT_MUTEX', 
 'Occurs during synchronization of internal store initialization.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_SYNC_TASK_ENQUEUE_EVENT', 
 'Occurs when a task is started in a synchronous manner. Most tasks in SQL Server are started in an asynchronous manner, in which control returns to the starter immediately after the task request has been placed on the work queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOS_VIRTUALMEMORY_LOW', 
 'Occurs when a memory allocation waits for a resource manager to free up virtual memory.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_EVENT', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server event synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_INTERNAL', 
 'Occurs during synchronization of memory manager callbacks used by hosted components, such as CLR.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_MUTEX', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server mutex synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_RWLOCK', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server reader-writer synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_SEMAPHORE', 
 'Occurs when a hosted component, such as CLR, waits on a SQL Server semaphore synchronization object.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_SLEEP', 
 'Occurs when a hosted task sleeps while waiting for a generic event to occur. Hosted tasks are used by hosted components such as CLR.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_TRACELOCK', 
 'Occurs during synchronization of access to trace streams.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SOSHOST_WAITFORDONE', 
 'Occurs when a hosted component, such as CLR, waits for a task to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_PREEMPTIVE_SERVER_DIAGNOSTICS_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_BUFFER_ACCESS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_INIT_MUTEX', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SP_SERVER_DIAGNOSTICS_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_APPDOMAIN', 
 'Occurs while CLR waits for an application domain to complete startup.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_ASSEMBLY', 
 'Occurs while waiting for access to the loaded assembly list in the appdomain.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_DEADLOCK_DETECTION', 
 'Occurs while CLR waits for deadlock detection to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLCLR_QUANTUM_PUNISHMENT', 
 'Occurs when a CLR task is throttled because it has exceeded its execution quantum. This throttling is done in order to reduce the effect of this resource-intensive task on other tasks.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLSORT_NORMMUTEX', 
 'Occurs during internal synchronization, while initializing internal sorting structures.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLSORT_SORTMUTEX', 
 'Occurs during internal synchronization, while initializing internal sorting structures.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_BUFFER_FLUSH', 
 'Occurs when a task is waiting for a background task to flush trace buffers to disk every four seconds.: Applies to: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_BUFFER', 
 'Occurs during synchronization on trace buffers during a file trace.,: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_READ_IO_COMPLETION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_FILE_WRITE_IO_COMPLETION', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_INCREMENTAL_FLUSH_SLEEP', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_LOCK', 
 'TBD: APPLIES TO: SQL Server 2008 R2 only.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_PENDING_BUFFER_WRITERS', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_SHUTDOWN', 
 'Occurs while trace shutdown waits for outstanding trace events to complete.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SQLTRACE_WAIT_ENTRIES', 
 'Occurs while a SQL Trace event queue waits for packets to arrive on the queue.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('SRVPROC_SHUTDOWN', 
 'Occurs while the shutdown process waits for internal resources to be released to shutdown cleanly.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('STARTUP_DEPENDENCY_MANAGER', 
 'TBD: Applies to: SQL Server 2012 (11.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('TDS_BANDWIDTH_STATE', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
INSERT INTO DFS_WaitTypes
(typecode, 
 [definition]
)
VALUES
('TDS_INIT', 
 'TBD: Applies to: SQL Server 2016 (13.x) through SQL Server 2017.'
);
SET NOCOUNT OFF;PRINT '--- "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"' 
PRINT '--- "D:\dev\SQL\DFINAnalytics\create_DFS_WaitTypes_TableAndPopulate.sql"' 
