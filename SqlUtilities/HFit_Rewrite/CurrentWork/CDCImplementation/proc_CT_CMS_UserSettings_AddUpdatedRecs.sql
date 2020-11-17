
GO
PRINT 'Executing proc_CT_CMS_UserSettings_AddUpdatedRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_CMS_UserSettings_AddUpdatedRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_CMS_UserSettings_AddUpdatedRecs;
    END;
GO
/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select top 100 * from CMS_UserSettings
update CMS_UserSettings set UserNickName = UserNickName where UserSettingsID in (select top 50 UserSettingsID from CMS_UserSettings order by UserSettingsID desc )

 exec proc_CT_CMS_UserSettings_AddUpdatedRecs
 select * from STAGING_CMS_UserSettings where SYS_CHANGE_VERSION is not null

*/

CREATE PROCEDURE proc_CT_CMS_UserSettings_AddUpdatedRecs
AS
BEGIN
    WITH CTE (
         UserSettingsID
       , SYS_CHANGE_VERSION
       , SYS_CHANGE_OPERATION
       , SYS_CHANGE_COLUMNS) 
        AS ( SELECT
                    CT.UserSettingsID
                  , CT.SYS_CHANGE_VERSION
                  , CT.SYS_CHANGE_OPERATION
                  , SYS_CHANGE_COLUMNS
                    FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
                    WHERE SYS_CHANGE_OPERATION = 'U') 
        UPDATE S
               SET
                   S.UserSettingsID = T.UserSettingsID
                 ,S.UserNickName = T.UserNickName
                 ,S.UserPicture = T.UserPicture
                 ,S.UserSignature = T.UserSignature
                 ,S.UserURLReferrer = T.UserURLReferrer
                 ,S.UserCampaign = T.UserCampaign
                 ,S.UserMessagingNotificationEmail = T.UserMessagingNotificationEmail
                 ,S.UserCustomData = T.UserCustomData
                 ,S.UserRegistrationInfo = T.UserRegistrationInfo
                 ,S.UserPreferences = T.UserPreferences
                 ,S.UserActivationDate = T.UserActivationDate
                 ,S.UserActivatedByUserID = T.UserActivatedByUserID
                 ,S.UserTimeZoneID = T.UserTimeZoneID
                 ,S.UserAvatarID = T.UserAvatarID
                 ,S.UserBadgeID = T.UserBadgeID
                 ,S.UserActivityPoints = T.UserActivityPoints
                 ,S.UserForumPosts = T.UserForumPosts
                 ,S.UserBlogComments = T.UserBlogComments
                 ,S.UserGender = T.UserGender
                 ,S.UserDateOfBirth = T.UserDateOfBirth
                 ,S.UserMessageBoardPosts = T.UserMessageBoardPosts
                 ,S.UserSettingsUserGUID = T.UserSettingsUserGUID
                 ,S.UserSettingsUserID = T.UserSettingsUserID
                 ,S.WindowsLiveID = T.WindowsLiveID
                 ,S.UserBlogPosts = T.UserBlogPosts
                 ,S.UserWaitingForApproval = T.UserWaitingForApproval
                 ,S.UserDialogsConfiguration = T.UserDialogsConfiguration
                 ,S.UserDescription = T.UserDescription
                 ,S.UserUsedWebParts = T.UserUsedWebParts
                 ,S.UserUsedWidgets = T.UserUsedWidgets
                 ,S.UserFacebookID = T.UserFacebookID
                 ,S.UserAuthenticationGUID = T.UserAuthenticationGUID
                 ,S.UserSkype = T.UserSkype
                 ,S.UserIM = T.UserIM
                 ,S.UserPhone = T.UserPhone
                 ,S.UserPosition = T.UserPosition
                 ,S.UserBounces = T.UserBounces
                 ,S.UserLinkedInID = T.UserLinkedInID
                 ,S.UserLogActivities = T.UserLogActivities
                 ,S.UserPasswordRequestHash = T.UserPasswordRequestHash
                 ,S.UserInvalidLogOnAttempts = T.UserInvalidLogOnAttempts
                 ,S.UserInvalidLogOnAttemptsHash = T.UserInvalidLogOnAttemptsHash
                 ,S.UserAvatarType = T.UserAvatarType
                 ,S.UserAccountLockReason = T.UserAccountLockReason
                 ,S.UserPasswordLastChanged = T.UserPasswordLastChanged
                 ,S.UserSecurityQuestionAnswer1 = T.UserSecurityQuestionAnswer1
                 ,S.UserSecurityQuestionAnswer2 = T.UserSecurityQuestionAnswer2
                 ,S.UserSecurityQuestionAnswer3 = T.UserSecurityQuestionAnswer3
                 ,S.HfitUserSsoId = T.HfitUserSsoId
                 ,S.HFitIsPlatformEnabled = T.HFitIsPlatformEnabled
                 ,S.HFitIsHraEnabled = T.HFitIsHraEnabled
                 ,S.HFitIsIncentivesEnabled = T.HFitIsIncentivesEnabled
                 ,S.HFitUserMpiNumber = T.HFitUserMpiNumber
                 ,S.SocialSecurity = T.SocialSecurity
                 ,S.HFitUserMobilePhone = T.HFitUserMobilePhone
                 ,S.HFitUserPhoneType = T.HFitUserPhoneType
                 ,S.HFitUserAgreesToTerms = T.HFitUserAgreesToTerms
                 ,S.HFitUserPreferredEmail = T.HFitUserPreferredEmail
                 ,S.HFitUserPreferredPhone = T.HFitUserPreferredPhone
                 ,S.HFitUserPreferredFirstName = T.HFitUserPreferredFirstName
                 ,S.HFitUserPhoneExt = T.HFitUserPhoneExt
                 ,S.HFitComInboxNotifyByEmail = T.HFitComInboxNotifyByEmail
                 ,S.HFitComInboxNotifyByText = T.HFitComInboxNotifyByText
                 ,S.HFitComActivitiesNotifyEmail = T.HFitComActivitiesNotifyEmail
                 ,S.HFitComActivitiesNotifyText = T.HFitComActivitiesNotifyText
                 ,S.HFitComTipOfTheDayNotifyByEmail = T.HFitComTipOfTheDayNotifyByEmail
                 ,S.HFitComTipOfTheDayNotifyByText = T.HFitComTipOfTheDayNotifyByText
                 ,S.HFitComCoachingTrackingEmail = T.HFitComCoachingTrackingEmail
                 ,S.HFitComCoachingTrackingText = T.HFitComCoachingTrackingText
                 ,S.HfitUserPreferredMailingAddress = T.HfitUserPreferredMailingAddress
                 ,S.HfitUserPreferredMailingCity = T.HfitUserPreferredMailingCity
                 ,S.HfitUserPreferredMailingState = T.HfitUserPreferredMailingState
                 ,S.HfitUserPreferredMailingPostalCode = T.HfitUserPreferredMailingPostalCode
                 ,S.HFitCoachingEnrollDate = T.HFitCoachingEnrollDate
                 ,S.HFitUserAltPreferredPhone = T.HFitUserAltPreferredPhone
                 ,S.HFitUserAltPreferredPhoneType = T.HFitUserAltPreferredPhoneType
                 ,S.HFitUserAltPreferredPhoneExt = T.HFitUserAltPreferredPhoneExt
                 ,S.HFitHealthVision = T.HFitHealthVision
                 ,S.HFitCoachId = T.HFitCoachId
                 ,S.HFitUserTypeID = T.HFitUserTypeID
                 ,S.HFitCoachSystemLastActivity = T.HFitCoachSystemLastActivity
                 ,S.HFitIsConditionManagement = T.HFitIsConditionManagement
                 ,S.HFitCoachSystemNextActivity = T.HFitCoachSystemNextActivity
                 ,S.HFitCoachWebLastActivity = T.HFitCoachWebLastActivity
                 ,S.HFitUserPreferredCallTime = T.HFitUserPreferredCallTime
                 ,S.HFitCoachSession1Date = T.HFitCoachSession1Date
                 ,S.HFitCoachSystemCoachID = T.HFitCoachSystemCoachID
                 ,S.HFitUserPreferredMailingAddress2 = T.HFitUserPreferredMailingAddress2
                 ,S.HFitCoachingOptOutDate = T.HFitCoachingOptOutDate
                 ,S.HFitCoachingOptOutItemID = T.HFitCoachingOptOutItemID
                 ,S.HFitComScreeningSchedulersEmail = T.HFitComScreeningSchedulersEmail
                 ,S.HFitCoachingOptOutSentDate = T.HFitCoachingOptOutSentDate
                 ,S.HFitComScreeningSchedulersText = T.HFitComScreeningSchedulersText
                 ,S.WellnessGoalGuid = T.WellnessGoalGuid
                 ,S.UserSecurityQuestionGuid1 = T.UserSecurityQuestionGuid1
                 ,S.UserSecurityQuestionGuid2 = T.UserSecurityQuestionGuid2
                 ,S.UserSecurityQuestionGuid3 = T.UserSecurityQuestionGuid3
                 ,S.HFitUserRegistrationDate = T.HFitUserRegistrationDate
                 ,S.HFitCoachingServiceLevel = T.HFitCoachingServiceLevel
                 ,S.HealthAdvisingEvaluationDate = T.HealthAdvisingEvaluationDate
                 ,S.HFitCallLogStatus = T.HFitCallLogStatus
                 ,S.HFitCallLogStatusDate = T.HFitCallLogStatusDate
                 ,S.HFitCoachingDeliveryMethod = T.HFitCoachingDeliveryMethod
                 ,S.HFitTrackerReminderDisplayed = T.HFitTrackerReminderDisplayed
                 ,S.HFitPrimaryContactID = T.HFitPrimaryContactID
                 ,S.HFitPrimaryContactGuid = T.HFitPrimaryContactGuid
                 ,S.HFitUserIsRegistered = T.HFitUserIsRegistered
                 ,S.UserDataComUser = T.UserDataComUser
                 ,S.UserDataComPassword = T.UserDataComPassword
                 ,S.UserShowIntroductionTile = T.UserShowIntroductionTile
                 ,S.UserDashboardApplications = T.UserDashboardApplications

                 ,S.LastModifiedDate = GETDATE () 
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                 ,S.SYS_CHANGE_VERSION = CTE.SYS_CHANGE_VERSION
                   FROM STAGING_CMS_UserSettings AS S
                            JOIN
                            CMS_UserSettings AS T
                                ON
                                S.UserSettingsID = T.UserSettingsID
                            AND S.DeletedFlg IS NULL
                            JOIN CTE
                                ON CTE.UserSettingsID = T.UserSettingsID
                               AND (CTE.SYS_CHANGE_VERSION != S.SYS_CHANGE_VERSION
                                 OR S.SYS_CHANGE_VERSION IS NULL);

    DECLARE
    @iCnt AS int = @@ROWCOUNT;
    PRINT 'Updated Count: ' + CAST ( @iCnt AS nvarchar (50)) ;

    exec proc_CT_CMS_UserSettings_History 'U';

    --WITH CTE (
    --     UserSettingsID
    --   , SYS_CHANGE_VERSION
    --   , SYS_CHANGE_COLUMNS) 
    --    AS ( SELECT
    --                CT.UserSettingsID
    --              , CT.SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
    --                WHERE SYS_CHANGE_OPERATION = 'U'
    --         EXCEPT
    --         SELECT
    --                UserSettingsID
    --              , SYS_CHANGE_VERSION
    --              , SYS_CHANGE_COLUMNS
    --                FROM STAGING_CMS_UserSettings_Update_History
    --    ) 
    --    INSERT INTO STAGING_CMS_UserSettings_Update_History
    --    (
    --           UserSettingsID
    --         , LastModifiedDate
    --         , SVR
    --         , DBNAME
    --         , SYS_CHANGE_VERSION
    --         , SYS_CHANGE_COLUMNS, commit_time) 
    --    SELECT
    --           CTE.UserSettingsID
    --         , GETDATE () AS LastModifiedDate
    --         , @@SERVERNAME AS SVR
    --         , DB_NAME () AS DBNAME
    --         , CTE.SYS_CHANGE_VERSION
    --         , CTE.SYS_CHANGE_COLUMNS, tc.commit_time
    --           FROM CTE JOIN sys.dm_tran_commit_table AS tc
    --                       ON CTE.sys_change_version = tc.commit_ts;

    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_CMS_UserSettings_AddUpdatedRecs.sql';
GO
 