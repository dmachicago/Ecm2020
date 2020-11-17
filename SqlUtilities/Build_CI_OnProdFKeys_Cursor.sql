
DECLARE
      @T AS TABLE (stmt nvarchar (max) NULL);

DECLARE
      @MySql AS nvarchar (max) = '',
      @cols AS nvarchar (max) = '',
      @DBNAME AS nvarchar (250) = 'KenticoCMS_1',
      @CMD AS nvarchar (250) = '',
      @ParentTable AS nvarchar (250),
      @ParentColumn AS nvarchar (250),
      @ParentSchema AS nvarchar (250),
      @ChildTable AS nvarchar (250),
      @ChildColumn AS nvarchar (250),
      @ChildSchema AS nvarchar (250) = '';

DECLARE C CURSOR
    FOR SELECT PKTABLE_NAME = CONVERT (sysname , O1.NAME) , 
               PKCOLUMN_NAME = CONVERT (sysname , C1.NAME) , 
               PKTABLE_OWNER = CONVERT (sysname , SCHEMA_NAME (O1.SCHEMA_ID)) , 
               FKTABLE_NAME = CONVERT (sysname , O2.NAME) , 
               FKCOLUMN_NAME = CONVERT (sysname , C2.NAME) , 
               FKTABLE_OWNER = CONVERT (sysname , SCHEMA_NAME (O2.SCHEMA_ID))
          FROM SYS.ALL_OBJECTS AS O1 , SYS.ALL_OBJECTS AS O2 , SYS.ALL_COLUMNS AS C1 , SYS.ALL_COLUMNS AS C2 ,
               SYS.FOREIGN_KEYS AS F
               INNER JOIN SYS.FOREIGN_KEY_COLUMNS AS K
               ON K.CONSTRAINT_OBJECT_ID = F.OBJECT_ID
               INNER JOIN SYS.INDEXES AS I
               ON F.REFERENCED_OBJECT_ID = I.OBJECT_ID
              AND F.KEY_INDEX_ID = I.INDEX_ID
          WHERE O1.OBJECT_ID = F.REFERENCED_OBJECT_ID
            AND O2.OBJECT_ID = F.PARENT_OBJECT_ID
            AND C1.OBJECT_ID = F.REFERENCED_OBJECT_ID
            AND C2.OBJECT_ID = F.PARENT_OBJECT_ID
            AND C1.COLUMN_ID = K.REFERENCED_COLUMN_ID
            AND C2.COLUMN_ID = K.PARENT_COLUMN_ID
          ORDER BY O1.NAME, O2.NAME ;
OPEN C;

FETCH NEXT FROM C INTO @ParentTable , @ParentColumn , @ParentSchema , @ChildTable , @ChildColumn , @ChildSchema;

WHILE @@FETCH_STATUS = 0
    BEGIN

	   SET @MySql = 'exec PrintImmediate ''Processing table ' + @ParentTable + ' : ' + @ParentColumn + ''';' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'if exists (select name from sys.tables where name = ''BASE_' + @ParentTable + ''')' ; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;        
	   SET @MySql = 'BEGIN' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = '    if not exists (select name from sys.indexes where name = ''CI_DBPK_' + @ParentTable + '_' + @ParentColumn + ''')' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = '         CREATE INDEX CI_DBPK_' + @ParentTable + '_' + @ParentColumn + ' ON BASE_' + @ParentTable + '(' + @ParentColumn + ') INCLUDE (dbname) ; ' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'END' + char(10) + 'GO ';
        INSERT INTO @T (stmt) VALUES (@MySQl) ;
        
        SET @MySql = 'exec PrintImmediate ''Processing table ' + @ChildTable + ' : ' + @ChildColumn + ''';' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'if exists (select name from sys.tables where name = ''BASE_' + @ChildTable + ''')' ; 
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;        
	   SET @MySql = 'BEGIN' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = '    if not exists (select name from sys.indexes where name = ''CI_DBPK_' + @ChildTable + '_' + @ChildColumn + ''')' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = '         CREATE INDEX CI_DBPK_' + @ChildTable + '_' + @ChildColumn + ' ON BASE_' + @ChildTable + '(' + @ChildColumn + ') INCLUDE (dbname) ; ' ;
	   INSERT INTO @T (stmt) VALUES (@MySQl) ;
        SET @MySql = 'END' + char(10) + 'GO ';
        INSERT INTO @T (stmt) VALUES (@MySQl) ;
        
        FETCH NEXT FROM C INTO @ParentTable , @ParentColumn , @ParentSchema , @ChildTable , @ChildColumn , @ChildSchema;
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
