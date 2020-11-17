
-- use KenticoCMS_DataMart_2
GO
PRINT 'Executing proc_IsColIdentity.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'proc_IsColIdentity') 
    BEGIN
        PRINT 'Replacing function proc_IsColIdentity';
        DROP PROCEDURE
             proc_IsColIdentity;
    END;

GO
/*-----------------------------------------------------------------------------
-------------------------------------------------------------------------------
-----------------------------------------------------------

declare @InstanceName as nvarchar(50) = 'KenticoCMS_1'
declare @TblName as nvarchar(50) = '[CMS_User]'
declare @I as integer = -1 ;
exec @I = proc_IsColIdentity 'KenticoCMS_1', 'CMS_User' , 'USerID'
print @I 
*/
CREATE PROCEDURE dbo.proc_IsColIdentity (@InstanceName nvarchar (100) , @TblName nvarchar (100) , @ColName nvarchar (100)) 
AS
BEGIN
    --W. Dale Miller
    --June 20, 2012

set @ColName = replace(@ColName, '[', '');
set @ColName = replace(@ColName, ']', '');

    --DECLARE @InstanceName AS nvarchar (50) = 'KenticoCMS_1';
    --DECLARE @TblName AS nvarchar (50) = 'CMS_User';
    --DECLARE @ColName AS nvarchar (50) = 'UserID';

    DECLARE @COL AS nvarchar (2000) = '';
    DECLARE @TableCols AS nvarchar (2000) = '';
    DECLARE @S AS nvarchar (max) = '';
    DECLARE @I AS integer = 0;

    DECLARE @MySql AS nvarchar (500) = '';

    SET @MySql = '    SELECT count(*) ' + CHAR (10) ;
    --set @MySql = @MySql + '           b.name AS IdentityColumn ' + char(10) ;
    SET @MySql = @MySql + '           FROM ' + CHAR (10) ;
    SET @MySql = @MySql + '               sysobjects AS a ' + CHAR (10) ;
    SET @MySql = @MySql + '                   INNER JOIN syscolumns AS b ' + CHAR (10) ;
    SET @MySql = @MySql + '                       ON a.id = b.id ' + CHAR (10) ;
    SET @MySql = @MySql + '           WHERE ' + CHAR (10) ;
    SET @MySql = @MySql + '           COLUMNPROPERTY (a.id, b.name, ''isIdentity'') = 1 ' + CHAR (10) ;
    SET @MySql = @MySql + '       AND OBJECTPROPERTY (a.id, ''isTable'') = 1 ' + CHAR (10) ;
    SET @MySql = @MySql + '       AND b.name = ''' + @ColName + '''' + CHAR (10) ;
    --print @MySql ;

    DECLARE @result TABLE (
                          iCnt bigint) ;
    INSERT INTO @result (
           iCnt) 
    EXEC (@MySql) ;
    DECLARE @rowcount AS int = (SELECT TOP (1) 
                                       iCnt
                                       FROM @result);

    IF @rowcount > 0
        BEGIN
            SET @I = 1
        END;
    --PRINT @I;
    RETURN @I;
END;
GO
PRINT 'Executed proc_IsColIdentity.sql';
GO

