
/*------------------------
cms_user			    -> DONE
cms_usersettings	  -> DONE
CMS_UserSite	  -> DONE
hfit_ppteligibility
cms_usercontact
*/
GO
PRINT 'Executing create_table_STAGING_CMS_UserSite.sql';
GO

IF NOT EXISTS (SELECT
                      sys.tables.name AS Table_name
                      FROM
                          sys.change_tracking_tables
                              JOIN sys.tables
                                  ON sys.tables.object_id = sys.change_tracking_tables.object_id
                              JOIN sys.schemas
                                  ON sys.schemas.schema_id = sys.tables.schema_id
                      WHERE sys.tables.name = 'CMS_UserSite') 
    BEGIN
        PRINT 'ADDING Change Tracking to CMS_UserSite';
        ALTER TABLE dbo.CMS_UserSite
            ENABLE CHANGE_TRACKING
                WITH (TRACK_COLUMNS_UPDATED = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'Change Tracking exists on CMS_UserSite';
    END;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_Table_STAGING_CMS_UserSite') 
    BEGIN
        DROP PROCEDURE
             proc_Create_Table_STAGING_CMS_UserSite;
    END;
GO
-- exec proc_Create_Table_STAGING_CMS_UserSite
-- select top 100 * from [STAGING_CMS_UserSite]
CREATE PROCEDURE proc_Create_Table_STAGING_CMS_UserSite
AS
BEGIN

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSite') 
        BEGIN
            DROP TABLE
                 dbo.STAGING_CMS_UserSite;
        END;

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE dbo.STAGING_CMS_UserSite (
                 UserSiteID int NOT NULL
               , UserID int NOT NULL
               , SiteID int NOT NULL
               , UserPreferredCurrencyID int NULL
               , UserPreferredShippingOptionID int NULL
               , UserPreferredPaymentOptionID int NULL

               , LastModifiedDate datetime NULL
               , RowNbr int NULL
               , DeletedFlg bit NULL
               , TimeZone nvarchar (10) NULL
               , ConvertedToCentralTime bit NULL
               , SVR nvarchar (100) NOT NULL
               , DBNAME nvarchar (100) NOT NULL
               , SYS_CHANGE_VERSION int NULL
    ) 
    ON [PRIMARY];

    ALTER TABLE dbo.STAGING_CMS_UserSite
    ADD
                DEFAULT @@servername FOR SVR;
    ALTER TABLE dbo.STAGING_CMS_UserSite
    ADD
                DEFAULT DB_NAME () FOR DBNAME;

    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSite ON dbo.STAGING_CMS_UserSite
    (
    UserSiteID ASC,
    SVR ASC,
    DBNAME ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

    --SET IDENTITY_INSERT STAGING_CMS_UserSite ON;

    INSERT INTO STAGING_CMS_UserSite
    (
           UserSiteID
         , UserID
         , SiteID
         , UserPreferredCurrencyID
         , UserPreferredShippingOptionID
         , UserPreferredPaymentOptionID) 
    SELECT
           UserSiteID
         , UserID
         , SiteID
         , UserPreferredCurrencyID
         , UserPreferredShippingOptionID
         , UserPreferredPaymentOptionID
           FROM CMS_UserSite;

    --SET IDENTITY_INSERT STAGING_CMS_UserSite OFF;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'STAGING_CMS_UserSite_Update_History') 
        BEGIN
            DROP TABLE
                 STAGING_CMS_UserSite_Update_History;
        END;

    -- select * from STAGING_CMS_UserSite_Update_History
   
CREATE TABLE [dbo].[STAGING_CMS_UserSite_Update_History](
	[UserSiteid] [int] NOT NULL,
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
	[UserSiteID_cg] [int] NULL,
	[UserID_cg] [int] NULL,
	[SiteID_cg] [int] NULL,
	[UserPreferredCurrencyID_cg] [int] NULL,
	[UserPreferredShippingOptionID_cg] [int] NULL,
	[UserPreferredPaymentOptionID_cg] [int] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_CurrUser]  DEFAULT (user_name()) FOR [CurrUser]
ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_SysUser]  DEFAULT (suser_sname()) FOR [SysUser]
ALTER TABLE [dbo].[STAGING_CMS_UserSite_Update_History] ADD  CONSTRAINT [DF_STAGING_CMS_UserSite_Update_History_IPADDR]  DEFAULT (CONVERT([nvarchar](50),connectionproperty('client_net_address'))) FOR [IPADDR]


    CREATE CLUSTERED INDEX PI_STAGING_CMS_UserSite_Update_History ON dbo.STAGING_CMS_UserSite_Update_History
    (
    UserSiteID ASC,
    SVR ASC,
    SYS_CHANGE_VERSION ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];


END;

GO
PRINT 'Executed create_table_STAGING_CMS_UserSite.sql';
GO
-- select * from STAGING_CMS_UserSite_Update_History
EXEC proc_Create_Table_STAGING_CMS_UserSite;
GO
