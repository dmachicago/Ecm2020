
IF OBJECT_ID('tempdb..#TEMP_EDW_HA_NoDistinct') IS NULL 
	BEGIN
		drop table tempdb..#TEMP_EDW_HA_NoDistinct
	END
IF OBJECT_ID('tempdb..#TEMP_EDW_HA_NoDistinct') IS NULL 
	BEGIN
		drop table tempdb..#TEMP_EDW_HA_Distinct
	END

--drop table #TEMP_EDW_HA_NoDistinct
--drop table TEMP_EDW_HA_Distinct

Select * 
--into #TEMP_EDW_HA_NoDistinct
from view_EDW_HealthAssesment
go

alter table TEMP_EDW_HA_NoDistinct add IDCOL int identity (1,1) 
GO


select count(*) from TEMP_EDW_HA_NoDistinct
go

--Check for duplicate records
SELECT COUNT(*) TotalCount, [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ChangeType]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[IsProfessionallyCollected]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
      --,[HAPaperFlg]
      --,[HATelephonicFlg]
  FROM TEMP_EDW_HA_NoDistinct
  GROUP BY [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ChangeType]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[IsProfessionallyCollected]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
      --,[HAPaperFlg]
      --,[HATelephonicFlg]
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC

select count(*) from TEMP_EDW_HA_NoDistinct

DELETE FROM TEMP_EDW_HA_NoDistinct
WHERE IDCOL NOT IN
(
SELECT MAX(IDCOL)
FROM TEMP_EDW_HA_NoDistinct
GROUP BY [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ChangeType]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[IsProfessionallyCollected]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
      --,[HAPaperFlg]
      --,[HATelephonicFlg]
)


Select * from TEMP_EDW_HA_NoDistinct
where [UserStartedItemID] = 18978
and HealthAssesmentUserStartedNodeGUID = '45F40CD2-B2C7-46E3-BDC2-F072B4727C23'
and userID = 29269
and HFitUserMpiNumber = 6238125
and [UserRiskCategoryCodeName] = 'TotalCholesterol'
and [UserRiskCategoryItemID] = 100178
and HAQuestionGuid = 'A9569762-D775-4593-8C7B-3A4AC5FD3F3A'