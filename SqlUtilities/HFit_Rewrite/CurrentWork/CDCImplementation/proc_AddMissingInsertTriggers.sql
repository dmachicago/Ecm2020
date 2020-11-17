

--proc_AddMissingInsertTriggers

GO
PRINT 'Executing proc_AddMissingInsertTriggers.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_AddMissingInsertTriggers') 
    BEGIN
        DROP PROCEDURE proc_AddMissingInsertTriggers;
    END;
GO

-- exec proc_AddMissingInsertTriggers 1
CREATE PROCEDURE proc_AddMissingInsertTriggers (@PreviewOnly int = 0) 
AS
BEGIN
    -- declare @PreviewOnly int = 0
    DECLARE
           @MySql AS nvarchar (max) 
         , @T AS nvarchar (250) = ''
         , @TrigName AS nvarchar (250) = '';

--proc_CreateInsertTrigger
    DECLARE C CURSOR
        FOR SELECT table_name
                 , 'exec proc_GenInsertTrigger ' + replace(table_name, '_DEL','') AS cmd
              FROM information_schema.tables
              WHERE table_type = 'BASE TABLE'
                AND table_name LIKE '%[_]DEL'
              ORDER BY table_name;

    OPEN C;

    FETCH NEXT FROM C INTO @T, @MySql;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @TrigName = 'TRIG_INS_' + @T;
            SET @TrigName = REPLACE (@TrigName, '_DEL', '') ;
            IF NOT EXISTS (SELECT *
                             FROM sys.triggers
                             WHERE sys.triggers.object_id = OBJECT_ID (@TrigName)) 
                BEGIN
                    IF @PreviewOnly = 1
                        BEGIN
                            PRINT 'PREVIEW: ' + @MySql;
                        END
                    ELSE
                        BEGIN 					   
                           PRINT 'SQL: ' + @MySql;
					   EXEC (@MySql) ;
                        END;
				PRINT 'EXEC proc_InitializeDelTableData ' + @T + ', 0' ;
                    EXEC proc_InitializeDelTableData @T, 0;
                END;
            ELSE
                BEGIN
                    PRINT 'Already exists TRIGGER : ' + @TrigName;
                END;

            FETCH NEXT FROM C INTO @T, @MySql;
        END;

    CLOSE C;
    DEALLOCATE C;

END; 

GO
PRINT 'Created proc_AddMissingInsertTriggers.sql';
GO