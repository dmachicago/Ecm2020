USE msdb
GO
SELECT DISTINCT SJ.Name AS JobName, SJ.description AS JobDescription,
SJH.run_date AS LastRunDate, 
CASE SJH.run_status 
WHEN 0 THEN 'Failed'
WHEN 1 THEN 'Successful'
WHEN 3 THEN 'Cancelled'
WHEN 4 THEN 'In Progress'
END AS LastRunStatus,
'EXEC msdb..sp_start_job "'+SJ.Name+'" ' as CMD
FROM sysjobhistory SJH, sysjobs SJ
WHERE SJH.job_id = SJ.job_id and SJH.run_date = 
(SELECT MAX(SJH1.run_date) FROM sysjobhistory SJH1 WHERE SJH.job_id = SJH1.job_id)
and SJH.run_status = 0 
ORDER BY SJH.run_date desc

EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingAuditLog_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_hfit_CoachingCMTemporalContainer_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingCommitToQuit_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingEnrollmentSettings_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingEnrollmentSyncStaging_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingEvalHARiskArea_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingEvalHARiskCategory_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingEvalHARiskModule_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingHealthActionPlan_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingLibraryHealthArea_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingLibraryResource_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingLibraryResources_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingLMTemporalContainer_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingMyGoalsSettings_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingMyHealthInterestsSettings_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingNotAssignedSettings_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingPrivacyPolicy_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingSessionCompleted_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_Hfit_CoachingSystemSettings_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingTermsAndConditionsSettings_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_Hfit_CoachingUserCMCondition_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_Hfit_CoachingUserCMExclusion_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_CoachingWelcomeSettings_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_Configuration_CallLogCoaching_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFIT_Configuration_CMCoaching_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFIT_Configuration_HACoaching_KenticoCMS_3_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_Configuration_LMCoaching_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingAuditLogType_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingCMConditions_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingCMExclusions_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingOptOutReason_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingServiceLevel_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachingServiceLevelStatus_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_LKP_CoachViewTimeZone_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_Staging_Coach_KenticoCMS_1_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_BASE_HFit_Staging_Coach_KenticoCMS_2_ApplyCT" 
EXEC msdb.dbo.sp_start_job "job_proc_HFit_CoachingHealthArea_KenticoCMS_1" 
EXEC msdb.dbo.sp_start_job "job_proc_HFit_CoachingHealthArea_KenticoCMS_2" 
EXEC msdb.dbo.sp_start_job "job_proc_HFit_CoachingHealthArea_KenticoCMS_3" 
EXEC msdb.dbo.sp_start_job "job_proc_HFit_CoachingHealthInterest_KenticoCMS_1" 
EXEC msdb.dbo.sp_start_job "job_proc_HFit_CoachingHealthInterest_KenticoCMS_2" 
EXEC msdb.dbo.sp_start_job "job_proc_HFit_CoachingHealthInterest_KenticoCMS_3" 
EXEC msdb.dbo.sp_start_job "job_PROC_SYnC_View_HFit_Coach_Bio" 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
