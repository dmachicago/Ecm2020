
SELECT *
FROM msdb.dbo.sysmanagement_shared_server_groups_internal groups 
INNER JOIN msdb.dbo.sysmanagement_shared_registered_servers_internal svr
 ON groups.server_group_id = svr.server_group_id
 

 SELECT a.*  
FROM OPENROWSET('SQLNCLI', 'Server=ALIEN15;Trusted_Connection=yes;',  
     'SELECT name FROM sys.databases') AS a;  

SELECT a.*  
FROM OPENROWSET('SQLNCLI', 'Server=192.168.230.136;Trusted_Connection=no; userid=sa; password=Junebug1',  
     'SELECT name FROM sys.databases') AS a;  