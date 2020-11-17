
DECLARE
      @PreviewOnly AS bit = 1 , 
      @UpdateMartData AS bit = 0;
DECLARE
      @DBNAME AS nvarchar (250) = '' ,		   --Leave blank to use default DB NAME
      @DBNAME2 AS nvarchar (250) = '' ,		   --leave blank to skip
      @DBNAME3 AS nvarchar (250) = '' ,		   --leave blank to skip 
      @PKIDX_ColName AS nvarchar (500) = '' , 
      @PKIDX_Name AS nvarchar (500) = '' , 
      @GenProc AS nvarchar (250) = '' , 
      @Msg AS nvarchar (max) , 
      @MySql AS nvarchar (max) , 
      @TblName AS nvarchar (250) = '' , 
      @ColName AS nvarchar (250) = '' , 
      @KeyName AS nvarchar (250) = '';

-- truncate table TEMP_PKey_CI_Fix
-- select * from TEMP_PKey_CI_Fix
IF NOT EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = 'TEMP_PKey_CI_Fix') 
    BEGIN
        CREATE TABLE TEMP_PKey_CI_Fix (procstmt nvarchar (4000)) 
    END;

IF LEN (@DBNAME) = 0
    BEGIN
        SET @DBNAME = DB_NAME () 
    END;

DECLARE C CURSOR
    FOR SELECT table_name , 
               column_name
          FROM INFORMATION_SCHEMA.COLUMNS
          WHERE COLUMN_NAME LIKE 'SurrogateKey%';

OPEN C;

FETCH NEXT FROM C INTO @TblName , @ColName;

WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRANSACTION TX1;
        BEGIN TRY

            SET @Msg = 'EXEC PrintImmediate ' + '''Processing: ' + @DBNAME + '.dbo.' + @TblName + '''';
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
                BEGIN EXEC 
				PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;
            IF LEN (@DBNAME2) > 0
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' DISABLE CHANGE_TRACKING ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC 
					   PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' DISABLE CHANGE_TRACKING ';
                    IF @PreviewOnly = 1
                        BEGIN EXEC 
					   PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';

            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' DROP CONSTRAINT ' + @PKIDX_Name;
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN 
				EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' DROP CONSTRAINT ' + @PKIDX_Name;
                    IF @PreviewOnly = 1
                        BEGIN 
					   EXEC PrintImmediate @MySql;
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
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';

            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' DROP column ' + @PKIDX_ColName;
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' DROP column ' + @PKIDX_ColName;
                    IF @PreviewOnly = 1
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' DROP column ' + @PKIDX_ColName;
                    IF @PreviewOnly = 1
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';
            SET @KeyName = 'CTKey_' + @TblName;
            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' add CTKey_' + @TblName + ' int identity(1,1) not null ';
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN 
				EXEC PrintImmediate @MySql;
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
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';
            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' ADD CONSTRAINT IDX_CTKey_' + @TblName + ' PRIMARY KEY (' + @KeyName + ')';
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN 
				EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' ADD CONSTRAINT IDX_CTKey_' + @TblName + ' PRIMARY KEY (' + @KeyName + ')';
                    IF @PreviewOnly = 1
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN
                    SET @MySql = 'ALTER TABLE ' + @DBNAME3 + '.dbo.' + @TblName + ' ADD CONSTRAINT IDX_CTKey_' + @TblName + ' PRIMARY KEY (' + @KeyName + ')';
                    IF @PreviewOnly = 1
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';
            SET @MySql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate @MySql;
                END;
            ELSE
                BEGIN 
				EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;

            IF LEN (@DBNAME2) > 0
                BEGIN

                    SET @MySql = 'ALTER TABLE ' + @DBNAME2 + '.dbo.' + @TblName + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
                    IF @PreviewOnly = 1
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN 
					   EXEC PrintImmediate @MySql;
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
                        BEGIN 
					   EXEC PrintImmediate @MySql;
                            EXEC (@MySql) ;
                        END;
                END;
            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate 'GO    --Preview Only Set true';
                END;
            --EXEC PrintImmediate '-->>>';

            IF NOT EXISTS (SELECT name
                             FROM sys.procedures
                             WHERE name = 'proc_CreateBaseTable') 
                BEGIN
                    SET @UpdateMartData = 0;
                END;
            IF @UpdateMartData = 0
                BEGIN 
				EXEC PrintImmediate '/*';
                END;

            SET @MySql = 'exec proc_CreateBaseTable ''' + @DBNAME + ''', ''' + @TblName + ''', @SkipIfExists = 0 ;' + CHAR (10) + 'GO';

            IF NOT EXISTS (SELECT procstmt
                             FROM TEMP_PKey_CI_Fix
                             WHERE procstmt = @MySql) 
                BEGIN
                    INSERT INTO TEMP_PKey_CI_Fix (procstmt) 
                    VALUES (@MySql) 
                END;

            IF @PreviewOnly = 1
                BEGIN 
				EXEC PrintImmediate @MySql;
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

                    SET @MySql = 'exec proc_CreateBaseTable ''' + @DBNAME2 + ''', ''' + @TblName + ''', @SkipIfExists = 1 ;' + CHAR (10) + 'GO';
                    IF NOT EXISTS (SELECT procstmt
                                     FROM TEMP_PKey_CI_Fix
                                     WHERE procstmt = @MySql) 
                        BEGIN
                            INSERT INTO TEMP_PKey_CI_Fix (procstmt) 
                            VALUES (@MySql) 
                        END;

                    IF @PreviewOnly = 1
                        BEGIN EXEC PrintImmediate @MySql;
                        END;
                    ELSE
                        BEGIN EXEC (@MySql) ;
                        END;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN

                    SET @MySql = 'exec proc_CreateBaseTable ''' + @DBNAME3 + ''', ''' + @TblName + ''', @SkipIfExists = 1 ;' + CHAR (10) + 'GO';

                    IF NOT EXISTS (SELECT procstmt
                                     FROM TEMP_PKey_CI_Fix
                                     WHERE procstmt = @MySql) 
                        BEGIN
                            INSERT INTO TEMP_PKey_CI_Fix (procstmt) 
                            VALUES (@MySql) 
                        END;

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
				 IF NOT EXISTS (SELECT procstmt
                                     FROM TEMP_PKey_CI_Fix
                                     WHERE procstmt = @Msg) 
                        BEGIN
                            INSERT INTO TEMP_PKey_CI_Fix (procstmt) 
                            VALUES (@Msg) 
                        END;
                    EXEC PrintImmediate @Msg;
                END;
            IF LEN (@DBNAME2) > 0
                BEGIN
                    SET @Msg = '-- EXEC proc_BASE_' + @TblName + '_' + @DBNAME2 + '_ApplyCT ';
				IF NOT EXISTS (SELECT procstmt
                                     FROM TEMP_PKey_CI_Fix
                                     WHERE procstmt = @Msg) 
                        BEGIN
                            INSERT INTO TEMP_PKey_CI_Fix (procstmt) 
                            VALUES (@Msg) 
                        END;
                    EXEC PrintImmediate @Msg;
                END;
            IF LEN (@DBNAME3) > 0
                BEGIN
                    SET @Msg = '-- EXEC proc_BASE_' + @TblName + '_' + @DBNAME3 + '_ApplyCT ';
				IF NOT EXISTS (SELECT procstmt
                                     FROM TEMP_PKey_CI_Fix
                                     WHERE procstmt = @Msg) 
                        BEGIN
                            INSERT INTO TEMP_PKey_CI_Fix (procstmt) 
                            VALUES (@Msg) 
                        END;
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


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
