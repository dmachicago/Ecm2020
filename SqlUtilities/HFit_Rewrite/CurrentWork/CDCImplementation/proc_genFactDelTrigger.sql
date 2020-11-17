


go


go
print 'EXecuting proc_genFactDelTrigger.sql'
go
if exists (select name from sys.procedures where name = 'proc_genFactDelTrigger')
DROP PROCEDURE [dbo].[proc_genFactDelTrigger]
GO

/****** Object:  StoredProcedure [dbo].[proc_genFactDelTrigger]    Script Date: 11/24/2015 10:27:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- exec proc_genFactDelTrigger 'STAGING_CMS_UserSettings_Update_History'
-- exec proc_genFactDelTrigger 'STAGING_CMS_USER_Update_History'
-- exec proc_genFactDelTrigger 'STAGING_EDW_HealthInterestDetail'
-- exec proc_genFactDelTrigger 'View_HFit_HealthAssessment_Joined'
-- exec proc_genFactDelTrigger 'STAGING_EDW_SmallSteps'
-- exec proc_genFactDelTrigger 'STAGING_EDW_HealthInterestDetail'
-- exec proc_genFactDelTrigger 'CMS_UserSettings'
-- exec proc_genFactDelTrigger 'CMS_USER'
-- exec proc_genFactDelTrigger 'FACT_CMS_Class'
-- exec proc_genFactDelTrigger 'FACT_HFit_HealthAssessment'
-- exec proc_genFactDelTrigger 'VIEW_EDW_PULLHADATA_NOCT'
-- exec proc_genFactDelTrigger 'STAGING_EDW_HealthAssessment'

/*-------------------------------------------------------
declare @OUT as nvarchar(max) = '' ;
declare @DDL as nvarchar(max) = '' ;
exec proc_genFactDelTrigger 'FACT_CMS_Document', @DDL OUTPUT
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

CREATE PROCEDURE [dbo].[proc_genFactDelTrigger] (
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
      SET @mysql = 'DECLARE @ACTION as char(1) = ''D'' ; '+ CHAR ( 10) ;
    SET @mysql = @mysql  + 'INSERT INTO ' + @TBL + '_DEL' + CHAR ( 10) ;
    SET @mysql = @mysql + '(' + CHAR ( 10) ;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @i = @i + 1;
            IF @i = 1
                BEGIN
                    SET @mysql = @mysql + '  [' + @col +']';
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
    

  SET @mysql2 = replace(@mysql2, '[Action]', '@Action');
  SET @mysql2 = replace(@mysql2, '[LASTMODIFIEDDATE]', 'GetDate()');

    SET @mysql = @mysql + ')' + CHAR ( 10) ;
    --SET @mysql2 = @mysql2 + CHAR ( 10) + 'FROM ' + @FactTable;
    SET @mysql2 = @mysql2 + CHAR ( 10) + 'FROM deleted ' ;
    SET @mysql = @mysql + ' ' + @mysql2;

    DECLARE @TrigDDL AS nvarchar (max) = 'CREATE TRIGGER TRIG_DEL_' + @FactTable + char(10) ;
    SET @TrigDDL = @TrigDDL + '    ON dbo.' + @FactTable + char(10) ;
    SET @TrigDDL = @TrigDDL + '    FOR DELETE ' + char(10) ;
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

print 'EXecuted proc_genFactDelTrigger.sql'
go

