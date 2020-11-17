
/*---------------------------
cms_user	  -> DONE
cms_usersettings	  -> DONE
cms_usersite	  -> DONE
hfit_ppteligibility	  -> DONE
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_cms_user.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_User') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_User';
        ALTER TABLE dbo.CMS_User
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_User';
    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_cms_user') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_cms_user;
    END;
GO
-- exec proc_Create_Table_STAGING_cms_user
-- select top 100 * from [STAGING_cms_user]
CREATE PROCEDURE proc_Create_Table_STAGING_cms_user
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_cms_user') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_cms_user;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_cms_user (
                 UserID int IDENTITY (1, 1) 
                            NOT NULL
               , UserName nvarchar (100) NOT NULL
               , FirstName nvarchar (100) NULL
               , MiddleName nvarchar (100) NULL
               , LastName nvarchar (100) NULL
               , FullName nvarchar (450) NULL
               , Email nvarchar (100) NULL
               , UserPassword nvarchar (100) NOT NULL
               , PreferredCultureCode nvarchar (10) NULL
               , PreferredUICultureCode nvarchar (10) NULL
               , UserEnabled bit NOT NULL
               , UserIsEditor bit NOT NULL
               , UserIsGlobalAdministrator bit NOT NULL
               , UserIsExternal bit NULL
               , UserPasswordFormat nvarchar (10) NULL
               , UserCreated datetime2 (7) NULL
               , LastLogon datetime2 (7) NULL
               , UserStartingAliasPath nvarchar (200) NULL
               , UserGUID uniqueidentifier NOT NULL
               , UserLastModified datetime2 (7) NOT NULL
               , UserLastLogonInfo nvarchar (max) NULL
               , UserIsHidden bit NULL
               , UserVisibility nvarchar (max) NULL
               , UserIsDomain bit NULL
               , UserHasAllowedCultures bit NULL
               , UserSiteManagerDisabled bit NULL
               , UserPasswordBuffer nvarchar (2000) NULL
               , UserTokenID uniqueidentifier NULL
               , UserMFRequired bit NULL
               , UserTokenIteration int NULL
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

    ALTER TABLE dbo.STAGING_cms_user
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_cms_user
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    SET IDENTITY_INSERT STAGING_cms_user ON;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_USer ON dbo.STAGING_cms_user
    (
    UserID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    INSERT INTO STAGING_cms_user
    (
           UserID
         , UserName
         , FirstName
         , MiddleName
         , LastName
         , FullName
         , Email
         , UserPassword
         , PreferredCultureCode
         , PreferredUICultureCode
         , UserEnabled
         , UserIsEditor
         , UserIsGlobalAdministrator
         , UserIsExternal
         , UserPasswordFormat
         , UserCreated
         , LastLogon
         , UserStartingAliasPath
         , UserGUID
         , UserLastModified
         , UserLastLogonInfo
         , UserIsHidden
         , UserVisibility
         , UserIsDomain
         , UserHasAllowedCultures
         , UserSiteManagerDisabled
         , UserPasswordBuffer
         , UserTokenID
         , UserMFRequired
         , UserTokenIteration) 
    SELECT
           UserID
         , UserName
         , FirstName
         , MiddleName
         , LastName
         , FullName
         , Email
         , UserPassword
         , PreferredCultureCode
         , PreferredUICultureCode
         , UserEnabled
         , UserIsEditor
         , UserIsGlobalAdministrator
         , UserIsExternal
         , UserPasswordFormat
         , UserCreated
         , LastLogon
         , UserStartingAliasPath
         , UserGUID
         , UserLastModified
         , UserLastLogonInfo
         , UserIsHidden
         , UserVisibility
         , UserIsDomain
         , UserHasAllowedCultures
         , UserSiteManagerDisabled
         , UserPasswordBuffer
         , UserTokenID
         , UserMFRequired
         , UserTokenIteration
           FROM cms_user;

    SET IDENTITY_INSERT STAGING_cms_user OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_cms_user_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_cms_user_Update_History;
        END;

CREATE TABLE [dbo].[STAGING_CMS_USER_Update_History](
	[Userid] [int] NOT NULL,
	[SYS_CHANGE_VERSION] [bigint] NULL,
	[SYS_CHANGE_OPERATION] [nchar](1) NULL,
	[SYS_CHANGE_COLUMNS] [varbinary](4100) NULL,
	[CurrUser] [varchar](60) NOT NULL,
	[SysUser] [varchar](60) NOT NULL,
	[IPADDR] [varchar](60) NOT NULL,
	[commit_time] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[SVR] [nvarchar](128) NULL,
	[DBNAME] [nvarchar](128) NULL,
	[Email_cg] [int] NULL,
	[FirstName_cg] [int] NULL,
	[FullName_cg] [int] NULL,
	[LastLogon_cg] [int] NULL,
	[LastName_cg] [int] NULL,
	[MiddleName_cg] [int] NULL,
	[PreferredCultureCode_cg] [int] NULL,
	[PreferredUICultureCode_cg] [int] NULL,
	[UserCreated_cg] [int] NULL,
	[UserEnabled_cg] [int] NULL,
	[UserGUID_cg] [int] NULL,
	[UserHasAllowedCultures_cg] [int] NULL,
	[UserID_cg] [int] NULL,
	[UserIsDomain_cg] [int] NULL,
	[UserIsEditor_cg] [int] NULL,
	[UserIsExternal_cg] [int] NULL,
	[UserIsGlobalAdministrator_cg] [int] NULL,
	[UserIsHidden_cg] [int] NULL,
	[UserLastLogonInfo_cg] [int] NULL,
	[UserLastModified_cg] [int] NULL,
	[UserMFRequired_cg] [int] NULL,
	[UserName_cg] [int] NULL,
	[UserPassword_cg] [int] NULL,
	[UserPasswordBuffer_cg] [int] NULL,
	[UserPasswordFormat_cg] [int] NULL,
	[UserSiteManagerDisabled_cg] [int] NULL,
	[UserStartingAliasPath_cg] [int] NULL,
	[UserTokenID_cg] [int] NULL,
	[UserTokenIteration_cg] [int] NULL,
	[UserVisibility_cg] [int] NULL
)


ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_CurrUser]  DEFAULT (user_name()) FOR [CurrUser]

ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_SysUser]  DEFAULT (suser_sname()) FOR [SysUser]

ALTER TABLE [dbo].[STAGING_CMS_USER_Update_History] ADD  CONSTRAINT [DF_STAGING_cms_user_Update_History_IPADDR]  DEFAULT (CONVERT([nvarchar](50),connectionproperty('client_net_address'))) FOR [IPADDR]
    
    CREATE CLUSTERED INDEX PI_STAGING_cms_user_Update_History ON dbo.STAGING_cms_user_Update_History
    (
    UserID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


END;

GO
PRINT 'Executed create_table_STAGING_cms_user.sql';
GO
EXEC proc_Create_Table_STAGING_cms_user;
GO
