
/*
exec proc_STAGING_EDW_HA_Definition 0   --Process Changed Data only
exec proc_STAGING_EDW_HA_Definition 1   --Reload ALL
exec proc_STAGING_EDW_HA_Definition 0,7

select * from TEMP_EDW_HealthDefinition_DATA
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
       FROM DIM_EDW_HealthDefinition;

SELECT COUNT(*) FROM [view_EDW_HealthAssessmentDefinition_CT]	  --00:01:47
SELECT top 10 * FROM [view_EDW_HealthAssessmentDefinition_CT]
SELECT TOP 100 * FROM [DIM_EDW_HealthDefinition];
SELECT COUNT (*) FROM [DIM_EDW_HealthDefinition]; 

PERF Measurements
03.26.2015 : 4681580 rows - 01:26:36 run time / PROD 1 @ LAB - full reload
03.27.2015 : 4681580 rows - 01:01:20 run time / PROD 1 @ LAB - full reload
03.27.2015 : Prod2  @ LAB : (3711933 row(s) affected) : 01:56:01 - full reload
03.28.2015 : Prod3  @ LAB : (5697805 row(s) affected) : 05:45:57 - full reload
03.29.2015 : Prod2  @ LAB : (xx row(s) affected) : 01:56:01 - Changed Records

04.16.2015 : WDM - complted the SP and started testing.
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

    DECLARE
       @Synchronization_Version bigint = 0
     , @iVersion AS int
     , @Lastviewpull_Version AS bigint
     , @Lastpullversion AS bigint
     , @CurrentDbVersion AS int
     , @STime AS datetime
     , @TgtView AS nvarchar (100) = 'view_EDW_HealthDeffinition'
     , @ExtractionDate AS datetime
     , @ExtractedVersion AS int
     , @ExtractedRowCnt AS int
     , @EndTime AS datetime
     , @CNT_PulledRecords AS int = 0
     , @iCnt AS int = 0
     , @RowNbr AS int = 0
     , @StartTime AS datetime = GETDATE () 
     , @SVRName AS nvarchar (100) 
     , @DBName AS nvarchar (100) = DB_NAME () 
     , @CNT_Insert AS int = 0
     , @CNT_Update AS int = 0
     , @CNT_Delete AS int = 0
     , @CNT_StagingTable int = 0
     , @VersionNBR int = 0
     , @TrackProgress int = 1;

    SET @SVRName = (SELECT
                           @@SERVERNAME) ;

    SET @STime = GETDATE () ;

    DECLARE
       @RecordID AS uniqueidentifier = NEWID () ;
    EXEC proc_EDW_CT_ExecutionLog_Update @RecordID, 'proc_STAGING_EDW_HA_Definition', @STime, 0, 'I';

    IF @Reloadall = 1
        BEGIN
            IF EXISTS ( SELECT
                               NAME
                               FROM sys.tables
                          WHERE name = 'DIM_EDW_HealthDefinition') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping DIM_EDW_HealthDefinition for FULL reload.';
                        END;
                    --*******************************	 
                    --** DROP THE TABLE AND RECREATE
                    --*******************************
                    DROP TABLE
                         DIM_EDW_HealthDefinition;
                END;
            ELSE
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Reloading DIM_EDW_HealthDefinition.';
                        END;
                END;
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Standby, performing initial load of the HA definitions - this could take a couple of hours, Started at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            IF @Reloadall = 1
                BEGIN

                    PRINT 'RELOADING ALL EDW HA Data.';

                    SELECT
                           * INTO
                                  DIM_EDW_HealthDefinition
                           FROM view_EDW_HealthAssessmentDefinition_CT;

                    ALTER TABLE DIM_EDW_HealthDefinition
                    ADD
                                LastModifiedDate datetime NULL;
                    ALTER TABLE DIM_EDW_HealthDefinition
                    ADD
                                RowNbr  int IDENTITY (1, 1) ;
                    ALTER TABLE DIM_EDW_HealthDefinition
                    ADD
                                DeletedFlg  bit NULL;

                    IF @TrackProgress = 1
                        BEGIN
                            SET @iCnt = (SELECT
                                                COUNT (*) 
                                                FROM DIM_EDW_HealthDefinition) ;
                            PRINT DB_NAME () + ' - Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) + ' , loaded ' + CAST (@iCnt AS nvarchar (50)) + ' records.';
                        END;

                    SET @CNT_PulledRecords = (SELECT
                                                     COUNT (*) 
                                                     FROM DIM_EDW_HealthDefinition) ;
                    SET @CNT_StagingTable = @CNT_PulledRecords;
                    IF NOT EXISTS ( SELECT
                                           name
                                           FROM sys.indexes
                                      WHERE name = 'PI_EDW_HealthAssessment_IDs') 
                        BEGIN
                            IF @TrackProgress = 1
                                BEGIN
                                    PRINT 'Adding INDEX PI_EDW_HealthAssessment_IDs at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                                END;
                            CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.DIM_EDW_HealthDefinition (RCDocumentGuid, RADocumentGuid, RACodeName, QuesDocumentGuid, AnsDocumentGuid, HANodeSiteID) 
                            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                        END;

                    SET @ExtractionDate = GETDATE () ;
                    SET @ExtractedVersion = -1;
                    SET @ExtractedRowCnt = (SELECT
                                                   COUNT (*) 
                                                   FROM DIM_EDW_HealthDefinition) ;
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
                         , CNT_StagingTable
                    ) 
                    VALUES
                           (@ExtractionDate ,
                           @ExtractedVersion ,
                           @CurrentDbVersion ,
                           @ExtractedRowCnt ,
                           @TgtView ,
                           @StartTime ,
                           @EndTime,
                           @SVRName,
                           @DBName,
                           @CNT_Insert,
                           @CNT_Update,
                           @CNT_delete,
                           @CNT_PulledRecords,
                           @CNT_StagingTable) ;

                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Completed , RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                        END;

                END;
            -- SELECT * INTO [DIM_EDW_HealthDefinition] FROM [view_EDW_HealthAssessmentDefinition_CT];
            IF @TrackProgress = 1
                BEGIN
                    PRINT 'Completed , reloading at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            IF @TrackProgress = 1
                BEGIN
                    PRINT
                    'Completed FULL RELOAD at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
                END;

            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID, 'proc_STAGING_EDW_HA_Definition', @STime, @CNT_PulledRecords, 'U';
            RETURN;
        END;

    IF NOT EXISTS ( SELECT
                           NAME
                           FROM sys.tables
                      WHERE name = 'DIM_EDW_HealthDefinition') 
        BEGIN
            PRINT '****************************************************************************';
            PRINT 'FATAL ERROR: table DIM_EDW_HealthDefinition was NOT found, aborting.';
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
            --        CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.DIM_EDW_HealthDefinition ( ItemCreatedWhen ASC , ItemModifiedWhen ASC , HARiskCategory_ItemModifiedWhen ASC , HAUserRiskArea_ItemModifiedWhen ASC , HAUserQuestion_ItemModifiedWhen ASC , HAUserAnswers_ItemModifiedWhen ASC) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
            --    END;

            IF NOT EXISTS ( SELECT
                                   name
                                   FROM sys.indexes
                              WHERE name = 'PI_EDW_HealthAssessment_IDs') 
                BEGIN

                    PRINT 'Adding INDEX PI_EDW_HealthAssessment_IDs';

                    CREATE CLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.DIM_EDW_HealthDefinition (RCDocumentGuid, RADocumentGuid, RACodeName, QuesDocumentGuid, AnsDocumentGuid, HANodeSiteID) 
                    WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
                END;

            --The staging table exists, CHANGES will be determined and applied.

            IF EXISTS ( SELECT
                               name
                        --FROM tempdb.dbo.sysobjects
                        --WHERE id = OBJECT_ID ( N'tempdb..#DIM_EDW_HealthDefinition')) 
                               FROM sys.tables
                          WHERE name = 'TEMP_EDW_HealthDefinition_DATA') 
                BEGIN
                    IF @TrackProgress = 1
                        BEGIN
                            PRINT 'Dropping TEMP_EDW_HealthDefinition_DATA';
                        END;
                    DROP TABLE
                         TEMP_EDW_HealthDefinition_DATA;
                END;

            /*******************************************************************************/

            IF EXISTS (SELECT
                              name
                              FROM sys.tables
                         WHERE name = 'TEMP_EDW_HealthDefinition_DATA') 
                BEGIN
                    DROP TABLE
                         TEMP_EDW_HealthDefinition_DATA;
                END;

            SELECT
                   * INTO
                          TEMP_EDW_HealthDefinition_DATA
                   FROM view_EDW_HealthAssessmentDefinition_CT;
            --WHERE CHANGED_FLG IS NOT NULL;

            ALTER TABLE TEMP_EDW_HealthDefinition_DATA
            ADD
                        LastModifiedDate datetime NULL;
            ALTER TABLE TEMP_EDW_HealthDefinition_DATA
            ADD
                        RowNbr  int NULL;
            ALTER TABLE TEMP_EDW_HealthDefinition_DATA
            ADD
                        DeletedFlg  bit NULL;

            CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.TEMP_EDW_HealthDefinition_DATA (
            RCDocumentGuid, RADocumentGuid, RACodeName, QuesDocumentGuid, AnsDocumentGuid, HANodeSiteID) 
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

            SET @CNT_PulledRecords = (SELECT
                                             COUNT (*) 
                                             FROM TEMP_EDW_HealthDefinition_DATA) ;

            --select * from TEMP_EDW_HealthDefinition_DATA
            --update TEMP_EDW_HealthDefinition_DATA set AnsDocumentGuid = '1B8A2611-B0BF-4555-B609-56CC7D4EFC38' where AnsDocumentGuid = '001FBF56-C327-490F-AA15-4EB6F595D47A' and AnsPOints = 15
            --update TEMP_EDW_HealthDefinition_DATA set AnsDocumentGuid = newid() where AnsDocumentGuid = 'C1D9949E-786D-42F7-8E31-0619D8ED60BD' and AnsPOints = 0
            WITH CTE (
                 RCDocumentGuid
               , RADocumentGuid
               , RACodeName
               , QuesDocumentGuid
               , AnsDocumentGuid
               , HANodeSiteID
            ) 
                AS
                (
                SELECT
                       RCDocumentGuid
                     , RADocumentGuid
                     , RACodeName
                     , QuesDocumentGuid
                     , AnsDocumentGuid
                     , HANodeSiteID
                       FROM TEMP_EDW_HealthDefinition_DATA
                EXCEPT
                SELECT
                       RCDocumentGuid
                     , RADocumentGuid
                     , RACodeName
                     , QuesDocumentGuid
                     , AnsDocumentGuid
                     , HANodeSiteID
                --HANodeID
                --HADocumentID
                --RCDocPubVerID
                --QuesDocPubVerID
                       FROM DIM_EDW_HealthDefinition
                  WHERE LastModifiedDate IS NULL
                ) 
                INSERT INTO dbo.DIM_EDW_HealthDefinition
                (
                       SiteGUID
                     , AccountCD
                     , HANodeID
                     , HANodeName
                     , HADocumentID
                     , HANodeSiteID
                     , HADocPubVerID
                     , ModTitle
                     , IntroText
                     , ModDocGuid
                     , ModWeight
                     , ModIsEnabled
                     , ModCodeName
                     , ModDocPubVerID
                     , RCTitle
                     , RCWeight
                     , RCDocumentGUID
                     , RCIsEnabled
                     , RCCodeName
                     , RCDocPubVerID
                     , RATytle
                     , RAWeight
                     , RADocumentGuid
                     , RAIsEnabled
                     , RACodeName
                     , RAScoringStrategyID
                     , RADocPubVerID
                     , QuestionType
                     , QuesTitle
                     , QuesWeight
                     , QuesIsRequired
                     , QuesDocumentGuid
                     , QuesIsEnabled
                     , QuesIsVisible
                     , QuesIsSTaging
                     , QuestionCodeName
                     , QuesDocPubVerID
                     , AnsValue
                     , AnsPoints
                     , AnsDocumentGuid
                     , AnsIsEnabled
                     , AnsCodeName
                     , AnsUOM
                     , AnsDocPUbVerID
                     , ChangeType
                     , DocumentCreatedWhen
                     , DocumentModifiedWhen
                     , CmsTreeNodeGuid
                     , HANodeGUID
                     , SiteLastModified
                     , Account_ItemModifiedWhen
                     , Campaign_DocumentModifiedWhen
                     , Assessment_DocumentModifiedWhen
                     , Module_DocumentModifiedWhen
                     , RiskCategory_DocumentModifiedWhen
                     , RiskArea_DocumentModifiedWhen
                     , Question_DocumentModifiedWhen
                     , Answer_DocumentModifiedWhen
                     , AllowMultiSelect
                     , LocID
                     , CMS_Class_CtID
                     , CMS_Class_SCV
                     , CMS_Document_CtID
                     , CMS_Document_SCV
                     , CMS_Site_CtID
                     , CMS_Site_SCV
                     , CMS_Tree_CtID
                     , CMS_Tree_SCV
                     , CMS_User_CtID
                     , CMS_User_SCV
                     , COM_SKU_CtID
                     , COM_SKU_SCV
                     , HFit_HealthAssesmentMatrixQuestion_CtID
                     , HFit_HealthAssesmentMatrixQuestion_SCV
                     , HFit_HealthAssesmentModule_CtID
                     , HFit_HealthAssesmentModule_SCV
                     , HFit_HealthAssesmentMultipleChoiceQuestion_CtID
                     , HFit_HealthAssesmentMultipleChoiceQuestion_SCV
                     , HFit_HealthAssesmentRiskArea_CtID
                     , HFit_HealthAssesmentRiskArea_SCV
                     , HFit_HealthAssesmentRiskCategory_CtID
                     , HFit_HealthAssesmentRiskCategory_SCV
                     , HFit_HealthAssessment_CtID
                     , HFit_HealthAssessment_SCV
                     , HFit_HealthAssessmentFreeForm_CtID
                     , HFit_HealthAssessmentFreeForm_SCV
                     , CMS_Class_CHANGE_OPERATION
                     , CMS_Document_CHANGE_OPERATION
                     , CMS_Site_CHANGE_OPERATION
                     , CMS_Tree_CHANGE_OPERATION
                     , CMS_User_CHANGE_OPERATION
                     , COM_SKU_CHANGE_OPERATION
                     , HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
                     , HFit_HealthAssesmentModule_CHANGE_OPERATION
                     , HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
                     , HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
                     , HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
                     , HFit_HealthAssessment_CHANGE_OPERATION
                     , HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
                     , CHANGED_FLG
                     , CHANGE_TYPE_CODE
                     , LastModifiedDate
                       --,[RowNbr]
                     , DeletedFlg
                ) 
                SELECT
                       T.SiteGUID
                     , T.AccountCD
                     , T.HANodeID
                     , T.HANodeName
                     , T.HADocumentID
                     , T.HANodeSiteID
                     , T.HADocPubVerID
                     , T.ModTitle
                     , T.IntroText
                     , T.ModDocGuid
                     , T.ModWeight
                     , T.ModIsEnabled
                     , T.ModCodeName
                     , T.ModDocPubVerID
                     , T.RCTitle
                     , T.RCWeight
                     , T.RCDocumentGUID
                     , T.RCIsEnabled
                     , T.RCCodeName
                     , T.RCDocPubVerID
                     , T.RATytle
                     , T.RAWeight
                     , T.RADocumentGuid
                     , T.RAIsEnabled
                     , T.RACodeName
                     , T.RAScoringStrategyID
                     , T.RADocPubVerID
                     , T.QuestionType
                     , T.QuesTitle
                     , T.QuesWeight
                     , T.QuesIsRequired
                     , T.QuesDocumentGuid
                     , T.QuesIsEnabled
                     , T.QuesIsVisible
                     , T.QuesIsSTaging
                     , T.QuestionCodeName
                     , T.QuesDocPubVerID
                     , T.AnsValue
                     , T.AnsPoints
                     , T.AnsDocumentGuid
                     , T.AnsIsEnabled
                     , T.AnsCodeName
                     , T.AnsUOM
                     , T.AnsDocPUbVerID
                     , T.ChangeType
                     , T.DocumentCreatedWhen
                     , T.DocumentModifiedWhen
                     , T.CmsTreeNodeGuid
                     , T.HANodeGUID
                     , T.SiteLastModified
                     , T.Account_ItemModifiedWhen
                     , T.Campaign_DocumentModifiedWhen
                     , T.Assessment_DocumentModifiedWhen
                     , T.Module_DocumentModifiedWhen
                     , T.RiskCategory_DocumentModifiedWhen
                     , T.RiskArea_DocumentModifiedWhen
                     , T.Question_DocumentModifiedWhen
                     , T.Answer_DocumentModifiedWhen
                     , T.AllowMultiSelect
                     , T.LocID
                     , T.CMS_Class_CtID
                     , T.CMS_Class_SCV
                     , T.CMS_Document_CtID
                     , T.CMS_Document_SCV
                     , T.CMS_Site_CtID
                     , T.CMS_Site_SCV
                     , T.CMS_Tree_CtID
                     , T.CMS_Tree_SCV
                     , T.CMS_User_CtID
                     , T.CMS_User_SCV
                     , T.COM_SKU_CtID
                     , T.COM_SKU_SCV
                     , T.HFit_HealthAssesmentMatrixQuestion_CtID
                     , T.HFit_HealthAssesmentMatrixQuestion_SCV
                     , T.HFit_HealthAssesmentModule_CtID
                     , T.HFit_HealthAssesmentModule_SCV
                     , T.HFit_HealthAssesmentMultipleChoiceQuestion_CtID
                     , T.HFit_HealthAssesmentMultipleChoiceQuestion_SCV
                     , T.HFit_HealthAssesmentRiskArea_CtID
                     , T.HFit_HealthAssesmentRiskArea_SCV
                     , T.HFit_HealthAssesmentRiskCategory_CtID
                     , T.HFit_HealthAssesmentRiskCategory_SCV
                     , T.HFit_HealthAssessment_CtID
                     , T.HFit_HealthAssessment_SCV
                     , T.HFit_HealthAssessmentFreeForm_CtID
                     , T.HFit_HealthAssessmentFreeForm_SCV
                     , T.CMS_Class_CHANGE_OPERATION
                     , T.CMS_Document_CHANGE_OPERATION
                     , T.CMS_Site_CHANGE_OPERATION
                     , T.CMS_Tree_CHANGE_OPERATION
                     , T.CMS_User_CHANGE_OPERATION
                     , T.COM_SKU_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentModule_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
                     , T.HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
                     , T.HFit_HealthAssessment_CHANGE_OPERATION
                     , T.HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
                     , T.CHANGED_FLG
                     , T.CHANGE_TYPE_CODE
                     , NULL AS LastModifiedDate
                       --, T.[RowNbr]
                     , NULL AS DeletedFlg
                       FROM
                           TEMP_EDW_HealthDefinition_DATA AS T --JOIN TEMPXX AS S
                               JOIN CTE AS S
                                   ON
                                   S.RCDocumentGuid = T.RCDocumentGuid
                               AND S.RADocumentGuid = T.RADocumentGuid
                               AND S.RACodeName = T.RACodeName
                               AND S.QuesDocumentGuid = T.QuesDocumentGuid
                               AND S.AnsDocumentGuid = T.AnsDocumentGuid
                               AND S.HANodeSiteID = T.HANodeSiteID;
            --S.HANodeID = T.HANodeID
            --and S.HADocumentID is null
            --and T.HADocumentID is null
            --AND S.HADocumentID = T.HADocumentID
            --AND S.RCDocPubVerID = T.RCDocPubVerId
            --AND S.QuesDocPubVerID = T.QuesDocPubVerId

            --Check to see if CURRENT records have differnet HASH codes and if so, update the staging table
            SET @iCnt = (SELECT
                                COUNT (*) 
                                FROM
                                    DIM_EDW_HealthDefinition AS S
                                        JOIN TEMP_EDW_HealthDefinition_DATA AS T
                                            ON                 S.RCDocumentGuid = T.RCDocumentGuid
                                                           AND S.RADocumentGuid = T.RADocumentGuid
                                                           AND S.RACodeName = T.RACodeName
                                                           AND S.QuesDocumentGuid = T.QuesDocumentGuid
                                                           AND S.AnsDocumentGuid = T.AnsDocumentGuid
                                                           AND S.HANodeSiteID = T.HANodeSiteID
                           WHERE
                           S.HashCode != T.HashCode) ;

/*******************************************
		  UPDATE Records with a HashCode difference
		  *******************************************/

            UPDATE S
                   SET
                       S.SiteGUID = T.SiteGUID
                     ,S.AccountCD = T.AccountCD
                     ,S.HANodeID = T.HANodeID
                     ,S.HANodeName = T.HANodeName
                     ,S.HADocumentID = T.HADocumentID
                     ,S.HANodeSiteID = T.HANodeSiteID
                     ,S.HADocPubVerID = T.HADocPubVerID
                     ,S.ModTitle = T.ModTitle
                     ,S.IntroText = T.IntroText
                     ,S.ModDocGuid = T.ModDocGuid
                     ,S.ModWeight = T.ModWeight
                     ,S.ModIsEnabled = T.ModIsEnabled
                     ,S.ModCodeName = T.ModCodeName
                     ,S.ModDocPubVerID = T.ModDocPubVerID
                     ,S.RCTitle = T.RCTitle
                     ,S.RCWeight = T.RCWeight
                     ,S.RCDocumentGUID = T.RCDocumentGUID
                     ,S.RCIsEnabled = T.RCIsEnabled
                     ,S.RCCodeName = T.RCCodeName
                     ,S.RCDocPubVerID = T.RCDocPubVerID
                     ,S.RATytle = T.RATytle
                     ,S.RAWeight = T.RAWeight
                     ,S.RADocumentGuid = T.RADocumentGuid
                     ,S.RAIsEnabled = T.RAIsEnabled
                     ,S.RACodeName = T.RACodeName
                     ,S.RAScoringStrategyID = T.RAScoringStrategyID
                     ,S.RADocPubVerID = T.RADocPubVerID
                     ,S.QuestionType = T.QuestionType
                     ,S.QuesTitle = T.QuesTitle
                     ,S.QuesWeight = T.QuesWeight
                     ,S.QuesIsRequired = T.QuesIsRequired
                     ,S.QuesDocumentGuid = T.QuesDocumentGuid
                     ,S.QuesIsEnabled = T.QuesIsEnabled
                     ,S.QuesIsVisible = T.QuesIsVisible
                     ,S.QuesIsSTaging = T.QuesIsSTaging
                     ,S.QuestionCodeName = T.QuestionCodeName
                     ,S.QuesDocPubVerID = T.QuesDocPubVerID
                     ,S.AnsValue = T.AnsValue
                     ,S.AnsPoints = T.AnsPoints
                     ,S.AnsDocumentGuid = T.AnsDocumentGuid
                     ,S.AnsIsEnabled = T.AnsIsEnabled
                     ,S.AnsCodeName = T.AnsCodeName
                     ,S.AnsUOM = T.AnsUOM
                     ,S.AnsDocPUbVerID = T.AnsDocPUbVerID
                     ,S.ChangeType = T.ChangeType
                     ,S.DocumentCreatedWhen = T.DocumentCreatedWhen
                     ,S.DocumentModifiedWhen = T.DocumentModifiedWhen
                     ,S.CmsTreeNodeGuid = T.CmsTreeNodeGuid
                     ,S.HANodeGUID = T.HANodeGUID
                     ,S.SiteLastModified = T.SiteLastModified
                     ,S.Account_ItemModifiedWhen = T.Account_ItemModifiedWhen
                     ,S.Campaign_DocumentModifiedWhen = T.Campaign_DocumentModifiedWhen
                     ,S.Assessment_DocumentModifiedWhen = T.Assessment_DocumentModifiedWhen
                     ,S.Module_DocumentModifiedWhen = T.Module_DocumentModifiedWhen
                     ,S.RiskCategory_DocumentModifiedWhen = T.RiskCategory_DocumentModifiedWhen
                     ,S.RiskArea_DocumentModifiedWhen = T.RiskArea_DocumentModifiedWhen
                     ,S.Question_DocumentModifiedWhen = T.Question_DocumentModifiedWhen
                     ,S.Answer_DocumentModifiedWhen = T.Answer_DocumentModifiedWhen
                     ,S.AllowMultiSelect = T.AllowMultiSelect
                     ,S.LocID = T.LocID
                     ,S.CMS_Class_CtID = T.CMS_Class_CtID
                     ,S.CMS_Class_SCV = T.CMS_Class_SCV
                     ,S.CMS_Document_CtID = T.CMS_Document_CtID
                     ,S.CMS_Document_SCV = T.CMS_Document_SCV
                     ,S.CMS_Site_CtID = T.CMS_Site_CtID
                     ,S.CMS_Site_SCV = T.CMS_Site_SCV
                     ,S.CMS_Tree_CtID = T.CMS_Tree_CtID
                     ,S.CMS_Tree_SCV = T.CMS_Tree_SCV
                     ,S.CMS_User_CtID = T.CMS_User_CtID
                     ,S.CMS_User_SCV = T.CMS_User_SCV
                     ,S.COM_SKU_CtID = T.COM_SKU_CtID
                     ,S.COM_SKU_SCV = T.COM_SKU_SCV
                     ,S.HFit_HealthAssesmentMatrixQuestion_CtID = T.HFit_HealthAssesmentMatrixQuestion_CtID
                     ,S.HFit_HealthAssesmentMatrixQuestion_SCV = T.HFit_HealthAssesmentMatrixQuestion_SCV
                     ,S.HFit_HealthAssesmentModule_CtID = T.HFit_HealthAssesmentModule_CtID
                     ,S.HFit_HealthAssesmentModule_SCV = T.HFit_HealthAssesmentModule_SCV
                     ,S.HFit_HealthAssesmentMultipleChoiceQuestion_CtID = T.HFit_HealthAssesmentMultipleChoiceQuestion_CtID
                     ,S.HFit_HealthAssesmentMultipleChoiceQuestion_SCV = T.HFit_HealthAssesmentMultipleChoiceQuestion_SCV
                     ,S.HFit_HealthAssesmentRiskArea_CtID = T.HFit_HealthAssesmentRiskArea_CtID
                     ,S.HFit_HealthAssesmentRiskArea_SCV = T.HFit_HealthAssesmentRiskArea_SCV
                     ,S.HFit_HealthAssesmentRiskCategory_CtID = T.HFit_HealthAssesmentRiskCategory_CtID
                     ,S.HFit_HealthAssesmentRiskCategory_SCV = T.HFit_HealthAssesmentRiskCategory_SCV
                     ,S.HFit_HealthAssessment_CtID = T.HFit_HealthAssessment_CtID
                     ,S.HFit_HealthAssessment_SCV = T.HFit_HealthAssessment_SCV
                     ,S.HFit_HealthAssessmentFreeForm_CtID = T.HFit_HealthAssessmentFreeForm_CtID
                     ,S.HFit_HealthAssessmentFreeForm_SCV = T.HFit_HealthAssessmentFreeForm_SCV
                     ,S.CMS_Class_CHANGE_OPERATION = T.CMS_Class_CHANGE_OPERATION
                     ,S.CMS_Document_CHANGE_OPERATION = T.CMS_Document_CHANGE_OPERATION
                     ,S.CMS_Site_CHANGE_OPERATION = T.CMS_Site_CHANGE_OPERATION
                     ,S.CMS_Tree_CHANGE_OPERATION = T.CMS_Tree_CHANGE_OPERATION
                     ,S.CMS_User_CHANGE_OPERATION = T.CMS_User_CHANGE_OPERATION
                     ,S.COM_SKU_CHANGE_OPERATION = T.COM_SKU_CHANGE_OPERATION
                     ,S.HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION = T.HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
                     ,S.HFit_HealthAssesmentModule_CHANGE_OPERATION = T.HFit_HealthAssesmentModule_CHANGE_OPERATION
                     ,S.HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION = T.HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
                     ,S.HFit_HealthAssesmentRiskArea_CHANGE_OPERATION = T.HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
                     ,S.HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION = T.HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
                     ,S.HFit_HealthAssessment_CHANGE_OPERATION = T.HFit_HealthAssessment_CHANGE_OPERATION
                     ,S.HFit_HealthAssessmentFreeForm_CHANGE_OPERATION = T.HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
                     ,S.CHANGED_FLG = T.CHANGED_FLG
                     ,S.CHANGE_TYPE_CODE = T.CHANGE_TYPE_CODE
                     ,S.LastModifiedDate = GETDATE () 
                     ,S.DeletedFlg = NULL
                       FROM DIM_EDW_HealthDefinition AS S
                                JOIN TEMP_EDW_HealthDefinition_DATA AS T
                                    ON S.RCDocumentGuid = T.RCDocumentGuid
                                   AND S.RADocumentGuid = T.RADocumentGuid
                                   AND S.RACodeName = T.RACodeName
                                   AND S.QuesDocumentGuid = T.QuesDocumentGuid
                                   AND S.AnsDocumentGuid = T.AnsDocumentGuid
                                   AND S.HANodeSiteID = T.HANodeSiteID
              WHERE
                    T.HashCode != S.HashCode;

/************************************************
FIND ANY DELETED ROWS
************************************************/

            WITH CTE (
                 RCDocumentGuid
               , RADocumentGuid
               , RACodeName
               , QuesDocumentGuid
               , AnsDocumentGuid
               , HANodeSiteID) 
                AS
                (
                SELECT
                       RCDocumentGuid
                     , RADocumentGuid
                     , RACodeName
                     , QuesDocumentGuid
                     , AnsDocumentGuid
                     , HANodeSiteID
                       FROM DIM_EDW_HealthDefinition
                EXCEPT
                SELECT
                       RCDocumentGuid
                     , RADocumentGuid
                     , RACodeName
                     , QuesDocumentGuid
                     , AnsDocumentGuid
                     , HANodeSiteID
                       FROM TEMP_EDW_HealthDefinition_DATA
                ) 
                UPDATE S
                       SET
                           S.DeletedFlg = 1
                           FROM CTE AS T
                                    JOIN DIM_EDW_HealthDefinition AS S
                                        ON
                                        S.RCDocumentGuid = T.RCDocumentGuid
                                    AND S.RADocumentGuid = T.RADocumentGuid
                                    AND S.RACodeName = T.RACodeName
                                    AND S.QuesDocumentGuid = T.QuesDocumentGuid
                                    AND S.AnsDocumentGuid = T.AnsDocumentGuid
                                    AND S.HANodeSiteID = T.HANodeSiteID;

            SET @CNT_StagingTable = (SELECT
                                            COUNT (*) 
                                            FROM DIM_EDW_HealthDefinition) ;
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

            SET @CNT_PulledRecords = (SELECT
                                             COUNT (*) 
                                             FROM TEMP_EDW_HealthDefinition_DATA) ;
            SET @STime = GETDATE () ;
            EXEC proc_EDW_CT_ExecutionLog_Update @RecordID, 'proc_STAGING_EDW_HA_Definition', @STime, @CNT_PulledRecords, 'U';

        END;
END;

GO
PRINT 'Created proc_STAGING_EDW_HA_Definition';
GO 
