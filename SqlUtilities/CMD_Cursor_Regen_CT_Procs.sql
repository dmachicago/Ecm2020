
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
	   SET @MySql = 'exec PrintImmediate ''Processing ' + @TBL +''';' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'if exists (select name from sys.tables where name = '''+ @TBL + ''')' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   SET @MySql = 'BEGIN'; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   set @MySQl = '   exec proc_genPullChangesProc ''KenticoCMS_1'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   set @MySQl = '   exec proc_genPullChangesProc ''KenticoCMS_2'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   set @MySQl = '   exec proc_genPullChangesProc ''KenticoCMS_3'', '''+@TBL+''', @DeBug=0, @GenProcOnlyDoNotPullData=1 ' ;
        INSERT INTO @T (stmt) VALUES (@MySQl) ;
	   SET @MySql = 'END '; 
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
