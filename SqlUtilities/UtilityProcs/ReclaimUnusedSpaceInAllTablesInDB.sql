--reclaim the space from the table 
EXEC sp_msforeachtable 'DBCC CLEANTABLE(0, ''?'') '; 