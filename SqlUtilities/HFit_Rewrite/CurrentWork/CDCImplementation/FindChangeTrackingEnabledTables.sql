select sys.schemas.name as Schema_name, sys.tables.name as Table_name from sys.change_tracking_tables
join sys.tables on sys.tables.object_id = sys.change_tracking_tables.object_id
join sys.schemas on sys.schemas.schema_id = sys.tables.schema_id
order by sys.tables.name