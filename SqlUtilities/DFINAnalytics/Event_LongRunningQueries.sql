CREATE EVENT SESSION [LongRunningQueries] ON SERVER 
ADD EVENT sqlserver.blocked_process_report(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text)),
ADD EVENT sqlserver.degree_of_parallelism(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text)),
ADD EVENT sqlserver.lock_acquired(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text)
    WHERE (([package0].[greater_than_uint64]([database_id],(4))) AND ([package0].[equal_boolean]([sqlserver].[is_system],(0))))),
ADD EVENT sqlserver.lock_deadlock(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text)),
ADD EVENT sqlserver.lock_deadlock_chain(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text)),
ADD EVENT sqlserver.lock_timeout(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text)),
ADD EVENT sqlserver.locks_lock_waits(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text)),
ADD EVENT sqlserver.xml_deadlock_report(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_plan_hash,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.sql_text))
ADD TARGET package0.event_file(SET filename=N'c:\temp\LongRunningQueries'),
ADD TARGET package0.histogram(SET filtering_event_name=N'sqlserver.lock_acquired',source=N'sqlserver.query_hash')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=ON,STARTUP_STATE=ON)
GO


