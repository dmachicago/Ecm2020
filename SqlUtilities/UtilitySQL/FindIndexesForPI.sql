select OBJECT_NAME(object_id) AS tblName, name from sys.indexes where name like 'PI_%'
union
select OBJECT_NAME(object_id) AS tblName, name from sys.indexes where name like '%_PI'