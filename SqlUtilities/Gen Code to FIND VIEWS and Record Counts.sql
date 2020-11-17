

--  Gen Code to FIND VIEWS and Record Counts
select 'Select db_name() as DBNAME, '''+table_name+''' as ViewName, count(*) as RowCNT from '+table_name + char(10) + 'UNION' as cmd
from information_schema.tables 
where table_type != 'BASE TABLE'

Select db_name() as DBNAME, 'View_Hfit_TipOfTheDayCategory_Joined' as ViewName, count(*) as RowCNT from View_Hfit_TipOfTheDayCategory_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_TipOfTheDay_Joined' as ViewName, count(*) as RowCNT from View_HFit_TipOfTheDay_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_PostMessage_Joined' as ViewName, count(*) as RowCNT from View_HFit_PostMessage_Joined
UNION
Select db_name() as DBNAME, 'View_hfit_Post_Joined' as ViewName, count(*) as RowCNT from View_hfit_Post_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_UserGoalTrackerDetails' as ViewName, count(*) as RowCNT from View_HFit_UserGoalTrackerDetails
UNION
Select db_name() as DBNAME, 'View_HFit_PostQuote_Joined' as ViewName, count(*) as RowCNT from View_HFit_PostQuote_Joined
UNION
Select db_name() as DBNAME, 'View_Custom_HFit_ScreeningEventsWithCapacity' as ViewName, count(*) as RowCNT from View_Custom_HFit_ScreeningEventsWithCapacity
UNION
Select db_name() as DBNAME, 'View_HFit_PostReminder_Joined' as ViewName, count(*) as RowCNT from View_HFit_PostReminder_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserGoalOutcomes' as ViewName, count(*) as RowCNT from HFit_UserGoalOutcomes
UNION
Select db_name() as DBNAME, 'View_Custom_HFit_UserScreeningEventDetail' as ViewName, count(*) as RowCNT from View_Custom_HFit_UserScreeningEventDetail
UNION
Select db_name() as DBNAME, 'View_HFit_PrivacyPolicy_Joined' as ViewName, count(*) as RowCNT from View_HFit_PrivacyPolicy_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserCoachingAlert_NotMet' as ViewName, count(*) as RowCNT from HFit_UserCoachingAlert_NotMet
UNION
Select db_name() as DBNAME, 'View_HFit_TermsConditions_Joined' as ViewName, count(*) as RowCNT from View_HFit_TermsConditions_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserCoachingAlert_MeetNotModify' as ViewName, count(*) as RowCNT from HFit_UserCoachingAlert_MeetNotModify
UNION
Select db_name() as DBNAME, 'View_NewsletterSubscriberUserRole_Joined' as ViewName, count(*) as RowCNT from View_NewsletterSubscriberUserRole_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_Newsletter_Joined' as ViewName, count(*) as RowCNT from View_HFit_Newsletter_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_TrackerCategory_Joined' as ViewName, count(*) as RowCNT from View_HFit_TrackerCategory_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingAuditLog' as ViewName, count(*) as RowCNT from View_HFit_CoachingAuditLog
UNION
Select db_name() as DBNAME, 'view_HFit_TrackerEvents' as ViewName, count(*) as RowCNT from view_HFit_TrackerEvents
UNION
Select db_name() as DBNAME, 'View_HFit_TrackerDocument_Joined' as ViewName, count(*) as RowCNT from View_HFit_TrackerDocument_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_Coach_Bio' as ViewName, count(*) as RowCNT from View_HFit_Coach_Bio
UNION
Select db_name() as DBNAME, 'View_HFit_ProfColBio_WithSource' as ViewName, count(*) as RowCNT from View_HFit_ProfColBio_WithSource
UNION
Select db_name() as DBNAME, 'View_HFit_PostHealthEducation_Joined' as ViewName, count(*) as RowCNT from View_HFit_PostHealthEducation_Joined
UNION
Select db_name() as DBNAME, 'view_ToDoHealthAdvising' as ViewName, count(*) as RowCNT from view_ToDoHealthAdvising
UNION
Select db_name() as DBNAME, 'View_OM_ContactGroupMember_User_ContactJoined' as ViewName, count(*) as RowCNT from View_OM_ContactGroupMember_User_ContactJoined
UNION
Select db_name() as DBNAME, 'View_HFit_Pillar_Joined' as ViewName, count(*) as RowCNT from View_HFit_Pillar_Joined
UNION
Select db_name() as DBNAME, 'View_ToDoHealthAssesment' as ViewName, count(*) as RowCNT from View_ToDoHealthAssesment
UNION
Select db_name() as DBNAME, 'View_hfit_WellnessGoalPostTemplate_Joined' as ViewName, count(*) as RowCNT from View_hfit_WellnessGoalPostTemplate_Joined
UNION
Select db_name() as DBNAME, 'View_ToDoScreenings' as ViewName, count(*) as RowCNT from View_ToDoScreenings
UNION
Select db_name() as DBNAME, 'View_ToDoScheduleScreenings' as ViewName, count(*) as RowCNT from View_ToDoScheduleScreenings
UNION
Select db_name() as DBNAME, 'View_HFit_HAWelcomeSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_HAWelcomeSettings_Joined
UNION
Select db_name() as DBNAME, 'view_ToDoFeatures' as ViewName, count(*) as RowCNT from view_ToDoFeatures
UNION
Select db_name() as DBNAME, 'View_ToDoScheduleScreeningsCompleted' as ViewName, count(*) as RowCNT from View_ToDoScheduleScreeningsCompleted
UNION
Select db_name() as DBNAME, 'View_hfit_SocialProof_Joined' as ViewName, count(*) as RowCNT from View_hfit_SocialProof_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_ValidationMeasures' as ViewName, count(*) as RowCNT from view_HFit_ValidationMeasures
UNION
Select db_name() as DBNAME, 'View_CMS_ACLItem_ItemsAndOperators' as ViewName, count(*) as RowCNT from View_CMS_ACLItem_ItemsAndOperators
UNION
Select db_name() as DBNAME, 'View_EDW_RewardProgram_Joined' as ViewName, count(*) as RowCNT from View_EDW_RewardProgram_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_RewardActivity_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardActivity_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Users_With_Demographics' as ViewName, count(*) as RowCNT from View_CMS_Users_With_Demographics
UNION
Select db_name() as DBNAME, 'View_Rewards_CompletedGoals' as ViewName, count(*) as RowCNT from View_Rewards_CompletedGoals
UNION
Select db_name() as DBNAME, 'View_CMS_ResourceString_Joined' as ViewName, count(*) as RowCNT from View_CMS_ResourceString_Joined
UNION
Select db_name() as DBNAME, 'View_Poll_AnswerCount' as ViewName, count(*) as RowCNT from View_Poll_AnswerCount
UNION
Select db_name() as DBNAME, 'View_CMS_SettingsKeyCategory' as ViewName, count(*) as RowCNT from View_CMS_SettingsKeyCategory
UNION
Select db_name() as DBNAME, 'View_HFit_RewardLevel_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardLevel_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_ObjectVersionHistoryUser_Joined' as ViewName, count(*) as RowCNT from View_CMS_ObjectVersionHistoryUser_Joined
UNION
Select db_name() as DBNAME, 'View_COM_SKUOptionCategory_OptionCategory_Joined' as ViewName, count(*) as RowCNT from View_COM_SKUOptionCategory_OptionCategory_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_RewardProgram_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardProgram_Joined
UNION
Select db_name() as DBNAME, 'View_Reporting_CategoryReport_Joined' as ViewName, count(*) as RowCNT from View_Reporting_CategoryReport_Joined
UNION
Select db_name() as DBNAME, 'View_Hfit_CoachingSystemSettings_Joined' as ViewName, count(*) as RowCNT from View_Hfit_CoachingSystemSettings_Joined
UNION
Select db_name() as DBNAME, 'View_OM_Account_Joined' as ViewName, count(*) as RowCNT from View_OM_Account_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_PageTemplateCategoryPageTemplate_Joined' as ViewName, count(*) as RowCNT from View_CMS_PageTemplateCategoryPageTemplate_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingWelcomeSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingWelcomeSettings_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Query_List' as ViewName, count(*) as RowCNT from View_CMS_Query_List
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingEnrollmentSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingEnrollmentSettings_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingServiceLevelProgramDates' as ViewName, count(*) as RowCNT from View_HFit_CoachingServiceLevelProgramDates
UNION
Select db_name() as DBNAME, 'view_EDW_TrackerCompositeDetails' as ViewName, count(*) as RowCNT from view_EDW_TrackerCompositeDetails
UNION
Select db_name() as DBNAME, 'View_Hfit_HACampaigns_Joined' as ViewName, count(*) as RowCNT from View_Hfit_HACampaigns_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HACampaign_Joined' as ViewName, count(*) as RowCNT from View_HFit_HACampaign_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentRiskCategory_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentRiskCategory_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentModule_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentModule_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentRiskArea_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentRiskArea_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CustomSettingsTemporalContainer_Joined' as ViewName, count(*) as RowCNT from View_HFit_CustomSettingsTemporalContainer_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentPredefinedAnswer_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentPredefinedAnswer_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Tree_Joined_Versions_Attachments' as ViewName, count(*) as RowCNT from View_CMS_Tree_Joined_Versions_Attachments
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentQuestionTitleIDX' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentQuestionTitleIDX
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingTermsAndConditionsSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingTermsAndConditionsSettings_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingGetStarted_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingGetStarted_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Relationship_Joined' as ViewName, count(*) as RowCNT from View_CMS_Relationship_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_GroupRewardLevel_Joined' as ViewName, count(*) as RowCNT from View_HFit_GroupRewardLevel_Joined
UNION
Select db_name() as DBNAME, 'View_Hfit_HealthAssessmentDefinition' as ViewName, count(*) as RowCNT from View_Hfit_HealthAssessmentDefinition
UNION
Select db_name() as DBNAME, 'View_CMS_UserSettingsRole_Joined' as ViewName, count(*) as RowCNT from View_CMS_UserSettingsRole_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingMyGoalsSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingMyGoalsSettings_Joined
UNION
Select db_name() as DBNAME, 'View_COM_SKU' as ViewName, count(*) as RowCNT from View_COM_SKU
UNION
Select db_name() as DBNAME, 'View_HFit_Goal_Joined' as ViewName, count(*) as RowCNT from View_HFit_Goal_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_GoalCategory_Joined' as ViewName, count(*) as RowCNT from View_HFit_GoalCategory_Joined
UNION
Select db_name() as DBNAME, 'View_OM_Account_MembershipJoined' as ViewName, count(*) as RowCNT from View_OM_Account_MembershipJoined
UNION
Select db_name() as DBNAME, 'View_HFit_GoalSubCategory_Joined' as ViewName, count(*) as RowCNT from View_HFit_GoalSubCategory_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingGetUserDaysSinceActivity' as ViewName, count(*) as RowCNT from View_HFit_CoachingGetUserDaysSinceActivity
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingHealthArea_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingHealthArea_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingReadyForNotification' as ViewName, count(*) as RowCNT from View_HFit_CoachingReadyForNotification
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingMyHealthInterestsSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingMyHealthInterestsSettings_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingHealthActionPlan_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingHealthActionPlan_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_ClinicalValidationMeasures' as ViewName, count(*) as RowCNT from view_HFit_ClinicalValidationMeasures
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentMatrixQuestion_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentMatrixQuestion_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_Participant' as ViewName, count(*) as RowCNT from view_EDW_Participant
UNION
Select db_name() as DBNAME, 'View_HFit_SmallSteps_Joined' as ViewName, count(*) as RowCNT from View_HFit_SmallSteps_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_HealthMeasures' as ViewName, count(*) as RowCNT from view_HFit_HealthMeasures
UNION
Select db_name() as DBNAME, 'View_HFIT_SsoConfiguration_Joined' as ViewName, count(*) as RowCNT from View_HFIT_SsoConfiguration_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_RewardUserDetail' as ViewName, count(*) as RowCNT from view_EDW_RewardUserDetail
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingPrivacyPolicy_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingPrivacyPolicy_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_RewardAwardDetail' as ViewName, count(*) as RowCNT from view_EDW_RewardAwardDetail
UNION
Select db_name() as DBNAME, 'View_HFit_RewardTriggerParameter_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardTriggerParameter_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthSummarySettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthSummarySettings_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_CoachingPPTEnrolled' as ViewName, count(*) as RowCNT from view_EDW_CoachingPPTEnrolled
UNION
Select db_name() as DBNAME, 'View_CMS_User_With_HFitCoachingSettings' as ViewName, count(*) as RowCNT from View_CMS_User_With_HFitCoachingSettings
UNION
Select db_name() as DBNAME, 'View_HFit_Tobacco_Goal_Joined' as ViewName, count(*) as RowCNT from View_HFit_Tobacco_Goal_Joined
UNION
Select db_name() as DBNAME, 'View_Community_Friend_RequestedFriends' as ViewName, count(*) as RowCNT from View_Community_Friend_RequestedFriends
UNION
Select db_name() as DBNAME, 'view_EDW_CoachingPPTEligible' as ViewName, count(*) as RowCNT from view_EDW_CoachingPPTEligible
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingCommitToQuit_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingCommitToQuit_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_WidgetCategoryWidget_Joined' as ViewName, count(*) as RowCNT from View_CMS_WidgetCategoryWidget_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssessmentFreeForm_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssessmentFreeForm_Joined
UNION
Select db_name() as DBNAME, 'View_OM_AccountContact_AccountJoined' as ViewName, count(*) as RowCNT from View_OM_AccountContact_AccountJoined
UNION
Select db_name() as DBNAME, 'view_EDW_SmallStepResponses' as ViewName, count(*) as RowCNT from view_EDW_SmallStepResponses
UNION
Select db_name() as DBNAME, 'View_HFit_RewardDefaultSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardDefaultSettings_Joined
UNION
Select db_name() as DBNAME, 'view_hfit_SmallStepsOutcomeMessages' as ViewName, count(*) as RowCNT from view_hfit_SmallStepsOutcomeMessages
UNION
Select db_name() as DBNAME, 'view_EDW_BiometricViewRejectCriteria' as ViewName, count(*) as RowCNT from view_EDW_BiometricViewRejectCriteria
UNION
Select db_name() as DBNAME, 'View_HFit_HSGraphRangeSetting_Joined' as ViewName, count(*) as RowCNT from View_HFit_HSGraphRangeSetting_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_ResourceTranslated_Joined' as ViewName, count(*) as RowCNT from View_CMS_ResourceTranslated_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_OutComeMessages_Joined' as ViewName, count(*) as RowCNT from View_HFit_OutComeMessages_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_WebPartCategoryWebpart_Joined' as ViewName, count(*) as RowCNT from View_CMS_WebPartCategoryWebpart_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_Calculator_Joined' as ViewName, count(*) as RowCNT from View_HFit_Calculator_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ScreeningEvent_Joined' as ViewName, count(*) as RowCNT from View_HFit_ScreeningEvent_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_BioMetrics' as ViewName, count(*) as RowCNT from view_EDW_BioMetrics
UNION
Select db_name() as DBNAME, 'View_HFit_ScreeningEventDate_Joined' as ViewName, count(*) as RowCNT from View_HFit_ScreeningEventDate_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserCoachingAlert_NotMet_Step1' as ViewName, count(*) as RowCNT from HFit_UserCoachingAlert_NotMet_Step1
UNION
Select db_name() as DBNAME, 'view_EDW_RewardTriggerParameters' as ViewName, count(*) as RowCNT from view_EDW_RewardTriggerParameters
UNION
Select db_name() as DBNAME, 'View_HFit_ScreeningEventCategory_Joined' as ViewName, count(*) as RowCNT from View_HFit_ScreeningEventCategory_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserCoachingAlert_NotMet_Step2' as ViewName, count(*) as RowCNT from HFit_UserCoachingAlert_NotMet_Step2
UNION
Select db_name() as DBNAME, 'View_OM_AccountContact_ContactJoined' as ViewName, count(*) as RowCNT from View_OM_AccountContact_ContactJoined
UNION
Select db_name() as DBNAME, 'View_HFit_HSAbout_Joined' as ViewName, count(*) as RowCNT from View_HFit_HSAbout_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserCoachingAlert_NotMet_Step3' as ViewName, count(*) as RowCNT from HFit_UserCoachingAlert_NotMet_Step3
UNION
Select db_name() as DBNAME, 'view_EDW_HealthInterestList' as ViewName, count(*) as RowCNT from view_EDW_HealthInterestList
UNION
Select db_name() as DBNAME, 'View_HFit_RewardsAboutInfoItem_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardsAboutInfoItem_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserCoachingAlert_NotMet_Step4' as ViewName, count(*) as RowCNT from HFit_UserCoachingAlert_NotMet_Step4
UNION
Select db_name() as DBNAME, 'View_OM_Contact_Activity' as ViewName, count(*) as RowCNT from View_OM_Contact_Activity
UNION
Select db_name() as DBNAME, 'View_Community_Friend_Friends' as ViewName, count(*) as RowCNT from View_Community_Friend_Friends
UNION
Select db_name() as DBNAME, 'view_EDW_Awards' as ViewName, count(*) as RowCNT from view_EDW_Awards
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingNotAssignedSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingNotAssignedSettings_Joined
UNION
Select db_name() as DBNAME, 'HFit_UserCoachingAlert_NotMet_Step5' as ViewName, count(*) as RowCNT from HFit_UserCoachingAlert_NotMet_Step5
UNION
Select db_name() as DBNAME, 'View_Community_Group' as ViewName, count(*) as RowCNT from View_Community_Group
UNION
Select db_name() as DBNAME, 'view_EDW_ClientCompany' as ViewName, count(*) as RowCNT from view_EDW_ClientCompany
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingEvalHAOverall_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingEvalHAOverall_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_Coaches' as ViewName, count(*) as RowCNT from view_EDW_Coaches
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingEvalHARiskCategory_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingEvalHARiskCategory_Joined
UNION
Select db_name() as DBNAME, 'view_ToDoCoachingEnrollment' as ViewName, count(*) as RowCNT from view_ToDoCoachingEnrollment
UNION
Select db_name() as DBNAME, 'view_HFit_UserContactDemographics' as ViewName, count(*) as RowCNT from view_HFit_UserContactDemographics
UNION
Select db_name() as DBNAME, 'view_EDW_CoachingDefinition' as ViewName, count(*) as RowCNT from view_EDW_CoachingDefinition
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingEvalHARiskArea_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingEvalHARiskArea_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_UserRoleMembershipRole' as ViewName, count(*) as RowCNT from View_CMS_UserRoleMembershipRole
UNION
Select db_name() as DBNAME, 'View_Boards_BoardMessage_Joined' as ViewName, count(*) as RowCNT from View_Boards_BoardMessage_Joined
UNION
Select db_name() as DBNAME, 'View_OM_ContactGroupMember_ContactJoined' as ViewName, count(*) as RowCNT from View_OM_ContactGroupMember_ContactJoined
UNION
Select db_name() as DBNAME, 'view_ToDoCoachingEnrollmentCompleted' as ViewName, count(*) as RowCNT from view_ToDoCoachingEnrollmentCompleted
UNION
Select db_name() as DBNAME, 'view_EDW_CoachingDetail' as ViewName, count(*) as RowCNT from view_EDW_CoachingDetail
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingEvalHAQA_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingEvalHAQA_Joined
UNION
Select db_name() as DBNAME, 'View_EDW_HealthAssesmentQuestions' as ViewName, count(*) as RowCNT from View_EDW_HealthAssesmentQuestions
UNION
Select db_name() as DBNAME, 'View_HFit_HSLearnMoreDocument_Joined' as ViewName, count(*) as RowCNT from View_HFit_HSLearnMoreDocument_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_RoleResourcePermission_Joined' as ViewName, count(*) as RowCNT from View_CMS_RoleResourcePermission_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_HealthAssesment' as ViewName, count(*) as RowCNT from view_EDW_HealthAssesment
UNION
Select db_name() as DBNAME, 'View_HFit_ScheduledNotification_Joined' as ViewName, count(*) as RowCNT from View_HFit_ScheduledNotification_Joined
UNION
Select db_name() as DBNAME, 'View_EDW_HealthAssesmentAnswers' as ViewName, count(*) as RowCNT from View_EDW_HealthAssesmentAnswers
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingLibraryResource_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingLibraryResource_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Site_DocumentCount' as ViewName, count(*) as RowCNT from View_CMS_Site_DocumentCount
UNION
Select db_name() as DBNAME, 'View_Document_Attachment' as ViewName, count(*) as RowCNT from View_Document_Attachment
UNION
Select db_name() as DBNAME, 'view_EDW_HealthAssesmentClientView' as ViewName, count(*) as RowCNT from view_EDW_HealthAssesmentClientView
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingLibrarySettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingLibrarySettings_Joined
UNION
Select db_name() as DBNAME, 'View_Hfit_RewardsUserActivityDetailOverrideActivity' as ViewName, count(*) as RowCNT from View_Hfit_RewardsUserActivityDetailOverrideActivity
UNION
Select db_name() as DBNAME, 'view_EDW_HealthAssesmentDeffinition' as ViewName, count(*) as RowCNT from view_EDW_HealthAssesmentDeffinition
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingLibraryHealthArea_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingLibraryHealthArea_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_HealthAssesmentDeffinitionCustom' as ViewName, count(*) as RowCNT from view_EDW_HealthAssesmentDeffinitionCustom
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingLibraryResources_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingLibraryResources_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_BioMetrics' as ViewName, count(*) as RowCNT from view_HFit_BioMetrics
UNION
Select db_name() as DBNAME, 'view_EDW_HealthInterestDetail' as ViewName, count(*) as RowCNT from view_EDW_HealthInterestDetail
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingEvalHARiskModule_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingEvalHARiskModule_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_ScreeningsFromTrackers' as ViewName, count(*) as RowCNT from view_EDW_ScreeningsFromTrackers
UNION
Select db_name() as DBNAME, 'View_HFit_HSHealthMeasuresSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_HSHealthMeasuresSettings_Joined
UNION
Select db_name() as DBNAME, 'View_OM_ContactGroupMember_AccountJoined' as ViewName, count(*) as RowCNT from View_OM_ContactGroupMember_AccountJoined
UNION
Select db_name() as DBNAME, 'view_EDW_TrackerMetadata' as ViewName, count(*) as RowCNT from view_EDW_TrackerMetadata
UNION
Select db_name() as DBNAME, 'View_HFit_ContentBlock_Joined' as ViewName, count(*) as RowCNT from View_HFit_ContentBlock_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_UsersWithUserSettings' as ViewName, count(*) as RowCNT from View_HFit_UsersWithUserSettings
UNION
Select db_name() as DBNAME, 'View_Newsletter_Subscriptions_Joined' as ViewName, count(*) as RowCNT from View_Newsletter_Subscriptions_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_TrackerShots' as ViewName, count(*) as RowCNT from view_EDW_TrackerShots
UNION
Select db_name() as DBNAME, 'View_Hfit_MyHealthSettings_Joined' as ViewName, count(*) as RowCNT from View_Hfit_MyHealthSettings_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_UsersWithUserSettingsBySite' as ViewName, count(*) as RowCNT from View_HFit_UsersWithUserSettingsBySite
UNION
Select db_name() as DBNAME, 'view_EDW_TrackerTests' as ViewName, count(*) as RowCNT from view_EDW_TrackerTests
UNION
Select db_name() as DBNAME, 'View_HFit_PostEmptyFeed_Joined' as ViewName, count(*) as RowCNT from View_HFit_PostEmptyFeed_Joined
UNION
Select db_name() as DBNAME, 'View_Forums_GroupForumPost_Joined' as ViewName, count(*) as RowCNT from View_Forums_GroupForumPost_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssessmentConfiguration_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssessmentConfiguration_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssessmentModuleConfiguration_Joined' as ViewName, count(*) as RowCNT from View_HFit_HealthAssessmentModuleConfiguration_Joined
UNION
Select db_name() as DBNAME, 'View_HFIT_RewardGroupWithContactGroupIDs' as ViewName, count(*) as RowCNT from View_HFIT_RewardGroupWithContactGroupIDs
UNION
Select db_name() as DBNAME, 'View_HFit_RightsResponsibilities_Joined' as ViewName, count(*) as RowCNT from View_HFit_RightsResponsibilities_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_SiteRoleResourceUIElement_Joined' as ViewName, count(*) as RowCNT from View_CMS_SiteRoleResourceUIElement_Joined
UNION
Select db_name() as DBNAME, 'view_ToDoScreeningsCompleted' as ViewName, count(*) as RowCNT from view_ToDoScreeningsCompleted
UNION
Select db_name() as DBNAME, 'View_HFit_LoginPageSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_LoginPageSettings_Joined
UNION
Select db_name() as DBNAME, 'View_Rewards_ScreeningEventsNew' as ViewName, count(*) as RowCNT from View_Rewards_ScreeningEventsNew
UNION
Select db_name() as DBNAME, 'View_Integration_Task_Joined' as ViewName, count(*) as RowCNT from View_Integration_Task_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_EligibilityHistory' as ViewName, count(*) as RowCNT from view_EDW_EligibilityHistory
UNION
Select db_name() as DBNAME, 'View_HFit_PLPPackageContent_Joined' as ViewName, count(*) as RowCNT from View_HFit_PLPPackageContent_Joined
UNION
Select db_name() as DBNAME, 'View_UserGoalModification' as ViewName, count(*) as RowCNT from View_UserGoalModification
UNION
Select db_name() as DBNAME, 'View_HFit_UserGoals' as ViewName, count(*) as RowCNT from View_HFit_UserGoals
UNION
Select db_name() as DBNAME, 'View_Hfit_MarketplaceProduct_Joined' as ViewName, count(*) as RowCNT from View_Hfit_MarketplaceProduct_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_RewardGroup_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardGroup_Joined
UNION
Select db_name() as DBNAME, 'View_hfit_ChallengeTeams_Joined' as ViewName, count(*) as RowCNT from View_hfit_ChallengeTeams_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_UserGoalModification' as ViewName, count(*) as RowCNT from View_HFit_UserGoalModification
UNION
Select db_name() as DBNAME, 'View_HFit_PostChallenge_Joined' as ViewName, count(*) as RowCNT from View_HFit_PostChallenge_Joined
UNION
Select db_name() as DBNAME, 'View_hfit_ChallengeAbout_Joined' as ViewName, count(*) as RowCNT from View_hfit_ChallengeAbout_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_HARediness' as ViewName, count(*) as RowCNT from view_HFit_HARediness
UNION
Select db_name() as DBNAME, 'View_PageInfo' as ViewName, count(*) as RowCNT from View_PageInfo
UNION
Select db_name() as DBNAME, 'View_hfit_ChallengeTeam_Joined' as ViewName, count(*) as RowCNT from View_hfit_ChallengeTeam_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_Eligibility' as ViewName, count(*) as RowCNT from view_EDW_Eligibility
UNION
Select db_name() as DBNAME, 'View_hfit_challengeGeneralSettings_Joined' as ViewName, count(*) as RowCNT from View_hfit_challengeGeneralSettings_Joined
UNION
Select db_name() as DBNAME, 'View_UserToContact' as ViewName, count(*) as RowCNT from View_UserToContact
UNION
Select db_name() as DBNAME, 'View_Membership_MembershipUser_Joined' as ViewName, count(*) as RowCNT from View_Membership_MembershipUser_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengePostTemplate_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengePostTemplate_Joined
UNION
Select db_name() as DBNAME, 'View_PageInfo_Blank' as ViewName, count(*) as RowCNT from View_PageInfo_Blank
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengeRegistrationSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengeRegistrationSettings_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengeRegistrationPostTemplate_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengeRegistrationPostTemplate_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_RoleEligibility' as ViewName, count(*) as RowCNT from view_EDW_RoleEligibility
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengePPTRegisteredPostTemplate_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengePPTRegisteredPostTemplate_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengeTrackerDailySum' as ViewName, count(*) as RowCNT from View_HFit_ChallengeTrackerDailySum
UNION
Select db_name() as DBNAME, 'View_hFit_ChallengePPTEligiblePostTemplate_Joined' as ViewName, count(*) as RowCNT from View_hFit_ChallengePPTEligiblePostTemplate_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Tree_Joined_Attachments' as ViewName, count(*) as RowCNT from View_CMS_Tree_Joined_Attachments
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengePPTRegisteredRDPostTemplate_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ContactGroupsToRoles' as ViewName, count(*) as RowCNT from View_HFit_ContactGroupsToRoles
UNION
Select db_name() as DBNAME, 'View_CMS_UserDocuments' as ViewName, count(*) as RowCNT from View_CMS_UserDocuments
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengeNewsletter_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengeNewsletter_Joined
UNION
Select db_name() as DBNAME, 'view_SchemaDiff' as ViewName, count(*) as RowCNT from view_SchemaDiff
UNION
Select db_name() as DBNAME, 'View_PM_ProjectStatus_Joined' as ViewName, count(*) as RowCNT from View_PM_ProjectStatus_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengePPTEligibleCDPostTemplate_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengePPTEligibleCDPostTemplate_Joined
UNION
Select db_name() as DBNAME, 'view_SchemaChangeMonitor' as ViewName, count(*) as RowCNT from view_SchemaChangeMonitor
UNION
Select db_name() as DBNAME, 'View_HFit_ConsentAndRelease_Joined' as ViewName, count(*) as RowCNT from View_HFit_ConsentAndRelease_Joined
UNION
Select db_name() as DBNAME, 'view_SchemaChangeMonitor_rptData' as ViewName, count(*) as RowCNT from view_SchemaChangeMonitor_rptData
UNION
Select db_name() as DBNAME, 'View_CMS_User_With_HFitCustomSettings' as ViewName, count(*) as RowCNT from View_CMS_User_With_HFitCustomSettings
UNION
Select db_name() as DBNAME, 'View_HFit_UserGoalHistory_Base' as ViewName, count(*) as RowCNT from View_HFit_UserGoalHistory_Base
UNION
Select db_name() as DBNAME, 'View_HFit_HA_UseAndDisclosure_Joined' as ViewName, count(*) as RowCNT from View_HFit_HA_UseAndDisclosure_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_UserGoalHistory' as ViewName, count(*) as RowCNT from View_HFit_UserGoalHistory
UNION
Select db_name() as DBNAME, 'View_hfit_challenge_Joined' as ViewName, count(*) as RowCNT from View_hfit_challenge_Joined
UNION
Select db_name() as DBNAME, 'View_PM_ProjectTaskStatus_Joined' as ViewName, count(*) as RowCNT from View_PM_ProjectTaskStatus_Joined
UNION
Select db_name() as DBNAME, 'View_Messaging_ContactList' as ViewName, count(*) as RowCNT from View_Messaging_ContactList
UNION
Select db_name() as DBNAME, 'View_HFit_ChallengeRegistrationEmail_Joined' as ViewName, count(*) as RowCNT from View_HFit_ChallengeRegistrationEmail_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_EventLog_Joined' as ViewName, count(*) as RowCNT from View_CMS_EventLog_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HESChallenge_Joined' as ViewName, count(*) as RowCNT from View_HFit_HESChallenge_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_CoachingPPTAvailable' as ViewName, count(*) as RowCNT from view_EDW_CoachingPPTAvailable
UNION
Select db_name() as DBNAME, 'View_hfit_ChallengeFAQ_Joined' as ViewName, count(*) as RowCNT from View_hfit_ChallengeFAQ_Joined
UNION
Select db_name() as DBNAME, 'View_ToDoHealthAssesmentCompleted' as ViewName, count(*) as RowCNT from View_ToDoHealthAssesmentCompleted
UNION
Select db_name() as DBNAME, 'View_CMS_Tree_Joined_Regular' as ViewName, count(*) as RowCNT from View_CMS_Tree_Joined_Regular
UNION
Select db_name() as DBNAME, 'View_hfit_challengeBase_Joined' as ViewName, count(*) as RowCNT from View_hfit_challengeBase_Joined
UNION
Select db_name() as DBNAME, 'view_ToDoHealthAdvisingCompleted' as ViewName, count(*) as RowCNT from view_ToDoHealthAdvisingCompleted
UNION
Select db_name() as DBNAME, 'View_CMS_Tree_Joined_Linked' as ViewName, count(*) as RowCNT from View_CMS_Tree_Joined_Linked
UNION
Select db_name() as DBNAME, 'View_hfit_challengeOffering_Joined' as ViewName, count(*) as RowCNT from View_hfit_challengeOffering_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Tree_Joined' as ViewName, count(*) as RowCNT from View_CMS_Tree_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssessmentProfessionallyCollectedBiometrics' as ViewName, count(*) as RowCNT from View_HFit_HealthAssessmentProfessionallyCollectedBiometrics
UNION
Select db_name() as DBNAME, 'View_HFit_EmailTemplate_Joined' as ViewName, count(*) as RowCNT from View_HFit_EmailTemplate_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_Tree_Joined_Versions' as ViewName, count(*) as RowCNT from View_CMS_Tree_Joined_Versions
UNION
Select db_name() as DBNAME, 'View_HFit_HSBiometricChart_Joined' as ViewName, count(*) as RowCNT from View_HFit_HSBiometricChart_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_File_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_File_Joined
UNION
Select db_name() as DBNAME, 'View_Hfit_SecurityQuestionSettings_Joined' as ViewName, count(*) as RowCNT from View_Hfit_SecurityQuestionSettings_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ProgramFeedNotificationSettings_Joined' as ViewName, count(*) as RowCNT from View_HFit_ProgramFeedNotificationSettings_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Article_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Article_Joined
UNION
Select db_name() as DBNAME, 'View_hfit_ContactGroupsToUsers' as ViewName, count(*) as RowCNT from View_hfit_ContactGroupsToUsers
UNION
Select db_name() as DBNAME, 'View_BookingSystem_Joined' as ViewName, count(*) as RowCNT from View_BookingSystem_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_UserSearch_Joined' as ViewName, count(*) as RowCNT from View_HFit_UserSearch_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Blog_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Blog_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_Configuration_Joined' as ViewName, count(*) as RowCNT from View_HFit_Configuration_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssessmentLastUserResponses_LastCompleted' as ViewName, count(*) as RowCNT from View_HFit_HealthAssessmentLastUserResponses_LastCompleted
UNION
Select db_name() as DBNAME, 'View_CONTENT_BlogMonth_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_BlogMonth_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_FeatureConfiguration' as ViewName, count(*) as RowCNT from View_HFit_FeatureConfiguration
UNION
Select db_name() as DBNAME, 'View_HFIT_Configuration_CMCoaching_Joined' as ViewName, count(*) as RowCNT from View_HFIT_Configuration_CMCoaching_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_BlogPost_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_BlogPost_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_GroupConfiguration' as ViewName, count(*) as RowCNT from View_HFit_GroupConfiguration
UNION
Select db_name() as DBNAME, 'View_hfit_TemporalConfigurationContainer_Joined' as ViewName, count(*) as RowCNT from View_hfit_TemporalConfigurationContainer_Joined
UNION
Select db_name() as DBNAME, 'view_EDW_RewardUserLevel' as ViewName, count(*) as RowCNT from view_EDW_RewardUserLevel
UNION
Select db_name() as DBNAME, 'View_CONTENT_Cellphone_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Cellphone_Joined
UNION
Select db_name() as DBNAME, 'View_Hfit_Client_Joined' as ViewName, count(*) as RowCNT from View_Hfit_Client_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Event_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Event_Joined
UNION
Select db_name() as DBNAME, 'View_Hfit_TimezoneConfiguration_Joined' as ViewName, count(*) as RowCNT from View_Hfit_TimezoneConfiguration_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_BookingEvent_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_BookingEvent_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_UsersWithTrackersFromScreening' as ViewName, count(*) as RowCNT from view_HFit_UsersWithTrackersFromScreening
UNION
Select db_name() as DBNAME, 'View_HFit_Configuration_LMCoaching_Joined' as ViewName, count(*) as RowCNT from View_HFit_Configuration_LMCoaching_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_FAQ_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_FAQ_Joined
UNION
Select db_name() as DBNAME, 'View_Custom_Hfit_ChallengeTeamMembers' as ViewName, count(*) as RowCNT from View_Custom_Hfit_ChallengeTeamMembers
UNION
Select db_name() as DBNAME, 'view_HFit_Reports_ScreeningCompleters' as ViewName, count(*) as RowCNT from view_HFit_Reports_ScreeningCompleters
UNION
Select db_name() as DBNAME, 'View_HFit_Configuration_CallLogCoaching_Joined' as ViewName, count(*) as RowCNT from View_HFit_Configuration_CallLogCoaching_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_ImageGallery_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_ImageGallery_Joined
UNION
Select db_name() as DBNAME, 'View_Rewards_ScreeningEvents' as ViewName, count(*) as RowCNT from View_Rewards_ScreeningEvents
UNION
Select db_name() as DBNAME, 'View_HFIT_Configuration_HACoaching_Joined' as ViewName, count(*) as RowCNT from View_HFIT_Configuration_HACoaching_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Job_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Job_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ProfessionallyCollectedBiometrics' as ViewName, count(*) as RowCNT from View_HFit_ProfessionallyCollectedBiometrics
UNION
Select db_name() as DBNAME, 'View_Custom_HFit_UserEligibilityData' as ViewName, count(*) as RowCNT from View_Custom_HFit_UserEligibilityData
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingEnrollment' as ViewName, count(*) as RowCNT from View_HFit_CoachingEnrollment
UNION
Select db_name() as DBNAME, 'View_HFIT_Configuration_Screening_Joined' as ViewName, count(*) as RowCNT from View_HFIT_Configuration_Screening_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_KBArticle_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_KBArticle_Joined
UNION
Select db_name() as DBNAME, 'View_Hfit_GoalTracker' as ViewName, count(*) as RowCNT from View_Hfit_GoalTracker
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingCallLogTemporalContainer_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingCallLogTemporalContainer_Joined
UNION
Select db_name() as DBNAME, 'View_CMS_UserRole_Joined' as ViewName, count(*) as RowCNT from View_CMS_UserRole_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Laptop_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Laptop_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_UsersCrossSiteSearch' as ViewName, count(*) as RowCNT from View_HFit_UsersCrossSiteSearch
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingLMTemporalContainer_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingLMTemporalContainer_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_News_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_News_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_Reports_HRACompleters' as ViewName, count(*) as RowCNT from view_HFit_Reports_HRACompleters
UNION
Select db_name() as DBNAME, 'View_hfit_CoachingCMTemporalContainer_Joined' as ViewName, count(*) as RowCNT from View_hfit_CoachingCMTemporalContainer_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Office_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Office_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_CoachingHATemporalContainer_Joined' as ViewName, count(*) as RowCNT from View_HFit_CoachingHATemporalContainer_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_MenuItem_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_MenuItem_Joined
UNION
Select db_name() as DBNAME, 'View_Messaging_IgnoreList' as ViewName, count(*) as RowCNT from View_Messaging_IgnoreList
UNION
Select db_name() as DBNAME, 'View_HFit_ScreeningTemporalContainer_Joined' as ViewName, count(*) as RowCNT from View_HFit_ScreeningTemporalContainer_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_PressRelease_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_PressRelease_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_HealthAssessmentUserAnswer' as ViewName, count(*) as RowCNT from view_HFit_HealthAssessmentUserAnswer
UNION
Select db_name() as DBNAME, 'View_HFit_RewardTriggerTobaccoParameter_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardTriggerTobaccoParameter_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Product_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Product_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_SimpleArticle_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_SimpleArticle_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_RewardTrigger_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardTrigger_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_RewardParameterBase_Joined' as ViewName, count(*) as RowCNT from View_HFit_RewardParameterBase_Joined
UNION
Select db_name() as DBNAME, 'View_CONTENT_Smartphone_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Smartphone_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentQuestions' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentQuestions
UNION
Select db_name() as DBNAME, 'View_CMS_User' as ViewName, count(*) as RowCNT from View_CMS_User
UNION
Select db_name() as DBNAME, 'View_CONTENT_Wireframe_Joined' as ViewName, count(*) as RowCNT from View_CONTENT_Wireframe_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentPageBreaks' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentPageBreaks
UNION
Select db_name() as DBNAME, 'view_Statbridge_GetAppointments' as ViewName, count(*) as RowCNT from view_Statbridge_GetAppointments
UNION
Select db_name() as DBNAME, 'View_Community_Member' as ViewName, count(*) as RowCNT from View_Community_Member
UNION
Select db_name() as DBNAME, 'View_CMS_UserRole_MembershipRole_ValidOnly_Joined' as ViewName, count(*) as RowCNT from View_CMS_UserRole_MembershipRole_ValidOnly_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_SsoRequest_Joined' as ViewName, count(*) as RowCNT from View_HFit_SsoRequest_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HealthAssesmentAnswers' as ViewName, count(*) as RowCNT from View_HFit_HealthAssesmentAnswers
UNION
Select db_name() as DBNAME, 'view_Statbridge_ScreeningEligibility' as ViewName, count(*) as RowCNT from view_Statbridge_ScreeningEligibility
UNION
Select db_name() as DBNAME, 'View_HFit_SsoRequestAttributes_Joined' as ViewName, count(*) as RowCNT from View_HFit_SsoRequestAttributes_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_SecurityQuestion_Joined' as ViewName, count(*) as RowCNT from View_HFit_SecurityQuestion_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_ClientContact_Joined' as ViewName, count(*) as RowCNT from View_HFit_ClientContact_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_WellnessGoal_Joined' as ViewName, count(*) as RowCNT from View_HFit_WellnessGoal_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_Message_Joined' as ViewName, count(*) as RowCNT from View_HFit_Message_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_Event_Joined' as ViewName, count(*) as RowCNT from View_HFit_Event_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_Class_Joined' as ViewName, count(*) as RowCNT from View_HFit_Class_Joined
UNION
Select db_name() as DBNAME, 'view_HFit_HealthAssesmentUserResponses' as ViewName, count(*) as RowCNT from view_HFit_HealthAssesmentUserResponses
UNION
Select db_name() as DBNAME, 'view_EDW_RewardsDefinition' as ViewName, count(*) as RowCNT from view_EDW_RewardsDefinition
UNION
Select db_name() as DBNAME, 'View_HFit_RegistrationWelcome_Joined' as ViewName, count(*) as RowCNT from View_HFit_RegistrationWelcome_Joined
UNION
Select db_name() as DBNAME, 'View_HFit_HRA_Joined' as ViewName, count(*) as RowCNT from View_HFit_HRA_Joined

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
