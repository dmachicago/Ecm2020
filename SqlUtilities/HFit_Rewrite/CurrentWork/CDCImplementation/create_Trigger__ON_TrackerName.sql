

/*
USE [KenticoCMS_Datamart_X];
USE [KenticoCMS_Datamart_2];
exec proc_create_Trigger_ON_TrackerName 
*/

--**********************************************************************

GO
PRINT 'Executing create_Trigger__ON_TrackerName'; 
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_create_Trigger_ON_TrackerName') 
    BEGIN
        DROP PROCEDURE proc_create_Trigger_ON_TrackerName
    END;
GO

CREATE PROCEDURE proc_create_Trigger_ON_TrackerName
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
          @MySql AS nvarchar (max) , 
          @DBNAME AS nvarchar (250) = 'KenticoCMS_2' , 
          @TblName AS nvarchar (250) = '' , 
          @I AS int = 0;

    DECLARE CursorTrigger CURSOR
        FOR SELECT DISTINCT table_name
              FROM information_schema.columns
              WHERE column_name = 'TrackerName'
                AND table_name NOT LIKE '%DEL'
                AND table_name NOT LIKE '%view%'
                AND table_name NOT LIKE '%TESTDATA'
			 AND table_name NOT LIKE 'FACT_TrackerData';

    OPEN CursorTrigger;

    FETCH NEXT FROM CursorTrigger INTO @TblName;
    DECLARE
          @ShortTblName AS nvarchar (100) = '' , 
          @TriggerName AS nvarchar (250) = '';
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @I = @I + 1;
            -- if @I > 2 goto NOMORE ;
            SET @ShortTblName = SUBSTRING (@TblName , 6 , 9999) ;
            SET @TriggerName = 'TRIG_TNAME_INS_' + @TblName;

            IF EXISTS (SELECT *
                         FROM sys.objects
                         WHERE type = 'TR'
                           AND name = @TriggerName) 
                BEGIN
                    SET @MySQl = 'DROP TRIGGER ' + @TriggerName;
                    EXEC (@MySQl) ;
                    PRINT 'Replaced Trigger: ' + @TriggerName;
                END;
            SET @TriggerName = 'TRIG_TNAME_UPDT_' + @TblName;
            IF EXISTS (SELECT *
                         FROM sys.objects
                         WHERE type = 'TR'
                           AND name = @TriggerName) 
                BEGIN
                    SET @MySQl = 'DROP TRIGGER ' + @TriggerName;
                    EXEC (@MySQl) ;
                    PRINT 'Replaced Trigger: ' + @TriggerName;
                END;

            SET @MySQl = '';
            SET @MySQl = @MySQl + ' create TRIGGER dbo.TRIG_TNAME_INS_' + @TblName + ' ON dbo.' + @TblName + ' ' + CHAR (10) ;
            SET @MySQl = @MySQl + ' AFTER INSERT  ' + CHAR (10) ;
            SET @MySQl = @MySQl + ' AS ' + CHAR (10) ;
            SET @MySQl = @MySQl + ' BEGIN ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      UPDATE T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      SET T.TrackerName = REPLACE (T.TrackerName , ''BASE_'' , '''')  ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      FROM ' + @TblName + ' T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      JOIN inserted I ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      ON T.SurrogateKey_' + @ShortTblName + ' = I.SurrogateKey_' + @ShortTblName + '; ' + CHAR (10) ;
            SET @MySQl = @MySQl + '       ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      UPDATE T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      SET T.TrackerName = REPLACE (T.TrackerName , ''FACT_'' , '''') ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      FROM ' + @TblName + ' T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      JOIN inserted I ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      ON T.SurrogateKey_' + @ShortTblName + ' = I.SurrogateKey_' + @ShortTblName + '; ' + CHAR (10) ;
            SET @MySQl = @MySQl + 'END;  ' + CHAR (10) ;

            --PRINT @MySql;
            EXEC (@MySql) ;

            SET @MySQl = 'CREATE TRIGGER dbo.TRIG_TNAME_UPDT_' + @TblName + ' ON dbo.' + @TblName + ' ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      AFTER UPDATE  ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      AS ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      BEGIN ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           UPDATE T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           SET T.TrackerName = REPLACE (T.TrackerName , ''BASE_'' , '''') ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           FROM ' + @TblName + ' T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           JOIN inserted I ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      ON T.SurrogateKey_' + @ShortTblName + ' = I.SurrogateKey_' + @ShortTblName + '; ' + CHAR (10) ;
            SET @MySQl = @MySQl + '            ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           UPDATE T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           SET T.TrackerName = REPLACE (T.TrackerName , ''FACT_'' , '''') ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           FROM ' + @TblName + ' T ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           JOIN inserted I ' + CHAR (10) ;
            SET @MySQl = @MySQl + '           ON T.SurrogateKey_' + @ShortTblName + ' = I.SurrogateKey_' + @ShortTblName + '; ' + CHAR (10) ;
            SET @MySQl = @MySQl + '      END;  ' + CHAR (10) ;
            EXEC (@MySql) ;
            --PRINT @MySql;

            IF EXISTS (SELECT *
                         FROM sys.objects
                         WHERE type = 'TR'
                           AND name = @TriggerName) 
                BEGIN
                    PRINT 'SUCCESSFULLY Generated Trigger: ' + @TriggerName;
                    IF @TblName != 'FACT_TrackerData'
                        BEGIN
                            SET @MySQl = 'Update ' + @TblName + ' SET TrackerName = REPLACE (TrackerName , ''BASE_'' , '''') where TrackerName like ''BASE%'' ';
                            PRINT @MySql;
                            EXEC (@MySql) ;

                            SET @MySQl = 'Update ' + @TblName + ' SET TrackerName = REPLACE (TrackerName , ''FACT_'' , '''')  where TrackerName like ''FACT%''';
                            PRINT @MySql;
                            EXEC (@MySql) ;
                        END;

                END;
            SET @TriggerName = 'TRIG_TNAME_UPDT_' + @TblName;
            IF EXISTS (SELECT *
                         FROM sys.objects
                         WHERE type = 'TR'
                           AND name = @TriggerName) 
                BEGIN
                    PRINT 'SUCCESSFULLY Generated Trigger: ' + @TriggerName;
                END;
            PRINT '--*********************************************';
            FETCH NEXT FROM CursorTrigger INTO @TblName;
        END;
    NOMORE:
    CLOSE CursorTrigger;
    DEALLOCATE CursorTrigger;

    SET NOCOUNT OFF;
END; 

GO
PRINT 'Executed create_Trigger__ON_TrackerName'; 
GO
