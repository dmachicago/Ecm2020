

Use KenticoCMS_1
go

select 'ALTER DATABASE '+DB_NAME()+' SET CHANGE_TRACKING = ON  (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) ;' + char(10) + 'GO' as CMD
union
select 'ALTER TABLE dbo.' + sys.tables.name + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON); '  + char(10) + 'GO'  as cmd
from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id;


select 'ALTER TABLE dbo.' + sys.tables.name + ' DISABLE CHANGE_TRACKING; '  + char(10) + 'GO'  as cmd
from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id;