CREATE EVENT SESSION [FindBlockers] ON SERVER 
ADD EVENT sqlserver.lock_acquired(
    ACTION(sqlserver.database_id,sqlserver.plan_handle,sqlserver.session_id,sqlserver.sql_text,sqlserver.tsql_stack)
    WHERE ([database_id]=(9) AND [resource_0]<>(0))),
ADD EVENT sqlserver.lock_released(
    WHERE ([database_id]=(9) AND [resource_0]<>(0)))
ADD TARGET package0.pair_matching(SET begin_event=N'sqlserver.lock_acquired',begin_matching_columns=N'database_id, resource_0, resource_1, resource_2, transaction_id, mode',end_event=N'sqlserver.lock_released',end_matching_columns=N'database_id, resource_0, resource_1, resource_2, transaction_id, mode',respond_to_memory_pressure=(1))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=1 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


