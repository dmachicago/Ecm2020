
DECLARE
      @MySql AS nvarchar (max) = '',
      @cols AS nvarchar (max) = '',
      @DBNAME AS nvarchar (250) = 'KenticoCMS_2',
      @TBL AS nvarchar (250) = '';
DECLARE
      @T AS TABLE (stmt nvarchar (max) NULL) ;

DECLARE C CURSOR
    FOR SELECT DISTINCT table_NAME
          FROM INFORMATION_SCHEMA.tables
          WHERE table_name LIKE 'BASE_%'
            AND table_name NOT LIKE '%[_]DEL'
            AND table_name NOT LIKE '%[_]testdata'
		  AND table_name NOT LIKE '%[_]view[_]%'
            AND table_name NOT LIKE '%[_]CTVerHIST'
            AND TABLE_TYPE like 'BASE TABLE';
OPEN C;

FETCH NEXT FROM C INTO @TBL;

WHILE @@FETCH_STATUS = 0
    BEGIN
    declare @ProcName as nvarchar(500) = '' ;
	   set @ProcName = 'proc_'+@TBL+'_KenticoCMS_1_SYNC'
	   SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName +''';' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'if exists (select name from sys.procedures where name = '''+ @ProcName + ''')' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   set @MySQl = '     exec '+@ProcName + ' 0,0;' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   SET @MySql = 'GO'; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;

	    set @ProcName = 'proc_'+@TBL+'_KenticoCMS_2_SYNC'
	   SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName +''';' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'if exists (select name from sys.procedures where name = '''+ @ProcName + ''')' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   set @MySQl = '     exec '+@ProcName + ' 0,0;' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   SET @MySql = 'GO'; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;

	    set @ProcName = 'proc_'+@TBL+'_KenticoCMS_3_SYNC'
	   SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName +''';' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'if exists (select name from sys.procedures where name = '''+ @ProcName + ''')' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   set @MySQl = '     exec '+@ProcName + ' 0,0;' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   SET @MySql = 'GO'; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;

        FETCH NEXT FROM C INTO @TBL;
    END;

CLOSE C;
DEALLOCATE C; 

SELECT * FROM @T;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
