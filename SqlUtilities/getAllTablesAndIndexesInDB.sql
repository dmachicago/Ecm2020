use AP_ProductionAF_Port
go
select DB_NAME() as [DBName], T.name as [Schema], T.name AS TblName, I.name as [Index] from sys.tables T
join sys.schemas S on S.schema_id = T.schema_id
join sys.indexes I on I.object_id = T.object_id