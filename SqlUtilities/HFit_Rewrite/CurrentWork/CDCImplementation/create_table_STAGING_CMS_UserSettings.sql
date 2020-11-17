
/*------------------------
-----------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
cms_usersite
hfit_ppteligibility
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_CMS_UserSettings.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_UserSettings') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_UserSettings';
        ALTER TABLE dbo.CMS_UserSettings
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_UserSettings';
    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_CMS_UserSettings') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_CMS_UserSettings;
    END;
GO
-- exec proc_Create_Table_STAGING_CMS_UserSettings
-- select top 100 * from [STAGING_CMS_UserSettings]
CREATE PROCEDURE proc_Create_Table_STAGING_CMS_UserSettings
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSettings') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_CMS_UserSettings;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_CMS_UserSettings (
                 UserSettingsID int NOT NULL
               , UserNickName nvarchar (200) NULL
               , UserPicture nvarchar (200) NULL
               , UserSignature nvarchar (max) NULL
               , UserURLReferrer nvarchar (450) NULL
               , UserCampaign nvarchar (200) NULL
               , UserMessagingNotificationEmail nvarchar (200) NULL
               , UserCustomData nvarchar (max) NULL
               , UserRegistrationInfo nvarchar (max) NULL
               , UserPreferences nvarchar (max) NULL
               , UserActivationDate datetime2 (7) NULL
               , UserActivatedByUserID int NULL
               , UserTimeZoneID int NULL
               , UserAvatarID int NULL
               , UserBadgeID int NULL
               , UserActivityPoints int NULL
               , UserForumPosts int NULL
               , UserBlogComments int NULL
               , UserGender int NULL
               , UserDateOfBirth datetime2 (7) NULL
               , UserMessageBoardPosts int NULL
               , UserSettingsUserGUID uniqueidentifier NOT NULL
               , UserSettingsUserID int NOT NULL
               , WindowsLiveID nvarchar (50) NULL
               , UserBlogPosts int NULL
               , UserWaitingForApproval bit NULL
               , UserDialogsConfiguration nvarchar (max) NULL
               , UserDescription nvarchar (max) NULL
               , UserUsedWebParts nvarchar (1000) NULL
               , UserUsedWidgets nvarchar (1000) NULL
               , UserFacebookID nvarchar (100) NULL
               , UserAuthenticationGUID uniqueidentifier NULL
               , UserSkype nvarchar (100) NULL
               , UserIM nvarchar (100) NULL
               , UserPhone nvarchar (26) NULL
               , UserPosition nvarchar (200) NULL
               , UserBounces int NULL
               , UserLinkedInID nvarchar (100) NULL
               , UserLogActivities bit NULL
               , UserPasswordRequestHash nvarchar (100) NULL
               , UserInvalidLogOnAttempts int NULL
               , UserInvalidLogOnAttemptsHash nvarchar (100) NULL
               , UserAvatarType nvarchar (200) NULL
               , UserAccountLockReason int NULL
               , UserPasswordLastChanged datetime2 (7) NULL
               , UserSecurityQuestionAnswer1 nvarchar (100) NULL
               , UserSecurityQuestionAnswer2 nvarchar (100) NULL
               , UserSecurityQuestionAnswer3 nvarchar (100) NULL
               , HfitUserSsoId nvarchar (250) NULL
               , HFitIsPlatformEnabled bit NULL
               , HFitIsHraEnabled bit NULL
               , HFitIsIncentivesEnabled bit NULL
               , HFitUserMpiNumber bigint NULL
               , SocialSecurity nvarchar (100) NULL
               , HFitUserMobilePhone nvarchar (15) NULL
               , HFitUserPhoneType nvarchar (10) NULL
               , HFitUserAgreesToTerms bit NULL
               , HFitUserPreferredEmail nvarchar (100) NULL
               , HFitUserPreferredPhone nvarchar (15) NULL
               , HFitUserPreferredFirstName nvarchar (50) NULL
               , HFitUserPhoneExt nvarchar (16) NULL
               , HFitComInboxNotifyByEmail bit NULL
               , HFitComInboxNotifyByText bit NULL
               , HFitComActivitiesNotifyEmail bit NULL
               , HFitComActivitiesNotifyText bit NULL
               , HFitComTipOfTheDayNotifyByEmail bit NULL
               , HFitComTipOfTheDayNotifyByText bit NULL
               , HFitComCoachingTrackingEmail bit NULL
               , HFitComCoachingTrackingText bit NULL
               , HfitUserPreferredMailingAddress nvarchar (100) NULL
               , HfitUserPreferredMailingCity nvarchar (50) NULL
               , HfitUserPreferredMailingState nvarchar (2) NULL
               , HfitUserPreferredMailingPostalCode nvarchar (10) NULL
               , HFitCoachingEnrollDate datetime2 (7) NULL
               , HFitUserAltPreferredPhone nvarchar (15) NULL
               , HFitUserAltPreferredPhoneType int NULL
               , HFitUserAltPreferredPhoneExt nvarchar (16) NULL
               , HFitHealthVision nvarchar (max) NULL
               , HFitCoachId int NULL
               , HFitUserTypeID int NULL
               , HFitCoachSystemLastActivity datetime2 (7) NULL
               , HFitIsConditionManagement bit NULL
               , HFitCoachSystemNextActivity datetime2 (7) NULL
               , HFitCoachWebLastActivity datetime2 (7) NULL
               , HFitUserPreferredCallTime int NULL
               , HFitCoachSession1Date datetime2 (7) NULL
               , HFitCoachSystemCoachID int NULL
               , HFitUserPreferredMailingAddress2 nvarchar (100) NULL
               , HFitCoachingOptOutDate datetime2 (7) NULL
               , HFitCoachingOptOutItemID int NULL
               , HFitComScreeningSchedulersEmail bit NULL
               , HFitCoachingOptOutSentDate datetime2 (7) NULL
               , HFitComScreeningSchedulersText bit NULL
               , WellnessGoalGuid uniqueidentifier NULL
               , UserSecurityQuestionGuid1 uniqueidentifier NULL
               , UserSecurityQuestionGuid2 uniqueidentifier NULL
               , UserSecurityQuestionGuid3 uniqueidentifier NULL
               , HFitUserRegistrationDate datetime2 (7) NULL
               , HFitCoachingServiceLevel int NULL
               , HealthAdvisingEvaluationDate datetime2 (7) NULL
               , HFitCallLogStatus int NULL
               , HFitCallLogStatusDate datetime2 (7) NULL
               , HFitCoachingDeliveryMethod int NULL
               , HFitTrackerReminderDisplayed datetime2 (7) NULL
               , HFitPrimaryContactID int NULL
               , HFitPrimaryContactGuid uniqueidentifier NULL
               , HFitUserIsRegistered bit NULL
               , UserDataComUser nvarchar (200) NULL
               , UserDataComPassword nvarchar (200) NULL
               , UserShowIntroductionTile bit NULL
               , UserDashboardApplications nvarchar (max) NULL
               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSettings
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_CMS_UserSettings
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSettings ON dbo.STAGING_CMS_UserSettings
    (
    UserSettingsID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings ON;

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
         , UserDashboardApplications) 
    SELECT
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
           FROM CMS_UserSettings;

    --SET IDENTITY_INSERT STAGING_CMS_UserSettings OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSettings_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_CMS_UserSettings_Update_History;
        END;

    CREATE TABLE dbo.STAGING_CMS_UserSettings_Update_History (
                 UserSettingsid int NOT NULL
               ,SYS_CHANGE_VERSION bigint NULL
               ,SYS_CHANGE_OPERATION nchar (1) NULL
               ,SYS_CHANGE_COLUMNS varbinary (4100) NULL
               ,CurrUser varchar (60) NOT NULL
               ,SysUser varchar (60) NOT NULL
               ,IPADDR varchar (60) NOT NULL
               ,commit_time datetime NOT NULL
               ,LastModifiedDate datetime NOT NULL
               ,SVR nvarchar (128) NULL
               ,DBNAME nvarchar (128) NULL
               ,UserSettingsID_cg int NULL
               ,UserNickName_cg int NULL
               ,UserPicture_cg int NULL
               ,UserSignature_cg int NULL
               ,UserURLReferrer_cg int NULL
               ,UserCampaign_cg int NULL
               ,UserMessagingNotificationEmail_cg int NULL
               ,UserCustomData_cg int NULL
               ,UserRegistrationInfo_cg int NULL
               ,UserPreferences_cg int NULL
               ,UserActivationDate_cg int NULL
               ,UserActivatedByUserID_cg int NULL
               ,UserTimeZoneID_cg int NULL
               ,UserAvatarID_cg int NULL
               ,UserBadgeID_cg int NULL
               ,UserActivityPoints_cg int NULL
               ,UserForumPosts_cg int NULL
               ,UserBlogComments_cg int NULL
               ,UserGender_cg int NULL
               ,UserDateOfBirth_cg int NULL
               ,UserMessageBoardPosts_cg int NULL
               ,UserSettingsUserGUID_cg int NULL
               ,UserSettingsUserID_cg int NULL
               ,WindowsLiveID_cg int NULL
               ,UserBlogPosts_cg int NULL
               ,UserWaitingForApproval_cg int NULL
               ,UserDialogsConfiguration_cg int NULL
               ,UserDescription_cg int NULL
               ,UserUsedWebParts_cg int NULL
               ,UserUsedWidgets_cg int NULL
               ,UserFacebookID_cg int NULL
               ,UserAuthenticationGUID_cg int NULL
               ,UserSkype_cg int NULL
               ,UserIM_cg int NULL
               ,UserPhone_cg int NULL
               ,UserPosition_cg int NULL
               ,UserBounces_cg int NULL
               ,UserLinkedInID_cg int NULL
               ,UserLogActivities_cg int NULL
               ,UserPasswordRequestHash_cg int NULL
               ,UserInvalidLogOnAttempts_cg int NULL
               ,UserInvalidLogOnAttemptsHash_cg int NULL
               ,UserAvatarType_cg int NULL
               ,UserAccountLockReason_cg int NULL
               ,UserPasswordLastChanged_cg int NULL
               ,UserSecurityQuestionAnswer1_cg int NULL
               ,UserSecurityQuestionAnswer2_cg int NULL
               ,UserSecurityQuestionAnswer3_cg int NULL
               ,HfitUserSsoId_cg int NULL
               ,HFitIsPlatformEnabled_cg int NULL
               ,HFitIsHraEnabled_cg int NULL
               ,HFitIsIncentivesEnabled_cg int NULL
               ,HFitUserMpiNumber_cg int NULL
               ,SocialSecurity_cg int NULL
               ,HFitUserMobilePhone_cg int NULL
               ,HFitUserPhoneType_cg int NULL
               ,HFitUserAgreesToTerms_cg int NULL
               ,HFitUserPreferredEmail_cg int NULL
               ,HFitUserPreferredPhone_cg int NULL
               ,HFitUserPreferredFirstName_cg int NULL
               ,HFitUserPhoneExt_cg int NULL
               ,HFitComInboxNotifyByEmail_cg int NULL
               ,HFitComInboxNotifyByText_cg int NULL
               ,HFitComActivitiesNotifyEmail_cg int NULL
               ,HFitComActivitiesNotifyText_cg int NULL
               ,HFitComTipOfTheDayNotifyByEmail_cg int NULL
               ,HFitComTipOfTheDayNotifyByText_cg int NULL
               ,HFitComCoachingTrackingEmail_cg int NULL
               ,HFitComCoachingTrackingText_cg int NULL
               ,HfitUserPreferredMailingAddress_cg int NULL
               ,HfitUserPreferredMailingCity_cg int NULL
               ,HfitUserPreferredMailingState_cg int NULL
               ,HfitUserPreferredMailingPostalCode_cg int NULL
               ,HFitCoachingEnrollDate_cg int NULL
               ,HFitUserAltPreferredPhone_cg int NULL
               ,HFitUserAltPreferredPhoneType_cg int NULL
               ,HFitUserAltPreferredPhoneExt_cg int NULL
               ,HFitHealthVision_cg int NULL
               ,HFitCoachId_cg int NULL
               ,HFitUserTypeID_cg int NULL
               ,HFitCoachSystemLastActivity_cg int NULL
               ,HFitIsConditionManagement_cg int NULL
               ,HFitCoachSystemNextActivity_cg int NULL
               ,HFitCoachWebLastActivity_cg int NULL
               ,HFitUserPreferredCallTime_cg int NULL
               ,HFitCoachSession1Date_cg int NULL
               ,HFitCoachSystemCoachID_cg int NULL
               ,HFitUserPreferredMailingAddress2_cg int NULL
               ,HFitCoachingOptOutDate_cg int NULL
               ,HFitCoachingOptOutItemID_cg int NULL
               ,HFitComScreeningSchedulersEmail_cg int NULL
               ,HFitCoachingOptOutSentDate_cg int NULL
               ,HFitComScreeningSchedulersText_cg int NULL
               ,WellnessGoalGuid_cg int NULL
               ,UserSecurityQuestionGuid1_cg int NULL
               ,UserSecurityQuestionGuid2_cg int NULL
               ,UserSecurityQuestionGuid3_cg int NULL
               ,HFitUserRegistrationDate_cg int NULL
               ,HFitCoachingServiceLevel_cg int NULL
               ,HealthAdvisingEvaluationDate_cg int NULL
               ,HFitCallLogStatus_cg int NULL
               ,HFitCallLogStatusDate_cg int NULL
               ,HFitCoachingDeliveryMethod_cg int NULL
               ,HFitTrackerReminderDisplayed_cg int NULL
               ,HFitPrimaryContactID_cg int NULL
               ,HFitPrimaryContactGuid_cg int NULL
               ,HFitUserIsRegistered_cg int NULL
               ,UserDataComUser_cg int NULL
               ,UserDataComPassword_cg int NULL
               ,UserShowIntroductionTile_cg int NULL
               ,UserDashboardApplications_cg int NULL
               ,HFitForgotPasswordAttempts_cg int NULL
               ,HFitForgotPasswordStarted_cg int NULL
    ) 
    ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_CurrUser  DEFAULT USER_NAME () FOR CurrUser;
    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_SysUser  DEFAULT SUSER_SNAME () FOR SysUser;
    ALTER TABLE dbo.STAGING_CMS_UserSettings_Update_History
    ADD
                CONSTRAINT DF_STAGING_CMS_UserSettings_Update_History_IPADDR  DEFAULT CONVERT (nvarchar (50) , CONNECTIONPROPERTY ('client_net_address')) FOR IPADDR;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSettings_Update_History ON dbo.STAGING_CMS_UserSettings_Update_History
    (
    UserSettingsID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --CREATE CLUSTERED INDEX [PI_STAGING_CMS_UserSettings_Update_History] ON [dbo].[STAGING_CMS_UserSettings_Update_History]
    --(
	   -- [UserSettingsid] ASC
    --)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END;

GO
PRINT 'Executed create_table_STAGING_CMS_UserSettings.sql';
GO
EXEC proc_Create_Table_STAGING_CMS_UserSettings;
GO

