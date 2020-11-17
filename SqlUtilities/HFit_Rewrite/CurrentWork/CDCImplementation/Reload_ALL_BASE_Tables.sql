

print 'Executing Reload_ALL_BASE_Tables.sql'

 insert into MIGRATE_DataMart_Commands
select 'PRINT ''' + name  + ''''
+ char(10) + ' GO ' 
+ char(10) + 'print ''Start Time: '''
+ char(10) + ' print getdate()'
+ char(10) + ' GO ' 
+ char(10) + 'EXEC ' + name + ' 0,1;' 
+ char(10) + 'go'  
+ char(10) + 'print ''END Time: '''
+ char(10) + ' print getdate()'
+ char(10) + 'print ''***********************************************************'''
+ char(10) + ' GO ' 
from sys.procedures where name like '%_SYNC' 
and name like 'Proc_BASE_%'
union
select 'PRINT ''' + name  + ''''
+ char(10) + ' GO ' 
+ char(10) + 'print ''Start Time: '''
+ char(10) + ' print getdate()'
+ char(10) + ' GO ' 
+ char(10) + 'EXEC ' + name + ' 1;' 
+ char(10) + 'go'  
+ char(10) + 'print ''END Time: '''
+ char(10) + ' print getdate()'
+ char(10) + 'print ''***********************************************************'''
from sys.procedures where name like 'proc_CT_DIM_HFit_Tracker%'


