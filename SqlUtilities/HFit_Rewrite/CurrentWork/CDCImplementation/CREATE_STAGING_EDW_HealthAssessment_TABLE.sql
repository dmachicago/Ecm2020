

GO
PRINT 'CREATE_EDW_HealthAssessment_TABLE.SQL';
GO
-- select top 100 * from FACT_MART_EDW_HealthAssesment
--drop table FACT_MART_EDW_HealthAssesment
--exec CREATE_EDW_HealthAssessment_TABLE
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'CREATE_EDW_HealthAssessment_TABLE') 
    BEGIN
        DROP PROCEDURE
             CREATE_EDW_HealthAssessment_TABLE;
    END;
GO

CREATE PROCEDURE CREATE_EDW_HealthAssessment_TABLE
AS
BEGIN
    IF NOT EXISTS ( SELECT
                           name
                           FROM sys.tables
                           WHERE name = 'FACT_MART_EDW_HealthAssesment') 
        BEGIN

            CREATE TABLE dbo.FACT_MART_EDW_HealthAssesment (
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
                       , TITLE nvarchar (max) NULL
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
                       , HASHCODE nvarchar (100) NULL
                       , PKHASHCODE nvarchar (100) NULL
                       , CHANGED_FLG int NULL
                       , LastModifiedDATE datetime NULL
                       , HEALTHASSESSMENTTYPE nvarchar (9) NULL
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
				   , ChangeType nvarchar(1) null 
            ) 
            ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
		  --drop INDEX PI_EDW_HealthAssessment_Dates ON dbo.FACT_MART_EDW_HealthAssesment
            CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_Dates ON dbo.FACT_MART_EDW_HealthAssesment (
            ITEMMODIFIEDWHEN
            , HAUSERSTARTED_LASTMODIFIED
            , CMSUSER_LASTMODIFIED
            , USERSETTINGS_LASTMODIFIED
            , USERSITE_LASTMODIFIED
            , CMSSITE_LASTMODIFIED
            , ACCT_LASTMODIFIED
            , HAUSERMODULE_LASTMODIFIED
            , VHCJ_LASTMODIFIED
            , VHAJ_LASTMODIFIED
            , HARISKCATEGORY_LASTMODIFIED
            , HAUSERRISKAREA_LASTMODIFIED
            , HAUSERQUESTION_LASTMODIFIED
            , HAQUESTIONSVIEW_LASTMODIFIED
            , HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED
            , HAUSERANSWERS_LASTMODIFIED) ON [PRIMARY];

            IF NOT EXISTS
            ( SELECT
                     name
                     FROM sys.indexes
                     WHERE name = 'PI_EDW_HealthAssessment_NATKEY') 
                BEGIN
                    PRINT 'Adding INDEX PI_EDW_HealthAssessment_NATKEY at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
				--drop INDEX PI_EDW_HealthAssessment_NATKEY ON dbo.FACT_MART_EDW_HealthAssesment 
                    CREATE clustered INDEX PI_EDW_HealthAssessment_NATKEY ON dbo.FACT_MART_EDW_HealthAssesment (
				SVR, DBNAME ,
                    UserStartedItemID
                    , UserGUID
                    , PKHashCode
                    );
                END;

IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'FACT_MART_EDW_HealthAssesment') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_DelFLG
        ON dbo.FACT_MART_EDW_HealthAssesment (SVR, DBNAME, LastModifiedDATE, DELETEDFLG) 
    END;
        --CREATE CLUSTERED INDEX PI_EDW_HealthAssessment_IDs ON dbo.FACT_MART_EDW_HealthAssesment ( UserStartedItemID , UserModuleItemId , UserRiskCategoryItemID , UserRiskAreaItemID , UserQuestionItemID , UserAnswerItemID , AccountID , UserGUID , HFitUserMpiNumber ) ON [PRIMARY];
        END;
END;

GO
PRINT 'Completed CREATE_EDW_HealthAssessment_TABLE.SQL';
GO