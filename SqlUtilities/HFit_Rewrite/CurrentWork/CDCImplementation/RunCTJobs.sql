
--Start CT Jobs

USE msdb ;
GO



EXEC dbo.sp_start_job N'job_EDW_GetStagingData_BioMetrics_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_Coaches_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_CoachingDefinition_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_CoachingDetail_KenticoCMS_Prod1' ;

EXEC dbo.sp_start_job N'job_EDW_GetStagingData_HA_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_HADefinition_KenticoCMS_Prod1' ;

EXEC dbo.sp_start_job N'job_EDW_GetStagingData_RewardAwardDetail_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_RewardsDefinition_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_RewardTriggerParameters_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_RewardUserDetail_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_RewardUserLevel_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_SmallSteps_KenticoCMS_Prod1' ;
EXEC dbo.sp_start_job N'job_EDW_GetStagingData_Trackers_KenticoCMS_Prod1' ;
