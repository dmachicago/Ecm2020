-- drop table ##SvrSideTable
-- select top 100 * from information_schema.columns
-- exec proc_MatchChildToSvrSideTable 'KenticoCMS_3', 'CMS_Usersettings', 'BASE_CMS_Usersettings' 
 
alter PROCEDURE proc_MatchChildToSvrSideTable (
      @DBNAME NVARCHAR (100) 
    ,@SvrSideTable NVARCHAR (250) 
    ,@MartTable NVARCHAR (250) 
    ,@PreviewOnly BIT = 1) 
AS
BEGIN

    BEGIN TRY
        DROP TABLE
             ##SvrSideTable;
    END TRY
    BEGIN CATCH
        PRINT 'Init ##SvrSideTable ';
    END CATCH;

    BEGIN TRY
        DROP TABLE
             ##MartTable;
    END TRY
    BEGIN CATCH
        PRINT 'Init ##MartTable ';
    END CATCH;

    -- drop table #TempColumns
    --Get the columns from the server table 
    DECLARE
    @MySql VARCHAR (max) = '';
    --FIND MISSING COLUMNS
    set @MySql = 'SELECT * ' ;
    set @MySql = @MySql + char(10) + 'INTO ##SvrSideTable ' ;
    set @MySql = @MySql + char(10) + 'FROM '+@DBNAME+'.information_schema.columns ' ; 
    set @MySql = @MySql + char(10) + 'WHERE table_schema = ''dbo''' ;
    set @MySql = @MySql + char(10) + 'AND table_name = '''+@SvrSideTable+'''' ;
    set @MySql = @MySql + char(10) + 'AND column_name NOT IN ( ' ;
    set @MySql = @MySql + char(10) + '    SELECT column_name ' ; 
    set @MySql = @MySql + char(10) + '    FROM INFORMATION_SCHEMA.columns ' ; 
    set @MySql = @MySql + char(10) + '    WHERE table_schema = ''dbo''' ;
    set @MySql = @MySql + char(10) + '    AND table_name = '''+@MartTable+''')' ;
    PRINT @MySQl;
    EXEC (@MySql) ;

    --SELECT * FROM ##SvrSideTable ORDER BY Ordinal_Position;

    DECLARE
    @MySql2 VARCHAR (max) = ''
  ,@column_name VARCHAR (250) 
  ,@IS_NULLABLE VARCHAR (250) 
  ,@data_type VARCHAR (250) 
  ,@CHARACTER_MAXIMUM_LENGTH INT
  ,@NUMERIC_PRECISION INT
  ,@NUMERIC_PRECISION_RADIX INT;

    SET @MySql2 = 'select * into ##MartTable from information_schema.columns where table_schema = ''dbo'' and table_name = ''' + @MartTable + '''';
    SET @MySql2 = @MySql2 + CHAR (10) + ' AND column_name not like ''SVR''' + CHAR (10) ;
    SET @MySql2 = @MySql2 + CHAR (10) +'  AND column_name not like ''SVR''' + CHAR (10) ;
    SET @MySql2 = @MySql2 + CHAR (10) +'  AND column_name not like ''DBNAME''' + CHAR (10) ;
    SET @MySql2 = @MySql2 + CHAR (10) +'  AND column_name not like ''%SurrogateKey%''' + CHAR (10) ;
    SET @MySql2 = @MySql2 + CHAR (10) +'  AND column_name not like ''HashCode''' + CHAR (10) ;
    SET @MySql2 = @MySql2 + CHAR (10) +'  AND column_name not like ''LastModifiedDate''' + CHAR (10) 
    SET @MySql2 = @MySql2 + CHAR (10) +'  AND column_name not like ''Action_Date''' + CHAR (10) ;

    --FIND EXTRA COLUMNS in MART table
    SET @MySql2 = 'SELECT * ' ; 
    SET @MySql2 = @MySql2 + char(10) + ' INTO ##MartTable ' ; 
    SET @MySql2 = @MySql2 + char(10) + ' FROM information_schema.columns ' ; 
    SET @MySql2 = @MySql2 + char(10) + ' WHERE table_schema = ''dbo'' ' ; 
    SET @MySql2 = @MySql2 + char(10) + ' AND table_name = '''+ @MartTable + '''' ; 
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''SVR''';
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''DBNAME''' ;    
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''%SurrogateKey%''' ;
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''HashCode''';
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''LastModifiedDate''';
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''Action_Date''' ;
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''Action%''' ;
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''SYS_%''' ;
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT LIKE ''CT_%''' ;
    SET @MySql2 = @MySql2 + char(10) + ' AND column_name NOT IN ( ' ;     
    SET @MySql2 = @MySql2 + char(10) + '   SELECT column_name ' ; 
    SET @MySql2 = @MySql2 + char(10) + '   FROM '+@DBNAME+'.information_schema.columns ' ; 
    SET @MySql2 = @MySql2 + char(10) + '   WHERE table_schema = ''dbo''' ;
    SET @MySql2 = @MySql2 + char(10) + ' AND table_name = '''+@SvrSideTable+''')' ;
    
    PRINT @MySQl2;
    EXEC (@MySql2) ;

    DECLARE C CURSOR
        FOR SELECT
                   column_name
                 ,IS_NULLABLE
                 ,data_type
                 ,CHARACTER_MAXIMUM_LENGTH
                 ,NUMERIC_PRECISION
                 ,NUMERIC_PRECISION_RADIX
            FROM ##MartTable
            --WHERE
            --       table_name = @MartTable AND column_name NOT LIKE 'SVR' AND column_name NOT LIKE 'DBNAME' AND column_name NOT LIKE '%SurrogateKey%' AND column_name NOT LIKE 'LastModifiedDate' AND column_name NOT LIKE 'HashCode' AND column_name NOT LIKE 'Action_Date';

    OPEN C;

    FETCH NEXT FROM C INTO @column_name , @IS_NULLABLE , @data_type , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_PRECISION_RADIX;
    --Remove columns that are in the mart Table and no longer exist in the Server Table
    WHILE
           @@FETCH_STATUS = 0
        BEGIN

            IF
                   (SELECT
                           COUNT (*) 
                    FROM ##SvrSideTable
                    WHERE
                           column_name = @column_name) = 0
                BEGIN
                    --the column no longer exists in the Parent Table
                    SET @MySql = 'alter table ' + @MartTable + ' drop column ' + @column_name + ';';
                    IF @PreviewOnly = 1
                        BEGIN
                            PRINT @MySql;
                        END;
                    ELSE
                        BEGIN
                            IF
                                   (SELECT
                                           COUNT (*) 
                                    FROM INFORMATION_SCHEMA.columns
                                    WHERE
                                           table_name = @MartTable AND
                                           column_name = @column_name) > 0
                                BEGIN
							 if @PreviewOnly =1 
								PRINT @MySql;
							 else 
							 begin
								PRINT @MySql;
								EXEC (@MySql) ;
							 end ;
                                END;
                            ELSE
                                BEGIN
                                    PRINT '-- MISSING COLUMN: ' + @MySql;
                                END;
                        END;
                END;
		  exec PrintImmediate @column_name ;
            FETCH NEXT FROM C INTO @column_name , @IS_NULLABLE , @data_type , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_PRECISION_RADIX;
        END;

    CLOSE C;
    DEALLOCATE C;

    DECLARE C2 CURSOR
        FOR SELECT
                   column_name
                 ,IS_NULLABLE
                 ,data_type
                 ,CHARACTER_MAXIMUM_LENGTH
                 ,NUMERIC_PRECISION
                 ,NUMERIC_PRECISION_RADIX
            FROM ##SvrSideTable;

    OPEN C2;

    FETCH NEXT FROM C2 INTO @column_name , @IS_NULLABLE , @data_type , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_PRECISION_RADIX;
    --Remove columns that are in the mart Table and no longer exist in the Server Table
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            --select top 100 * from information_schema.columns
            IF
                   (SELECT
                           COUNT (*) 
                    FROM information_schema.columns C join INFORMATION_SCHEMA.tables T on C.table_name = T.table_name and C.column_name = @column_name                   
                           ) > 0
                BEGIN
                    --the column id new and needs to be added to the MART table
                    SET @MySql = 'alter table ' + @MartTable + ' add ' + @column_name + ' ' + @data_type;
                    IF
                           LEN (@CHARACTER_MAXIMUM_LENGTH) > 0
                        BEGIN
					   if @CHARACTER_MAXIMUM_LENGTH < 0 
                            SET @MySql = @MySql + '(MAX)';
					   else
					   SET @MySql = @MySql + '(' + CAST (@CHARACTER_MAXIMUM_LENGTH AS NVARCHAR (50)) + ')';
                        END;
                    IF
                           LEN (@NUMERIC_PRECISION) > 0 AND
                           LEN (@NUMERIC_PRECISION_RADIX) = 0
                        BEGIN
                            SET @MySql = @MySql + '(' + CAST (@NUMERIC_PRECISION AS NVARCHAR (50)) + ')';
                        END;
                    IF
                           LEN (@NUMERIC_PRECISION) > 0 AND
                           LEN (@NUMERIC_PRECISION_RADIX) > 0
                        BEGIN
					   if @data_type = 'int' or @data_type = 'bigint' 
						  print 'INT FOUND' ;
					   else 
						  SET @MySql = @MySql + '(' + CAST (@NUMERIC_PRECISION AS NVARCHAR (50)) + '),(' + CAST (@NUMERIC_PRECISION_RADIX AS NVARCHAR (50)) + ')';
                        END;
                    IF @PreviewOnly = 1
                        BEGIN
                            PRINT @MySql;
                        END;
                    ELSE
                        BEGIN
                            PRINT @MySql;
                            EXEC (@MySql) ;
                        END;
                END;

            FETCH NEXT FROM C2 INTO @column_name , @IS_NULLABLE , @data_type , @CHARACTER_MAXIMUM_LENGTH , @NUMERIC_PRECISION , @NUMERIC_PRECISION_RADIX;
        END;

    CLOSE C2;
    DEALLOCATE C2;

END;