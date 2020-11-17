

GO
PRINT 'Create proc_CREATE_EDW_HealthAssessment_TABLE.SQL';
GO

IF EXISTS (SELECT name
				  FROM sys.procedures
				  WHERE name = 'proc_CREATE_EDW_HealthAssessment_TABLE') 
	BEGIN
		DROP PROCEDURE proc_CREATE_EDW_HealthAssessment_TABLE;
	END;
GO
IF EXISTS (SELECT name
				  FROM sys.tables
				  WHERE name = 'BASE_MART_EDW_HealthAssesment') 
	BEGIN
		DROP TABLE BASE_MART_EDW_HealthAssesment;
	END;
GO

-- drop table BASE_MART_EDW_HealthAssesment
-- exec proc_CREATE_EDW_HealthAssessment_TABLE
CREATE PROCEDURE proc_CREATE_EDW_HealthAssessment_TABLE
AS
	 BEGIN
		 IF NOT EXISTS (SELECT name
							   FROM sys.tables
							   WHERE name = 'BASE_MART_EDW_HealthAssesment') 
			 BEGIN
				 PRINT 'CREATING BASE_MART_EDW_HealthAssesment ';

				 CREATE TABLE dbo.BASE_MART_EDW_HealthAssesment (USERSTARTEDITEMID int NOT NULL
														   , HEALTHASSESMENTUSERSTARTEDNODEGUID uniqueidentifier NOT NULL
														   , USERID bigint NOT NULL
														   , USERGUID uniqueidentifier NOT NULL
														   , HFITUSERMPINUMBER bigint NULL
														   , SITEGUID uniqueidentifier NOT NULL
														   , ACCOUNTID int NOT NULL
														   , ACCOUNTCD nvarchar (8) NULL
														   , ACCOUNTNAME nvarchar (200) NULL
														   , HASTARTEDDT datetime2 (7) NOT NULL
														   , HACOMPLETEDDT datetime2 (7) NULL
														   , USERMODULEITEMID int NOT NULL
														   , USERMODULECODENAME nvarchar (100) NOT NULL
														   , HAMODULENODEGUID uniqueidentifier NOT NULL
														   , CMSNODEGUID uniqueidentifier NOT NULL
														   , HAMODULEVERSIONID int NULL
														   , USERRISKCATEGORYITEMID int NOT NULL
														   , USERRISKCATEGORYCODENAME nvarchar (100) NOT NULL
														   , HARISKCATEGORYNODEGUID uniqueidentifier NOT NULL
														   , HARISKCATEGORYVERSIONID int NULL
														   , USERRISKAREAITEMID int NOT NULL
														   , USERRISKAREACODENAME nvarchar (100) NOT NULL
														   , HARISKAREANODEGUID uniqueidentifier NOT NULL
														   , HARISKAREAVERSIONID int NULL
														   , USERQUESTIONITEMID int NOT NULL
														   , TITLE nvarchar (max) NULL
														   , HAQUESTIONGUID uniqueidentifier NOT NULL
														   , USERQUESTIONCODENAME nvarchar (100) NOT NULL
														   , HAQUESTIONDOCUMENTID int NULL
														   , HAQUESTIONVERSIONID int NULL
														   , HAQUESTIONNODEGUID uniqueidentifier NOT NULL
														   , USERANSWERITEMID int NOT NULL
														   , HAANSWERNODEGUID uniqueidentifier NOT NULL
														   , HAANSWERVERSIONID int NULL
														   , USERANSWERCODENAME nvarchar (100) NOT NULL
														   , HAANSWERVALUE nvarchar (255) NULL
														   , HAMODULESCORE float NOT NULL
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
														   , CHANGETYPE nchar (1) NULL
														   , ITEMCREATEDWHEN datetime2 (7) NULL
														   , ITEMMODIFIEDWHEN datetime2 (7) NULL
														   , ISPROFESSIONALLYCOLLECTED bit NOT NULL
														   , HARISKCATEGORY_ITEMMODIFIEDWHEN datetime2 (7) NULL
														   , HAUSERRISKAREA_ITEMMODIFIEDWHEN datetime2 (7) NULL
														   , HAUSERQUESTION_ITEMMODIFIEDWHEN datetime2 (7) NULL
														   , HAUSERANSWERS_ITEMMODIFIEDWHEN datetime2 (7) NULL
														   , HAPAPERFLG bit NOT NULL
														   , HATELEPHONICFLG bit NOT NULL
														   , HASTARTEDMODE int NOT NULL
														   , HACOMPLETEDMODE int NOT NULL
														   , DOCUMENTCULTURE_VHCJ nvarchar (10) NOT NULL
														   , DOCUMENTCULTURE_HAQUESTIONSVIEW nvarchar (10) NOT NULL
														   , CAMPAIGNNODEGUID uniqueidentifier NOT NULL
														   , HACAMPAIGNID int NOT NULL
														   , HASHCODE varchar (100) NULL
														   , PKHASHCODE varchar (100) NULL
														   , CHANGED_FLG int NULL
														   , CT_CMS_USER_USERID int NULL
														   , CT_CMS_USER_CHANGE_OPERATION nchar (1) NULL
														   , CT_USERSETTINGSID int NULL
														   , CT_USERSETTINGSID_CHANGE_OPERATION nchar (1) NULL
														   , SITEID_CTID int NULL
														   , SITEID_CHANGE_OPERATION nchar (1) NULL
														   , USERSITEID_CTID int NULL
														   , USERSITEID_CHANGE_OPERATION nchar (1) NULL
														   , ACCOUNTID_CTID int NULL
														   , ACCOUNTID__CHANGE_OPERATION nchar (1) NULL
														   , HAUSERANSWERS_CTID int NULL
														   , HAUSERANSWERS_CHANGE_OPERATION nchar (1) NULL
														   , HFIT_HEALTHASSESMENTUSERMODULE_CTID int NULL
														   , HFIT_HEALTHASSESMENTUSERMODULE_CHANGE_OPERATION nchar (1) NULL
														   , HFIT_HEALTHASSESMENTUSERQUESTION_CTID int NULL
														   , HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION nchar (1) NULL
														   , HFIT_HealthAssesmentUserQuestionGroupResults_CTID int NULL
														   , HFIT_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION nchar (1) NULL
														   , HFIT_HEALTHASSESMENTUSERRISKAREA_CTID int NULL
														   , HFIT_HEALTHASSESMENTUSERRISKAREA_CHANGE_OPERATION nchar (1) NULL
														   , HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CTID int NULL
														   , HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CHANGE_OPERATION nchar (1) NULL
														   , HFIT_HEALTHASSESMENTUSERSTARTED_CTID int NULL
														   , HFIT_HEALTHASSESMENTUSERSTARTED_CHANGE_OPERATION nchar (1) NULL
														   , CT_CMS_USER_SCV bigint NULL
														   , CT_CMS_USERSETTINGS_SCV bigint NULL
														   , CT_CMS_SITE_SCV bigint NULL
														   , CT_CMS_USERSITE_SCV bigint NULL
														   , CT_HFIT_ACCOUNT_SCV bigint NULL
														   , CT_HFIT_HealthAssesmentUserAnswers_SCV bigint NULL
														   , CT_HFIT_HEALTHASSESMENTUSERMODULE_SCV bigint NULL
														   , CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV bigint NULL
														   , CT_HFIT_HealthAssesmentUserQuestionGroupResults_SCV bigint NULL
														   , CT_HFIT_HEALTHASSESMENTUSERRISKAREA_SCV bigint NULL
														   , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY_SCV bigint NULL
														   , CT_HFIT_HEALTHASSESMENTUSERSTARTED_SCV bigint NULL
														   , LastModifiedDATE datetime2 (7) NULL
														   , DELETEFLG int NOT NULL
														   , HealthAssessmentType varchar (9) NOT NULL
														   , LASTUPDATEID int NOT NULL
														   , SVR nvarchar (100) NOT NULL
														   , DBNAME nvarchar (100) NOT NULL
														   , DeletedFlg int NOT NULL
														   , LASTLOADEDDATE int NULL
														   , RowNbr int IDENTITY (1, 1) 
																		NOT NULL



														   , TimeZone nvarchar (10) NULL






														   , ConvertedToCentralTime bit NULL) 
				 ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

				 CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_CDT ON dbo.BASE_MART_EDW_HealthAssesment (ConvertedToCentralTime ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

				 CREATE NONCLUSTERED INDEX PI_EDW_HealthAssessment_Dates ON dbo.BASE_MART_EDW_HealthAssesment (ITEMMODIFIEDWHEN ASC, HAUSERSTARTED_LASTMODIFIED ASC, CMSUSER_LASTMODIFIED ASC, USERSETTINGS_LASTMODIFIED ASC, USERSITE_LASTMODIFIED ASC, CMSSITE_LASTMODIFIED ASC, ACCT_LASTMODIFIED ASC, HAUSERMODULE_LASTMODIFIED ASC, VHCJ_LASTMODIFIED ASC, VHAJ_LASTMODIFIED ASC, HARISKCATEGORY_LASTMODIFIED ASC, HAUSERRISKAREA_LASTMODIFIED ASC, HAUSERQUESTION_LASTMODIFIED ASC, HAQUESTIONSVIEW_LASTMODIFIED ASC, HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED ASC, HAUSERANSWERS_LASTMODIFIED ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

				 CREATE CLUSTERED INDEX PI_EDW_HealthAssessment_NATKEY ON dbo.BASE_MART_EDW_HealthAssesment (USERSTARTEDITEMID ASC, USERGUID ASC, PKHASHCODE ASC, DeletedFlg, ChangeType) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

			 END;
		 ELSE
			 BEGIN
				 PRINT 'BASE_MART_EDW_HealthAssesment ALREADY exists, skipping.';
			 END;
	 END;
