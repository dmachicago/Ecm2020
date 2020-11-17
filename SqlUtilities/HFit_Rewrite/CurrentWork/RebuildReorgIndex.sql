--Gen REBUILD statements
SELECT 'Alter Index ' + SI.name + ' ON ' + object_name(IPS.object_id) + ' REBUILD; ' as CMD, 
   IPS.Index_type_desc, 
   IPS.avg_fragmentation_in_percent, 
   IPS.avg_fragment_size_in_pages, 
   cast (IPS.avg_page_space_used_in_percent as decimal (5,2)) as avg_page_space_used_in_percent, 
   IPS.record_count, 
   IPS.ghost_record_count,
   IPS.fragment_count, 
   IPS.avg_fragment_size_in_pages
FROM sys.dm_db_index_physical_stats(db_id(N'DEV'), NULL, NULL, NULL , 'DETAILED') IPS
   JOIN sys.tables ST WITH (nolock) ON IPS.object_id = ST.object_id
   JOIN sys.indexes SI WITH (nolock) ON IPS.object_id = SI.object_id AND IPS.index_id = SI.index_id
WHERE ST.is_ms_shipped = 0 and IPS.avg_fragmentation_in_percent >= 40
ORDER BY IPS.avg_fragmentation_in_percent desc
go

--Gen Reorg statements
SELECT 'Alter Index ' + SI.name + ' ON ' + object_name(IPS.object_id) + ' REORGANIZE; ' as CMD, 
   IPS.Index_type_desc, 
   IPS.avg_fragmentation_in_percent, 
   IPS.avg_fragment_size_in_pages, 
   cast (IPS.avg_page_space_used_in_percent as decimal (5,2)) as avg_page_space_used_in_percent, 
   IPS.record_count, 
   IPS.ghost_record_count,
   IPS.fragment_count, 
   IPS.avg_fragment_size_in_pages
FROM sys.dm_db_index_physical_stats(db_id(N'DEV'), NULL, NULL, NULL , 'DETAILED') IPS
   JOIN sys.tables ST WITH (nolock) ON IPS.object_id = ST.object_id
   JOIN sys.indexes SI WITH (nolock) ON IPS.object_id = SI.object_id AND IPS.index_id = SI.index_id
WHERE ST.is_ms_shipped = 0 
	and IPS.avg_fragmentation_in_percent >= 10
	and IPS.avg_fragmentation_in_percent < 40
ORDER BY IPS.avg_fragmentation_in_percent desc
go

SELECT object_name(IPS.object_id) AS [TableName], 
   SI.name AS [IndexName], 
   IPS.Index_type_desc, 
   IPS.avg_fragmentation_in_percent, 
   IPS.avg_fragment_size_in_pages, 
   cast (IPS.avg_page_space_used_in_percent as decimal (5,2)) as avg_page_space_used_in_percent, 
   IPS.record_count, 
   IPS.ghost_record_count,
   IPS.fragment_count, 
   IPS.avg_fragment_size_in_pages
FROM sys.dm_db_index_physical_stats(db_id(N'DEV'), NULL, NULL, NULL , 'DETAILED') IPS
   JOIN sys.tables ST WITH (nolock) ON IPS.object_id = ST.object_id
   JOIN sys.indexes SI WITH (nolock) ON IPS.object_id = SI.object_id AND IPS.index_id = SI.index_id
WHERE ST.is_ms_shipped = 0 and IPS.avg_fragmentation_in_percent >= 10
ORDER BY 1,5
go

UPDATE STATISTICS Analytics_HourHits WITH FULLSCAN, ALL

select 'UPDATE STATISTICS ' + name + ' WITH FULLSCAN, ALL' from sys.tables where type = 'u'

GO
--If an index is very small (I believe less than 8 pages) it will use mixed extents. 
--Therefore, it'll appear as if there is still fragmentation remaining, as the housing 
--extent will contain pages from multiple indexes.
--Because of this, and also the fact that in such a small index that fragmentation is 
--typically negligable, you really should only be rebuilding indexes with a certain page 
--threshold. It is best practices to rebuild fragmented indexes that are a minimum of 1000 pages.


--EXEC sp_updatestats; 

Alter Index PK_Analytics_HourHits ON Analytics_HourHits rebuild;
GO
Alter Index IX_Analytics_HourHits_HitsStatisticsID ON Analytics_HourHits rebuild;
GO
Alter Index IX_CMS_ObjectVersionHistory_VersionModifiedByUserID ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index PK_CMS_UserSettings ON CMS_UserSettings rebuild;
GO
Alter Index PK_CMS_ObjectVersionHistory ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index IX_Analytics_HourHits_HitsStartTime_HitsEndTime ON Analytics_HourHits rebuild;
GO
Alter Index IX_CMS_Class_ClassID_ClassName_ClassDisplayName ON CMS_Class rebuild;
GO
Alter Index IX_CMS_DocumentAlias_AliasURLPath ON CMS_DocumentAlias rebuild;
GO

Alter Index PK_HFit_PPTEligibility ON HFit_PPTEligibility rebuild;
GO
Alter Index PK_CMS_User ON CMS_User rebuild;
GO
Alter Index PK_HFit_Blurb ON HFit_Blurb rebuild;
GO
Alter Index PK_HFit_StagingEligibility ON HFit_StagingEligibility rebuild;
GO
Alter Index IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName ON CMS_MetaFile rebuild;
GO
Alter Index IX_CMS_DocumentAlias_AliasURLPath ON CMS_DocumentAlias rebuild;
GO
Alter Index PK_CMS_Document ON CMS_Document rebuild;
GO
Alter Index IX_Analytics_DayHits_HitsStatisticsID ON Analytics_DayHits rebuild;
GO
Alter Index PK_HFit_Staging_Blurb ON HFit_Staging_Blurb rebuild;
GO
Alter Index PK_DDLEvents ON DDLEvents rebuild;
GO
Alter Index PK_HFit_TrackerSummary ON HFit_TrackerSummary rebuild;
GO
Alter Index idx_HFitTrackerSummary_WeekendDate ON HFit_TrackerSummary rebuild;
GO
Alter Index IX_CMS_Transformation_TransformationClassID_TransformationName ON CMS_Transformation rebuild;
GO
Alter Index IX_OM_Contact_ContactLastName ON OM_Contact rebuild;
GO
Alter Index PK_CMS_ContactGroup ON OM_ContactGroup rebuild;
GO
Alter Index PK_OM_Contact ON OM_Contact rebuild;
GO
Alter Index PK_CMS_Layout ON CMS_Layout rebuild;
GO
Alter Index IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index PK_CMS_ObjectWorkflowTrigger ON CMS_ObjectWorkflowTrigger rebuild;
GO
Alter Index PK_CMS_TemplateDeviceLayout ON CMS_TemplateDeviceLayout rebuild;
GO
Alter Index IX_CMS_Tree_NodeID ON CMS_Tree rebuild;
GO
Alter Index PK_HFit_ChallengeRegistrationEmail ON HFit_ChallengeRegistrationEmail rebuild;
GO
Alter Index PK_HFit_HealthAssessment ON HFit_HealthAssessment rebuild;
GO
Alter Index PK_HFit_LKP_TrackerCardioActivity ON HFit_LKP_TrackerCardioActivity rebuild;
GO
Alter Index PK_HFit_RewardLevel ON HFit_RewardLevel rebuild;
GO
Alter Index PK_HFit_Screening_QST ON HFit_Screening_QST rebuild;
GO
Alter Index idx_HFitTrackerSummary_UserID ON HFit_TrackerSummary rebuild;
GO

--Alter Index NULL ON HFit_UserGoal_back rebuild;
--GO
Alter Index PK_hfit_ChallengeTeams ON hfit_ChallengeTeams rebuild;
GO
Alter Index PK_HFit_LoginPageSettings ON HFit_LoginPageSettings rebuild;
GO
Alter Index PK_AuditObjects ON AuditObjects rebuild;
GO
Alter Index IX_CMS_ACL_ACLInheritedACLs ON CMS_ACL rebuild;
GO
Alter Index PK_CMS_AllowedChildClasses ON CMS_AllowedChildClasses rebuild;
GO
Alter Index PK_CMS_Country ON CMS_Country rebuild;
GO
Alter Index PK_CMS_Culture ON CMS_Culture rebuild;
GO
Alter Index IX_CMS_Culture_CultureCode ON CMS_Culture rebuild;
GO
Alter Index IX_CMS_CulturAlias ON CMS_Culture rebuild;
GO
Alter Index IX_CMS_InlineControl_ControlDisplayName ON CMS_InlineControl rebuild;
GO

--Alter Index PK_DataSync.CMS_LicenseKey_dss_tracking ON CMS_LicenseKey_dss_tracking rebuild;
--GO

Alter Index IX_CMS_ObjectSettings_ObjectSettingsObjectType_ObjectSettingsObjectID ON CMS_ObjectSettings rebuild;
GO
Alter Index PK_CMS_ObjectVersionHistory_1 ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen ON CMS_ObjectVersionHistory rebuild;
GO
Alter Index IX_CMS_Resource_ResourceDisplayName ON CMS_Resource rebuild;
GO
Alter Index PK_CMS_ResourceSite ON CMS_ResourceSite rebuild;
GO
Alter Index PK_CMS_ScheduledTask ON CMS_ScheduledTask rebuild;
GO
Alter Index IX_CMS_SearchIndex_IndexDisplayName ON CMS_SearchIndex rebuild;
GO
Alter Index PK_CMS_SettingsCategory ON CMS_SettingsCategory rebuild;
GO
Alter Index IX_CMS_TagGroup_TagGroupDisplayName ON CMS_TagGroup rebuild;
GO
Alter Index PK_CMS_WebPartCategory ON CMS_WebPartCategory rebuild;
GO
Alter Index IX_CMS_WebPartCategory_CategoryParentID_CategoryOrder ON CMS_WebPartCategory rebuild;
GO
Alter Index IX_CMS_WebPartContainer_ContainerDisplayName ON CMS_WebPartContainer rebuild;
GO
Alter Index PK_CMS_Widget ON CMS_Widget rebuild;
GO
Alter Index IX_CMS_Widget_WidgetWebPartID ON CMS_Widget rebuild;
GO
Alter Index IX_CMS_Widget_WidgetIsEnabled_WidgetForGroup_WidgetForEditor_WidgetForUser ON CMS_Widget rebuild;
GO
Alter Index PK_CMS_WorkflowStep ON CMS_WorkflowStep rebuild;
GO
Alter Index IX_CMS_WorkflowStep_StepWorkflowID_StepName ON CMS_WorkflowStep rebuild;
GO
Alter Index IX_CMS_WorkflowStep_StepWorkflowID_StepOrder ON CMS_WorkflowStep rebuild;
GO
Alter Index IX_Community_Group_GroupCreatedByUserID ON Community_Group rebuild;
GO
Alter Index IX_Community_Group_GroupApprovedByUserID ON Community_Group rebuild;
GO
Alter Index IX_Community_Group_GroupAvatarID ON Community_Group rebuild;
GO
Alter Index IX_Community_Group_GroupApproved ON Community_Group rebuild;
GO
Alter Index PK_Community_Group ON Community_Group rebuild;
GO
Alter Index PK_HFit_Calculator ON HFit_Calculator rebuild;
GO

Alter Index PK_hfit_challenge ON hfit_challenge rebuild;
GO
Alter Index PK_hfit_ChallengeTeam ON hfit_ChallengeTeam rebuild;
GO
Alter Index PK_HFit_ClientContact ON HFit_ClientContact rebuild;
GO
Alter Index PK_HFit_ClientSecurityQuestions ON HFit_ClientSecurityQuestions rebuild;
GO
Alter Index PK_HFit_CoachingGetStarted ON HFit_CoachingGetStarted rebuild;
GO
Alter Index PK_HFit_CoachingHealthActionPlan ON HFit_CoachingHealthActionPlan rebuild;
GO
Alter Index PK_HFit_CoachingLibraryHealthArea ON HFit_CoachingLibraryHealthArea rebuild;
GO
Alter Index PK_HFit_CoachingLibraryResources ON HFit_CoachingLibraryResources rebuild;
GO
Alter Index PK_HFit_CoachingLibrarySettings ON HFit_CoachingLibrarySettings rebuild;
GO
Alter Index PK__HFit_Coa__3214EC2770041C20 ON HFit_CoachingSessionCompleted rebuild;
GO
Alter Index PK_Hfit_CoachingSystemSettings ON Hfit_CoachingSystemSettings rebuild;
GO
Alter Index PK_Hfit_CoachingUserCMCondition ON Hfit_CoachingUserCMCondition rebuild;
GO
Alter Index IDX_ConfigGroupToFeatures_ConfigFeatureID ON HFit_configGroupToFeature rebuild;
GO
Alter Index IDX_FeaturesToGroups_ContactGroupMembershipID ON HFit_configGroupToFeature rebuild;
GO
Alter Index IDX_ConfigGroupToFeatures_SiteID ON HFit_configGroupToFeature rebuild;
GO
Alter Index PK_HFit_ConsentAndReleaseAgreement ON HFit_ConsentAndReleaseAgreement rebuild;
GO
Alter Index PK_HFit_ContactGroupMembership ON HFit_ContactGroupMembership rebuild;
GO
Alter Index PK_HFit_ContactGroupSyncExclude ON HFit_ContactGroupSyncExclude rebuild;
GO
Alter Index PK_HFit_Event ON HFit_Event rebuild;
GO
Alter Index PK_HFit_HealthAssesmentRiskArea ON HFit_HealthAssesmentRiskArea rebuild;
GO
Alter Index idx_ThresholdTypeID ON HFit_HealthAssesmentThresholds rebuild;
GO
Alter Index Ref65 ON HFit_HealthAssesmentThresholds rebuild;
GO
Alter Index PK_HFit_HealthAssessmentHDLScoring ON HFit_HealthAssessmentHDLScoring rebuild;
GO
Alter Index PK_HFit_HealthAssessmentModuleConfiguration ON HFit_HealthAssessmentModuleConfiguration rebuild;
GO
Alter Index PK_HFit_HSHealthMeasuresSettings ON HFit_HSHealthMeasuresSettings rebuild;
GO
Alter Index PK_HFit_MockMpiData ON HFit_MockMpiData rebuild;
GO
Alter Index PK_Hfit_MyHealthSettings ON Hfit_MyHealthSettings rebuild;
GO
Alter Index PK_HFit_RegistrationWelcome ON HFit_RegistrationWelcome rebuild;
GO
Alter Index PK_HFit_RewardDefaultSettings ON HFit_RewardDefaultSettings rebuild;
GO
Alter Index PK_HFit_RewardException ON HFit_RewardException rebuild;
GO
Alter Index PK_HFit_RewardProgram ON HFit_RewardProgram rebuild;
GO
Alter Index PK_HFit_Tobacco_Goal ON HFit_Tobacco_Goal rebuild;
GO
Alter Index PK_HFit_TrackerHighSodiumFoods ON HFit_TrackerHighSodiumFoods rebuild;
GO
Alter Index PK_HFit_TrackerMedicalCarePlan ON HFit_TrackerMedicalCarePlan rebuild;
GO
Alter Index PK_HFit_TrackerSitLess ON HFit_TrackerSitLess rebuild;
GO
Alter Index PK_HFit_TrackerStress ON HFit_TrackerStress rebuild;
GO


Alter Index PK_HFit_TrackerSugaryDrinks ON HFit_TrackerSugaryDrinks rebuild;
GO
Alter Index PK_HFit_TrackerTests ON HFit_TrackerTests rebuild;
GO
Alter Index PK_HFit_TrackerWholeGrains ON HFit_TrackerWholeGrains rebuild;
GO
Alter Index PK_HFit_UserTrackerCategory ON HFit_UserTrackerCategory rebuild;
GO
Alter Index IX_Media_Library_LibraryDisplayName ON Media_Library rebuild;
GO
Alter Index IX_Newsletter_NewsletterIssue_IssueNewsletterID ON Newsletter_NewsletterIssue rebuild;
GO
Alter Index IX_Newsletter_NewsletterIssue_IssueTemplateID ON Newsletter_NewsletterIssue rebuild;
GO
Alter Index IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive ON Newsletter_NewsletterIssue rebuild;
GO
Alter Index IX_Newsletter_NewsletterIssue_IssueSiteID ON Newsletter_NewsletterIssue rebuild;
GO
Alter Index PK_OM_MVTCombination ON OM_MVTCombination rebuild;
GO
Alter Index PK_Reporting_ReportCategory ON Reporting_ReportCategory rebuild;
GO
Alter Index IX_Reporting_ReportCategory_CategoryParentID ON Reporting_ReportCategory rebuild;
GO
Alter Index PK_Reporting_SavedGraph ON Reporting_SavedGraph rebuild;
GO
Alter Index IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate ON Reporting_SavedReport rebuild;
GO

--Alter Index NULL ON Temp_ImportStaging_MAP rebuild;
--GO
--Alter Index NULL ON Temp_ImportStaging_QST rebuild;
--GO

Alter Index PK_hfit_WellnessGoalPostTemplate ON hfit_WellnessGoalPostTemplate rebuild;
GO
Alter Index PK_HFit_HealthSummarySettings ON HFit_HealthSummarySettings rebuild;
GO
Alter Index PK_HFit_HAWelcomeSettings ON HFit_HAWelcomeSettings REBUILD;
GO
Alter Index IX_CMS_ACL_ACLOwnerNodeID ON CMS_ACL REBUILD;
GO
Alter Index IX_CMS_Avatar_AvatarGUID ON CMS_Avatar REBUILD;
GO
Alter Index IX_CMS_Avatar_AvatarType_AvatarIsCustom ON CMS_Avatar REBUILD;
GO
Alter Index PK_CMS_Avatar ON CMS_Avatar REBUILD;
GO
Alter Index IX_CMS_Culture_CultureName ON CMS_Culture REBUILD;
GO
Alter Index PK_CMS_EmailTemplate ON CMS_EmailTemplate REBUILD;
GO
Alter Index IX_CMS_FormUserControl_UserControlParentID ON CMS_FormUserControl REBUILD;
GO
Alter Index IX_CMS_FormUserControl_UserControlResourceID ON CMS_FormUserControl REBUILD;
GO
Alter Index PK_CMS_FormUserControl ON CMS_FormUserControl REBUILD;
GO
Alter Index PK_CMS_Membership ON CMS_Membership REBUILD;
GO


Alter Index PK_CMS_MembershipRole ON CMS_MembershipRole REBUILD;
GO
Alter Index IX_CMS_ObjectVersionHistory_VersionModifiedByUserID ON CMS_ObjectVersionHistory REBUILD;
GO
Alter Index IX_CMS_PageTemplate_PageTemplateIsReusable_PageTemplateForAllPages_PageTemplateShowAsMasterTemplate ON CMS_PageTemplate REBUILD;
GO
Alter Index PK_CMS_Relationship ON CMS_Relationship REBUILD;
GO
Alter Index IX_CMS_Role_SiteID_RoleID ON CMS_Role REBUILD;
GO
Alter Index IX_CMS_TimeZone_TimeZoneDisplayName ON CMS_TimeZone REBUILD;
GO
Alter Index IX_Community_Group_GroupSiteID_GroupName ON Community_Group REBUILD;
GO
Alter Index IX_Community_GroupMember_MemberJoined ON Community_GroupMember REBUILD;
GO
Alter Index PK_HFit_CoachingWelcomeSettings ON HFit_CoachingWelcomeSettings REBUILD;
GO
Alter Index PK_HFit_configFeatures ON HFit_configFeatures REBUILD;
GO
Alter Index PK_DataEntryClinicalID ON HFit_DataEntry_Clinical_bak REBUILD;
GO
Alter Index PK_DataEntryClinicalID_EXISTING ON HFit_DataEntry_Clinical_bak2 REBUILD;
GO
Alter Index PK_HFit_HealthAssesmentModule ON HFit_HealthAssesmentModule REBUILD;
GO
Alter Index PK_HFit_HealthAssesmentQuestionCodeNames ON HFit_HealthAssesmentQuestionCodeNames REBUILD;
GO
Alter Index Ref76 ON HFit_HealthAssesmentRecomendations REBUILD;
GO
Alter Index idx_UserID ON HFit_HealthAssesmentUserStarted REBUILD;
GO
Alter Index PK_HFit_HealthAssessmentDiasBpScoring ON HFit_HealthAssessmentDiasBpScoring REBUILD;
GO
Alter Index PK_HFit_HealthAssessmentHbA1cScoring ON HFit_HealthAssessmentHbA1cScoring REBUILD;
GO
Alter Index PK_HFit_RewardsUserInterfaceState ON HFit_RewardsUserInterfaceState REBUILD;
GO
Alter Index idx_HFit_TrackerBMI_UserIDEventDate ON HFit_TrackerBMI REBUILD;
GO
Alter Index PK_HFit_TrackerFruits ON HFit_TrackerFruits REBUILD;
GO
Alter Index PK_HFit_TrackerStressManagement ON HFit_TrackerStressManagement REBUILD;
GO

Alter Index IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName ON Newsletter_Newsletter REBUILD;
GO
Alter Index PK_OM_ActivityType ON OM_ActivityType REBUILD;
GO
Alter Index IX_Reporting_ReportCategory_CategoryPath ON Reporting_ReportCategory REBUILD;
GO
Alter Index IX_Reporting_ReportGraph_GraphGUID ON Reporting_ReportGraph REBUILD;
GO
Alter Index IX_Reporting_ReportTable_TableReportID_TableName ON Reporting_ReportTable REBUILD;
GO
Alter Index PK_Reporting_ReportValue ON Reporting_ReportValue REBUILD;
GO
Alter Index PK_CMS_ObjectSettings ON CMS_ObjectSettings REBUILD;
GO
Alter Index PK_HFit_ContentBlock ON HFit_ContentBlock REBUILD;
GO
Alter Index IX_CMS_LicenseKey_LicenseDomain ON CMS_LicenseKey REBUILD;
GO
Alter Index IX_OM_Activity_ActivityOriginalContactID ON OM_Activity REBUILD;
GO
Alter Index IX_OM_Activity_ActivityActiveContactID ON OM_Activity REBUILD;
GO
Alter Index IX_CMS_CssStylesheet_StylesheetDisplayName ON CMS_CssStylesheet REBUILD;
GO
--Alter Index NULL ON bnw_CustomTracker REBUILD;
--GO
Alter Index IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen ON CMS_ObjectVersionHistory REBUILD;
GO
Alter Index IX_CMS_PageTemplate_PageTemplateLayoutID ON CMS_PageTemplate REBUILD;
GO
Alter Index PK_CMS_PageTemplate ON CMS_PageTemplate REBUILD;
GO
Alter Index PK_CMS_Role ON CMS_Role REBUILD;
GO
Alter Index IX_CMS_Role_RoleGroupID ON CMS_Role REBUILD;
GO
Alter Index IX_CMS_Tree_NodeParentID_NodeAlias_NodeName ON CMS_Tree REBUILD;
GO
Alter Index IX_CMS_User_UserName ON CMS_User REBUILD;
GO
Alter Index IX_CMS_WebPart_WebPartLastSelection ON CMS_WebPart REBUILD;
GO
Alter Index IX_CMS_WebPart_WebPartParentID ON CMS_WebPart REBUILD;
GO
Alter Index IX_CMS_WebPart_WebPartCategoryID ON CMS_WebPart REBUILD;
GO
Alter Index PK_CMS_WebPart ON CMS_WebPart REBUILD;
GO
Alter Index IX_CMS_WebPartCategory_CategoryPath ON CMS_WebPartCategory REBUILD;
GO
Alter Index IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName ON CMS_WebPartLayout REBUILD;
GO
Alter Index PK_CMS_WorkflowAction ON CMS_WorkflowAction REBUILD;
GO


Alter Index PK_HFit_ChallengeUserRegistration ON HFit_ChallengeUserRegistration REBUILD;
GO
Alter Index PK_HFit_HealthAssesmentAnswerCodeNames ON HFit_HealthAssesmentAnswerCodeNames REBUILD;
GO
Alter Index idx_HACompletedDt ON HFit_HealthAssesmentUserStarted REBUILD;
GO
Alter Index idx_DocumentID ON HFit_HealthAssesmentUserStarted REBUILD;
GO
Alter Index PK_HFit_HealthAssessmentFastingGlucoseScoring ON HFit_HealthAssessmentFastingGlucoseScoring REBUILD;
GO
Alter Index PK_HFit_HealthAssessmentSysBpScoring ON HFit_HealthAssessmentSysBpScoring REBUILD;
GO
Alter Index PK_HFit_HealthAssessmentTCHDLRatioScoring ON HFit_HealthAssessmentTCHDLRatioScoring REBUILD;
GO
Alter Index PK_HFit_HSAbout ON HFit_HSAbout REBUILD;
GO
Alter Index PK_HFit_PostQuote ON HFit_PostQuote REBUILD;
GO
Alter Index PK_HFit_RewardsAwardUserDetail ON HFit_RewardsAwardUserDetail REBUILD;
GO
Alter Index PK_HFit_ScreeningEvent ON HFit_ScreeningEvent REBUILD;
GO
Alter Index PK_HFit_SsoRequest ON HFit_SsoRequest REBUILD;
GO
Alter Index PK_HFit_TrackerRestingHeartRate ON HFit_TrackerRestingHeartRate REBUILD;
GO
Alter Index PK_HFit_TrackerSleepPlan ON HFit_TrackerSleepPlan REBUILD;
GO
Alter Index PK_HFit_TrackerVegetables ON HFit_TrackerVegetables REBUILD;
GO
Alter Index IX_OM_UserAgent_UserAgentOriginalContactID ON OM_UserAgent REBUILD;
GO
Alter Index IX_Reporting_ReportGraph_GraphReportID_GraphName ON Reporting_ReportGraph REBUILD;
GO
Alter Index PK_HFit_Class ON HFit_Class REBUILD;
GO

--Alter Index NULL ON CMS_UserSettings_Back REBUILD;
--GO
--Alter Index NULL ON BNW_OutComeMessage REBUILD;
--GO

Alter Index PK_CMS_ACL ON CMS_ACL REBUILD;
GO
Alter Index IX_CMS_Country_CountryDisplayName ON CMS_Country REBUILD;
GO
Alter Index IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID ON CMS_EmailTemplate REBUILD;
GO
Alter Index IX_CMS_ScheduledTask_TaskSiteID_TaskDisplayName ON CMS_ScheduledTask REBUILD;
GO
Alter Index IX_Community_Group_GroupDisplayName ON Community_Group REBUILD;
GO
Alter Index PK_HFit_CoachingUserServiceLevel ON HFit_CoachingUserServiceLevel REBUILD;
GO
Alter Index PK__HFit_joi__43B67C8AB1CE0F45 ON HFit_join_ClinicalTrackers REBUILD;
GO
Alter Index PK_HFit_PostReminder ON HFit_PostReminder REBUILD;
GO
Alter Index PK_HFit_RewardsUserRepeatableTriggerDetail ON HFit_RewardsUserRepeatableTriggerDetail REBUILD;
GO
Alter Index PK_HFit_RewardsUserSummary ON HFit_RewardsUserSummary REBUILD;
GO
Alter Index PK_HFit_RewardTrigger ON HFit_RewardTrigger REBUILD;
GO
Alter Index PK_HFit_ScreeningEventDate ON HFit_ScreeningEventDate REBUILD;
GO
Alter Index PK_HFit_TipOfTheDay ON HFit_TipOfTheDay REBUILD;
GO
Alter Index PK_HFit_TrackerFlexibility ON HFit_TrackerFlexibility REBUILD;
GO
Alter Index HFit_UserTracker_idx_01 ON HFit_UserTracker REBUILD;
GO
Alter Index PK_temp_CMS_Layout ON Temp_CMS_Layout REBUILD;
GO
Alter Index IX_OM_Activity_ActivityItemDetailID ON OM_Activity REBUILD;
GO
Alter Index IX_OM_Activity_ActivitySiteID ON OM_Activity REBUILD;
GO
Alter Index idxpagetemplatetemp ON temp_CMS_PageTemplate REBUILD;
GO
Alter Index IX_CMS_Tree_NodeAliasPath ON CMS_Tree REBUILD;
GO
Alter Index PK_CMS_ACLItem ON CMS_ACLItem REBUILD;
GO
Alter Index idx_HFit_CMS_Role_SiteIDRoleID ON CMS_Role REBUILD;
GO
Alter Index IX_CMS_Role_SiteID_RoleName ON CMS_Role REBUILD;
GO
Alter Index IX_CMS_WebPart_WebPartName ON CMS_WebPart REBUILD;
GO
Alter Index PK_HFit_configGroupToFeature ON HFit_configGroupToFeature REBUILD;
GO
Alter Index PK_HFit_Ref_RewardTrackerValidation ON HFit_Ref_RewardTrackerValidation REBUILD;
GO
Alter Index PK_HFit_TrackerCategory ON HFit_TrackerCategory REBUILD;
GO
Alter Index PK_hfit_challengeOffering ON hfit_challengeOffering REBUILD;
GO
Alter Index IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID ON CMS_Personalization REBUILD;
GO
Alter Index PK_CMS_Query ON CMS_Query REBUILD;
GO
Alter Index PK_CMS_ResourceString ON CMS_ResourceString REBUILD;
GO
Alter Index PK_HFit_HAAgreement ON HFit_HAAgreement REBUILD;
GO
Alter Index PK_HFit_SSIS_ScreeningMapping ON HFit_SSIS_ScreeningMapping REBUILD;
GO
Alter Index PK_HFIT_Tracker ON HFIT_Tracker REBUILD;
GO
Alter Index IX_Messaging_Message_MessageSenderUserID_MessageSent_MessageSenderDeleted ON Messaging_Message REBUILD;
GO
Alter Index PK_Messaging_Message ON Messaging_Message REBUILD;
GO
Alter Index PK_Reporting_Report ON Reporting_Report REBUILD;
GO
Alter Index IX_OM_Activity_ActivityCreated ON OM_Activity REBUILD;
GO
Alter Index PK_CMS_Attachment ON CMS_Attachment REBUILD;
GO
Alter Index PK_CMS_PageTemplateSite ON CMS_PageTemplateSite REBUILD;
GO
Alter Index IX_CMS_UserRole_UserID_RoleID ON CMS_UserRole REBUILD;
GO
Alter Index PK__CONTENT_File__46D27B73 ON CONTENT_File REBUILD;
GO
Alter Index PK_Form_PlatformAdminSite_GlobalWalkThisWayPre_Survey ON Form_PlatformAdminSite_GlobalWalkThisWayPre_Survey REBUILD;
GO
Alter Index PK_DataEntryClinicalID_old ON HFit_DataEntry_Clinical REBUILD;
GO
Alter Index PK_HFit_TrackerBodyFat ON HFit_TrackerBodyFat REBUILD;
GO
Alter Index PK_HFit_TrackerStrength ON HFit_TrackerStrength REBUILD;
GO

--Alter Index PK_DataSync.provision_marker_dss ON provision_marker_dss REBUILD;
--GO

Alter Index PK_CMS_ObjectVersionHistory ON CMS_ObjectVersionHistory REBUILD;
GO
Alter Index IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID ON CMS_Attachment REBUILD;
GO
Alter Index PK_CMS_MetaFile ON CMS_MetaFile REBUILD;
GO
Alter Index PK2 ON HFit_HealthAssesmentThresholds REBUILD;
GO
Alter Index PK_HFit_SchedulerEventAppointmentSlot ON HFit_SchedulerEventAppointmentSlot REBUILD;
GO
Alter Index PK_hfit_ChallengeAbout ON hfit_ChallengeAbout REBUILD;
GO

--Alter Index NULL ON HFit_View_EDW_HealthAssesment REBUILD;
--GO

Alter Index IX_OM_Activity_ActivityType ON OM_Activity REBUILD;
GO
Alter Index PK_HFit_HealthAssesmentPredefinedAnswer ON HFit_HealthAssesmentPredefinedAnswer REBUILD;
GO
Alter Index IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder ON CMS_Attachment REBUILD;
GO
Alter Index IX_CMS_PageTemplate_PageTemplateSiteID_PageTemplateCodeName_PageTemplateGUID ON CMS_PageTemplate REBUILD;
GO
Alter Index IX_CMS_SettingsCategory_CategoryOrder ON CMS_SettingsCategory REBUILD;
GO
Alter Index PK_CMS_UIElement ON CMS_UIElement REBUILD;
GO
Alter Index PK_CMS_UserRole ON CMS_UserRole REBUILD;
GO
Alter Index PK_Hfit_SmallStepResponses ON Hfit_SmallStepResponses REBUILD;
GO
Alter Index PK_HFit_SsoRequestAttributes ON HFit_SsoRequestAttributes REBUILD;
GO
Alter Index IX_Reporting_Report_ReportName ON Reporting_Report REBUILD;
GO

UPDATE STATISTICS HFit_HealthAssesmentThresholds WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS tmpImport WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_PaymentOption WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_PersonalizationVariant WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_SocialProof WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_EmailTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_DocumentTag WITH FULLSCAN, ALL;
GO
--UPDATE STATISTICS schema_info_dss WITH FULLSCAN, ALL;
--GO
UPDATE STATISTICS CMS_BannerCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamADev_HAAccept WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserQuestion WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_ComplexSurvey_1 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_OrderStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_GroupRemovedUsers WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PLPPackageContent WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SSISLoadDetail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserQuestionStaging WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_TrackerSleepPlanTechniques WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Media_Library WITH FULLSCAN, ALL;
GO
--UPDATE STATISTICS scope_config_dss WITH FULLSCAN, ALL;
--GO
UPDATE STATISTICS HFit_HSBiometricChart WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Smartphone WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_TrackerFlexibilityActivity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowTransition WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_DiscountLevel WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PostHealthEducation WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentRiskCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Integration_SyncLog WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS PM_ProjectTaskPriority WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_ConversionCampaign WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeRegistrationPostTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentFastingGlucoseScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Event WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserModule WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_CustomerCreditHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentImportStagingDetail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_DataEntry_Clinical_changed_withData WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamCDev_Drip_Campaign WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Export_Task WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Staging_Fulfillment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_ExitPages WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingNotAssignedSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_TrackerTobaccoQuitAids WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Currency WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SSISLoadError WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_TaxClass WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_BannedIP WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Blog_PostSubscription WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_Index WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_MVTest WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ContactGroupMembership WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_WellnessGoalPostTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentRiskAreaCodeNames WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Address WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_PublicStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_ContactGroupType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_FastingState WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Wireframe WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentNonFastingGlucoseScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_VersionHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Fulfillment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_VersionAttachment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hFit_ChallengePPTEligiblePostTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ScreeningEvent WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SSIS_ScreeningMapping WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UserTracker WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_FAQ WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_InternalStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_TrackerTable WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentRecomendationClientConfig WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Media_LibraryRolePermission WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_User WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_MVTCombination WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerHbA1c WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_SupportTakenRoom WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerShots WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_AttachmentHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardLevel WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentRiskCategoryCodeNames WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Goal WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_SSISEvent WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardCompleted WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_ExchangeTable WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_ComplexSurvey_1_2 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Document WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFIT_TestLookup WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserAnswers WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_TrackerStrengthActivity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WidgetRole WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerTests WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ScheduledNotificationHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeRegistrations WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ABVariant WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_DiscountCoupon WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_MembershipRole WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentHbA1cScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_YearHits WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PostReminder WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_SSISPackage WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_EmailUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Staging_Coach WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_SupportCannedResponse WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_AutomationHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_EventLog WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentModuleCodeNames WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_File WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_TagGroup WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Temp_CMS_Layout WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengePPTRegisteredPostTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerHighSodiumFoods WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_FormRole WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SecurityQuestion WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_WeekHits WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ScheduledTaskHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardException WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UserSchedulerAppointment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_ChallengeAbout WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_DataEntry_Clinical_bak2 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerInstance_Item WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_ComplexSurvey WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_SSISPackageTask WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebPartCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerBodyMeasurements WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SMTPServerSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_Room WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS PM_ProjectStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS temp_CMS_PageTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_OrderStatusUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingUserServiceLevel WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentImportStagingException WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_MonthHits WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_MarketplaceProductTypes WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS tempcms_treeNode WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ABTest WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Message WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_EmailTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerSugaryDrinks WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS zzz_HFit_LKP_RewardUnitValue WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ResourceTranslation WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentStarted WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_HourHits WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardProgram WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingLibrarySettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SSISLoad_FTPServer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_OnlineSupport WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_AccountContact WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_UserCulture WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_DayHits WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_DataEntry_Clinical_bak WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Email WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformAdminSite_GlobalWalkThisWayPre_Survey WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Account WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerSitLess WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengePostTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Banner WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardTrigger WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_Notification WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SiteCulture WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_OrderItem WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_ForumRoles WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeRegistrationTempData WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_MarketplaceProduct WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_join_ClinicalTrackers WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_Foobar_1_2 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardTrigger WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Device_RawNotification WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_ImageGallery WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS BadWords_WordCulture WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_HealthAssessmentImportStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_Message WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerRegularMeals WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_Newsletter WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Site WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingMyHealthInterestsSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformConsolidated_WTW_PreSurvey_2013 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Culture WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerSummary WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_EventLogArchive WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ScreeningEventDate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ValMeasureValues WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentThresholdGrouping WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsUserLevelDetail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ContactGroupSyncExclude WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Join_ClinicalSourceTracker WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsUserRepeatableTriggerDetail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_RoomUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_CssStylesheetSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PostEmptyFeed WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_ForumSubscription WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SchedulerEventAppointmentSlot WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UserRewardPoints WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_Post WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentAnswers WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS shane_MacroRuleToTable WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ConsentAndReleaseAgreement WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_RelationshipName WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentAnswerCodeNames WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAdvisingSessionCompleted WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SSISLoad_FTPCommand WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_ForumModerators WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Job WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_PageTemplateCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ScreeningEventCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_GroupAddUsers WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_MacroConditions WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardActivity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeRegistrationEmail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Messaging_Message WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LoginPageSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_DocumentAlias WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ScheduledTask WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingHealthArea WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentConfiguration WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingEvalHAOverall WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerVegetables WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Messaging_IgnoreList WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingTermsAndConditionsSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Badge WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_MacroCompare WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_Campaign WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_KBArticle WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ClassType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_ScheduledNotificationDeliveryType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_Account WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_CoachingServiceLevelStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Customer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Notification_Subscription WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Pillar WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowScope WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Messaging_ContactList WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Events_Attendee WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_BiometricData WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_CoachingCMConditions WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingWelcomeSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerInstance_Tracker WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ConsentAndRelease WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Export_History WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsAwardUserDetailArchive WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFIT_Tracker WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_OrderItemSKUFile WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ObjectWorkflowTrigger WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsUserSummaryArchive WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS scope_info_dss WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_SKU WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SearchEngine WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentQuestionGroupCodeNames WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_FulfillmentFeatures WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardTriggerParameter WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Product WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_TranslationSubmissionItem WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardTriggerParameterOperator WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Media_File WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Tobacco_Goal WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_CoachingOptOutReason WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_Conversion WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_FooterAdministration WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingGetStarted WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeRegistrationSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_TranslationSubmission WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Calculator WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_CoachingCMExclusions WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Session WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HAAgreement WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_Foobar_1 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Temp_ImportStaging_MAP WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS provision_marker_dss WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Sites WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Laptop WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebFarmTask WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ValMeasures WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformAdminSite_Test WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_DocumentCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ResourceSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Temp_ImportStaging_QST WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Users WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardDefaultSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_AutomationState WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_GoalStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_LicenseKey_dss_tracking WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ValMeasureType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Category WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UserGoal WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Community_Friend WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_TranslationService WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingEvalHARiskCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Mapping_BioMetricTrackers WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Order WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_LicenseKey WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HSHealthMeasuresSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Class WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerDef_Tracker WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingCommitToQuit WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_EventType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_OnlineUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Workflow WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS bnw_CustomTracker WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_UICulture WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_GroupRewardLevel WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UnitOfMeasure WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_ShoppingCart WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Notification_Gateway WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_UserSettings_Back WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentBmiScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_RelationshipNameSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_State WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentModuleConfiguration WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengePPTRegisteredRDPostTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PPTEligibility WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerHeight WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Relationship WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Polls_PollSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Personalization WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_ForumGroup WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingHealthInterest WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Resource WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_GoalOutcome WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentPhysicalActivityScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_StressManagementActivity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Staging_Server WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_MyHealthSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ObjectRelationship WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SettingsKey WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Polls_PollRoles WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_News WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ContactGroup WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingEvalHARiskArea WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS bnw_PostFeedGetLog WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SearchIndex WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_ComplexSurvey_1_1 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_CurrencyExchangeRate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Polls_Poll WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_OpenIDUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HSLearnMoreDocument WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ToDoSmallSteps WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ScoreContactRule WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentSysBpScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_challengeTypes WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HA_UseAndDisclosure WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Staging_Task WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerBMI WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS PM_ProjectTask WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardAboutInfoItem WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_TipOfTheDayCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerDocument WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_Rule WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_DiscountLevelDepartment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_CssStylesheet WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HESChallenge WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Temp_File WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerBodyFat WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PrivacyPolicy WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Country WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS PM_ProjectRolePermission WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_AbuseReport WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_MenuItem WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentRecomendations WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerDailySteps WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_MVTVariant WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_UserDepartment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS PM_Project WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentFreeForm WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerRestingHeartRate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ClassSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentDiasBpScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerMedicalCarePlan WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SyncTaskSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Article WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingEvalHAQA WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_SubscriberNewsletter WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Community_Invitation WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_MacroStatement WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Polls_PollAnswer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerCholesterol WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengePPTEligibleCDPostTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_DataEntry_Clinical_oldwithoutData WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_TemplateDeviceLayout WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_AllowedChildClasses WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowAction WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowStepRoles WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Office WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS sysdiagrams WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS BadWords_Word WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowStepUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_CoachingUserCMExclusion WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Community_GroupRolePermission WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_CoachingServiceLevel WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SMTPServer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_Subscriber WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_UserRole WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebFarmServer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Announcements WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CallList WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_Foobar_1_1 WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebPart WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ActivityType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowStep WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeUserRegistration WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Staging_Clinical WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UserTrackerCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_TimeZone WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Blog WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_PageTemplateScope WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_CallResult WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_CoachingSystemSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_RoleUIElement WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_User WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformTeamDDev_Foobar WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentMultipleChoiceQuestion WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ClassMapping WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_Emails WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Community_GroupMember WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentRecomendationTypes WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerHighFatFoods WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthSummarySettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_UIElement WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerMealPortions WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HESChallengeTable WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_RolePermission WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Staging_Blurb WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerFruits WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentImportStatBridge WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Transformation WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_Membership WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentThresholdTypes WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingHealthActionPlan WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardDatesAggregator WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WorkflowUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Ref_RewardTrackerValidation WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Role WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_InitiatedChatRequest WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Community_Group WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerTobaccoFree WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Permission WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_ForumPost WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PostChallenge WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_HACampaigns WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WidgetCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Form WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Board_Subscription WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SsoData WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_IP WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_InlineControl WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Board_Role WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerWeight WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_Activity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Staging_SyncLog WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_Contact WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Device_Organization WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HaScoringStrategies WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Newsletter WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Blurb WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_Link WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebPartContainer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerCollectionSource WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Board_Moderator WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Company WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SsoAttributeData WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_Search WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_FormUserControl WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Staging_Synchronization WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_AlternativeForm WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_MacroBaseTable WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Tree WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_Forum WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ObjectSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_View_EDW_HealthAssesment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ContactGroupMember WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Coaches WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_PageVisit WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_TaxClassState WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TipOfTheDay WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Layout WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingEnrollmentSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerWholeGrains WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_PressRelease WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Attachment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_NewsletterIssue WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_TaxClassCountry WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_StagingScreenings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardFrequency WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_BlogMonth WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_SmallStepResponses WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ContentBlock WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsAboutInfoItem WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Avatar WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS AuditObjects WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_MVTCombinationVariation WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_SKUTaxClasses WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Device_User WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Analytics_Statistics WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_StatbridgeFileDownload WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_challengeBase WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_DataEntry_Clinical WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsUserTrigger WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardGroup WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Integration_Task WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_ABTest WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS DDLEvents WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_PageTemplateSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_ShippingOptionTaxClass WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsAwardUserDetail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TermsConditions WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardLevel WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_WellnessGoals WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingLibraryHealthArea WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ResourceString WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_dataEntry_clinical_backup WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SsoRequest WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Chat_PopupWindowSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Integration_Synchronization WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_ReportCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerStrength WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerCardio WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_DepartmentTaxClass WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS FragmentationReport WITH FULLSCAN, ALL;
GO
--UPDATE STATISTICS Staging_SynchronizationArchive WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ACLItem WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Event WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Staging_SyncLogArchive WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Integration_Connector WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_TheTodd WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Department WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentPredefinedAnswer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_configFeatures WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Staging_TaskArchive WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_SavedReport WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingLibraryResources WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingSessionCompleted WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsUserActivityDetail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SearchTask WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SettingsCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ClientSecurityQuestions WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_BlogPost WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_challenge WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Membership WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_TipOfTheDayCategoryCT WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HRA WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserStarted WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_challengeGeneralSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_SavedGraph WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_UserSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingLibraryResource WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Board_Message WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_configGroupToFeature WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PostSubscriber WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RightsResponsibilities WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS t_Weight_BNW WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_ReportSubscription WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingPrivacyPolicy WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS csv_instance WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SearchIndexSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SSIS_BiometricBioLook WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerSugaryFoods WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_MockMpiData WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_MembershipUser WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeNewsletterRelationship WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentTCScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SsoRequestAttributes WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_FulfillmentCodes WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerStress WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_UserAgent WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SearchIndexCulture WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ContactStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentImportStaging WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_UserType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentMatrixQuestion WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserRiskCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Wishlist WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentRiskArea WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_ReportValue WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Screening_CNT WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PostQuote WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_Report WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingEvalHARiskModule WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_GoalCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_VolumeDiscount WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardCompleted_FIX WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_UserFavorites WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_ContactRole WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_ReportTable WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentHDLScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Blog_Comment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_MockRewardsTriggers WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_StagingEligibility WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerSleepPlan WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsUserInterfaceState WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Screening_MAP WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_SKUOptionCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Reporting_ReportGraph WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardsUserSummary WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_GoalSubCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_SKUFile WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UserSearch WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Query WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_DeviceProfileLayout WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ToDoPersonal WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Board_Board WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Forums_Attachment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Notification_TemplateText WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_OutComeMessages WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerStressManagement WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_CoachingMyGoalsSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_SKUDiscountCoupon WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_SimpleArticle WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentQuestionCodeNames WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_PageTemplate WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_InlineControlSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Screening_PPT WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserRiskArea WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentLDLScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_SiteDomainAlias WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebPartLayout WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_ShoppingCartSKU WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ACL WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_BookingEvent WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerBloodPressure WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HACampaign WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SchedulerEventType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_challengeOffering WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS trackerType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebPartContainerSite WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Bundle WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Hfit_CoachingUserCMCondition WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentModule WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardLevelType WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_CardioActivityIntensity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Class WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_MacroRule WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_UnitOfMeasure WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_MetaFile WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SmallSteps WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_ChallengeFAQ WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Widget WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_EmailAttachment WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentTCHDLRatioScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_EmailTemplateNewsletter WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerFlexibility WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS BNW_OutComeMessage WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_PostMessage WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_AttachmentForEmail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_ShippingCost WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_UserSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_Frequency WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserQuestionGroupResults WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ScheduledNotification WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RewardTriggerParameter WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerBloodSugarAndGlucose WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_WebFarmServerTask WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS custom_ttest WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_PaymentShipping WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerDef_Item WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssesmentUserQuestionImport WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Supplier WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentImportStagingMaster WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HAWelcomeSettings WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CONTENT_Cellphone WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_RegistrationWelcome WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HealthAssessmentTriglyceridesScoring WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HSAbout WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_ChallengeTeams WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_Score WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS PM_ProjectTaskStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_Screening_QST WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_SubscriberLink WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_UserGoal_back WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_OptionCategory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_TrackerWater WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Form_PlatformAdminSite_GlobalWalkThisWayPostSurvey WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ClientContact WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS OM_AccountStatus WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Newsletter_OpenedEmail WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardActivity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_SSISLoad WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_ObjectVersionHistory WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_TrackerCardioActivity WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_ShippingOption WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_DeviceProfile WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_LKP_RewardGroupLevel WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_WellnessGoal WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_EligibilityLoadTracking WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS SearchTMP WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS hfit_ChallengeTeam WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS Notification_Template WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS COM_Manufacturer WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS CMS_Tag WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_ChallengeNewsletter WITH FULLSCAN, ALL;
GO
UPDATE STATISTICS HFit_HSGraphRangeSetting WITH FULLSCAN, ALL;
GO

  --  
  --  
GO 
print('***** FROM: RebuildReorgIndex.sql'); 
GO 
