select 'ALTER TABLE ' +  table_name + ' ADD [UID] uniqueidentifier default newid() ; ' + char(10) + 'GO' from INFORMATION_SCHEMA.tables 
where table_name not in (
	select table_name from INFORMATION_SCHEMA.columns where column_name = 'UID'
)
and table_type = 'BASE TABLE'
and table_name like 'DFS_%'