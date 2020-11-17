
-- Partial Implementation of Change TRacking
-- DOES NOT implement CT on all tables, only selected tables.

GO
PRINT 'Executing validateChangeTrackingOnEachTable.sql';
GO

-- USE KenticoCMS_Datamart_2;

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_TurnOnChangeTracking') 
    BEGIN
        DROP PROCEDURE proc_TurnOnChangeTracking;
    END;
GO
-- exec proc_TurnOnChangeTracking 'KenticoCMS_1', 1
CREATE PROCEDURE proc_TurnOnChangeTracking (@InstanceName AS nvarchar (100) , 
                                            @PreviewOnly AS bit = 0) 
AS
BEGIN

    SET NOCOUNT ON;

    CREATE TABLE #TEMPCMD (cmd nvarchar (max)) ;

    SELECT SUBSTRING (Table_name , 6 , 9999) AS Table_name INTO #TGT_TABLES
      FROM information_schema.tables
      WHERE table_Name LIKE 'BASE_%'
        AND table_Name NOT LIKE '%_CTVerHist'
        AND table_Name NOT LIKE '%_testdata'
        AND table_Name NOT LIKE '%_del'
        AND table_Name NOT LIKE 'view%'
        AND table_Name NOT LIKE '%_view_%'
        AND table_Name NOT LIKE '%_joined_%'
        AND table_Name NOT LIKE 'TEMP_%'
        AND table_Name NOT LIKE 'CT_%'
        AND table_Name NOT LIKE 'CT_%'
        AND table_Name NOT LIKE 'CHAD%'
        AND table_Name NOT LIKE 'CHAT%'
        AND table_Name NOT LIKE 'coach%'
        AND table_Name NOT LIKE 'DIM_%'
        AND table_Name NOT LIKE 'dups'
        AND table_Name NOT LIKE 'FACT_%'
        AND table_Name NOT LIKE 'EDW_%'
        AND table_Name NOT LIKE 'keywords%'
        AND table_Name NOT LIKE 'MART_%'
        AND table_Name NOT LIKE '%_EventLog'
      ORDER BY 1;

    DECLARE
          @IsOn AS int = 0 , 
          @TblName AS nvarchar (500) = '';


    DECLARE
          @MySql AS nvarchar (max) ;
    DECLARE
          @DBNAME AS nvarchar (250) = 'KenticoCMS_2';
    DECLARE
          @CMD AS nvarchar (250) = '';

    DECLARE CursorCT CURSOR
        FOR SELECT Table_name
              FROM #TGT_TABLES;


    OPEN CursorCT;

    FETCH NEXT FROM CursorCT INTO @TblName;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC @ison = isChangeTrackingON @InstanceName , @TblName;
            IF @ison = 0
                BEGIN
                    SET @cmd = ' ALTER TABLE ' + @InstanceName + '.dbo.' + @TblNAme + ' ENABLE CHANGE_TRACKING ';
                END;
            IF @PreviewOnly = 1
                BEGIN
                    IF @ison = 1
                        BEGIN
                            PRINT @CMD;
                            INSERT INTO #TEMPCMD (cmd) 
                            VALUES (@CMD) ;
                        END;
                    ELSE
                        BEGIN
                            PRINT @TblName + ' already has CT engaged, skipping ';
                        END;
                END;
            ELSE
                BEGIN
                    IF @ison = 1
                        BEGIN EXEC (@CMD) ;
                        END;
                    ELSE
                        BEGIN
                            PRINT @TblName + ' already has CT engaged, skipping ';
                        END;
                END;
            FETCH NEXT FROM CursorCT INTO @TblName;
        END;
    CLOSE CursorCT;
    DEALLOCATE CursorCT;

    IF (SELECT COUNT (*)
          FROM #TEMPCMD) > 0
        BEGIN
            SELECT * FROM #TEMPCMD;
        END;

    SET NOCOUNT OFF;

    PRINT 'Successful Insatllation of the procedures.';
    PRINT 'To ENABLE change tracking: ' + CHAR (10) + 'exec proc_TurnOnChangeTracking DB_NAME() ';
    PRINT 'To DISABLE change tracking: ' + CHAR (10) + 'exec proc_TurnOffChangeTracking  DB_NAME() ';

END;


GO
PRINT 'Executed validateChangeTrackingOnEachTable.sql';
GO
