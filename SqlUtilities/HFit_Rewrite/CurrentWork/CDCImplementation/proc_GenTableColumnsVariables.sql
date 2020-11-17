

--SELECT COLUMN_NAME
--FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
--WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
--AND TABLE_NAME = 'CMS_WidgetRole' AND TABLE_SCHEMA = 'dbo'

GO
PRINT 'Executing proc_GenTableColumnsVariables.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'proc_GenTableColumnsVariables') 
    BEGIN
        PRINT 'Replacing function proc_GenTableColumnsVariables';
        DROP PROCEDURE
             proc_GenTableColumnsVariables;
    END;

GO
/*-----------------------------------------------------------
-- use KenticoCMS_DataMart_2
declare @COLS as nvarchar(max) = '' ;
declare @ReturnedCols as nvarchar(max) = null ;
declare @InstanceName as nvarchar(50) = 'KenticoCMS_DataMart'
declare @TblName as nvarchar(50) = 'BASE_HFit_TrackerCardio'
exec @COLS = proc_GenTableColumnsVariables @InstanceName, @TblName, @ReturnedCols OUT
set @COLS = @ReturnedCols ;
print @COLS ;
*/
CREATE PROCEDURE dbo.proc_GenTableColumnsVariables (
       @InstanceName NVARCHAR (100) 
     , @TblName NVARCHAR (100) 
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
    SET @S = @S + ' and column_name not like ''ct_%'' ' + CHAR (10) ;
    --print @S ;    
    EXEC (@S) ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COL, @DT, @Character_Maximum_Length;
    IF @@FETCH_STATUS <> 0
        BEGIN
            PRINT 'No PKs found';
            RETURN '';
        END;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @DT = 'nvarchar'
                BEGIN
                    SELECT
                           @TableCols = @TableCols + CHAR (10) + 'Declare @' + @COL + ' ' + @DT + '(' + CAST (@Character_Maximum_Length AS NVARCHAR (50)) + ') = NULL ;';
                END
            ELSE
                BEGIN IF @DT = 'varchar'
                          BEGIN
                              SELECT
                                     @TableCols = @TableCols + CHAR (10) + 'Declare @' + @COL + ' ' + @DT + '(' + CAST (@Character_Maximum_Length AS NVARCHAR (50)) + ') =NULL ;';
                          END
                      ELSE
                          BEGIN IF @DT = 'char'
                                    BEGIN
                                        SELECT
                                               @TableCols = @TableCols + CHAR (10) + 'Declare @' + @COL + ' ' + @DT + '(' + CAST (@Character_Maximum_Length AS NVARCHAR (50)) + ') =NULL ;';
                                    END
                                ELSE
                                    BEGIN
                                        SELECT
                                               @TableCols = @TableCols + CHAR (10) + 'Declare @' + @COL + ' ' + @DT + ' =NULL ;';
                                    END;
                          END;
                END;
            --PRINT @TableCols;
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
PRINT 'Executed proc_GenTableColumnsVariables.sql';
GO

