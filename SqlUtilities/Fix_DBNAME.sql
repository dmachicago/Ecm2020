use datamartplatform ;
go
-- slect distinct DBNAME from base_CMS_User
go
DECLARE db_cursor CURSOR FOR  
	select T.table_name from information_schema.tables T
	join information_schema.columns C
	on T.table_name = C.table_name
	where column_name = 'dbname'
	and T.table_name like 'base_CMS_User' 
	--and table_type <> 'view' and T.table_name like 'BASE[_]VIEW%' and t.table_name not like  'VIEW[_]%';

declare @name nvarchar(254) = null ;
declare @MySql nvarchar(2000) = null ;

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN   
	exec PrintImmediate @name ;	
    exec proc_DisableAllTableTriggers @name ;
	BEGIN TRANSACTION;   
	set @MySql = ' update '+@name+' set dbname = ''KenticoCMS_PRD_1'' where dbname = ''KenticoCMS_1'' ; '
	exec (@MySql) ;
	COMMIT TRANSACTION;  
	BEGIN TRANSACTION;   
	set @MySql = ' update '+@name+' set dbname = ''KenticoCMS_PRD_2'' where dbname = ''KenticoCMS_2'' ; '
	exec (@MySql) ;
	COMMIT TRANSACTION;  
	BEGIN TRANSACTION;   
	set @MySql = ' update '+@name+' set dbname = ''KenticoCMS_PRD_3'' where dbname = ''KenticoCMS_3'' ; '
	exec (@MySql) ;
	COMMIT TRANSACTION;   
	exec proc_EnableAllTableTriggers @name  ;	
    FETCH NEXT FROM db_cursor INTO @name   ;
END 

CLOSE db_cursor   
DEALLOCATE db_cursor

/*
SELECT 
	'DROP TRIGGER ' + SO.name +';' as cmd 
FROM sysobjects SO
INNER JOIN sys.tables t 
    ON SO.parent_obj = t.object_id 
INNER JOIN sys.schemas s 
    ON t.schema_id = s.schema_id 
WHERE SO.type = 'TR' 
and OBJECTPROPERTY(id, 'ExecIsTriggerDisabled') = 1
*/
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
