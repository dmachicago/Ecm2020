
-- use KenticoCMS_DataMart_2
GO
PRINT 'Executing proc_IsColPrimaryKey.sql';
GO
IF EXISTS (SELECT
                  *
                  FROM   sys.procedures
                  WHERE  name = 'proc_IsColPrimaryKey') 
    BEGIN
        PRINT 'Replacing function proc_IsColPrimaryKey';
        DROP PROCEDURE
             proc_IsColPrimaryKey;
    END;

GO
/*-----------------------------------------------------------------------------------
exec sp_depends proc_IsColPrimaryKey

declare @InstanceName as nvarchar(50) = 'KenticoCMS_1'
declare @TblName as nvarchar(50) = 'CMS_User'
declare @I as integer = -1 ;
exec @I = proc_IsColPrimaryKey 'KenticoCMS_1', 'CMS_User' , 'USerID'
print @I 

*/
CREATE PROCEDURE dbo.proc_IsColPrimaryKey (
     @InstanceName nvarchar (100) 
   , @TblName nvarchar (100) 
    , @ColName nvarchar (100) ) 
AS
BEGIN
    --W. Dale Miller
    --June 20, 2012
    DECLARE @COL AS nvarchar (2000) = '';
    DECLARE @TableCols AS nvarchar (2000) = '';
    DECLARE @S AS nvarchar (max) = '';
    declare @I as integer =0 ;

    IF EXISTS (
            SELECT
                   @ColName
                   FROM
                       KenticoCMS_1.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
                           INNER JOIN
                           KenticoCMS_1.INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
                               ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
                              AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
                              AND ku.table_name = @TblName
                              AND column_name = @ColName) 
                BEGIN
                   set @I = 1 ;
                END;
    Return @I ;
END;
GO
PRINT 'Executed proc_IsColPrimaryKey.sql';
GO

