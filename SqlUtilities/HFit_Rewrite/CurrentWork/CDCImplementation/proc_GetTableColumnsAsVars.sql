

--SELECT COLUMN_NAME
--FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
--WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
--AND TABLE_NAME = 'CMS_WidgetRole' AND TABLE_SCHEMA = 'dbo'

GO
PRINT 'Executing proc_GetTableColumnsAsVars.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'proc_GetTableColumnsAsVars') 
    BEGIN
        PRINT 'Replacing function proc_GetTableColumnsAsVars';
        DROP PROCEDURE
             proc_GetTableColumnsAsVars;
    END;

GO
/*-----------------------------------------------------------
-- use KenticoCMS_DataMart_2
declare @COLS as nvarchar(max) = '' ;
declare @ReturnedCols as nvarchar(max) = null ;
declare @InstanceName as nvarchar(50) = 'KenticoCMS_DataMart_2'
declare @TblName as nvarchar(50) = 'BASE_HFit_TrackerCardio'
exec @COLS = proc_GetTableColumnsAsVars @InstanceName, @TblName, 1, @ReturnedCols OUT
set @COLS = @ReturnedCols ;
print @COLS ;
*/
CREATE PROCEDURE dbo.proc_GetTableColumnsAsVars (
       @InstanceName NVARCHAR (100) 
     , @TblName NVARCHAR (100) 
     , @SetAsUpdateVars INT = 0
     , @ReturnedCols NVARCHAR (MAX) OUT) 
AS
BEGIN
    --W. Dale Miller
    --June 20, 2012
    DECLARE @COL AS NVARCHAR (MAX) = '';
    DECLARE @DT AS NVARCHAR (MAX) = '';
    DECLARE @Character_Maximum_Length AS INT = 0;
    DECLARE @TableCols AS NVARCHAR (MAX) = '';
    DECLARE @S AS NVARCHAR (MAX) = '';

    IF CURSOR_STATUS ('global', 'PCursor') >= -1
        BEGIN
            DEALLOCATE PCursor;
        END;

    SET @S = 'DECLARE PCursor CURSOR FOR ' + CHAR (10) ;
    SET @S = @S + ' SELECT column_name, data_type, Character_Maximum_Length  ' + CHAR (10) ;
    SET @S = @S + ' FROM ' + @InstanceName + '.INFORMATION_SCHEMA.columns AS TC ' + CHAR (10) ;
    SET @S = @S + ' where TABLE_NAME = ''' + @TblName + '''' + CHAR (10) ;
    SET @S = @S + ' and COLUMN_NAME not like ''CT_%'' ' + CHAR (10) ;
    --print @S ;    
    EXEC (@S) ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COL, @DT, @Character_Maximum_Length;
    IF @@FETCH_STATUS <> 0
        BEGIN
            PRINT 'No PKs found';
            RETURN '';
        END;
    DECLARE @i AS INT = -1;
    WHILE @@FETCH_STATUS = 0
        BEGIN
		  set @i = @i +1;
            IF @SetAsUpdateVars = 0
                BEGIN
                    IF @i = 0
                        BEGIN
                            SELECT
                                   @TableCols = @TableCols + '    @' + @COL + CHAR (10) ;
                        END;
                    ELSE
                        BEGIN
                            SELECT
                                   @TableCols = @TableCols + '    , @' + @COL + CHAR (10) ;
                        END;
                END  ;
            ELSE
                BEGIN
                    IF @i = 0
                        BEGIN
                            SELECT
                                   @TableCols = @TableCols + '    ' + @COL + ' =    @' + @COL + CHAR (10) ;
                        END;
                    ELSE
                        BEGIN
                            SELECT
                                   @TableCols = @TableCols + '    ,' + @COL + ' =    @' + @COL + CHAR (10) ;
                        END;
                END;

            FETCH NEXT FROM PCursor INTO @COL, @DT, @Character_Maximum_Length;
        END;

    CLOSE PCursor;
    DEALLOCATE PCursor;
    IF LEN (@TableCols) > 0
        BEGIN
            DECLARE @k AS INT = LEN (@TableCols) ;
            SET @TableCols = SUBSTRING (@TableCols, 1, @k - 1) ;
        END;
    --print @TableCols ;
    SET @ReturnedCols = @TableCols;
END;
GO
PRINT 'Executed proc_GetTableColumnsAsVars.sql';
GO

