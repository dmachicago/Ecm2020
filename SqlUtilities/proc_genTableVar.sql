
GO
PRINT 'FROM: proc_genTableVar.sql';
PRINT 'Creating proc_getPKeyCols';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_getPKeyCols') 
    BEGIN
        DROP PROCEDURE
             proc_getPKeyCols;
    END;
GO
-- Use KenticoCMS_Datamart_2
-- exec proc_getPKeyCols FACT_HFit_UserTracker, a
CREATE PROCEDURE proc_getPKeyCols (
     @tblname AS nvarchar (250) 
   , @pkcols nvarchar (max) OUTPUT) 
AS
BEGIN

/*****************************************************************************************************************
Author:	  W. Dale Miller
Date:	  09.22.2003
Copyright:  DMA, Ltd.
Purpose:	  Returns a list of columns used to define the PRIMARY key associated with this table if any are defined.
*****************************************************************************************************************/

    DECLARE
    @collist nvarchar ( max) 
  , @col AS nvarchar ( 250) 
  , @i AS int = 0;
    DECLARE PK_Cur CURSOR
        FOR
            SELECT
                   column_name
                   FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                   WHERE
                   OBJECTPROPERTY ( OBJECT_ID ( constraint_name) , 'IsPrimaryKey') = 1
               AND table_name = @tblname
                   ORDER BY
                            column_name;
    OPEN PK_Cur;
    FETCH NEXT FROM PK_Cur INTO @col;
    SET @collist = '';
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @i = 0
                BEGIN
                    SET @collist = @collist + @col;
                END;
            ELSE
                BEGIN
                    SET @collist = @collist + ', ' + @col;
                END;
            FETCH NEXT FROM PK_Cur INTO  @col;
            SET @i = @i + 1;
        END;

    --PRINT @collist;

    CLOSE PK_Cur;
    DEALLOCATE PK_Cur;
    SET @pkcols = @collist;

	   select @pkcols;

END;
GO
PRINT 'Created proc_getPKeyCols';
GO
PRINT 'Creating proc_genTableVar';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_genTableVar') 
    BEGIN
        DROP PROCEDURE
             proc_genTableVar;
    END;
GO

-- exec proc_genTableVar 'View_HFit_HealthAssessment_Joined'
-- exec proc_genTableVar 'TEMP_HA_HashKeys_2'
-- exec proc_genTableVar 'View_HFit_HACampaign_Joined'
-- exec proc_genTableVar 'HFit_HealthAssesmentUserQuestion'
-- exec proc_genTableVar 'CMS_SITE'
-- exec proc_genTableVar 'CMS_USER'
-- exec proc_genTableVar '[HumanResources].[Employee]'

/********************************************************
    SELECT * FROM information_schema.columns
    WHERE table_name = 'CMS_Document'
    ORDER BY ORDINAL_POSITION;    --DocumentGroupWebParts
********************************************************/

-- exec proc_genTableVar view_EDW_HealthAssessment_MART_CMS3
CREATE PROCEDURE proc_genTableVar (
     @TBLNAME AS nvarchar (250)) 
AS
BEGIN

/*********************************************************************************
Author:	  W. Dale Miller
Date:	  09.22.2003
Copyright:  DMA, Ltd.
Purpose:	  Generates the SQL to create a TABLE VAR from an existing table or view.
*********************************************************************************/

    DECLARE
    @TBL nvarchar ( 100) 
  , @COL nvarchar ( 100) 
  , @DType AS nvarchar ( 50) 
  , @LEN AS int
  , @PRECISION AS int
  , @SCALE AS int
  , @mysql AS nvarchar ( max) 
  , @i AS int = 0
  , @IS_NULLABLE AS nvarchar ( 10) ;
    DECLARE db_cursor CURSOR
        FOR
            SELECT
                   table_name
                 , COLUMN_NAME
                 , DATA_TYPE
                 , character_maximum_length
                 , numeric_precision
                 , numeric_scale
                 , IS_NULLABLE
                   FROM information_schema.columns
                   WHERE table_name = @TBLNAME
                   ORDER BY
                            ORDINAL_POSITION;
    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
    SET @mysql = 'DECLARE' + CHAR ( 10) ;
    SET @mysql = @mysql + '@' + @TBL + CHAR ( 10) ;
    SET @mysql = @mysql + 'TABLE' + CHAR ( 10) ;
    SET @mysql = @mysql + '(' + CHAR ( 10) ;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @mysql = @mysql + @col + ' ' + @DType + ' ';
                END;
            ELSE
                BEGIN
                    SET @mysql = @mysql + CHAR ( 10) + ', ';
                    SET @mysql = @mysql + @col + ' ' + @DType + ' ';
                END;

            IF @DType = 'decimal'
                BEGIN
                    SET @mysql = @mysql + '(' + CAST ( @PRECISION AS nvarchar ( 100)) + ',' + CAST ( @SCALE AS nvarchar ( 100)) + ')';
                END;
            IF @DType = 'datetime2'
                BEGIN
                    SET @mysql = @mysql + '(7)';
                END;
            IF @LEN IS NOT NULL
                BEGIN
                    IF @LEN < 0
                        BEGIN
                            SET @mysql = @mysql + '(max)';
                        END;
                    ELSE
                        BEGIN
                            SET @mysql = @mysql + ' (' + CAST ( @LEN AS nvarchar ( 100)) + ')';
                        END;
                END;

            IF @IS_NULLABLE = 'NO'
                BEGIN
                    SET @mysql = @mysql + ' NOT NULL ';
                END;
            ELSE
                BEGIN
                    SET @mysql = @mysql + ' NULL ';
                END;

            FETCH NEXT FROM db_cursor INTO  @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
        END;
    DECLARE
    @KCols AS nvarchar ( max) ;
    EXEC proc_getPKeyCols @TBL , @KCols OUTPUT;

    --PRINT '@KCols: ' + @KCols;

    SET @KCols = LTRIM ( RTRIM ( @KCols)) ;
    DECLARE
    @collen AS int = ( SELECT
                              DATALENGTH ( @KCols));
    IF @collen > 0
        BEGIN
            SET @mysql = @mysql + CHAR ( 10) + ' PRIMARY KEY ( ' + CAST ( @KCols AS nvarchar ( max)) + ' )' + CHAR ( 10) ;
        END;
    ELSE
        BEGIN
            SET @mysql = @mysql + CHAR ( 10) + ' -- PRIMARY KEY (col1, col2)' + CHAR ( 10) ;
        END;
    SET @mysql = @mysql + ')' + CHAR ( 10) ;

    --PRINT  '**************************';
    
    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    PRINT @mysql;
    select @mysql;

END;
GO
PRINT 'Created proc_genTableVar';
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
