

-- use KenticoCMS_Datamart_2
GO
PRINT 'Creating proc_genSelectInto';
GO
IF EXISTS ( SELECT
                   name
            FROM sys.procedures
            WHERE
                   name = 'proc_genSelectInto') 
    BEGIN
        DROP PROCEDURE
             proc_genSelectInto;
    END;
GO
/***********************************************************************
declare @S as nvarchar(max) ;
declare @DDL as nvarchar(max)
exec proc_genSelectInto @DBNAME = 'KenticoCMS_1', @PullFromTbl = 'BASE_CMS_USER', @IntoTBLNAME = 'CMS_USER', @DDL 

exec proc_genSelectInto 'KenticoCMS_1', 'BASE_CMS_USER', 'CMS_USER', DDL 

declare @S as nvarchar(max)
declare @DDL as nvarchar(max)
exec proc_genSelectInto 'KenticoCMS_Datamart_2', 'view_EDW_HealthAssessment_MART_CMS3', 'BASE_MART_EDW_HealthAssesment', DDL 
select * from ##TEMP_InsertDDL
set @s = @DDL ;
select @S
***********************************************************************/
-- exec proc_genSelectInto 'view_EDW_HealthAssessment_MART_CMS3'

-- use KenticoCMS_Datamart_2

/******************************************************
*******************************************************
INSERT INTO TestTable (FirstName, LastName)
SELECT FirstName, LastName
FROM Person.Contact
*******************************************************
******************************************************/

CREATE PROCEDURE proc_genSelectInto (
       @DBNAME AS NVARCHAR (100) = null
     , @PullFromTbl AS NVARCHAR (250) 
     , @IntoTBLNAME AS NVARCHAR (250) = NULL
     , @DDL AS NVARCHAR (MAX) OUT) 
AS
BEGIN

if @DBNAME is null
    set @DBNAME = DB_NAME();

/*******************************************************************************
********************************************************************************
Author:	  W. Dale Miller
Date:	  09.22.2003
Copyright:  DMA, Ltd.
Purpose:	  Generates a select into statement from a table or view. This method 
		  is used when table is already created in the database earlier and 
		  data is to be inserted into this table from another table.
Last Test:  10.19.2015 WDM
********************************************************************************
*******************************************************************************/

    -- DECLARE @PullFromTbl AS nvarchar ( 250 ) = 'view_EDW_HealthAssesment_CT';

    IF OBJECT_ID ('tempdb..##TEMP_InsertDDL') IS NOT NULL
        BEGIN DROP TABLE
                   ##TEMP_InsertDDL;
        END;

    CREATE TABLE ##TEMP_InsertDDL (
                 DDL NVARCHAR (MAX)) ;

    DECLARE
    @TBL NVARCHAR ( 250) 
  , @COL NVARCHAR ( 250) 
  , @DType AS NVARCHAR ( 50) 
  , @LEN AS INT
  , @PRECISION AS INT
  , @SCALE AS INT
  , @mysql AS NVARCHAR ( MAX) 
  , @mysql2 AS NVARCHAR ( MAX) = 'SELECT '
  , @i AS INT = 0
  , @IS_NULLABLE AS NVARCHAR ( 10) ;

    IF @DBNAME IS NOT NULL
        BEGIN
            SET @MySql = 'SELECT
                   table_name
                   ,COLUMN_NAME
                   ,DATA_TYPE
                   ,character_maximum_length
                   ,numeric_precision
                   ,numeric_scale
                   ,IS_NULLABLE
              FROM ' + @DBNAME + '.information_schema.columns
              WHERE table_name = ''' + @IntoTBLNAME + ''' ORDER BY ORDINAL_POSITION';
        END
    ELSE
        BEGIN
            SET @MySql = 'SELECT
                   table_name
                   ,COLUMN_NAME
                   ,DATA_TYPE
                   ,character_maximum_length
                   ,numeric_precision
                   ,numeric_scale
                   ,IS_NULLABLE
              FROM information_schema.columns
              WHERE table_name = ''' + @IntoTBLNAME + ''' ORDER BY ORDINAL_POSITION';
        END;

    --DECLARE db_cursor CURSOR
    --    FOR
    --        SELECT
    --               table_name
    --               ,COLUMN_NAME
    --               ,DATA_TYPE
    --               ,character_maximum_length
    --               ,numeric_precision
    --               ,numeric_scale
    --               ,IS_NULLABLE
    --          FROM information_schema.columns
    --          WHERE table_name = @PullFromTbl
    --          ORDER BY
    --                   ORDINAL_POSITION;

    DECLARE @sqlstatement NVARCHAR (MAX) ;
    SET @sqlstatement = 'DECLARE db_cursor CURSOR FOR ' + CHAR (10) + @MySQl;

    EXEC ( @sqlstatement) ;

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;

    IF @IntoTBLNAME IS NULL
        BEGIN
            SET @mysql = 'INSERT INTO #' + @TBL + CHAR ( 10) ;
        END
    ELSE
        BEGIN
            IF @DBNAME IS NULL
                BEGIN
                    SET @mysql = 'INSERT INTO ' + @IntoTBLNAME + CHAR ( 10) ;
                END
            ELSE
                BEGIN
                    SET @mysql = 'INSERT INTO ' + @DBNAME + '.dbo.' + @IntoTBLNAME + CHAR ( 10) ;
                END;
        END;

    SET @mysql = @mysql + '(' + CHAR ( 10) ;
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @mysql = @mysql + '     ' + @col;
                    SET @mysql2 = @mysql2 + CHAR (10) + '     ' + @col;
                END;
            ELSE
                BEGIN
                    SET @mysql = @mysql + CHAR ( 10) + '      , ';
                    SET @mysql = @mysql + @col + ' ';
                    SET @mysql2 = @mysql2 + CHAR ( 10) + '     , ';
                    SET @mysql2 = @mysql2 + @col + ' ';
                END;

            FETCH NEXT FROM db_cursor INTO  @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
        END;

    SET @mysql = @mysql + ')' + CHAR ( 10) ;
    SET @mysql2 = @mysql2 + CHAR ( 10) + 'FROM ' + @PullFromTbl;

    SET @mysql = @mysql + ' ' + @mysql2;
    --PRINT  '**************************';

    --PRINT cast(@mysql as NTEXT);
    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    INSERT INTO ##TEMP_InsertDDL (
           DDL) 
    VALUES (@mysql) ;

    SET @DDL = @MySql;

END;
GO
PRINT 'Created proc_genSelectInto';
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
