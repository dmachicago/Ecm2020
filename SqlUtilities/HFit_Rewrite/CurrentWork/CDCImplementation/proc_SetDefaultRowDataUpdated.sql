
USE kenticoCMS_Datamart_2;

GO
PRINT 'Executing proc_SetDefaultRowDataUpdated.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_SetDefaultRowDataUpdated') 
    BEGIN
        DROP PROCEDURE
             proc_SetDefaultRowDataUpdated;
    END;
GO

-- exec proc_SetDefaultRowDataUpdated 1

CREATE PROCEDURE proc_SetDefaultRowDataUpdated (
       @PreviewOnly AS BIT = 0) 
AS
BEGIN
    DECLARE
         @MySql AS NVARCHAR (MAX) 
       , @Table_name AS NVARCHAR (250) = ''
       , @Column_name AS NVARCHAR (250) = '';

    DECLARE C CURSOR
        FOR
            SELECT
                   Table_name
                 , Column_name
            FROM information_schema.columns
            WHERE
                   column_name = 'CT_RowDataUpdated' AND
                   TABLE_SCHEMA = 'dbo' AND column_default IS NULL AND table_name NOT LIKE '%_DEL'
            ORDER BY
                     table_name;

    OPEN C;

    FETCH NEXT FROM C INTO @Table_name , @Column_name;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = 'ALTER TABLE ' + @Table_name + ' ADD CONSTRAINT DF_RowDataUpdated_' + @Table_name + ' DEFAULT 1 FOR CT_RowDataUpdated ';
            EXEC PrintImmediate @MySql;
            IF
                   @PreviewOnly != 1
                BEGIN
                    EXEC (@MySql) 
                END;

            FETCH NEXT FROM C INTO @Table_name , @Column_name;
        END;

    CLOSE C;
    DEALLOCATE C;
END;

GO
PRINT 'Executed proc_SetDefaultRowDataUpdated.sql';
GO