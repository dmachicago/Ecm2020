
-- use KenticoCMS_Datamart_2
GO
PRINT 'Executing proc_GetTableColumnsNoIdentity.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'proc_GetTableColumnsNoIdentity') 
    BEGIN
        PRINT 'Replacing function proc_GetTableColumnsNoIdentity';
        DROP PROCEDURE
             proc_GetTableColumnsNoIdentity;
    END;

GO
/*-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-----------------------------------------------------------
declare @MySql as nvarchar(2000) = '' ;
declare @ReturnedCols as nvarchar(2000) = null ;
declare @InstanceName as nvarchar(50) = 'KenticoCMS_1'
declare @TblName as nvarchar(50) = 'CMS_User'
exec @MySql = proc_GetTableColumnsNoIdentity @InstanceName, @TblName, @ReturnedCols OUT
set @MySql = @ReturnedCols ;
print @MySql ;
*/
CREATE PROCEDURE dbo.proc_GetTableColumnsNoIdentity (
     @InstanceName nvarchar (100) 
   , @TblName nvarchar (100) 
   , @ReturnedCols nvarchar (2000) OUT) 
AS
BEGIN
    --W. Dale Miller
    --June 20, 2012
    DECLARE @COL AS nvarchar (2000) = '';
    DECLARE @TableCols AS nvarchar (2000) = '';
    DECLARE @S AS nvarchar (max) = '';

    IF CURSOR_STATUS ('global', 'PCursor') >= -1
        BEGIN
            DEALLOCATE PCursor;
        END;

    --select * from KenticoCMS_1.INFORMATION_SCHEMA.columns where table_name = 'CMS_USER'

    SET @S = 'DECLARE PCursor CURSOR FOR ' + CHAR (10) ;
    SET @S = @S + ' SELECT column_name ' + CHAR (10) ;
    SET @S = @S + ' FROM ' + @InstanceName + '.INFORMATION_SCHEMA.columns AS TC ' + CHAR (10) ;
    SET @S = @S + ' where TABLE_NAME = ''' + @TblName + '''' + CHAR (10) ;
    SET @S = @S + ' and column_name NOT in  ' + CHAR (10) ;
    SET @S = @S + ' ( ' + CHAR (10) ;
    SET @S = @S + ' select b.name as IdentityColumn ' + CHAR (10) ;
    SET @S = @S + ' from sysobjects a inner join syscolumns b on a.id = b.id ' + CHAR (10) ;
    SET @S = @S + ' where columnproperty(a.id, b.name, ''isIdentity'') = 1 ' + CHAR (10) ;
    SET @S = @S + ' and objectproperty(a.id, ''isTable'') = 1 ' + CHAR (10) ;
    SET @S = @S + ' and a.name = ''' + @TblName + '''' + CHAR (10) ;
    SET @S = @S + ' ) ' + CHAR (10) ;
    --PRINT @S;
    EXEC (@S) ;

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COL;
    IF @@FETCH_STATUS <> 0
        BEGIN
            PRINT 'No PKs found';
            RETURN '';
        END;

/*-----------------------------------------------------
select
    b.name as IdentityColumn
from
    sysobjects a inner join syscolumns b on a.id = b.id
where
    columnproperty(a.id, b.name, 'isIdentity') = 1
    and objectproperty(a.id, 'isTable') = 1
    and a.name = 'BASE_HFit_TrackerSitLess'
*/

    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF NOT EXISTS (
            SELECT
                   @COL
                   FROM
                       KenticoCMS_1.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
                           INNER JOIN
                           KenticoCMS_1.INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
                               ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
                              AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
                              AND ku.table_name = @TblName
                              AND column_name = @COL) 
                BEGIN
                    --S.[ToDoTitle] = T.[ToDoTitle],
                    SELECT
                           @TableCols = @TableCols + CHAR (10) + 'S.[' + @COL + '] = T.[' + @COL + '],';
                END;
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
PRINT 'Executed proc_GetTableColumnsNoIdentity.sql';
GO

