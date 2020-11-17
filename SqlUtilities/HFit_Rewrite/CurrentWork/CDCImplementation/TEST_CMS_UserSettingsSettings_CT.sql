
-- TEST_CMS_UserSettingsSettings_CT.sql 

--drop table TEMP_CMS_UserSettings_1000
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE
                      name = 'TEMP_CMS_UserSettings_1000') 
    BEGIN
        SELECT
               * INTO
                      TEMP_CMS_UserSettings_1000
               FROM CMS_UserSettings;
        CREATE UNIQUE CLUSTERED INDEX PI_TEMP_CMS_UserSettings_1000 ON dbo.TEMP_CMS_UserSettings_1000
        (
        UserSettingsID ASC
        );
    END;
GO

-- select count(*) from TEMP_CMS_UserSettings_1000
-- select count(*) from CMS_UserSettings
-- select top 100 * from CMS_UserSettings
UPDATE CMS_UserSettings
       SET
           UserNickName = 'NMN'
WHERE
      UserSettingsID IN (SELECT TOP 1000
                                UserSettingsID
                                FROM CMS_UserSettings) 
  AND UserNickName IS NULL;

SELECT
       COUNT (*)  --,CT.UserSettingsID, CT.SYS_CHANGE_VERSION, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'U';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM STAGING_CMS_UserSettings_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CMS_UserSettings;

DELETE FROM CMS_UserSettings
WHERE
      UserSettingsID IN (SELECT TOP 1000
                                UserSettingsID
                                FROM CMS_UserSettings) ;

SELECT
       COUNT (*) 
--,CT.UserSettingsID
--, CT.SYS_CHANGE_VERSION
--, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'D';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM STAGING_CMS_UserSettings_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CMS_UserSettings;

GO
SET IDENTITY_INSERT CMS_UserSettings ON;
GO

WITH CTE (
     UserSettingsID) 
    AS (
    SELECT
           UserSettingsID
           FROM TEMP_CMS_UserSettings_1000
    EXCEPT
    SELECT
           UserSettingsID
           FROM CMS_UserSettings
    ) 
    INSERT INTO CMS_UserSettings
    (
           UserSettingsID
         , UserNickName
         , UserPicture
         , UserSignature
         , UserURLReferrer
         , UserCampaign
         , UserMessagingNotificationEmail
         , UserCustomData
         , UserRegistrationInfo
         , UserPreferences
         , UserActivationDate
         , UserActivatedByUserID
         , UserTimeZoneID
         , UserAvatarID
         , UserBadgeID
         , UserActivityPoints
         , UserForumPosts
         , UserBlogComments
         , UserGender
         , UserDateOfBirth
         , UserMessageBoardPosts
         , UserSettingsUserGUID
         , UserSettingsUserID
         , WindowsLiveID
         , UserBlogPosts
         , UserWaitingForApproval
         , UserDialogsConfiguration
         , UserDescription
         , UserUsedWebParts
         , UserUsedWidgets
         , UserFacebookID
         , UserAuthenticationGUID
         , UserSkype
         , UserIM
         , UserPhone
         , UserPosition
         , UserBounces
         , UserLinkedInID
         , UserLogActivities
         , UserPasswordRequestHash
         , UserInvalidLogOnAttempts
         , UserInvalidLogOnAttemptsHash
         , UserAvatarType
         , UserAccountLockReason
         , UserPasswordLastChanged
         , UserSecurityQuestionAnswer1
         , UserSecurityQuestionAnswer2
         , UserSecurityQuestionAnswer3
         , HfitUserSsoId
         , HFitIsPlatformEnabled
         , HFitIsHraEnabled
         , HFitIsIncentivesEnabled
         , HFitUserMpiNumber
         , SocialSecurity
         , HFitUserMobilePhone
         , HFitUserPhoneType
         , HFitUserAgreesToTerms
         , HFitUserPreferredEmail
         , HFitUserPreferredPhone
         , HFitUserPreferredFirstName
         , HFitUserPhoneExt
         , HFitComInboxNotifyByEmail
         , HFitComInboxNotifyByText
         , HFitComActivitiesNotifyEmail
         , HFitComActivitiesNotifyText
         , HFitComTipOfTheDayNotifyByEmail
         , HFitComTipOfTheDayNotifyByText
         , HFitComCoachingTrackingEmail
         , HFitComCoachingTrackingText
         , HfitUserPreferredMailingAddress
         , HfitUserPreferredMailingCity
         , HfitUserPreferredMailingState
         , HfitUserPreferredMailingPostalCode
         , HFitCoachingEnrollDate
         , HFitUserAltPreferredPhone
         , HFitUserAltPreferredPhoneType
         , HFitUserAltPreferredPhoneExt
         , HFitHealthVision
         , HFitCoachId
         , HFitUserTypeID
         , HFitCoachSystemLastActivity
         , HFitIsConditionManagement
         , HFitCoachSystemNextActivity
         , HFitCoachWebLastActivity
         , HFitUserPreferredCallTime
         , HFitCoachSession1Date
         , HFitCoachSystemCoachID
         , HFitUserPreferredMailingAddress2
         , HFitCoachingOptOutDate
         , HFitCoachingOptOutItemID
         , HFitComScreeningSchedulersEmail
         , HFitCoachingOptOutSentDate
         , HFitComScreeningSchedulersText
         , WellnessGoalGuid
         , UserSecurityQuestionGuid1
         , UserSecurityQuestionGuid2
         , UserSecurityQuestionGuid3
         , HFitUserRegistrationDate
         , HFitCoachingServiceLevel
         , HealthAdvisingEvaluationDate
         , HFitCallLogStatus
         , HFitCallLogStatusDate
         , HFitCoachingDeliveryMethod
         , HFitTrackerReminderDisplayed
         , HFitPrimaryContactID
         , HFitPrimaryContactGuid
         , HFitUserIsRegistered
         , UserDataComUser
         , UserDataComPassword
         , UserShowIntroductionTile
         , UserDashboardApplications) 
    SELECT
           CTE.UserSettingsID
         , UserNickName
         , UserPicture
         , UserSignature
         , UserURLReferrer
         , UserCampaign
         , UserMessagingNotificationEmail
         , UserCustomData
         , UserRegistrationInfo
         , UserPreferences
         , UserActivationDate
         , UserActivatedByUserID
         , UserTimeZoneID
         , UserAvatarID
         , UserBadgeID
         , UserActivityPoints
         , UserForumPosts
         , UserBlogComments
         , UserGender
         , UserDateOfBirth
         , UserMessageBoardPosts
         , UserSettingsUserGUID
         , UserSettingsUserID
         , WindowsLiveID
         , UserBlogPosts
         , UserWaitingForApproval
         , UserDialogsConfiguration
         , UserDescription
         , UserUsedWebParts
         , UserUsedWidgets
         , UserFacebookID
         , UserAuthenticationGUID
         , UserSkype
         , UserIM
         , UserPhone
         , UserPosition
         , UserBounces
         , UserLinkedInID
         , UserLogActivities
         , UserPasswordRequestHash
         , UserInvalidLogOnAttempts
         , UserInvalidLogOnAttemptsHash
         , UserAvatarType
         , UserAccountLockReason
         , UserPasswordLastChanged
         , UserSecurityQuestionAnswer1
         , UserSecurityQuestionAnswer2
         , UserSecurityQuestionAnswer3
         , HfitUserSsoId
         , HFitIsPlatformEnabled
         , HFitIsHraEnabled
         , HFitIsIncentivesEnabled
         , HFitUserMpiNumber
         , SocialSecurity
         , HFitUserMobilePhone
         , HFitUserPhoneType
         , HFitUserAgreesToTerms
         , HFitUserPreferredEmail
         , HFitUserPreferredPhone
         , HFitUserPreferredFirstName
         , HFitUserPhoneExt
         , HFitComInboxNotifyByEmail
         , HFitComInboxNotifyByText
         , HFitComActivitiesNotifyEmail
         , HFitComActivitiesNotifyText
         , HFitComTipOfTheDayNotifyByEmail
         , HFitComTipOfTheDayNotifyByText
         , HFitComCoachingTrackingEmail
         , HFitComCoachingTrackingText
         , HfitUserPreferredMailingAddress
         , HfitUserPreferredMailingCity
         , HfitUserPreferredMailingState
         , HfitUserPreferredMailingPostalCode
         , HFitCoachingEnrollDate
         , HFitUserAltPreferredPhone
         , HFitUserAltPreferredPhoneType
         , HFitUserAltPreferredPhoneExt
         , HFitHealthVision
         , HFitCoachId
         , HFitUserTypeID
         , HFitCoachSystemLastActivity
         , HFitIsConditionManagement
         , HFitCoachSystemNextActivity
         , HFitCoachWebLastActivity
         , HFitUserPreferredCallTime
         , HFitCoachSession1Date
         , HFitCoachSystemCoachID
         , HFitUserPreferredMailingAddress2
         , HFitCoachingOptOutDate
         , HFitCoachingOptOutItemID
         , HFitComScreeningSchedulersEmail
         , HFitCoachingOptOutSentDate
         , HFitComScreeningSchedulersText
         , WellnessGoalGuid
         , UserSecurityQuestionGuid1
         , UserSecurityQuestionGuid2
         , UserSecurityQuestionGuid3
         , HFitUserRegistrationDate
         , HFitCoachingServiceLevel
         , HealthAdvisingEvaluationDate
         , HFitCallLogStatus
         , HFitCallLogStatusDate
         , HFitCoachingDeliveryMethod
         , HFitTrackerReminderDisplayed
         , HFitPrimaryContactID
         , HFitPrimaryContactGuid
         , HFitUserIsRegistered
         , UserDataComUser
         , UserDataComPassword
         , UserShowIntroductionTile
         , UserDashboardApplications
           FROM
               TEMP_CMS_UserSettings_1000
                   JOIN CTE
                       ON CTE.UserSettingsID = TEMP_CMS_UserSettings_1000.UserSettingsID;

GO

SET IDENTITY_INSERT CMS_UserSettings OFF;
GO

SELECT
       COUNT (*) 
--,CT.UserSettingsID
--, CT.SYS_CHANGE_VERSION
--, CT.SYS_CHANGE_OPERATION
       FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
       WHERE
       SYS_CHANGE_OPERATION = 'I';
SELECT
       COUNT (*) 
     , SYS_CHANGE_OPERATION
       FROM STAGING_CMS_UserSettings_Audit
       GROUP BY
                SYS_CHANGE_OPERATION;

EXEC proc_STAGING_EDW_CMS_UserSettings;

GO

UPDATE CMS_UserSettings
       SET
           UserNickName = NULL
WHERE
      UserNickName = 'NMN';

EXEC proc_STAGING_EDW_CMS_UserSettings;

SELECT
       *
       FROM view_AUDIT_CMS_UserSettings
       WHERE UserSettingsID IN (
             SELECT TOP 100
                    UserSettingsID
                    FROM CMS_UserSettings) 
       ORDER BY
                UserSettingsID;

SELECT
       *
       FROM STAGING_CMS_UserSettings_Update_History;
