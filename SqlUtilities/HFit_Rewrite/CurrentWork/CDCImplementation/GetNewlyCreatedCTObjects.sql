select (substring(table_name,CHARINDEX('_', table_name)+1,100)) as ROOTNAME,table_name,table_type 
from INFORMATION_SCHEMA.tables where table_name like '%_CT' and table_name like '%_EDW_%' and table_type = 'VIEW' --order by table_name
union
select (substring(table_name,CHARINDEX('_', table_name)+1,100)) as ROOTNAME,table_name,table_type  
from INFORMATION_SCHEMA.tables where table_name like 'STAGING_EDW%' and table_type = 'BASE TABLE' --order by table_name
union
select (substring(name,CHARINDEX('EDW_', name),100)) as ROOTNAME,name,'STORED PROC' 
from sys.procedures where name like '%STAGING_EDW%' --order by name
order by ROOTNAME

SELECT [name] FROM msdb.dbo.sysjobs where name like '%GetStagingData%' order by name