
GO
PRINT 'Executing proc_Create_StagingTables_INIT.SQL';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_Create_StagingTables_INIT') 
    BEGIN
        DROP PROCEDURE
             dbo.proc_Create_StagingTables_INIT
    END;
GO

-- exec proc_Create_StagingTables_INIT
CREATE PROCEDURE dbo.proc_Create_StagingTables_INIT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.tables
                           WHERE name = 'DIM_EDW_HealthAssessment') 
        BEGIN

            SET ANSI_NULLS ON;
            SET QUOTED_IDENTIFIER ON;
            SET ANSI_PADDING ON;

            CREATE TABLE dbo.DIM_EDW_HealthAssessment (
                         USERSTARTEDITEMID INT NULL
                       , HEALTHASSESMENTUSERSTARTEDNODEGUID UNIQUEIDENTIFIER NULL
                       , USERID BIGINT NULL
                       , USERGUID UNIQUEIDENTIFIER NULL
                       , HFITUSERMPINUMBER BIGINT NULL
                       , SITEGUID UNIQUEIDENTIFIER NULL
                       , ACCOUNTID INT NULL
                       , ACCOUNTCD NVARCHAR (8) NULL
                       , ACCOUNTNAME NVARCHAR (200) NULL
                       , HASTARTEDDT DATETIME NULL
                       , HACOMPLETEDDT DATETIME NULL
                       , USERMODULEITEMID INT NULL
                       , USERMODULECODENAME NVARCHAR (100) NULL
                       , HAMODULENODEGUID UNIQUEIDENTIFIER NULL
                       , CMSNODEGUID UNIQUEIDENTIFIER NULL
                       , HAMODULEVERSIONID INT NULL
                       , USERRISKCATEGORYITEMID INT NULL
                       , USERRISKCATEGORYCODENAME NVARCHAR (100) NULL
                       , HARISKCATEGORYNODEGUID UNIQUEIDENTIFIER NULL
                       , HARISKCATEGORYVERSIONID INT NULL
                       , USERRISKAREAITEMID INT NULL
                       , USERRISKAREACODENAME NVARCHAR (100) NULL
                       , HARISKAREANODEGUID UNIQUEIDENTIFIER NULL
                       , HARISKAREAVERSIONID INT NULL
                       , USERQUESTIONITEMID INT NULL
                       , TITLE VARCHAR (MAX) NULL
                       , HAQUESTIONGUID UNIQUEIDENTIFIER NULL
                       , USERQUESTIONCODENAME NVARCHAR (100) NULL
                       , HAQUESTIONDOCUMENTID INT NULL
                       , HAQUESTIONVERSIONID INT NULL
                       , HAQUESTIONNODEGUID UNIQUEIDENTIFIER NULL
                       , USERANSWERITEMID INT NULL
                       , HAANSWERNODEGUID UNIQUEIDENTIFIER NULL
                       , HAANSWERVERSIONID INT NULL
                       , USERANSWERCODENAME NVARCHAR (100) NULL
                       , HAANSWERVALUE NVARCHAR (255) NULL
                       , HAMODULESCORE FLOAT NULL
                       , HARISKCATEGORYSCORE FLOAT NULL
                       , HARISKAREASCORE FLOAT NULL
                       , HAQUESTIONSCORE FLOAT NULL
                       , HAANSWERPOINTS INT NULL
                       , POINTRESULTS INT NULL
                       , UOMCODE NVARCHAR (10) NULL
                       , HASCORE INT NULL
                       , MODULEPREWEIGHTEDSCORE FLOAT NULL
                       , RISKCATEGORYPREWEIGHTEDSCORE FLOAT NULL
                       , RISKAREAPREWEIGHTEDSCORE FLOAT NULL
                       , QUESTIONPREWEIGHTEDSCORE FLOAT NULL
                       , QUESTIONGROUPCODENAME NVARCHAR (100) NULL
                       , ITEMCREATEDWHEN DATETIME NULL
                       , ITEMMODIFIEDWHEN DATETIME NULL
                       , ISPROFESSIONALLYCOLLECTED BIT NULL
                       , HARISKCATEGORY_ITEMMODIFIEDWHEN DATETIME NULL
                       , HAUSERRISKAREA_ITEMMODIFIEDWHEN DATETIME NULL
                       , HAUSERQUESTION_ITEMMODIFIEDWHEN DATETIME NULL
                       , HAUSERANSWERS_ITEMMODIFIEDWHEN DATETIME NULL
                       , HAPAPERFLG BIT NULL
                       , HATELEPHONICFLG BIT NULL
                       , HASTARTEDMODE INT NULL
                       , HACOMPLETEDMODE INT NULL
                       , DOCUMENTCULTURE_VHCJ NVARCHAR (10) NULL
                       , DOCUMENTCULTURE_HAQUESTIONSVIEW NVARCHAR (10) NULL
                       , CAMPAIGNNODEGUID UNIQUEIDENTIFIER NULL
                       , HACAMPAIGNID INT NULL
                       , HASHCODE VARCHAR (100) NULL
                       , PKHASHCODE VARCHAR (100) NULL
                       , CHANGED_FLG INT NULL
                       , LASTMODIFIEDDATE DATETIME NULL
                       , HEALTHASSESSMENTTYPE VARCHAR (9) NULL
                       , HAUSERSTARTED_LASTMODIFIED DATETIME NULL
                       , CMSUSER_LASTMODIFIED DATETIME NULL
                       , USERSETTINGS_LASTMODIFIED DATETIME NULL
                       , USERSITE_LASTMODIFIED DATETIME NULL
                       , CMSSITE_LASTMODIFIED DATETIME NULL
                       , ACCT_LASTMODIFIED DATETIME NULL
                       , HAUSERMODULE_LASTMODIFIED DATETIME NULL
                       , VHCJ_LASTMODIFIED DATETIME NULL
                       , VHAJ_LASTMODIFIED DATETIME NULL
                       , HARISKCATEGORY_LASTMODIFIED DATETIME NULL
                       , HAUSERRISKAREA_LASTMODIFIED DATETIME NULL
                       , HAUSERQUESTION_LASTMODIFIED DATETIME NULL
                       , HAQUESTIONSVIEW_LASTMODIFIED DATETIME NULL
                       , HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED DATETIME NULL
                       , HAUSERANSWERS_LASTMODIFIED DATETIME NULL
                       , HAUSERSTARTED_LastUpdateID INT NULL
                       , CMSUSER_LastUpdateID INT NULL
                       , USERSETTINGS_LastUpdateID INT NULL
                       , USERSITE_LastUpdateID INT NULL
                       , CMSSITE_LastUpdateID DATETIME NULL
                       , ACCT_LastUpdateID DATETIME NULL
                       , HAUSERMODULE_LastUpdateID INT NULL
                       , VHCJ_LastUpdateID INT NULL
                       , VHAJ_LastUpdateID INT NULL
                       , HARISKCATEGORY_LastUpdateID INT NULL
                       , HAUSERRISKAREA_LastUpdateID INT NULL
                       , HAUSERQUESTION_LastUpdateID INT NULL
                       , HAQUESTIONSVIEW_LastUpdateID INT NULL
                       , HAUSERQUESTIONGROUPRESULTS_LastUpdateID INT NULL
                       , HAUSERANSWERS_LastUpdateID INT NULL
                       , LASTUPDATEID INT NULL
                       , DELETEFLG INT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DELETEDFLG INT NULL
                       , RowNbr INT NULL
                       , TimeZone NVARCHAR (10) NULL
                       , ConvertedToCentralTime BIT NULL
            ) 
            ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_DIM_EDW_HealthAssessment_CDT ON dbo.DIM_EDW_HealthAssessment
            (
            ConvertedToCentralTime ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_DIM_EDW_HealthAssessment_Dates ON dbo.DIM_EDW_HealthAssessment
            (
            ITEMMODIFIEDWHEN ASC,
            HAUSERSTARTED_LASTMODIFIED ASC,
            CMSUSER_LASTMODIFIED ASC,
            USERSETTINGS_LASTMODIFIED ASC,
            USERSITE_LASTMODIFIED ASC,
            CMSSITE_LASTMODIFIED ASC,
            ACCT_LASTMODIFIED ASC,
            HAUSERMODULE_LASTMODIFIED ASC,
            VHCJ_LASTMODIFIED ASC,
            VHAJ_LASTMODIFIED ASC,
            HARISKCATEGORY_LASTMODIFIED ASC,
            HAUSERRISKAREA_LASTMODIFIED ASC,
            HAUSERQUESTION_LASTMODIFIED ASC,
            HAQUESTIONSVIEW_LASTMODIFIED ASC,
            HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED ASC,
            HAUSERANSWERS_LASTMODIFIED ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE CLUSTERED INDEX PI_DIM_EDW_HealthAssessment_NATKEY ON dbo.DIM_EDW_HealthAssessment
            (
            USERSTARTEDITEMID ASC,
            USERGUID ASC,
            PKHASHCODE ASC,
            DeletedFlg
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            IF NOT EXISTS (SELECT
                                  name
                                  FROM sys.indexes
                                  WHERE name = 'DIM_EDW_HealthAssessment') 
                BEGIN
                    CREATE NONCLUSTERED INDEX PI_DIM_EDW_HealthAssessment_DelFLG
                    ON dbo.DIM_EDW_HealthAssessment (LASTMODIFIEDDATE, DELETEDFLG) ;
                END;
        END;
    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_CombinedHAViews') 
        BEGIN
            PRINT ' Initalizing DIM_EDW_CombinedHAViews';
            CREATE TABLE dbo.DIM_EDW_CombinedHAViews (
                         USERRISKCATEGORYITEMID INT NULL
                       , USERRISKCATEGORYCODENAME NVARCHAR (100) NOT NULL
                       , HARISKCATEGORYNODEGUID UNIQUEIDENTIFIER NOT NULL
                       , HARISKCATEGORYSCORE FLOAT NULL
                       , RISKCATEGORYPREWEIGHTEDSCORE FLOAT NULL
                       , HARISKCATEGORY_ITEMMODIFIEDWHEN DATETIME NULL
                       , HAMODULEITEMID INT NULL
                       , USERRISKAREAITEMID INT NULL
                       , USERRISKAREACODENAME NVARCHAR (100) NOT NULL
                       , HARISKAREANODEGUID UNIQUEIDENTIFIER NOT NULL
                       , HARISKAREASCORE FLOAT NULL
                       , RISKAREAPREWEIGHTEDSCORE FLOAT NULL
                       , HAUSERRISKAREA_ITEMMODIFIEDWHEN DATETIME NULL
                       , USERQUESTIONITEMID INT NULL
                       , HAQUESTIONGUID UNIQUEIDENTIFIER NOT NULL
                       , USERQUESTIONCODENAME NVARCHAR (100) NOT NULL
                       , HAQUESTIONNODEGUID UNIQUEIDENTIFIER NOT NULL
                       , HAQUESTIONSCORE FLOAT NULL
                       , QUESTIONPREWEIGHTEDSCORE FLOAT NULL
                       , ISPROFESSIONALLYCOLLECTED BIT NOT NULL
                       , HAUSERQUESTION_ITEMMODIFIEDWHEN DATETIME NULL
                       , TITLE VARCHAR (MAX) NULL
                       , DOCUMENTCULTURE_HAQUESTIONSVIEW NVARCHAR (10) NOT NULL
                       , HAQUESTIONSVIEW_LASTMODIFIED DATETIME NOT NULL
                       , GroupResultsItemID INT NULL
                       , POINTRESULTS INT NULL
                       , QUESTIONGROUPCODENAME NVARCHAR (100) NULL
                       , HARISKAREAITEMID INT NULL
                       , HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED DATETIME NULL
                       , USERANSWERITEMID INT NULL
                       , HAANSWERNODEGUID UNIQUEIDENTIFIER NOT NULL
                       , USERANSWERCODENAME NVARCHAR (100) NOT NULL
                       , HAANSWERVALUE NVARCHAR (255) NULL
                       , HAANSWERPOINTS INT NULL
                       , UOMCODE NVARCHAR (10) NULL
                       , HAQUESTIONITEMID INT NOT NULL
                       , ITEMCREATEDWHEN DATETIME NULL
                       , HAUSERANSWERS_ITEMMODIFIEDWHEN DATETIME NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
            ) 
            ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
            CREATE CLUSTERED INDEX PI_DIM_EDW_CombinedHAViews ON dbo.DIM_EDW_CombinedHAViews
            (
            USERRISKCATEGORYITEMID ASC,
            USERRISKAREAITEMID ASC,
            HARISKAREANODEGUID ASC,
            USERQUESTIONITEMID ASC,
            HAQUESTIONGUID ASC,
            HAQUESTIONNODEGUID ASC,
            HAANSWERNODEGUID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_CMS_USER') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_CMS_USER (
                         USERGUID UNIQUEIDENTIFIER NOT NULL
                       , LastModifiedWhen DATETIME2 (7) NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , USERID INT NULL
            ) 
            ON [PRIMARY];
            CREATE UNIQUE CLUSTERED INDEX PI_DIM_EDW_CMS_USER ON dbo.DIM_EDW_CMS_USER
            (
            USERID ASC,
            USERGUID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_CMS_USERSETTINGS') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_CMS_USERSETTINGS (
                         USERSETTINGSUSERID INT NOT NULL
                       , HFITUSERMPINUMBER BIGINT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , USERSETTINGSID INT NULL
            ) 
            ON [PRIMARY];

            CREATE CLUSTERED INDEX PI_CMS_USER ON dbo.DIM_EDW_CMS_USERSETTINGS
            (
            USERSETTINGSID ASC,
            USERSETTINGSUSERID ASC,
            HFITUSERMPINUMBER ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_CMS_USER_IDS ON dbo.DIM_EDW_CMS_USERSETTINGS
            (
            USERSETTINGSUSERID ASC,
            HFITUSERMPINUMBER ASC
            ) 
            INCLUDE ( 	LASTUPDATEID,
            LASTLOADEDDATE,
            SVR,
            DBNAME,
            DeletedFlg,
            USERSETTINGSID) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_CMS_USERSITE') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_CMS_USERSITE (
                         USERID INT NOT NULL
                       , SITEID INT NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , USERSITEID INT NULL
            ) 
            ON [PRIMARY];

            CREATE CLUSTERED INDEX PI_EDW_CMS_USERSITE ON dbo.DIM_EDW_CMS_USERSITE
            (
            USERSITEID ASC,
            USERID ASC,
            SITEID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_EDW_CMS_USERSITE_UID ON dbo.DIM_EDW_CMS_USERSITE
            (
            USERID ASC
            ) 
            INCLUDE ( 	SITEID,
            LASTUPDATEID,
            LASTLOADEDDATE,
            SVR,
            DBNAME,
            DeletedFlg,
            USERSITEID) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HealthAssessmentDefinition') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_HealthAssessmentDefinition (
                         SiteGUID INT NULL
                       , AccountCD INT NULL
                       , HANodeID INT NOT NULL
                       , HANodeName NVARCHAR (100) NOT NULL
                       , HADocumentID INT NULL
                       , HANodeSiteID INT NOT NULL
                       , HADocPubVerID INT NULL
                       , ModTitle VARCHAR (MAX) NULL
                       , IntroText VARCHAR (MAX) NULL
                       , ModDocGuid UNIQUEIDENTIFIER NOT NULL
                       , ModWeight INT NOT NULL
                       , ModIsEnabled BIT NOT NULL
                       , ModCodeName NVARCHAR (100) NOT NULL
                       , ModDocPubVerID INT NULL
                       , RCTitle VARCHAR (MAX) NULL
                       , RCWeight INT NOT NULL
                       , RCDocumentGUID UNIQUEIDENTIFIER NOT NULL
                       , RCIsEnabled BIT NOT NULL
                       , RCCodeName NVARCHAR (100) NOT NULL
                       , RCDocPubVerID INT NULL
                       , RATytle VARCHAR (MAX) NULL
                       , RAWeight INT NOT NULL
                       , RADocumentGuid UNIQUEIDENTIFIER NOT NULL
                       , RAIsEnabled BIT NOT NULL
                       , RACodeName NVARCHAR (100) NOT NULL
                       , RAScoringStrategyID INT NOT NULL
                       , RADocPubVerID INT NULL
                       , QuestionType NVARCHAR (100) NOT NULL
                       , QuesTitle VARCHAR (MAX) NULL
                       , QuesWeight INT NOT NULL
                       , QuesIsRequired BIT NOT NULL
                       , QuesDocumentGuid UNIQUEIDENTIFIER NOT NULL
                       , QuesIsEnabled BIT NOT NULL
                       , QuesIsVisible NVARCHAR (MAX) NULL
                       , QuesIsSTaging BIT NOT NULL
                       , QuestionCodeName NVARCHAR (100) NOT NULL
                       , QuesDocPubVerID INT NULL
                       , AnsValue NVARCHAR (150) NULL
                       , AnsPoints INT NULL
                       , AnsDocumentGuid UNIQUEIDENTIFIER NULL
                       , AnsIsEnabled BIT NULL
                       , AnsCodeName NVARCHAR (100) NULL
                       , AnsUOM NVARCHAR (5) NULL
                       , AnsDocPUbVerID INT NULL
                       , ChangeType VARCHAR (1) NOT NULL
                       , DocumentCreatedWhen DATETIME NULL
                       , DocumentModifiedWhen DATETIME NULL
                       , CmsTreeNodeGuid UNIQUEIDENTIFIER NOT NULL
                       , HANodeGUID UNIQUEIDENTIFIER NOT NULL
                       , SiteLastModified INT NULL
                       , Account_ItemModifiedWhen INT NULL
                       , Campaign_DocumentModifiedWhen INT NULL
                       , Assessment_DocumentModifiedWhen DATETIME NULL
                       , Module_DocumentModifiedWhen DATETIME NULL
                       , RiskCategory_DocumentModifiedWhen DATETIME NULL
                       , RiskArea_DocumentModifiedWhen DATETIME NULL
                       , Question_DocumentModifiedWhen DATETIME NULL
                       , Answer_DocumentModifiedWhen DATETIME NULL
                       , AllowMultiSelect BIT NULL
                       , LocID VARCHAR (5) NOT NULL
                       , CMS_Class_CtID INT NULL
                       , CMS_Class_SCV BIGINT NULL
                       , CMS_Document_CtID INT NULL
                       , CMS_Document_SCV BIGINT NULL
                       , CMS_Site_CtID INT NULL
                       , CMS_Site_SCV BIGINT NULL
                       , CMS_Tree_CtID INT NULL
                       , CMS_Tree_SCV BIGINT NULL
                       , CMS_User_CtID INT NULL
                       , CMS_User_SCV BIGINT NULL
                       , COM_SKU_CtID INT NULL
                       , COM_SKU_SCV BIGINT NULL
                       , HFit_HealthAssesmentMatrixQuestion_CtID INT NULL
                       , HFit_HealthAssesmentMatrixQuestion_SCV BIGINT NULL
                       , HFit_HealthAssesmentModule_CtID INT NULL
                       , HFit_HealthAssesmentModule_SCV BIGINT NULL
                       , HFit_HealthAssesmentMultipleChoiceQuestion_CtID INT NULL
                       , HFit_HealthAssesmentMultipleChoiceQuestion_SCV BIGINT NULL
                       , HFit_HealthAssesmentRiskArea_CtID INT NULL
                       , HFit_HealthAssesmentRiskArea_SCV BIGINT NULL
                       , HFit_HealthAssesmentRiskCategory_CtID INT NULL
                       , HFit_HealthAssesmentRiskCategory_SCV BIGINT NULL
                       , HFit_HealthAssessment_CtID INT NULL
                       , HFit_HealthAssessment_SCV BIGINT NULL
                       , HFit_HealthAssessmentFreeForm_CtID INT NULL
                       , HFit_HealthAssessmentFreeForm_SCV BIGINT NULL
                       , CMS_Class_CHANGE_OPERATION NCHAR (1) NULL
                       , CMS_Document_CHANGE_OPERATION NCHAR (1) NULL
                       , CMS_Site_CHANGE_OPERATION NCHAR (1) NULL
                       , CMS_Tree_CHANGE_OPERATION NCHAR (1) NULL
                       , CMS_User_CHANGE_OPERATION NCHAR (1) NULL
                       , COM_SKU_CHANGE_OPERATION NCHAR (1) NULL
                       , HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION NCHAR (1) NULL
                       , HFit_HealthAssesmentModule_CHANGE_OPERATION NCHAR (1) NULL
                       , HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION NCHAR (1) NULL
                       , HFit_HealthAssesmentRiskArea_CHANGE_OPERATION NCHAR (1) NULL
                       , HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION NCHAR (1) NULL
                       , HFit_HealthAssessment_CHANGE_OPERATION NCHAR (1) NULL
                       , HFit_HealthAssessmentFreeForm_CHANGE_OPERATION NCHAR (1) NULL
                       , CHANGED_FLG INT NULL
                       , CHANGE_TYPE_CODE NCHAR (1) NULL
                       , LastModifiedDate DATETIME NULL
                       , RowNbr INT NULL
                       , DeletedFlg BIT NULL
                       , TimeZone NVARCHAR (10) NULL
                       , ConvertedToCentralTime BIT NULL
            ) 
            ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

            CREATE CLUSTERED INDEX PI_DIM_EDW_HealthAssessmentDefinition ON dbo.DIM_EDW_HealthAssessmentDefinition
            (
            SiteGUID ASC
            , AccountCD ASC
            , HANodeID ASC
            , HADocumentID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFIT_HealthAssesmentUserAnswers') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_HFIT_HealthAssesmentUserAnswers (
                         HAANSWERNODEGUID UNIQUEIDENTIFIER NOT NULL
                       , CODENAME NVARCHAR (100) NOT NULL
                       , HAANSWERVALUE NVARCHAR (255) NULL
                       , HAANSWERPOINTS INT NULL
                       , UOMCODE NVARCHAR (10) NULL
                       , ITEMCREATEDWHEN DATETIME2 (7) NULL
                       , ITEMMODIFIEDWHEN DATETIME2 (7) NULL
                       , HAQUESTIONITEMID INT NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , ITEMID INT NULL
            ) 
            ON [PRIMARY];
            --drop index PI_HFIT_HealthAssesmentUserAnswers ON dbo.DIM_EDW_HFIT_HealthAssesmentUserAnswers
            CREATE CLUSTERED INDEX PI_HFIT_HealthAssesmentUserAnswers ON dbo.DIM_EDW_HFIT_HealthAssesmentUserAnswers
            (
            ITEMID ASC,
            HAQUESTIONITEMID ASC,
            HAANSWERNODEGUID ASC,
            CODENAME ASC,
            HAANSWERVALUE ASC,
            HAANSWERPOINTS ASC,
            UOMCODE ASC,
            ITEMCREATEDWHEN ASC,
            ITEMMODIFIEDWHEN ASC,
            LASTUPDATEID, LASTLOADEDDATE
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_HFIT_HealthAssesmentUserAnswers_HAQUESTIONITEMID ON dbo.DIM_EDW_HFIT_HealthAssesmentUserAnswers
            (
            HAQUESTIONITEMID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_HFIT_HealthAssesmentUserAnswers_LASTUPDATEID ON dbo.DIM_EDW_HFIT_HealthAssesmentUserAnswers
            (
            ITEMID ASC,
            LASTUPDATEID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE (
                         HASTARTEDITEMID INT NOT NULL
                       , CODENAME NVARCHAR (100) NOT NULL
                       , HAMODULENODEGUID UNIQUEIDENTIFIER NOT NULL
                       , HAMODULESCORE FLOAT NOT NULL
                       , PREWEIGHTEDSCORE FLOAT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , ITEMID INT NULL
            ) 
            ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_EDW_HFIT_HEALTHASSESMENTUSERMODULE ON dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE
            (
            ITEMID ASC,
            HASTARTEDITEMID ASC
            ) 
            INCLUDE ( 	CODENAME,
            HAMODULENODEGUID,
            HAMODULESCORE,
            PREWEIGHTEDSCORE) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_EDW_HFIT_HEALTHASSESMENTUSERMODULE_HASITEMID ON dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE
            (
            HASTARTEDITEMID ASC
            ) 
            INCLUDE ( 	CODENAME,
            HAMODULENODEGUID,
            HAMODULESCORE,
            PREWEIGHTEDSCORE,
            LASTUPDATEID,
            LASTLOADEDDATE,
            SVR,
            DBNAME,
            DeletedFlg,
            ITEMID) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFit_HealthAssesmentUserQuestion') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_HFit_HealthAssesmentUserQuestion (
                         HAQUESTIONNODEGUID UNIQUEIDENTIFIER NOT NULL
                       , CODENAME NVARCHAR (100) NOT NULL
                       , HAQUESTIONSCORE FLOAT NULL
                       , PREWEIGHTEDSCORE FLOAT NULL
                       , ISPROFESSIONALLYCOLLECTED BIT NOT NULL
                       , ITEMMODIFIEDWHEN DATETIME2 (7) NULL
                       , HARISKAREAITEMID INT NOT NULL
                       , HFIT_HEALTHASSESMENTUSERQUESTION_CTID INT NULL
                       , HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION NCHAR (1) NULL
                       , CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV BIGINT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , ITEMID INT NULL
            ) 
            ON [PRIMARY];

            CREATE CLUSTERED INDEX PI_HFit_HealthAssesmentUserQuestion ON dbo.DIM_EDW_HFit_HealthAssesmentUserQuestion
            (
            ITEMID ASC,
            HARISKAREAITEMID ASC,
            HAQUESTIONNODEGUID ASC,
            CODENAME ASC,
            HAQUESTIONSCORE ASC,
            PREWEIGHTEDSCORE ASC,
            ISPROFESSIONALLYCOLLECTED,
            ITEMMODIFIEDWHEN ASC,
            LASTUPDATEID ASC,
            LASTLOADEDDATE ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI01_DIM_EDW_HFIT_HEALTHASSESMENTUSERQUESTION ON dbo.DIM_EDW_HFit_HealthAssesmentUserQuestion
            (
            HARISKAREAITEMID ASC
            ) 
            INCLUDE ( 	ITEMID,
            HAQUESTIONNODEGUID,
            CODENAME,
            HAQUESTIONSCORE,
            PREWEIGHTEDSCORE,
            ISPROFESSIONALLYCOLLECTED,
            ITEMMODIFIEDWHEN,
            LASTUPDATEID ,
            LASTLOADEDDATE) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE UNIQUE NONCLUSTERED INDEX UK_DIM_EDW_HFIT_HEALTHASSESMENTUSERQUESTION ON dbo.DIM_EDW_HFit_HealthAssesmentUserQuestion
            (
            ITEMID ASC,
            LASTUPDATEID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults (
                         POINTRESULTS INT NOT NULL
                       , CODENAME NVARCHAR (100) NOT NULL
                       , HARISKAREAITEMID INT NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , ITEMID INT NULL
            ) 
            ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_HealthAssesmentUserQuestionGroupResults ON dbo.DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
            (
            ITEMID ASC
            ) 
            INCLUDE ( 	POINTRESULTS,
            CODENAME,
            HARISKAREAITEMID) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_DIM_HAUserQuestionGroupResults ON dbo.DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults
            (
            HARISKAREAITEMID ASC
            ) 
            INCLUDE ( 	ITEMID,
            POINTRESULTS,
            CODENAME) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFit_HealthAssesmentUserRiskArea') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_HFit_HealthAssesmentUserRiskArea (
                         CODENAME NVARCHAR (100) NOT NULL
                       , HARISKAREANODEGUID UNIQUEIDENTIFIER NOT NULL
                       , HARISKAREASCORE FLOAT NULL
                       , PREWEIGHTEDSCORE FLOAT NULL
                       , ITEMMODIFIEDWHEN DATETIME2 (7) NULL
                       , HARISKCATEGORYITEMID INT NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , ITEMID INT NULL
            ) 
            ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_HEALTHASSESMENTUSERRISKAREA_Category ON dbo.DIM_EDW_HFit_HealthAssesmentUserRiskArea
            (
            HARISKCATEGORYITEMID ASC
            ) 
            INCLUDE ( 	CODENAME,
            HARISKAREANODEGUID,
            HARISKAREASCORE,
            PREWEIGHTEDSCORE,
            ITEMMODIFIEDWHEN,
            LASTUPDATEID,
            LASTLOADEDDATE,
            SVR,
            DBNAME,
            DeletedFlg,
            ITEMID) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY') 
        BEGIN

            CREATE TABLE dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY (
                         CODENAME NVARCHAR (100) NOT NULL
                       , HARISKCATEGORYNODEGUID UNIQUEIDENTIFIER NOT NULL
                       , HARISKCATEGORYSCORE FLOAT NULL
                       , PREWEIGHTEDSCORE FLOAT NULL
                       , ITEMMODIFIEDWHEN DATETIME2 (7) NULL
                       , HAMODULEITEMID INT NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , ITEMID INT NULL
            ) 
            ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_EDW_HEALTHASSESMENTUSERRISKCATEGORY ON dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
            (
            ITEMID ASC,
            HAMODULEITEMID ASC
            ) 
            INCLUDE ( 	CODENAME,
            HARISKCATEGORYNODEGUID,
            HARISKCATEGORYSCORE,
            PREWEIGHTEDSCORE,
            ITEMMODIFIEDWHEN) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_EDW_HEALTHASSESMENTUSERRISKCATEGORY_HAMODID ON dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
            (
            HAMODULEITEMID ASC
            ) 
            INCLUDE ( 	CODENAME,
            HARISKCATEGORYNODEGUID,
            HARISKCATEGORYSCORE,
            PREWEIGHTEDSCORE,
            ITEMMODIFIEDWHEN,
            LASTUPDATEID,
            LASTLOADEDDATE,
            SVR,
            DBNAME,
            DeletedFlg,
            ITEMID) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED (
                         USERID BIGINT NOT NULL
                       , HASTARTEDDT DATETIME2 (7) NOT NULL
                       , HACOMPLETEDDT DATETIME2 (7) NULL
                       , HASCORE INT NULL
                       , HAPAPERFLG BIT NOT NULL
                       , HATELEPHONICFLG BIT NOT NULL
                       , HASTARTEDMODE INT NOT NULL
                       , HACOMPLETEDMODE INT NOT NULL
                       , HACAMPAIGNNODEGUID UNIQUEIDENTIFIER NOT NULL
                       , HADocumentConfigID INT NULL
                       , ItemModifiedWhen DATETIME2 (7) NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , ITEMID INT NULL
            ) 
            ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_HFIT_HEALTHASSESMENTUSERSTARTED ON dbo.DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED
            (
            ITEMID ASC,
            USERID ASC
            ) 
            INCLUDE ( 	HASTARTEDDT,
            HACOMPLETEDDT,
            HASCORE,
            HAPAPERFLG,
            HATELEPHONICFLG,
            HASTARTEDMODE,
            HACAMPAIGNNODEGUID,
            HADocumentConfigID) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS (
                         TITLE VARCHAR (MAX) NULL
                       , DOCUMENTCULTURE NVARCHAR (10) NOT NULL
                       , NODEGUID UNIQUEIDENTIFIER NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
            ) 
            ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

            CREATE UNIQUE CLUSTERED INDEX PI_VIEW_EDW_HEALTHASSESMENTQUESTIONS ON dbo.DIM_EDW_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS
            (
            DOCUMENTCULTURE ASC,
            NODEGUID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED (
                         DOCUMENTCULTURE NVARCHAR (10) NOT NULL
                       , HACAMPAIGNID INT NOT NULL
                       , NODEGUID UNIQUEIDENTIFIER NOT NULL
                       , NODESITEID INT NOT NULL
                       , HEALTHASSESSMENTID INT NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
            ) 
            ON [PRIMARY];

            CREATE UNIQUE CLUSTERED INDEX PI_VIEW_HFIT_HACAMPAIGN_JOINED ON dbo.DIM_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED
            (
            DOCUMENTCULTURE ASC,
            HACAMPAIGNID ASC,
            NODEGUID ASC,
            NODESITEID ASC,
            HEALTHASSESSMENTID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

            CREATE NONCLUSTERED INDEX PI_VIEW_HFIT_HACAMPAIGN_JOINED_CULTURE ON dbo.DIM_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED
            (
            NODEGUID ASC,
            DOCUMENTCULTURE ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED (
                         NODEGUID UNIQUEIDENTIFIER NOT NULL
                       , DOCUMENTID INT NOT NULL
                       , DOCUMENTCULTURE NVARCHAR (10) NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
            ) 
            ON [PRIMARY];

            CREATE UNIQUE CLUSTERED INDEX PI_VIEW_HFIT_HEALTHASSESSMENT_JOINED ON dbo.DIM_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED
            (
            NODEGUID ASC,
            DOCUMENTID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_View_EDW_HealthAssesmentQuestions') 
        BEGIN
            CREATE TABLE dbo.DIM_EDW_View_EDW_HealthAssesmentQuestions (
                         TITLE VARCHAR (MAX) NULL
                       , DOCUMENTCULTURE NVARCHAR (10) NOT NULL
                       , LASTUPDATEID INT NOT NULL
                       , LASTLOADEDDATE DATETIME NOT NULL
                       , SVR NVARCHAR (128) NULL
                       , DBNAME NVARCHAR (128) NULL
                       , DeletedFlg INT NOT NULL
                       , NODEGUID UNIQUEIDENTIFIER NULL
            ) 
            ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

            CREATE UNIQUE CLUSTERED INDEX PI_VIEW_EDW_HEALTHASSESMENTQUESTIONS ON dbo.DIM_EDW_View_EDW_HealthAssesmentQuestions
            (
            DOCUMENTCULTURE ASC,
            NODEGUID ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
        END;

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKAREA_Joined') 
        BEGIN
            DROP TABLE
                 DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKAREA_Joined;
        END;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKAREA_Joined') 
        BEGIN
            PRINT 'POPULATING DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKAREA_Joined';
            SELECT
                   HAUserRiskArea.ITEMID AS UserRiskAreaItemID
                 , HAUserRiskArea.HARISKCATEGORYITEMID
                 , HAUserRiskArea.CODENAME AS USERRISKAREACODENAME
                 , HAUserRiskArea.HARISKAREANODEGUID
                 , NULL AS HARISKAREAVERSIONID
                 , HAUserRiskArea.HARISKAREASCORE
                 , HAUserRiskArea.PREWEIGHTEDSCORE AS RISKAREAPREWEIGHTEDSCORE
                 , HAUserRiskArea.ITEMMODIFIEDWHEN AS HAUserRiskArea_ITEMMODIFIEDWHEN
                 , HAUserRiskArea.ITEMMODIFIEDWHEN AS HAUserRiskArea_LASTMODIFIED   --HAUserRiskArea.LASTLOADEDDATE 
                 , NULL AS HAUserRiskArea_LastUpdateID   --HAUserRiskArea.LastUpdateID 

                 , HAUserQuestionGroupResults.HARiskAreaItemID
                 , HAUserQuestionGroupResults.ItemID AS HAUserQuestionGroupResultsItemID
                 , HAUserQuestionGroupResults.POINTRESULTS
                 , HAUserQuestionGroupResults.CODENAME AS QUESTIONGROUPCODENAME
                 , HAUserQuestionGroupResults.ITEMMODIFIEDWHEN AS HAUserQuestionGroupResults_LASTMODIFIED	--HAUserQuestionGroupResults.LASTLOADEDDATE 
                 , NULL AS HAUserQuestionGroupResults_LastUpdateID	--HAUserQuestionGroupResults.LastUpdateID 

                 , HAUserRiskArea.ItemModifiedWhen AS LastModifiedWhen
                 , 0 AS LastUpdateID
                 , GETDATE () AS LASTLOADEDDATE
                 , @@SERVERNAME AS SVR
                 , DB_NAME () AS DBNAME
                 , 0 AS DeletedFlg
            INTO
                 DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined
                   FROM
            DBO.BASE_HFIT_HealthAssesmentUserRiskArea AS HAUserRiskArea --ON HARISKCATEGORY.ITEMID = HAUserRiskArea.HARISKCATEGORYITEMID
                LEFT JOIN DBO.HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUserQuestionGroupResults
                    ON HAUserRiskArea.ITEMID = HAUserQuestionGroupResults.HARiskAreaItemID;

            IF NOT EXISTS (SELECT
                                  column_name
                                  FROM information_schema.columns
                                  WHERE table_name = 'DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined'
                                    AND column_name = 'HARISKCATEGORYITEMID') 
                BEGIN
                    PRINT 'ADDING HARISKCATEGORYITEMID to DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined';
                    ALTER TABLE DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined
                    ADD
                                HARISKCATEGORYITEMID INT NULL;
                END;

            CREATE CLUSTERED INDEX PI_DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined ON DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined ( UserRiskAreaItemID ASC , HAUserQuestionGroupResultsItemID ASC) ;

            CREATE NONCLUSTERED INDEX CI_DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined
            ON dbo.DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined (HAUserQuestionGroupResultsItemID) 
            INCLUDE (UserRiskAreaItemID, LastUpdateID) ;

        END;

    SET NOCOUNT OFF;
END;

GO

PRINT 'Executed proc_Create_StagingTables_INIT.SQL';
GO
