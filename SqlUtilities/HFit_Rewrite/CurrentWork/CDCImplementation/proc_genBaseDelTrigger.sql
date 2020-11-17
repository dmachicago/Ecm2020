
GO
PRINT 'Executing proc_genBaseDelTrigger.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_genBaseDelTrigger') 
    BEGIN
        DROP PROCEDURE
             dbo.proc_genBaseDelTrigger;
    END;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO



/*-------------------------------------------------------------------------------------
use KenticoCMS_Datamart_2
select * from BASE_View_CMS_Tree_Joined
select * from information_schema.columns where table_name = 'BASE_View_CMS_Tree_Joined'

declare @OUT as nvarchar(max) = '' ;
declare @DDL as nvarchar(max) = '' ;
exec proc_genBaseDelTrigger 'BASE_MART_EDW_HealthAssesment', @DDL OUTPUT
set @OUT = (select @DDL);
select @OUT
*/

/*-----------------------------------------------------
*******************************************************
INSERT INTO TestTable (FirstName, LastName)
SELECT FirstName, LastName
FROM Person.Contact
*******************************************************
*/

CREATE PROCEDURE dbo.proc_genBaseDelTrigger (
       @BaseTable AS NVARCHAR (250) 
     , @DDL AS NVARCHAR (MAX) OUT) 
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

    -- DECLARE @BaseTable AS nvarchar ( 250 ) = 'view_EDW_HealthAssesment_CT';

    DECLARE
           @TBL NVARCHAR ( 100) 
         , @COL NVARCHAR ( 100) 
         , @DType AS NVARCHAR ( 50) 
         , @LEN AS INT
         , @PRECISION AS INT
         , @SCALE AS INT
         , @mysql AS NVARCHAR ( MAX) 
         , @mysql2 AS NVARCHAR ( MAX) = 'SELECT '
         , @i AS INT = 0
         , @IS_NULLABLE AS NVARCHAR ( 10) 
         , @TgtName  AS NVARCHAR ( 250) = ''
         , @TriggerName AS NVARCHAR ( 250) = '';

    SET @TriggerName = 'TRIG_DEL_' + @BaseTable;
    IF EXISTS (SELECT
                      *
               FROM sys.triggers
               WHERE
                      object_id = OBJECT_ID (@TriggerName)) 
        BEGIN
		  set @MySql = 'DROP TRIGGER ' + @TriggerName;
		  exec (@MySql) ;
        END;

    --*****************************************************************	   
    SET @TgtName = @BaseTable + '_DEL';
    PRINT '@TgtName: ' + @TgtName;
    EXEC mart_AddMissingColumns  @BaseTable , @TgtName;
    --*****************************************************************

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
            WHERE
                   table_name = @BaseTable
            ORDER BY
                     ORDINAL_POSITION;
    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @TBL , @COL , @DType , @LEN , @PRECISION , @SCALE , @IS_NULLABLE;
    SET @mysql = 'DECLARE @ACTION as char(1) = ''D'' ; ' + CHAR ( 10) ;
    SET @mysql = @mysql + 'INSERT INTO ' + @TBL + '_DEL' + CHAR ( 10) ;
    SET @mysql = @mysql + '(' + CHAR ( 10) ;
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @mysql = @mysql + '  [' + @col + ']';
                    SET @mysql2 = @mysql2 + CHAR (10) + '  [' + @col + ']';
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

    SET @mysql2 = REPLACE (@mysql2 , '[Action]' , '@Action') ;
    SET @mysql2 = REPLACE (@mysql2 , '[LASTMODIFIEDDATE]' , 'GetDate()') ;

    SET @mysql = @mysql + ')' + CHAR ( 10) ;
    --SET @mysql2 = @mysql2 + CHAR ( 10) + 'FROM ' + @BaseTable;
    SET @mysql2 = @mysql2 + CHAR ( 10) + 'FROM deleted ';
    SET @mysql = @mysql + ' ' + @mysql2;

    DECLARE
           @TrigDDL AS NVARCHAR (MAX) = 'CREATE TRIGGER TRIG_DEL_' + @BaseTable + CHAR (10) ;
    SET @TrigDDL = @TrigDDL + '    ON dbo.' + @BaseTable + CHAR (10) ;
    SET @TrigDDL = @TrigDDL + '    FOR DELETE AS ' + CHAR (10) ;
    SET @TrigDDL = @TrigDDL + 'BEGIN ' + CHAR (10) ;
    SET @TrigDDL = @TrigDDL + '-- Generated on: ' + cast(getdate() as nvarchar(50)) + CHAR (10) ;
    SET @TrigDDL = @TrigDDL + @mysql + CHAR (10) ;
    SET @TrigDDL = @TrigDDL + 'END; ' + CHAR (10) ;

    SELECT
           @DDL = @TrigDDL;

    --print 'TRIGGER DDL: ***************************************' ;
    --print @DDL ;
    --print '***************************************' ;
    CLOSE db_cursor;
    DEALLOCATE db_cursor;
END;

GO

PRINT 'EXecuted proc_genBaseDelTrigger.sql';
GO

