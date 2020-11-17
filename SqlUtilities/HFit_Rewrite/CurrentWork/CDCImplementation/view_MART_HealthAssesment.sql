USE KenticoCMS_DataMart_2;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_MART_HealthAssesment') 
    BEGIN
        DROP VIEW
             view_MART_HealthAssesment
    END;
GO
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

-- WDM: 11/28/2015
-- This view is a test view used to develop a possible SSIS implementation of the HA dimension table.
-- select top 100 * from [view_MART_HealthAssesment]
-- select count(*) from [view_MART_HealthAssesment]
/*
drop table TEMP_view_MART_HealthAssesment
set rowcount 100 ;
select * into TEMP_view_MART_HealthAssesment from dbo.view_MART_HealthAssesment

select top 100 * from view_MART_HealthAssesment

*/
CREATE VIEW dbo.view_MART_HealthAssesment 
--WITH SCHEMABINDING
AS 
SELECT
          HAUserStarted.ItemID AS UserStartedItemID
        , isnull(VHAJ.NodeGUID,'00000000-0000-0000-0000-000000000000') AS HealthAssesmentUserStartedNodeGUID
        , HAUserStarted.UserID
        , isnull(CMSUser.UserGUID,'00000000-0000-0000-0000-000000000000') as UserGuid
        , isnull(UserSettings.HFitUserMpiNumber,-1) as HFitUserMpiNumber
        , isnull(CMSSite.SiteGUID,'00000000-0000-0000-0000-000000000000') as SiteGuid
        , ACCT.AccountID
        , isnull(ACCT.AccountCD,'?') as AccountCD
        , ACCT.AccountName
        , CAST (HAUserStarted.HAStartedDt AS DATETIME2) AS HAStartedDt
        , isnull(HAUserStarted.HACompletedDt,'1700-01-01') AS HACompletedDt
        , HAUserModule.ItemID AS UserModuleItemId
        , isnull(HAUserModule.CodeName,'?') AS UserModuleCodeName
        , isnull(HAUserModule.HAModuleNodeGUID,'00000000-0000-0000-0000-000000000000') as HAModuleNodeGUID
        , isnull(VHAJ.NodeGUID ,'00000000-0000-0000-0000-000000000000') AS CMSNodeGuid
        , -1 AS HAModuleVersionID
        , isnull(HARiskCategory.ItemID,-1) AS UserRiskCategoryItemID
        , isnull(HARiskCategory.CodeName,'?') AS UserRiskCategoryCodeName
        , isnull(HARiskCategory.HARiskCategoryNodeGUID,'00000000-0000-0000-0000-000000000000') as HARiskCategoryNodeGUID
        , -1 AS HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
        , isnull(HAUserRiskArea.ItemID,-1) AS UserRiskAreaItemID
        , isnull(HAUserRiskArea.CodeName,'?') AS UserRiskAreaCodeName
        , isnull(HAUserRiskArea.HARiskAreaNodeGUID,'00000000-0000-0000-0000-000000000000') as HARiskAreaNodeGUID
        , -1  AS HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
        , HAUserQuestion.ItemID AS UserQuestionItemID
        , dbo.udf_StripHTML (HAQuestionsView.Title) AS Title			--WDM 47619 12.29.2014
        , isnull(HAUserQuestion.HAQuestionNodeGUID,'00000000-0000-0000-0000-000000000000')	AS HAQuestionGuid
        , isnull(HAUserQuestion.CodeName,'?') AS UserQuestionCodeName
        , -1 AS HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
        , -1 AS HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
        , isnull(HAUserQuestion.HAQuestionNodeGUID,'00000000-0000-0000-0000-000000000000') as HAQuestionNodeGUID
        , HAUserAnswers.ItemID AS UserAnswerItemID
        , isnull(HAUserAnswers.HAAnswerNodeGUID,'00000000-0000-0000-0000-000000000000') as HAAnswerNodeGUID
        , -1 AS HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
        , HAUserAnswers.CodeName AS UserAnswerCodeName
        , HAUserAnswers.HAAnswerValue
        , HAUserModule.HAModuleScore
        , HARiskCategory.HARiskCategoryScore
        , HAUserRiskArea.HARiskAreaScore
        , HAUserQuestion.HAQuestionScore
        , HAUserAnswers.HAAnswerPoints
        , isnull(HAUserQuestionGroupResults.PointResults, -1) as PointResults
        , HAUserAnswers.UOMCode
        , HAUserStarted.HAScore
        , HAUserModule.PreWeightedScore AS ModulePreWeightedScore
        , HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
        , HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
        , HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
        , isnull(HAUserQuestionGroupResults.CodeName, '?') AS QuestionGroupCodeName
        , CASE
          WHEN
          HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , CAST (HAUserAnswers.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
        , CAST (HAUserAnswers.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
        , HAUserQuestion.IsProfessionallyCollected
        , CAST (HARiskCategory.ItemModifiedWhen AS DATETIME2) AS HARiskCategory_ItemModifiedWhen
        , CAST (HAUserRiskArea.ItemModifiedWhen AS DATETIME2) AS HAUserRiskArea_ItemModifiedWhen
        , CAST (HAUserQuestion.ItemModifiedWhen AS DATETIME2) AS HAUserQuestion_ItemModifiedWhen
        , CAST (HAUserAnswers.ItemModifiedWhen AS DATETIME2) AS HAUserAnswers_ItemModifiedWhen
        , HAUserStarted.HAPaperFlg
        , HAUserStarted.HATelephonicFlg
        , HAUserStarted.HAStartedMode		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
        , HAUserStarted.HACompletedMode	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

        , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
        , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
        , isnull(HAUserStarted.HACampaignNodeGUID,'00000000-0000-0000-0000-000000000000') AS CampaignNodeGUID
        , CASE
          WHEN HAUserStarted.HADocumentConfigID IS NULL
                  THEN 'SHORT_VER'
          WHEN HAUserStarted.HADocumentConfigID IS NOT NULL
                  THEN 'LONG_VER'
              ELSE 'UNKNOWN'
          END AS HealthAssessmentType
		 , HAUserStarted.SVR
		  , HAUserStarted.DBNAME
          FROM dbo.BASE_HFit_HealthAssesmentUserStarted AS HAUserStarted
                   INNER JOIN dbo.BASE_CMS_User AS CMSUser
                       ON HAUserStarted.UserID = CMSUser.UserID
                      AND HAUserStarted.SVR = CMSUser.SVR
                      AND HAUserStarted.DBNAME = CMSUser.DBNAME
                   INNER JOIN dbo.BASE_CMS_UserSettings AS UserSettings
                       ON UserSettings.SVR = CMSUser.SVR
                      AND UserSettings.DBNAME = CMSUser.DBNAME
                      AND UserSettings.UserSettingsUserID = CMSUser.UserID
                      AND HFitUserMpiNumber >= 0
                      AND HFitUserMpiNumber IS NOT NULL -- (WDM) CR47516 
                   INNER JOIN dbo.BASE_CMS_UserSite AS UserSite
                       ON CMSUser.UserID = UserSite.UserID
                      AND CMSUser.SVR = UserSite.SVR
                      AND CMSUser.DBNAME = UserSite.DBNAME
                   INNER JOIN dbo.BASE_CMS_Site AS CMSSite
                       ON UserSite.SiteID = CMSSite.SiteID
                      AND UserSite.SVR = CMSSite.SVR
                      AND UserSite.DBNAME = CMSSite.DBNAME
                   INNER JOIN dbo.BASE_HFit_Account AS ACCT
                       ON ACCT.SiteID = CMSSite.SiteID
                      AND ACCT.SVR = CMSSite.SVR
                      AND ACCT.DBNAME = CMSSite.DBNAME
                   INNER JOIN dbo.BASE_HFit_HealthAssesmentUserModule AS HAUserModule
                       ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
                      AND HAUserStarted.SVR = HAUserModule.SVR
                      AND HAUserStarted.DBNAME = HAUserModule.DBNAME
                   INNER JOIN FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED AS VHCJ
                       ON VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID
                      AND VHCJ.SVR = HAUserStarted.SVR
                      AND VHCJ.DBNAME = HAUserStarted.DBNAME
                      AND VHCJ.NodeSiteID = UserSite.SiteID
                      AND VHCJ.DocumentCulture = 'en-US'
                   INNER JOIN FACT_EDW_View_HFit_HealthAssessment_Joined AS VHAJ
                       ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
                      AND VHAJ.SVR = VHCJ.SVR
                      AND VHAJ.DBNAME = VHCJ.DBNAME
                   INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
                       ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
                      AND HAUserModule.SVR = HARiskCategory.SVR
                      AND HAUserModule.DBNAME = HARiskCategory.DBNAME
                   INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                       ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
                      AND HARiskCategory.SVR = HAUserRiskArea.SVR
                      AND HARiskCategory.DBNAME = HAUserRiskArea.DBNAME
                   INNER JOIN dbo.BASE_HFit_HealthAssesmentUserQuestion AS HAUserQuestion
                       ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
                      AND HAUserRiskArea.SVR = HAUserQuestion.SVR
                      AND HAUserRiskArea.DBNAME = HAUserQuestion.DBNAME
                   INNER JOIN dbo.FACT_View_EDW_HealthAssesmentQuestions AS HAQuestionsView
                       ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
                      AND HAUserQuestion.SVR = HAQuestionsView.SVR
                      AND HAUserQuestion.DBNAME = HAQuestionsView.DBNAME
                      AND HAQuestionsView.DocumentCulture = 'en-US'
                   LEFT OUTER JOIN dbo.FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
                       ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
                      AND HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR
                      AND HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME
                   INNER JOIN dbo.BASE_HFit_HealthAssesmentUserAnswers AS HAUserAnswers
                       ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID
                      AND HAUserQuestion.SVR = HAUserAnswers.SVR
                      AND HAUserQuestion.DBNAME = HAUserAnswers.DBNAME
          WHERE UserSettings.HFitUserMpiNumber NOT IN (
       SELECT
              RejectMPICode
              FROM HFit_LKP_EDW_RejectMPI);

GO
----Create an index on the view.
--CREATE UNIQUE CLUSTERED INDEX PKI_view_MART_HealthAssesment 
--    ON Sales.vOrders (OrderDate, ProductID);