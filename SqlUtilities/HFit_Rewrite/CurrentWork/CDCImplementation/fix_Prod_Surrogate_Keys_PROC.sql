
/*
select table_name,COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME like 'Surro%'

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
AND TABLE_NAME = 'EDW_RoleMembership' AND TABLE_SCHEMA = 'dbo'
*/

DECLARE
      @PreviewOnly AS bit = 1 , 
      @UpdateMartData AS bit = 1;
DECLARE
      @DBNAME AS nvarchar (250) = '' , 
      @DBNAME2 AS nvarchar (250) = '' , 
      @DBNAME3 AS nvarchar (250) = '' , 
      @PKIDX_ColName AS nvarchar (500) = '' , 
      @PKIDX_Name AS nvarchar (500) = '' , 
      @GenProc AS nvarchar (250) = '' , 
      @Msg AS nvarchar (max) , 
      @MySql AS nvarchar (max) , 
      @TblName AS nvarchar (250) = '' , 
      @ColName AS nvarchar (250) = '' , 
      @KeyName AS nvarchar (250) = '';

if len(@DBNAME) = 0 
    set @DBNAME = DB_NAME();

DECLARE C CURSOR
    FOR SELECT table_name , 
               column_name
          FROM INFORMATION_SCHEMA.COLUMNS
          WHERE COLUMN_NAME LIKE 'Surro%';

OPEN C;

FETCH NEXT FROM C INTO @TblName , @ColName;

WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRANSACTION TX1;
        BEGIN TRY

            SET @Msg = '-- Processing: ' + @DBNAME + '.dbo.' + @TblName;
            EXEC PrintImmediate @Msg;

            SET @PKIDX_Name = (SELECT CONSTRAINT_NAME
                                 FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                                 WHERE OBJECTPROPERTY (OBJECT_ID (CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME) , 'IsPrimaryKey') = 1
                                   AND TABLE_NAME = @TblName
                                   AND TABLE_SCHEMA = 'dbo') ;

            SET @PKIDX_ColName = (SELECT COLUMN_NAME
                                    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                                    WHERE OBJECTPROPERTY (OBJECT_ID (CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME) , 'IsPrimaryKey') = 1
                                      AND TABLE_NAME = @TblName
                                      AND TABLE_SCHEMA = 'dbo') ;

            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' DISABLE CHANGE_TRACKING ';
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;
            IF LEN (@DBNAME2) > 0
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' DISABLE CHANGE_TRACKING ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' DISABLE CHANGE_TRACKING ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';

            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' DROP CONSTRAINT ' + @PKIDX_Name;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' DROP CONSTRAINT ' + @PKIDX_Name;
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' DROP CONSTRAINT ' + @PKIDX_Name;
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';

            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' DROP column ' + @PKIDX_ColName;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' DROP column ' + @PKIDX_ColName;
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' DROP column ' + @PKIDX_ColName;
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';
            SET @KeyName = 'CTKey_' + @TblName;
            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' add CTKey_' + @TblName + ' int identity(1,1) not null ';
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;
            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' add CTKey_' + @TblName + ' int identity(1,1) not null ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' add CTKey_' + @TblName + ' int identity(1,1) not null ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';
            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' ADD CONSTRAINT IDX_CTKey_' + @TblName + ' PRIMARY KEY CLUSTERED (' + @KeyName + ')';
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' ADD CONSTRAINT IDX_CTKey_' + @TblName + ' PRIMARY KEY CLUSTERED (' + @KeyName + ')';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' ADD CONSTRAINT IDX_CTKey_' + @TblName + ' PRIMARY KEY CLUSTERED (' + @KeyName + ')';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';
            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';

            IF NOT EXISTS (SELECT name
                             FROM sys.procedures
                             WHERE name = 'proc_CreateBaseTable') 
                BEGIN
                    SET @UpdateMartData = 0;
                END;
            IF @UpdateMartData = 0
                BEGIN EXEC PrintImmediate '/*';
                END;
            SET @MySql = 'exec proc_CreateBaseTable ''' + @DBNAME + ''', ''' + @TblName + ''', @SkipIfExists = 0';
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN
                    IF @UpdateMartData = 0
                        BEGIN
                            SET @MySql = '-- ' + @MySql;
                        END;
                    EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'exec proc_CreateBaseTable ''' + @DBNAME2 + ''', ''' + @TblName + ''', @SkipIfExists = 1';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'exec proc_CreateBaseTable ''' + @DBNAME3 + ''', ''' + @TblName + ''', @SkipIfExists = 1';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;

            IF LEN (@DBNAME) > 0
                BEGIN
                    SET @Msg = '-- EXEC proc_BASE_' + @TblName + '_' + @DBNAME + '_ApplyCT ';
                    EXEC PrintImmediate @Msg;
                END;
            IF LEN (@DBNAME2) > 0
                BEGIN
                    SET @Msg = '-- EXEC proc_BASE_' + @TblName + '_' + @DBNAME2 + '_ApplyCT ';
                    EXEC PrintImmediate @Msg;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN
                    SET @Msg = '-- EXEC proc_BASE_' + @TblName + '_' + @DBNAME3 + '_ApplyCT ';
                    EXEC PrintImmediate @Msg;
                END;

            IF @UpdateMartData = 0
                BEGIN EXEC PrintImmediate '*/';
                END;

            COMMIT TRANSACTION TX1;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION TX1;
        END CATCH;
        IF @PreviewOnly = 1
            BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
            END;
        EXEC PrintImmediate '--**************************************************************';
        FETCH NEXT FROM C INTO @TblName , @ColName;
    END;

CLOSE C;
DEALLOCATE C; 

