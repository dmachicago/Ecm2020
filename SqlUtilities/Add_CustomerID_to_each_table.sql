
-- select TABLE_CATALOG + char(13) + char(10) + TABLE_NAME + char(13) + char(10) + 'GO' from INFORMATION_SCHEMA.TABLES

select 
'if not exists(' + char(10) +
'    select 1 from information_schema.columns ' +  char(10) +
'    where TABLE_CATALOG = '''+TABLE_CATALOG+'''' +   char(10)+
'    and TABLE_SCHEMA='''+TABLE_SCHEMA+''' ' +   char(10)+
'    and TABLE_NAME='''+TABLE_NAME+''''+   char(10)+
'    and COLUMN_NAME=''CustID''' +   char(10)+
')' +   char(10) +
'ALTER TABLE ['+TABLE_CATALOG+'].dbo.['+TABLE_NAME+'] add [CustID] int null ;' +  char(10) +'GO'+char(10)
from INFORMATION_SCHEMA.TABLES
where TABLE_CATALOG not in ('master','model','msdb','tempdb', 'ReportServer', 'ReportServerTempDB')
and TABLE_NAME not in ('database_firewall_rules')