
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_Awards';
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerShots' ;
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerTests' ;
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_BioMetrics' ;
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_CoachingDetail';
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_ClientCompany';
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_Coaches';
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_CoachingDefinition';
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerMetadata'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthInterestDetail'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthInterestList'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_ScreeningsFromTrackers'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_SmallStepResponses'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_Participant'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'View_EDW_HealthAssesmentQuestions'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_TrackerCompositeDetails'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_EligibilityHistory'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'View_EDW_HealthAssesmentAnswers'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_CoachingPPTEnrolled'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_CoachingPPTEligible'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthAssesmentClientView'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_RewardAwardDetail'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthAssesmentDeffinition'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'View_EDW_RewardProgram_Joined'; 
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthAssesment'; 

update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_RewardUserLevel';
update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_HealthAssesmentDeffinitionCustom';  

update HFit_EDW_K7K8_TestDDL set Passed = 0 where VIEW_NAME = 'view_EDW_Eligibility';
update HFit_EDW_K7K8_TestDDL set Passed = 0 where VIEW_NAME = 'view_EDW_RewardTriggerParameters'; 
update HFit_EDW_K7K8_TestDDL set Passed = 0 where VIEW_NAME = 'view_EDW_RewardsDefinition'; 
update HFit_EDW_K7K8_TestDDL set Passed = 0 where VIEW_NAME = 'view_EDW_RewardUserDetail'; 


--select TABLE_NAME from information_schema.tables where table_name like 'test_%'
--update HFit_EDW_K7K8_TestDDL set Passed = null where Passed = 0 ;
select * from HFit_EDW_K7K8_TestDDL order by passed, view_name desc;

