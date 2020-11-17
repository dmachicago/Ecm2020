
use BNY_UATReleaseAR_Port;
go
SELECT 
@@SERVERNAME AS SvrName,
	db_NAME() as DBName,
    [TableName] = so.name, 
    [RowCount] = MAX(si.rows) 
FROM 
    sysobjects so, 
    sysindexes si 
WHERE 
    so.xtype = 'U' 
    AND 
    si.id = OBJECT_ID(so.name) 
group by so.name
having MAX(si.rows) > 1000
order by 3 desc
