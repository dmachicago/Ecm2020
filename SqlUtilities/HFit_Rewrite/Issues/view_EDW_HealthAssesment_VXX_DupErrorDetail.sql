USE [KenticoCMS_PRD_1]
GO

SELECT count(*) as CNT, 
	HFit_HealthAssesmentUserQuestionGroupResults.[UserID]
      ,HFit_HealthAssesmentUserQuestionGroupResults.[PointResults]
     
	  --,HFit_HealthAssesmentUserQuestionGroupResults.[ItemCreatedWhen]
   --   ,HFit_HealthAssesmentUserQuestionGroupResults.[ItemModifiedWhen]
     
	  ,HFit_HealthAssesmentUserQuestionGroupResults.[ItemGUID]
      ,HFit_HealthAssesmentUserQuestionGroupResults.[HARiskAreaItemID]
      ,HFit_HealthAssesmentUserQuestionGroupResults.[CodeName]

	  --,HAUserRiskArea.ItemID 
		--,HAUserRiskArea.CodeName 
		--,HAUserRiskArea.HARiskAreaNodeGUID 
		--,HAUserRiskArea.HARiskAreaScore
		--,HAUserRiskArea.PreWeightedScore
		--,HAUserRiskArea.ItemModifiedWhen

  FROM [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] 
	JOIN HFit_HealthAssesmentUserRiskArea as HAUserRiskArea on HAUserRiskArea.ItemID = [HFit_HealthAssesmentUserQuestionGroupResults].HARiskAreaItemID
where HFit_HealthAssesmentUserQuestionGroupResults.UserID = 181007
  group by 
[HFit_HealthAssesmentUserQuestionGroupResults].[UserID]
      ,[HFit_HealthAssesmentUserQuestionGroupResults].[PointResults]
     
	  --,[HFit_HealthAssesmentUserQuestionGroupResults].[ItemCreatedWhen]
   --   ,[HFit_HealthAssesmentUserQuestionGroupResults].[ItemModifiedWhen]
     
	  ,[HFit_HealthAssesmentUserQuestionGroupResults].[ItemGUID]
      ,[HFit_HealthAssesmentUserQuestionGroupResults].[HARiskAreaItemID]
      ,[HFit_HealthAssesmentUserQuestionGroupResults].[CodeName]

	   --,HAUserRiskArea.ItemID 
		--,HAUserRiskArea.CodeName 
		--,HAUserRiskArea.HARiskAreaNodeGUID 
		--,HAUserRiskArea.HARiskAreaScore
		--,HAUserRiskArea.PreWeightedScore
		--,HAUserRiskArea.ItemModifiedWhen
having count(*) > 0
order by UserID, HFit_HealthAssesmentUserQuestionGroupResults.CodeName

select * from HFit_HealthAssesmentUserQuestionGroupResults
where UserID = 181007