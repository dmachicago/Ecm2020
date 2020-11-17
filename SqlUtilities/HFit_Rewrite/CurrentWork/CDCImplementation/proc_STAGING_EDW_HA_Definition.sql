
GO

-- use KenticoCMS_Prod1

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/

/*----------------------------------------------------------------------------
exec proc_STAGING_EDW_HA_Definition 0   --Process Changed Data only
exec proc_STAGING_EDW_HA_Definition 1   --Reload ALL
exec proc_STAGING_EDW_HA_Definition 0,7

select * from ##TEMP_EDW_HealthDefinition_DATA
select  * from CT_VersionTracking ; 
select * from view_EDW_HealthAssessmentDefinition_CT

PULLING Changes for versions between: 42944  and 43281
PULLING Changes for versions between: 43284  and 43287
PULLING Changes for versions between: 43455  and 43468
PULLING Changes for versions between: 43625  and 43627
PULLING Changes for versions between: 43629  and 43632
PULLING Changes for versions between: 43635  and 43691

PULLING Changes for versions between: 11  and 14

SELECT
       COUNT (*) 
       FROM STAGING_EDW_HA_Definition;

SELECT COUNT(*) FROM [view_EDW_HealthAssessmentDefinition_CT]	  --00:01:47
SELECT top 10 * FROM [view_EDW_HealthAssessmentDefinition_CT]
SELECT TOP 100 * FROM [STAGING_EDW_HA_Definition];
SELECT COUNT (*) FROM [STAGING_EDW_HA_Definition]; 

PERF Measurements
03.26.2015 : 4681580 rows - 01:26:36 run time / PROD 1 @ LAB - full reload
03.27.2015 : 4681580 rows - 01:01:20 run time / PROD 1 @ LAB - full reload
03.27.2015 : Prod2  @ LAB : (3711933 row(s) affected) : 01:56:01 - full reload
03.28.2015 : Prod3  @ LAB : (5697805 row(s) affected) : 05:45:57 - full reload
03.29.2015 : Prod2  @ LAB : (xx row(s) affected) : 01:56:01 - Changed Records

04.16.2015 : WDM - complted the SP and started testing.
05.28.2015 : WDM - completed unit testing 
*/

GO
PRINT 'FROM proc_STAGING_EDW_HA_Definition.SQL';
PRINT 'Creating proc_STAGING_EDW_HA_Definition';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_STAGING_EDW_HA_Definition') 
    BEGIN
        PRINT 'Replacing proc_STAGING_EDW_HA_Definition proc';
        DROP PROCEDURE
             proc_STAGING_EDW_HA_Definition;
    END;
GO

CREATE PROCEDURE proc_STAGING_EDW_HA_Definition
       @Reloadall int = 0
AS
BEGIN

/*---------------------------------------
Developer  : W. Dale Miller
05.28.2015 : WDM - completed unit testing
*/
    SET NOCOUNT ON;
    DECLARE
    @iTotal AS bigint = 0;

    EXEC @iTotal = proc_QuickRowCount 'STAGING_EDW_HA_Definition';

    IF @iTotal <= 1
        BEGIN
            PRINT 'NO RECORDS FOUND IN STAGING TABLE - Reloading all.';
            SET @Reloadall = 1;
        END;

    DECLARE
    @Synchronization_Version bigint = 0
  , @iVersion AS int
  , @Lastviewpull_Version AS bigint
  , @Lastpullversion AS bigint
  , @CurrentDbVersion AS int
  , @STime AS datetime
  , @TgtView AS nvarchar ( 100) = 'view_EDW_HealthDeffinition'
  , @ExtractionDate AS datetime
  , @ExtractedVersion AS int
  , @ExtractedRowCnt AS int
  , @EndTime AS datetime
  , @CNT_PulledRecords AS int = 0
  , @iCnt AS int = 0
  , @RowNbr AS int = 0
  , @StartTime AS datetime = GETDATE () 
  , @SVRName AS nvarchar ( 100) 
  , @DBName AS nvarchar ( 100) = DB_NAME () 
  , @CNT_Insert AS int = 0
  , @CNT_Update AS int = 0
  , @CNT_Delete AS int = 0
  , @CNT_StagingTable int = 0
  , @VersionNBR int = 0
  , @TrackProgress int = 1;

    SET @SVRName = ( SELECT
                            @@SERVERNAME) ;

    SET @STime = GETDATE () ;

    DECLARE
    @RecordID AS uniqueidentifier = NEWID () ;
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_HA_Definition' , @STime , 0 , 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                               FROM sys.tables
                               WHERE name = 'STAGING_EDW_HA_Definition') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping STAGING_EDW_HA_Definition for FULL reload.';
                        END;
                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    DROP TABLE
                         STAGING_EDW_HA_Definition;
                END;
            ELSE
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading STAGING_EDW_HA_Definition.';
                        END;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA definitions - this could take a couple of hours, Started at: ' + CAST ( GETDATE
                          () AS nvarchar ( 50)) ;
                END;

            IF @Reloadall = 1
                BEGIN

                    PRINT 'RELOADING ALL EDW HA Data.';

                    SELECT
                           * INTO
                                  STAGING_EDW_HA_Definition
                           FROM view_EDW_HealthAssessmentDefinition_CT;
                    EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @@ROWCOUNT;

                    EXEC proc_Add_EDW_CT_StdCols 'STAGING_EDW_HA_Definition';

                    SET @iCnt = ( SELECT
                                         COUNT ( *) 
                                         FROM STAGING_EDW_HA_Definition) ;
                    PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST ( @iCnt
                          AS nvarchar ( 50)) + ' records.';

                    SET @CNT_PulledRecords = ( SELECT
                                                      COUNT ( *) 
                                                      FROM STAGING_EDW_HA_Definition) ;
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                           FROM sys.indexes
                                           WHERE name = 'PI_EDW_HealthAssessment_IDs') 
                        BEGIN
                            PRINT 'Adding INDEX PI_EDW_HealthAssessment_IDs at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                            CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.STAGING_EDW_HA_Definition ( RCDocumentGuid ,
                            RADocumentGuid , RACodeName , QuesDocumentGuid , AnsDocumentGuid , HANodeSiteID) WITH ( PAD_INDEX = OFF ,
                            STATISTICS_NORECOMPUTE = OFF ,
                            SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;

                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = ( SELECT
                                                    COUNT ( *) 
                                                    FROM STAGING_EDW_HA_Definition) ;
                    --SET @TgtView = 'view_EDW_HealthDeffinition';
                    SET @EndTime = GETDATE () ;

                    INSERT INTO CT_VersionTracking (
                           ExtractionDate
                         , ExtractedVersion
                         , CurrentDbVersion
                         , ExtractedRowCnt
                         , TgtView
                         , StartTime
                         , EndTime
                         , SVRName
                         , DBName
                         , CNT_Insert
                         , CNT_Update
                         , CNT_delete
                         , CNT_PulledRecords
                         , CNT_StagingTable) 
                    VALUES
                    (
                    @ExtractionDate , @ExtractedVersion , @CurrentDbVersion , @ExtractedRowCnt , @TgtView , @StartTime , @EndTime , @SVRName ,
                    @DBName , @CNT_Insert , @CNT_Update , @CNT_delete , @CNT_PulledRecords , @CNT_StagingTable) ;

                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;

                END;
            -- SELECT * INTO [STAGING_EDW_HA_Definition] FROM [view_EDW_HealthAssessmentDefinition_CT];
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            SET @STime = GETDATE () ;

            EXEC proc_EDW_ChangeGmtToCentralTime 'STAGING_EDW_HA_Definition';
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_HA_Definition' , @STime , @CNT_PulledRecords , 'U';
            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                           WHERE name = 'STAGING_EDW_HA_Definition') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table STAGING_EDW_HA_Definition was NOT found, aborting.';
            PRINT '****************************************************************************';
        END;
    ELSE
        BEGIN

            --IF NOT EXISTS ( SELECT
            --                name
            --                  FROM sys.indexes
            --                  WHERE name = 'PI_EDW_HealthAssessment_IDs') 
            --    BEGIN
            --        IF @TrackProgress = 1
            --            BEGIN
            --                PRINT 'Adding INDEX PI_EDW_HealthAssessment_IDs';
            --            END;
            --        CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.STAGING_EDW_HA_Definition ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
            --    END;

            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                                   WHERE name = 'PI_EDW_HealthAssessment_IDs') 
                BEGIN

                    PRINT 'Adding INDEX PI_EDW_HealthAssessment_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.STAGING_EDW_HA_Definition ( RCDocumentGuid , RADocumentGuid ,
                    RACodeName , QuesDocumentGuid , AnsDocumentGuid , HANodeSiteID) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF ,
                    SORT_IN_TEMPDB = OFF ,
                    DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                               FROM tempdb.dbo.sysobjects
                               WHERE id = OBJECT_ID ( N'tempdb..##TEMP_EDW_HealthDefinition_DATA')) 
                --FROM sys.tables
                --WHERE name = '##TEMP_EDW_HealthDefinition_DATA') 
                BEGIN
                    PRINT 'Dropping ##TEMP_EDW_HealthDefinition_DATA';
                    DROP TABLE
                         ##TEMP_EDW_HealthDefinition_DATA;
                END;

--*****************************************************************************************

            SELECT
                   * INTO
                          ##TEMP_EDW_HealthDefinition_DATA
                   FROM view_EDW_HealthAssessmentDefinition_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

            EXEC proc_Add_EDW_CT_StdCols '##TEMP_EDW_HealthDefinition_DATA';

            CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.##TEMP_EDW_HealthDefinition_DATA
            (	 RCDocumentGuid ,
            RADocumentGuid ,
            RACodeName ,
            QuesDocumentGuid ,
            AnsDocumentGuid ,
            HANodeSiteID) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF ,
            SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                              FROM ##TEMP_EDW_HealthDefinition_DATA) ;

--*****************************************************************************************
-- ADD NEW RECORDS
--*****************************************************************************************
            DECLARE
            @iNewInserts AS int = 0;
            EXEC @iNewInserts = proc_CT_HA_Definition_AddNewRecs ;
            PRINT 'new inserts: ' + CAST ( @iNewInserts AS nvarchar ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iNewInserts;

--*****************************************************************************************
-- ADD UPDATED RECORDS
--*****************************************************************************************
            --select top 100 * from ##TEMP_EDW_HealthDefinition_DATA
            DECLARE
            @iUpdates AS int = 0;
            EXEC @iUpdates = proc_CT_HA_Definition_AddUpdatedRecs ;
            PRINT 'Updated Records: ' + CAST ( @iUpdates AS nvarchar ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdates;

--*****************************************************************************************
--		  FIND ANY DELETED ROWS
--*****************************************************************************************
            DECLARE
            @iDeleted AS int = 0;
            EXEC @iDeleted = proc_CT_HA_Definition_AddDeletedRecs ;
            PRINT 'MARKED Deleted Records: ' + CAST ( @iDeleted AS nvarchar ( 50)) ;
            EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @iDeleted;

--*****************************************************************************************
            SET @CNT_StagingTable = ( SELECT
                                             COUNT ( *) 
                                             FROM STAGING_EDW_HA_Definition) ;
            UPDATE CT_VersionTracking
              SET
                  CNT_PulledRecords = @iCnt
                   WHERE
                         RowNbr = @RowNbr;

            UPDATE CT_VersionTracking
              SET
                  CNT_StagingTable = @CNT_StagingTable
                   WHERE
                         RowNbr = @RowNbr;

            SET @CNT_PulledRecords = ( SELECT
                                              COUNT ( *) 
                                              FROM ##TEMP_EDW_HealthDefinition_DATA) ;

            EXEC proc_EDW_ChangeGmtToCentralTime 'STAGING_EDW_HA_Definition';
            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , 'proc_STAGING_EDW_HA_Definition' , @STime , @CNT_PulledRecords , 'U';

        END;
    SET NOCOUNT OFF;
END;

GO
PRINT 'Created proc_STAGING_EDW_HA_Definition';
GO 
