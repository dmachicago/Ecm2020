exec proc_CreateBaseTable 'KenticoCMS_1', 'EDW_RoleMembership', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'EDW_HealthAssessmentDefinition', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_HealthAssesmentThresholdGrouping', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_PPTStatusIpadMappingCodeCleanup', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_HealthAssessmentDataForMissingResponses', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'Hfit_HAHealthCheckLog', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_RewardsUserSummaryArchive', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_RewardsAwardUserDetailArchive', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_PPTStatusEnum', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'EDW_GroupMemberToday', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_PPTStatus', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_PostSubscriber_ContactMap', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_PPTStatus_CR27070', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'HFit_PostSubscriber_ContactBackup', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'EDW_PerformanceMeasure', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'EDW_HealthAssessment', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'Hfit_HealthAssessmentDataForImport', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'RPT_CoachingFromPortal', @SkipIfExists = 0 ;
GO
--wdm
exec proc_CreateBaseTable 'KenticoCMS_1', 'coachExclusion', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_1', 'EDW_RoleMemberToday', @SkipIfExists = 0 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_PPTStatus_CR27070', @SkipIfExists = 1 ;
GO
--wdm
exec proc_CreateBaseTable 'KenticoCMS_2', 'coachExclusion', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'EDW_PerformanceMeasure', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'EDW_HealthAssessment', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'EDW_HealthAssessmentDefinition', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_PPTStatusIpadMappingCodeCleanup', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'RPT_CoachingFromPortal', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'EDW_RoleMemberToday', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'EDW_RoleMembership', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_RewardsUserSummaryArchive', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_RewardsAwardUserDetailArchive', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_HealthAssessmentDataForMissingResponses', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_PostSubscriber_ContactMap', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_PostSubscriber_ContactBackup', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_PPTStatusEnum', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_PPTStatus', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'Hfit_HAHealthCheckLog', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'Hfit_HealthAssessmentDataForImport', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'EDW_GroupMemberToday', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_2', 'HFit_HealthAssesmentThresholdGrouping', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'EDW_RoleMemberToday', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'EDW_RoleMembership', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_PostSubscriber_ContactMap', @SkipIfExists = 1 ;
GO
--wdm
exec proc_CreateBaseTable 'KenticoCMS_3', 'coachExclusion', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_PostSubscriber_ContactBackup', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_PPTStatusEnum', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_PPTStatus', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_RewardsAwardUserDetailArchive', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'EDW_GroupMemberToday', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'Hfit_HealthAssessmentDataForImport', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'EDW_PerformanceMeasure', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'EDW_HealthAssessment', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_PPTStatus_CR27070', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_HealthAssessmentDataForMissingResponses', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'EDW_HealthAssessmentDefinition', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'Hfit_HAHealthCheckLog', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'RPT_CoachingFromPortal', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_RewardsUserSummaryArchive', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_PPTStatusIpadMappingCodeCleanup', @SkipIfExists = 1 ;
GO
exec proc_CreateBaseTable 'KenticoCMS_3', 'HFit_HealthAssesmentThresholdGrouping', @SkipIfExists = 1 ;
GO
