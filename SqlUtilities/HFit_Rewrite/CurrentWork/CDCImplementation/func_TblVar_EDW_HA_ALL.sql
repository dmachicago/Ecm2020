-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION TglVar_EDW_HA_ALL()
RETURNS @HARECS TABLE
   (
                    UserStartedItemID int  NOT NULL
                    ,HealthAssesmentUserStartedNodeGUID uniqueidentifier  NOT NULL
                    ,UserID bigint  NOT NULL
                    ,UserGUID uniqueidentifier  NOT NULL
                    ,HFitUserMpiNumber bigint  NULL
                    ,SiteGUID uniqueidentifier  NOT NULL
                    ,AccountID int  NOT NULL
                    ,AccountCD nvarchar   NULL
                    ,AccountName nvarchar  NULL
                    ,HAStartedDt datetime  NOT NULL
                    ,HACompletedDt datetime  NULL
                    ,UserModuleItemId int  NOT NULL
                    ,UserModuleCodeName nvarchar  NOT NULL
                    ,HAModuleNodeGUID uniqueidentifier  NOT NULL
                    ,CMSNodeGuid uniqueidentifier  NOT NULL
                    ,HAModuleVersionID int  NULL
                    ,UserRiskCategoryItemID int  NOT NULL
                    ,UserRiskCategoryCodeName nvarchar  NOT NULL
                    ,HARiskCategoryNodeGUID uniqueidentifier  NOT NULL
                    ,HARiskCategoryVersionID int  NULL
                    ,UserRiskAreaItemID int  NOT NULL
                    ,UserRiskAreaCodeName nvarchar  NOT NULL
                    ,HARiskAreaNodeGUID uniqueidentifier  NOT NULL
                    ,HARiskAreaVersionID int  NULL
                    ,UserQuestionItemID int  NOT NULL
                    ,Title varchar ( max ) NULL
                    ,HAQuestionGuid uniqueidentifier  NOT NULL
                    ,UserQuestionCodeName nvarchar  NOT NULL
                    ,HAQuestionDocumentID int  NULL
                    ,HAQuestionVersionID int  NULL
                    ,HAQuestionNodeGUID uniqueidentifier  NOT NULL
                    ,UserAnswerItemID int  NOT NULL
                    ,HAAnswerNodeGUID uniqueidentifier  NOT NULL
                    ,HAAnswerVersionID int  NULL
                    ,UserAnswerCodeName nvarchar   NOT NULL
                    ,HAAnswerValue nvarchar  NULL
                    ,HAModuleScore float  NOT NULL
                    ,HARiskCategoryScore float  NULL
                    ,HARiskAreaScore float  NULL
                    ,HAQuestionScore float  NULL
                    ,HAAnswerPoints int  NULL
                    ,PointResults int  NULL
                    ,UOMCode nvarchar   NULL
                    ,HAScore int  NULL
                    ,ModulePreWeightedScore float  NULL
                    ,RiskCategoryPreWeightedScore float  NULL
                    ,RiskAreaPreWeightedScore float  NULL
                    ,QuestionPreWeightedScore float  NULL
                    ,QuestionGroupCodeName nvarchar  NULL
                    ,ChangeType nchar  NULL
                    ,ItemCreatedWhen datetime  NULL
                    ,ItemModifiedWhen datetime  NULL
                    ,IsProfessionallyCollected bit  NOT NULL
                    ,HARiskCategory_ItemModifiedWhen datetime  NULL
                    ,HAUserRiskArea_ItemModifiedWhen datetime  NULL
                    ,HAUserQuestion_ItemModifiedWhen datetime  NULL
                    ,HAUserAnswers_ItemModifiedWhen datetime  NULL
                    ,HAPaperFlg bit  NOT NULL
                    ,HATelephonicFlg bit  NOT NULL
                    ,HAStartedMode int  NOT NULL
                    ,HACompletedMode int  NOT NULL
                    ,DocumentCulture_VHCJ nvarchar  NOT NULL
                    ,DocumentCulture_HAQuestionsView nvarchar  NOT NULL
                    ,CampaignNodeGUID uniqueidentifier  NOT NULL
                    ,HACampaignID int  NOT NULL
                    ,HashCode varchar  NULL
                    ,PKHashCode varchar  NOT  NULL
                    ,CHANGED_FLG int  NULL
                    ,CT_CMS_User_UserID int  NULL
                    ,CT_CMS_User_CHANGE_OPERATION nchar  NULL
                    ,CT_UserSettingsID int  NULL
                    ,CT_UserSettingsID_CHANGE_OPERATION nchar NULL
                    ,SiteID_CtID int  NULL
                    ,SiteID_CHANGE_OPERATION nchar  NULL
                    ,UserSiteID_CtID int  NULL
                    ,UserSiteID_CHANGE_OPERATION nchar   NULL
                    ,AccountID_CtID int  NULL
                    ,AccountID__CHANGE_OPERATION nchar   NULL
                    ,HAUserAnswers_CtID int  NULL
                    ,HAUserAnswers_CHANGE_OPERATION nchar   NULL
                    ,HFit_HealthAssesmentUserModule_CtID int  NULL
                    ,HFit_HealthAssesmentUserModule_CHANGE_OPERATION nchar NULL
                    ,HFit_HealthAssesmentUserQuestion_CtID int  NULL
                    ,HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION nchar NULL
                    ,HFit_HealthAssesmentUserQuestionGroupResults_CtID int  NULL
                    ,HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION nchar   NULL
                    ,HFit_HealthAssesmentUserRiskArea_CtID int  NULL
                    ,HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION nchar   NULL
                    ,HFit_HealthAssesmentUserRiskCategory_CtID int  NULL
                    ,HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION nchar  NULL
                    ,HFit_HealthAssesmentUserStarted_CtID int  NULL
                    ,HFit_HealthAssesmentUserStarted_CHANGE_OPERATION nchar  NULL
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
                    ,DeleteFlg int  NOT NULL
				,RowNbr int not null
                   --PRIMARY KEY ( UserStartedItemID , UserGUID , PKHashCode, RowNbr 
)
AS
begin

INSERT INTO @HARECS
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
	   ,RowNbr
)
SELECT
       HAUserStarted.ItemID AS UserStartedItemID
       ,VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
       ,HAUserStarted.UserID
       ,CMSUser.UserGUID
       ,UserSettings.HFitUserMpiNumber
       ,CMSSite.SiteGUID
       ,ACCT.AccountID
       ,ACCT.AccountCD
       ,ACCT.AccountName
       ,HAUserStarted.HAStartedDt
       ,HAUserStarted.HACompletedDt
       ,HAUserModule.ItemID AS UserModuleItemId
       ,HAUserModule.CodeName AS UserModuleCodeName
       ,HAUserModule.HAModuleNodeGUID
       ,VHAJ.NodeGUID AS CMSNodeGuid
       ,NULL AS HAModuleVersionID
       ,HARiskCategory.ItemID AS UserRiskCategoryItemID
       ,HARiskCategory.CodeName AS UserRiskCategoryCodeName
       ,HARiskCategory.HARiskCategoryNodeGUID
       ,NULL AS HARiskCategoryVersionID
       ,HAUserRiskArea.ItemID AS UserRiskAreaItemID
       ,HAUserRiskArea.CodeName AS UserRiskAreaCodeName
       ,HAUserRiskArea.HARiskAreaNodeGUID
       ,NULL AS HARiskAreaVersionID
       ,HAUserQuestion.ItemID AS UserQuestionItemID
       ,dbo.udf_StripHTML ( HAQuestionsView.Title ) AS Title
       ,HAUserQuestion.HAQuestionNodeGUID AS HAQuestionGuid
       ,HAUserQuestion.CodeName AS UserQuestionCodeName
       ,NULL AS HAQuestionDocumentID
       ,NULL AS HAQuestionVersionID
       ,HAUserQuestion.HAQuestionNodeGUID
       ,HAUserAnswers.ItemID AS UserAnswerItemID
       ,HAUserAnswers.HAAnswerNodeGUID
       ,NULL AS HAAnswerVersionID
       ,HAUserAnswers.CodeName AS UserAnswerCodeName
       ,HAUserAnswers.HAAnswerValue
       ,HAUserModule.HAModuleScore
       ,HARiskCategory.HARiskCategoryScore
       ,HAUserRiskArea.HARiskAreaScore
       ,HAUserQuestion.HAQuestionScore
       ,HAUserAnswers.HAAnswerPoints
       ,HAUserQuestionGroupResults.PointResults
       ,HAUserAnswers.UOMCode
       ,HAUserStarted.HAScore
       ,HAUserModule.PreWeightedScore AS ModulePreWeightedScore
       ,HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
       ,HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
       ,HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
       ,HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName
       ,COALESCE ( CT_CMS_User.SYS_CHANGE_OPERATION , CT_CMS_UserSettings.SYS_CHANGE_OPERATION , CT_CMS_Site.SYS_CHANGE_OPERATION , CT_CMS_UserSite.SYS_CHANGE_OPERATION , CT_HFit_Account.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION ,
       CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION ,
       CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION ,
       CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_OPERATION , CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION ) AS ChangeType
       ,HAUserAnswers.ItemCreatedWhen
       ,HAUserAnswers.ItemModifiedWhen
       ,HAUserQuestion.IsProfessionallyCollected
       ,HARiskCategory.ItemModifiedWhen AS HARiskCategory_ItemModifiedWhen
       ,HAUserRiskArea.ItemModifiedWhen AS HAUserRiskArea_ItemModifiedWhen
       ,HAUserQuestion.ItemModifiedWhen AS HAUserQuestion_ItemModifiedWhen
       ,HAUserAnswers.ItemModifiedWhen AS HAUserAnswers_ItemModifiedWhen
       ,HAUserStarted.HAPaperFlg
       ,HAUserStarted.HATelephonicFlg
       ,HAUserStarted.HAStartedMode
       ,HAUserStarted.HACompletedMode
       ,VHCJ.DocumentCulture AS DocumentCulture_VHCJ
       ,HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
       ,HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
       ,VHCJ.HACampaignID
       ,CAST( HASHBYTES ( 'sha1' ,
       ISNULL ( CAST ( HAUserStarted.ItemID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( VHAJ.NodeGUID  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserStarted.UserID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( CMSUser.UserGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( UserSettings.HFitUserMpiNumber AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( CMSSite.SiteGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( ACCT.AccountID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( ACCT.AccountCD AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( ACCT.AccountName AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserStarted.HAStartedDt AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserStarted.HACompletedDt AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserModule.ItemID  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserModule.CodeName  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserModule.HAModuleNodeGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( VHAJ.NodeGUID  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.ItemID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.CodeName AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.HARiskCategoryNodeGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserRiskArea.ItemID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserRiskArea.CodeName AS nvarchar( 100 )) ,
       '-' ) + ISNULL ( CAST ( HAUserRiskArea.HARiskAreaNodeGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.ItemID AS nvarchar( 100 )) , '-' ) + ISNULL ( LEFT ( HAQuestionsView.Title , 1000 ) , '-' ) + ISNULL ( CAST ( HAUserQuestion.HAQuestionNodeGUID  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserQuestion.CodeName  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.HAQuestionNodeGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserAnswers.ItemID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserAnswers.HAAnswerNodeGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserAnswers.CodeName AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserAnswers.HAAnswerValue AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserModule.HAModuleScore AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.HARiskCategoryScore AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserRiskArea.HARiskAreaScore AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.HAQuestionScore AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserAnswers.HAAnswerPoints AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserQuestionGroupResults.PointResults AS nvarchar( 100 )) , '-' ) + ISNULL (
       CAST ( HAUserAnswers.UOMCode AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserStarted.HAScore AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserModule.PreWeightedScore AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.PreWeightedScore  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserRiskArea.PreWeightedScore  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.PreWeightedScore  AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST
       ( HAUserQuestionGroupResults.CodeName AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserAnswers.ItemCreatedWhen AS nvarchar( 100 )) , '-' ) + ISNULL (
       CAST ( HAUserAnswers.ItemModifiedWhen AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.IsProfessionallyCollected AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.ItemModifiedWhen AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserRiskArea.ItemModifiedWhen AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.ItemModifiedWhen AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserAnswers.ItemModifiedWhen AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserStarted.HAPaperFlg AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserStarted.HATelephonicFlg AS nvarchar( 100 )) , '-' ) + ISNULL (
       CAST ( HAUserStarted.HAStartedMode AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( HAUserStarted.HACompletedMode AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST
       ( HAUserStarted.HACampaignNodeGUID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST ( VHCJ.HACampaignID AS nvarchar( 100 )) , '-' ) + ISNULL ( CAST (
       HAUserAnswers.ItemModifiedWhen AS nvarchar( 100 )) , '-' )) AS varchar( 100 )) AS HashCode
       ,CAST( HASHBYTES ( 'sha1' ,
       ISNULL ( CAST ( HAUserStarted.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( VHAJ.NodeGUID  AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( UserGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( SiteGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( ACCT.AccountID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( AccountCD AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserModule.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAModuleNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( VHAJ.NodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HARiskCategory.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HARiskCategoryNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserRiskArea.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HARiskAreaNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserQuestion.HAQuestionNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAQuestionNodeGUID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserAnswers.ItemID AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAAnswerNodeGUID   AS varchar( 50 )) , '-' ) + ISNULL ( CAST ( HAUserStarted.HACampaignNodeGUID AS varchar( 50 )) , '-' )) AS varchar( 100 )) AS PKHashCode
       ,COALESCE ( CT_CMS_User.UserID , CT_CMS_UserSettings.UserSettingsID , CT_CMS_Site.SiteID , CT_CMS_UserSite.UserSiteID , CT_HFit_Account.AccountID ,
       CT_HFit_HealthAssesmentUserAnswers.ItemID , CT_HFit_HealthAssesmentUserModule.ItemID , CT_HFit_HealthAssesmentUserQuestion.ItemID ,
       CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID , CT_HFit_HealthAssesmentUserRiskArea.ItemID , CT_HFit_HealthAssesmentUserRiskCategory.ItemID ,
       CT_HFit_HealthAssesmentUserStarted.ItemID ) AS CHANGED_FLG
       ,CT_CMS_User.UserID AS CT_CMS_User_UserID
       ,CT_CMS_User.SYS_CHANGE_OPERATION AS CT_CMS_User_CHANGE_OPERATION
       ,CT_CMS_UserSettings.UserSettingsID AS CT_UserSettingsID
       ,CT_CMS_UserSettings.SYS_CHANGE_OPERATION AS CT_UserSettingsID_CHANGE_OPERATION
       ,CT_CMS_Site.SiteID AS SiteID_CtID
       ,CT_CMS_Site.SYS_CHANGE_OPERATION AS SiteID_CHANGE_OPERATION
       ,CT_CMS_UserSite.UserSiteID AS UserSiteID_CtID
       ,CT_CMS_UserSite.SYS_CHANGE_OPERATION AS UserSiteID_CHANGE_OPERATION
       ,CT_HFit_Account.AccountID AS AccountID_CtID
       ,CT_HFit_Account.SYS_CHANGE_OPERATION AS AccountID__CHANGE_OPERATION
       ,CT_HFit_HealthAssesmentUserAnswers.ItemID AS HAUserAnswers_CtID
       ,CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION AS HAUserAnswers_CHANGE_OPERATION
       ,CT_HFit_HealthAssesmentUserModule.ItemID AS HFit_HealthAssesmentUserModule_CtID
       ,CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserModule_CHANGE_OPERATION
       ,CT_HFit_HealthAssesmentUserQuestion.ItemID AS HFit_HealthAssesmentUserQuestion_CtID
       ,CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
       ,CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID AS HFit_HealthAssesmentUserQuestionGroupResults_CtID
       ,CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
       ,CT_HFit_HealthAssesmentUserRiskArea.ItemID AS HFit_HealthAssesmentUserRiskArea_CtID
       ,CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
       ,CT_HFit_HealthAssesmentUserRiskCategory.ItemID AS HFit_HealthAssesmentUserRiskCategory_CtID
       ,CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
       ,CT_HFit_HealthAssesmentUserStarted.ItemID AS HFit_HealthAssesmentUserStarted_CtID
       ,CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentUserStarted_CHANGE_OPERATION
       ,CT_CMS_User.SYS_CHANGE_VERSION AS CT_CMS_User_SCV
       ,CT_CMS_UserSettings.SYS_CHANGE_VERSION AS CT_CMS_UserSettings_SCV
       ,CT_CMS_Site.SYS_CHANGE_VERSION AS CT_CMS_Site_SCV
       ,CT_CMS_UserSite.SYS_CHANGE_VERSION AS CT_CMS_UserSite_SCV
       ,CT_HFit_Account.SYS_CHANGE_VERSION AS CT_HFit_Account_SCV
       ,CT_HFit_HealthAssesmentUserAnswers.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserAnswers_SCV
       ,CT_HFit_HealthAssesmentUserModule.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserModule_SCV
       ,CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestion_SCV
       ,CT_HFit_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
       ,CT_HFit_HealthAssesmentUserRiskArea.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskArea_SCV
       ,CT_HFit_HealthAssesmentUserRiskCategory.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserRiskCategory_SCV
       ,CT_HFit_HealthAssesmentUserStarted.SYS_CHANGE_VERSION AS CT_HFit_HealthAssesmentUserStarted_SCV
       ,HAUserAnswers.ItemModifiedWhen AS LastModifiedDate
       ,0 AS DeleteFlg
	   ,ROW_NUMBER() over (order by UserGUID ) RowNbr
  FROM
       dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted WITH ( NOLOCK ) INNER JOIN dbo.CMS_User AS CMSUser WITH ( NOLOCK )
       ON HAUserStarted.UserID = CMSUser.UserID
                                                                            INNER JOIN dbo.CMS_UserSettings AS UserSettings WITH ( NOLOCK )
       ON
       UserSettings.UserSettingsUserID = CMSUser.UserID
   AND HFitUserMpiNumber >= 0
   AND HFitUserMpiNumber IS NOT NULL
                                                                            INNER JOIN dbo.CMS_UserSite AS UserSite WITH ( NOLOCK )
       ON CMSUser.UserID = UserSite.UserID
                                                                            INNER JOIN dbo.CMS_Site AS CMSSite WITH ( NOLOCK )
       ON UserSite.SiteID = CMSSite.SiteID
                                                                            INNER JOIN dbo.HFit_Account AS ACCT WITH ( NOLOCK )
       ON ACCT.SiteID = CMSSite.SiteID
                                                                            INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule WITH ( NOLOCK )
       ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
                                                                            INNER JOIN #TEMP_View_HFit_HACampaign_Joined AS VHCJ
       ON
       VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID
   AND VHCJ.NodeSiteID = UserSite.SiteID
   AND VHCJ.DocumentCulture = 'en-US'
                                                                            INNER JOIN #TEMP_View_HFit_HealthAssessment_Joined AS VHAJ
       ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
                                                                            INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory WITH ( NOLOCK )
       ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
                                                                            INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea WITH ( NOLOCK )
       ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
                                                                            INNER JOIN #TEMP_HFit_HealthAssesmentUserQuestion AS HAUserQuestion WITH ( NOLOCK )
       ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
                                                                            INNER JOIN dbo.#TEMP_View_EDW_HealthAssesmentQuestions AS HAQuestionsView
       ON
       HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
   AND HAQuestionsView.DocumentCulture = 'en-US'
                                                                            LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults WITH ( NOLOCK )
       ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
                                                                            INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers WITH ( NOLOCK )
       ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID
                                                                            LEFT JOIN CHANGETABLE( CHANGES CMS_UserSettings , NULL )AS CT_CMS_UserSettings
       ON UserSettings.UserSettingsID = CT_CMS_UserSettings.UserSettingsID
                                                                            LEFT JOIN CHANGETABLE( CHANGES CMS_User , NULL )AS CT_CMS_User
       ON CMSUser.UserID = CT_CMS_User.UserID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES CMS_Site , NULL )AS CT_CMS_Site
       ON CMSSite.SiteID = CT_CMS_Site.SiteID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES CMS_UserSite , NULL )AS CT_CMS_UserSite
       ON UserSite.UserSiteID = CT_CMS_UserSite.UserSiteID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_Account , NULL )AS CT_HFit_Account
       ON ACCT.AccountID = CT_HFit_Account.AccountID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HACampaign , NULL )AS CT_HFit_HACampaign
       ON VHCJ.HACampaignID = CT_HFit_HACampaign.HACampaignID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HealthAssesmentUserAnswers , NULL )AS CT_HFit_HealthAssesmentUserAnswers
       ON HAUserAnswers.ItemID = CT_HFit_HealthAssesmentUserAnswers.ItemID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HealthAssesmentUserModule , NULL )AS CT_HFit_HealthAssesmentUserModule
       ON HAUserModule.ItemID = CT_HFit_HealthAssesmentUserModule.ItemID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HealthAssesmentUserQuestion , NULL )AS CT_HFit_HealthAssesmentUserQuestion
       ON HAUserQuestion.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HealthAssesmentUserQuestionGroupResults , NULL )AS CT_HFit_HealthAssesmentUserQuestionGroupResults
       ON HAUserQuestionGroupResults.ItemID = CT_HFit_HealthAssesmentUserQuestionGroupResults.ItemID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HealthAssesmentUserRiskArea , NULL )AS CT_HFit_HealthAssesmentUserRiskArea
       ON HAUserRiskArea.ItemID = CT_HFit_HealthAssesmentUserRiskArea.ItemID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HealthAssesmentUserRiskCategory , NULL )AS CT_HFit_HealthAssesmentUserRiskCategory
       ON HARiskCategory.ItemID = CT_HFit_HealthAssesmentUserRiskCategory.ItemID
                                                                            LEFT OUTER JOIN CHANGETABLE( CHANGES HFit_HealthAssesmentUserStarted , NULL )AS CT_HFit_HealthAssesmentUserStarted
       ON HAUserStarted.ItemID = CT_HFit_HealthAssesmentUserStarted.ItemID
  WHERE
  UserSettings.HFitUserMpiNumber NOT IN (
  SELECT
         RejectMPICode
    FROM HFit_LKP_EDW_RejectMPI );
return ;
end;
