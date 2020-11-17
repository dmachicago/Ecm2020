

-- use KenticoCMS_Datamart_2
GO
PRINT 'Creating proc_genSelectInto';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_genSelectInto' )
    BEGIN
        DROP PROCEDURE
             proc_genSelectInto;
    END;
GO
-- exec proc_genSelectInto 'STAGING_CMS_UserSettings_Update_History'
-- exec proc_genSelectInto 'STAGING_CMS_USER_Update_History'
-- exec proc_genSelectInto 'STAGING_EDW_HealthInterestDetail'
-- exec proc_genSelectInto 'View_HFit_HealthAssessment_Joined'
-- exec proc_genSelectInto 'STAGING_EDW_SmallSteps'
-- exec proc_genSelectInto 'VIEW_HFIT_HEALTHASSESSMENT_JOINED'
-- exec proc_genSelectInto 'CMS_UserSettings'
-- exec proc_genSelectInto 'BASE_CMS_USER'
-- exec proc_genSelectInto 'KenticoCMS_1', 'BASE_CMS_USER', 'CMS_USER'
-- exec proc_genSelectInto 'FACT_EDW_HealthAssesment'
-- exec proc_genSelectInto 'FACT_HFit_HealthAssessment'
/*
declare @S as nvarchar(max) ;
declare @DDL as nvarchar(max)
exec proc_genSelectInto 'KenticoCMS_1', 'BASE_CMS_USER', 'CMS_USER', DDL
select * from ##TEMP_InsertDDL
set @s = @DDL ;
select @S
*/
-- exec proc_genSelectInto 'STAGING_EDW_HealthAssessment'

-- use KenticoCMS_Datamart_2

/********************************************************
INSERT INTO TestTable (FirstName, LastName)
SELECT FirstName, LastName
FROM Person.Contact
********************************************************/

CREATE PROCEDURE proc_genSelectInto (@DBNAME as nvarchar(100), 
@TBLNAME AS nvarchar( 250 ), @IntoTBLNAME AS nvarchar( 250 ) = null, @DDL as nvarchar(max) out )
AS
BEGIN

/*********************************************************************************
Author:	  W. Dale Miller
Date:	  09.22.2003
Copyright:  DMA, Ltd.
Purpose:	  Generates a select into statement from a table or view. This method 
		  is used when table is already created in the database earlier and 
		  data is to be inserted into this table from another table.
Last Test:  10.19.2015 WDM
*********************************************************************************/

    -- DECLARE @TBLNAME AS nvarchar ( 250 ) = 'view_EDW_HealthAssesment_CT';

        IF OBJECT_ID ('tempdb..##TEMP_InsertDDL') IS NOT NULL
        BEGIN DROP TABLE
                   ##TEMP_InsertDDL;
        END;

	   create table ##TEMP_InsertDDL (DDL nvarchar(max)) ;

    DECLARE
       @TBL nvarchar ( 250 )
       ,@COL nvarchar ( 250 )
       ,@DType AS nvarchar ( 50 )
       ,@LEN AS int
       ,@PRECISION AS int
       ,@SCALE AS int
       ,@mysql AS nvarchar ( max )
       ,@mysql2 AS nvarchar ( max ) = 'SELECT '
       ,@i AS int = 0
       ,@IS_NULLABLE AS nvarchar ( 10 );

if @DBNAME is not null
set @MySql = 'SELECT
                   table_name
                   ,COLUMN_NAME
                   ,DATA_TYPE
                   ,character_maximum_length
                   ,numeric_precision
                   ,numeric_scale
                   ,IS_NULLABLE
              FROM '+@DBNAME+'.information_schema.columns
              WHERE table_name = '''+@TBLNAME+''' ORDER BY ORDINAL_POSITION'
else 
set @MySql = 'SELECT
                   table_name
                   ,COLUMN_NAME
                   ,DATA_TYPE
                   ,character_maximum_length
                   ,numeric_precision
                   ,numeric_scale
                   ,IS_NULLABLE
              FROM information_schema.columns
              WHERE table_name = '''+@TBLNAME+''' ORDER BY ORDINAL_POSITION' 

declare @sqlstatement nvarchar(max) ;

set @sqlstatement = 'DECLARE db_cursor CURSOR FOR ' +char(10) + @MySQl ;
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
    --          WHERE table_name = @TBLNAME
    --          ORDER BY
    --                   ORDINAL_POSITION;
    print @sqlstatement ;
    exec ( @sqlstatement );

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
    
    if @IntoTBLNAME is null
	   SET @mysql = 'INSERT INTO #' + @TBL + CHAR ( 10 );
    else 
	   if @DBNAME is null 
		  SET @mysql = 'INSERT INTO ' + @IntoTBLNAME + CHAR ( 10 ) ;
		  else 
		  SET @mysql = 'INSERT INTO ' +@DBNAME+'.dbo.' + @IntoTBLNAME + CHAR ( 10 ) ;

    SET @mysql = @mysql + '(' + CHAR ( 10 );
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @mysql = @mysql + '     ' + @col;
                    SET @mysql2 = @mysql2 + char(10) + '     ' + @col;
                END;
            ELSE
                BEGIN
                    SET @mysql = @mysql + CHAR ( 10 ) + '      , ';
                    SET @mysql = @mysql + @col + ' ';
                    SET @mysql2 = @mysql2 + CHAR ( 10 ) + '     , ';
                    SET @mysql2 = @mysql2 + @col + ' ';
                END;

            FETCH NEXT FROM db_cursor INTO  @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
        END;

    SET @mysql = @mysql + ')' + CHAR ( 10 );
    SET @mysql2 = @mysql2 + CHAR ( 10 ) + 'FROM ' + @TBLNAME;


SET @mysql = @mysql + ' ' + @mysql2 ;
    --PRINT  '**************************';

    --PRINT cast(@mysql as NTEXT);
    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    insert into ##TEMP_InsertDDL (DDL) values (@mysql) ;

    set @DDL = @MySql ;
    

END;
GO
PRINT 'Created proc_genSelectInto';
GO
