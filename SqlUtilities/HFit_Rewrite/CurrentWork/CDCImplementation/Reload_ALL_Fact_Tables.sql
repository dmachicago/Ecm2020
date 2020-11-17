
select 'PRINT ' + name + char(10) + ' GO ' + char(10) + 'EXEC ' + name + ' 0,1;' + char(10) + 'go'  from sys.procedures where name like '%_SYNC' and name like 'Proc_BASE_%'


PRINT proc_BASE_CMS_Class_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_CMS_Class_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_CMS_Document_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_CMS_Document_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_CMS_Site_KenticoCMS_1_SYNC
 GO 

EXEC proc_BASE_CMS_Site_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_CMS_Tree_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_CMS_Tree_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_cms_user_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_cms_user_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_cms_usersettings_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_cms_usersettings_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_cms_usersite_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_cms_usersite_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_Account_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_Account_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_CoachingHealthArea_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_CoachingHealthArea_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_CoachingHealthInterest_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HACampaign_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HACampaign_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HealthAssesmentModule_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HealthAssesmentRiskArea_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_SYNC 0,1;
go
PRINT proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_1_SYNC
 GO 
EXEC proc_BASE_HFit_HealthAssesmentUserModule_KenticoCMS_1_SYNC 0,1;
go