--find size of all databases on a Server – Azure

select
       @@serverName as ServerName,
    db.name as DatabaseName,
       (select top 1 s.storage_in_megabytes from sys.resource_stats s where s.database_name = db.name order by s.start_time desc) as DatabaseMB
from
       sys.databases db 
order by db.name
 
 
-- DB Size and additional details including pool name 
select
       @@serverName as ServerName,
    db.name as DatabaseName, db.create_date, db.state_desc, 
   (select top 1 s.storage_in_megabytes from sys.resource_stats s where s.database_name = db.name order by s.start_time desc) as DatabaseMB
,do.edition, do.service_objective, do.elastic_pool_name
from
       sys.databases db JOIN sys.database_service_objectives do on db.database_id = do.database_id
order by db.name