
PRINT 'Executing Migrate_DataMart_Data_From_New_Servers.sql';
PRINT 'VERSION 04.05.2016 @ 12:29';
PRINT 'FOR USE INSTRUNCTIONS - CONTACT SCOTT MONTGOMERY OR DALE MILLER';

BEGIN TRY
    DROP TABLE ##TMPX;
END TRY
BEGIN CATCH
    PRINT 'Dropped ##TMPX';
END CATCH;
GO
SELECT T.name AS [TABLE NAME] , 
       I.rows AS [ROWCOUNT] INTO #TMPX
  FROM
       sys.tables AS T
       INNER JOIN sys.sysindexes AS I
       ON T.object_id = I.id
      AND I.indid < 2
  WHERE t.name NOT LIKE '%DEL'
    AND t.name NOT LIKE '%testdata'
    AND t.name NOT LIKE '%VerHist'
    AND t.name LIKE 'BASE%'
  ORDER BY I.rows DESC;
DELETE FROM ##TMPX
  WHERE [ROWCOUNT] = 0;
--***************************************
-- ENABLE CHANGE TRACKING
--***************************************
-- select * from dbo.MIGRATE_DataMart_Commands 
-- drop table dbo.MIGRATE_DataMart_Commands 
USE KenticoCMS_Datamart_X;
GO

DECLARE
      @SkipAllProcessedRecords AS bit = 0;
IF @SkipAllProcessedRecords = 1
    BEGIN
        GOTO SkipAllPRocessedRecords;
    END;

DECLARE
      @RemoveAllExistingProcessingCommands AS bit = 1;
IF NOT EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = 'MIGRATE_DataMart_Commands') 
    BEGIN
        CREATE TABLE dbo.MIGRATE_DataMart_Commands (cmd nvarchar (max) NULL , 
                                                    RowNbr int IDENTITY (1 , 1) , 
                                                    Processed int DEFAULT 0) ;
    END;
ELSE
    BEGIN
        IF @RemoveAllExistingProcessingCommands = 1
            BEGIN
                truncate TABLE dbo.MIGRATE_DataMart_Commands;
            END;
    END;

DECLARE
      @cmd AS nvarchar (max) = '';

SET @cmd = 'IF NOT EXISTS (SELECT * FROM sys.change_tracking_databases
               WHERE database_id = DB_ID (''KenticoCMS_1'')) 
    BEGIN
        ALTER DATABASE KenticoCMS_1 SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) 
    END; ';
INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
VALUES (@cmd) ;

SET @cmd = 'IF NOT EXISTS (SELECT * FROM sys.change_tracking_databases
               WHERE database_id = DB_ID (''KenticoCMS_2'')) 
    BEGIN
        ALTER DATABASE KenticoCMS_1 SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) 
    END; ';
INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
VALUES (@cmd) ;

SET @cmd = 'IF NOT EXISTS (SELECT * FROM sys.change_tracking_databases
               WHERE database_id = DB_ID (''KenticoCMS_3'')) 
    BEGIN
        ALTER DATABASE KenticoCMS_1 SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 7 DAYS, AUTO_CLEANUP = ON) 
    END; ';
INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
VALUES (@cmd) ;

--*************************************************
-- VERIFY CHANGE TRACKING IS ON FOR ALL TABLES
-- NOTE: SKIP ALL EVENT LOGS
--*************************************************

DECLARE
      @VerifyChangeTrackingOnServer1 AS bit = 0;
IF @VerifyChangeTrackingOnServer1 = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'if not exists ( --001' + CHAR (10) + 'select T.name ' + CHAR (10) + 'from KenticoCMS_1.sys.change_tracking_tables CT' + CHAR (10) + 'join KenticoCMS_1.sys.tables T on T.object_id = CT.object_id ' + CHAR (10) + 'join KenticoCMS_1.sys.schemas S on S.schema_id = T.schema_id ' + CHAR (10) + 'where T.name = ''' + KT.name + ''' ' + CHAR (10) + ') ' + CHAR (10) + '    ALTER TABLE KenticoCMS_1.dbo.' + KT.name + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)' + CHAR (10) AS CMD
          FROM
               KenticoCMS_1.sys.change_tracking_tables AS KCT
               JOIN KenticoCMS_1.sys.tables AS KT
               ON KT.object_id = KCT.object_id
               JOIN KenticoCMS_1.sys.schemas AS KS
               ON KS.schema_id = KT.schema_id
          WHERE KT.name NOT LIKE '%eventlog%';
    END;

DECLARE
      @VerifyChangeTrackingOnServer2 AS bit = 0;
IF @VerifyChangeTrackingOnServer2 = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        VALUES ('GO') ;
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'if not exists ( --001=2' + CHAR (10) + 'select T.name ' + CHAR (10) + 'from KenticoCMS_2.sys.change_tracking_tables CT' + CHAR (10) + 'join KenticoCMS_2.sys.tables T on T.object_id = CT.object_id ' + CHAR (10) + 'join KenticoCMS_2.sys.schemas S on S.schema_id = T.schema_id ' + CHAR (10) + 'where T.name = ''' + KT.name + ''' ' + CHAR (10) + ') ' + CHAR (10) + '    ALTER TABLE KenticoCMS_2.dbo.' + KT.name + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)' + CHAR (10) AS CMD
          FROM
               KenticoCMS_2.sys.change_tracking_tables AS KCT
               JOIN KenticoCMS_2.sys.tables AS KT
               ON KT.object_id = KCT.object_id
               JOIN KenticoCMS_2.sys.schemas AS KS
               ON KS.schema_id = KT.schema_id
          WHERE KT.name NOT LIKE '%eventlog%';
    END;

DECLARE
      @VerifyChangeTrackingOnServer3 AS bit = 0;
IF @VerifyChangeTrackingOnServer3 = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'if not exists ( --003' + CHAR (10) + 'select T.name ' + CHAR (10) + 'from KenticoCMS_3.sys.change_tracking_tables CT' + CHAR (10) + 'join KenticoCMS_3.sys.tables T on T.object_id = CT.object_id ' + CHAR (10) + 'join KenticoCMS_3.sys.schemas S on S.schema_id = T.schema_id ' + CHAR (10) + 'where T.name = ''' + KT.name + ''' ' + CHAR (10) + ') ' + CHAR (10) + '    ALTER TABLE KenticoCMS_3.dbo.' + KT.name + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON)' + CHAR (10) AS CMD
          FROM
               KenticoCMS_3.sys.change_tracking_tables AS KCT
               JOIN KenticoCMS_3.sys.tables AS KT
               ON KT.object_id = KCT.object_id
               JOIN KenticoCMS_3.sys.schemas AS KS
               ON KS.schema_id = KT.schema_id
          WHERE KT.name NOT LIKE '%eventlog%';
    END;

--***************************************
-- DISABLE ALL TRIGGERS
--***************************************
INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
VALUES ('USE KenticoCMS_Datamart_X') ;
INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
VALUES ('GO') ;
DECLARE
      @DisableAllTriggers AS bit = 1;
IF @DisableAllTriggers = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'DISABLE TRIGGER dbo.' + sysobjects.name + ' ON dbo.' + OBJECT_NAME (parent_obj) + CHAR (10) AS DisableTriggersCMD
        --    'ENABLE TRIGGER dbo.'+sysobjects.name+' ON dbo.'+OBJECT_NAME(parent_obj)+ char(10) + 'GO' as EnableTriggersCMD
          FROM
               sysobjects
               INNER JOIN sysusers
               ON sysobjects.uid = sysusers.uid
               INNER JOIN sys.tables AS t
               ON sysobjects.parent_obj = t.object_id
               INNER JOIN sys.schemas AS s
               ON t.schema_id = s.schema_id
          WHERE sysobjects.type = 'TR'
            AND OBJECT_NAME (parent_obj) LIKE 'BASE_%'
             OR OBJECT_NAME (parent_obj) LIKE 'FACT_%';
    END;

--***************************************
-- TRUNCATE ALL EXISTING DATA
--***************************************
--USE KenticoCMS_Datamart_X;
--GO
DECLARE
      @TruncateAllTables AS bit = 0;
IF @TruncateAllTables = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'TRUNCATE TABLE [dbo].[' + table_name + '];' + CHAR (10)
          FROM information_schema.tables
          WHERE table_type = 'BASE TABLE'
            AND table_name NOT LIKE 'MART%'
            AND table_name NOT LIKE 'Schema%'
            AND table_name NOT LIKE 'Request%'
            AND table_name NOT LIKE 'sys%'
            AND table_name NOT LIKE 'keyword%'
          ORDER BY table_name;
    END;

--***************************************
-- DISABLE ALL JOBS
--***************************************
--USE KenticoCMS_Datamart_X;
--GO
--insert into KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) values ('USE KenticoCMS_Datamart_X');
--insert into KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) values ('GO');
DECLARE
      @DisableAllJobs AS bit = 1;
IF @DisableAllJobs = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'exec msdb.dbo.sp_update_job @job_name = ''' + name + '''' + ', @enabled = 0 ;' + CHAR (10)
          FROM msdb.dbo.sysjobs
          WHERE(NAme LIKE '%Tracker%'
             OR NAme LIKE 'JOB_EDW%'
             OR NAme LIKE '%_CT_DIM_%'
             OR NAme LIKE '%_proc_BASE_%')
           AND NAme NOT LIKE '%stag%';
    END;

--***************************************
-- IMPORT ALL NEW DATA
--***************************************
--USE KenticoCMS_Datamart_X;
--GO
INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
VALUES ('USE KenticoCMS_Datamart_X') ;
INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
VALUES ('GO') ;
DECLARE
      @ImportAllData AS bit = 1;
IF @ImportAllData = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'EXEC PrintImmediate ''' + name + ''''
               --+ char(10) + ' GO ' 
               + CHAR (10) + 'print ''Start Time: ''' + CHAR (10) + ' print getdate()'
               --+ char(10) + ' GO ' 
               + CHAR (10) + 'EXEC ' + name + ' 0,1;'
               --+ char(10) + 'go'  
               + CHAR (10) + 'print ''END Time: ''' + CHAR (10) + ' print getdate()' + CHAR (10) + 'print ''***********************************************************'''
        --+ char(10) + ' GO ' 
          FROM sys.procedures
          WHERE name LIKE '%_SYNC'
            AND name LIKE 'Proc_BASE_%'
        UNION
        SELECT 'EXEC PrintImmediate ''' + name + ''''
               --+ char(10) + ' GO ' 
               + CHAR (10) + 'print ''Start Time: ''' + CHAR (10) + ' print getdate()'
               --+ char(10) + ' GO ' 
               + CHAR (10) + 'EXEC ' + name + ' 1;'
               --+ char(10) + 'go'  
               + CHAR (10) + 'print ''END Time: ''' + CHAR (10) + ' print getdate()' + CHAR (10) + 'print ''***********************************************************'''
          FROM sys.procedures
          WHERE name LIKE 'proc_CT_DIM_HFit_Tracker%';
    END;

--***************************************
-- REGENERATE ALL VIEWS TO TABLES
--***************************************
DECLARE
      @RegenViewsToTables AS bit = 1;
IF @RegenViewsToTables = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'EXEC PrintImmediate ''' + table_name + '''' + CHAR (10) + 'exec proc_GenBaseTableFromView ' + '@DBNAME=[KenticoCMS_1] ' + ', @ViewName=''' + SUBSTRING (table_name , 6 , 999) + '''' + ', @Preview = ''no''' + CHAR (10) + ', @GenJobToExecute = 1' + CHAR (10) + ', @SkipIfExists = 0'
        --+ char(10) + 'GO'
          FROM INFORMATION_SCHEMA.TABLES
          WHERE table_name LIKE 'BASE_view_%'
            AND table_name NOT LIKE '%_DEL'
            AND table_name NOT LIKE '%_hist'
            AND table_name NOT LIKE '%_pulldate'
            AND table_name NOT LIKE '%eventlog%'
        UNION
        SELECT 'EXEC PrintImmediate ''' + table_name + '''' + CHAR (10) + 'exec proc_GenBaseTableFromView ' + '@DBNAME=[KenticoCMS_2] ' + ', @ViewName=''' + SUBSTRING (table_name , 6 , 999) + '''' + ', @Preview = ''no''' + CHAR (10) + ', @GenJobToExecute = 1' + CHAR (10) + ', @SkipIfExists = 0'
        --+ char(10) + 'GO'
          FROM INFORMATION_SCHEMA.TABLES
          WHERE table_name LIKE 'BASE_view_%'
            AND table_name NOT LIKE '%_DEL'
            AND table_name NOT LIKE '%_hist'
            AND table_name NOT LIKE '%_pulldate'
            AND table_name NOT LIKE '%eventlog%'
        UNION
        SELECT 'EXEC PrintImmediate ''' + table_name + '''' + CHAR (10) + 'exec proc_GenBaseTableFromView ' + '@DBNAME=[KenticoCMS_3] ' + ', @ViewName=''' + SUBSTRING (table_name , 6 , 999) + '''' + ', @Preview = ''no''' + CHAR (10) + ', @GenJobToExecute = 1' + CHAR (10) + ', @SkipIfExists = 0'
        --+ char(10) + 'GO'
          FROM INFORMATION_SCHEMA.TABLES
          WHERE table_name LIKE 'BASE_view_%'
            AND table_name NOT LIKE '%_DEL'
            AND table_name NOT LIKE '%_hist'
            AND table_name NOT LIKE '%_pulldate'
            AND table_name NOT LIKE '%eventlog%';
    END;

--***************************************
-- RELOAD ALL VIEWS TO TABLES
--***************************************
DECLARE
      @ReloadViewsToTables AS bit = 1;
IF @ReloadViewsToTables = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'EXEC PrintImmediate ''' + table_name + '''' + CHAR (10) + 'exec proc_' + SUBSTRING (table_name , 6 , 999) + '_KenticoCMS_1 ;'
          FROM INFORMATION_SCHEMA.TABLES
          WHERE table_name LIKE 'BASE_view_%'
            AND table_name NOT LIKE '%_DEL'
            AND table_name NOT LIKE '%_hist'
            AND table_name NOT LIKE '%_pulldate'
            AND table_name NOT LIKE '%eventlog%'
        UNION
        SELECT 'EXEC PrintImmediate ''' + table_name + '''' + CHAR (10) + 'exec proc_' + SUBSTRING (table_name , 6 , 999) + '_KenticoCMS_2 ;'
          FROM INFORMATION_SCHEMA.TABLES
          WHERE table_name LIKE 'BASE_view_%'
            AND table_name NOT LIKE '%_DEL'
            AND table_name NOT LIKE '%_hist'
            AND table_name NOT LIKE '%_pulldate'
            AND table_name NOT LIKE '%eventlog%'
        UNION
        SELECT 'EXEC PrintImmediate ''' + table_name + '''' + CHAR (10) + 'exec proc_' + SUBSTRING (table_name , 6 , 999) + '_KenticoCMS_3 ;'
          FROM INFORMATION_SCHEMA.TABLES
          WHERE table_name LIKE 'BASE_view_%'
            AND table_name NOT LIKE '%_DEL'
            AND table_name NOT LIKE '%_hist'
            AND table_name NOT LIKE '%_pulldate'
            AND table_name NOT LIKE '%eventlog%';
    END;

--***************************************
-- ADD TRACKER RELS
-- Use KenticoCMS_Datamart_2
-- gen cmd proc_ConnectTables_BySurrogateKey.sql
--***************************************
DECLARE
      @AddTrackerRels AS bit = 1;
IF @AddTrackerRels = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'exec PrintImmediate ''Adding User RELS: ' + table_name + '''' + CHAR (10) + 'exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "' + table_name + '", @PreviewOnly = 0 ' + CHAR (10) + 'update ' + table_name + ' set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where ' + table_name + '.Userid = B.UserID and ' + table_name + '.DBNAME = B.DBNAME) ' AS UPDT_CMD
          FROM information_schema.tables
          WHERE table_name LIKE '%_TRACKER%'
            AND table_name NOT LIKE '%_DEL'
            AND table_name NOT LIKE '%_CTVerHIST'
            AND table_name NOT LIKE '%_NoNulls'
            AND table_name NOT LIKE '%_CT'
            AND table_name NOT LIKE '%_ONLY'
            AND table_name NOT LIKE '%_TEMP_%'
            AND table_name NOT LIKE '%_view_%'
            AND table_name NOT LIKE '%_LKP_%'
            AND table_name NOT LIKE 'view_%'
            AND table_name NOT LIKE 'base_view_%'
            AND table_name NOT LIKE 'FACT_TrackerData'
            AND table_name NOT LIKE '%TestData';
    END;

--***************************************
-- ENABLE ALL TRIGGERS
--***************************************
--USE KenticoCMS_Datamart_X;
--GO
--insert into KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) values ('USE KenticoCMS_Datamart_X');
--insert into KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) values ('GO');
DECLARE
      @EnableAllTriggers AS bit = 1;
IF @EnableAllTriggers = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT
        --    'DISABLE TRIGGER dbo.'+sysobjects.name+' ON dbo.'+OBJECT_NAME(parent_obj)+ char(10) + 'GO' as DisableTriggersCMD
        'ENABLE TRIGGER dbo.' + sysobjects.name + ' ON dbo.' + OBJECT_NAME (parent_obj) + CHAR (10) AS EnableTriggersCMD
          FROM
               sysobjects
               INNER JOIN sysusers
               ON sysobjects.uid = sysusers.uid
               INNER JOIN sys.tables AS t
               ON sysobjects.parent_obj = t.object_id
               INNER JOIN sys.schemas AS s
               ON t.schema_id = s.schema_id
          WHERE sysobjects.type = 'TR'
            AND OBJECT_NAME (parent_obj) LIKE 'BASE_%'
             OR OBJECT_NAME (parent_obj) LIKE 'FACT_%';
    END;

--***************************************
-- REPOINT ALL JOBS TO NEW DB
--***************************************
--USE KenticoCMS_Datamart_X;
--GO
--EXEC msdb.dbo.sp_update_jobstep @job_name= 'job_proc_view_EDW_HealthInterestDetail_KenticoCMS_3', @step_id=1 , 
--		@database_name=N'KenticoCMS_Datamart_X'
--EXEC msdb.dbo.sp_update_jobstep @job_name= 'job_proc_view_EDW_HealthInterestDetail_KenticoCMS_3', @step_id=2 , 
--		@database_name=N'KenticoCMS_Datamart_X'
DECLARE
      @PointAllJobsToNewDB AS bit = 1;
IF @PointAllJobsToNewDB = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'msdb.dbo.sp_update_jobstep @job_name= ''' + JOB.NAME + ''', @step_id=' + CAST (STEP.STEP_ID AS nvarchar (50)) + ', @database_name=N''KenticoCMS_Datamart_X''' + CHAR (10) + 'GO'
          FROM
               Msdb.dbo.SysJobs AS JOB
               INNER JOIN Msdb.dbo.SysJobSteps AS STEP
               ON STEP.Job_Id = JOB.Job_Id
              AND (JOB.Name LIKE '%ApplyCT'
                OR JOB.NAme LIKE 'job_proc_View%'
                OR JOB.NAme LIKE 'job_proc_CT_DIM%'
               AND JOB.NAme NOT LIKE '%stag%'
               AND JOB.NAme NOT LIKE 'job_proc_view_EDW_HealthAssesment_KenticoCMS%'
               AND JOB.NAme NOT LIKE 'job_proc_view_EDW_HAassessment_KenticoCMS%')
          ORDER BY JOB.NAME , STEP.STEP_ID;
    END;

--***************************************
-- ENABLE ALL JOBS
--***************************************
--USE KenticoCMS_Datamart_X;
--GO
--insert into KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) values ('USE KenticoCMS_Datamart_X');
--insert into KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) values ('GO');
DECLARE
      @EnableAllJobs AS bit = 1;
IF @EnableAllJobs = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'exec msdb.dbo.sp_update_job @job_name = ''' + name + '''' + ', @enabled = 1 ;' + CHAR (10)
          FROM msdb.dbo.sysjobs
          WHERE Name LIKE '%ApplyCT'
             OR NAme LIKE 'job_proc_View%'
             OR NAme LIKE 'job_proc_CT_DIM%'
            AND NAme NOT LIKE '%stag%'
          ORDER BY NAME;
    END;

--***************************************
-- LAUNCH ALL JOBS
--***************************************
--EXEC dbo.sp_start_job N'Weekly Sales Data Backup' ;
DECLARE
      @StartAllJobs AS bit = 1;
IF @StartAllJobs = 1
    BEGIN
        INSERT INTO KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands (cmd) 
        SELECT 'exec msdb.dbo.sp_start_job @job_name = ''' + name + '''; '
          FROM msdb.dbo.sysjobs
          WHERE Name LIKE '%ApplyCT'
             OR NAme LIKE 'job_proc_View%'
             OR NAme LIKE 'job_proc_CT_DIM%'
            AND NAme NOT LIKE '%stag%'
          ORDER BY NAME;
    END;

SkipAllPRocessedRecords:
--****************************************************************************************************************************
-- Execute the COMMANDS as a Cursor or Select the COMMANDS to execute later.
-- Set 'Skip if Processed' either on or not
--****************************************************************************************************************************
--USE KenticoCMS_Datamart_X;
--GO
DECLARE
      @PreviewOnly AS bit = 0;
DECLARE
      @SkippedProcessed AS bit = 1;
IF @PreviewOnly = 1
    BEGIN
        PRINT 'PREVIEW ONLY SELECTED...';
        SELECT *
          FROM KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands
          ORDER BY RowNbr;
    END;
ELSE
    BEGIN
        DECLARE
              @iTotal AS int = 0;
        DECLARE
              @iCurr AS int = 0;
        DECLARE
              @msg AS nvarchar (max) ;
        DECLARE
              @MySql AS nvarchar (max) ;
        DECLARE
              @T AS nvarchar (max) = '';
        DECLARE
              @R AS int = 0;
        DECLARE
              @P AS int = 0;
        SET @iTotal = (SELECT COUNT (*)
                         FROM KenticoCMS_Datamart_X.dbo.MIGRATE_DataMart_Commands) ;
        DECLARE C CURSOR
            FOR SELECT cmd , 
                       RowNbr , 
                       Processed
                  FROM dbo.MIGRATE_DataMart_Commands
                  WHERE Processed != 1
                  ORDER BY RowNbr;

        OPEN C;

        FETCH NEXT FROM C INTO @T , @R , @P;
        DECLARE
              @LoopStartDate AS datetime = NULL;
        DECLARE
              @LoopEndDate AS datetime = NULL;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @LoopStartDate = GETDATE () ;
                SET @iCurr = @iCurr + 1;
                SET @Msg = 'Processing #' + CAST (@iCurr AS nvarchar (50)) + ' of ' + CAST (@iTotal AS nvarchar (50)) ;
                EXEC PrintImmediate @msg;
                SET @MySql = @T;
                IF @T = 'GO'
                    BEGIN
                        GOTO SKIPTHISREC;
                    END;
                SET @msg = 'Cmd ID#' + CAST (@R AS nvarchar (50)) + ' : ' + @MySql;
                EXEC PrintImmediate @msg;
                IF @SkippedProcessed = 1
               AND @P = 1
                    BEGIN
                        GOTO SKIPTHISREC;
                    END;
                BEGIN TRANSACTION TX1;
                BEGIN TRY
                    IF @MySQl != 'GO'
                        BEGIN EXEC (@MySql) ;
                        END;
                    COMMIT TRANSACTION TX1;
                END TRY
                BEGIN CATCH
                    ROLLBACK TRANSACTION TX1;
                    PRINT 'STATEMENT #' + CAST (@R AS nvarchar (50)) + ', failed - ' + CHAR (10) + @MySql;
                END CATCH;
                UPDATE MIGRATE_DataMart_Commands
                  SET Processed = 1
                  WHERE RowNbr = @R;
                CHECKPOINT;
                SKIPTHISREC:
                SET @LoopEndDate = GETDATE () ;
                SET @Msg = 'START / STOP: ' + CAST (@LoopStartDate AS nvarchar (50)) + ' / ' + CAST (@LoopEndDate AS nvarchar (50)) ;
                EXEC PrintImmediate @msg;
                DECLARE
                      @hrs AS decimal (10 , 3) = CAST (DATEDIFF (second , @LoopStartDate , @LoopEndDate) AS decimal (10 , 3)) / 60 / 60;
                SET @msg = 'Elapsed Hours: ' + CAST (@hrs AS nvarchar (50)) ;
                EXEC PrintImmediate @msg;
                FETCH NEXT FROM C INTO @T , @R , @P;
            END;

        CLOSE C;
        DEALLOCATE C;
    END;

PRINT '******************************************************';
PRINT '*********** COMPLETED ********************************';
PRINT '******************************************************';

