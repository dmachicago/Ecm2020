use DataMartPlatform;
go
declare @i int = 0 ;
declare @itot int = 0 ;
declare @icnt int = 0 ;
declare @msg nvarchar(1000) = '' ;

SET NOCOUNT ON  ;

set @itot = (select count(*) from information_schema.tables T
	join information_schema.columns C
	on T.table_name = C.table_name
	where column_name = 'dbname'
	and table_type <> 'view' and T.table_name like 'BASE[_]%' and t.table_name not like  'VIEW[_]%'
);
DECLARE @rowcount TABLE (Value int);

DECLARE db_cursor CURSOR FOR  
	select T.table_name from information_schema.tables T
	join information_schema.columns C
	on T.table_name = C.table_name
	where column_name = 'dbname'
	and table_type <> 'view' and T.table_name like 'BASE[_]%' and t.table_name not like  'VIEW[_]%'
	and t.table_name not like  'BASE_HFit_GoalOutcome%';

declare @name nvarchar(254) = null ;
declare @MySql nvarchar(2000) = null ;

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN   
	set @i = @i + 1 ;

    exec PrintImmediate '-------------------------------' ;
    set @msg = 'Processing '+@name+' : ' + cast(@i as nvarchar(50)) + ' of ' + cast(@itot as nvarchar(50)) ;
    exec PrintImmediate @msg ;

    delete from @rowcount ;
    INSERT INTO @rowcount       
    EXEC('SELECT COUNT(*) FROM dbo.' + @name + ' where DBNAME = ''KenticoCMS_1'' or DBNAME = ''KenticoCMS_3'' or DBNAME = ''KenticoCMS_3''' );
    set @iCnt = (select top 1 Value FROM @rowcount);
	
	set @msg = '#Rows to process: ' + cast(@iCnt as nvarchar(50)) ;
	exec PrintImmediate @msg ;

	if (@iCnt = 0)
	begin 	  
	   set @msg = 'SKIPPING: ' + @name ;
	   exec PrintImmediate @msg ;	
	end 
    else 
    begin
	set @msg = 'UPDATING: ' + @name ;
	exec PrintImmediate @msg ;
	   --set @msg = '#Rows to process: ' + cast(@iCnt as nvarchar(50)) ;
	   --exec PrintImmediate @msg ;
	   exec proc_DisableAllTableTriggers @name ;
	   BEGIN TRANSACTION;   
	   set @MySql = ' update '+@name+' set dbname = ''KenticoCMS_PRD_1'' where dbname = ''KenticoCMS_1'' ; '
	   exec (@MySql) ;
	   
	   set @MySql = ' update '+@name+' set dbname = ''KenticoCMS_PRD_2'' where dbname = ''KenticoCMS_2'' ; '
	   exec (@MySql) ;
	   
	   set @MySql = ' update '+@name+' set dbname = ''KenticoCMS_PRD_3'' where dbname = ''KenticoCMS_3'' ; '
	   exec (@MySql) ;
	   COMMIT TRANSACTION;   
	   exec proc_EnableAllTableTriggers @name  ;	
	end
	
    FETCH NEXT FROM db_cursor INTO @name   ;
END 

CLOSE db_cursor   
DEALLOCATE db_cursor

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
