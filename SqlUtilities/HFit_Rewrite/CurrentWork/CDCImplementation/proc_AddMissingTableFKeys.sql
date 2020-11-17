
GO
PRINT 'EXecuting proc_AddMissingTableFKeys.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_AddMissingTableFKeys') 
    BEGIN
        DROP PROCEDURE
             proc_AddMissingTableFKeys
    END;
GO
-- exec proc_AddMissingTableFKeys 
CREATE PROCEDURE proc_AddMissingTableFKeys (@TblName as nvarchar(250))
AS
BEGIN
/*
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  Finds and Recreates all missing foreign keys on the passed in table.
*/
    --**********************************************************************
    -- Recreate all missing foreign keys.
    --**********************************************************************

    IF OBJECT_ID('TEMP_FK_Constraints')IS NULL 
            BEGIN
                exec PrintImmediate 'TEMP_FK_Constraints table has no data, returning.' ;
			 return 0 ;
            END;

   IF (select count(*) from TEMP_FK_Constraints) = 0 
            BEGIN
                exec PrintImmediate 'TEMP_FK_Constraints table has ZERO records, returning.' ;
			 return 0 ;
            END;

     exec PrintImmediate 'EXECUTING proc_AddMissingTableFKeys' ;

    DECLARE @ForeignKeyName VARCHAR (4000) ;
    DECLARE @GenSql AS  NVARCHAR (4000) = '';
    DECLARE CFkey CURSOR
        FOR
            SELECT
                   ForeignKeyName
                 , GenSql
                   FROM TEMP_FK_Constraints
                   WHERE ParentTableName = @TblName;
    OPEN CFkey;

    FETCH NEXT FROM CFkey INTO @ForeignKeyName, @GenSql;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            IF NOT EXISTS (SELECT
                                  *
                                  FROM sys.objects AS o
                                  WHERE o.object_id = OBJECT_ID (@ForeignKeyName) 
                                    AND OBJECTPROPERTY (o.object_id, N'IsForeignKey') = 1) 
                BEGIN
				exec PrintImmediate  @GenSql;
				begin try
                    EXEC (@GenSql) ;
				    end try
				begin catch
				    print 'ERROR: ' + @GenSql
				end catch
                    
                END;

            FETCH NEXT FROM CFkey INTO @ForeignKeyName, @GenSql;
        END;
    CLOSE CFkey;
    DEALLOCATE CFkey;
END;
GO
PRINT 'Executed proc_AddMissingTableFKeys.sql';
GO