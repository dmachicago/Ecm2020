

--SELECT COLUMN_NAME
--FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
--WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
--AND TABLE_NAME = 'CMS_WidgetRole' AND TABLE_SCHEMA = 'dbo'

GO
PRINT 'Executing proc_GetTableColumnsCT.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'proc_GetTableColumnsCT') 
    BEGIN
        PRINT 'Replacing function proc_GetTableColumnsCT';
        DROP PROCEDURE
             proc_GetTableColumnsCT;
    END;

GO
/*-----------------------------------------------------------
use KenticoCMS_Datamart_2

declare @COLS as nvarchar(max) = '' ;
declare @ReturnedCols as nvarchar(max) = null ;
declare @InstanceName as nvarchar(50) = 'KenticoCMS_1'
declare @TblName as nvarchar(50) = 'EDW_RoleMemberHistory'
exec @COLS = proc_GetTableColumnsCT @InstanceName, @TblName, @ReturnedCols OUT
set @COLS = @ReturnedCols ;
print @COLS ;
*/
CREATE PROCEDURE dbo.proc_GetTableColumnsCT (
     @InstanceName nvarchar (100) 
   , @TblName nvarchar (100) 
   , @ReturnedCols nvarchar (max) OUT) 
AS
BEGIN
    --W. Dale Miller
    --June 20, 2012
    DECLARE @COL AS nvarchar (max) = '';
    DECLARE @TableCols AS nvarchar (max) = '';
    DECLARE @S AS nvarchar (max) = '';

    IF CURSOR_STATUS ('global', 'PCursor') >= -1
        BEGIN
            DEALLOCATE PCursor;
        END;

    SET @S = 'DECLARE PCursor CURSOR FOR ' + CHAR (10) ;
    SET @S = @S + ' SELECT column_name ' + CHAR (10) ;
    SET @S = @S + ' FROM '+@InstanceName+'.INFORMATION_SCHEMA.columns AS TC ' + CHAR (10) ;
    SET @S = @S + ' where TABLE_NAME = '''+@TblName+'''' + CHAR (10) ;
    SET @S = @S + ' and column_name not like ''LastModifiedDate''' + CHAR (10) ;
    SET @S = @S + ' and column_name not like ''CT[_]%''' + CHAR (10) ;

    --print @S ;    
    EXEC (@S) ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COL;
    IF @@FETCH_STATUS <> 0
        BEGIN
            PRINT 'No PKs found';
            RETURN '';
        END;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT
                   @TableCols = @TableCols + char(10) + '[' + @COL +']' + ',';
            --PRINT @TableCols;
            FETCH NEXT FROM PCursor INTO @COL;
        END;

    CLOSE PCursor;
    DEALLOCATE PCursor;
    IF LEN (@TableCols) > 0
        BEGIN
            DECLARE @k AS int = LEN (@TableCols) ;
            SET @TableCols = SUBSTRING (@TableCols, 1, @k - 1) ;
        END;
    --print @TableCols ;
    SET @ReturnedCols = @TableCols;
END;
GO
PRINT 'Executed proc_GetTableColumnsCT.sql';
GO

