SELECT
	   *
	   FROM information_schema.columns
	   WHERE table_name = 'view_EDW_HealthAssesment'
		 AND column_name LIKE '%GUID%';

select count(*)  AS CNT, UserStartedItemID FROM view_EDW_HealthAssesment GROUP BY UserStartedItemID
select 'UserModuleItemId' as COL, count(*)  AS CNT, UserModuleItemId FROM view_EDW_HealthAssesment GROUP BY UserModuleItemId
select count(*)  AS CNT, UserRiskCategoryItemID FROM view_EDW_HealthAssesment GROUP BY UserRiskCategoryItemID
select 'UserRiskAreaItemID' as COL, count(*)  AS CNT, UserRiskAreaItemID FROM view_EDW_HealthAssesment GROUP BY UserRiskAreaItemID
select count(*)  AS CNT, UserQuestionItemID FROM view_EDW_HealthAssesment GROUP BY UserQuestionItemID
select count(*)  AS CNT, UserAnswerItemID FROM view_EDW_HealthAssesment GROUP BY UserAnswerItemID
select count(*)  AS CNT, AccountID FROM view_EDW_HealthAssesment GROUP BY AccountID
select count(*)  AS CNT, UserGUID FROM view_EDW_HealthAssesment GROUP BY UserGUID
select count(*)  AS CNT, HFitUserMpiNumber FROM view_EDW_HealthAssesment GROUP BY HFitUserMpiNumber

select count(*) 
	,UserStartedItemID
	,UserModuleItemId
	,UserRiskCategoryItemID
	,UserRiskAreaItemID
	,UserQuestionItemID
	,UserAnswerItemID
	,AccountID
	,UserGUID
	,HFitUserMpiNumber
FROM view_EDW_HealthAssesment
GROUP BY
	UserStartedItemID
	,UserModuleItemId
	,UserRiskCategoryItemID
	,UserRiskAreaItemID
	,UserQuestionItemID
	,UserAnswerItemID
	,AccountID
	,UserGUID
	,HFitUserMpiNumber
having count(*) > 1
--P3 = 150


SELECT
	   COUNT (*) 
	 , UserStartedItemID
	 , UserAnswerItemID
	 , HealthAssesmentUserStartedNodeGUID
	 , UserGUID
	 , SiteGUID
	 , HAModuleNodeGUID
	 , CMSNodeGuid
	 , HARiskCategoryNodeGUID
	 , HARiskAreaNodeGUID
	 , HAQuestionGuid
	 , HAQuestionNodeGUID
	 , HAAnswerNodeGUID
--, CampaignNodeGUID
	   FROM view_EDW_HealthAssesment
	   GROUP BY
				UserStartedItemID
			  , UserAnswerItemID
			  , HealthAssesmentUserStartedNodeGUID
			  , UserGUID
			  , SiteGUID
			  , HAModuleNodeGUID
			  , CMSNodeGuid
			  , HARiskCategoryNodeGUID
			  , HARiskAreaNodeGUID
			  , HAQuestionGuid
			  , HAQuestionNodeGUID
			  , HAAnswerNodeGUID
	   --, CampaignNodeGUID
	   HAVING COUNT (*) > 1;
--count 1417 P2
GO
SELECT
	   *
	   FROM view_EDW_HealthAssesment
	   WHERE UserStartedItemID = 21896
		 AND UserAnswerItemID = 6641768
		 AND HealthAssesmentUserStartedNodeGUID = 'ECBECCC1-14BF-4CCB-88A6-65FC640C5871'
		 AND UserGUID = '42AB489D-2BD4-4628-8A9E-976760F530E9'
		 AND SiteGUID = 'DD6E200A-62A7-4768-963B-71AB24AD7C93'
		 AND HAModuleNodeGUID = 'C1501F9B-C8B2-42C4-9764-B1B3FA76F9BA'
		 AND CMSNodeGuid = 'ECBECCC1-14BF-4CCB-88A6-65FC640C5871'
		 AND HARiskCategoryNodeGUID = 'D708AB45-D6CA-4706-B1EA-1D0961717F25'
		 AND HARiskAreaNodeGUID = '1237D0B7-2DDA-4187-8342-E97BDFE3DC86'
		 AND HAQuestionGuid = '688B3E1D-B677-414B-86B9-5F57E563AE6F'
		 AND HAQuestionNodeGUID = '688B3E1D-B677-414B-86B9-5F57E563AE6F'
		 AND HAAnswerNodeGUID = '86CEB5BF-BAAB-4F51-8FE1-6CD5683D2029'
		 AND CampaignNodeGUID = '4AEB9F30-41F9-47E4-8B78-1E6A202A8415';

/*****************************************
******************************************
*****************************************/

SELECT
	   COUNT (*) 
	 , UserStartedItemID
	 , HealthAssesmentUserStartedNodeGUID
	 , UserID
	 , UserGUID
	 , HFitUserMpiNumber
	 , SiteGUID
	 , AccountID
	 , AccountCD
	 , AccountName
	 , HAStartedDt
	 , HACompletedDt
	 , UserModuleItemId
	 , UserModuleCodeName
	 , HAModuleNodeGUID
	 , CMSNodeGuid
	 , HAModuleVersionID
	 , UserRiskCategoryItemID
	 , UserRiskCategoryCodeName
	 , HARiskCategoryNodeGUID
	 , HARiskCategoryVersionID
	 , UserRiskAreaItemID
	 , UserRiskAreaCodeName
	 , HARiskAreaNodeGUID
	 , HARiskAreaVersionID
	 , UserQuestionItemID
	 , Title
	 , HAQuestionGuid
	 , UserQuestionCodeName
	 , HAQuestionDocumentID
	 , HAQuestionVersionID
	 , HAQuestionNodeGUID
	 , UserAnswerItemID
	 , HAAnswerNodeGUID
	 , HAAnswerVersionID
	 , UserAnswerCodeName
	 , HAAnswerValue
	 , HAModuleScore
	 , HARiskCategoryScore
	 , HARiskAreaScore
	 , HAQuestionScore
	 , HAAnswerPoints
	 , PointResults
	 , UOMCode
	 , HAScore
	 , ModulePreWeightedScore
	 , RiskCategoryPreWeightedScore
	 , RiskAreaPreWeightedScore
	 , QuestionPreWeightedScore
	 , QuestionGroupCodeName
	 , ChangeType
	 , ItemCreatedWhen
	 , ItemModifiedWhen
	 , IsProfessionallyCollected
	 , HARiskCategory_ItemModifiedWhen
	 , HAUserRiskArea_ItemModifiedWhen
	 , HAUserQuestion_ItemModifiedWhen
	 , HAUserAnswers_ItemModifiedWhen
	 , HAPaperFlg
	 , HATelephonicFlg
	 , HAStartedMode
	 , HACompletedMode
	 , DocumentCulture_VHCJ
	 , DocumentCulture_HAQuestionsView
	 , CampaignNodeGUID
	   FROM view_EDW_HealthAssesment
	   GROUP BY
				UserStartedItemID
			  , HealthAssesmentUserStartedNodeGUID
			  , UserID
			  , UserGUID
			  , HFitUserMpiNumber
			  , SiteGUID
			  , AccountID
			  , AccountCD
			  , AccountName
			  , HAStartedDt
			  , HACompletedDt
			  , UserModuleItemId
			  , UserModuleCodeName
			  , HAModuleNodeGUID
			  , CMSNodeGuid
			  , HAModuleVersionID
			  , UserRiskCategoryItemID
			  , UserRiskCategoryCodeName
			  , HARiskCategoryNodeGUID
			  , HARiskCategoryVersionID
			  , UserRiskAreaItemID
			  , UserRiskAreaCodeName
			  , HARiskAreaNodeGUID
			  , HARiskAreaVersionID
			  , UserQuestionItemID
			  , Title
			  , HAQuestionGuid
			  , UserQuestionCodeName
			  , HAQuestionDocumentID
			  , HAQuestionVersionID
			  , HAQuestionNodeGUID
			  , UserAnswerItemID
			  , HAAnswerNodeGUID
			  , HAAnswerVersionID
			  , UserAnswerCodeName
			  , HAAnswerValue
			  , HAModuleScore
			  , HARiskCategoryScore
			  , HARiskAreaScore
			  , HAQuestionScore
			  , HAAnswerPoints
			  , PointResults
			  , UOMCode
			  , HAScore
			  , ModulePreWeightedScore
			  , RiskCategoryPreWeightedScore
			  , RiskAreaPreWeightedScore
			  , QuestionPreWeightedScore
			  , QuestionGroupCodeName
			  , ChangeType
			  , ItemCreatedWhen
			  , ItemModifiedWhen
			  , IsProfessionallyCollected
			  , HARiskCategory_ItemModifiedWhen
			  , HAUserRiskArea_ItemModifiedWhen
			  , HAUserQuestion_ItemModifiedWhen
			  , HAUserAnswers_ItemModifiedWhen
			  , HAPaperFlg
			  , HATelephonicFlg
			  , HAStartedMode
			  , HACompletedMode
			  , DocumentCulture_VHCJ
			  , DocumentCulture_HAQuestionsView
			  , CampaignNodeGUID
	   HAVING COUNT (*) > 1;
--1417
SELECT
	   COUNT (*) 
	   FROM view_EDW_HealthAssesment;