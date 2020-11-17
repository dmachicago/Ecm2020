


-- drop table #TABLES

select 'BASE_'+table_name as BaseTable, table_name 
into #TABLES
from KenticoCMS_1.Information_Schema.tables
where table_Type = 'BASE TABLE'
order by table_name

select * from #TABLES
where BaseTable not in (select table_name from KenticoCMS_DataMart.Information_Schema.tables )
order by table_name
