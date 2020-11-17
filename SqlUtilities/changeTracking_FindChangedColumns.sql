
SELECT
       ', change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID (''' + table_name + ''') , ''' + column_name + ''', ''columnid'') , CTE.sys_change_columns) AS [' + column_name + '_cg] '
       FROM INFORMATION_SCHEMA.COLUMNS
       WHERE table_name = 'CMS_UserSettings';

GO

DROP TABLE
     STAGING_CMS_UserSettings_Update_History;

GO

SELECT
       CTE.UserSettingsid
     , SYS_CHANGE_VERSION
     , SYS_CHANGE_OPERATION
     , SYS_CHANGE_COLUMNS
     , '                                                            ' AS CurrUser
     , '                                                            ' AS SysUser
     , '                                                            ' AS IPADDR
     , GETDATE () AS commit_time
     , GETDATE () AS LastModifiedDate
     , @@SERVERNAME AS SVR
     , DB_NAME () AS DBNAME
       --********************************************     
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HealthAdvisingEvaluationDate', 'columnid') , CTE.sys_change_columns) AS [HealthAdvisingEvaluationDate_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCallLogStatus', 'columnid') , CTE.sys_change_columns) AS [HFitCallLogStatus_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCallLogStatusDate', 'columnid') , CTE.sys_change_columns) AS [HFitCallLogStatusDate_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachId', 'columnid') , CTE.sys_change_columns) AS [HFitCoachId_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachingDeliveryMethod', 'columnid') , CTE.sys_change_columns) AS [HFitCoachingDeliveryMethod_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachingEnrollDate', 'columnid') , CTE.sys_change_columns) AS [HFitCoachingEnrollDate_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachingOptOutDate', 'columnid') , CTE.sys_change_columns) AS [HFitCoachingOptOutDate_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachingOptOutItemID', 'columnid') , CTE.sys_change_columns) AS [HFitCoachingOptOutItemID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachingOptOutSentDate', 'columnid') , CTE.sys_change_columns) AS [HFitCoachingOptOutSentDate_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachingServiceLevel', 'columnid') , CTE.sys_change_columns) AS [HFitCoachingServiceLevel_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachSession1Date', 'columnid') , CTE.sys_change_columns) AS [HFitCoachSession1Date_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachSystemCoachID', 'columnid') , CTE.sys_change_columns) AS [HFitCoachSystemCoachID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachSystemLastActivity', 'columnid') , CTE.sys_change_columns) AS [HFitCoachSystemLastActivity_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachSystemNextActivity', 'columnid') , CTE.sys_change_columns) AS [HFitCoachSystemNextActivity_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitCoachWebLastActivity', 'columnid') , CTE.sys_change_columns) AS [HFitCoachWebLastActivity_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComActivitiesNotifyEmail', 'columnid') , CTE.sys_change_columns) AS [HFitComActivitiesNotifyEmail_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComActivitiesNotifyText', 'columnid') , CTE.sys_change_columns) AS [HFitComActivitiesNotifyText_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComCoachingTrackingEmail', 'columnid') , CTE.sys_change_columns) AS [HFitComCoachingTrackingEmail_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComCoachingTrackingText', 'columnid') , CTE.sys_change_columns) AS [HFitComCoachingTrackingText_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComInboxNotifyByEmail', 'columnid') , CTE.sys_change_columns) AS [HFitComInboxNotifyByEmail_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComInboxNotifyByText', 'columnid') , CTE.sys_change_columns) AS [HFitComInboxNotifyByText_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComScreeningSchedulersEmail', 'columnid') , CTE.sys_change_columns) AS [HFitComScreeningSchedulersEmail_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComScreeningSchedulersText', 'columnid') , CTE.sys_change_columns) AS [HFitComScreeningSchedulersText_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComTipOfTheDayNotifyByEmail', 'columnid') , CTE.sys_change_columns) AS [HFitComTipOfTheDayNotifyByEmail_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitComTipOfTheDayNotifyByText', 'columnid') , CTE.sys_change_columns) AS [HFitComTipOfTheDayNotifyByText_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitHealthVision', 'columnid') , CTE.sys_change_columns) AS [HFitHealthVision_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitIsConditionManagement', 'columnid') , CTE.sys_change_columns) AS [HFitIsConditionManagement_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitIsHraEnabled', 'columnid') , CTE.sys_change_columns) AS [HFitIsHraEnabled_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitIsIncentivesEnabled', 'columnid') , CTE.sys_change_columns) AS [HFitIsIncentivesEnabled_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitIsPlatformEnabled', 'columnid') , CTE.sys_change_columns) AS [HFitIsPlatformEnabled_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitPrimaryContactGuid', 'columnid') , CTE.sys_change_columns) AS [HFitPrimaryContactGuid_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitPrimaryContactID', 'columnid') , CTE.sys_change_columns) AS [HFitPrimaryContactID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitTrackerReminderDisplayed', 'columnid') , CTE.sys_change_columns) AS [HFitTrackerReminderDisplayed_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserAgreesToTerms', 'columnid') , CTE.sys_change_columns) AS [HFitUserAgreesToTerms_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserAltPreferredPhone', 'columnid') , CTE.sys_change_columns) AS [HFitUserAltPreferredPhone_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserAltPreferredPhoneExt', 'columnid') , CTE.sys_change_columns) AS [HFitUserAltPreferredPhoneExt_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserAltPreferredPhoneType', 'columnid') , CTE.sys_change_columns) AS [HFitUserAltPreferredPhoneType_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserIsRegistered', 'columnid') , CTE.sys_change_columns) AS [HFitUserIsRegistered_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserMobilePhone', 'columnid') , CTE.sys_change_columns) AS [HFitUserMobilePhone_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserMpiNumber', 'columnid') , CTE.sys_change_columns) AS [HFitUserMpiNumber_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserPhoneExt', 'columnid') , CTE.sys_change_columns) AS [HFitUserPhoneExt_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserPhoneType', 'columnid') , CTE.sys_change_columns) AS [HFitUserPhoneType_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserPreferredCallTime', 'columnid') , CTE.sys_change_columns) AS [HFitUserPreferredCallTime_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserPreferredEmail', 'columnid') , CTE.sys_change_columns) AS [HFitUserPreferredEmail_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserPreferredFirstName', 'columnid') , CTE.sys_change_columns) AS [HFitUserPreferredFirstName_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HfitUserPreferredMailingAddress', 'columnid') , CTE.sys_change_columns) AS [HfitUserPreferredMailingAddress_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserPreferredMailingAddress2', 'columnid') , CTE.sys_change_columns) AS [HFitUserPreferredMailingAddress2_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HfitUserPreferredMailingCity', 'columnid') , CTE.sys_change_columns) AS [HfitUserPreferredMailingCity_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HfitUserPreferredMailingPostalCode', 'columnid') , CTE.sys_change_columns) AS [HfitUserPreferredMailingPostalCode_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HfitUserPreferredMailingState', 'columnid') , CTE.sys_change_columns) AS [HfitUserPreferredMailingState_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserPreferredPhone', 'columnid') , CTE.sys_change_columns) AS [HFitUserPreferredPhone_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserRegistrationDate', 'columnid') , CTE.sys_change_columns) AS [HFitUserRegistrationDate_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HfitUserSsoId', 'columnid') , CTE.sys_change_columns) AS [HfitUserSsoId_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'HFitUserTypeID', 'columnid') , CTE.sys_change_columns) AS [HFitUserTypeID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'SocialSecurity', 'columnid') , CTE.sys_change_columns) AS [SocialSecurity_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserAccountLockReason', 'columnid') , CTE.sys_change_columns) AS [UserAccountLockReason_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserActivatedByUserID', 'columnid') , CTE.sys_change_columns) AS [UserActivatedByUserID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserActivationDate', 'columnid') , CTE.sys_change_columns) AS [UserActivationDate_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserActivityPoints', 'columnid') , CTE.sys_change_columns) AS [UserActivityPoints_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserAuthenticationGUID', 'columnid') , CTE.sys_change_columns) AS [UserAuthenticationGUID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserAvatarID', 'columnid') , CTE.sys_change_columns) AS [UserAvatarID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserAvatarType', 'columnid') , CTE.sys_change_columns) AS [UserAvatarType_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserBadgeID', 'columnid') , CTE.sys_change_columns) AS [UserBadgeID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserBlogComments', 'columnid') , CTE.sys_change_columns) AS [UserBlogComments_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserBlogPosts', 'columnid') , CTE.sys_change_columns) AS [UserBlogPosts_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserBounces', 'columnid') , CTE.sys_change_columns) AS [UserBounces_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserCampaign', 'columnid') , CTE.sys_change_columns) AS [UserCampaign_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserCustomData', 'columnid') , CTE.sys_change_columns) AS [UserCustomData_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserDashboardApplications', 'columnid') , CTE.sys_change_columns) AS [UserDashboardApplications_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserDataComPassword', 'columnid') , CTE.sys_change_columns) AS [UserDataComPassword_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserDataComUser', 'columnid') , CTE.sys_change_columns) AS [UserDataComUser_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserDateOfBirth', 'columnid') , CTE.sys_change_columns) AS [UserDateOfBirth_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserDescription', 'columnid') , CTE.sys_change_columns) AS [UserDescription_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserDialogsConfiguration', 'columnid') , CTE.sys_change_columns) AS [UserDialogsConfiguration_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserFacebookID', 'columnid') , CTE.sys_change_columns) AS [UserFacebookID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserForumPosts', 'columnid') , CTE.sys_change_columns) AS [UserForumPosts_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserGender', 'columnid') , CTE.sys_change_columns) AS [UserGender_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserIM', 'columnid') , CTE.sys_change_columns) AS [UserIM_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserInvalidLogOnAttempts', 'columnid') , CTE.sys_change_columns) AS [UserInvalidLogOnAttempts_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserInvalidLogOnAttemptsHash', 'columnid') , CTE.sys_change_columns) AS [UserInvalidLogOnAttemptsHash_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserLinkedInID', 'columnid') , CTE.sys_change_columns) AS [UserLinkedInID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserLogActivities', 'columnid') , CTE.sys_change_columns) AS [UserLogActivities_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserMessageBoardPosts', 'columnid') , CTE.sys_change_columns) AS [UserMessageBoardPosts_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserMessagingNotificationEmail', 'columnid') , CTE.sys_change_columns) AS [UserMessagingNotificationEmail_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserNickName', 'columnid') , CTE.sys_change_columns) AS [UserNickName_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserPasswordLastChanged', 'columnid') , CTE.sys_change_columns) AS [UserPasswordLastChanged_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserPasswordRequestHash', 'columnid') , CTE.sys_change_columns) AS [UserPasswordRequestHash_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserPhone', 'columnid') , CTE.sys_change_columns) AS [UserPhone_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserPicture', 'columnid') , CTE.sys_change_columns) AS [UserPicture_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserPosition', 'columnid') , CTE.sys_change_columns) AS [UserPosition_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserPreferences', 'columnid') , CTE.sys_change_columns) AS [UserPreferences_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserRegistrationInfo', 'columnid') , CTE.sys_change_columns) AS [UserRegistrationInfo_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSecurityQuestionAnswer1', 'columnid') , CTE.sys_change_columns) AS [UserSecurityQuestionAnswer1_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSecurityQuestionAnswer2', 'columnid') , CTE.sys_change_columns) AS [UserSecurityQuestionAnswer2_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSecurityQuestionAnswer3', 'columnid') , CTE.sys_change_columns) AS [UserSecurityQuestionAnswer3_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSecurityQuestionGuid1', 'columnid') , CTE.sys_change_columns) AS [UserSecurityQuestionGuid1_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSecurityQuestionGuid2', 'columnid') , CTE.sys_change_columns) AS [UserSecurityQuestionGuid2_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSecurityQuestionGuid3', 'columnid') , CTE.sys_change_columns) AS [UserSecurityQuestionGuid3_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSettingsID', 'columnid') , CTE.sys_change_columns) AS [UserSettingsID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSettingsUserGUID', 'columnid') , CTE.sys_change_columns) AS [UserSettingsUserGUID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSettingsUserID', 'columnid') , CTE.sys_change_columns) AS [UserSettingsUserID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserShowIntroductionTile', 'columnid') , CTE.sys_change_columns) AS [UserShowIntroductionTile_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSignature', 'columnid') , CTE.sys_change_columns) AS [UserSignature_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserSkype', 'columnid') , CTE.sys_change_columns) AS [UserSkype_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserTimeZoneID', 'columnid') , CTE.sys_change_columns) AS [UserTimeZoneID_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserURLReferrer', 'columnid') , CTE.sys_change_columns) AS [UserURLReferrer_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserUsedWebParts', 'columnid') , CTE.sys_change_columns) AS [UserUsedWebParts_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserUsedWidgets', 'columnid') , CTE.sys_change_columns) AS [UserUsedWidgets_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'UserWaitingForApproval', 'columnid') , CTE.sys_change_columns) AS [UserWaitingForApproval_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'WellnessGoalGuid', 'columnid') , CTE.sys_change_columns) AS [WellnessGoalGuid_cg] 
	   , change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSettings') , 'WindowsLiveID', 'columnid') , CTE.sys_change_columns) AS [WindowsLiveID_cg] 
--********************************************     
INTO
     STAGING_CMS_UserSettings_Update_History
--********************************************     
       FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CTE;

GO
ALTER TABLE STAGING_CMS_UserSettings_Update_History
ADD
            CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_CurrUser  DEFAULT USER_NAME () FOR CurrUser;
ALTER TABLE STAGING_CMS_UserSettings_Update_History
ADD
            CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_SysUser  DEFAULT SUSER_SNAME () FOR SysUser;
ALTER TABLE STAGING_CMS_UserSettings_Update_History
ADD
            CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_IPADDR  DEFAULT
            CAST (CONNECTIONPROPERTY ('client_net_address') AS nvarchar (50)) FOR IPADDR;
GO

EXEC proc_genSelectInto 'STAGING_CMS_UserSettings_Update_History';


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
