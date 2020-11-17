
SELECT
	  [CT].[UserID]
  FROM CHANGETABLE (CHANGES [BASE_CMS_User] , NULL) AS [CT];
SELECT
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_HealthAssesmentUserQuestionGroupResults] , NULL) AS [CT];
SELECT
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_HealthAssesmentUserRiskCategory] , NULL) AS [CT];
SELECT
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_HealthAssesmentUserModule] , NULL) AS [CT];
--select * from CT_HFit_HealthAssesmentUserModule ;
SELECT
	  [CT].[SiteID]
  FROM CHANGETABLE (CHANGES [BASE_CMS_Site] , NULL) AS [CT];
SELECT
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_HealthAssesmentUserRiskArea] , NULL) AS [CT];
SELECT
	  [CT].[UserSiteID]
  FROM CHANGETABLE (CHANGES [BASE_CMS_UserSite] , NULL) AS [CT];
SELECT
	  [CT].[UserSettingsID]
  FROM CHANGETABLE (CHANGES [BASE_CMS_UserSettings] , NULL) AS [CT];
SELECT
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_HealthAssesmentUserQuestion] , NULL) AS [CT];
SELECT
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_HealthAssesmentUserAnswers] , NULL) AS [CT];
SELECT
	  [CT].[AccountID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_Account] , NULL) AS [CT];
SELECT
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES [BASE_HFit_HealthAssesmentUserStarted] , NULL) AS [CT];