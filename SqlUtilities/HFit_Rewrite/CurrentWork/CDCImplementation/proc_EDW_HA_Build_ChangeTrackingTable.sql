


declare @synchronization_version as int = CHANGE_TRACKING_CURRENT_VERSION();
declare @last_synchronization_version as int = 10 ; 

SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserAnswers' as TBL, * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserAnswers, @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'CMS_Class', * FROM CHANGETABLE(CHANGES dbo.CMS_Class , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'CMS_Document', * FROM CHANGETABLE(CHANGES dbo.CMS_Document , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'CMS_Site', * FROM CHANGETABLE(CHANGES dbo.CMS_Site , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'CMS_Tree', * FROM CHANGETABLE(CHANGES dbo.CMS_Tree , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'CMS_User', * FROM CHANGETABLE(CHANGES dbo.CMS_User , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'CMS_UserSettings', * FROM CHANGETABLE(CHANGES dbo.CMS_UserSettings , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'CMS_UserSite', * FROM CHANGETABLE(CHANGES dbo.CMS_UserSite , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'COM_SKU', * FROM CHANGETABLE(CHANGES dbo.COM_SKU , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_Account', * FROM CHANGETABLE(CHANGES dbo.HFit_Account , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HACampaign', * FROM CHANGETABLE(CHANGES dbo.HFit_HACampaign , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentMatrixQuestion', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentMatrixQuestion , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentMultipleChoiceQuestion', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentMultipleChoiceQuestion , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserAnswers', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserAnswers , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserModule', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserModule , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserQuestion', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserQuestion , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserQuestionGroupResults', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserQuestionGroupResults , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserRiskArea', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserRiskArea , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserRiskCategory', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserRiskCategory , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssesmentUserStarted', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssesmentUserStarted , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssessment', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssessment , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_HealthAssessmentFreeForm', * FROM CHANGETABLE(CHANGES dbo.HFit_HealthAssessmentFreeForm , @last_synchronization_version) AS CT
union 
SELECT @@SERVERNAME as  SVR, 'HFit_LKP_EDW_RejectMPI', * FROM CHANGETABLE(CHANGES dbo.HFit_LKP_EDW_RejectMPI , @last_synchronization_version) AS CT
