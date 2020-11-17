

GO
PRINT 'Executing proc_TableHasCol.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_TableHasCol') 
    BEGIN
        DROP PROCEDURE
             proc_TableHasCol
    END;
GO
/*
use KenticoCMS_DataMArt
exec proc_TableHasCol base_cms_user, userid
declare @i as int = 0 ; 
exec @i = proc_TableHasCol base_cms_user, userid   
print @i
select * from sys.procedures where name like '%comma%'
*/
CREATE PROCEDURE proc_TableHasCol (
       @TblName AS NVARCHAR (100) 
     , @ColName AS NVARCHAR (100)) 
AS
BEGIN

    DECLARE
           @rc AS INT = 0;

    SET @rc = (SELECT
                      count (*) 
               FROM information_schema.columns
               WHERE
                      table_name = @TblName AND
                      column_name = @ColName) ;

    RETURN @rc;
END;

GO
PRINT 'Executed proc_TableHasCol.sql';
GO