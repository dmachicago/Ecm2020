

GO

select 
	HFit_HealthAssesmentUserStarted.ItemID AS UserStartedItemID
	,HFit_HealthAssesmentUserStarted.UserID
	,HFit_HealthAssesmentUserStarted.HAStartedDt
	,HFit_HealthAssesmentUserStarted.HACompletedDt
	,HFit_HealthAssesmentUserStarted.HAScore
	,CMS_User.UserGUID

from HFit_HealthAssesmentUserStarted
	INNER JOIN dbo.CMS_User ON HFit_HealthAssesmentUserStarted.UserID = CMS_User.UserID  --  
  --  
GO 
print('***** FROM: HealthAssesmentRewrite.sql'); 
GO 
