USE [ECM.Library.FS];
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_DropAllFK'
)
    DROP PROCEDURE sp_DropAllFK;
GO

-- exec sp_DropAllFK 'Retention'
CREATE PROCEDURE sp_DropAllFK(@TBL NVARCHAR(250))
AS
    BEGIN
        DECLARE @cmd VARCHAR(4000);
        DECLARE @reftbl VARCHAR(4000);
        DECLARE @fk VARCHAR(4000);
        DECLARE MY_CURSOR CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY
        FOR 
		SELECT 'ALTER TABLE ' + OBJECT_SCHEMA_NAME(parent_object_id) + '.' + OBJECT_NAME(parent_object_id) + ' DROP CONSTRAINT ' + name + ';'
   FROM sys.foreign_keys 
   WHERE OBJECT_NAME(referenced_object_id) = @TBL
        OPEN MY_CURSOR;
        FETCH NEXT FROM MY_CURSOR INTO @cmd;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                --EXEC (@cmd)
                PRINT @cmd;
                FETCH NEXT FROM MY_CURSOR INTO @cmd;
            END;
        CLOSE MY_CURSOR;
        DEALLOCATE MY_CURSOR;
    END;
GO
--ALTER TABLE Retention DROP CONSTRAINT RefRetention16;