
GO
PRINT 'Creating proc_genFactUpdateTrigger';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_genFactUpdateTrigger') 
    BEGIN
        DROP PROCEDURE
             proc_genFactUpdateTrigger;
    END;
GO

/*
declare @S as nvarchar(max) = '' ;
declare @DDL as nvarchar(max) = '' ;
exec proc_genFactUpdateTrigger 'BASE_MART_EDW_HealthAssesment', @DDL
set @S = @DDL ;
print @S ;
*/

CREATE PROCEDURE proc_genFactUpdateTrigger (
     @FactTable AS nvarchar (250) 
   , @DDL AS nvarchar (max) OUT) 
AS
BEGIN

/*------------------------------------------------------------------------------
********************************************************************************
Author:	  W. Dale Miller
Date:	  11.12.2015
Copyright:  DMA, Ltd.
Purpose:	  Generates a DELETE TRIGGER for a FACT Table
Last Test:  10.19.2015 WDM
********************************************************************************
*/

    -- DECLARE @FactTable AS nvarchar ( 250 ) = 'view_EDW_HealthAssesment_CT';

    DECLARE
    @TBL nvarchar ( 100) 
  , @COL nvarchar ( 100) 
  , @DType AS nvarchar ( 50) 
  , @LEN AS int
  , @PRECISION AS int
  , @SCALE AS int
  , @mysql AS nvarchar ( max) 
  , @mysql2 AS nvarchar ( max) = 'SELECT '
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
                   WHERE table_name = @FactTable
                   ORDER BY
                            ORDINAL_POSITION;
    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
    SET @mysql = 'INSERT INTO ' + @TBL + '_UPDT' + CHAR ( 10) ;
    SET @mysql = @mysql + '(' + CHAR ( 10) ;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @mysql = @mysql + '     [' + @col +']';
                    SET @mysql2 = @mysql2 + CHAR (10) + '     [' + @col + ']';
                END;
            ELSE
                BEGIN
                    SET @mysql = @mysql + CHAR ( 10) + '      , ';
                    SET @mysql = @mysql + '[' + @col + '] ';
                    SET @mysql2 = @mysql2 + CHAR ( 10) + '     , ';
                    SET @mysql2 = @mysql2 + '[' + @col + '] ';
                END;

            FETCH NEXT FROM db_cursor INTO  @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
        END;

    SET @mysql = @mysql + ')' + CHAR ( 10) ;
    --SET @mysql2 = @mysql2 + CHAR ( 10) + 'FROM ' + @FactTable;
    SET @mysql2 = @mysql2 + CHAR ( 10) + 'FROM inserted ' ;
    SET @mysql = @mysql + ' ' + @mysql2;

    DECLARE @TrigDDL AS nvarchar (max) = 'CREATE TRIGGER TRIG_DEL_' + @FactTable + char(10) ;
    SET @TrigDDL = @TrigDDL + '    ON dbo.' + @FactTable + char(10) ;
    SET @TrigDDL = @TrigDDL + '    AFTER UPDATE ' + char(10) ;
    SET @TrigDDL = @TrigDDL + 'AS ' + char(10) ;
    SET @TrigDDL = @TrigDDL + 'BEGIN ' + char(10) ;
    SET @TrigDDL = @TrigDDL + @mysql + char(10) ;
    SET @TrigDDL = @TrigDDL + 'END; ' + char(10) ;

    SELECT @DDL = @TrigDDL;

    print 'TRIGGER DDL: ***************************************' ;
    print @DDL ;
    print '***************************************' ;
    CLOSE db_cursor;
    DEALLOCATE db_cursor;
END;
GO
PRINT 'Created proc_genFactUpdateTrigger';
GO
