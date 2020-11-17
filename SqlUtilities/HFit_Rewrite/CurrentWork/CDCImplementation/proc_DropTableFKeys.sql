
GO
PRINT 'EXecuting proc_DropTableFKeys.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_DropTableFKeys') 
    BEGIN
        DROP PROCEDURE
             proc_DropTableFKeys
    END;
GO
-- exec proc_DropTableFKeys CMS_ScheduledTask
CREATE PROCEDURE proc_DropTableFKeys (
       @TableName AS NVARCHAR (250)) 
AS
BEGIN
/*
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  Finds and drops any foreign keys on the passed in table.
*/

    --**********************************************************************
    -- Remove all foreign from specified table.
    --**********************************************************************
    DECLARE @TblName AS NVARCHAR (250) = 'CMS_ScheduledTask';
    DECLARE @DropSql AS  NVARCHAR (4000) = '';
    DECLARE CFkey CURSOR
        FOR
            SELECT
                   DropSql
                   FROM ##DropFK
                   WHERE ParentTableName = @TblName;
    OPEN CFkey;

    FETCH NEXT FROM CFkey INTO @DropSql;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC (@DropSql) ;
            exec PrintImmediate  @DropSql;
            FETCH NEXT FROM CFkey INTO @TableName;
        END;
    CLOSE CFkey;
    DEALLOCATE CFkey;
END;
GO
PRINT 'Executed proc_DropTableFKeys.sql';
GO