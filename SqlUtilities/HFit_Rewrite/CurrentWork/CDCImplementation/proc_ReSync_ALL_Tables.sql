
DISABLE TRIGGER Person.uAddress ON Person.Address;  

SELECT 
     'DISABLE TRIGGER ' + sysobjects.name + ' ON ' +  OBJECT_NAME(parent_obj) + char(10) + 'GO'
FROM sysobjects 

INNER JOIN sysusers 
    ON sysobjects.uid = sysusers.uid 

INNER JOIN sys.tables t 
    ON sysobjects.parent_obj = t.object_id 

INNER JOIN sys.schemas s 
    ON t.schema_id = s.schema_id 

WHERE sysobjects.type = 'TR' 

go

-- exec proc_Reload_All_tables 1
alter PROCEDURE proc_Reload_All_tables @KeepHistory bit = 1
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
          @MySql AS nvarchar (max) = '' , 
          @cols AS nvarchar (max) = '' , 
          @DBNAME AS nvarchar (250) = 'KenticoCMS_2' , 
          @TBL AS nvarchar (250) = '' , 
          @HistTable nvarchar (250) = '';

    DECLARE
          @T AS TABLE (stmt nvarchar (max) NULL) ;

    DECLARE C CURSOR
        FOR SELECT DISTINCT table_NAME
              FROM INFORMATION_SCHEMA.tables
              WHERE table_name LIKE 'BASE_%'
                AND table_name NOT LIKE '%[_]DEL'
                AND table_name NOT LIKE '%[_]testdata'
                AND table_name NOT LIKE '%[_]CTVerHIST'
                AND TABLE_TYPE LIKE 'BASE TABLE';
    OPEN C;

    FETCH NEXT FROM C INTO @TBL;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            DECLARE
                  @ProcName AS nvarchar (500) = '';
            IF CHARINDEX ('base_view' , @TBL) <= 0
                BEGIN
                    SET @ProcName = 'proc_' + @TBL + '_KenticoCMS_1_SYNC null,1';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'if exists (select name from sys.procedures where name = ''' + @ProcName + ''')';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + ' 0,0;';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @TBL + '_KenticoCMS_2_SYNC null,1';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'if exists (select name from sys.procedures where name = ''' + @ProcName + ''')';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + ' 0,0;';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @TBL + '_KenticoCMS_3_SYNC null,1';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'if exists (select name from sys.procedures where name = ''' + @ProcName + ''')';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + ' 0,0;';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    IF @KeepHistory = 0
                        BEGIN
                            set @HistTable = @TBL + '_DEL';
                            IF EXISTS (SELECT table_name
                                         FROM information_schema.tables
                                         WHERE table_name = @HistTable) 
                                BEGIN
                                    SET @Mysql = 'Truncate table ' + @HistTable;
                                    INSERT INTO @T (stmt) 
							 VALUES (@MySQl) ;
							 SET @MySql = 'GO';
							 INSERT INTO @T (stmt) 
							 VALUES (@MySQl) ;
                                END;
                        END;
                END;
            ELSE
                BEGIN
                    DECLARE
                          @temptbl nvarchar (254) = SUBSTRING (@TBL , 6 , 9999) ;
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @ProcName = 'proc_' + @temptbl + '_KenticoCMS_1';
                    SET @MySQl = '     exec ' + @ProcName + '  @ReloadAll = 1;' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @temptbl + '_KenticoCMS_2';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + '  @ReloadAll = 1;' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @temptbl + '_KenticoCMS_3';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + '  @ReloadAll = 1;' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                   IF @KeepHistory = 0
                        BEGIN
                            set @HistTable = @TBL + '_DEL';
                            IF EXISTS (SELECT table_name
                                         FROM information_schema.tables
                                         WHERE table_name = @HistTable) 
                                BEGIN
                                    SET @Mysql = 'Truncate table ' + @HistTable;
                                    INSERT INTO @T (stmt) 
							 VALUES (@MySQl) ;
							 SET @MySql = 'GO';
							 INSERT INTO @T (stmt) 
							 VALUES (@MySQl) ;
                                END;
                        END;

                END;

            FETCH NEXT FROM C INTO @TBL;
        END;

    CLOSE C;
    DEALLOCATE C;

    SELECT * FROM @T;
END;

GO

CREATE PROCEDURE proc_Resync_All_tables
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
          @MySql AS nvarchar (max) = '' , 
          @cols AS nvarchar (max) = '' , 
          @DBNAME AS nvarchar (250) = 'KenticoCMS_2' , 
          @TBL AS nvarchar (250) = '';
    DECLARE
          @T AS TABLE (stmt nvarchar (max) NULL) ;

    DECLARE C CURSOR
        FOR SELECT DISTINCT table_NAME
              FROM INFORMATION_SCHEMA.tables
              WHERE table_name LIKE 'BASE_%'
                AND table_name NOT LIKE '%[_]DEL'
                AND table_name NOT LIKE '%[_]testdata'
                AND table_name NOT LIKE '%[_]CTVerHIST'
                AND TABLE_TYPE LIKE 'BASE TABLE';
    OPEN C;

    FETCH NEXT FROM C INTO @TBL;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            DECLARE
                  @ProcName AS nvarchar (500) = '';
            IF CHARINDEX ('base_view' , @TBL) <= 0
                BEGIN
                    SET @ProcName = 'proc_' + @TBL + '_KenticoCMS_1_SYNC null,1';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'if exists (select name from sys.procedures where name = ''' + @ProcName + ''')';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + ' 0,0;';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @TBL + '_KenticoCMS_2_SYNC null,1';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'if exists (select name from sys.procedures where name = ''' + @ProcName + ''')';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + ' 0,0;';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @TBL + '_KenticoCMS_3_SYNC null,1';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'if exists (select name from sys.procedures where name = ''' + @ProcName + ''')';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + ' 0,0;';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySql = 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                END;
            ELSE
                BEGIN
                    DECLARE
                          @temptbl nvarchar (254) = SUBSTRING (@TBL , 6 , 9999) ;
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @ProcName = 'proc_' + @temptbl + '_KenticoCMS_1';
                    SET @MySQl = '     exec ' + @ProcName + '  null,0;' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @temptbl + '_KenticoCMS_2';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + '  null,0;' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;

                    SET @ProcName = 'proc_' + @temptbl + '_KenticoCMS_3';
                    SET @MySql = 'exec PrintImmediate ''Running: ' + @ProcName + ''';' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                    SET @MySQl = '     exec ' + @ProcName + '  null,0;' + CHAR (10) + 'GO';
                    INSERT INTO @T (stmt) 
                    VALUES (@MySQl) ;
                END;

            FETCH NEXT FROM C INTO @TBL;
        END;

    CLOSE C;
    DEALLOCATE C;

    SELECT * FROM @T;
END;