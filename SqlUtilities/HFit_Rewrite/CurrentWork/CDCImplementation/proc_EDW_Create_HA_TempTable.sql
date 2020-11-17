
go
use KenticoCMS_DataMart

GO
PRINT 'Creating proc_EDW_Create_HA_TempTable.sql';
GO

--exec proc_EDW_UpdateDIMTables ;
--go

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_EDW_Create_HA_TempTable' )
    BEGIN
        DROP PROCEDURE
             proc_EDW_Create_HA_TempTable;
    END;
GO
--EXEC proc_EDW_Create_HA_TempTable
CREATE PROCEDURE proc_EDW_Create_HA_TempTable
AS
BEGIN

    IF NOT EXISTS ( SELECT
                           name
                      FROM sys.tables
                      WHERE name = 'TEMP_EDW_HealthAssessment_DATA' )
        BEGIN
            CREATE TABLE TEMP_EDW_HealthAssessment_DATA
            (
                         UserStartedItemID int  NULL
                         ,HealthAssesmentUserStartedNodeGUID uniqueidentifier  NULL
                         ,UserID bigint  NULL
                         ,UserGUID uniqueidentifier  NULL
                         ,HFitUserMpiNumber bigint  NULL
                         ,SiteGUID uniqueidentifier  NULL
                         ,AccountID int  NULL
                         ,AccountCD nvarchar( 8 ) NULL
                         ,AccountName nvarchar( 200 ) NULL
                         ,HAStartedDt datetime  NULL
                         ,HACompletedDt datetime  NULL
                         ,UserModuleItemId int  NULL
                         ,UserModuleCodeName nvarchar( 100 ) NULL
                         ,HAModuleNodeGUID uniqueidentifier  NULL
                         ,CMSNodeGuid uniqueidentifier  NULL
                         ,HAModuleVersionID int  NULL
                         ,UserRiskCategoryItemID int  NULL
                         ,UserRiskCategoryCodeName nvarchar( 100 ) NULL
                         ,HARiskCategoryNodeGUID uniqueidentifier  NULL
                         ,HARiskCategoryVersionID int  NULL
                         ,UserRiskAreaItemID int  NULL
                         ,UserRiskAreaCodeName nvarchar( 100 ) NULL
                         ,HARiskAreaNodeGUID uniqueidentifier  NULL
                         ,HARiskAreaVersionID int  NULL
                         ,UserQuestionItemID int  NULL
                         ,Title varchar( max ) NULL
                         ,HAQuestionGuid uniqueidentifier  NULL
                         ,UserQuestionCodeName nvarchar( 100 ) NULL
                         ,HAQuestionDocumentID int  NULL
                         ,HAQuestionVersionID int  NULL
                         ,HAQuestionNodeGUID uniqueidentifier  NULL
                         ,UserAnswerItemID int  NULL
                         ,HAAnswerNodeGUID uniqueidentifier  NULL
                         ,HAAnswerVersionID int  NULL
                         ,UserAnswerCodeName nvarchar( 100 ) NULL
                         ,HAAnswerValue nvarchar( 255 ) NULL
                         ,HAModuleScore float  NULL
                         ,HARiskCategoryScore float  NULL
                         ,HARiskAreaScore float  NULL
                         ,HAQuestionScore float  NULL
                         ,HAAnswerPoints int  NULL
                         ,PointResults int  NULL
                         ,UOMCode nvarchar( 10 ) NULL
                         ,HAScore int  NULL
                         ,ModulePreWeightedScore float  NULL
                         ,RiskCategoryPreWeightedScore float  NULL
                         ,RiskAreaPreWeightedScore float  NULL
                         ,QuestionPreWeightedScore float  NULL
                         ,QuestionGroupCodeName nvarchar( 100 ) NULL
                         ,ChangeType nchar( 1 ) NULL
                         ,ItemCreatedWhen datetime  NULL
                         ,ItemModifiedWhen datetime  NULL
                         ,IsProfessionallyCollected bit  NULL
                         ,HARiskCategory_ItemModifiedWhen datetime  NULL
                         ,HAUserRiskArea_ItemModifiedWhen datetime  NULL
                         ,HAUserQuestion_ItemModifiedWhen datetime  NULL
                         ,HAUserAnswers_ItemModifiedWhen datetime  NULL
                         ,HAPaperFlg bit  NULL
                         ,HATelephonicFlg bit  NULL
                         ,HAStartedMode int  NULL
                         ,HACompletedMode int  NULL
                         ,DocumentCulture_VHCJ nvarchar( 10 ) NULL
                         ,DocumentCulture_HAQuestionsView nvarchar( 10 ) NULL
                         ,CampaignNodeGUID uniqueidentifier  NULL
                         ,HACampaignID int  NULL
                         ,HashCode varchar( 100 ) NULL
                         ,PKHASHCODE nvarchar( 100 ) NOT  NULL
                         ,CHANGED_FLG int  NULL
                         ,CT_CMS_User_UserID int  NULL
                         ,CT_CMS_User_CHANGE_OPERATION nchar( 1 ) NULL
                         ,CT_UserSettingsID int  NULL
                         ,CT_UserSettingsID_CHANGE_OPERATION nchar( 1 ) NULL
                         ,SiteID_CtID int  NULL
                         ,SiteID_CHANGE_OPERATION nchar( 1 ) NULL
                         ,UserSiteID_CtID int  NULL
                         ,UserSiteID_CHANGE_OPERATION nchar( 1 ) NULL
                         ,AccountID_CtID int  NULL
                         ,AccountID__CHANGE_OPERATION nchar( 1 ) NULL
                         ,HAUserAnswers_CtID int  NULL
                         ,HAUserAnswers_CHANGE_OPERATION nchar( 1 ) NULL
                         ,HFit_HealthAssesmentUserModule_CtID int  NULL
                         ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION nchar( 1 ) NULL
                         ,HFit_HealthAssesmentUserQuestion_CtID int  NULL
                         ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION nchar( 1 ) NULL
                         ,HFit_HealthAssesmentUserQuestionGroupResults_CtID int  NULL
                         ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION nchar( 1 ) NULL
                         ,HFit_HealthAssesmentUserRiskArea_CtID int  NULL
                         ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION nchar( 1 ) NULL
                         ,HFit_HealthAssesmentUserRiskCategory_CtID int  NULL
                         ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION nchar( 1 ) NULL
                         ,HFit_HealthAssesmentUserStarted_CtID int  NULL
                         ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION nchar( 1 ) NULL
                         ,CT_CMS_User_SCV bigint  NULL
                         ,CT_CMS_UserSettings_SCV bigint  NULL
                         ,CT_CMS_Site_SCV bigint  NULL
                         ,CT_CMS_UserSite_SCV bigint  NULL
                         ,CT_HFit_Account_SCV bigint  NULL
                         ,CT_HFit_HealthAssesmentUserAnswers_SCV bigint  NULL
                         ,CT_HFit_HealthAssesmentUserModule_SCV bigint  NULL
                         ,CT_HFit_HealthAssesmentUserQuestion_SCV bigint  NULL
                         ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV bigint  NULL
                         ,CT_HFit_HealthAssesmentUserRiskArea_SCV bigint  NULL
                         ,CT_HFit_HealthAssesmentUserRiskCategory_SCV bigint  NULL
                         ,CT_HFit_HealthAssesmentUserStarted_SCV bigint  NULL
                         ,LastModifiedDate datetime  NULL
                         ,DeleteFlg int  NULL
            );
        END;

/******************************************************************************************************************
IF NOT EXISTS ( SELECT
                        name
                    FROM sys.indexes
                    WHERE name = 'temp_PI_EDW_HealthAssessment_IDs' )
CREATE INDEX temp_PI_EDW_HealthAssessment_IDs ON TEMP_EDW_HealthAssessment_DATA (
UserStartedItemID
, HealthAssesmentUserStartedNodeGUID
, UserGUID
, SiteGUID
, AccountCD
, HAModuleNodeGUID
, CMSNodeGuid
, HARiskCategoryNodeGUID
, UserRiskAreaItemID
, HARiskAreaNodeGUID
, UserQuestionItemID
, HAQuestionGuid
, HAQuestionNodeGUID
, UserAnswerItemID
, HAAnswerNodeGUID
, CampaignNodeGUID
)
INCLUDE ( AccountID , UserModuleItemId , UserRiskCategoryItemID , HASHCODE , LastModifiedDate )
WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
ALLOW_ROW_LOCKS = ON ,
ALLOW_PAGE_LOCKS = ON );
******************************************************************************************************************/

    IF NOT EXISTS ( SELECT
                           name
                      FROM sys.indexes
                      WHERE name = 'temp_PI_EDW_HealthAssessment_ChangeType' )
        BEGIN
            CREATE INDEX temp_PI_EDW_HealthAssessment_ChangeType ON TEMP_EDW_HealthAssessment_DATA ( ChangeType )
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
            ALLOW_ROW_LOCKS = ON ,
            ALLOW_PAGE_LOCKS = ON )
        END;

    IF NOT EXISTS ( SELECT
                           name
                      FROM sys.indexes
                      WHERE name = 'temp_PI_EDW_HealthAssessment_NATKEY' )
        BEGIN
            CREATE INDEX temp_PI_EDW_HealthAssessment_NATKEY ON TEMP_EDW_HealthAssessment_DATA (
            UserStartedItemID
            , UserGUID
            , PKHashCode
            , HASHCODE
            )
        END;

END;

GO
PRINT 'Created proc_EDW_Create_HA_TempTable';
GO
