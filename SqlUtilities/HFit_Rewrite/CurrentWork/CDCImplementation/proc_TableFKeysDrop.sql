
-- use KenticoCMS_Datamart_2
GO
PRINT 'Executing proc_TableFKeysDrop.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_TableFKeysDrop') 
    BEGIN
        DROP PROCEDURE
             proc_TableFKeysDrop;
    END;
GO      
-- exec proc_TableFKeysDrop CMS_ScheduledTask
CREATE PROCEDURE proc_TableFKeysDrop (
       @TableName AS NVARCHAR (250)) 
AS
BEGIN

/*--------------------------------------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  Finds and drops any foreign keys on the passed in table.
*/

    --**********************************************************************
    -- Generated the DROP statements for the specified table.
    --**********************************************************************
    EXEC dropAllForeignKeyCONSTRAINTS @TableName;

    --**********************************************************************
    -- Remove all foreign from specified table.
    --**********************************************************************
    --select * from TEMP_DROPFK
    DECLARE
           @msg AS NVARCHAR (2000) = ''
         ,@DropSql AS  NVARCHAR (4000) = ''
         ,@ChildTABLENAME AS  NVARCHAR (500) = ''
         ,@PARENTTABLENAME AS  NVARCHAR (500) = ''
         ,@FOREIGNKEYNAME AS  NVARCHAR (500) = '';

    --CREATE TABLE TEMP_DROPFK
    --(
    --                ParentTableName NVARCHAR (250) NOT NULL
    --            , ChildTableName NVARCHAR (250) NOT NULL
    --            , ForeignKeyName NVARCHAR (250) NOT NULL
    --            , DropSql NVARCHAR (4000) NULL
    --);

    DECLARE CFkey CURSOR
        FOR
            SELECT
                   PARENTTABLENAME
                 , ChildTABLENAME
                 , FOREIGNKEYNAME
                 , DropSql
            FROM TEMP_DROPFK
            WHERE
                   ParentTableName = @TableName;
    OPEN CFkey;

    FETCH NEXT FROM CFkey INTO @PARENTTABLENAME , @ChildTABLENAME , @FOREIGNKEYNAME , @DropSql;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            IF EXISTS (SELECT
                              CONSTRAINT_NAME
                       FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
                       WHERE
                              CONSTRAINT_NAME = @FOREIGNKEYNAME AND
                              CONSTRAINT_SCHEMA = 'dbo') 
                BEGIN
                    SET @msg = 'DROPPING FK, ' + @FOREIGNKEYNAME + ' on ' + @PARENTTABLENAME + '.';
                    EXEC PrintImmediate @msg;
                    EXEC PrintImmediate  @DropSql;
                    EXEC (@DropSql) ;

                END;
            ELSE
                BEGIN
                    SET @msg = 'WARNING FK, ' + @FOREIGNKEYNAME + ' not found.';
                    EXEC PrintImmediate @msg;

                END;
            FETCH NEXT FROM CFkey INTO @PARENTTABLENAME , @ChildTABLENAME , @FOREIGNKEYNAME , @DropSql;
        END;
    CLOSE CFkey;
    DEALLOCATE CFkey;
END;
GO
PRINT 'Executed proc_TableFKeysDrop.sql';
GO