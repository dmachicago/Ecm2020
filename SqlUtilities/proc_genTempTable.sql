
PRINT 'Creating proc_genTempTable';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_genTempTable' )
    BEGIN
        DROP PROCEDURE
             proc_genTempTable;
    END;
GO

    -- exec proc_genTempTable '[HumanResources].[Department]'
    -- exec proc_genTempTable 'CT_Performance_History'
    -- exec proc_genTempTable 'STAGING_EDW_HealthInterestDetail'
    -- exec proc_genTempTable 'CMS_TREE'
    -- exec proc_genTempTable 'CMS_SITE'
    -- exec proc_genTempTable 'CMS_USER'
    -- exec proc_genTempTable '[HumanResources].[Employee]'
    /*
    SELECT * FROM information_schema.columns
    WHERE table_name = 'CMS_Document'
    ORDER BY ORDINAL_POSITION;    --DocumentGroupWebParts
    */

CREATE PROCEDURE proc_genTempTable ( @TBLNAME AS nvarchar( 250 ))
AS
BEGIN
/*
Author:	  W. Dale Miller
Date:	  09.22.2003
Copyright:  DMA, Ltd.
Purpose:	  Generates a temp table from another table or view.
*/

    DECLARE
       @TBL nvarchar( 100 )
       ,@COL nvarchar( 100 )
       ,@DType AS nvarchar( 50 )
       ,@LEN AS int
       ,@PRECISION AS int
       ,@SCALE AS int
       ,@mysql AS nvarchar( max )
       ,@i AS int = 0
       ,@IS_NULLABLE AS nvarchar( 10 );

    DECLARE db_cursor CURSOR
        FOR
            --select table_name, COLUMN_NAME,DATA_TYPE,character_maximum_length , numeric_precision, numeric_scale, IS_NULLABLE
            SELECT
                   table_name ,
                   COLUMN_NAME ,
                   DATA_TYPE ,
                   character_maximum_length ,
                   numeric_precision ,
                   numeric_scale ,
                   IS_NULLABLE
              FROM information_schema.columns
              WHERE table_name = @TBLNAME
              ORDER BY
                       ORDINAL_POSITION;

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;

    SET @mysql = 'IF EXISTS ( SELECT name FROM tempdb.dbo.sysobjects WHERE id = OBJECT_ID (N''tempdb..#TEMP_'+@TBL+''' )) ' + char(10) ;
    SET @mysql =  @mysql + '    BEGIN '  + char(10) ;
    SET @mysql =  @mysql + '        DROP TABLE '  + char(10) ;
    SET @mysql =  @mysql + '            #TEMP_'+@TBL + char(10) ;
    SET @mysql =  @mysql + '    END; '  + char(10) ;
    print @mysql ; 
    print ' ' ; 


    SET @mysql = 'CREATE TABLE ' + CHAR( 10 );
    SET @mysql = @mysql + '#TEMP_' + @TBL + CHAR( 10 );
    SET @mysql = @mysql + '(' + CHAR( 10 );
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @mysql = @mysql + @col + ' ' + @DType + ' ';
                END;
            ELSE
                BEGIN
                    SET @mysql = @mysql + CHAR( 10 ) + ', ';
                    SET @mysql = @mysql + @col + ' ' + @DType + ' ';
                END;

            --PRINT '@TBL: ' + CAST( @TBL AS nvarchar( 100 ));
            --PRINT  '@@COL: ' + CAST( @COL AS nvarchar( 100 ));
            --PRINT  '@@DType: ' + CAST( @DType AS nvarchar( 100 ));
            --PRINT  '@@LEN: ' + CAST( @LEN AS nvarchar( 100 ));
            --PRINT  '@@PRECISION: ' + CAST( @PRECISION AS nvarchar( 100 ));
            --PRINT  '@@SCALE: ' + CAST( @SCALE AS nvarchar( 100 ));
            --PRINT  '@@IS_NULLABLE: ' + CAST( @IS_NULLABLE AS nvarchar( 100 ));
            --PRINT ' - ';
            IF @DType = 'decimal'
                BEGIN
                    SET @mysql = @mysql + '(' + CAST( @PRECISION AS nvarchar( 100 )) + ',' + CAST( @SCALE AS nvarchar( 100 )) + ')';
                END;
            IF @DType = 'datetime2'
                BEGIN
                    SET @mysql = @mysql + '(7)';
                END;

            IF @LEN IS NOT NULL
                BEGIN
				if @LEN < 0 
				    SET @mysql = @mysql + '(max)';
				else 
				    SET @mysql = @mysql + ' (' + CAST( @LEN AS nvarchar( 100 )) + ')';
                END;

            IF @IS_NULLABLE = 'NO'
                BEGIN
                    SET @mysql = @mysql + ' NOT NULL ';
                END;
            ELSE
                BEGIN
                    SET @mysql = @mysql + ' NULL ';
                END;

            --PRINT '@@mysql: ' + CAST( @mysql AS nvarchar( max ));
            --PRINT  '**************************';

            FETCH NEXT FROM db_cursor INTO  @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
        END;

    DECLARE
       @KCols AS nvarchar( max );
    EXEC proc_getPKeyCols @TBL , @KCols OUTPUT;

    --PRINT '@KCols: ' + @KCols;

    set @KCols = ltrim(rtrim(@KCols)) ;

    declare @collen as int = (select datalength(@KCols)) ;

    IF @collen > 0 
        BEGIN
            SET @mysql = @mysql + CHAR( 10 ) + ' PRIMARY KEY ( ' + CAST( @KCols AS nvarchar( max )) + ' )' + CHAR( 10 );
        END;
    ELSE
        BEGIN
            SET @mysql = @mysql + CHAR( 10 ) + ' -- PRIMARY KEY (col1, col2)' + CHAR( 10 );
        END;

    SET @mysql = @mysql + ')' + CHAR( 10 );
    --PRINT  '**************************';
    PRINT @mysql;
    select @mysql;
    CLOSE db_cursor;
    DEALLOCATE db_cursor;

END;

go

PRINT 'Created proc_genTempTable';
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
