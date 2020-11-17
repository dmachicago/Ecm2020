
USE kenticoCMS_Datamart_2;

GO
PRINT 'Executing proc_SetDefaultTrackerName.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_SetDefaultTrackerName') 
    BEGIN
        DROP PROCEDURE
             proc_SetDefaultTrackerName;
    END;
GO

-- exec proc_SetDefaultTrackerName 1

CREATE PROCEDURE proc_SetDefaultTrackerName (@PreviewOnly as bit = 0)
AS
BEGIN
    DECLARE
         @MySql AS NVARCHAR (MAX) 
       , @DBNAME AS NVARCHAR (250) = 'KenticoCMS_2'
       , @Table_name AS NVARCHAR (250) = ''
       , @Column_name AS NVARCHAR (250) = '';

    DECLARE C CURSOR
        FOR
            SELECT
                   Table_name
                 , Column_name
            FROM information_schema.columns
            WHERE
                   column_name = 'TrackerName' AND
                   IS_NULLABLE = 'YES' AND
                   TABLE_SCHEMA = 'dbo' AND column_default IS NULL;

    OPEN C;

    FETCH NEXT FROM C INTO @Table_name , @Column_name;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = 'ALTER TABLE ' + @Table_name + ' ADD CONSTRAINT DF_TrackerName_' + @Table_name + ' DEFAULT N''NA'' FOR TrackerName ';
            PRINT @MySql + CHAR (10) ;
		  if @PreviewOnly != 1 
			 EXEC (@MySql) ;

            FETCH NEXT FROM C INTO @Table_name , @Column_name;
        END;

    CLOSE C;
    DEALLOCATE C;
END;

GO
PRINT 'Executed proc_SetDefaultTrackerName.sql';
GO