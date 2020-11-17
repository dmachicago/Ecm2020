
declare @MySql as nvarchar(max) = '' ;
declare @cols as nvarchar(max) = '' ;
declare @DBNAME as nvarchar(250) = 'KenticoCMS_2' ;
declare @CMD as nvarchar(250) = '' ;
declare @T as table (stmt nvarchar(max) null) ;

declare C cursor for
    SELECT distinct table_NAME
	   FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
	   WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
    OPEN C;

    FETCH NEXT FROM C INTO @CMD ;

 WHILE
           @@FETCH_STATUS = 0
       begin
	  set @cols = '' ;
		  select @cols =  @cols + ','+column_name FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
	   WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
	   AND TABLE_NAME = @CMD;

	   DECLARE @INAME AS NVARCHAR(250) = 'CI_DBPK_'+@CMD ;
	   IF exists (select name from DataMartPlatform.sys.indexes where name = @INAME) 
	   begin
		  SET @MySql = 'drop index ' + @INAME + ' ON base_' + @CMD ;
		  insert into @T (stmt) values (@MySQl) ;
		  -- exec (@MySql) ;
		  print 'Dropped ' + @INAME ;
	   end 
	   SET @cols = SUBSTRING(@cols,2,9999) ;
	   SET @MySql = 'if exists (select name from sys.tables where name = ''BASE_' + @CMD + ''') CREATE INDEX CI_DBPK_'+@CMD + ' ON BASE_' + @CMD +'('+ @cols + ') INCLUDE (dbname) ; ' + char(10) + 'GO';
	   insert into @T (stmt) values (@MySQl) ;
		  exec PrintImmediate @MySql
		  --exec @CMD ;
		  FETCH NEXT FROM C INTO @CMD ;
        END

close C;
deallocate C; 

select * from @T ;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
