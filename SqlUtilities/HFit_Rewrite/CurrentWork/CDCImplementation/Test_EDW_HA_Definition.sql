
/**************************************************************

-- use KenticoCMS_Prod1

TEST proc_STAGING_EDW_HA_Definition

Author: W. Dale Miller
06.18.2015 - PAssed all tests

***************************************************************/

PRINT '****************************************************************';
PRINT '** TEST #1 proc_STAGING_EDW_HA_Definition Initial counts ';
PRINT '****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1 ) WITH NOWAIT;

SET NOCOUNT ON;

DECLARE
   @DBN AS nvarchar ( 100 ) = DB_NAME ( )
   ,@JNAME AS nvarchar ( 100 ) = 'job_EDW_GetStagingData_HADefinition_' + DB_NAME ( )
   ,@b AS int = 0
   ,@ERRCNT AS int = 0;


DECLARE
   @iCnt AS int = 0
   ,@iTotalRecs AS int = 0;

SET @iTotalRecs = ( SELECT
                           COUNT ( * )
                      FROM view_EDW_HealthAssesmentDeffinition );
SET @iCnt = ( SELECT
                     COUNT ( * )
                FROM view_EDW_HealthAssessmentDefinition_CT );
PRINT 'Row count from view_EDW_HealthAssessmentDefinition_CT : ' + CAST ( @iTotalRecs AS nvarchar( 50 ));
PRINT 'Row count from parent view_EDW_HealthAssessmentDefinition: ' + CAST ( @iCnt AS nvarchar( 50 ));
PRINT '**********************************************************************';
--Test the RELOAD ALL of the procedure 130
if not exists (select name from sys.tables where name = 'STAGING_EDW_HA_Definition')
    EXEC proc_STAGING_EDW_HA_Definition 1;

DECLARE
   @RecsLoaded AS int = ( SELECT
                                 COUNT ( * )
                            FROM STAGING_EDW_HA_Definition );

if @RecsLoaded = 0 
    EXEC proc_STAGING_EDW_HA_Definition 1;

set @RecsLoaded = ( SELECT
                                 COUNT ( * )
                            FROM STAGING_EDW_HA_Definition );

PRINT 'Records Loaded in initial load: ' + CAST ( @RecsLoaded AS nvarchar( 50 ));
--Test the LOAD Changes Only of the procedure
EXEC proc_STAGING_EDW_HA_Definition 0;

IF EXISTS ( SELECT
                   name
              FROM sys.tables
              WHERE name = 'TEMP_HFit_HealthAssesmentModule_TestData' )
    BEGIN
        PRINT 'Dropped TEMP_HFit_HealthAssesmentModule_TestData table ';
        DROP TABLE
             TEMP_HFit_HealthAssesmentModule_TestData;
    END;

/*** BACKUP THE BASE TABLE BEFORE PROCEEDING ***/

IF NOT EXISTS ( SELECT
                       name
                  FROM sys.tables
                  WHERE name = 'TEMP_HFit_HealthAssesmentModule_FULL_Backup' )
    BEGIN
        SELECT
               *
        INTO
             TEMP_HFit_HealthAssesmentModule_FULL_Backup
          FROM KenticoCMS_Prod2.dbo.HFit_HealthAssesmentModule;
    END;

/*Get 100 rows and save them for testing purposes*/

SELECT TOP 100
       *
INTO
     TEMP_HFit_HealthAssesmentModule_TestData    
  FROM HFit_HealthAssesmentModule
  ORDER BY
           HealthAssesmentModuleID DESC;
--select * from TEMP_HFit_HealthAssesmentModule_TestData

/**************************************************************************************************************************
    Modify a portion of the 100 rows AND validate that change tracking finds them and updates the staging table.
    NOTE: The column to be modified will have to be validated for each base table to ensure it is used in the view.
**************************************************************************************************************************/

/*
Confirm that INSERTS are detected and registered.
select * from ##TEMP_EDW_HealthDefinition_DATA
NOTE: This statement will have to be tailored for each use
*/

DECLARE
   @iCntBeforeInsert AS int = 0;
SET @iCntBeforeInsert = ( SELECT
                                 COUNT ( * )
                            FROM ##TEMP_EDW_HealthDefinition_DATA );
PRINT 'Staging Record Count Before Insert: ' + CAST ( @iCntBeforeInsert AS nvarchar( 50 ));

INSERT INTO dbo.##TEMP_EDW_HealthDefinition_DATA
(
       SiteGUID
       ,AccountCD
       ,HANodeID
       ,HANodeName
       ,HADocumentID
       ,HANodeSiteID
       ,HADocPubVerID
       ,ModTitle
       ,IntroText
       ,ModDocGuid
       ,ModWeight
       ,ModIsEnabled
       ,ModCodeName
       ,ModDocPubVerID
       ,RCTitle
       ,RCWeight
       ,RCDocumentGUID
       ,RCIsEnabled
       ,RCCodeName
       ,RCDocPubVerID
       ,RATytle
       ,RAWeight
       ,RADocumentGuid
       ,RAIsEnabled
       ,RACodeName
       ,RAScoringStrategyID
       ,RADocPubVerID
       ,QuestionType
       ,QuesTitle
       ,QuesWeight
       ,QuesIsRequired
       ,QuesDocumentGuid
       ,QuesIsEnabled
       ,QuesIsVisible
       ,QuesIsSTaging
       ,QuestionCodeName
       ,QuesDocPubVerID
       ,AnsValue
       ,AnsPoints
       ,AnsDocumentGuid
       ,AnsIsEnabled
       ,AnsCodeName
       ,AnsUOM
       ,AnsDocPUbVerID
       ,ChangeType
       ,DocumentCreatedWhen
       ,DocumentModifiedWhen
       ,CmsTreeNodeGuid
       ,HANodeGUID
       ,SiteLastModified
       ,Account_ItemModifiedWhen
       ,Campaign_DocumentModifiedWhen
       ,Assessment_DocumentModifiedWhen
       ,Module_DocumentModifiedWhen
       ,RiskCategory_DocumentModifiedWhen
       ,RiskArea_DocumentModifiedWhen
       ,Question_DocumentModifiedWhen
       ,Answer_DocumentModifiedWhen
       ,AllowMultiSelect
       ,LocID
       ,HashCode
       ,CMS_Class_CtID
       ,CMS_Class_SCV
       ,CMS_Document_CtID
       ,CMS_Document_SCV
       ,CMS_Site_CtID
       ,CMS_Site_SCV
       ,CMS_Tree_CtID
       ,CMS_Tree_SCV
       ,CMS_User_CtID
       ,CMS_User_SCV
       ,COM_SKU_CtID
       ,COM_SKU_SCV
       ,HFit_HealthAssesmentMatrixQuestion_CtID
       ,HFit_HealthAssesmentMatrixQuestion_SCV
       ,HFit_HealthAssesmentModule_CtID
       ,HFit_HealthAssesmentModule_SCV
       ,HFit_HealthAssesmentMultipleChoiceQuestion_CtID
       ,HFit_HealthAssesmentMultipleChoiceQuestion_SCV
       ,HFit_HealthAssesmentRiskArea_CtID
       ,HFit_HealthAssesmentRiskArea_SCV
       ,HFit_HealthAssesmentRiskCategory_CtID
       ,HFit_HealthAssesmentRiskCategory_SCV
       ,HFit_HealthAssessment_CtID
       ,HFit_HealthAssessment_SCV
       ,HFit_HealthAssessmentFreeForm_CtID
       ,HFit_HealthAssessmentFreeForm_SCV
       ,CMS_Class_CHANGE_OPERATION
       ,CMS_Document_CHANGE_OPERATION
       ,CMS_Site_CHANGE_OPERATION
       ,CMS_Tree_CHANGE_OPERATION
       ,CMS_User_CHANGE_OPERATION
       ,COM_SKU_CHANGE_OPERATION
       ,HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
       ,HFit_HealthAssesmentModule_CHANGE_OPERATION
       ,HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
       ,HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
       ,HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
       ,HFit_HealthAssessment_CHANGE_OPERATION
       ,HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
       ,CHANGED_FLG
       ,CHANGE_TYPE_CODE
       ,LastModifiedDate
       ,RowNbr
       ,DeletedFlg )
VALUES
(
-100
, -100
, -100
, 'XXX_1'
, -100
, -100
, -100
, 'XXX_1'
, 'XXX_1'
, NEWID ( )
, -100
, 0
, 'XXX_1'
, -100
, 'XXX_1'
, -100
, NEWID ( )
, 0
, 'XXX_1'
, -100
, 'XXX_1'
, -100
, NEWID ( )
, 0
, 'XXX_1'
, -100
, -100
, 'XXX_1'
, 'XXX_1'
, -100
, 0
, NEWID ( )
, 0
, 'XXX_1'
, 0
, 'XXX_1'
, -100
, 'XXX_1'
, -100
, NEWID ( )
, 0
, 'XXX_1'
, 'XXX_1'
, -100
, 'I'
, GETDATE ( )
, GETDATE ( )
, NEWID ( )
, NEWID ( )
, -100
, -100
, -100
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, 0
, 'XXX_1'
, HASHBYTES ( 'sha1' , 'XXX_1' )
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, NULL
, 'I'
, NULL
, NULL
, NULL );

INSERT INTO dbo.##TEMP_EDW_HealthDefinition_DATA
(
       SiteGUID
       ,AccountCD
       ,HANodeID
       ,HANodeName
       ,HADocumentID
       ,HANodeSiteID
       ,HADocPubVerID
       ,ModTitle
       ,IntroText
       ,ModDocGuid
       ,ModWeight
       ,ModIsEnabled
       ,ModCodeName
       ,ModDocPubVerID
       ,RCTitle
       ,RCWeight
       ,RCDocumentGUID
       ,RCIsEnabled
       ,RCCodeName
       ,RCDocPubVerID
       ,RATytle
       ,RAWeight
       ,RADocumentGuid
       ,RAIsEnabled
       ,RACodeName
       ,RAScoringStrategyID
       ,RADocPubVerID
       ,QuestionType
       ,QuesTitle
       ,QuesWeight
       ,QuesIsRequired
       ,QuesDocumentGuid
       ,QuesIsEnabled
       ,QuesIsVisible
       ,QuesIsSTaging
       ,QuestionCodeName
       ,QuesDocPubVerID
       ,AnsValue
       ,AnsPoints
       ,AnsDocumentGuid
       ,AnsIsEnabled
       ,AnsCodeName
       ,AnsUOM
       ,AnsDocPUbVerID
       ,ChangeType
       ,DocumentCreatedWhen
       ,DocumentModifiedWhen
       ,CmsTreeNodeGuid
       ,HANodeGUID
       ,SiteLastModified
       ,Account_ItemModifiedWhen
       ,Campaign_DocumentModifiedWhen
       ,Assessment_DocumentModifiedWhen
       ,Module_DocumentModifiedWhen
       ,RiskCategory_DocumentModifiedWhen
       ,RiskArea_DocumentModifiedWhen
       ,Question_DocumentModifiedWhen
       ,Answer_DocumentModifiedWhen
       ,AllowMultiSelect
       ,LocID
       ,HashCode
       ,CMS_Class_CtID
       ,CMS_Class_SCV
       ,CMS_Document_CtID
       ,CMS_Document_SCV
       ,CMS_Site_CtID
       ,CMS_Site_SCV
       ,CMS_Tree_CtID
       ,CMS_Tree_SCV
       ,CMS_User_CtID
       ,CMS_User_SCV
       ,COM_SKU_CtID
       ,COM_SKU_SCV
       ,HFit_HealthAssesmentMatrixQuestion_CtID
       ,HFit_HealthAssesmentMatrixQuestion_SCV
       ,HFit_HealthAssesmentModule_CtID
       ,HFit_HealthAssesmentModule_SCV
       ,HFit_HealthAssesmentMultipleChoiceQuestion_CtID
       ,HFit_HealthAssesmentMultipleChoiceQuestion_SCV
       ,HFit_HealthAssesmentRiskArea_CtID
       ,HFit_HealthAssesmentRiskArea_SCV
       ,HFit_HealthAssesmentRiskCategory_CtID
       ,HFit_HealthAssesmentRiskCategory_SCV
       ,HFit_HealthAssessment_CtID
       ,HFit_HealthAssessment_SCV
       ,HFit_HealthAssessmentFreeForm_CtID
       ,HFit_HealthAssessmentFreeForm_SCV
       ,CMS_Class_CHANGE_OPERATION
       ,CMS_Document_CHANGE_OPERATION
       ,CMS_Site_CHANGE_OPERATION
       ,CMS_Tree_CHANGE_OPERATION
       ,CMS_User_CHANGE_OPERATION
       ,COM_SKU_CHANGE_OPERATION
       ,HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
       ,HFit_HealthAssesmentModule_CHANGE_OPERATION
       ,HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
       ,HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
       ,HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
       ,HFit_HealthAssessment_CHANGE_OPERATION
       ,HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
       ,CHANGED_FLG
       ,CHANGE_TYPE_CODE
       ,LastModifiedDate
       ,RowNbr
       ,DeletedFlg )
VALUES
(
-100
, -100
, -100
, 'xxx_2'
, -100
, -100
, -100
, 'xxx_2'
, 'xxx_2'
, NEWID ( )
, -100
, 0
, 'xxx_2'
, -100
, 'xxx_2'
, -100
, NEWID ( )
, 0
, 'xxx_2'
, -100
, 'xxx_2'
, -100
, NEWID ( )
, 0
, 'xxx_2'
, -100
, -100
, 'xxx_2'
, 'xxx_2'
, -100
, 0
, NEWID ( )
, 0
, 'xxx_2'
, 0
, 'xxx_2'
, -100
, 'xxx_2'
, -100
, NEWID ( )
, 0
, 'xxx_2'
, 'xxx_2'
, -100
, 'I'
, GETDATE ( )
, GETDATE ( )
, NEWID ( )
, NEWID ( )
, -100
, -100
, -100
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, GETDATE ( )
, 0
, 'xxx_2'
, HASHBYTES ( 'sha1' , 'xxx_2' )
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, -100
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, 'I'
, NULL
, 'I'
, NULL
, NULL
, NULL );

--*****************************************************************************************
-- ADD NEW RECORDS
--*****************************************************************************************
            DECLARE
            @iNewInserts AS int = 0;
            EXEC @iNewInserts = proc_CT_HA_Definition_AddNewRecs ;
            PRINT 'new inserts: ' + CAST ( @iNewInserts AS nvarchar ( 50)) ;

--*****************************************************************************************
-- ADD UPDATED RECORDS
--*****************************************************************************************
            --select top 100 * from ##TEMP_EDW_HealthDefinition_DATA
			update ##TEMP_EDW_HealthDefinition_DATA set AnsCodeName = lower(AnsCodeName), HashCode = hashbytes('sha1', AnsCodeName)
			where AnsDocumentGuid in (Select top 1 AnsDocumentGuid  from ##TEMP_EDW_HealthDefinition_DATA order by AnsDocumentGuid) ;

            DECLARE
            @iUpdates AS int = 0;
            EXEC @iUpdates = proc_CT_HA_Definition_AddUpdatedRecs ;
            PRINT 'Updated Records: ' + CAST ( @iUpdates AS nvarchar ( 50)) ;

--*****************************************************************************************
--		  FIND ANY DELETED ROWS
--*****************************************************************************************
			delete from ##TEMP_EDW_HealthDefinition_DATA 
			where AnsDocumentGuid in (Select top 1 AnsDocumentGuid  from ##TEMP_EDW_HealthDefinition_DATA order by AnsDocumentGuid desc) ;

            DECLARE
            @iDeleted AS int = 0;
            EXEC @iDeleted = proc_CT_HA_Definition_AddDeletedRecs ;
            PRINT 'MARKED Deleted Records: ' + CAST ( @iDeleted AS nvarchar ( 50)) ;
--*****************************************************************************************

PRINT '*******************************************************************';
PRINT 'TEST COMPLETE.';
SET NOCOUNT OFF;


print '***************************************************'; 
print 'INSERTED RECS    : ' + cast(@iNewInserts as nvarchar(50)) ; 
print 'Updated  RECS    : ' + cast(@iUpdates as nvarchar(50)) ; 
print 'Deleted  RECS    : ' + cast(@iNewInserts as nvarchar(50)) ; 
print '***************************************************'; 


--SELECT
--       *
--  FROM EDW_CT_ExecutionLog
--  WHERE CT_NAME = 'proc_STAGING_EDW_HA_Definition'
--  ORDER BY
--           CT_Start DESC;
