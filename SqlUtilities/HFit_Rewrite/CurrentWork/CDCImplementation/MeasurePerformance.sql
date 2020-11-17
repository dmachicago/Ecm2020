PRINT
	  DB_NAME () + ': Start 0: ' + CAST (GETDATE () AS NVarChar (100)) ;
GO

SELECT TOP 100
	  [UserStartedItemID]
	, [HealthAssesmentUserStartedNodeGUID]
	, [UserID]
	, [UserGUID]
	, [HFitUserMpiNumber]
	, [SiteGUID]
	, [AccountID]
	, [AccountCD]
	, [AccountName]
	, [HAStartedDt]
	, [HACompletedDt]
	, [UserModuleItemId]
	, [UserModuleCodeName]
	, [HAModuleNodeGUID]
	, [CMSNodeGuid]
	, [HAModuleVersionID]
	, [UserRiskCategoryItemID]
	, [UserRiskCategoryCodeName]
	, [HARiskCategoryNodeGUID]
	, [HARiskCategoryVersionID]
	, [UserRiskAreaItemID]
	, [UserRiskAreaCodeName]
	, [HARiskAreaNodeGUID]
	, [HARiskAreaVersionID]
	, [UserQuestionItemID]
	, [Title]
	, [HAQuestionGuid]
	, [UserQuestionCodeName]
	, [HAQuestionDocumentID]
	, [HAQuestionVersionID]
	, [HAQuestionNodeGUID]
	, [UserAnswerItemID]
	, [HAAnswerNodeGUID]
	, [HAAnswerVersionID]
	, [UserAnswerCodeName]
	, [HAAnswerValue]
	, [HAModuleScore]
	, [HARiskCategoryScore]
	, [HARiskAreaScore]
	, [HAQuestionScore]
	, [HAAnswerPoints]
	, [PointResults]
	, [UOMCode]
	, [HAScore]
	, [ModulePreWeightedScore]
	, [RiskCategoryPreWeightedScore]
	, [RiskAreaPreWeightedScore]
	, [QuestionPreWeightedScore]
	, [QuestionGroupCodeName]
	, [ChangeType]
	, [ItemCreatedWhen]
	, [ItemModifiedWhen]
	, [IsProfessionallyCollected]
	, [HARiskCategory_ItemModifiedWhen]
	, [HAUserRiskArea_ItemModifiedWhen]
	, [HAUserQuestion_ItemModifiedWhen]
	, [HAUserAnswers_ItemModifiedWhen]
	, [HAPaperFlg]
	, [HATelephonicFlg]
	, [HAStartedMode]
	, [HACompletedMode]
	, [DocumentCulture_VHCJ]
	, [DocumentCulture_HAQuestionsView]
	, [CampaignNodeGUID]
	, [HACampaignID]
	, [HashCode]
	, [LastModifiedDate]
	, [DeleteFlg]
	, [CT_CMS_User_UserID]
	, [CT_CMS_User_CHANGE_OPERATION]
	, [CT_UserSettingsID]
	, [CT_UserSettingsID_CHANGE_OPERATION]
	, [SiteID_CtID]
	, [SiteID_CHANGE_OPERATION]
	, [UserSiteID_CtID]
	, [UserSiteID_CHANGE_OPERATION]
	, [AccountID_CtID]
	, [AccountID__CHANGE_OPERATION]
	, [HAUserAnswers_CtID]
	, [HAUserAnswers_CHANGE_OPERATION]
	, [HFit_HealthAssesmentUserModule_CtID]
	, [HFit_HealthAssesmentUserModule_CHANGE_OPERATION]
	, [HFit_HealthAssesmentUserQuestion_CtID]
	, [HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION]
	, [HFit_HealthAssesmentUserQuestionGroupResults_CtID]
	, [HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION]
	, [HFit_HealthAssesmentUserRiskArea_CtID]
	, [HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION]
	, [HFit_HealthAssesmentUserRiskCategory_CtID]
	, [HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION]
	, [HFit_HealthAssesmentUserStarted_CtID]
	, [HFit_HealthAssesmentUserStarted_CHANGE_OPERATION]
   FROM [dbo].[view_EDW_HealthAssesmentCT];
GO
PRINT
	  DB_NAME () + ': Start 1: ' + CAST (GETDATE () AS NVarChar (100)) ;
GO  
--18 min.
SELECT '[view_EDW_HealthAssesmentCT]',
	  COUNT (*) 
   FROM [dbo].[view_EDW_HealthAssesmentCT];
GO
PRINT DB_NAME () + ': Start 2a: ' + CAST (GETDATE () AS NVarChar (100)) ;
go  
--20 Min. - 5697837 rows
SELECT '[view_EDW_HealthAssesmentALL]',
	  COUNT (*) 
   FROM [dbo].[view_EDW_HealthAssesmentALL]
GO
PRINT DB_NAME () + ': Start 2b: ' + CAST (GETDATE () AS NVarChar (100)) ;
GO
--KenticoCMS_Prod2: Start 2b: Mar 22 2015  9:39PM  --(29 row(s) affected)
--KenticoCMS_Prod2: Start 2c: Mar 23 2015  1:52AM
/*
select count(*) from  #tempEDW200
where 
[CT_CMS_User_UserID] is NULL
AND  [CT_UserSettingsID] IS NULL
AND  [SiteID_CtID] IS NULL
AND  [UserSiteID_CtID] IS NULL
AND  [AccountID_CtID] IS NULL
AND  [HAUserAnswers_CtID] IS NULL
AND  [HFit_HealthAssesmentUserModule_CtID] IS NULL
AND  [HFit_HealthAssesmentUserQuestion_CtID] IS NULL
AND  [HFit_HealthAssesmentUserQuestionGroupResults_CtID] IS NULL
AND  [HFit_HealthAssesmentUserRiskArea_CtID] IS NULL
AND  [HFit_HealthAssesmentUserRiskCategory_CtID] IS NULL
AND  [HFit_HealthAssesmentUserStarted_CtID] IS NULL;
*/
/*
select 'Count from view_EDW_HealthAssesmentCT', count(*)  from  [view_EDW_HealthAssesmentCT]
go
select 'Count from view_EDW_HealthAssesmentALL', count(*)  from  [view_EDW_HealthAssesmentALL]
go
*/
GO
PRINT DB_NAME () + ': Start 2b.1: ' + CAST (GETDATE () AS NVarChar (100)) ;
GO
if exists (select name from sys.tables where name = 'CT_EDW_HealthAssesment_ChangedData')
BEGIN
    drop table CT_EDW_HealthAssesment_ChangedData;
END;
go
--KenticoCMS_Prod3: Start 2b.1: Mar 23 2015 10:45PM (32 row(s) affected) KenticoCMS_Prod3: Start 2c: Mar 24 2015  5:58AM
--select * from CT_EDW_HealthAssesment_ChangedData
SELECT
	  *
    into CT_EDW_HealthAssesment_ChangedData
    FROM [dbo].[view_EDW_HealthAssesmentCT] ;    
GO
PRINT DB_NAME () + ': Start 2c: ' + CAST (GETDATE () AS NVarChar (100)) ;
GO
--14:39, 16:12
SELECT
	  COUNT (*) 
   FROM [dbo].[view_EDW_HealthAssesmentALL]
   WHERE
UserGuid is not null AND
(
   [CT_CMS_User_UserID] IS NOT NULL
OR [CT_UserSettingsID] IS NOT NULL
OR [SiteID_CtID] IS NOT NULL
OR [UserSiteID_CtID] IS NOT NULL
OR [AccountID_CtID] IS NOT NULL
OR [HAUserAnswers_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserModule_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserQuestion_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserQuestionGroupResults_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserRiskArea_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserRiskCategory_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserStarted_CtID] IS NOT NULL);
GO
PRINT
	  DB_NAME () + ': Start 3: ' + CAST (GETDATE () AS NVarChar (100)) ;
GO
DECLARE @fn AS NVarChar (200) =
	  '#TempHA_' + CAST (GETDATE () AS NVarChar (200)) ;
PRINT DB_NAME () + ':  FN: ' + @fn;

SELECT
	  *
INTO
	[CT_view_EDW_HealthAssesmentALL_Data]
   FROM [dbo].[view_EDW_HealthAssesmentALL]
   WHERE
   [CT_CMS_User_UserID] IS NOT NULL
OR [CT_UserSettingsID] IS NOT NULL
OR [SiteID_CtID] IS NOT NULL
OR [UserSiteID_CtID] IS NOT NULL
OR [AccountID_CtID] IS NOT NULL
OR [HAUserAnswers_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserModule_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserQuestion_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserQuestionGroupResults_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserRiskArea_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserRiskCategory_CtID] IS NOT NULL
OR [HFit_HealthAssesmentUserStarted_CtID] IS NOT NULL;
GO
PRINT
	  DB_NAME () + ': Start 4: ' + CAST (GETDATE () AS NVarChar (100)) ;
GO