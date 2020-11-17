
GO

--select top 10 * into XX_TEMP from view_EDW_HealthAssesment_CT

PRINT 'Creating the STAGING tables';

GO

/*-------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
*********************************************************************************************************************
=============================================================
DATE:      04-17-2015 16:49:54
SERVER:    hfit-tgt.cloudapp.net,2
Author:	  Dale Miller
Tables:
		DIM_EDW_HealthAssessmentDefinition, DIM_EDW_Coaches, DIM_EDW_CoachingDetail
		DIM_EDW_HealthAssesmentClientView, DIM_EDW_HealthAssessment, DIM_EDW_HealthDefinition
		DIM_EDW_HealthInterestDetail, DIM_EDW_HealthInterestList, DIM_EDW_RewardAwardDetail
		DIM_EDW_RewardTriggerParameters, DIM_EDW_RewardUserDetail, DIM_EDW_RewardUserLevel
		DIM_EDW_SmallSteps, DIM_EDW_Trackers, TEMP_EDW_Coaches_DATA
		TEMP_EDW_CoachingDetail_DATA, TEMP_EDW_HealthDefinition_DATA, TEMP_EDW_RewardAwardDetail_DATA
		TEMP_EDW_RewardTriggerParameters_DATA, TEMP_EDW_RewardUserLevel_DATA, TEMP_EDW_Tracker_DATA


=============================================================
*********************************************************************************************************************
*/

--IF EXISTS ( SELECT
--                   name
--              FROM sys.procedures
--              WHERE name = 'spPullEdwCompositeTracker' )

--    BEGIN

--        DROP PROCEDURE
--             spPullEdwCompositeTracker;
--    END;

--GO

--IF EXISTS ( SELECT
--                   name
--              FROM sys.procedures
--              WHERE name = 'proc_EDW_HA_Changes' )

--    BEGIN

--        DROP PROCEDURE
--             proc_EDW_HA_Changes;
--    END;

--GO

--IF EXISTS ( SELECT
--                   name
--              FROM sys.procedures
--              WHERE name = 'spPullEdwHaDefinition' )

--    BEGIN

--        DROP PROCEDURE
--             spPullEdwHaDefinition;
--    END;

--GO

PRINT 'Creating DIM_EDW_RewardsDefinition';

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_RewardsDefinition') 

    BEGIN

        DROP TABLE
             DIM_EDW_RewardsDefinition;
    END;

GO

CREATE TABLE dbo.DIM_EDW_RewardsDefinition (
             SiteGUID uniqueidentifier NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , RewardProgramGUID uniqueidentifier NOT NULL
           , RewardProgramName nvarchar (100) NOT NULL
           , RewardProgramPeriodStart datetime NOT NULL
           , RewardProgramPeriodEnd datetime NOT NULL
           , RewardGroupGuid uniqueidentifier NOT NULL
           , GroupName nvarchar (100) NOT NULL
           , RewardLevelGuid uniqueidentifier NOT NULL
           , Level nvarchar (50) NOT NULL
           , RewardLevelTypeLKPName nvarchar (25) NOT NULL
           , AwardDisplayName nvarchar (255) NULL
           , AwardType int NOT NULL
           , AwardThreshold1 int NOT NULL
           , AwardThreshold2 int NOT NULL
           , AwardThreshold3 int NOT NULL
           , AwardThreshold4 int NOT NULL
           , AwardValue1 float NOT NULL
           , AwardValue2 float NOT NULL
           , AwardValue3 float NOT NULL
           , AwardValue4 float NOT NULL
           , ExternalFulfillmentRequired bit NOT NULL
           , RewardActivityGuid uniqueidentifier NOT NULL
           , ActivityName nvarchar (150) NOT NULL
           , ActivityFreqOrCrit int NULL
           , ActivityPoints float NOT NULL
           , IsBundle bit NOT NULL
           , IsRequired bit NULL
           , MaxThreshold int NOT NULL
           , AwardPointsIncrementally bit NOT NULL
           , AllowMedicalExceptions bit NOT NULL
           , RewardTriggerGuid uniqueidentifier NOT NULL
           , RewardTriggerDynamicValue bit NULL
           , TriggerName nvarchar (100) NOT NULL
           , RewardTriggerParameterOperator int NOT NULL
           , RewardTriggerParmGUID uniqueidentifier NOT NULL
           , [Value] float NOT NULL
           , ChangeType varchar (1) NOT NULL
           , DocumentCulture_VHFRAJ nvarchar (10) NOT NULL
           , DocumentCulture_VHFRPJ nvarchar (10) NOT NULL
           , DocumentCulture_VHFRGJ nvarchar (10) NOT NULL
           , DocumentCulture_VHFRLJ nvarchar (10) NOT NULL
           , DocumentCulture_VHFRTPJ nvarchar (10) NOT NULL
           , LevelName nvarchar (128) NOT NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10) 
) 
ON [PRIMARY];

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardsDefinition';

GO

PRINT 'CREATED DIM_EDW_RewardsDefinition';

GO

SET ANSI_WARNINGS ON;

SET XACT_ABORT ON;

SET ARITHABORT ON;

SET NOCOUNT ON;

SET NUMERIC_ROUNDABORT OFF;

SET CONCAT_NULL_YIELDS_NULL ON;

GO

-- Create Table [dbo].[DIM_EDW_HealthAssessment]

PRINT 'Create Table [dbo].[DIM_EDW_HealthAssessment]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_HealthAssessment') 

    BEGIN

        DROP TABLE
             DIM_EDW_HealthAssessment;
    END;

GO

SET ANSI_NULLS ON;

GO

SET QUOTED_IDENTIFIER ON;

GO

SET ANSI_PADDING ON;

GO

--ALTER TABLE DIM_EDW_HealthAssessment ALTER COLUMN DeleteFlg INT NULL
CREATE TABLE dbo.DIM_EDW_HealthAssessment (
             USERSTARTEDITEMID int NULL
           , HEALTHASSESMENTUSERSTARTEDNODEGUID uniqueidentifier NULL
           , USERID bigint NULL
           , USERGUID uniqueidentifier NULL
           , HFITUSERMPINUMBER bigint NULL
           , SITEGUID uniqueidentifier NULL
           , ACCOUNTID int NULL
           , ACCOUNTCD nvarchar (8) NULL
           , ACCOUNTNAME nvarchar (200) NULL
           , HASTARTEDDT datetime NULL
           , HACOMPLETEDDT datetime NULL
           , USERMODULEITEMID int NULL
           , USERMODULECODENAME nvarchar (100) NULL
           , HAMODULENODEGUID uniqueidentifier NULL
           , CMSNODEGUID uniqueidentifier NULL
           , HAMODULEVERSIONID int NULL
           , USERRISKCATEGORYITEMID int NULL
           , USERRISKCATEGORYCODENAME nvarchar (100) NULL
           , HARISKCATEGORYNODEGUID uniqueidentifier NULL
           , HARISKCATEGORYVERSIONID int NULL
           , USERRISKAREAITEMID int NULL
           , USERRISKAREACODENAME nvarchar (100) NULL
           , HARISKAREANODEGUID uniqueidentifier NULL
           , HARISKAREAVERSIONID int NULL
           , USERQUESTIONITEMID int NULL
           , TITLE varchar (max) NULL
           , HAQUESTIONGUID uniqueidentifier NULL
           , USERQUESTIONCODENAME nvarchar (100) NULL
           , HAQUESTIONDOCUMENTID int NULL
           , HAQUESTIONVERSIONID int NULL
           , HAQUESTIONNODEGUID uniqueidentifier NULL
           , USERANSWERITEMID int NULL
           , HAANSWERNODEGUID uniqueidentifier NULL
           , HAANSWERVERSIONID int NULL
           , USERANSWERCODENAME nvarchar (100) NULL
           , HAANSWERVALUE nvarchar (255) NULL
           , HAMODULESCORE float NULL
           , HARISKCATEGORYSCORE float NULL
           , HARISKAREASCORE float NULL
           , HAQUESTIONSCORE float NULL
           , HAANSWERPOINTS int NULL
           , POINTRESULTS int NULL
           , UOMCODE nvarchar (10) NULL
           , HASCORE int NULL
           , MODULEPREWEIGHTEDSCORE float NULL
           , RISKCATEGORYPREWEIGHTEDSCORE float NULL
           , RISKAREAPREWEIGHTEDSCORE float NULL
           , QUESTIONPREWEIGHTEDSCORE float NULL
           , QUESTIONGROUPCODENAME nvarchar (100) NULL
           , ITEMCREATEDWHEN datetime NULL
           , ITEMMODIFIEDWHEN datetime NULL
           , ISPROFESSIONALLYCOLLECTED bit NULL
           , HARISKCATEGORY_ITEMMODIFIEDWHEN datetime NULL
           , HAUSERRISKAREA_ITEMMODIFIEDWHEN datetime NULL
           , HAUSERQUESTION_ITEMMODIFIEDWHEN datetime NULL
           , HAUSERANSWERS_ITEMMODIFIEDWHEN datetime NULL
           , HAPAPERFLG bit NULL
           , HATELEPHONICFLG bit NULL
           , HASTARTEDMODE int NULL
           , HACOMPLETEDMODE int NULL
           , DOCUMENTCULTURE_VHCJ nvarchar (10) NULL
           , DOCUMENTCULTURE_HAQUESTIONSVIEW nvarchar (10) NULL
           , CAMPAIGNNODEGUID uniqueidentifier NULL
           , HACAMPAIGNID int NULL
           , HASHCODE varchar (100) NULL
           , PKHASHCODE varchar (100) NULL
           , CHANGED_FLG int NULL
           , LASTMODIFIEDDATE datetime NULL
           , HEALTHASSESSMENTTYPE varchar (9) NULL
           , HAUSERSTARTED_LASTMODIFIED datetime NULL
           , CMSUSER_LASTMODIFIED datetime NULL
           , USERSETTINGS_LASTMODIFIED datetime NULL
           , USERSITE_LASTMODIFIED datetime NULL
           , CMSSITE_LASTMODIFIED datetime NULL
           , ACCT_LASTMODIFIED datetime NULL
           , HAUSERMODULE_LASTMODIFIED datetime NULL
           , VHCJ_LASTMODIFIED datetime NULL
           , VHAJ_LASTMODIFIED datetime NULL
           , HARISKCATEGORY_LASTMODIFIED datetime NULL
           , HAUSERRISKAREA_LASTMODIFIED datetime NULL
           , HAUSERQUESTION_LASTMODIFIED datetime NULL
           , HAQUESTIONSVIEW_LASTMODIFIED datetime NULL
           , HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED datetime NULL
           , HAUSERANSWERS_LASTMODIFIED datetime NULL
           , HAUSERSTARTED_LastUpdateID int NULL
           , CMSUSER_LastUpdateID int NULL
           , USERSETTINGS_LastUpdateID int NULL
           , USERSITE_LastUpdateID int NULL
           , CMSSITE_LastUpdateID datetime NULL
           , ACCT_LastUpdateID datetime NULL
           , HAUSERMODULE_LastUpdateID int NULL
           , VHCJ_LastUpdateID int NULL
           , VHAJ_LastUpdateID int NULL
           , HARISKCATEGORY_LastUpdateID int NULL
           , HAUSERRISKAREA_LastUpdateID int NULL
           , HAUSERQUESTION_LastUpdateID int NULL
           , HAQUESTIONSVIEW_LastUpdateID int NULL
           , HAUSERQUESTIONGROUPRESULTS_LastUpdateID int NULL
           , HAUSERANSWERS_LastUpdateID int NULL
           , LASTUPDATEID int NULL
           , DELETEFLG int NULL
           , SVR nvarchar (128) NULL
           , DBNAME nvarchar (128) NULL
           , DELETEDFLG int NULL
           , RowNbr int NULL
           , TimeZone nvarchar (10) NULL
           , ConvertedToCentralTime bit NULL
) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

SET ANSI_PADDING OFF;

GO

IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'PI_EDW_HealthAssessment_Dates') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_Dates ON dbo.DIM_EDW_HealthAssessment ( ItemCreatedWhen , ItemModifiedWhen , HARiskCategory_ItemModifiedWhen , HAUserRiskArea_ItemModifiedWhen , HAUserQuestion_ItemModifiedWhen , HAUserAnswers_ItemModifiedWhen) ON [PRIMARY];
    END;

GO
IF NOT EXISTS
( SELECT
         name
         FROM sys.indexes
         WHERE name = 'PI_EDW_HealthAssessment_NATKEY') 
    BEGIN
        PRINT 'Adding INDEX PI_EDW_HealthAssessment_NATKEY at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
        CREATE CLUSTERED INDEX PI_EDW_HealthAssessment_NATKEY ON dbo.DIM_EDW_HealthAssessment (
        UserStartedItemID
        , UserGUID
        , PKHashCode , HashCode , DeletedFlg) ;
    END;

GO

IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'PI_EDW_HealthAssessment_Dates') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_Dates ON dbo.DIM_EDW_HealthAssessment
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
    END;
GO
--ALTER TABLE dbo.DIM_EDW_HealthAssessment SET ( LOCK_ESCALATION = TABLE) ;

GO

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthAssessment';

PRINT 'Create Table [dbo].[TEMP_EDW_RewardUserLevel_DATA]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_EDW_RewardUserLevel_DATA') 

    BEGIN

        DROP TABLE
             TEMP_EDW_RewardUserLevel_DATA;
    END;
GO

CREATE TABLE dbo.TEMP_EDW_RewardUserLevel_DATA (
             UserId int NOT NULL
           , LevelCompletedDt datetime NOT NULL
           , LevelName nvarchar (100) NOT NULL
           , SiteName nvarchar (100) NOT NULL
           , nodeguid uniqueidentifier NOT NULL
           , SiteGuid uniqueidentifier NOT NULL
           , LevelHeader nvarchar (256) NULL
           , GroupHeadingText nvarchar (40) NULL
           , GroupHeadingDescription nvarchar (1024) NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX temp_PI_EDW_RewardUserLevel_IDs ON dbo.TEMP_EDW_RewardUserLevel_DATA ( UserId , LevelCompletedDt , LevelName , SiteName , nodeguid , SiteGuid) ON [PRIMARY];

GO

--ALTER TABLE dbo.TEMP_EDW_RewardUserLevel_DATA SET ( LOCK_ESCALATION = TABLE) ;

GO
-- Create Table [dbo].[DIM_EDW_HealthDefinition]

PRINT 'Create Table [dbo].[DIM_EDW_HealthDefinition]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_HealthDefinition') 

    BEGIN

        DROP TABLE
             DIM_EDW_HealthDefinition;
    END;

go

CREATE TABLE dbo.DIM_EDW_HealthDefinition (
             SiteGUID int NULL
           , AccountCD int NULL
           , HANodeID int NOT NULL
           , HANodeName nvarchar (100) NOT NULL
           , HADocumentID int NULL
           , HANodeSiteID int NOT NULL
           , HADocPubVerID int NULL
           , ModTitle varchar (max) NULL
           , IntroText varchar (max) NULL
           , ModDocGuid uniqueidentifier NOT NULL
           , ModWeight int NOT NULL
           , ModIsEnabled bit NOT NULL
           , ModCodeName nvarchar (100) NOT NULL
           , ModDocPubVerID int NULL
           , RCTitle varchar (max) NULL
           , RCWeight int NOT NULL
           , RCDocumentGUID uniqueidentifier NOT NULL
           , RCIsEnabled bit NOT NULL
           , RCCodeName nvarchar (100) NOT NULL
           , RCDocPubVerID int NULL
           , RATytle varchar (max) NULL
           , RAWeight int NOT NULL
           , RADocumentGuid uniqueidentifier NOT NULL
           , RAIsEnabled bit NOT NULL
           , RACodeName nvarchar (100) NOT NULL
           , RAScoringStrategyID int NOT NULL
           , RADocPubVerID int NULL
           , QuestionType nvarchar (100) NOT NULL
           , QuesTitle varchar (max) NULL
           , QuesWeight int NOT NULL
           , QuesIsRequired bit NOT NULL
           , QuesDocumentGuid uniqueidentifier NOT NULL
           , QuesIsEnabled bit NOT NULL
           , QuesIsVisible nvarchar (max) NULL
           , QuesIsSTaging bit NOT NULL
           , QuestionCodeName nvarchar (100) NOT NULL
           , QuesDocPubVerID int NULL
           , AnsValue nvarchar (150) NULL
           , AnsPoints int NULL
           , AnsDocumentGuid uniqueidentifier NULL
           , AnsIsEnabled bit NULL
           , AnsCodeName nvarchar (100) NULL
           , AnsUOM nvarchar (5) NULL
           , AnsDocPUbVerID int NULL
           , ChangeType varchar (1) NOT NULL
           , DocumentCreatedWhen datetime NULL
           , DocumentModifiedWhen datetime NULL
           , CmsTreeNodeGuid uniqueidentifier NOT NULL
           , HANodeGUID uniqueidentifier NOT NULL
           , SiteLastModified int NULL
           , Account_ItemModifiedWhen int NULL
           , Campaign_DocumentModifiedWhen int NULL
           , Assessment_DocumentModifiedWhen datetime NULL
           , Module_DocumentModifiedWhen datetime NULL
           , RiskCategory_DocumentModifiedWhen datetime NULL
           , RiskArea_DocumentModifiedWhen datetime NULL
           , Question_DocumentModifiedWhen datetime NULL
           , Answer_DocumentModifiedWhen datetime NULL
           , AllowMultiSelect bit NULL
           , LocID varchar (5) NOT NULL
           , HashCode nvarchar (75) NULL
           , CMS_Class_CtID int NULL
           , CMS_Class_SCV bigint NULL
           , CMS_Document_CtID int NULL
           , CMS_Document_SCV bigint NULL
           , CMS_Site_CtID int NULL
           , CMS_Site_SCV bigint NULL
           , CMS_Tree_CtID int NULL
           , CMS_Tree_SCV bigint NULL
           , CMS_User_CtID int NULL
           , CMS_User_SCV bigint NULL
           , COM_SKU_CtID int NULL
           , COM_SKU_SCV bigint NULL
           , HFit_HealthAssesmentMatrixQuestion_CtID int NULL
           , HFit_HealthAssesmentMatrixQuestion_SCV bigint NULL
           , HFit_HealthAssesmentModule_CtID int NULL
           , HFit_HealthAssesmentModule_SCV bigint NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_CtID int NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_SCV bigint NULL
           , HFit_HealthAssesmentRiskArea_CtID int NULL
           , HFit_HealthAssesmentRiskArea_SCV bigint NULL
           , HFit_HealthAssesmentRiskCategory_CtID int NULL
           , HFit_HealthAssesmentRiskCategory_SCV bigint NULL
           , HFit_HealthAssessment_CtID int NULL
           , HFit_HealthAssessment_SCV bigint NULL
           , HFit_HealthAssessmentFreeForm_CtID int NULL
           , HFit_HealthAssessmentFreeForm_SCV bigint NULL
           , CMS_Class_CHANGE_OPERATION nchar (1) NULL
           , CMS_Document_CHANGE_OPERATION nchar (1) NULL
           , CMS_Site_CHANGE_OPERATION nchar (1) NULL
           , CMS_Tree_CHANGE_OPERATION nchar (1) NULL
           , CMS_User_CHANGE_OPERATION nchar (1) NULL
           , COM_SKU_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentModule_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentRiskArea_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssessment_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssessmentFreeForm_CHANGE_OPERATION nchar (1) NULL
           , CHANGED_FLG int NULL
           , CHANGE_TYPE_CODE nchar (1) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

-- Create Table [dbo].[DIM_EDW_HealthInterestList]

PRINT 'Create Table [dbo].[DIM_EDW_HealthInterestList]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_HealthInterestList') 

    BEGIN

        DROP TABLE
             DIM_EDW_HealthInterestList;
    END;
GO

CREATE TABLE dbo.DIM_EDW_HealthInterestList (
             HealthAreaID int NOT NULL
           , NodeID int NOT NULL
           , NodeGuid uniqueidentifier NOT NULL
           , AccountCD nvarchar (8) NULL
           , HealthAreaName nvarchar (100) NOT NULL
           , HealthAreaDescription nvarchar (255) NULL
           , CodeName nvarchar (20) NULL
           , DocumentCreatedWhen datetime NULL
           , DocumentModifiedWhen datetime NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime2 (7) NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_HealthInterestList ON dbo.DIM_EDW_HealthInterestList ( HealthAreaID , NodeID , NodeGuid , AccountCD) ON [PRIMARY];

GO

CREATE NONCLUSTERED INDEX PI_EDW_HealthInterestList_RowNbrCDate ON dbo.DIM_EDW_HealthInterestList ( RowNbr , LastModifiedDate , DeletedFlg) ON [PRIMARY];
--ALTER TABLE dbo.DIM_EDW_HealthInterestList SET ( LOCK_ESCALATION = TABLE) ;

GO

PRINT 'Create Table [dbo].[TEMP_EDW_Coaches_DATA]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_EDW_Coaches_DATA') 

    BEGIN

        DROP TABLE
             TEMP_EDW_Coaches_DATA;
    END;
go

CREATE TABLE dbo.TEMP_EDW_Coaches_DATA (
             UserGUID uniqueidentifier NULL
           , SiteGUID uniqueidentifier NULL
           , AccountID int NULL
           , AccountCD nvarchar (8) NULL
           , CoachID int NOT NULL
           , LastName nvarchar (20) NOT NULL
           , FirstName nvarchar (20) NOT NULL
           , StartDate datetime NOT NULL
           , Phone nvarchar (15) NOT NULL
           , email nvarchar (50) NOT NULL
           , Supervisor int NOT NULL
           , SuperCoach bit NOT NULL
           , MaxParticipants int NOT NULL
           , Inactive bit NOT NULL
           , MaxRiskLevel nvarchar (10) NOT NULL
           , Locked bit NOT NULL
           , TimeLocked datetime NULL
           , terminated bit NOT NULL
           , APMaxParticipants int NULL
           , RNMaxParticipants int NULL
           , RNPMaxParticipants int NULL
           , Change_Type nvarchar (1) NULL
           , Last_Update_Dt datetime NULL
           , HashCode nvarchar (75) NULL) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX temp_PI_EDW_Coaches_IDs ON dbo.TEMP_EDW_Coaches_DATA ( UserGUID , SiteGUID , AccountID , AccountCD , CoachID , email) ON [PRIMARY];

GO

--ALTER TABLE dbo.TEMP_EDW_Coaches_DATA SET ( LOCK_ESCALATION = TABLE) ;

GO
-- Create Table [dbo].[DIM_EDW_Trackers]

PRINT 'Create Table [dbo].[DIM_EDW_Trackers]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_Trackers') 

    BEGIN

        DROP TABLE
             DIM_EDW_Trackers;
    END;

GO

CREATE TABLE dbo.DIM_EDW_Trackers (
             TrackerNameAggregateTable varchar (32) NOT NULL
           , ItemID int NOT NULL
           , EventDate datetime NOT NULL
           , IsProfessionallyCollected bit NOT NULL
           , TrackerCollectionSourceID int NOT NULL
           , Notes nvarchar (1000) NULL
           , UserID int NOT NULL
           , CollectionSourceName_Internal nvarchar (100) NULL
           , CollectionSourceName_External nvarchar (100) NULL
           , EventName varchar (7) NOT NULL
           , UOM varchar (10) NOT NULL
           , KEY1 varchar (18) NOT NULL
           , VAL1 float NULL
           , KEY2 varchar (13) NOT NULL
           , VAL2 float NULL
           , KEY3 varchar (12) NOT NULL
           , VAL3 float NULL
           , KEY4 varchar (9) NOT NULL
           , VAL4 float NULL
           , KEY5 varchar (12) NOT NULL
           , VAL5 float NULL
           , KEY6 varchar (11) NOT NULL
           , VAL6 float NULL
           , KEY7 varchar (10) NOT NULL
           , VAL7 float NULL
           , KEY8 varchar (3) NOT NULL
           , VAL8 float NULL
           , KEY9 varchar (2) NOT NULL
           , VAL9 int NULL
           , KEY10 varchar (2) NOT NULL
           , VAL10 int NULL
           , ItemCreatedBy int NULL
           , ItemCreatedWhen datetime NULL
           , ItemModifiedBy int NULL
           , ItemModifiedWhen datetime NULL
           , IsProcessedForHa bit NULL
           , TXTKEY1 varchar (10) NOT NULL
           , TXTVAL1 nvarchar (500) NULL
           , TXTKEY2 varchar (8) NOT NULL
           , TXTVAL2 nvarchar (255) NULL
           , TXTKEY3 varchar (2) NOT NULL
           , TXTVAL3 int NULL
           , ItemOrder int NULL
           , ItemGuid uniqueidentifier NULL
           , UserGuid uniqueidentifier NOT NULL
           , MPI varchar (50) NOT NULL
           , ClientCode varchar (12) NULL
           , SiteGUID uniqueidentifier NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , IsAvailable bit NULL
           , IsCustom bit NULL
           , UniqueName nvarchar (50) NULL
           , ColDesc nvarchar (50) NULL
           , VendorID int NULL
           , VendorName nvarchar (32) NULL
           , CT_ItemID int NULL
           , CT_ChangeVersion bigint NULL
           , CMS_Operation nchar (1) NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10) 
           , ItemLastUpdated datetime NULL
) 
ON [PRIMARY];

GO

CREATE NONCLUSTERED INDEX PI_EDW_Tracker_Dates ON dbo.DIM_EDW_Trackers ( TrackerNameAggregateTable , ItemID , ItemModifiedWhen) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_Trackers SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[DIM_EDW_RewardAwardDetail]

PRINT 'Create Table [dbo].[DIM_EDW_RewardAwardDetail]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_RewardAwardDetail') 

    BEGIN

        DROP TABLE
             DIM_EDW_RewardAwardDetail;
    END;
go

CREATE TABLE dbo.DIM_EDW_RewardAwardDetail (
             UserGUID uniqueidentifier NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , HFitUserMpiNumber bigint NULL
           , RewardLevelGUID uniqueidentifier NOT NULL
           , AwardType int NOT NULL
           , AwardDisplayName nvarchar (100) NOT NULL
           , RewardValue float NULL
           , ThresholdNumber int NOT NULL
           , UserNotified bit NOT NULL
           , IsFulfilled bit NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , ChangeType varchar (1) NOT NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO


CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.DIM_EDW_RewardAwardDetail ( UserGUID , SiteGUID , HFitUserMpiNumber , RewardLevelGUID , AwardType , AwardDisplayName , RewardValue , ThresholdNumber , UserNotified , IsFulfilled , AccountID , AccountCD) ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_RewardAwardDetail_IDs ON dbo.DIM_EDW_RewardAwardDetail ( UserGUID , SiteGUID , HFitUserMpiNumber , RewardLevelGUID , AwardType , AwardDisplayName , RewardValue , ThresholdNumber , UserNotified , IsFulfilled , AccountID , AccountCD) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_RewardAwardDetail SET ( LOCK_ESCALATION = TABLE) ;

GO
-- Create Table [dbo].[DIM_EDW_HealthInterestDetail]

PRINT 'Create Table [dbo].[DIM_EDW_HealthInterestDetail]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_HealthInterestDetail') 

    BEGIN

        DROP TABLE
             DIM_EDW_HealthInterestDetail;
    END;
GO

CREATE TABLE dbo.DIM_EDW_HealthInterestDetail (
             UserID int NULL
           , UserGUID uniqueidentifier NULL
           , HFitUserMpiNumber bigint NULL
           , SiteGUID uniqueidentifier NULL
           , CoachingHealthInterestID int NULL
           , FirstHealthAreaID int NULL
           , FirstNodeID int NULL
           , FirstNodeGuid uniqueidentifier NULL
           , FirstHealthAreaName nvarchar (100) NULL
           , FirstHealthAreaDescription nvarchar (255) NULL
           , FirstCodeName nvarchar (20) NULL
           , SecondHealthAreaID int NULL
           , SecondNodeID int NULL
           , SecondNodeGuid uniqueidentifier NULL
           , SecondHealthAreaName nvarchar (100) NULL
           , SecondHealthAreaDescription nvarchar (255) NULL
           , SecondCodeName nvarchar (20) NULL
           , ThirdHealthAreaID int NULL
           , ThirdNodeID int NULL
           , ThirdNodeGuid uniqueidentifier NULL
           , ThirdHealthAreaName nvarchar (100) NULL
           , ThirdHealthAreaDescription nvarchar (255) NULL
           , ThirdCodeName nvarchar (20) NULL
           , ItemCreatedWhen datetime NULL
           , ItemModifiedWhen datetime NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime2 (7) NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10) NULL) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_HealthInterestDetail ON dbo.DIM_EDW_HealthInterestDetail ( UserID , UserGUID , HFitUserMpiNumber , SiteGUID , CoachingHealthInterestID , FirstNodeID , SecondNodeGuid , ThirdNodeGuid) ON [PRIMARY];

GO
CREATE NONCLUSTERED INDEX PI_EDW_HealthInterestDetail_RowNbrCDate ON dbo.DIM_EDW_HealthInterestDetail ( LastModifiedDate , DeletedFlg) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_HealthInterestDetail SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[DIM_EDW_HealthAssesmentClientView]

PRINT 'Create Table [dbo].[DIM_EDW_HealthAssesmentClientView]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_HealthAssesmentClientView') 

    BEGIN

        DROP TABLE
             DIM_EDW_HealthAssesmentClientView;
    END;

GO

CREATE TABLE dbo.DIM_EDW_HealthAssesmentClientView (
             AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , AccountName nvarchar (200) NULL
           , ClientGuid uniqueidentifier NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , CompanyID int NULL
           , CompanyGUID int NULL
           , CompanyName int NULL
           , DocumentName nvarchar (100) NOT NULL
           , HAStartDate datetime NULL
           , HAEndDate datetime NULL
           , NodeSiteID int NOT NULL
           , Title nvarchar (150) NOT NULL
           , CodeName nvarchar (100) NOT NULL
           , IsEnabled bit NOT NULL
           , ChangeType varchar (1) NOT NULL
           , DocumentCreatedWhen datetime NULL
           , DocumentModifiedWhen datetime NULL
           , AssesmentModule_DocumentModifiedWhen datetime NULL
           , DocumentCulture_HAAssessmentMod nvarchar (10) NOT NULL
           , DocumentCulture_HACampaign nvarchar (10) NOT NULL
           , DocumentCulture_HAJoined nvarchar (10) NOT NULL
           , BiometricCampaignStartDate datetime NULL
           , BiometricCampaignEndDate datetime NULL
           , CampaignStartDate datetime NOT NULL
           , CampaignEndDate datetime NOT NULL
           , Name nvarchar (200) NOT NULL
           , CampaignNodeGuid uniqueidentifier NOT NULL
           , HACampaignID int NOT NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime2 (7) NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_HealthAssesmentClientView ON dbo.DIM_EDW_HealthAssesmentClientView ( AccountID , AccountCD , AccountName , ClientGuid , SiteGUID , NodeSiteID , CampaignNodeGuid , HACampaignID , CodeName) ON [PRIMARY];

GO
CREATE NONCLUSTERED INDEX PI_EDW_HealthAssesmentClientView_RowNbrCDate ON dbo.DIM_EDW_HealthAssesmentClientView ( RowNbr , LastModifiedDate , DeletedFlg) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_HealthAssesmentClientView SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[DIM_EDW_CoachingDetail]

PRINT 'Create Table [dbo].[DIM_EDW_CoachingDetail]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_CoachingDetail') 

    BEGIN

        DROP TABLE
             DIM_EDW_CoachingDetail;
    END;

GO

CREATE TABLE dbo.DIM_EDW_CoachingDetail (
             ItemID int NOT NULL
           , ItemGUID uniqueidentifier NOT NULL
           , GoalID int NOT NULL
           , UserID int NOT NULL
           , UserGUID uniqueidentifier NOT NULL
           , HFitUserMpiNumber bigint NULL
           , SiteGUID uniqueidentifier NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , AccountName nvarchar (200) NULL
           , IsCreatedByCoach bit NOT NULL
           , BaselineAmount float NOT NULL
           , GoalAmount float NOT NULL
           , DocumentID int NULL
           , GoalStatusLKPID int NOT NULL
           , GoalStatusLKPName nvarchar (100) NOT NULL
           , EvaluationStartDate datetime NULL
           , EvaluationEndDate datetime NULL
           , GoalStartDate datetime NOT NULL
           , CoachDescription nvarchar (500) NULL
           , EvaluationDate datetime NULL
           , Passed bit NULL
           , WeekendDate datetime NULL
           , ChangeType varchar (1) NOT NULL
           , ItemCreatedWhen datetime NULL
           , ItemModifiedWhen datetime NULL
           , NodeGUID uniqueidentifier NOT NULL
           , CloseReasonLKPID int NOT NULL
           , CloseReason varchar (250) NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_CoachingDetail_IDs ON dbo.DIM_EDW_CoachingDetail ( ItemID , ItemGUID , GoalID , UserID , UserGUID , HFitUserMpiNumber , SiteGUID , AccountID , AccountCD , WeekendDate) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_CoachingDetail SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[DIM_EDW_RewardUserDetail]

PRINT 'Create Table [dbo].[DIM_EDW_RewardUserDetail]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_RewardUserDetail') 

    BEGIN

        DROP TABLE
             DIM_EDW_RewardUserDetail;
    END;

CREATE TABLE dbo.DIM_EDW_RewardUserDetail (
             UserGUID uniqueidentifier NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , HFitUserMpiNumber bigint NULL
           , RewardActivityGUID uniqueidentifier NULL
           , RewardProgramName nvarchar (100) NOT NULL
           , RewardModifiedDate datetime NULL
           , RewardGroupGUID uniqueidentifier NULL
           , RewardLevelModifiedDate datetime NULL
           , LevelCompletedDt datetime NOT NULL
           , ActivityPointsEarned int NOT NULL
           , ActivityCompletedDt datetime NOT NULL
           , RewardActivityModifiedDate datetime NULL
           , ActivityPoints float NULL
           , UserAccepted int NULL
           , UserExceptionAppliedTo int NULL
           , RewardTriggerGUID uniqueidentifier NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , ChangeType varchar (1) NOT NULL
           , HashCode nvarchar (75) NULL
           , DeletedFlg int NULL
           , LastModifiedDate datetime2 (7) NULL
           , RowNbr int NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10) 
           , RewardExceptionModifiedDate datetime NULL) ;

GO

CREATE CLUSTERED INDEX PI_EDW_RewardUserDetail ON dbo.DIM_EDW_RewardUserDetail ( UserGUID , AccountID , AccountCD , SiteGUID , HFitUserMpiNumber , RewardActivityGUID , RewardTriggerGUID) ON [PRIMARY];

GO

CREATE NONCLUSTERED INDEX PI_EDW_RewardUserDetail_RowNbrCDate ON dbo.DIM_EDW_RewardUserDetail ( RowNbr , LastModifiedDate , DeletedFlg) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_RewardUserDetail SET ( LOCK_ESCALATION = TABLE) ;

GO
-- Create Table [dbo].[DIM_EDW_Coaches]

PRINT 'Create Table [dbo].[DIM_EDW_Coaches]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_Coaches') 

    BEGIN

        DROP TABLE
             DIM_EDW_Coaches;
    END;
GO

CREATE TABLE dbo.DIM_EDW_Coaches (
             UserGUID uniqueidentifier NULL
           , SiteGUID uniqueidentifier NULL
           , AccountID int NULL
           , AccountCD nvarchar (8) NULL
           , CoachID int NOT NULL
           , LastName nvarchar (20) NOT NULL
           , FirstName nvarchar (20) NOT NULL
           , StartDate datetime NOT NULL
           , Phone nvarchar (15) NOT NULL
           , email nvarchar (50) NOT NULL
           , Supervisor int NOT NULL
           , SuperCoach bit NOT NULL
           , MaxParticipants int NOT NULL
           , Inactive bit NOT NULL
           , MaxRiskLevel nvarchar (10) NOT NULL
           , Locked bit NOT NULL
           , TimeLocked datetime NULL
           , terminated bit NOT NULL
           , APMaxParticipants int NULL
           , RNMaxParticipants int NULL
           , RNPMaxParticipants int NULL
           , Change_Type nvarchar (1) NULL
           , Last_Update_Dt datetime NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO
CREATE CLUSTERED INDEX PI_EDW_Coaches_IDs ON dbo.DIM_EDW_Coaches ( UserGUID , SiteGUID , AccountID , AccountCD , CoachID , email) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_Coaches SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[DIM_EDW_RewardTriggerParameters]

PRINT 'Create Table [dbo].[DIM_EDW_RewardTriggerParameters]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_RewardTriggerParameters') 

    BEGIN

        DROP TABLE
             DIM_EDW_RewardTriggerParameters;
    END;
GO

CREATE TABLE dbo.DIM_EDW_RewardTriggerParameters (
             SiteGUID uniqueidentifier NOT NULL
           , RewardTriggerID int NOT NULL
           , TriggerName nvarchar (100) NOT NULL
           , RewardTriggerParameterOperatorLKPDisplayName nvarchar (255) NOT NULL
           , ParameterDisplayName nvarchar (250) NOT NULL
           , RewardTriggerParameterOperator int NOT NULL
           , [Value] float NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , ChangeType varchar (1) NOT NULL
           , DocumentGuid uniqueidentifier NULL
           , NodeGuid uniqueidentifier NOT NULL
           , DocumentCreatedWhen datetime NULL
           , DocumentModifiedWhen datetime NULL
           , RewardTriggerParameter_DocumentModifiedWhen datetime NULL
           , documentculture_VHFRTPJ nvarchar (10) NOT NULL
           , documentculture_VHFRTJ nvarchar (10) NOT NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_RewardTriggerParameters_IDs ON dbo.DIM_EDW_RewardTriggerParameters ( SiteGUID , RewardTriggerID , ParameterDisplayName , RewardTriggerParameterOperator , [Value] , AccountID , AccountCD , DocumentGuid , NodeGuid) ON [PRIMARY];

GO
--ALTER TABLE dbo.DIM_EDW_RewardTriggerParameters SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[TEMP_EDW_RewardTriggerParameters_DATA]

PRINT 'Create Table [dbo].[TEMP_EDW_RewardTriggerParameters_DATA]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_EDW_RewardTriggerParameters_DATA') 

    BEGIN

        DROP TABLE
             TEMP_EDW_RewardTriggerParameters_DATA;
    END;

GO

CREATE TABLE dbo.TEMP_EDW_RewardTriggerParameters_DATA (
             SiteGUID uniqueidentifier NOT NULL
           , RewardTriggerID int NOT NULL
           , TriggerName nvarchar (100) NOT NULL
           , RewardTriggerParameterOperatorLKPDisplayName nvarchar (255) NOT NULL
           , ParameterDisplayName nvarchar (250) NOT NULL
           , RewardTriggerParameterOperator int NOT NULL
           , [Value] float NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , ChangeType varchar (1) NOT NULL
           , DocumentGuid uniqueidentifier NULL
           , NodeGuid uniqueidentifier NOT NULL
           , DocumentCreatedWhen datetime NULL
           , DocumentModifiedWhen datetime NULL
           , RewardTriggerParameter_DocumentModifiedWhen datetime NULL
           , documentculture_VHFRTPJ nvarchar (10) NOT NULL
           , documentculture_VHFRTJ nvarchar (10) NOT NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.TEMP_EDW_RewardTriggerParameters_DATA ( SiteGUID , RewardTriggerID , ParameterDisplayName , RewardTriggerParameterOperator , [Value] , AccountID , AccountCD , DocumentGuid , NodeGuid) ON [PRIMARY];

GO

--ALTER TABLE dbo.TEMP_EDW_RewardTriggerParameters_DATA SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[TEMP_EDW_CoachingDetail_DATA]

PRINT 'Create Table [dbo].[TEMP_EDW_CoachingDetail_DATA]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_EDW_CoachingDetail_DATA') 

    BEGIN

        DROP TABLE
             TEMP_EDW_CoachingDetail_DATA;
    END;
GO

CREATE TABLE dbo.TEMP_EDW_CoachingDetail_DATA (
             ItemID int NOT NULL
           , ItemGUID uniqueidentifier NOT NULL
           , GoalID int NOT NULL
           , UserID int NOT NULL
           , UserGUID uniqueidentifier NOT NULL
           , HFitUserMpiNumber bigint NULL
           , SiteGUID uniqueidentifier NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , AccountName nvarchar (200) NULL
           , IsCreatedByCoach bit NOT NULL
           , BaselineAmount float NOT NULL
           , GoalAmount float NOT NULL
           , DocumentID int NULL
           , GoalStatusLKPID int NOT NULL
           , GoalStatusLKPName nvarchar (100) NOT NULL
           , EvaluationStartDate datetime NULL
           , EvaluationEndDate datetime NULL
           , GoalStartDate datetime NOT NULL
           , CoachDescription nvarchar (500) NULL
           , EvaluationDate datetime NULL
           , Passed bit NULL
           , WeekendDate datetime NULL
           , ChangeType varchar (1) NOT NULL
           , ItemCreatedWhen datetime NULL
           , ItemModifiedWhen datetime NULL
           , NodeGUID uniqueidentifier NOT NULL
           , CloseReasonLKPID int NOT NULL
           , CloseReason varchar (250) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX temp_PI_EDW_CoachingDetail_IDs ON dbo.TEMP_EDW_CoachingDetail_DATA ( ItemID , ItemGUID , GoalID , UserID , UserGUID , HFitUserMpiNumber , SiteGUID , AccountID , AccountCD , WeekendDate) ON [PRIMARY];

GO

--ALTER TABLE dbo.TEMP_EDW_CoachingDetail_DATA SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[TEMP_EDW_HealthDefinition_DATA]

PRINT 'Create Table [dbo].[TEMP_EDW_HealthDefinition_DATA]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_EDW_HealthDefinition_DATA') 

    BEGIN

        DROP TABLE
             TEMP_EDW_HealthDefinition_DATA;
    END;
GO

CREATE TABLE dbo.TEMP_EDW_HealthDefinition_DATA (
             SiteGUID int NULL
           , AccountCD int NULL
           , HANodeID int NOT NULL
           , HANodeName nvarchar (100) NOT NULL
           , HADocumentID int NULL
           , HANodeSiteID int NOT NULL
           , HADocPubVerID int NULL
           , ModTitle varchar (max) NULL
           , IntroText varchar (max) NULL
           , ModDocGuid uniqueidentifier NOT NULL
           , ModWeight int NOT NULL
           , ModIsEnabled bit NOT NULL
           , ModCodeName nvarchar (100) NOT NULL
           , ModDocPubVerID int NULL
           , RCTitle varchar (max) NULL
           , RCWeight int NOT NULL
           , RCDocumentGUID uniqueidentifier NOT NULL
           , RCIsEnabled bit NOT NULL
           , RCCodeName nvarchar (100) NOT NULL
           , RCDocPubVerID int NULL
           , RATytle varchar (max) NULL
           , RAWeight int NOT NULL
           , RADocumentGuid uniqueidentifier NOT NULL
           , RAIsEnabled bit NOT NULL
           , RACodeName nvarchar (100) NOT NULL
           , RAScoringStrategyID int NOT NULL
           , RADocPubVerID int NULL
           , QuestionType nvarchar (100) NOT NULL
           , QuesTitle varchar (max) NULL
           , QuesWeight int NOT NULL
           , QuesIsRequired bit NOT NULL
           , QuesDocumentGuid uniqueidentifier NOT NULL
           , QuesIsEnabled bit NOT NULL
           , QuesIsVisible nvarchar (max) NULL
           , QuesIsSTaging bit NOT NULL
           , QuestionCodeName nvarchar (100) NOT NULL
           , QuesDocPubVerID int NULL
           , AnsValue nvarchar (150) NULL
           , AnsPoints int NULL
           , AnsDocumentGuid uniqueidentifier NULL
           , AnsIsEnabled bit NULL
           , AnsCodeName nvarchar (100) NULL
           , AnsUOM nvarchar (5) NULL
           , AnsDocPUbVerID int NULL
           , ChangeType varchar (1) NOT NULL
           , DocumentCreatedWhen datetime NULL
           , DocumentModifiedWhen datetime NULL
           , CmsTreeNodeGuid uniqueidentifier NOT NULL
           , HANodeGUID uniqueidentifier NOT NULL
           , SiteLastModified int NULL
           , Account_ItemModifiedWhen int NULL
           , Campaign_DocumentModifiedWhen int NULL
           , Assessment_DocumentModifiedWhen datetime NULL
           , Module_DocumentModifiedWhen datetime NULL
           , RiskCategory_DocumentModifiedWhen datetime NULL
           , RiskArea_DocumentModifiedWhen datetime NULL
           , Question_DocumentModifiedWhen datetime NULL
           , Answer_DocumentModifiedWhen datetime NULL
           , AllowMultiSelect bit NULL
           , LocID varchar (5) NOT NULL
           , HashCode nvarchar (75) NULL
           , CMS_Class_CtID int NULL
           , CMS_Class_SCV bigint NULL
           , CMS_Document_CtID int NULL
           , CMS_Document_SCV bigint NULL
           , CMS_Site_CtID int NULL
           , CMS_Site_SCV bigint NULL
           , CMS_Tree_CtID int NULL
           , CMS_Tree_SCV bigint NULL
           , CMS_User_CtID int NULL
           , CMS_User_SCV bigint NULL
           , COM_SKU_CtID int NULL
           , COM_SKU_SCV bigint NULL
           , HFit_HealthAssesmentMatrixQuestion_CtID int NULL
           , HFit_HealthAssesmentMatrixQuestion_SCV bigint NULL
           , HFit_HealthAssesmentModule_CtID int NULL
           , HFit_HealthAssesmentModule_SCV bigint NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_CtID int NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_SCV bigint NULL
           , HFit_HealthAssesmentRiskArea_CtID int NULL
           , HFit_HealthAssesmentRiskArea_SCV bigint NULL
           , HFit_HealthAssesmentRiskCategory_CtID int NULL
           , HFit_HealthAssesmentRiskCategory_SCV bigint NULL
           , HFit_HealthAssessment_CtID int NULL
           , HFit_HealthAssessment_SCV bigint NULL
           , HFit_HealthAssessmentFreeForm_CtID int NULL
           , HFit_HealthAssessmentFreeForm_SCV bigint NULL
           , CMS_Class_CHANGE_OPERATION nchar (1) NULL
           , CMS_Document_CHANGE_OPERATION nchar (1) NULL
           , CMS_Site_CHANGE_OPERATION nchar (1) NULL
           , CMS_Tree_CHANGE_OPERATION nchar (1) NULL
           , CMS_User_CHANGE_OPERATION nchar (1) NULL
           , COM_SKU_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentModule_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentRiskArea_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssessment_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssessmentFreeForm_CHANGE_OPERATION nchar (1) NULL
           , CHANGED_FLG int NULL
           , CHANGE_TYPE_CODE nchar (1) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.TEMP_EDW_HealthDefinition_DATA ( RCDocumentGUID , RADocumentGuid , RACodeName , QuesDocumentGuid , AnsDocumentGuid , HANodeSiteID) ON [PRIMARY];

GO

--ALTER TABLE dbo.TEMP_EDW_HealthDefinition_DATA SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[TEMP_EDW_Tracker_DATA]

PRINT 'Create Table [dbo].[TEMP_EDW_Tracker_DATA]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_EDW_Tracker_DATA') 

    BEGIN

        DROP TABLE
             TEMP_EDW_Tracker_DATA;
    END;
GO

CREATE TABLE dbo.TEMP_EDW_Tracker_DATA (
             TrackerNameAggregateTable varchar (32) NOT NULL
           , ItemID int NOT NULL
           , EventDate datetime NOT NULL
           , IsProfessionallyCollected bit NOT NULL
           , TrackerCollectionSourceID int NOT NULL
           , Notes nvarchar (1000) NULL
           , UserID int NOT NULL
           , CollectionSourceName_Internal nvarchar (100) NULL
           , CollectionSourceName_External nvarchar (100) NULL
           , EventName varchar (7) NOT NULL
           , UOM varchar (10) NOT NULL
           , KEY1 varchar (18) NOT NULL
           , VAL1 float NULL
           , KEY2 varchar (13) NOT NULL
           , VAL2 float NULL
           , KEY3 varchar (12) NOT NULL
           , VAL3 float NULL
           , KEY4 varchar (9) NOT NULL
           , VAL4 float NULL
           , KEY5 varchar (12) NOT NULL
           , VAL5 float NULL
           , KEY6 varchar (11) NOT NULL
           , VAL6 float NULL
           , KEY7 varchar (10) NOT NULL
           , VAL7 float NULL
           , KEY8 varchar (3) NOT NULL
           , VAL8 float NULL
           , KEY9 varchar (2) NOT NULL
           , VAL9 int NULL
           , KEY10 varchar (2) NOT NULL
           , VAL10 int NULL
           , ItemCreatedBy int NULL
           , ItemCreatedWhen datetime NULL
           , ItemModifiedBy int NULL
           , ItemModifiedWhen datetime NULL
           , IsProcessedForHa bit NULL
           , TXTKEY1 varchar (10) NOT NULL
           , TXTVAL1 nvarchar (500) NULL
           , TXTKEY2 varchar (8) NOT NULL
           , TXTVAL2 nvarchar (255) NULL
           , TXTKEY3 varchar (2) NOT NULL
           , TXTVAL3 int NULL
           , ItemOrder int NULL
           , ItemGuid uniqueidentifier NULL
           , UserGuid uniqueidentifier NOT NULL
           , MPI varchar (50) NOT NULL
           , ClientCode varchar (12) NULL
           , SiteGUID uniqueidentifier NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , IsAvailable bit NULL
           , IsCustom bit NULL
           , UniqueName nvarchar (50) NULL
           , ColDesc nvarchar (50) NULL
           , VendorID int NULL
           , VendorName nvarchar (32) NULL
           , CT_ItemID int NULL
           , CT_ChangeVersion bigint NULL
           , CMS_Operation nchar (1) NULL
           , DeleteFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10) 
           , ItemLastUpdated datetime NULL) 
ON [PRIMARY];

GO

ALTER TABLE dbo.TEMP_EDW_Tracker_DATA
ADD
            CONSTRAINT DF__TEMP_Stag__ItemL__251061DB DEFAULT GETDATE () FOR ItemLastUpdated;

GO

CREATE CLUSTERED INDEX temp_PI_EDW_Tracker_IDs ON dbo.TEMP_EDW_Tracker_DATA ( TrackerNameAggregateTable , ItemID , ItemModifiedWhen) ON [PRIMARY];

GO

--ALTER TABLE dbo.TEMP_EDW_Tracker_DATA SET ( LOCK_ESCALATION = TABLE) ;

GO
-- Create Table [dbo].[DIM_EDW_HealthAssessmentDefinition]

PRINT 'Create Table [dbo].[DIM_EDW_HealthAssessmentDefinition]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_HealthAssessmentDefinition') 

    BEGIN

        DROP TABLE
             DIM_EDW_HealthAssessmentDefinition;
    END;
GO

CREATE TABLE dbo.DIM_EDW_HealthAssessmentDefinition (
             SiteGUID int NULL
           , AccountCD int NULL
           , HANodeID int NOT NULL
           , HANodeName nvarchar (100) NOT NULL
           , HADocumentID int NULL
           , HANodeSiteID int NOT NULL
           , HADocPubVerID int NULL
           , ModTitle varchar (max) NULL
           , IntroText varchar (max) NULL
           , ModDocGuid uniqueidentifier NOT NULL
           , ModWeight int NOT NULL
           , ModIsEnabled bit NOT NULL
           , ModCodeName nvarchar (100) NOT NULL
           , ModDocPubVerID int NULL
           , RCTitle varchar (max) NULL
           , RCWeight int NOT NULL
           , RCDocumentGUID uniqueidentifier NOT NULL
           , RCIsEnabled bit NOT NULL
           , RCCodeName nvarchar (100) NOT NULL
           , RCDocPubVerID int NULL
           , RATytle varchar (max) NULL
           , RAWeight int NOT NULL
           , RADocumentGuid uniqueidentifier NOT NULL
           , RAIsEnabled bit NOT NULL
           , RACodeName nvarchar (100) NOT NULL
           , RAScoringStrategyID int NOT NULL
           , RADocPubVerID int NULL
           , QuestionType nvarchar (100) NOT NULL
           , QuesTitle varchar (max) NULL
           , QuesWeight int NOT NULL
           , QuesIsRequired bit NOT NULL
           , QuesDocumentGuid uniqueidentifier NOT NULL
           , QuesIsEnabled bit NOT NULL
           , QuesIsVisible nvarchar (max) NULL
           , QuesIsSTaging bit NOT NULL
           , QuestionCodeName nvarchar (100) NOT NULL
           , QuesDocPubVerID int NULL
           , AnsValue nvarchar (150) NULL
           , AnsPoints int NULL
           , AnsDocumentGuid uniqueidentifier NULL
           , AnsIsEnabled bit NULL
           , AnsCodeName nvarchar (100) NULL
           , AnsUOM nvarchar (5) NULL
           , AnsDocPUbVerID int NULL
           , ChangeType varchar (1) NOT NULL
           , DocumentCreatedWhen datetime NULL
           , DocumentModifiedWhen datetime NULL
           , CmsTreeNodeGuid uniqueidentifier NOT NULL
           , HANodeGUID uniqueidentifier NOT NULL
           , SiteLastModified int NULL
           , Account_ItemModifiedWhen int NULL
           , Campaign_DocumentModifiedWhen int NULL
           , Assessment_DocumentModifiedWhen datetime NULL
           , Module_DocumentModifiedWhen datetime NULL
           , RiskCategory_DocumentModifiedWhen datetime NULL
           , RiskArea_DocumentModifiedWhen datetime NULL
           , Question_DocumentModifiedWhen datetime NULL
           , Answer_DocumentModifiedWhen datetime NULL
           , AllowMultiSelect bit NULL
           , LocID varchar (5) NOT NULL
           , CMS_Class_CtID int NULL
           , CMS_Class_SCV bigint NULL
           , CMS_Document_CtID int NULL
           , CMS_Document_SCV bigint NULL
           , CMS_Site_CtID int NULL
           , CMS_Site_SCV bigint NULL
           , CMS_Tree_CtID int NULL
           , CMS_Tree_SCV bigint NULL
           , CMS_User_CtID int NULL
           , CMS_User_SCV bigint NULL
           , COM_SKU_CtID int NULL
           , COM_SKU_SCV bigint NULL
           , HFit_HealthAssesmentMatrixQuestion_CtID int NULL
           , HFit_HealthAssesmentMatrixQuestion_SCV bigint NULL
           , HFit_HealthAssesmentModule_CtID int NULL
           , HFit_HealthAssesmentModule_SCV bigint NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_CtID int NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_SCV bigint NULL
           , HFit_HealthAssesmentRiskArea_CtID int NULL
           , HFit_HealthAssesmentRiskArea_SCV bigint NULL
           , HFit_HealthAssesmentRiskCategory_CtID int NULL
           , HFit_HealthAssesmentRiskCategory_SCV bigint NULL
           , HFit_HealthAssessment_CtID int NULL
           , HFit_HealthAssessment_SCV bigint NULL
           , HFit_HealthAssessmentFreeForm_CtID int NULL
           , HFit_HealthAssessmentFreeForm_SCV bigint NULL
           , CMS_Class_CHANGE_OPERATION nchar (1) NULL
           , CMS_Document_CHANGE_OPERATION nchar (1) NULL
           , CMS_Site_CHANGE_OPERATION nchar (1) NULL
           , CMS_Tree_CHANGE_OPERATION nchar (1) NULL
           , CMS_User_CHANGE_OPERATION nchar (1) NULL
           , COM_SKU_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentModule_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentRiskArea_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssessment_CHANGE_OPERATION nchar (1) NULL
           , HFit_HealthAssessmentFreeForm_CHANGE_OPERATION nchar (1) NULL
           , CHANGED_FLG int NULL
           , CHANGE_TYPE_CODE nchar (1) NULL) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_HealthAssessmentDefinition SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[DIM_EDW_SmallSteps]

PRINT 'Create Table [dbo].[DIM_EDW_SmallSteps]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_SmallSteps') 

    BEGIN

        DROP TABLE
             dbo.DIM_EDW_SmallSteps;
    END;

GO

SET ANSI_NULLS ON;

GO

SET QUOTED_IDENTIFIER ON;

GO

SET ANSI_PADDING ON;

GO

CREATE TABLE dbo.DIM_EDW_SmallSteps (
             UserID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , SiteGUID uniqueidentifier NOT NULL
           , SSItemID int NOT NULL
           , SSItemCreatedBy int NULL
           , SSItemCreatedWhen datetime NULL
           , SSItemModifiedBy int NULL
           , SSItemModifiedWhen datetime NULL
           , SSItemOrder int NULL
           , SSItemGUID uniqueidentifier NOT NULL
           , SSHealthAssesmentUserStartedItemID int NOT NULL
           , SSOutcomeMessageGuid uniqueidentifier NOT NULL
           , SSOutcomeMessage nvarchar (max) NULL
           , HACampaignNodeGUID uniqueidentifier NOT NULL
           , HACampaignName nvarchar (200) NOT NULL
           , HACampaignStartDate datetime NOT NULL
           , HACampaignEndDate datetime NOT NULL
           , HAStartedDate datetime NOT NULL
           , HACompletedDate datetime NULL
           , HAStartedMode int NOT NULL
           , HACompletedMode int NOT NULL
           , HaCodeName nvarchar (100) NULL
           , HFitUserMPINumber bigint NULL
           , HashCode nvarchar (75) NULL
           , ChangeType nchar (1) NULL
           , CT_UserSettingsID int NULL
           , CT_UserSettings_CHANGE_OPERATION nchar (1) NULL
           , CT_CMS_UserSettings_SCV bigint NULL
           , SiteID_CtID int NULL
           , SiteID_CHANGE_OPERATION nchar (1) NULL
           , SITE_SCV bigint NULL
           , Campaign_CtID int NULL
           , Campaign_CHANGE_OPERATION nchar (1) NULL
           , Campaign_SCV bigint NULL
           , HealthAssesmentUserStarted_CtID int NULL
           , HealthAssesmentUserStarted_CHANGE_OPERATION nchar (1) NULL
           , HealthAssesmentUserStarted_SCV bigint NULL
           , OutComeMessages_CtID int NULL
           , OutComeMessages_CHANGE_OPERATION nchar (1) NULL
           , OutComeMessages_SCV bigint NULL
           , HFit_Account_CtID int NULL
           , HFit_Account_CHANGE_OPERATION nchar (1) NULL
           , HFit_Account_SCV bigint NULL
           , ToDoSmallSteps_CtID int NULL
           , ToDoSmallSteps_CHANGE_OPERATION nchar (1) NULL
           , ToDoSmallSteps_SCV bigint NULL
           , LastModifiedDate datetime2 (7) NULL
           , RowNbr uniqueidentifier NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_SmallSteps ON dbo.DIM_EDW_SmallSteps ( AccountCD , SiteGUID , SSItemID , SSItemGUID , SSHealthAssesmentUserStartedItemID , SSOutcomeMessageGuid , HFitUserMPINumber , HACampaignNodeGUID , HAStartedMode , HACompletedMode , HaCodeName , HACampaignStartDate , HACampaignEndDate) ON [PRIMARY];

GO

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'PI_BASE_Hfit_SmallStepResponses') 
AND EXISTS (SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'BASE_Hfit_SmallStepResponses') 
    BEGIN

        CREATE NONCLUSTERED INDEX PI_BASE_Hfit_SmallStepResponses
        ON dbo.BASE_Hfit_SmallStepResponses ( UserID , HealthAssesmentUserStartedItemID) 
        INCLUDE ( ItemID , OutComeMessageGUID , ItemCreatedBy , ItemCreatedWhen , ItemModifiedBy , ItemModifiedWhen , ItemOrder , ItemGUID) ;
    END;
GO

CREATE NONCLUSTERED INDEX PI_EDW_SmallSteps_RowNbrCDate ON dbo.DIM_EDW_SmallSteps ( RowNbr , LastModifiedDate , DeletedFlg) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_SmallSteps SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[TEMP_EDW_RewardAwardDetail_DATA]

PRINT 'Create Table [dbo].[TEMP_EDW_RewardAwardDetail_DATA]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_EDW_RewardAwardDetail_DATA') 

    BEGIN

        DROP TABLE
             TEMP_EDW_RewardAwardDetail_DATA;
    END;
GO

CREATE TABLE dbo.TEMP_EDW_RewardAwardDetail_DATA (
             UserGUID uniqueidentifier NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , HFitUserMpiNumber bigint NULL
           , RewardLevelGUID uniqueidentifier NOT NULL
           , AwardType int NOT NULL
           , AwardDisplayName nvarchar (100) NOT NULL
           , RewardValue float NULL
           , ThresholdNumber int NOT NULL
           , UserNotified bit NOT NULL
           , IsFulfilled bit NOT NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , ChangeType varchar (1) NOT NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX temp_PI_EDW_HealthAssessment_IDs ON dbo.TEMP_EDW_RewardAwardDetail_DATA ( UserGUID , SiteGUID , HFitUserMpiNumber , RewardLevelGUID , AwardType , AwardDisplayName , RewardValue , ThresholdNumber , UserNotified , IsFulfilled , AccountID , AccountCD) ON [PRIMARY];

GO

--ALTER TABLE dbo.TEMP_EDW_RewardAwardDetail_DATA SET ( LOCK_ESCALATION = TABLE) ;

GO

-- Create Table [dbo].[DIM_EDW_RewardUserLevel]

PRINT 'Create Table [dbo].[DIM_EDW_RewardUserLevel]';

GO

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_PADDING ON;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_RewardUserLevel') 

    BEGIN

        DROP TABLE
             DIM_EDW_RewardUserLevel;
    END;
GO

CREATE TABLE dbo.DIM_EDW_RewardUserLevel (
             UserId int NOT NULL
           , LevelCompletedDt datetime NOT NULL
           , LevelName nvarchar (100) NOT NULL
           , SiteName nvarchar (100) NOT NULL
           , nodeguid uniqueidentifier NOT NULL
           , SiteGuid uniqueidentifier NOT NULL
           , LevelHeader nvarchar (256) NULL
           , GroupHeadingText nvarchar (40) NULL
           , GroupHeadingDescription nvarchar (1024) NULL
           , HashCode nvarchar (75) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
           , TimeZone nvarchar (10)) 
ON [PRIMARY];

GO

CREATE CLUSTERED INDEX PI_EDW_RewardUserLevel_IDs ON dbo.DIM_EDW_RewardUserLevel ( UserId , LevelCompletedDt , LevelName , SiteName , nodeguid , SiteGuid) ON [PRIMARY];

GO

--ALTER TABLE dbo.DIM_EDW_RewardUserLevel SET ( LOCK_ESCALATION = TABLE) ;

GO

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'DIM_EDW_BioMetrics') 
    BEGIN
        DROP TABLE
             DIM_EDW_BioMetrics;
    END;
GO

CREATE TABLE dbo.DIM_EDW_BioMetrics (
             UserID int NOT NULL
           , UserGUID uniqueidentifier NOT NULL
           , HFitUserMpiNumber bigint NULL
           , SiteID int NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , CreatedDate datetime NULL
           , ModifiedDate datetime NULL
           , Notes nvarchar (1000) NULL
           , IsProfessionallyCollected bit NULL
           , EventDate datetime NULL
           , EventName varchar (13) NOT NULL
           , PPTWeight float NULL
           , PPTHbA1C float NULL
           , Fasting bit NULL
           , HDL float NULL
           , LDL float NULL
           , Ratio float NULL
           , Total float NULL
           , Triglycerides int NULL
           , Glucose int NULL
           , FastingState bit NULL
           , Systolic int NULL
           , Diastolic int NULL
           , PPTBodyFatPCT float NULL
           , BMI float NULL
           , WaistInches float NULL
           , HipInches float NULL
           , ThighInches float NULL
           , ArmInches float NULL
           , ChestInches float NULL
           , CalfInches float NULL
           , NeckInches float NULL
           , Height float NULL
           , HeartRate int NULL
           , FluShot bit NULL
           , PneumoniaShot bit NULL
           , PSATest bit NULL
           , OtherExam bit NULL
           , TScore float NULL
           , DRA float NULL
           , CotinineTest bit NULL
           , ColoCareKit bit NULL
           , CustomTest float NULL
           , CustomDesc varchar (500) NULL
           , CollectionSource nvarchar (100) NULL
           , AccountID int NOT NULL
           , AccountCD nvarchar (8) NULL
           , ChangeType varchar (1) NOT NULL
           , ItemCreatedWhen datetime NULL
           , ItemModifiedWhen datetime NULL
           , TrackerCollectionSourceID int NOT NULL
           , itemid int NOT NULL
           , TBL varchar (32) NOT NULL
           , VendorID int NULL
           , VendorName nvarchar (32) NULL
           , HashCode nvarchar (75) NULL
           , CMS_Site_CtID int NULL
           , CMS_Site_SCV bigint NULL
           , CMS_UserSettings_CtID int NULL
           , CMS_UserSettings_SCV bigint NULL
           , CMS_UserSite_CtID int NULL
           , CMS_UserSite_SCV bigint NULL
           , HFit_Account_CtID int NULL
           , HFit_Account_SCV bigint NULL
           , HFit_UserTracker_CtID int NULL
           , HFit_UserTracker_SCV bigint NULL
           , CMS_Site_CHGTYPE nchar (1) NULL
           , CMS_UserSettings_CHGTYPE nchar (1) NULL
           , CMS_UserSite_CHGTYPE nchar (1) NULL
           , HFit_Account_CHGTYPE nchar (1) NULL
           , HFit_UserTracker_CHGTYPE nchar (1) NULL
           , HFit_TrackerSource_CHGTYPE nchar (1) NULL
           , CT_ChangeType nchar (1) NULL
           , LastModifiedDate datetime NULL
           , RowNbr int NULL
           , DeletedFlg bit NULL
           , ConvertedToCentralTime bit NULL
) 
ON [PRIMARY];

GO

--Add needed columns to temp tables
IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'Temp_HealthInterestDetail') 
    BEGIN
        EXEC proc_Add_EDW_CT_StdCols 'Temp_HealthInterestDetail';
    END;

GO

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardsDefinition';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthAssessment';

EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_RewardUserLevel_DATA';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthDefinition';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthInterestList';

EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_Coaches_DATA';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_Trackers';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardAwardDetail';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthInterestDetail';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthAssesmentClientView';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_CoachingDetail';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardUserDetail';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_Coaches';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardTriggerParameters';

EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_RewardTriggerParameters_DATA';

EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_CoachingDetail_DATA';

EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_HealthDefinition_DATA';

EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_Tracker_DATA';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_HealthAssessmentDefinition';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_SmallSteps';

EXEC proc_Add_EDW_CT_StdCols 'TEMP_EDW_RewardAwardDetail_DATA';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_RewardUserLevel';

EXEC proc_Add_EDW_CT_StdCols 'DIM_EDW_BioMetrics';

GO

PRINT 'Created the STAGING tables';

GO 

