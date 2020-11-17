
GO
-- USe KenticoCMS_Prod1

PRINT 'Executing proc_CT_CMS_UserSettings_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSettings_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSettings_AddNewRecs;
    END;
GO

/*
    SELECT TOP 100 * FROM STAGING_CMS_UserSettings
    DELETE FROM STAGING_CMS_UserSettings where UserSettingsID = 20210
    exec proc_CT_CMS_UserSettings_AddNewRecs
*/
CREATE PROCEDURE proc_CT_CMS_UserSettings_AddNewRecs
AS
BEGIN

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings ON;

    WITH CTE (
         UserSettingsID) 
        AS ( SELECT
                    UserSettingsID
                    FROM CMS_UserSettings
             EXCEPT
             SELECT
                    UserSettingsID
                    FROM STAGING_CMS_UserSettings
                    WHERE DeletedFlg IS NULL) 
        INSERT INTO STAGING_CMS_UserSettings
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
             , UserDashboardApplications

             , LastModifiedDate
               --,[RowNbr]
             , DeletedFlg
             , TimeZone
             , ConvertedToCentralTime
             , SVR
             , DBNAME
             , SYS_CHANGE_VERSION) 
        SELECT
               T.UserSettingsID
             , T.UserNickName
             , T.UserPicture
             , T.UserSignature
             , T.UserURLReferrer
             , T.UserCampaign
             , T.UserMessagingNotificationEmail
             , T.UserCustomData
             , T.UserRegistrationInfo
             , T.UserPreferences
             , T.UserActivationDate
             , T.UserActivatedByUserID
             , T.UserTimeZoneID
             , T.UserAvatarID
             , T.UserBadgeID
             , T.UserActivityPoints
             , T.UserForumPosts
             , T.UserBlogComments
             , T.UserGender
             , T.UserDateOfBirth
             , T.UserMessageBoardPosts
             , T.UserSettingsUserGUID
             , T.UserSettingsUserID
             , T.WindowsLiveID
             , T.UserBlogPosts
             , T.UserWaitingForApproval
             , T.UserDialogsConfiguration
             , T.UserDescription
             , T.UserUsedWebParts
             , T.UserUsedWidgets
             , T.UserFacebookID
             , T.UserAuthenticationGUID
             , T.UserSkype
             , T.UserIM
             , T.UserPhone
             , T.UserPosition
             , T.UserBounces
             , T.UserLinkedInID
             , T.UserLogActivities
             , T.UserPasswordRequestHash
             , T.UserInvalidLogOnAttempts
             , T.UserInvalidLogOnAttemptsHash
             , T.UserAvatarType
             , T.UserAccountLockReason
             , T.UserPasswordLastChanged
             , T.UserSecurityQuestionAnswer1
             , T.UserSecurityQuestionAnswer2
             , T.UserSecurityQuestionAnswer3
             , T.HfitUserSsoId
             , T.HFitIsPlatformEnabled
             , T.HFitIsHraEnabled
             , T.HFitIsIncentivesEnabled
             , T.HFitUserMpiNumber
             , T.SocialSecurity
             , T.HFitUserMobilePhone
             , T.HFitUserPhoneType
             , T.HFitUserAgreesToTerms
             , T.HFitUserPreferredEmail
             , T.HFitUserPreferredPhone
             , T.HFitUserPreferredFirstName
             , T.HFitUserPhoneExt
             , T.HFitComInboxNotifyByEmail
             , T.HFitComInboxNotifyByText
             , T.HFitComActivitiesNotifyEmail
             , T.HFitComActivitiesNotifyText
             , T.HFitComTipOfTheDayNotifyByEmail
             , T.HFitComTipOfTheDayNotifyByText
             , T.HFitComCoachingTrackingEmail
             , T.HFitComCoachingTrackingText
             , T.HfitUserPreferredMailingAddress
             , T.HfitUserPreferredMailingCity
             , T.HfitUserPreferredMailingState
             , T.HfitUserPreferredMailingPostalCode
             , T.HFitCoachingEnrollDate
             , T.HFitUserAltPreferredPhone
             , T.HFitUserAltPreferredPhoneType
             , T.HFitUserAltPreferredPhoneExt
             , T.HFitHealthVision
             , T.HFitCoachId
             , T.HFitUserTypeID
             , T.HFitCoachSystemLastActivity
             , T.HFitIsConditionManagement
             , T.HFitCoachSystemNextActivity
             , T.HFitCoachWebLastActivity
             , T.HFitUserPreferredCallTime
             , T.HFitCoachSession1Date
             , T.HFitCoachSystemCoachID
             , T.HFitUserPreferredMailingAddress2
             , T.HFitCoachingOptOutDate
             , T.HFitCoachingOptOutItemID
             , T.HFitComScreeningSchedulersEmail
             , T.HFitCoachingOptOutSentDate
             , T.HFitComScreeningSchedulersText
             , T.WellnessGoalGuid
             , T.UserSecurityQuestionGuid1
             , T.UserSecurityQuestionGuid2
             , T.UserSecurityQuestionGuid3
             , T.HFitUserRegistrationDate
             , T.HFitCoachingServiceLevel
             , T.HealthAdvisingEvaluationDate
             , T.HFitCallLogStatus
             , T.HFitCallLogStatusDate
             , T.HFitCoachingDeliveryMethod
             , T.HFitTrackerReminderDisplayed
             , T.HFitPrimaryContactID
             , T.HFitPrimaryContactGuid
             , T.HFitUserIsRegistered
             , T.UserDataComUser
             , T.UserDataComPassword
             , T.UserShowIntroductionTile
             , T.UserDashboardApplications

             , GETDATE () AS LastModifiedDate
             , NULL AS DeletedFlg
             , NULL AS TimeZone
             , NULL AS ConvertedToCentralTime
             , @@SERVERNAME AS SVR
             , DB_NAME () AS DBNAME
             , null as SYS_CHANGE_VERSION
               FROM
                   CMS_UserSettings AS T
                       JOIN CTE AS S
                           ON S.UserSettingsID = T.UserSettingsID;
                        
    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    --SET IDENTITY_INSERT STAGING_CMS_UserSettings OFF;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSettings_AddNewRecs.sql';
GO
