


GO
PRINT 'BUILDING proc_Load_HA_CT_TempTable.sql';
go
/*
if exists (select table_name from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'FACT_MART_EDW_HealthAssesment')
    drop table FACT_MART_EDW_HealthAssesment ;

CREATE TABLE [dbo].[FACT_MART_EDW_HealthAssesment](
	[UserStartedItemID] [int] NOT NULL,
	[HealthAssesmentUserStartedNodeGUID] [uniqueidentifier] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[HFitUserMpiNumber] [bigint] NULL,
	[SiteGUID] [uniqueidentifier] NOT NULL,
	[AccountID] [int] NOT NULL,
	[AccountCD] [nvarchar](20) NULL,
	[AccountName] [nvarchar](200) NULL,
	[HAStartedDt] [datetime2](7) NOT NULL,
	[HACompletedDt] [datetime2](7) NULL,
	[UserModuleItemId] [int] NOT NULL,
	[UserModuleCodeName] [nvarchar](100) NOT NULL,
	[HAModuleNodeGUID] [uniqueidentifier] NOT NULL,
	[CMSNodeGuid] [uniqueidentifier] NOT NULL,
	[HAModuleVersionID] [int] NULL,
	[UserRiskCategoryItemID] [int] NOT NULL,
	[UserRiskCategoryCodeName] [nvarchar](100) NOT NULL,
	[HARiskCategoryNodeGUID] [uniqueidentifier] NOT NULL,
	[HARiskCategoryVersionID] [int] NULL,
	[UserRiskAreaItemID] [int] NOT NULL,
	[UserRiskAreaCodeName] [nvarchar](100) NOT NULL,
	[HARiskAreaNodeGUID] [uniqueidentifier] NOT NULL,
	[HARiskAreaVersionID] [int] NULL,
	[UserQuestionItemID] [int] NOT NULL,
	[Title] [varchar](max) NULL,
	[HAQuestionGuid] [uniqueidentifier] NOT NULL,
	[UserQuestionCodeName] [nvarchar](100) NOT NULL,
	[HAQuestionDocumentID] [int] NULL,
	[HAQuestionVersionID] [int] NULL,
	[HAQuestionNodeGUID] [uniqueidentifier] NOT NULL,
	[UserAnswerItemID] [int] NOT NULL,
	[HAAnswerNodeGUID] [uniqueidentifier] NOT NULL,
	[HAAnswerVersionID] [int] NULL,
	[UserAnswerCodeName] [nvarchar](100) NOT NULL,
	[HAAnswerValue] [nvarchar](255) NULL,
	[HAModuleScore] [float] NOT NULL,
	[HARiskCategoryScore] [float] NULL,
	[HARiskAreaScore] [float] NULL,
	[HAQuestionScore] [float] NULL,
	[HAAnswerPoints] [int] NULL,
	[PointResults] [int] NULL,
	[UOMCode] [nvarchar](10) NULL,
	[HAScore] [int] NULL,
	[ModulePreWeightedScore] [float] NULL,
	[RiskCategoryPreWeightedScore] [float] NULL,
	[RiskAreaPreWeightedScore] [float] NULL,
	[QuestionPreWeightedScore] [float] NULL,
	[QuestionGroupCodeName] [nvarchar](100) NULL,
	[ChangeType] [nchar](1) NULL,
	[ItemCreatedWhen] [datetime2](7) NULL,
	[ItemModifiedWhen] [datetime2](7) NULL,
	[IsProfessionallyCollected] [bit] NOT NULL,
	[HARiskCategory_ItemModifiedWhen] [datetime2](7) NULL,
	[HAUserRiskArea_ItemModifiedWhen] [datetime2](7) NULL,
	[HAUserQuestion_ItemModifiedWhen] [datetime2](7) NULL,
	[HAUserAnswers_ItemModifiedWhen] [datetime2](7) NULL,
	[HAPaperFlg] [bit] NOT NULL,
	[HATelephonicFlg] [bit] NOT NULL,
	[HAStartedMode] [int] NOT NULL,
	[HACompletedMode] [int] NOT NULL,
	[DocumentCulture_VHCJ] [nvarchar](10) NOT NULL,
	[DocumentCulture_HAQuestionsView] [nvarchar](10) NOT NULL,
	[CampaignNodeGUID] [uniqueidentifier] NOT NULL,
	[HACampaignID] [int] NOT NULL,
	[HashCode] [varchar](100) NULL,
	[PKHashCode] [varchar](100) NULL,
	[CHANGED_FLG] [int] NULL,
	[CT_CMS_User_UserID] [int] NULL,
	[CT_CMS_User_CHANGE_OPERATION] [nchar](1) NULL,
	[CT_UserSettingsID] [int] NULL,
	[CT_UserSettingsID_CHANGE_OPERATION] [nchar](1) NULL,
	[SiteID_CtID] [int] NULL,
	[SiteID_CHANGE_OPERATION] [nchar](1) NULL,
	[UserSiteID_CtID] [int] NULL,
	[UserSiteID_CHANGE_OPERATION] [nchar](1) NULL,
	[AccountID_CtID] [int] NULL,
	[AccountID__CHANGE_OPERATION] [nchar](1) NULL,
	[HAUserAnswers_CtID] [int] NULL,
	[HAUserAnswers_CHANGE_OPERATION] [nchar](1) NULL,
	[HFit_HealthAssesmentUserModule_CtID] [int] NULL,
	[HFit_HealthAssesmentUserModule_CHANGE_OPERATION] [nchar](1) NULL,
	[HFit_HealthAssesmentUserQuestion_CtID] [int] NULL,
	[HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION] [nchar](1) NULL,
	[HFit_HealthAssesmentUserQuestionGroupResults_CtID] [int] NULL,
	[HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION] [nchar](1) NULL,
	[HFit_HealthAssesmentUserRiskArea_CtID] [int] NULL,
	[HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION] [nchar](1) NULL,
	[HFit_HealthAssesmentUserRiskCategory_CtID] [int] NULL,
	[HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION] [nchar](1) NULL,
	[HFit_HealthAssesmentUserStarted_CtID] [int] NULL,
	[HFit_HealthAssesmentUserStarted_CHANGE_OPERATION] [nchar](1) NULL,
	[CT_CMS_User_SCV] [bigint] NULL,
	[CT_CMS_UserSettings_SCV] [bigint] NULL,
	[CT_CMS_Site_SCV] [bigint] NULL,
	[CT_CMS_UserSite_SCV] [bigint] NULL,
	[CT_HFit_Account_SCV] [bigint] NULL,
	[CT_HFit_HealthAssesmentUserAnswers_SCV] [bigint] NULL,
	[CT_HFit_HealthAssesmentUserModule_SCV] [bigint] NULL,
	[CT_HFit_HealthAssesmentUserQuestion_SCV] [bigint] NULL,
	[CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV] [bigint] NULL,
	[CT_HFit_HealthAssesmentUserRiskArea_SCV] [bigint] NULL,
	[CT_HFit_HealthAssesmentUserRiskCategory_SCV] [bigint] NULL,
	[CT_HFit_HealthAssesmentUserStarted_SCV] [bigint] NULL,
	[LastModifiedDate] [datetime2](7) NULL,	
     [DeletedFlg] [int] NOT NULL,
	[HealthAssessmentType] [varchar](9) NOT NULL,
	[SVR] [nvarchar](128) NULL,
	[DBNAME] [nvarchar](128) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
*/
GO


IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_Load_HA_CT_TempTable' )

    BEGIN

        PRINT 'REPLACING proc_Load_HA_CT_TempTable.sql';

        DROP PROCEDURE
             proc_Load_HA_CT_TempTable;
    END;

GO

/********************************
exec proc_Load_HA_CT_TempTable 0;
exec proc_Load_HA_CT_TempTable 1;
exec proc_Load_HA_CT_TempTable 2;
********************************/

CREATE PROCEDURE proc_Load_HA_CT_TempTable ( @ProcessControl AS int
                                           , @StartChangeID AS bigint = 0
                                           , @EndChangeID AS bigint = 9999999999 )
AS
BEGIN
    PRINT 'proc_Load_HA_CT_TempTable starting @';
    PRINT GETDATE ( );

/************************************************************************************************************************************
Author:	  W. Dale Miller
Created:	  06.01.2015
USE:		  proc_Load_HA_CT_TempTable @ProcessControl;
		  The parameter @ProcessControl - id 0 no deleted records found and only changes will be loaded.
							- id 1 DELETES FOUND process all changes and deletes. This generates 
								    a FULL load of all HA REcords into the TEMP TABLE.
							- id 2 Ignore changes and RELOAD ALL HA DATA INTO the STAGING table.
							- id 3 Process only changes between a start and a stop DB CHANGE ID.

		  @StartChangeID - Loads only changes between @StartChangeID from Change Control thru the Current CT ID (@EndChangeID). 
						  Reduces the size of the loads.

		  @EndChangeID - The current END id for change tracking. 
************************************************************************************************************************************/

    SET NOCOUNT ON;

    IF
           @ProcessControl != 0
       AND @ProcessControl != 1
       AND @ProcessControl != 2
       AND @ProcessControl != 3

        BEGIN

            PRINT 'FATAL ERROR: the variable @ProcessControl must be supplied. RETURNING.';

            RETURN -1;
        END;

    --DECLARE @ProcessControl AS int = 0, @iRows as int = 0 ;

    DECLARE
       @starttime AS datetime2 = GETDATE ( ) ,
       @iRows AS bigint = 0;

    --*******************************************************************************
    --** BUILD THE TEMP TABLES THAT DENORMAILZE NESTED VIEWS.
    EXEC proc_Denormalize_EDW_Views ;
    --*******************************************************************************

    DECLARE
       @startPullDate datetime2 = GETDATE ( );

    --** CHECK FOR AND CREATE THE TEMP TABLE IF NEEDED.

    EXEC proc_EDW_Create_HA_TempTable ;

    IF @ProcessControl = 0

        BEGIN
            PRINT 'Only changes (no deletes found) are being processed.';
            truncate TABLE TEMP_EDW_HealthAssessment_DATA;

            --truncate table ##TEMP_EDW_HealthAssessment_DATA
            INSERT INTO TEMP_EDW_HealthAssessment_DATA
            (
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,LastModifiedDate
                   ,DeleteFlg
            )
            SELECT
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,LastModifiedDate
                   ,DeleteFlg
              FROM view_EDW_HealthAssesment_CT
              WHERE ChangeType IS NOT NULL;

            SET @iRows = @@ROWCOUNT;
        END;

/*****************************************************************************************
******************************************************************************************
*****************************************************************************************/

    IF @ProcessControl = 1

        BEGIN
            PRINT 'deletes found, all records being loaded for processing into the TEMP table.';
            truncate TABLE TEMP_EDW_HealthAssessment_DATA;

            INSERT INTO TEMP_EDW_HealthAssessment_DATA
            (
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,LastModifiedDate
                   ,DeleteFlg
            )
            SELECT
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,NULL AS LastModifiedDate
                   ,NULL AS DeleteFlg
              FROM view_EDW_HealthAssesment_CT;

            SET @iRows = @@ROWCOUNT;
        END;

    --select count(*) from FACT_MART_EDW_HealthAssesment

    IF @ProcessControl = 2

        BEGIN
            PRINT 'RELOAD all selected, all rows being reloaded into staging table.';
            truncate TABLE FACT_MART_EDW_HealthAssesment;

            INSERT INTO FACT_MART_EDW_HealthAssesment
            (
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,LastModifiedDate
                   ,DeletedFlg
            )
            SELECT
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,NULL AS LastModifiedDate
                   ,NULL AS DeletedFlg
              FROM view_EDW_HealthAssesment_CT;

            SET @iRows = @@ROWCOUNT;
        END;

    IF @ProcessControl = 3
        BEGIN
            PRINT 'Loading only changes between ' + CAST( @StartChangeID AS nvarchar( 50 )) + ' & ' + CAST( @EndChangeID AS nvarchar( 50 )) + ' version IDs.';
            truncate TABLE TEMP_EDW_HealthAssessment_DATA;
            INSERT INTO TEMP_EDW_HealthAssessment_DATA
            (
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,LastModifiedDate
                   ,DeleteFlg
            )
            SELECT
                   UserStartedItemID
                   ,HealthAssesmentUserStartedNodeGUID
                   ,UserID
                   ,UserGUID
                   ,HFitUserMpiNumber
                   ,SiteGUID
                   ,AccountID
                   ,AccountCD
                   ,AccountName
                   ,HAStartedDt
                   ,HACompletedDt
                   ,UserModuleItemId
                   ,UserModuleCodeName
                   ,HAModuleNodeGUID
                   ,CMSNodeGuid
                   ,HAModuleVersionID
                   ,UserRiskCategoryItemID
                   ,UserRiskCategoryCodeName
                   ,HARiskCategoryNodeGUID
                   ,HARiskCategoryVersionID
                   ,UserRiskAreaItemID
                   ,UserRiskAreaCodeName
                   ,HARiskAreaNodeGUID
                   ,HARiskAreaVersionID
                   ,UserQuestionItemID
                   ,Title
                   ,HAQuestionGuid
                   ,UserQuestionCodeName
                   ,HAQuestionDocumentID
                   ,HAQuestionVersionID
                   ,HAQuestionNodeGUID
                   ,UserAnswerItemID
                   ,HAAnswerNodeGUID
                   ,HAAnswerVersionID
                   ,UserAnswerCodeName
                   ,HAAnswerValue
                   ,HAModuleScore
                   ,HARiskCategoryScore
                   ,HARiskAreaScore
                   ,HAQuestionScore
                   ,HAAnswerPoints
                   ,PointResults
                   ,UOMCode
                   ,HAScore
                   ,ModulePreWeightedScore
                   ,RiskCategoryPreWeightedScore
                   ,RiskAreaPreWeightedScore
                   ,QuestionPreWeightedScore
                   ,QuestionGroupCodeName
                   ,ChangeType
                   ,ItemCreatedWhen
                   ,ItemModifiedWhen
                   ,IsProfessionallyCollected
                   ,HARiskCategory_ItemModifiedWhen
                   ,HAUserRiskArea_ItemModifiedWhen
                   ,HAUserQuestion_ItemModifiedWhen
                   ,HAUserAnswers_ItemModifiedWhen
                   ,HAPaperFlg
                   ,HATelephonicFlg
                   ,HAStartedMode
                   ,HACompletedMode
                   ,DocumentCulture_VHCJ
                   ,DocumentCulture_HAQuestionsView
                   ,CampaignNodeGUID
                   ,HACampaignID
                   ,HashCode
                   ,PKHashCode
                   ,CHANGED_FLG
                   ,CT_CMS_User_UserID
                   ,CT_CMS_User_CHANGE_OPERATION
                   ,CT_UserSettingsID
                   ,CT_UserSettingsID_CHANGE_OPERATION
                   ,SiteID_CtID
                   ,SiteID_CHANGE_OPERATION
                   ,UserSiteID_CtID
                   ,UserSiteID_CHANGE_OPERATION
                   ,AccountID_CtID
                   ,AccountID__CHANGE_OPERATION
                   ,HAUserAnswers_CtID
                   ,HAUserAnswers_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserModule_CtID
                   ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestion_CtID
                   ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CtID
                   ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskArea_CtID
                   ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserRiskCategory_CtID
                   ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
                   ,HFit_HealthAssesmentUserStarted_CtID
                   ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
                   ,CT_CMS_User_SCV
                   ,CT_CMS_UserSettings_SCV
                   ,CT_CMS_Site_SCV
                   ,CT_CMS_UserSite_SCV
                   ,CT_HFit_Account_SCV
                   ,CT_HFit_HealthAssesmentUserAnswers_SCV
                   ,CT_HFit_HealthAssesmentUserModule_SCV
                   ,CT_HFit_HealthAssesmentUserQuestion_SCV
                   ,CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
                   ,CT_HFit_HealthAssesmentUserRiskArea_SCV
                   ,CT_HFit_HealthAssesmentUserRiskCategory_SCV
                   ,CT_HFit_HealthAssesmentUserStarted_SCV
                   ,NULL AS LastModifiedDate
                   ,NULL AS DeleteFlg
              FROM view_EDW_HealthAssesment_CT
              WHERE
                   CT_CMS_User_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_CMS_UserSettings_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_CMS_Site_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_CMS_UserSite_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_Account_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_HealthAssesmentUserAnswers_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_HealthAssesmentUserModule_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_HealthAssesmentUserQuestion_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_HealthAssesmentUserRiskArea_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_HealthAssesmentUserRiskCategory_SCV  BETWEEN @StartChangeID  AND  @EndChangeID
                OR CT_HFit_HealthAssesmentUserStarted_SCV  BETWEEN @StartChangeID  AND  @EndChangeID;

            SET @iRows = @@ROWCOUNT;
        END;

/*****************************************************************************************
******************************************************************************************
*****************************************************************************************/

    DECLARE
   @endtime AS datetime2 = GETDATE ( );

    PRINT 'TEMP RECORDS RETURNED:' + CAST ( @iRows AS nvarchar( 50 ));

    PRINT 'ENDTIME: ';

    PRINT GETDATE ( );

    DECLARE
       @secs AS decimal ( 10 , 3 ) = DATEDIFF ( second , @starttime , @endtime );

    DECLARE
       @mins AS decimal ( 10 , 3 ) = @secs / 60;

    DECLARE
       @hrs AS decimal ( 10 , 3 ) = @secs / 60 / 60;

    PRINT '**********';

    PRINT '@secs = ' + CAST ( @secs AS nvarchar( 50 ));

    PRINT '@mins = ' + CAST ( @mins AS nvarchar( 50 ));

    PRINT '@@hrs = ' + CAST ( @hrs AS nvarchar( 50 ));

    RETURN @iRows;
END;

GO

PRINT 'Finished BUILDING proc_Load_HA_CT_TempTable.sql';

GO

