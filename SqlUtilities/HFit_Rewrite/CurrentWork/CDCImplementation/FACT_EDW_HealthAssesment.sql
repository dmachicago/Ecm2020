
GO
PRINT 'Executing FACT_EDW_HealthAssesment.sql';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'FACT_EDW_HealthAssesment') 
    BEGIN
        DROP TABLE
             FACT_EDW_HealthAssesment
    END;
GO
/*
alter table dbo.FACT_EDW_HealthAssesment add SiteID int null ;
*/
CREATE TABLE dbo.FACT_EDW_HealthAssesment (
             USERSTARTEDITEMID INT NULL
           ,HEALTHASSESMENTUSERSTARTEDNODEGUID UNIQUEIDENTIFIER NULL
           ,USERID BIGINT NULL
           ,USERGUID UNIQUEIDENTIFIER NULL
           ,HFITUSERMPINUMBER BIGINT NULL
           ,SITEGUID UNIQUEIDENTIFIER NULL
           ,ACCOUNTID INT NULL
           ,ACCOUNTCD NVARCHAR (8) NULL
           ,ACCOUNTNAME NVARCHAR (200) NULL
           ,HASTARTEDDT DATETIME2 (7) NULL
           ,HACOMPLETEDDT DATETIME2 (7) NULL
           ,USERMODULEITEMID INT NULL
           ,USERMODULECODENAME NVARCHAR (100) NULL
           ,HAMODULENODEGUID UNIQUEIDENTIFIER NULL
           ,CMSNODEGUID UNIQUEIDENTIFIER NULL
           ,HAMODULEVERSIONID INT NULL
           ,USERRISKCATEGORYITEMID INT NULL
           ,USERRISKCATEGORYCODENAME NVARCHAR (100) NULL
           ,HARISKCATEGORYNODEGUID UNIQUEIDENTIFIER NULL
           ,HARISKCATEGORYVERSIONID INT NULL
           ,USERRISKAREAITEMID INT NULL
           ,USERRISKAREACODENAME NVARCHAR (100) NULL
           ,HARISKAREANODEGUID UNIQUEIDENTIFIER NULL
           ,HARISKAREAVERSIONID INT NULL
           ,USERQUESTIONITEMID INT NULL
           ,TITLE NVARCHAR (MAX) NULL
           ,HAQUESTIONGUID UNIQUEIDENTIFIER NULL
           ,USERQUESTIONCODENAME NVARCHAR (100) NULL
           ,HAQUESTIONDOCUMENTID INT NULL
           ,HAQUESTIONVERSIONID INT NULL
           ,HAQUESTIONNODEGUID UNIQUEIDENTIFIER NULL
           ,USERANSWERITEMID INT NULL
           ,HAANSWERNODEGUID UNIQUEIDENTIFIER NULL
           ,HAANSWERVERSIONID INT NULL
           ,USERANSWERCODENAME NVARCHAR (100) NULL
           ,HAANSWERVALUE NVARCHAR (255) NULL
           ,HAMODULESCORE FLOAT NULL
           ,HARISKCATEGORYSCORE FLOAT NULL
           ,HARISKAREASCORE FLOAT NULL
           ,HAQUESTIONSCORE FLOAT NULL
           ,HAANSWERPOINTS INT NULL
           ,POINTRESULTS INT NULL
           ,UOMCODE NVARCHAR (10) NULL
           ,HASCORE INT NULL
           ,MODULEPREWEIGHTEDSCORE FLOAT NULL
           ,RISKCATEGORYPREWEIGHTEDSCORE FLOAT NULL
           ,RISKAREAPREWEIGHTEDSCORE FLOAT NULL
           ,QUESTIONPREWEIGHTEDSCORE FLOAT NULL
           ,QUESTIONGROUPCODENAME NVARCHAR (100) NULL
           ,CHANGETYPE NCHAR (1) NULL
           ,ITEMCREATEDWHEN DATETIME2 (7) NULL
           ,ITEMMODIFIEDWHEN DATETIME2 (7) NULL
           ,ISPROFESSIONALLYCOLLECTED BIT NULL
           ,HARISKCATEGORY_ITEMMODIFIEDWHEN DATETIME2 (7) NULL
           ,HAUSERRISKAREA_ITEMMODIFIEDWHEN DATETIME2 (7) NULL
           ,HAUSERQUESTION_ITEMMODIFIEDWHEN DATETIME2 (7) NULL
           ,HAUSERANSWERS_ITEMMODIFIEDWHEN DATETIME2 (7) NULL
           ,HAPAPERFLG BIT NULL
           ,HATELEPHONICFLG BIT NULL
           ,HASTARTEDMODE INT NULL
           ,HACOMPLETEDMODE INT NULL
           ,DOCUMENTCULTURE_VHCJ NVARCHAR (10) NULL
           ,DOCUMENTCULTURE_HAQUESTIONSVIEW NVARCHAR (10) NULL
           ,CAMPAIGNNODEGUID UNIQUEIDENTIFIER NULL
           ,HACAMPAIGNID INT NULL
           ,HASHCODE VARCHAR (100) NULL
           ,PKHASHCODE VARCHAR (100) NULL
		  , SiteID int null
           ,--[CHANGED_FLG] [int] NULL,
             --[CT_CMS_USER_USERID] [int] NULL,
             --[CT_CMS_USER_CHANGE_OPERATION] [nchar](1) NULL,
             --[CT_USERSETTINGSID] [int] NULL,
             --[CT_USERSETTINGSID_CHANGE_OPERATION] [nchar](1) NULL,
             --[SITEID_CTID] [int] NULL,
             --[SITEID_CHANGE_OPERATION] [nchar](1) NULL,
             --[USERSITEID_CTID] [int] NULL,
             --[USERSITEID_CHANGE_OPERATION] [nchar](1) NULL,
             --[ACCOUNTID_CTID] [int] NULL,
             --[ACCOUNTID__CHANGE_OPERATION] [nchar](1) NULL,
             --[HAUSERANSWERS_CTID] [int] NULL,
             --[HAUSERANSWERS_CHANGE_OPERATION] [nchar](1) NULL,
             --[HFIT_HEALTHASSESMENTUSERMODULE_CTID] [int] NULL,
             --[HFIT_HEALTHASSESMENTUSERMODULE_CHANGE_OPERATION] [nchar](1) NULL,
             --[HFIT_HEALTHASSESMENTUSERQUESTION_CTID] [int] NULL,
             --[HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION] [nchar](1) NULL,
             --[HFIT_HealthAssesmentUserQuestionGroupResults_CTID] [int] NULL,
             --[HFIT_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION] [nchar](1) NULL,
             --[HFIT_HEALTHASSESMENTUSERRISKAREA_CTID] [int] NULL,
             --[HFIT_HEALTHASSESMENTUSERRISKAREA_CHANGE_OPERATION] [nchar](1) NULL,
             --[HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CTID] [int] NULL,
             --[HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CHANGE_OPERATION] [nchar](1) NULL,
             --[HFIT_HEALTHASSESMENTUSERSTARTED_CTID] [int] NULL,
             --[HFIT_HEALTHASSESMENTUSERSTARTED_CHANGE_OPERATION] [nchar](1) NULL,
             --[CT_CMS_USER_SCV] [bigint] NULL,
             --[CT_CMS_USERSETTINGS_SCV] [bigint] NULL,
             --[CT_CMS_SITE_SCV] [bigint] NULL,
             --[CT_CMS_USERSITE_SCV] [bigint] NULL,
             --[CT_HFIT_ACCOUNT_SCV] [bigint] NULL,
             --[CT_HFIT_HealthAssesmentUserAnswers_SCV] [bigint] NULL,
             --[CT_HFIT_HEALTHASSESMENTUSERMODULE_SCV] [bigint] NULL,
             --[CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV] [bigint] NULL,
             --[CT_HFIT_HealthAssesmentUserQuestionGroupResults_SCV] [bigint] NULL,
             --[CT_HFIT_HEALTHASSESMENTUSERRISKAREA_SCV] [bigint] NULL,
             --[CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY_SCV] [bigint] NULL,
             --[CT_HFIT_HEALTHASSESMENTUSERSTARTED_SCV] [bigint] NULL,
             LastModifiedDATE DATETIME2 (7) NULL
           ,DELETEFLG INT NULL
           ,HealthAssessmentType VARCHAR (9) NULL
           ,LASTUPDATEID INT NULL
           ,SVR NVARCHAR (100) NOT NULL
           ,DBNAME NVARCHAR (100) NOT NULL
           ,LASTLOADEDDATE INT NULL
           ,RowNumber INT IDENTITY (1, 1) 
) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

--drop index CI00_FACT_EDW_HealthAssesment on FACT_EDW_HealthAssesment 
CREATE INDEX CI00_FACT_EDW_HealthAssesment ON FACT_EDW_HealthAssesment (SVR, DBNAME, USERSTARTEDITEMID, UserID) 
    INCLUDE (USERGUID, LastModifiedDATE) ;

CREATE INDEX PI00_FACT_EDW_HealthAssesment ON FACT_EDW_HealthAssesment (RowNumber) ;

CREATE NONCLUSTERED INDEX PI_02_BASE_cms_usersettings
ON [dbo].[BASE_cms_usersettings] ([HFitUserMpiNumber])
INCLUDE ([UserSettingsUserID],[SVR],[DBNAME])

GO
PRINT 'Executed FACT_EDW_HealthAssesment.sql';
GO