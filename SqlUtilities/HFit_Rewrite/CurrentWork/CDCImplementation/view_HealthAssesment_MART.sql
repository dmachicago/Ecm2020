USE KenticoCMS_DataMart_2;
GO
IF EXISTS ( SELECT
                   name
            FROM sys.views
            WHERE
                   name = 'view_HealthAssesment_MART'
) 
    BEGIN
        DROP VIEW
             view_HealthAssesment_MART;
    END;
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

-- WDM: 11/28/2015
-- This view is a test view used to develop a possible SSIS implementation of the HA dimension table.
/*
use KenticoCMS_Datamart_2
go
select top 100 * from [view_HealthAssesment_MART]
where (HAUserQuestion_ItemModifiedWhen > '2016-03-09'
or HAUserRiskArea_ItemModifiedWhen > '2016-03-09'
or HAUserQuestion_ItemModifiedWhen > '2016-03-09'
or HAUserAnswers_ItemModifiedWhen > '2016-03-09')
and CT_RowDataUpdated = 1  > '2016-03-09'
*/
-- select count(*) from [view_HealthAssesment_MART]

/*-----------------------------------------------------------------------------
use KenticoCMS_Datamart_2

drop table TEMP_view_MART_HealthAssesment
set rowcount 100 ;
select * into TEMP_view_MART_HealthAssesment from dbo.view_HealthAssesment_MART

select top 100 * from view_HealthAssesment_MART
*/

CREATE VIEW dbo.view_HealthAssesment_MART

--WITH SCHEMABINDING

AS SELECT
          HAUserStarted.ItemID AS UserStartedItemID
        , ISNULL ( VHAJ.NodeGUID , '00000000-0000-0000-0000-000000000000'
          ) AS HealthAssesmentUserStartedNodeGUID
        , HAUserStarted.UserID
        , ISNULL ( CMSUser.UserGUID , '00000000-0000-0000-0000-000000000000'
          ) AS UserGuid
        , ISNULL ( UserSettings.HFitUserMpiNumber , -1
          ) AS HFitUserMpiNumber
        , ISNULL ( CMSSite.SiteGUID , '00000000-0000-0000-0000-000000000000'
          ) AS SiteGuid
        , ACCT.AccountID
        , ISNULL ( ACCT.AccountCD , '?'
          ) AS AccountCD
        , ACCT.AccountName
        , CAST ( HAUserStarted.HAStartedDt AS DATETIME2
          ) AS HAStartedDt
        , ISNULL ( HAUserStarted.HACompletedDt , '1700-01-01'
          ) AS HACompletedDt
        , HAUserModule.ItemID AS UserModuleItemId
        , ISNULL ( HAUserModule.CodeName , '?'
          ) AS UserModuleCodeName
        , ISNULL ( HAUserModule.HAModuleNodeGUID , '00000000-0000-0000-0000-000000000000'
          ) AS HAModuleNodeGUID
        , ISNULL ( VHAJ.NodeGUID , '00000000-0000-0000-0000-000000000000'
          ) AS CMSNodeGuid
        , -1 AS HAModuleVersionID
        , ISNULL ( HARiskCategory.ItemID , -1
          ) AS UserRiskCategoryItemID
        , ISNULL ( HARiskCategory.CodeName , '?'
          ) AS UserRiskCategoryCodeName
        , ISNULL ( HARiskCategory.HARiskCategoryNodeGUID , '00000000-0000-0000-0000-000000000000'
          ) AS HARiskCategoryNodeGUID
        , -1 AS HARiskCategoryVersionID
        , ISNULL ( HAUserRiskArea.ItemID , -1
          ) AS UserRiskAreaItemID
        , ISNULL ( HAUserRiskArea.CodeName , '?'
          ) AS UserRiskAreaCodeName
        , ISNULL ( HAUserRiskArea.HARiskAreaNodeGUID , '00000000-0000-0000-0000-000000000000'
          ) AS HARiskAreaNodeGUID
        , -1 AS HARiskAreaVersionID
        , HAUserQuestion.ItemID AS UserQuestionItemID
        , dbo.udf_StripHTML ( HAQuestionsView.Title
          ) AS Title
        , ISNULL ( HAUserQuestion.HAQuestionNodeGUID , '00000000-0000-0000-0000-000000000000'
          ) AS HAQuestionGuid
        , ISNULL ( HAUserQuestion.CodeName , '?'
          ) AS UserQuestionCodeName
        , -1 AS HAQuestionDocumentID
        , -1 AS HAQuestionVersionID
        , ISNULL ( HAUserQuestion.HAQuestionNodeGUID , '00000000-0000-0000-0000-000000000000'
          ) AS HAQuestionNodeGUID
        , HAUserAnswers.ItemID AS UserAnswerItemID
        , ISNULL ( HAUserAnswers.HAAnswerNodeGUID , '00000000-0000-0000-0000-000000000000') AS HAAnswerNodeGUID
        , -1 AS HAAnswerVersionID
        , HAUserAnswers.CodeName AS UserAnswerCodeName
        , HAUserAnswers.HAAnswerValue
        , HAUserModule.HAModuleScore
        , HARiskCategory.HARiskCategoryScore
        , HAUserRiskArea.HARiskAreaScore
        , HAUserQuestion.HAQuestionScore
        , HAUserAnswers.HAAnswerPoints
        , ISNULL ( HAUserQuestionGroupResults.PointResults , -1) AS PointResults
        , HAUserAnswers.UOMCode
        , HAUserStarted.HAScore
        , HAUserModule.PreWeightedScore AS ModulePreWeightedScore
        , HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
        , HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
        , HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
        , ISNULL ( HAUserQuestionGroupResults.CodeName , '?') AS QuestionGroupCodeName
        , CASE
          WHEN
          HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen
              THEN 'I'
          ELSE 'U'
          END AS ChangeType
        , CAST ( HAUserAnswers.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
        , CAST ( HAUserAnswers.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
        , HAUserQuestion.IsProfessionallyCollected
        , CAST ( HARiskCategory.ItemModifiedWhen AS DATETIME2) AS HARiskCategory_ItemModifiedWhen
        , CAST ( HAUserRiskArea.ItemModifiedWhen AS DATETIME2) AS HAUserRiskArea_ItemModifiedWhen
        , CAST ( HAUserQuestion.ItemModifiedWhen AS DATETIME2) AS HAUserQuestion_ItemModifiedWhen
        , CAST ( HAUserAnswers.ItemModifiedWhen AS DATETIME2) AS HAUserAnswers_ItemModifiedWhen
        , HAUserStarted.HAPaperFlg
        , HAUserStarted.HATelephonicFlg
        , HAUserStarted.HAStartedMode
        , .HACompletedMode
        , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
        , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
        , ISNULL ( HAUserStarted.HACampaignNodeGUID , '00000000-0000-0000-0000-000000000000') AS CampaignNodeGUID
        , CASE
          WHEN HAUserStarted.HADocumentConfigID IS NULL
              THEN 'SHORT_VER'
          WHEN HAUserStarted.HADocumentConfigID IS NOT NULL
              THEN 'LONG_VER'
          ELSE 'UNKNOWN'
          END AS HealthAssessmentType
        , HAUserStarted.SVR
        , HAUserStarted.DBNAME
   FROM
        dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
        INNER JOIN
        dbo.CMS_User AS CMSUser
        ON
          HAUserStarted.UserID = CMSUser.UserID AND
          HAUserStarted.SVR = CMSUser.SVR AND
          HAUserStarted.DBNAME = CMSUser.DBNAME
        INNER JOIN
        dbo.CMS_UserSettings AS UserSettings
        ON
          UserSettings.SVR = CMSUser.SVR AND
          UserSettings.DBNAME = CMSUser.DBNAME AND
          UserSettings.UserSettingsUserID = CMSUser.UserID AND
          HFitUserMpiNumber >= 0 AND
          HFitUserMpiNumber IS NOT NULL
        INNER JOIN
        dbo.CMS_UserSite AS UserSite
        ON
          CMSUser.UserID = UserSite.UserID AND
          CMSUser.SVR = UserSite.SVR AND
          CMSUser.DBNAME = UserSite.DBNAME
        INNER JOIN
        dbo.CMS_Site AS CMSSite
        ON
          UserSite.SiteID = CMSSite.SiteID AND
          UserSite.SVR = CMSSite.SVR AND
          UserSite.DBNAME = CMSSite.DBNAME
        INNER JOIN
        dbo.HFit_Account AS ACCT
        ON
          ACCT.SiteID = CMSSite.SiteID AND
          ACCT.SVR = CMSSite.SVR AND
          ACCT.DBNAME = CMSSite.DBNAME
        INNER JOIN
        dbo.HFit_HealthAssesmentUserModule AS HAUserModule
        ON
          HAUserStarted.ItemID = HAUserModule.HAStartedItemID AND
          HAUserStarted.SVR = HAUserModule.SVR AND
          HAUserStarted.DBNAME = HAUserModule.DBNAME
        INNER JOIN
        View_HFit_HACampaign_Joined AS VHCJ
        ON
          VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID AND
          VHCJ.SVR = HAUserStarted.SVR AND
          VHCJ.DBNAME = HAUserStarted.DBNAME AND
          VHCJ.NodeSiteID = UserSite.SiteID AND
          VHCJ.DocumentCulture = 'en-US'
        INNER JOIN
        View_HFit_HealthAssessment_Joined AS VHAJ
        ON
          VHAJ.DocumentID = VHCJ.HealthAssessmentID AND
          VHAJ.SVR = VHCJ.SVR AND
          VHAJ.DBNAME = VHCJ.DBNAME
        INNER JOIN
        dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
        ON
          HAUserModule.ItemID = HARiskCategory.HAModuleItemID AND
          HAUserModule.SVR = HARiskCategory.SVR AND
          HAUserModule.DBNAME = HARiskCategory.DBNAME
        INNER JOIN
        dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
        ON
          HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID AND
          HARiskCategory.SVR = HAUserRiskArea.SVR AND
          HARiskCategory.DBNAME = HAUserRiskArea.DBNAME
        INNER JOIN
        dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion
        ON
          HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID AND
          HAUserRiskArea.SVR = HAUserQuestion.SVR AND
          HAUserRiskArea.DBNAME = HAUserQuestion.DBNAME
        INNER JOIN
        dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
        ON
          HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID AND
          HAUserQuestion.SVR = HAQuestionsView.SVR AND
          HAUserQuestion.DBNAME = HAQuestionsView.DBNAME AND
          HAQuestionsView.DocumentCulture = 'en-US'
        LEFT OUTER JOIN
        dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
        ON
          HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID AND
          HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR AND
          HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME
        INNER JOIN
        dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers
        ON
          HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID AND
          HAUserQuestion.SVR = HAUserAnswers.SVR AND
          HAUserQuestion.DBNAME = HAUserAnswers.DBNAME
   WHERE UserSettings.HFitUserMpiNumber NOT IN (
   SELECT
          RejectMPICode
   FROM HFit_LKP_EDW_RejectMPI
   );
GO

----Create an index on the view.
--CREATE UNIQUE CLUSTERED INDEX PKI_view_MART_HealthAssesment 
--    ON Sales.vOrders (OrderDate, ProductID);