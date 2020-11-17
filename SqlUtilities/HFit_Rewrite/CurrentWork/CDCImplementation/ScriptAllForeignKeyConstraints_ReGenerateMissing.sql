
-- use KenticoCMS_1
GO
PRINT 'Executing ScriptAllForeignKeyConstraints_ReGenerateMissing.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'ScriptAllForeignKeyConstraints_ReGenerateMissing') 
    BEGIN
        DROP PROCEDURE ScriptAllForeignKeyConstraints_ReGenerateMissing;
    END;
GO
-- drop FK_Board_Board_BoardSiteID_CMS_Site
-- ALTER TABLE Board_Board DROP CONSTRAINT FK_Board_Board_BoardSiteID_CMS_Site; 
-- SELECT * FROM sys.foreign_keys where name = 'FK_Board_Board_BoardSiteID_CMS_Site'
-- select object_name(1351675863)
-- exec ScriptAllForeignKeyConstraints_ReGenerateMissing 1
-- select * from TEMP_FK_Constraints
-- select * from PERM_FK_Constraints
CREATE PROCEDURE ScriptAllForeignKeyConstraints_ReGenerateMissing (@PreviewOnly AS bit = 0) 
AS
BEGIN
    SET NOCOUNT ON;

/*----------------------------------------------------------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  All foreign keys' DDL will be regenerated if determined to be missing.
		  exec ScriptAllForeignKeyConstraints_ReGenerateMissing

*/

    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'PERM_FK_Constraints') 
        BEGIN
            SELECT * INTO PERM_FK_Constraints
              FROM TEMP_FK_Constraints;
        END;

    DECLARE
          @ForeignKeyID AS bigint = 0 , 
          @GenSql AS nvarchar (max) 
		,@ForeignKeyName AS nvarchar (500) ;

    DECLARE CursorFKRegen CURSOR
        FOR SELECT ForeignKeyName, ForeignKeyID , 
                   GenSql
              FROM PERM_FK_Constraints as P
		    where p.ForeignKeyName not in (SELECT Name FROM sys.foreign_keys);

    OPEN CursorFKRegen;
    FETCH NEXT FROM CursorFKRegen INTO @ForeignKeyName, @ForeignKeyID , @GenSql;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF NOT EXISTS (SELECT name
                             FROM sys.foreign_keys where name = @ForeignKeyName) 
                BEGIN
                    BEGIN TRY
                        IF @PreviewOnly = 1
                            BEGIN
                                PRINT 'PREVIEW: ' + @GenSql;
                            END;
                        ELSE
					   PRINT 'RECREATING: ' + @ForeignKeyName;
                            BEGIN EXEC (@GenSql) ;
                            END;
                    END TRY
                    BEGIN CATCH
                        PRINT 'ERROR IN: ' + @GenSql;
                    END CATCH;
                END;
            ELSE
                BEGIN
                    PRINT 'SKIPPING ALREADY EXIST: ' + @ForeignKeyName;
                END;
            FETCH NEXT FROM CursorFKRegen INTO @ForeignKeyName, @ForeignKeyID , @GenSql;
        END;
    CLOSE CursorFKRegen;
    DEALLOCATE CursorFKRegen;
    SET NOCOUNT OFF;

END;
GO
PRINT 'Executed ScriptAllForeignKeyConstraints_ReGenerateMissing.sql';
GO