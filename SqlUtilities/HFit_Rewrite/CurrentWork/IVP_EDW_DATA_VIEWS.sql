

GO
Print ('***********************************************') ;
Print ('Starting the EDW DATA Views IVP: ' + cast(getdate() as nvarchar(50))) ;
Print ('***********************************************') ;
go
--select 'exec IVP_DataValidation ''' + name + ''';' + char(10) + char(13) +'GO'  from sys.views where name like '%EDW%' order by name;
exec IVP_DataValidation 'view_EDW_Awards';

GO
exec IVP_DataValidation 'view_EDW_BioMetrics';

GO
exec IVP_DataValidation 'view_EDW_BiometricViewRejectCriteria';

GO
exec IVP_DataValidation 'view_EDW_ClientCompany';

GO
exec IVP_DataValidation 'view_EDW_Coaches';

GO
exec IVP_DataValidation 'view_EDW_CoachingDefinition';

GO
exec IVP_DataValidation 'view_EDW_CoachingDetail';

--GO
--exec IVP_DataValidation 'view_EDW_EDW_TEST_DEL_DelAudit';

GO
exec IVP_DataValidation 'view_EDW_Eligibility';

GO
exec IVP_DataValidation 'view_EDW_EligibilityHistory';

GO
exec IVP_DataValidation 'view_EDW_HealthAssesment';

GO
exec IVP_DataValidation 'View_EDW_HealthAssesmentAnswers';

GO
exec IVP_DataValidation 'view_EDW_HealthAssesmentClientView';

GO
exec IVP_DataValidation 'view_EDW_HealthAssesmentDeffinition';

GO
exec IVP_DataValidation 'view_EDW_HealthAssesmentDeffinitionCustom';

GO
exec IVP_DataValidation 'View_EDW_HealthAssesmentQuestions';

GO
exec IVP_DataValidation 'view_EDW_HealthAssessment_Staged';

GO
exec IVP_DataValidation 'view_EDW_HealthAssessmentDefinition_Staged';

GO
exec IVP_DataValidation 'view_EDW_HealthInterestDetail';

GO
exec IVP_DataValidation 'view_EDW_HealthInterestList';

GO
exec IVP_DataValidation 'view_EDW_Participant';

GO
exec IVP_DataValidation 'view_EDW_RewardAwardDetail';

GO
exec IVP_DataValidation 'View_EDW_RewardProgram_Joined';

GO
exec IVP_DataValidation 'view_EDW_RewardsDefinition';

GO
exec IVP_DataValidation 'view_EDW_RewardTriggerParameters';

GO
exec IVP_DataValidation 'view_EDW_RewardUserDetail';

GO
exec IVP_DataValidation 'view_EDW_RewardUserLevel';

GO
exec IVP_DataValidation 'view_EDW_ScreeningsFromTrackers';

GO
exec IVP_DataValidation 'view_EDW_SmallStepResponses';

GO
exec IVP_DataValidation 'view_EDW_TrackerCompositeDetails';

GO
exec IVP_DataValidation 'view_EDW_TrackerMetadata';

GO
exec IVP_DataValidation 'view_EDW_TrackerShots';

GO
exec IVP_DataValidation 'view_EDW_TrackerTests';

GO
Print ('***********************************************') ;
Print ('ENDING the EDW DATA Views IVP: ' + cast(getdate() as nvarchar(50))) ;
Print ('***********************************************') ;

GO
