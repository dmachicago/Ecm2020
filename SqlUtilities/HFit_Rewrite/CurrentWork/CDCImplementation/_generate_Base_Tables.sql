

--GO
--use DataMartPlatform;
GO

/*
    drop table MART_Tables_To_Convert
    truncate table MART_Tables_To_Convert
    Create table MART_Tables_To_Convert
    select * from MART_Tables_To_Convert where Table_Name like '%BASE_%'
    EXEC proc_CreateBaseTable @InstanceName = "KenticoCMS_2" , @TblName = "HFit_HealthAssessmentImportStagingDetail" , @SkipIfExists = 1 , @AddTableDefaults = "NO" 
*/

DECLARE
       @GenerateStatementsOnly AS BIT = 1
       , @Instance AS NVARCHAR (250) = 'KenticoCMS_1';

IF NOT EXISTS (SELECT
                      table_name
               FROM information_schema.tables
               WHERE
                      table_name = 'MART_Tables_To_Convert') 
    BEGIN
        CREATE TABLE MART_Tables_To_Convert (
                     DBMS NVARCHAR (250) 
                   , Table_Name NVARCHAR (250) 
                   , CMD NVARCHAR (MAX) 
                   , RowNbr INT IDENTITY (1 , 1)) ;
    END;


INSERT INTO MART_Tables_To_Convert (
       DBMS
     , Table_Name
     , CMD) 
SELECT
       @Instance
     , table_name
     , 'EXEC proc_CreateBaseTable @InstanceName = "' + @Instance + '" , @TblName = "' + table_name + '" , @SkipIfExists = 1 , @AddTableDefaults = "NO" ' + char(10) + '--GO' AS CMD  --+ char (10) + 'GO' 
FROM KenticoCMS_3.information_schema.tables
WHERE
(
  table_name LIKE '%coach%' OR
  table_name LIKE 'CMS_%' OR
  table_name LIKE 'COM_%' OR
  table_name LIKE 'OM_%' OR
  table_name LIKE 'PM_%' OR
  table_name LIKE 'EDW_%' OR
  table_name LIKE '%REJECT%' OR
  table_name LIKE '%HealthAsses%' OR
  table_name LIKE '%Reward%' OR
  table_name LIKE '%message%' OR
  table_name LIKE '%HFit_%' OR
  table_name LIKE '%HFit_LKP%' OR
  table_name LIKE '%ppt%' OR
  table_name LIKE 'HFit_HA%' OR
  table_name LIKE 'HFit_User%' OR
  table_name LIKE '%Account%' OR
  table_name LIKE 'HFIT_Configuration%' OR
  table_name LIKE 'HFIT_LKP_EDW_REJECTMPI' OR
  table_name LIKE 'EDW_GroupMemberHistory'
) AND
       TABLE_TYPE = 'BASE TABLE' AND
table_name NOT IN (SELECT
                          table_name
                   FROM MART_Tables_To_Convert
                   WHERE
                   DBMS = @Instance) OR
table_name IN
(
'Board_Message' ,
'HFIT_LKP_EDW_REJECTMPI' ,
'COM_SKU' ,
'HFit_Configuration_CallLogCoaching' ,
'HFIT_Configuration_CMCoaching' ,
'HFIT_Configuration_HACoaching' ,
'HFit_Configuration_LMCoaching' ,
'Hfit_SmallStepResponses' ,
'HFit_Staging_Coach' ,
'HFit_ToDoSmallSteps' ,
'HFIT_Tracker' ,
'RPT_CoachingFromPortal'
);

/*------------------------
 Delete Duplicate records 
*/

WITH CTE (
     DBMS
   , Table_name
   , DuplicateCount) 
    AS (
    SELECT
           DBMS
         , Table_name
         , ROW_NUMBER () OVER ( PARTITION BY DBMS
                                           , Table_name ORDER BY DBMS , Table_name) AS DuplicateCount
    FROM MART_Tables_To_Convert
    ) 
    DELETE
    FROM CTE
    WHERE
           DuplicateCount > 1;

IF
       @GenerateStatementsOnly = 1
    BEGIN
    -- Use DataMartPlatform
	   declare @ii as int = (select count(*) from MART_Tables_To_Convert) ;
	   SELECT 'Print ''Executing ' + cast(RowNbr as nvarchar) + ' of ' + cast(@ii as nvarchar(50)) +''''+ char(10) + 'GO' +char(10) +
               cmd
        FROM MART_Tables_To_Convert
        ORDER BY
                 RowNbr;

        RETURN;
    END;

DECLARE
       @MissingProcs AS INTEGER = 0
     , @MySql AS NVARCHAR (2000) = '';

IF NOT EXISTS (SELECT
                      name
               FROM sys.procedures
               WHERE
                      name = 'proc_GenTrackerFactTable') 
    BEGIN
        PRINT 'MISSING proc_GenTrackerFactTable';
        SET @MissingProcs = 1;
    END;

IF NOT EXISTS (SELECT
                      database_id
               FROM sys.change_tracking_databases
               WHERE
                      database_id = DB_ID ('DataMartPlatform')) 
    BEGIN

        PRINT 'ENABLED CHANGE TRACKING ON: DataMartPlatform';
        SET @MySql = 'ALTER DATABASE DataMartPlatform SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON) ';
        EXEC (@MySql) ;
    END;
IF NOT EXISTS ( SELECT
                       name
                FROM sys.procedures
                WHERE
                       name = 'proc_GetTableColumnsNoIdentity') 
    BEGIN
        PRINT 'MISSING proc_GetTableColumnsNoIdentity';
        SET @MissingProcs = 1;
    END;
IF NOT EXISTS ( SELECT
                       name
                FROM sys.procedures
                WHERE
                       name = 'proc_BASE_GetMaxCTVersionNbr') 
    BEGIN
        PRINT 'MISSING proc_BASE_GetMaxCTVersionNbr';
        SET @MissingProcs = 1;
    END;
IF NOT EXISTS ( SELECT
                       name
                FROM sys.procedures
                WHERE
                       name = 'proc_BASE_SaveCurrCTVersionNbr') 
    BEGIN
        PRINT 'MISSING proc_BASE_SaveCurrCTVersionNbr';
        SET @MissingProcs = 1;
    END;
IF NOT EXISTS (SELECT
                      name
               FROM sys.tables
               WHERE
                      name = 'PERFMON_PullTime_HIST') 
    BEGIN
        PRINT 'MISSING table PERFMON_PullTime_HIST';
        SET @MissingProcs = 1;
    END;
IF
       @MissingProcs = 1
    BEGIN
        RETURN;
    END;
--GO
-- DBCC FREEPROCCACHE
--GO

IF NOT EXISTS (SELECT
                      name
               FROM sys.tables
               WHERE
                      name = 'FACT_TrackerData') 
    BEGIN
        EXEC proc_GenTrackerFactTable;
    END;
--GO
EXEC proc_EnableChangeTracking 'KenticoCMS_1';
--GO
EXEC proc_EnableChangeTracking 'KenticoCMS_2';
--GO
EXEC proc_EnableChangeTracking 'KenticoCMS_3';
--GO

DECLARE
       @SkipParm AS  INT = 1
     , @GenerateTableDefaults AS NVARCHAR (50) = 'NO';

IF @SkipParm = 0
    BEGIN
        truncate TABLE PERFMON_PullTime_HIST;
    END;

DBCC FREEPROCCACHE;

DECLARE
       @CMD AS NVARCHAR (MAX) 
     , @Msg AS NVARCHAR (MAX) 
     , @T AS NVARCHAR (250) = ''
     , @i AS INT = 0
     , @iTot AS INT = 0
     , @SkipIfExists AS BIT = 1;

SET @iTot = (SELECT
                    COUNT (*) 
             FROM MART_Tables_To_Convert) ;

DECLARE CMD_Cursor CURSOR
    FOR
        SELECT
               Table_name
             , CMD
        FROM MART_Tables_To_Convert
        WHERE
        table_name NOT LIKE '%HIST' AND
        table_name NOT LIKE '%_DEL'
        ORDER BY
                 table_name;

OPEN CMD_Cursor;
FETCH NEXT FROM CMD_Cursor INTO @T , @CMD;

WHILE
       @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRANSACTION TX1;
        SET @i = @i + 1;
        BEGIN
            WAITFOR DELAY '00:00:01';
            SET @msg = 'Processing Table: ' + @T + ': ' + CAST (@i AS NVARCHAR (50)) + ' of ' + CAST (@iTot AS NVARCHAR (50)) + '.';
            EXEC PrintImmediate @msg;
        END;

        --IF @i < 314
        --    BEGIN GOTO NEXTREC
        --    END;

        --if @T like '%HIST' or @T like '%_DEL'
        --goto NEXTREC ;

        IF NOT EXISTS (SELECT
                              name
                       FROM sys.procedures
                       WHERE
                              name = 'proc_GenJobBaseTableSync') 
            BEGIN
                ROLLBACK TRANSACTION TX1;
                PRINT 'ERROR: proc_GenJobBaseTableSync MISSING.';
                EXEC proc_GenJobBaseTableSync_MISSING ;
                RAISERROR ('MSG ERROR 002: proc_GenJobBaseTableSync NOT found.' , 14 , 1) WITH NOWAIT;
                GOTO NEXTREC2;
            END;
        BEGIN TRY
            EXEC (@CMD) ;
            PRINT @CMD;
        END TRY
        BEGIN CATCH
            PRINT 'FAILURE: ' + @CMD;
        END CATCH;
        NEXTREC:
        COMMIT TRANSACTION TX1;
        NEXTREC2:

        DECLARE
               @BTBL  AS NVARCHAR (500) = 'BASE_' + @T;
        EXEC proc_SetPrimaryKeyToSurrogateKey @BTBL;

        DECLARE
               @PName AS NVARCHAR (500) = 'proc_BASE_' + @T;
        EXEC proc_GenJobBaseTableSync 3 , @PName;

    exec proc_MartRemoveDelTableNotNullsMASTER

        FETCH NEXT FROM CMD_Cursor INTO @T , @CMD;
    END;
ITSOVER:
CLOSE CMD_Cursor;
DEALLOCATE CMD_Cursor;

EXEC proc_SetBadDataIdentifiers ;

-- select * from sys.objects where name  ='sp_verify_jobstep'

/*------------------------------------------
select top 20 * from dbo.SchemaChangeMonitor
where obj = 'proc_GenJobBaseTableSync'
order by RowNbr desc
*/