--10,242 @ 01:42:05
-- drop table ##TEMP_EDW_HA_DATA_NOCT

CREATE TABLE ##TEMP_EDW_HA_DATA_NOCT (
             UserStartedITEMID int NOT NULL
           ,HEALTHASSESMENTUserStartedNODEGUID uniqueidentifier NULL
           ,USERID bigint NULL
           ,USERGUID uniqueidentifier NULL
           ,HFITUSERMPINUMBER bigint NULL
           ,SITEGUID uniqueidentifier NULL
           ,ACCOUNTID int NULL
           ,ACCOUNTCD nvarchar (8) NULL
           ,ACCOUNTNAME nvarchar (200) NULL
           ,HASTARTEDDT datetime2 (7) NULL
           ,HACOMPLETEDDT datetime2 (7) NULL
           ,USERMODULEITEMID int NULL
           ,USERMODULECODENAME nvarchar (100) NULL
           ,HAMODULENODEGUID uniqueidentifier NULL
           ,CMSNODEGUID uniqueidentifier NULL
           ,HAMODULEVERSIONID int NULL
           ,USERRISKCATEGORYITEMID int NULL
           ,USERRISKCATEGORYCODENAME nvarchar (100) NULL
           ,HARISKCATEGORYNODEGUID uniqueidentifier NULL
           ,HARISKCATEGORYVERSIONID int NULL
           ,USERRISKAREAITEMID int NULL
           ,USERRISKAREACODENAME nvarchar (100) NULL
           ,HARISKAREANODEGUID uniqueidentifier NULL
           ,HARISKAREAVERSIONID int NULL
           ,USERQUESTIONITEMID int NULL
           ,TITLE varchar (max) NULL
           ,HAQUESTIONGUID uniqueidentifier NULL
           ,USERQUESTIONCODENAME nvarchar (100) NULL
           ,HAQUESTIONDOCUMENTID int NULL
           ,HAQUESTIONVERSIONID int NULL
           ,HAQUESTIONNODEGUID uniqueidentifier NULL
           ,USERANSWERITEMID int NULL
           ,HAANSWERNODEGUID uniqueidentifier NULL
           ,HAANSWERVERSIONID int NULL
           ,USERANSWERCODENAME nvarchar (100) NULL
           ,HAANSWERVALUE nvarchar (255) NULL
           ,HAMODULESCORE float NULL
           ,HARISKCATEGORYSCORE float NULL
           ,HARISKAREASCORE float NULL
           ,HAQUESTIONSCORE float NULL
           ,HAANSWERPOINTS int NULL
           ,POINTRESULTS int NULL
           ,UOMCODE nvarchar (10) NULL
           ,HASCORE int NULL
           ,MODULEPREWEIGHTEDSCORE float NULL
           ,RISKCATEGORYPREWEIGHTEDSCORE float NULL
           ,RISKAREAPREWEIGHTEDSCORE float NULL
           ,QUESTIONPREWEIGHTEDSCORE float NULL
           ,QUESTIONGROUPCODENAME nvarchar (100) NULL
           ,ITEMCREATEDWHEN datetime2 (7) NULL
           ,ITEMMODIFIEDWHEN datetime2 (7) NULL
           ,ISPROFESSIONALLYCOLLECTED bit NULL
           ,HARISKCATEGORY_ITEMMODIFIEDWHEN datetime2 (7) NULL
           ,HAUSERRISKAREA_ITEMMODIFIEDWHEN datetime2 (7) NULL
           ,HAUSERQUESTION_ITEMMODIFIEDWHEN datetime2 (7) NULL
           ,HAUSERANSWERS_ITEMMODIFIEDWHEN datetime2 (7) NULL
           ,HAPAPERFLG bit NULL
           ,HATELEPHONICFLG bit NULL
           ,HASTARTEDMODE int NULL
           ,HACOMPLETEDMODE int NULL
           ,DOCUMENTCULTURE_VHCJ nvarchar (10) NULL
           ,DOCUMENTCULTURE_HAQUESTIONSVIEW nvarchar (10) NULL
           ,CAMPAIGNNODEGUID uniqueidentifier NULL
           ,HACAMPAIGNID int NULL
           ,HASHCODE varchar (100) NOT NULL
           ,PKHASHCODE varchar (100) NOT NULL
           ,CHANGED_FLG int NULL
           ,LASTMODIFIEDDATE datetime2 (7) NULL
           ,HEALTHASSESSMENTTYPE varchar (9) NULL
           ,HAUserStarted_LASTMODIFIED datetime NULL
           ,CMSUSER_LASTMODIFIED datetime NULL
           ,USERSETTINGS_LASTMODIFIED datetime NULL
           ,USERSITE_LASTMODIFIED datetime NULL
           ,CMSSITE_LASTMODIFIED datetime2 (7) NULL
           ,ACCT_LASTMODIFIED datetime2 (7) NULL
           ,HAUSERMODULE_LASTMODIFIED datetime NULL
           ,VHCJ_LASTMODIFIED datetime NULL
           ,VHAJ_LASTMODIFIED datetime NULL
           ,HARISKCATEGORY_LASTMODIFIED datetime NULL
           ,HAUSERRISKAREA_LASTMODIFIED datetime NULL
           ,HAUSERQUESTION_LASTMODIFIED datetime NULL
           ,HAQUESTIONSVIEW_LASTMODIFIED datetime NULL
           ,HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED datetime NULL
           ,HAUSERANSWERS_LASTMODIFIED datetime NULL
           ,HAUserStarted_LastUpdateID int NULL
           ,CMSUSER_LastUpdateID int NULL
           ,USERSETTINGS_LastUpdateID int NULL
           ,USERSITE_LastUpdateID int NULL
           ,ACCT_LastUpdateID datetime2 (7) NULL
           ,HAUSERMODULE_LastUpdateID int NULL
           ,VHCJ_LastUpdateID int NULL
           ,VHAJ_LastUpdateID int NULL
           ,HARISKCATEGORY_LastUpdateID int NULL
           ,HAUSERRISKAREA_LastUpdateID int NULL
           ,HAUSERQUESTION_LastUpdateID int NULL
           ,HAQUESTIONSVIEW_LastUpdateID int NULL
           ,HAUSERQUESTIONGROUPRESULTS_LastUpdateID int NULL
           ,HAUSERANSWERS_LastUpdateID int NULL
           ,LASTUPDATEID int NULL
           ,DELETEFLG int NULL
           ,SVR nvarchar (128) NULL
           ,DBNAME nvarchar (128) NULL
           ,DELETEDFLG int NULL
           , RowKey int IDENTITY (1, 1) 
                        NOT NULL
) 
ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = 'PI_EDWHA_PKHASHKEY') 
    BEGIN
        DROP INDEX PI_EDWHA_PKHASHKEY ON dbo.##TEMP_EDW_HA_DATA_NOCT
    END;

CREATE CLUSTERED INDEX PI_EDWHA_PKHASHKEY ON dbo.##TEMP_EDW_HA_DATA_NOCT
(
UserStartedITEMID ASC,
HASHCODE ASC,
PKHASHCODE ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

GO

--truncate table ##TEMP_EDW_HA_DATA_NOCT

INSERT INTO ##TEMP_EDW_HA_DATA_NOCT
(
       UserStartedITEMID
     , HEALTHASSESMENTUserStartedNODEGUID
     , USERID
     , USERGUID
     , HFITUSERMPINUMBER
     , SITEGUID
     , ACCOUNTID
     , ACCOUNTCD
     , ACCOUNTNAME
     , HASTARTEDDT
     , HACOMPLETEDDT
     , USERMODULEITEMID
     , USERMODULECODENAME
     , HAMODULENODEGUID
     , CMSNODEGUID
     , HAMODULEVERSIONID
     , USERRISKCATEGORYITEMID
     , USERRISKCATEGORYCODENAME
     , HARISKCATEGORYNODEGUID
     , HARISKCATEGORYVERSIONID
     , USERRISKAREAITEMID
     , USERRISKAREACODENAME
     , HARISKAREANODEGUID
     , HARISKAREAVERSIONID
     , USERQUESTIONITEMID
     , TITLE
     , HAQUESTIONGUID
     , USERQUESTIONCODENAME
     , HAQUESTIONDOCUMENTID
     , HAQUESTIONVERSIONID
     , HAQUESTIONNODEGUID
     , USERANSWERITEMID
     , HAANSWERNODEGUID
     , HAANSWERVERSIONID
     , USERANSWERCODENAME
     , HAANSWERVALUE
     , HAMODULESCORE
     , HARISKCATEGORYSCORE
     , HARISKAREASCORE
     , HAQUESTIONSCORE
     , HAANSWERPOINTS
     , POINTRESULTS
     , UOMCODE
     , HASCORE
     , MODULEPREWEIGHTEDSCORE
     , RISKCATEGORYPREWEIGHTEDSCORE
     , RISKAREAPREWEIGHTEDSCORE
     , QUESTIONPREWEIGHTEDSCORE
     , QUESTIONGROUPCODENAME
     , ITEMCREATEDWHEN
     , ITEMMODIFIEDWHEN
     , ISPROFESSIONALLYCOLLECTED
     , HARISKCATEGORY_ITEMMODIFIEDWHEN
     , HAUSERRISKAREA_ITEMMODIFIEDWHEN
     , HAUSERQUESTION_ITEMMODIFIEDWHEN
     , HAUSERANSWERS_ITEMMODIFIEDWHEN
     , HAPAPERFLG
     , HATELEPHONICFLG
     , HASTARTEDMODE
     , HACOMPLETEDMODE
     , DOCUMENTCULTURE_VHCJ
     , DOCUMENTCULTURE_HAQUESTIONSVIEW
     , CAMPAIGNNODEGUID
     , HACAMPAIGNID
     , HASHCODE
     , PKHASHCODE
     , CHANGED_FLG
     , LASTMODIFIEDDATE
     , HEALTHASSESSMENTTYPE
     , HAUserStarted_LASTMODIFIED
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
     , HAUSERANSWERS_LASTMODIFIED
     , HAUserStarted_LastUpdateID
     , CMSUSER_LastUpdateID
     , USERSETTINGS_LastUpdateID
     , USERSITE_LastUpdateID
     , ACCT_LastUpdateID
     , HAUSERMODULE_LastUpdateID
     , VHCJ_LastUpdateID
     , VHAJ_LastUpdateID
     , HARISKCATEGORY_LastUpdateID
     , HAUSERRISKAREA_LastUpdateID
     , HAUSERQUESTION_LastUpdateID
     , HAQUESTIONSVIEW_LastUpdateID
     , HAUSERQUESTIONGROUPRESULTS_LastUpdateID
     , HAUSERANSWERS_LastUpdateID
     , LASTUPDATEID
     , DELETEFLG
     , SVR
     , DBNAME
     , DELETEDFLG) 
SELECT
       UserStartedITEMID
     , HEALTHASSESMENTUserStartedNODEGUID
     , USERID
     , USERGUID
     , HFITUSERMPINUMBER
     , SITEGUID
     , ACCOUNTID
     , ACCOUNTCD
     , ACCOUNTNAME
     , HASTARTEDDT
     , HACOMPLETEDDT
     , USERMODULEITEMID
     , USERMODULECODENAME
     , HAMODULENODEGUID
     , CMSNODEGUID
     , HAMODULEVERSIONID
     , USERRISKCATEGORYITEMID
     , USERRISKCATEGORYCODENAME
     , HARISKCATEGORYNODEGUID
     , HARISKCATEGORYVERSIONID
     , USERRISKAREAITEMID
     , USERRISKAREACODENAME
     , HARISKAREANODEGUID
     , HARISKAREAVERSIONID
     , USERQUESTIONITEMID
     , TITLE
     , HAQUESTIONGUID
     , USERQUESTIONCODENAME
     , HAQUESTIONDOCUMENTID
     , HAQUESTIONVERSIONID
     , HAQUESTIONNODEGUID
     , USERANSWERITEMID
     , HAANSWERNODEGUID
     , HAANSWERVERSIONID
     , USERANSWERCODENAME
     , HAANSWERVALUE
     , HAMODULESCORE
     , HARISKCATEGORYSCORE
     , HARISKAREASCORE
     , HAQUESTIONSCORE
     , HAANSWERPOINTS
     , POINTRESULTS
     , UOMCODE
     , HASCORE
     , MODULEPREWEIGHTEDSCORE
     , RISKCATEGORYPREWEIGHTEDSCORE
     , RISKAREAPREWEIGHTEDSCORE
     , QUESTIONPREWEIGHTEDSCORE
     , QUESTIONGROUPCODENAME
     , ITEMCREATEDWHEN
     , ITEMMODIFIEDWHEN
     , ISPROFESSIONALLYCOLLECTED
     , HARISKCATEGORY_ITEMMODIFIEDWHEN
     , HAUSERRISKAREA_ITEMMODIFIEDWHEN
     , HAUSERQUESTION_ITEMMODIFIEDWHEN
     , HAUSERANSWERS_ITEMMODIFIEDWHEN
     , HAPAPERFLG
     , HATELEPHONICFLG
     , HASTARTEDMODE
     , HACOMPLETEDMODE
     , DOCUMENTCULTURE_VHCJ
     , DOCUMENTCULTURE_HAQUESTIONSVIEW
     , CAMPAIGNNODEGUID
     , HACAMPAIGNID
     , HASHCODE
     , PKHASHCODE
     , CHANGED_FLG
     , LASTMODIFIEDDATE
     , HEALTHASSESSMENTTYPE
     , HAUserStarted_LASTMODIFIED
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
     , HAUSERANSWERS_LASTMODIFIED
     , HAUserStarted_LastUpdateID
     , CMSUSER_LastUpdateID
     , USERSETTINGS_LastUpdateID
     , USERSITE_LastUpdateID
     , ACCT_LastUpdateID
     , HAUSERMODULE_LastUpdateID
     , VHCJ_LastUpdateID
     , VHAJ_LastUpdateID
     , HARISKCATEGORY_LastUpdateID
     , HAUSERRISKAREA_LastUpdateID
     , HAUSERQUESTION_LastUpdateID
     , HAQUESTIONSVIEW_LastUpdateID
     , HAUSERQUESTIONGROUPRESULTS_LastUpdateID
     , HAUSERANSWERS_LastUpdateID
     , LASTUPDATEID
     , DELETEFLG
     , SVR
     , DBNAME
     , DELETEDFLG
       FROM view_EDW_PullHAData_NoCT
       WHERE
       HAUserStarted_LastUpdateID >= 12578
    OR CMSUSER_LastUpdateID >= 12578
    OR USERSETTINGS_LastUpdateID >= 12578
    OR USERSITE_LastUpdateID >= 12578
       --OR  ACCT_LastUpdateID >= 12578
    OR HAUSERMODULE_LastUpdateID >= 12578
    OR VHCJ_LastUpdateID >= 12578
    OR VHAJ_LastUpdateID >= 12578
    OR HARISKCATEGORY_LastUpdateID >= 12578
    OR HAUSERRISKAREA_LastUpdateID >= 12578
    OR HAUSERQUESTION_LastUpdateID >= 12578
    OR HAQUESTIONSVIEW_LastUpdateID >= 12578
    OR HAUSERQUESTIONGROUPRESULTS_LastUpdateID >= 12578
    OR HAUSERANSWERS_LastUpdateID >= 12578;


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
