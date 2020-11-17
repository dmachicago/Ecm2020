if exists (select name from sys.views where name = 'view_EDW_EDW_TEST_DEL_DelAudit')
BEGIN
drop view view_EDW_EDW_TEST_DEL_DelAudit 
END
go

EXEC sp_refreshview view_EDW_SmallStepResponses ; 
--EXEC sp_refreshview view_EDW_EDW_TEST_DEL_DelAudit ; 
EXEC sp_refreshview view_EDW_HealthAssesment ; 
EXEC sp_refreshview view_EDW_CoachingDetail ; 
EXEC sp_refreshview view_EDW_HealthAssesmentDeffinition ; 
EXEC sp_refreshview view_EDW_RewardUserDetail ; 
EXEC sp_refreshview view_EDW_RewardsDefinition ; 
EXEC sp_refreshview view_EDW_BiometricViewRejectCriteria ; 
EXEC sp_refreshview view_EDW_BioMetrics ; 
EXEC sp_refreshview view_EDW_TrackerCompositeDetails ; 
EXEC sp_refreshview view_EDW_ClientCompany ; 
EXEC sp_refreshview view_EDW_HealthInterestDetail ; 
EXEC sp_refreshview view_EDW_Coaches ; 
EXEC sp_refreshview view_EDW_HealthInterestList ; 
EXEC sp_refreshview View_EDW_HealthAssesmentAnswers ; 
EXEC sp_refreshview View_EDW_HealthAssesmentQuestions ; 
EXEC sp_refreshview view_EDW_HealthAssesmentDeffinitionCustom ; 
EXEC sp_refreshview view_EDW_HealthAssessmentDefinition_Staged ; 
EXEC sp_refreshview view_EDW_HealthAssessment_Staged ; 
EXEC sp_refreshview view_EDW_Participant ; 
EXEC sp_refreshview view_EDW_CoachingDefinition ; 
EXEC sp_refreshview view_EDW_ScreeningsFromTrackers ; 
EXEC sp_refreshview view_EDW_TrackerMetadata ; 
EXEC sp_refreshview view_EDW_TrackerShots ; 
EXEC sp_refreshview view_EDW_TrackerTests ; 
EXEC sp_refreshview view_EDW_RewardAwardDetail ; 
EXEC sp_refreshview view_EDW_RewardTriggerParameters ; 
EXEC sp_refreshview view_EDW_RewardUserLevel ; 
EXEC sp_refreshview view_EDW_HealthAssesmentClientView ; 
EXEC sp_refreshview view_EDW_Awards ; 
EXEC sp_refreshview View_EDW_RewardProgram_Joined ; 
EXEC sp_refreshview view_EDW_EligibilityHistory ; 
EXEC sp_refreshview view_EDW_Eligibility ; 

drop view view_EDW_EDW_TEST_DEL_DelAudit 