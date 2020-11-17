--Create the DISABLE Statements
select 'ALTER Index ' + name + 
	'ON ' + OBJECT_NAME(object_id) + ' DISABLE'	from sys.indexes where name like 'PI_%'
union
Select
'ALTER Index ' + name + 
	'ON ' + OBJECT_NAME(object_id) + ' DISABLE'	from sys.indexes where name like '%_PI'

--Create the ENABLE Statements
select 'ALTER Index ' + name + 
	'ON ' + OBJECT_NAME(object_id) + ' REBUILD'	from sys.indexes where name like 'PI_%'
union
Select
'ALTER Index ' + name + 
	'ON ' + OBJECT_NAME(object_id) + ' REBUILD'	from sys.indexes where name like '%_PI'