
/****************************************************************************
select * from view_EDW_HealthAssessment_MART_CMS2
select * +-into DIM_EDW_HA_STATIC_DATA from view_EDW_HealthAssessment_MART_CMS2
****************************************************************************/
/*
select top 10 UserID from KenticoCMS_2.dbo.HFit_HealthAssesmentUserStarted order by UserID desc
	update KenticoCMS_2.dbo.HFit_HealthAssesmentUserStarted Set HAScore = HAScore+1 where UserID in
	(
193684
,193441
,193440
,193359
,193312
,193310
,193306
,193302
,193299
,193295)
*/
-- use KenticoCMS_Datamart_2
-- select * from view_EDW_HealthAssessment_MART_Pull_CMS2
-- select * from view_EDW_HealthAssessment_MART_Pull_CMS2
GO
PRINT 'Creating view_EDW_HealthAssessment_MART_Pull_CMS2';
GO
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_EDW_HealthAssessment_MART_Pull_CMS2') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssessment_MART_Pull_CMS2
    END;

GO

/*********************************************************************************************************************************
    select top 100 hastartedmode from BASE_HFit_HealthAssesmentUserStarted where ItemID between 100 and 110
    update BASE_HFit_HealthAssesmentUserStarted -1 where ItemID between 100 and 110
    update BASE_HFit_HealthAssesmentUserStarted 3 where ItemID between 100 and 110

    select top 100 HATelephonicFlg from BASE_HFit_HealthAssesmentUserStarted where ItemID between 200 and 210
    update BASE_HFit_HealthAssesmentUserStarted set HATelephonicFlg = 1 where ItemID between  200 and 210
    update BASE_HFit_HealthAssesmentUserStarted set HATelephonicFlg = 0 where ItemID between  200 and 210

    update BASE_HFit_HealthAssesmentUserQuestion set IsProfessionallyCollected = 1 where ItemID in (15047,15048,15049,15050,15051)
    update BASE_HFit_HealthAssesmentUserQuestion set IsProfessionallyCollected = 0 where ItemID in (15047,15048,15049,15050,15051)

    select top 100 ItemID,CodeName from BASE_HFit_HealthAssesmentUserAnswers where ItemID in (15422,15423,15424)
    update BASE_HFit_HealthAssesmentUserAnswers set CodeName = 'Maybe' where ItemID  in (15422,15423,15424)
    update BASE_HFit_HealthAssesmentUserAnswers set CodeName = 'No' where ItemID  in (15422,15423,15424)

	select count(*) from view_EDW_HealthAssessment_MART_Pull_CMS2
*********************************************************************************************************************************/

--SET ROWCOUNT 100;
-- USE KenticoCMS_Datamart_2

CREATE VIEW view_EDW_HealthAssessment_MART_Pull_CMS2
AS
-- Use KenticoCMS_Datamart_2
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
       --, CAST (HAUserStarted.HAStartedDt AS datetime) AS HAStartedDt
       --, CAST (HAUserStarted.HACompletedDt AS datetime) AS HACompletedDt
     ,
       HAUserStarted.HAStartedDt
     ,HAUserStarted.HACompletedDt
     ,HAUserModule.ItemID AS UserModuleItemId
     ,HAUserModule.CodeName AS UserModuleCodeName
     ,HAUserModule.HAModuleNodeGUID
     ,VHAJ.NodeGUID AS CMSNodeGuid
     ,NULL AS HAModuleVersionID
     ,HARiskCategory.ItemID AS UserRiskCategoryItemID
     ,HARiskCategory.CodeName AS UserRiskCategoryCodeName
     ,HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
     ,
       NULL AS HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
     ,
       HAUserRiskArea.ItemID AS UserRiskAreaItemID
     ,HAUserRiskArea.CodeName AS UserRiskAreaCodeName
     ,HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
     ,
       NULL AS HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
     ,
       HAUserQuestion.ItemID AS UserQuestionItemID
       --, dbo.udf_StripHTML (HAQuestionsView.Title) AS Title			--WDM 47619 12.29.2014
     ,
       HAQuestionsView.Title
     ,HAUserQuestion.HAQuestionNodeGUID AS HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID and matches to the definition file to get the question. This tells you the question, language agnostic.
     ,
       HAUserQuestion.CodeName AS UserQuestionCodeName
     ,NULL AS HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
     ,
       NULL AS HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
     ,
       HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
     ,
       HAUserAnswers.ItemID AS UserAnswerItemID
     ,HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
     ,
       NULL AS HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
     ,
       HAUserAnswers.CodeName AS UserAnswerCodeName
     ,HAUserAnswers.HAAnswerValue
     ,HAUserModule.HAModuleScore
     ,HARiskCategory.HARiskCategoryScore
     ,HAUserRiskArea.HARiskAreaScore
     ,HAUserQuestion.HAQuestionScore
     ,HAUserAnswers.HAAnswerPoints
       --WDM , HAUserQuestionGroupResults.PointResults
     ,
       HAUserAnswers.UOMCode
     ,HAUserStarted.HAScore
     ,HAUserModule.PreWeightedScore AS ModulePreWeightedScore
     ,HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
     ,HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
     ,HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
       --WDM, HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName
     ,
       CASE
       WHEN
       HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen
           THEN 'I'
       ELSE 'U'
       END AS ChangeType
       --, CAST (HAUserAnswers.ItemCreatedWhen AS datetime) AS ItemCreatedWhen
       --, CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS ItemModifiedWhen
     ,
       HAUserAnswers.ItemCreatedWhen
     ,HAUserAnswers.ItemModifiedWhen
     ,HAUserQuestion.IsProfessionallyCollected
       --, CAST (HARiskCategory.ItemModifiedWhen AS datetime) AS HARiskCategory_ItemModifiedWhen
       --, CAST (HAUserRiskArea.ItemModifiedWhen AS datetime) AS HAUserRiskArea_ItemModifiedWhen
       --, CAST (HAUserQuestion.ItemModifiedWhen AS datetime) AS HAUserQuestion_ItemModifiedWhen
       --, CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS HAUserAnswers_ItemModifiedWhen
     ,
       HARiskCategory.ItemModifiedWhen AS HARiskCategory_ItemModifiedWhen
     ,HAUserRiskArea.ItemModifiedWhen AS HAUserRiskArea_ItemModifiedWhen
     ,HAUserQuestion.ItemModifiedWhen AS HAUserQuestion_ItemModifiedWhen
     ,HAUserAnswers.ItemModifiedWhen AS HAUserAnswers_ItemModifiedWhen
     ,HAUserStarted.HAPaperFlg
     ,HAUserStarted.HATelephonicFlg
     ,HAUserStarted.HAStartedMode		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
     ,
       HAUserStarted.HACompletedMode	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
     ,
       VHCJ.DocumentCulture AS DocumentCulture_VHCJ
     ,HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
     ,HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
     ,CASE
      WHEN HAUserStarted.HADocumentConfigID IS NULL
          THEN 'SHORT_VER'
      WHEN HAUserStarted.HADocumentConfigID IS NOT NULL
          THEN 'LONG_VER'
      ELSE 'UNKNOWN'
      END AS HealthAssessmentType
     ,HAUserStarted.CT_HAStartedMode
     ,HAUserStarted.CT_HATelephonicFlg
     ,HAUserStarted.CT_HADocumentConfigID
     ,UserSettings.CT_HFitUserMpiNumber
     ,HAUserQuestion.CT_IsProfessionallyCollected
     ,HAUserAnswers.CT_CodeName
     ,CASE
      WHEN
       HAUserStarted.CT_HAStartedMode = 1
          THEN 40
      WHEN
       HAUserStarted.CT_HATelephonicFlg = 1
          THEN 41
      WHEN
       HAUserAnswers.CT_ItemModifiedWhen = 1
          THEN 42
      WHEN
       HAUserQuestion.CT_ItemModifiedWhen = 1
          THEN 43
      WHEN
       HAUserRiskArea.CT_ItemModifiedWhen = 1
          THEN 44
      WHEN
       HAUserStarted.CT_HADocumentConfigID = 1
          THEN 52
      WHEN
       HAUserQuestion.CT_IsProfessionallyCollected = 1
          THEN 54
      WHEN
       HAUserAnswers.CT_ItemCreatedWhen = 1
          THEN 55
      WHEN
       HAUserAnswers.CT_ItemModifiedWhen = 1
          THEN 56
      WHEN
       HAUserModule.CT_PreWeightedScore = 1
          THEN 57
      --wdmWHEN
      --HAUserQuestionGroupResults.CT_PointResults = 1
      --THEN 50
      --wdmWHEN
      --HAUserQuestionGroupResults.CT_CodeName = 1
      --THEN 59
      WHEN
       HAUserQuestion.CT_PreWeightedScore = 1
          THEN 60
      WHEN
       HAUserRiskArea.CT_PreWeightedScore = 1
          THEN 61
      WHEN
       HARiskCategory.CT_PreWeightedScore = 1
          THEN 62
      WHEN
       CMSSite.CT_SiteGUID = 1
          THEN 63
      WHEN
       HAQuestionsView.CT_Title = 1
          THEN 64
      WHEN
       HAUserAnswers.CT_UOMCode = 1
          THEN 65
      WHEN
       HAUserAnswers.CT_CodeName = 1
          THEN 66
      ELSE 0
      END AS RowDataChanged
     ,HAUserStarted.SurrogateKey_HFit_HealthAssesmentUserStarted
     ,CMSUser.SurrogateKey_CMS_User
     ,UserSettings.SurrogateKey_CMS_UserSettings
     ,UserSite.SurrogateKey_CMS_UserSite
     ,CMSSite.SurrogateKey_CMS_Site
     ,ACCT.SurrogateKey_HFit_Account
     ,HAUserModule.SurrogateKey_HFit_HealthAssesmentUserModule
     ,VHCJ.SurrogateKey_View_HFit_HACampaign_Joined
     ,VHAJ.SurrogateKey_View_HFit_HealthAssessment_Joined
     ,HARiskCategory.SurrogateKey_HFit_HealthAssesmentUserRiskCategory
     ,HAUserRiskArea.SurrogateKey_HFit_HealthAssesmentUserRiskArea
     ,HAUserQuestion.SurrogateKey_HFit_HealthAssesmentUserQuestion
     ,HAQuestionsView.SurrogateKey_View_EDW_HealthAssesmentQuestions
       --wdm,HAUserQuestionGroupResults.SurrogateKey_HFit_HealthAssesmentUserQuestionGroupResults	  
     ,
       HAUserAnswers.SurrogateKey_HFit_HealthAssesmentUserAnswers
     ,HAUserStarted.DBNAME
     ,HAUserStarted.SVR
     ,HAUserStarted.LastModifiedDate AS HAUserStarted_LastModifiedDate
     ,CMSUser.LastModifiedDate AS CMSUser_LastModifiedDate
     ,UserSettings.LastModifiedDate AS UserSettings_LastModifiedDate
     ,UserSite.LastModifiedDate AS UserSite_LastModifiedDate
     ,ACCT.LastModifiedDate AS ACCT_LastModifiedDate
     ,HAUserModule.LastModifiedDate AS HAUserModule_LastModifiedDate
     ,HARiskCategory.LastModifiedDate AS HARiskCategory_LastModifiedDate
     ,HAUserRiskArea.LastModifiedDate AS HAUserRiskArea_LastModifiedDate
     ,HAUserQuestion.LastModifiedDate AS HAUserQuestion_LastModifiedDate
     ,HAUserAnswers.LastModifiedDate AS HAUserAnswers_LastModifiedDate
     ,CASE
      WHEN
       HAUserStarted.LastModifiedDate > CMSUser.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > UserSettings.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > UserSite.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > ACCT.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > HAUserModule.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       HAUserStarted.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN HAUserStarted.LastModifiedDate
      WHEN
       CMSUser.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       CMSUser.LastModifiedDate > UserSettings.LastModifiedDate AND
       CMSUser.LastModifiedDate > UserSite.LastModifiedDate AND
       CMSUser.LastModifiedDate > ACCT.LastModifiedDate AND
       CMSUser.LastModifiedDate > HAUserModule.LastModifiedDate AND
       CMSUser.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       CMSUser.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       CMSUser.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       CMSUser.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN CMSUser.LastModifiedDate
      WHEN
       UserSettings.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       UserSettings.LastModifiedDate > CMSUser.LastModifiedDate AND
       UserSettings.LastModifiedDate > UserSite.LastModifiedDate AND
       UserSettings.LastModifiedDate > ACCT.LastModifiedDate AND
       UserSettings.LastModifiedDate > HAUserModule.LastModifiedDate AND
       UserSettings.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       UserSettings.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       UserSettings.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       UserSettings.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN UserSettings.LastModifiedDate
      WHEN
       UserSite.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       UserSite.LastModifiedDate > CMSUser.LastModifiedDate AND
       UserSite.LastModifiedDate > UserSettings.LastModifiedDate AND
       UserSite.LastModifiedDate > ACCT.LastModifiedDate AND
       UserSite.LastModifiedDate > HAUserModule.LastModifiedDate AND
       UserSite.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       UserSite.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       UserSite.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       UserSite.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN UserSite.LastModifiedDate
      WHEN
       ACCT.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       ACCT.LastModifiedDate > CMSUser.LastModifiedDate AND
       ACCT.LastModifiedDate > UserSettings.LastModifiedDate AND
       ACCT.LastModifiedDate > UserSite.LastModifiedDate AND
       ACCT.LastModifiedDate > HAUserModule.LastModifiedDate AND
       ACCT.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       ACCT.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       ACCT.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       ACCT.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN ACCT.LastModifiedDate
      WHEN
       HAUserModule.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       HAUserModule.LastModifiedDate > CMSUser.LastModifiedDate AND
       HAUserModule.LastModifiedDate > UserSettings.LastModifiedDate AND
       HAUserModule.LastModifiedDate > UserSite.LastModifiedDate AND
       HAUserModule.LastModifiedDate > ACCT.LastModifiedDate AND
       HAUserModule.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       HAUserModule.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       HAUserModule.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       HAUserModule.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN HAUserModule.LastModifiedDate
      WHEN
       HARiskCategory.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > CMSUser.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > UserSettings.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > UserSite.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > ACCT.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > HAUserModule.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       HARiskCategory.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN HAUserModule.LastModifiedDate
      WHEN
       HAUserRiskArea.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > CMSUser.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > UserSettings.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > UserSite.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > ACCT.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > HAUserModule.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > HAUserQuestion.LastModifiedDate AND
       HAUserRiskArea.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN HAUserRiskArea.LastModifiedDate
      WHEN
       HAUserQuestion.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > CMSUser.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > UserSettings.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > UserSite.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > ACCT.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > HAUserModule.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       HAUserQuestion.LastModifiedDate > HAUserAnswers.LastModifiedDate
          THEN HAUserQuestion.LastModifiedDate
      WHEN
       HAUserAnswers.LastModifiedDate > HAUserStarted.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > CMSUser.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > UserSettings.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > UserSite.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > ACCT.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > HAUserModule.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > HARiskCategory.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > HAUserRiskArea.LastModifiedDate AND
       HAUserAnswers.LastModifiedDate > HAUserQuestion.LastModifiedDate
          THEN HAUserAnswers.LastModifiedDate
      ELSE NULL
      END AS LastModifiedDate
     ,CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_VERSION

/*********************************************************************************
use KenticoCMS_Datamart_2
SELECT *    
FROM
    CHANGETABLE(CHANGES KenticoCMS_2.dbo.HFit_HealthAssesmentUserStarted, 0) AS CT
*********************************************************************************/
FROM
     CHANGETABLE (CHANGES KenticoCMS_2.dbo.HFit_HealthAssesmentUserStarted, 0) AS CT
          INNER JOIN dbo.BASE_HFit_HealthAssesmentUserStarted AS HAUserStarted
          ON
       HAUserStarted.ItemID = CT.ItemID
	  and HAUserStarted.DBNAME = 'KenticoCMS_2'
          INNER JOIN dbo.BASE_CMS_User AS CMSUser
          ON
       HAUserStarted.UserID = CMSUser.UserID AND --HAUserStarted.SVR = CMSUser.SVR AND
       HAUserStarted.DBNAME = CMSUser.DBNAME --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserStarted , NULL) AS CT_HAUserStarted
     --ON
     --  HAUserStarted.SurrogateKey_HFit_HealthAssesmentUserStarted = CT_HAUserStarted.SurrogateKey_HFit_HealthAssesmentUserStarted
          INNER JOIN dbo.BASE_CMS_UserSettings AS UserSettings
          ON
       UserSettings.UserSettingsUserID = CMSUser.UserID AND --UserSettings.SVR = CMSUser.SVR AND
       UserSettings.DBNAME = CMSUser.DBNAME AND
       HFitUserMpiNumber >= 0 AND HFitUserMpiNumber IS NOT NULL -- (WDM) CR47516 
     --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_CMS_UserSettings , NULL) AS CTBL_UserSettings
     --ON
     --  UserSettings.SurrogateKey_CMS_UserSettings = CTBL_UserSettings.SurrogateKey_CMS_UserSettings
          INNER JOIN dbo.BASE_CMS_UserSite AS UserSite
          ON
       CMSUser.UserID = UserSite.UserID AND --CMSUser.SVR = UserSite.SVR AND
       CMSUser.DBNAME = UserSite.DBNAME
          INNER JOIN dbo.BASE_CMS_Site AS CMSSite
          ON
       UserSite.SiteID = CMSSite.SiteID AND --UserSite.SVR = CMSSite.SVR AND
       UserSite.DBNAME = CMSSite.DBNAME
          INNER JOIN dbo.BASE_HFit_Account AS ACCT
          ON
       ACCT.SiteID = CMSSite.SiteID AND --ACCT.svr = CMSSite.SVR AND
       ACCT.DBNAME = CMSSite.DBNAME
          INNER JOIN dbo.BASE_HFit_HealthAssesmentUserModule AS HAUserModule
          ON
       HAUserStarted.ItemID = HAUserModule.HAStartedItemID AND --HAUserStarted.SVR = HAUserModule.SVR AND
       HAUserStarted.DBNAME = HAUserModule.DBNAME --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserModule , NULL) AS CT_HAUserModule
     --ON
     --  HAUserModule.SurrogateKey_HFit_HealthAssesmentUserModule = HAUserModule.SurrogateKey_HFit_HealthAssesmentUserModule
          INNER JOIN dbo.BASE_View_HFit_HACampaign_Joined AS VHCJ
          ON
       VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID AND --VHCJ.SVR = HAUserStarted.SVR AND
       VHCJ.DBNAME = HAUserStarted.DBNAME AND
       VHCJ.NodeSiteID = UserSite.SiteID AND
       VHCJ.DocumentCulture = 'en-US'
          INNER JOIN dbo.BASE_View_HFit_HealthAssessment_Joined AS VHAJ
          ON
       VHAJ.DocumentID = VHCJ.HealthAssessmentID AND --VHAJ.SVR = VHCJ.SVR AND
       VHAJ.DBNAME = VHCJ.DBNAME
          INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
          ON
       HAUserModule.ItemID = HARiskCategory.HAModuleItemID AND --HAUserModule.SVR = HARiskCategory.SVR AND
       HAUserModule.DBNAME = HARiskCategory.DBNAME --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskCategory , NULL) AS CTBL_HARiskCategory
     --ON
     --  HARiskCategory.SurrogateKey_HFit_HealthAssesmentUserRiskCategory = CTBL_HARiskCategory.SurrogateKey_HFit_HealthAssesmentUserRiskCategory
          INNER JOIN dbo.BASE_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
          ON
       HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID AND --HARiskCategory.SVR = HAUserRiskArea.SVR AND
       HARiskCategory.DBNAME = HAUserRiskArea.DBNAME --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserRiskArea , NULL) AS CTBL_HAUserRiskArea
     --ON
     --  HAUserRiskArea.SurrogateKey_HFit_HealthAssesmentUserRiskArea = CTBL_HAUserRiskArea.SurrogateKey_HFit_HealthAssesmentUserRiskArea
          INNER JOIN dbo.BASE_HFit_HealthAssesmentUserQuestion AS HAUserQuestion
          ON
       HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID AND --HAUserRiskArea.SVR = HAUserQuestion.SVR AND
       HAUserRiskArea.DBNAME = HAUserQuestion.DBNAME --**********************
     --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestion , NULL) AS CTBL_HAUserQuestion
     --ON
     --  HAUserQuestion.SurrogateKey_HFit_HealthAssesmentUserQuestion = CTBL_HAUserQuestion.SurrogateKey_HFit_HealthAssesmentUserQuestion
          INNER JOIN dbo.BASE_View_EDW_HealthAssesmentQuestions AS HAQuestionsView
          ON
       HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID AND --HAUserQuestion.SVR = HAQuestionsView.SVR AND
       HAUserQuestion.DBNAME = HAQuestionsView.DBNAME AND
       HAQuestionsView.DocumentCulture = 'en-US' --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_View_EDW_HealthAssesmentQuestions , NULL) AS CTBL_HAQuestionsView
     --ON
     --  HAQuestionsView.SurrogateKey_View_EDW_HealthAssesmentQuestions = CTBL_HAQuestionsView.SurrogateKey_View_EDW_HealthAssesmentQuestions

     --wdmLEFT JOIN
     --dbo.BASE_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
     --ON
     --  HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID AND --HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR AND
     --  HAUserRiskArea.DBNAME = HAUserQuestionGroupResults.DBNAME 

     --LEFT JOIN
     --CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestionGroupResults , NULL) AS CTBL_HAUserQuestionGroupResults
     --ON
     --  HAUserQuestionGroupResults.SurrogateKey_HFit_HealthAssesmentUserQuestionGroupResults = CTBL_HAUserQuestionGroupResults.SurrogateKey_HFit_HealthAssesmentUserQuestionGroupResults
          INNER JOIN dbo.BASE_HFit_HealthAssesmentUserAnswers AS HAUserAnswers
          ON
       HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID AND --HAUserQuestion.SVR = HAUserAnswers.SVR AND
       HAUserQuestion.DBNAME = HAUserAnswers.DBNAME;
--LEFT JOIN
--CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers , NULL) AS CTBL_HAUserAnswers
--ON
--  HAUserAnswers.SurrogateKey_HFit_HealthAssesmentUserAnswers = CTBL_HAUserAnswers.SurrogateKey_HFit_HealthAssesmentUserAnswers
--WDMWHERE
--UserSettings.HFitUserMpiNumber NOT IN (
--SELECT
--       RejectMPICode
--FROM  dbo.BASE_HFit_LKP_EDW_RejectMPI) ;

GO
-- use KenticoCMS_Datamart_2
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_EDW_HealthAssessment_MART_CMS2') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssessment_MART_CMS2;
    END;
GO
CREATE VIEW view_EDW_HealthAssessment_MART_CMS2
AS SELECT
          HaMain.UserStartedItemID
        ,HaMain.UserID
        ,HaMain.UserGUID
        ,HaMain.HFitUserMpiNumber
        ,HaMain.SiteGUID
        ,HaMain.AccountID
        ,HaMain.AccountCD
        ,HaMain.AccountName
        ,HaMain.HAStartedDt
        ,HaMain.HACompletedDt
        ,HaMain.UserModuleItemId
        ,HaMain.UserModuleCodeName
        ,HaMain.HAModuleNodeGUID
        ,HaMain.CMSNodeGuid
        ,HaMain.HAModuleVersionID
        ,HaMain.UserRiskCategoryItemID
        ,HaMain.UserRiskCategoryCodeName
        ,HaMain.HARiskCategoryNodeGUID
        ,HaMain.HARiskCategoryVersionID
        ,HaMain.UserRiskAreaItemID
        ,HaMain.UserRiskAreaCodeName
        ,HaMain.HARiskAreaNodeGUID
        ,HaMain.HARiskAreaVersionID
        ,HaMain.UserQuestionItemID
        ,HaMain.Title
        ,HaMain.HAQuestionGuid
        ,HaMain.UserQuestionCodeName
        ,HaMain.HAQuestionDocumentID
        ,HaMain.HAQuestionVersionID
        ,HaMain.HAQuestionNodeGUID
        ,HaMain.UserAnswerItemID
        ,HaMain.HAAnswerNodeGUID
        ,HaMain.HAAnswerVersionID
        ,HaMain.UserAnswerCodeName
        ,HaMain.HAAnswerValue
        ,HaMain.HAModuleScore
        ,HaMain.HARiskCategoryScore
        ,HaMain.HARiskAreaScore
        ,HaMain.HAQuestionScore
        ,HaMain.HAAnswerPoints
        ,HaMain.UOMCode
        ,HaMain.HAScore
        ,HaMain.ModulePreWeightedScore
        ,HaMain.RiskCategoryPreWeightedScore
        ,HaMain.RiskAreaPreWeightedScore
        ,HaMain.QuestionPreWeightedScore
        ,HaMain.ChangeType
        ,HaMain.ItemCreatedWhen
        ,HaMain.ItemModifiedWhen
        ,HaMain.IsProfessionallyCollected
        ,HaMain.HAPaperFlg
        ,HaMain.HATelephonicFlg
        ,HaMain.HAStartedMode
        ,HaMain.HACompletedMode
        ,HaMain.DocumentCulture_VHCJ
        ,HaMain.DocumentCulture_HAQuestionsView
        ,HaMain.CampaignNodeGUID
        ,HaMain.HealthAssessmentType
        ,HaMain.HAUserStarted_LastModifiedDate
        ,HaMain.CMSUser_LastModifiedDate
        ,HaMain.UserSettings_LastModifiedDate
        ,HaMain.UserSite_LastModifiedDate
        ,HaMain.ACCT_LastModifiedDate
        ,HaMain.HAUserModule_LastModifiedDate
        ,HaMain.HARiskCategory_LastModifiedDate
        ,HaMain.HAUserRiskArea_LastModifiedDate
        ,HaMain.HAUserQuestion_LastModifiedDate
        ,HaMain.HAUserAnswers_LastModifiedDate
        ,HealthAssesmentUserStartedNodeGUID
        ,HAUserQuestionGroupResults.PointResults
        ,HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName
        ,HaMain.CT_HAStartedMode
        ,HaMain.CT_HATelephonicFlg
        ,HaMain.CT_HADocumentConfigID
        ,HaMain.CT_HFitUserMpiNumber
        ,HaMain.CT_IsProfessionallyCollected
        ,HaMain.CT_CodeName
        ,HaMain.SurrogateKey_HFit_HealthAssesmentUserStarted
        ,HaMain.SurrogateKey_CMS_User
        ,HaMain.SurrogateKey_CMS_UserSettings
        ,HaMain.SurrogateKey_CMS_UserSite
        ,HaMain.SurrogateKey_CMS_Site
        ,HaMain.SurrogateKey_HFit_Account
        ,HaMain.SurrogateKey_HFit_HealthAssesmentUserModule
        ,HaMain.SurrogateKey_View_HFit_HACampaign_Joined
        ,HaMain.SurrogateKey_View_HFit_HealthAssessment_Joined
        ,HaMain.SurrogateKey_HFit_HealthAssesmentUserRiskCategory
        ,HaMain.SurrogateKey_HFit_HealthAssesmentUserRiskArea
        ,HaMain.SurrogateKey_HFit_HealthAssesmentUserQuestion
        ,HaMain.SurrogateKey_View_EDW_HealthAssesmentQuestions
        ,HaMain.SurrogateKey_HFit_HealthAssesmentUserAnswers
        ,HaMain.HARiskCategory_ItemModifiedWhen
        ,HaMain.HAUserRiskArea_ItemModifiedWhen
        ,HaMain.HAUserQuestion_ItemModifiedWhen
        ,HaMain.HAUserAnswers_ItemModifiedWhen
        ,HaMain.LastModifiedDate
        ,HaMain.RowDataChanged
        ,HaMain.SVR
        ,HaMain.DBNAME, HaMain.SYS_CHANGE_OPERATION, HaMain.SYS_CHANGE_VERSION
   FROM
        view_EDW_HealthAssessment_MART_Pull_CMS2 AS HaMain -- WITH (NOEXPAND) 
             LEFT JOIN dbo.BASE_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
             ON
          UserRiskAreaItemID = HAUserQuestionGroupResults.HARiskAreaItemID AND --HAUserRiskArea.SVR = HAUserQuestionGroupResults.SVR AND
          HAMAIN.DBNAME = HAUserQuestionGroupResults.DBNAME
             LEFT JOIN BASE_HFit_LKP_EDW_RejectMPI AS REJECT
             ON
          HAMAIN.HFitUserMpiNumber = REJECT.RejectMPICode
   WHERE REJECT.RejectMPICode IS NULL;
--WHERE
--HAMAIN.HFitUserMpiNumber NOT IN (
--SELECT
--       RejectMPICode
--FROM dbo.BASE_HFit_LKP_EDW_RejectMPI) ;

GO

/***********************************************************************************
************************************************************************************
use KenticoCMS_Datamart_2
go
SELECT 
       top 1000 *
FROM view_EDW_HealthAssessment_MART_CMS2
WHERE
       RowDataChanged > 0 AND LastModifiedDate  > '2016-03-09' 
************************************************************************************
***********************************************************************************/

GO
PRINT 'Created view_EDW_HealthAssessment_MART_Pull_CMS2';
GO




