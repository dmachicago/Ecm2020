
GO
USE KenticoCMS_DataMart;
/*--------------------------------------------------
-- drop table ##HealthAssessmentData    
  exec proc_Denormalize_EDW_HealthAssessment_VIEWS 1
*/
GO
PRINT 'Creating proc_Denormalize_EDW_HealthAssessment_VIEWS.sql';
GO

-- select count(*) from BASE_HFIT_HEALTHASSESMENTUSERANSWERS

IF EXISTS ( SELECT
            NAME
                   FROM SYS.PROCEDURES
                   WHERE NAME = 'proc_Denormalize_EDW_HealthAssessment_VIEWS') 
    BEGIN
        DROP PROCEDURE
        proc_Denormalize_EDW_HealthAssessment_VIEWS;
    END;

GO
CREATE PROCEDURE proc_Denormalize_EDW_HealthAssessment_VIEWS
     @ReloadAll AS INT = 0
AS
BEGIN

/*------------------------------------------------------
Author:	  W. Dale Miller
Created:	  06.15.2015
USE:		  exec proc_Denormalize_EDW_HealthAssessment_VIEWS
*/

    -- declare @ReloadAll as int = 0 ;

    DECLARE
    @St AS DATETIME = GETDATE () ;
    PRINT 'TempData Started: ';
    PRINT CHAR ( 10) ;
    PRINT GETDATE () ;
    PRINT CHAR ( 10) ;
    SET NOCOUNT ON;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_CMS_USER')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_CMS_USER;
  --      END;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_BASE_HFIT_HEALTHASSESMENTUSERSTARTED')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_BASE_HFIT_HEALTHASSESMENTUSERSTARTED;
  --      END;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.sysobjects
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##HealthAssessmentData')) 
  --      BEGIN
  --          DROP TABLE
  --          ##HealthAssessmentData;
  --      END;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_BASE_HFIT_HEALTHASSESMENTUSERANSWERS')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_TEMP_BASE_HFIT_HEALTHASSESMENTUSERANSWERS;
  --      END;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_CMS_USERSITE')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_CMS_USERSITE;
  --      END;

  --  SELECT
  --  USERSITE.USERID
  --, USERSITE.SITEID
  --, USERSITE.USERSITEID
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_CMS_USERSITE
  --         FROM BASE_CMS_USERSITE AS USERSITE;

  --  CREATE CLUSTERED INDEX PI_CMS_USERSITE
  --  ON ##_CMS_USERSITE ( SVR, DBNAME, USERID , SITEID , USERSITEID) ;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_HFIT_HEALTHASSESMENTUSERMODULE')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_HFIT_HEALTHASSESMENTUSERMODULE;
  --      END;

  --  SELECT
  --  HAUSERMODULE.HASTARTEDITEMID
  --, HAUSERMODULE.ITEMID
  --, HAUSERMODULE.CODENAME
  --, HAUSERMODULE.HAMODULENODEGUID
  --, HAUSERMODULE.HAMODULESCORE
  --, HAUSERMODULE.PREWEIGHTEDSCORE
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_HFIT_HEALTHASSESMENTUSERMODULE
  --         FROM BASE_HFIT_HEALTHASSESMENTUSERMODULE AS HAUSERMODULE;

  --  CREATE NONCLUSTERED INDEX PI_HFIT_HEALTHASSESMENTUSERMODULE
  --  ON ##_HFIT_HEALTHASSESMENTUSERMODULE ( SVR, DBNAME, HASTARTEDITEMID , ITEMID) 
  --  INCLUDE (CODENAME , HAMODULENODEGUID , HAMODULESCORE , PREWEIGHTEDSCORE) ;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_HFIT_HEALTHASSESMENTUSERRISKCATEGORY')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_HFIT_HEALTHASSESMENTUSERRISKCATEGORY;
  --      END;

  --  SELECT
  --  HARISKCATEGORY.ITEMID
  --, HARISKCATEGORY.CODENAME
  --, HARISKCATEGORY.HARISKCATEGORYNODEGUID
  --, HARISKCATEGORY.HARISKCATEGORYSCORE
  --, HARISKCATEGORY.PREWEIGHTEDSCORE
  --, HARISKCATEGORY.ITEMMODIFIEDWHEN
  --, HARISKCATEGORY.HAMODULEITEMID
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
  --         FROM BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY;

  --  CREATE NONCLUSTERED INDEX PI_HEALTHASSESMENTUSERRISKCATEGORY
  --  ON ##_HFIT_HEALTHASSESMENTUSERRISKCATEGORY ( SVR, DBNAME, ITEMID , HAMODULEITEMID) 
  --  INCLUDE (CODENAME , HARISKCATEGORYNODEGUID , HARISKCATEGORYSCORE , PREWEIGHTEDSCORE , ITEMMODIFIEDWHEN, LastModifiedDate) ;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_CMS_USERSETTINGS')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_CMS_USERSETTINGS;
  --      END;

  --  SELECT
  --  USERSETTINGS.USERSETTINGSUSERID
  --, USERSETTINGS.HFITUSERMPINUMBER
  --, USERSETTINGS.USERSETTINGSID
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_CMS_USERSETTINGS
  --         FROM BASE_CMS_USERSETTINGS AS USERSETTINGS;

  --  CREATE CLUSTERED INDEX PI_CMS_USER
  --  ON ##_CMS_USERSETTINGS ( SVR, DBNAME, USERSETTINGSUSERID , HFITUSERMPINUMBER , USERSETTINGSID) ;

  --  -- select count(*) from BASE_CMS_USER
  --  SELECT
  --  CMSUSER.USERID
  --, CMSUSER.USERGUID
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_CMS_USER
  --         FROM BASE_CMS_USER AS CMSUSER;

  --  CREATE CLUSTERED INDEX PI_CMS_USER
  --  ON ##_CMS_USER (SVR, DBNAME, USERID , USERGUID) ;

  --  SELECT
  --  HAUSERSTARTED.ITEMID
  --, HAUSERSTARTED.USERID
  --, HAUSERSTARTED.HASTARTEDDT
  --, HAUSERSTARTED.HACOMPLETEDDT
  --, HAUSERSTARTED.HASCORE
  --, HAUSERSTARTED.HAPAPERFLG
  --, HAUSERSTARTED.HATELEPHONICFLG
  --, HAUSERSTARTED.HASTARTEDMODE
  --, HAUSERSTARTED.HACOMPLETEDMODE
  --, HAUSERSTARTED.HACAMPAIGNNODEGUID
  --, HAUserStarted.HADocumentConfigID
  --, GETDATE () AS LASTLOADEDDATE
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_BASE_HFIT_HEALTHASSESMENTUSERSTARTED
  --         FROM BASE_HFIT_HEALTHASSESMENTUSERSTARTED AS HAUSERSTARTED;
  --  CREATE NONCLUSTERED INDEX PI_BASE_HFIT_HEALTHASSESMENTUSERSTARTED
  --  ON ##_BASE_HFIT_HEALTHASSESMENTUSERSTARTED ( SVR, DBNAME, ITEMID , USERID) 
  --  INCLUDE ( HASTARTEDDT , HACOMPLETEDDT , HASCORE , HAPAPERFLG , HATELEPHONICFLG , HASTARTEDMODE , HACAMPAIGNNODEGUID , HADocumentConfigID) ;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_HFit_HealthAssesmentUserRiskArea')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_TEMP_HFIT_HEALTHASSESMENTUSERRISKAREA;
  --      END;

  --  SELECT
  --  HAUSERANSWERS.ITEMID
  --, HAUSERANSWERS.HAANSWERNODEGUID
  --, HAUSERANSWERS.CODENAME
  --, HAUSERANSWERS.HAANSWERVALUE
  --, HAUSERANSWERS.HAANSWERPOINTS
  --, HAUSERANSWERS.UOMCODE
  --, HAUSERANSWERS.ITEMCREATEDWHEN
  --, HAUSERANSWERS.ITEMMODIFIEDWHEN
  --, HAUSERANSWERS.HAQUESTIONITEMID
  --, GETDATE () AS LASTLOADEDDATE
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_TEMP_BASE_HFIT_HEALTHASSESMENTUSERANSWERS
  --         FROM BASE_HFIT_HEALTHASSESMENTUSERANSWERS AS HAUSERANSWERS;

  --  CREATE NONCLUSTERED INDEX PI_BASE_HFIT_HEALTHASSESMENTUSERANSWERS
  --  ON ##_TEMP_BASE_HFIT_HEALTHASSESMENTUSERANSWERS ( SVR, DBNAME, ITEMID , HAQUESTIONITEMID) 
  --  INCLUDE ( HAANSWERNODEGUID , CODENAME , HAANSWERVALUE , HAANSWERPOINTS , UOMCODE , ITEMCREATEDWHEN , ITEMMODIFIEDWHEN) ;
  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_HFit_HealthAssesmentUserRiskArea')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_TEMP_HFIT_HEALTHASSESMENTUSERRISKAREA;
  --      END;
  --  SELECT
  --  HAUSERRISKAREA.ITEMID
  --, HAUSERRISKAREA.CODENAME
  --, HAUSERRISKAREA.HARISKAREANODEGUID
  --, HAUSERRISKAREA.HARISKAREASCORE
  --, HAUSERRISKAREA.PREWEIGHTEDSCORE
  --, HAUSERRISKAREA.ITEMMODIFIEDWHEN
  --, HAUSERRISKAREA.HARISKCATEGORYITEMID
  --, GETDATE () AS LASTLOADEDDATE
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_TEMP_HFIT_HEALTHASSESMENTUSERRISKAREA
  --         FROM BASE_HFIT_HEALTHASSESMENTUSERRISKAREA AS HAUSERRISKAREA;

  --  CREATE NONCLUSTERED INDEX PI_HEALTHASSESMENTUSERRISKAREA
  --  ON ##_TEMP_HFIT_HEALTHASSESMENTUSERRISKAREA ( SVR, DBNAME, ITEMID , HARISKCATEGORYITEMID) 
  --  INCLUDE ( CODENAME , HARISKAREANODEGUID , HARISKAREASCORE , PREWEIGHTEDSCORE , ITEMMODIFIEDWHEN) ;
  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_HFit_HealthAssesmentUserQuestionGroupResults')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_TEMP_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS;
  --      END;
  --  SELECT
  --  HAUSERQUESTIONGROUPRESULTS.ITEMID
  --, HAUSERQUESTIONGROUPRESULTS.POINTRESULTS
  --, HAUSERQUESTIONGROUPRESULTS.CODENAME
  --, HAUSERQUESTIONGROUPRESULTS.HARISKAREAITEMID
  --, GETDATE () AS LASTLOADEDDATE
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_TEMP_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
  --         FROM BASE_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUSERQUESTIONGROUPRESULTS;

  --  CREATE NONCLUSTERED INDEX PI_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
  --  ON ##_TEMP_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS ( SVR, DBNAME, ITEMID) 
  --  INCLUDE ( POINTRESULTS , CODENAME , HARISKAREAITEMID) ;
  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_HFit_HealthAssesmentUserQuestion')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_TEMP_HFit_HealthAssesmentUserQuestion;
  --      END;
  --  SELECT
  --  USERQUES.ITEMID
  --, USERQUES.HAQUESTIONNODEGUID
  --, USERQUES.CODENAME
  --, USERQUES.HAQUESTIONSCORE
  --, USERQUES.PREWEIGHTEDSCORE
  --, USERQUES.ISPROFESSIONALLYCOLLECTED
  --, USERQUES.ITEMMODIFIEDWHEN
  --, USERQUES.HARISKAREAITEMID
  --, CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID AS               HFIT_HEALTHASSESMENTUSERQUESTION_CTID
  --, CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION AS HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
  --, CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION AS   CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
  --, GETDATE () AS                                               LASTLOADEDDATE
  --, USERQUES.SVR
  --, USERQUES.DBNAME
  --, USERQUES.LastModifiedDate
  --  INTO
  --  ##_TEMP_HFit_HealthAssesmentUserQuestion
  --         FROM BASE_HFIT_HEALTHASSESMENTUSERQUESTION AS USERQUES
  --                  LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION, NULL) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
  --                      ON USERQUES.ITEMID = CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID;

  --  PRINT '##_TEMP_HFit_HealthAssesmentUserQuestion Created';
  --  -- select top 100 * from ##_TEMP_HFit_HealthAssesmentUserQuestion

  --  CREATE UNIQUE CLUSTERED INDEX PI_HFit_HealthAssesmentUserQuestion ON ##_TEMP_HFit_HealthAssesmentUserQuestion
  --  (
  --  SVR, DBNAME,
  --  ITEMID
  --  , HARISKAREAITEMID
  --  , HAQUESTIONNODEGUID
  --  , CODENAME
  --  , HAQUESTIONSCORE
  --  , PREWEIGHTEDSCORE
  --  , ITEMMODIFIEDWHEN
  --  )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

  --  CREATE NONCLUSTERED INDEX PI_USERQUES_RISKAREAID
  --  ON ##_TEMP_HFit_HealthAssesmentUserQuestion ( SVR, DBNAME, HARISKAREAITEMID) 
  --  INCLUDE ( ITEMID , HAQUESTIONNODEGUID , CODENAME , HAQUESTIONSCORE , PREWEIGHTEDSCORE , ISPROFESSIONALLYCOLLECTED , ITEMMODIFIEDWHEN) ;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_View_HFit_HACampaign_Joined')) 
  --      BEGIN

  --          --PRINT 'Dropping ##_TEMP_View_HFit_HACampaign_Joined';

  --          DROP TABLE
  --          ##_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED;
  --      END;
  --  SELECT
  --  CAMPAIGN.DOCUMENTCULTURE
  --, CAMPAIGN.HACAMPAIGNID
  --, CAMPAIGN.NODEGUID
  --, CAMPAIGN.NODESITEID
  --, CAMPAIGN.HEALTHASSESSMENTID
  --, GETDATE () AS LASTLOADEDDATE
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED
  --         FROM VIEW_HFIT_HACAMPAIGN_JOINED AS CAMPAIGN;

  --  CREATE UNIQUE CLUSTERED INDEX PI_VIEW_HFIT_HACAMPAIGN_JOINED ON ##_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED
  --  (SVR ASC, DBNAME ASC,
  --  DOCUMENTCULTURE ASC ,
  --  HACAMPAIGNID ASC ,
  --  NODEGUID ASC ,
  --  HEALTHASSESSMENTID
  --  )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_View_HFit_HealthAssessment_Joined')) 
  --      BEGIN

  --          --PRINT 'Dropping ##_TEMP_View_HFit_HealthAssessment_Joined';

  --          DROP TABLE
  --          ##_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED;
  --      END;

  --  --select top 100 * from View_HFit_HealthAssessment_Joined

  --  SELECT
  --  HAJOINED.NODEGUID
  --, HAJOINED.DOCUMENTID
  --, HAJOINED.DOCUMENTCULTURE
  --, GETDATE () AS LASTLOADEDDATE
  --, SVR
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED
  --         FROM VIEW_HFIT_HEALTHASSESSMENT_JOINED AS HAJOINED;
  --  SET ANSI_PADDING ON;

  --  CREATE UNIQUE CLUSTERED INDEX PI_VIEW_HFIT_HEALTHASSESSMENT_JOINED ON ##_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED
  --  (SVR ASC, DBNAME ASC,
  --  NODEGUID ASC ,
  --  DOCUMENTID ASC
  --  )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
  --  IF EXISTS ( SELECT
  --              NAME
  --                     FROM TEMPDB.DBO.SYSOBJECTS
  --                     WHERE ID = OBJECT_ID ( N'tempdb..##_TEMP_View_EDW_HealthAssesmentQuestions')) 
  --      BEGIN
  --          DROP TABLE
  --          ##_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS;
  --      END;
  --  SELECT
  --  DBO.UDF_STRIPHTML ( QUES.TITLE) AS TITLE
  --, QUES.DOCUMENTCULTURE
  --, QUES.NODEGUID
  --, GETDATE () AS                      LASTLOADEDDATE
  --, DBNAME
  --, LastModifiedDate
  --  INTO
  --  ##_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS
  --         FROM VIEW_EDW_HEALTHASSESMENTQUESTIONS AS QUES;
  --  IF NOT EXISTS ( SELECT
  --                  NAME
  --                         FROM SYS.INDEXES
  --                         WHERE NAME = 'PI_HAUserQuestionGroupResults') 
  --      BEGIN
  --          CREATE NONCLUSTERED INDEX PI_HAUserQuestionGroupResults
  --          ON DBO.##_TEMP_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS ( SVR, DBNAME, HARISKAREAITEMID) 
  --          INCLUDE ( ITEMID , POINTRESULTS , CODENAME) ;
  --      END;
  --  SET ANSI_PADDING ON;

  --  CREATE UNIQUE CLUSTERED INDEX PI_VIEW_EDW_HEALTHASSESMENTQUESTIONS ON ##_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS
  --  (SVR ASC, DBNAME ASC,
  --  DOCUMENTCULTURE ASC ,
  --  NODEGUID ASC
  --  )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

  --  PRINT 'TempData Loaded: ';
  --  PRINT CHAR ( 10) ;
  --  PRINT GETDATE () ;
  --  PRINT CHAR ( 10) ;
  --  PRINT 'Seconds: ' + CAST ( DATEDIFF ( SECOND , @St , GETDATE ()) AS NVARCHAR (50)) ;
  --  PRINT CHAR ( 10) ;


/*
select * into FACT_VIEW_HFIT_HACAMPAIGN_JOINED
from VIEW_HFIT_HACAMPAIGN_JOINED

select * into FACT_VIEW_HFIT_HEALTHASSESSMENT_JOINED
from VIEW_HFIT_HEALTHASSESSMENT_JOINED

select * into FACT_VIEW_EDW_HEALTHASSESMENTQUESTIONS
from VIEW_EDW_HEALTHASSESMENTQUESTIONS



*/

    DECLARE    @StPullTime AS DATETIME = GETDATE () ;

    --************************************************************
    --TO THIS POINT: Averages around 3 minutes. WDM 06.01.2015
    --TO THIS POINT: Averages around 5 minutes, now - more temp tables. WDM 06.01.2015

    DECLARE @Stdataload AS DATETIME = GETDATE () ;

    SELECT
    HAUSERSTARTED.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          USERSTARTEDITEMID
  , VHAJ.NODEGUID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 HEALTHASSESMENTUSERSTARTEDNODEGUID
  , HAUSERSTARTED.USERID
  , CMSUSER.USERGUID
  , USERSETTINGS.HFITUSERMPINUMBER
  , CMSSITE.SITEGUID
  , ACCT.ACCOUNTID
  , ACCT.ACCOUNTCD
  , ACCT.ACCOUNTNAME
  , HAUSERSTARTED.HASTARTEDDT
  , HAUSERSTARTED.HACOMPLETEDDT
  , HAUSERMODULE.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           USERMODULEITEMID
  , HAUSERMODULE.CODENAME AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         USERMODULECODENAME
  , HAUSERMODULE.HAMODULENODEGUID
  , VHAJ.NODEGUID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 CMSNODEGUID
  , NULL AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          HAMODULEVERSIONID
  , HARISKCATEGORY.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         USERRISKCATEGORYITEMID
  , HARISKCATEGORY.CODENAME AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       USERRISKCATEGORYCODENAME
  , HARISKCATEGORY.HARISKCATEGORYNODEGUID
  , NULL AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          HARISKCATEGORYVERSIONID
  , HAUSERRISKAREA.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         USERRISKAREAITEMID
  , HAUSERRISKAREA.CODENAME AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       USERRISKAREACODENAME
  , HAUSERRISKAREA.HARISKAREANODEGUID
  , NULL AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          HARISKAREAVERSIONID
  , HAUSERQUESTION.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         USERQUESTIONITEMID
  , DBO.UDF_STRIPHTML ( HAQUESTIONSVIEW.TITLE) AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    TITLE
  , HAUSERQUESTION.HAQUESTIONNODEGUID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             HAQUESTIONGUID
  , HAUSERQUESTION.CODENAME AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       USERQUESTIONCODENAME
  , NULL AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          HAQUESTIONDOCUMENTID
  , NULL AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          HAQUESTIONVERSIONID
  , HAUSERQUESTION.HAQUESTIONNODEGUID
  , HAUSERANSWERS.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          USERANSWERITEMID
  , HAUSERANSWERS.HAANSWERNODEGUID
  , NULL AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          HAANSWERVERSIONID
  , HAUSERANSWERS.CODENAME AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        USERANSWERCODENAME
  , HAUSERANSWERS.HAANSWERVALUE
  , HAUSERMODULE.HAMODULESCORE
  , HARISKCATEGORY.HARISKCATEGORYSCORE
  , HAUSERRISKAREA.HARISKAREASCORE
  , HAUSERQUESTION.HAQUESTIONSCORE
  , HAUSERANSWERS.HAANSWERPOINTS
  , HAUSERQUESTIONGROUPRESULTS.POINTRESULTS
  , HAUSERANSWERS.UOMCODE
  , HAUSERSTARTED.HASCORE
  , HAUSERMODULE.PREWEIGHTEDSCORE AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 MODULEPREWEIGHTEDSCORE
  , HARISKCATEGORY.PREWEIGHTEDSCORE AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               RISKCATEGORYPREWEIGHTEDSCORE
  , HAUSERRISKAREA.PREWEIGHTEDSCORE AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               RISKAREAPREWEIGHTEDSCORE
  , HAUSERQUESTION.PREWEIGHTEDSCORE AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               QUESTIONPREWEIGHTEDSCORE
  , HAUSERQUESTIONGROUPRESULTS.CODENAME AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           QUESTIONGROUPCODENAME
  , COALESCE ( CT_CMS_USER.SYS_CHANGE_OPERATION , CT_CMS_USERSETTINGS.SYS_CHANGE_OPERATION , CT_CMS_SITE.SYS_CHANGE_OPERATION , CT_CMS_USERSITE.SYS_CHANGE_OPERATION , CT_HFIT_ACCOUNT.SYS_CHANGE_OPERATION , CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.SYS_CHANGE_OPERATION ,
    CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_OPERATION , CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION ,
    CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.SYS_CHANGE_OPERATION , CT_HFIT_HEALTHASSESMENTUSERRISKAREA.SYS_CHANGE_OPERATION ,
    CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION , CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_OPERATION) AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  CHANGETYPE
  , HAUSERANSWERS.ITEMCREATEDWHEN
  , HAUSERANSWERS.ITEMMODIFIEDWHEN
  , HAUSERQUESTION.ISPROFESSIONALLYCOLLECTED
  , HARISKCATEGORY.ITEMMODIFIEDWHEN AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               HARISKCATEGORY_ITEMMODIFIEDWHEN
  , HAUSERRISKAREA.ITEMMODIFIEDWHEN AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               HAUSERRISKAREA_ITEMMODIFIEDWHEN
  , HAUSERQUESTION.ITEMMODIFIEDWHEN AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               HAUSERQUESTION_ITEMMODIFIEDWHEN
  , HAUSERANSWERS.ITEMMODIFIEDWHEN AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                HAUSERANSWERS_ITEMMODIFIEDWHEN
  , HAUSERSTARTED.HAPAPERFLG
  , HAUSERSTARTED.HATELEPHONICFLG
  , HAUSERSTARTED.HASTARTEDMODE
  , HAUSERSTARTED.HACOMPLETEDMODE
  , VHCJ.DOCUMENTCULTURE AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          DOCUMENTCULTURE_VHCJ
  , HAQUESTIONSVIEW.DOCUMENTCULTURE AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               DOCUMENTCULTURE_HAQUESTIONSVIEW
  , HAUSERSTARTED.HACAMPAIGNNODEGUID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              CAMPAIGNNODEGUID
  , VHCJ.HACAMPAIGNID
  , CAST ( HASHBYTES ( 'sha1' ,
    ISNULL ( CAST ( HAUSERSTARTED.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID  AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERSTARTED.USERID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( CMSUSER.USERGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( USERSETTINGS.HFITUSERMPINUMBER AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( CMSSITE.SITEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTCD AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTNAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERSTARTED.HASTARTEDDT AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACOMPLETEDDT AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERMODULE.ITEMID  AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.CODENAME  AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULENODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID  AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS NVARCHAR (100)) ,
    '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREANODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( LEFT ( HAQUESTIONSVIEW.TITLE , 1000) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID  AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERQUESTION.CODENAME  AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERANSWERS.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERANSWERS.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERVALUE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULESCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERRISKAREA.HARISKAREASCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERANSWERS.HAANSWERPOINTS AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTIONGROUPRESULTS.POINTRESULTS AS NVARCHAR (100)) , '-') + ISNULL (
    CAST ( HAUSERANSWERS.UOMCODE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HASCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.PREWEIGHTEDSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.PREWEIGHTEDSCORE  AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERRISKAREA.PREWEIGHTEDSCORE  AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.PREWEIGHTEDSCORE  AS NVARCHAR (100)) , '-') + ISNULL ( CAST
    ( HAUSERQUESTIONGROUPRESULTS.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMCREATEDWHEN AS NVARCHAR (100)) , '-') + ISNULL (
    CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ISPROFESSIONALLYCOLLECTED AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HAPAPERFLG AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HATELEPHONICFLG AS NVARCHAR (100)) , '-') + ISNULL (
    CAST ( HAUSERSTARTED.HASTARTEDMODE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACOMPLETEDMODE AS NVARCHAR (100)) , '-') + ISNULL ( CAST
    ( HAUSERSTARTED.HACAMPAIGNNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( VHCJ.HACAMPAIGNID AS NVARCHAR (100)) , '-') + ISNULL ( CAST (
    HAUSERANSWERS.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-')) AS VARCHAR (100)) AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   HASHCODE
  , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUSERSTARTED.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID  AS VARCHAR (50)) , '-') + ISNULL ( CAST ( USERGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( SITEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( ACCOUNTCD AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERMODULE.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAMODULENODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORYNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS VARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKAREANODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.CODENAME AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAQUESTIONNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAANSWERNODEGUID   AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACAMPAIGNNODEGUID AS VARCHAR (50)) , '-')) AS VARCHAR (100)) AS PKHASHCODE
  , COALESCE ( CT_CMS_USER.USERID , CT_CMS_USERSETTINGS.USERSETTINGSID , CT_CMS_SITE.SITEID , CT_CMS_USERSITE.USERSITEID , CT_HFIT_ACCOUNT.ACCOUNTID , CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.ITEMID , CT_HFIT_HEALTHASSESMENTUSERMODULE.ITEMID , CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID , CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.ITEMID , CT_HFIT_HEALTHASSESMENTUSERRISKAREA.ITEMID , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ITEMID , CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.ITEMID) AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            CHANGED_FLG

    --*************************************
    --join changes to the records 

  , CT_CMS_USER.USERID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            CT_CMS_USER_USERID
  , CT_CMS_USER.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              CT_CMS_USER_CHANGE_OPERATION
  , CT_CMS_USERSETTINGS.USERSETTINGSID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            CT_USERSETTINGSID
  , CT_CMS_USERSETTINGS.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      CT_USERSETTINGSID_CHANGE_OPERATION
  , CT_CMS_SITE.SITEID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            SITEID_CTID
  , CT_CMS_SITE.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              SITEID_CHANGE_OPERATION
  , CT_CMS_USERSITE.USERSITEID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    USERSITEID_CTID
  , CT_CMS_USERSITE.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          USERSITEID_CHANGE_OPERATION
  , CT_HFIT_ACCOUNT.ACCOUNTID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ACCOUNTID_CTID
  , CT_HFIT_ACCOUNT.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ACCOUNTID__CHANGE_OPERATION
  , CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                HAUSERANSWERS_CTID
  , CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  HAUSERANSWERS_CHANGE_OPERATION
  , CT_HFIT_HEALTHASSESMENTUSERMODULE.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      HFIT_HEALTHASSESMENTUSERMODULE_CTID
  , CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        HFIT_HEALTHASSESMENTUSERMODULE_CHANGE_OPERATION
  , CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    HFIT_HEALTHASSESMENTUSERQUESTION_CTID
  , CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      HFIT_HEALTHASSESMENTUSERQUESTION_CHANGE_OPERATION
  , CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS_CTID
  , CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS_CHANGE_OPERATION
  , CT_HFIT_HEALTHASSESMENTUSERRISKAREA.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    HFIT_HEALTHASSESMENTUSERRISKAREA_CTID
  , CT_HFIT_HEALTHASSESMENTUSERRISKAREA.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      HFIT_HEALTHASSESMENTUSERRISKAREA_CHANGE_OPERATION
  , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CTID
  , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  HFIT_HEALTHASSESMENTUSERRISKCATEGORY_CHANGE_OPERATION
  , CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.ITEMID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                BASE_HFIT_HEALTHASSESMENTUSERSTARTED_CTID
  , CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_OPERATION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  BASE_HFIT_HEALTHASSESMENTUSERSTARTED_CHANGE_OPERATION

    --Get the TYPE of change ID NUMBER

  , CT_CMS_USER.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                CT_CMS_USER_SCV
  , CT_CMS_USERSETTINGS.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        CT_CMS_USERSETTINGS_SCV
  , CT_CMS_SITE.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                CT_CMS_SITE_SCV
  , CT_CMS_USERSITE.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            CT_CMS_USERSITE_SCV
  , CT_HFIT_ACCOUNT.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            CT_HFIT_ACCOUNT_SCV
  , CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS_SCV
  , CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          CT_HFIT_HEALTHASSESMENTUSERMODULE_SCV
  , CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        CT_HFIT_HEALTHASSESMENTUSERQUESTION_SCV
  , CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS_SCV
  , CT_HFIT_HEALTHASSESMENTUSERRISKAREA.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        CT_HFIT_HEALTHASSESMENTUSERRISKAREA_SCV
  , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY_SCV
  , CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.SYS_CHANGE_VERSION AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED_SCV
  , HAUSERANSWERS.ITEMMODIFIEDWHEN AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                LastModifiedDATE
  , 0 AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             DELETEFLG
  , CASE
    WHEN HAUserStarted.HADocumentConfigID IS NULL
            THEN 'SHORT_VER'
    WHEN HAUserStarted.HADocumentConfigID IS NOT NULL
            THEN 'LONG_VER'
        ELSE 'UNKNOWN'
    END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           HealthAssessmentType
  , GETDATE () AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    LASTLOADEDDATE
    --, change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'SiteID', 'columnid') , CTE.sys_change_columns) AS [SiteID_cg] 
    --, change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserID', 'columnid') , CTE.sys_change_columns) AS [UserID_cg] 
    --, change_tracking_is_column_in_mask (COLUMNPROPERTY (OBJECT_ID ('CMS_UserSite') , 'UserPreferredCurrencyID', 'columnid') , CTE.sys_change_columns) AS [UserPreferredCurrencyID_cg] 
  , SVR
  , DBNAME
  , LastModifiedDate
    INTO
    ##HealthAssessmentData
           FROM BASE_HFIT_HEALTHASSESMENTUSERSTARTED AS HAUSERSTARTED
                    INNER JOIN BASE_CMS_USER AS CMSUSER
                        ON HAUSERSTARTED.USERID = CMSUSER.USERID
                       AND HAUSERSTARTED.SVR = CMSUSER.SVR
                       AND HAUSERSTARTED.DBNAME = CMSUSER.DBNAME
                    INNER JOIN BASE_CMS_USERSETTINGS AS USERSETTINGS
                        ON USERSETTINGS.USERSETTINGSUSERID = CMSUSER.USERID
                       AND HFITUSERMPINUMBER >= 0
                       AND HFITUSERMPINUMBER IS NOT NULL
                       AND USERSETTINGS.SVR = CMSUSER.SVR
                       AND USERSETTINGS.DBNAME = CMSUSER.DBNAME
                    INNER JOIN BASE_CMS_USERSITE AS USERSITE
                        ON CMSUSER.USERID = USERSITE.USERID
                       AND CMSUSER.SVR = USERSITE.SVR
                       AND CMSUSER.DBNAME = USERSITE.DBNAME
                    INNER JOIN DBO.BASE_CMS_SITE AS CMSSITE
                        ON USERSITE.SITEID = CMSSITE.SITEID
                       AND USERSITE.SVR = CMSSITE.SVR
                       AND USERSITE.DBNAME = CMSSITE.DBNAME
                    INNER JOIN DBO.BASE_HFIT_ACCOUNT AS ACCT
                        ON ACCT.SITEID = CMSSITE.SITEID
                       AND ACCT.SVR = CMSSITE.SVR
                       AND ACCT.DBNAME = CMSSITE.DBNAME
                    INNER JOIN BASE_HFIT_HEALTHASSESMENTUSERMODULE AS HAUSERMODULE
                        ON HAUSERSTARTED.ITEMID = HAUSERMODULE.HASTARTEDITEMID
                       AND HAUSERSTARTED.SVR = HAUSERMODULE.SVR
                       AND HAUSERSTARTED.DBNAME = HAUSERMODULE.DBNAME
                    INNER JOIN FACT_VIEW_HFIT_HACAMPAIGN_JOINED AS VHCJ
                        ON VHCJ.NODEGUID = HAUSERSTARTED.HACAMPAIGNNODEGUID
                       AND VHCJ.NODESITEID = USERSITE.SITEID
                       AND VHCJ.DOCUMENTCULTURE = 'en-US'
                       AND VHCJ.SVR = USERSITE.SVR
                       AND VHCJ.DBNAME = USERSITE.DBNAME
                    INNER JOIN FACT_VIEW_HFIT_HEALTHASSESSMENT_JOINED AS VHAJ
                        ON VHAJ.DOCUMENTID = VHCJ.HEALTHASSESSMENTID
                       AND VHAJ.SVR = VHCJ.SVR
                       AND VHAJ.DBNAME = VHCJ.DBNAME
                    INNER JOIN BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY
                        ON HAUSERMODULE.ITEMID = HARISKCATEGORY.HAMODULEITEMID
                       AND HAUSERMODULE.SVR = HARISKCATEGORY.SVR
                       AND HAUSERMODULE.DBNAME = HARISKCATEGORY.DBNAME
                    INNER JOIN BASE_HFIT_HEALTHASSESMENTUSERRISKAREA AS HAUSERRISKAREA
                        ON HARISKCATEGORY.ITEMID = HAUSERRISKAREA.HARISKCATEGORYITEMID
                       AND HARISKCATEGORY.SVR = HAUSERRISKAREA.SVR
                       AND HARISKCATEGORY.DBNAME = HAUSERRISKAREA.DBNAME
                    INNER JOIN BASE_HFit_HealthAssesmentUserQuestion AS HAUSERQUESTION
                        ON HAUSERRISKAREA.ITEMID = HAUSERQUESTION.HARISKAREAITEMID
                       AND HAUSERRISKAREA.SVR = HAUSERQUESTION.SVR
                       AND HAUSERRISKAREA.DBNAME = HAUSERQUESTION.DBNAME
                    INNER JOIN FACT_VIEW_EDW_HEALTHASSESMENTQUESTIONS AS HAQUESTIONSVIEW
                        ON HAUSERQUESTION.HAQUESTIONNODEGUID = HAQUESTIONSVIEW.NODEGUID
                       AND HAUSERQUESTION.SVR = HAQUESTIONSVIEW.SVR
                       AND HAUSERQUESTION.DBNAME = HAQUESTIONSVIEW.DBNAME
                    LEFT OUTER JOIN BASE_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUSERQUESTIONGROUPRESULTS
                        ON HAUSERRISKAREA.ITEMID = HAUSERQUESTIONGROUPRESULTS.HARISKAREAITEMID
                       AND HAUSERRISKAREA.SVR = HAUSERQUESTIONGROUPRESULTS.SVR
                       AND HAUSERRISKAREA.DBNAME = HAUSERQUESTIONGROUPRESULTS.DBNAME
                    INNER JOIN BASE_HFit_HEALTHASSESMENTUSERANSWERS AS HAUSERANSWERS
                        ON HAUSERQUESTION.ITEMID = HAUSERANSWERS.HAQUESTIONITEMID
                       AND HAUSERQUESTION.SVR = HAUSERANSWERS.SVR
                       AND HAUSERQUESTION.DBNAME = HAUSERANSWERS.DBNAME 
/*				
Add in the change tracking data
*/
                    LEFT JOIN CHANGETABLE (CHANGES BASE_CMS_USERSETTINGS, NULL) AS CT_CMS_USERSETTINGS
                        ON USERSETTINGS.USERSETTINGSID = CT_CMS_USERSETTINGS.USERSETTINGSID
                       AND USERSETTINGS.SVR = CT_CMS_USERSETTINGS.SVR
                       AND USERSETTINGS.DBNAME = CT_CMS_USERSETTINGS.DBNAME
                    LEFT JOIN CHANGETABLE (CHANGES BASE_CMS_USER, NULL) AS CT_CMS_USER
                        ON CMSUSER.USERID = CT_CMS_USER.USERID
                       AND CMSUSER.SVR = CT_CMS_USER.SVR
                       AND CMSUSER.DBNAME = CT_CMS_USER.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_SITE, NULL) AS CT_CMS_SITE
                        ON CMSSITE.SITEID = CT_CMS_SITE.SITEID
                       AND CMSSITE.SVR = CT_CMS_SITE.SVR
                       AND CMSSITE.DBNAME = CT_CMS_SITE.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_CMS_USERSITE, NULL) AS CT_CMS_USERSITE
                        ON USERSITE.USERSITEID = CT_CMS_USERSITE.USERSITEID
                       AND USERSITE.SVR = CT_CMS_USERSITE.SVR
                       AND USERSITE.DBNAME = CT_CMS_USERSITE.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_ACCOUNT, NULL) AS CT_HFIT_ACCOUNT
                        ON ACCT.ACCOUNTID = CT_HFIT_ACCOUNT.ACCOUNTID
                       AND ACCT.SVR = CT_HFIT_ACCOUNT.SVR
                       AND ACCT.DBNAME = CT_HFIT_ACCOUNT.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HACAMPAIGN, NULL) AS CT_HFIT_HACAMPAIGN
                        ON VHCJ.HACAMPAIGNID = CT_HFIT_HACAMPAIGN.HACAMPAIGNID
                       AND VHCJ.SVR = CT_HFIT_HACAMPAIGN.SVR
                       AND VHCJ.DBNAME = CT_HFIT_HACAMPAIGN.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERANSWERS, NULL) AS CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS
                        ON HAUSERANSWERS.ITEMID = CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.ITEMID
                       AND HAUSERANSWERS.SVR = CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.SVR
                       AND HAUSERANSWERS.DBNAME = CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERMODULE, NULL) AS CT_HFIT_HEALTHASSESMENTUSERMODULE
                        ON HAUSERMODULE.ITEMID = CT_HFIT_HEALTHASSESMENTUSERMODULE.ITEMID
                       AND HAUSERMODULE.SVR = CT_HFIT_HEALTHASSESMENTUSERMODULE.SVR
                       AND HAUSERMODULE.DBNAME = CT_HFIT_HEALTHASSESMENTUSERMODULE.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTION, NULL) AS CT_HFIT_HEALTHASSESMENTUSERQUESTION
                        ON HAUSERQUESTION.ITEMID = CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID
                       AND HAUSERQUESTION.SVR = CT_HFIT_HEALTHASSESMENTUSERQUESTION.SVR
                       AND HAUSERQUESTION.DBNAME = CT_HFIT_HEALTHASSESMENTUSERQUESTION.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS, NULL) AS CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS
                        ON HAUSERQUESTIONGROUPRESULTS.ITEMID = CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.ITEMID
                       AND HAUSERQUESTIONGROUPRESULTS.SVR = CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.SVR
                       AND HAUSERQUESTIONGROUPRESULTS.DBNAME = CT_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKAREA, NULL) AS CT_HFIT_HEALTHASSESMENTUSERRISKAREA
                        ON HAUSERRISKAREA.ITEMID = CT_HFIT_HEALTHASSESMENTUSERRISKAREA.ITEMID
                       AND HAUSERRISKAREA.SVR = CT_HFIT_HEALTHASSESMENTUSERRISKAREA.SVR
                       AND HAUSERRISKAREA.DBNAME = CT_HFIT_HEALTHASSESMENTUSERRISKAREA.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERRISKCATEGORY, NULL) AS CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY
                        ON HARISKCATEGORY.ITEMID = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ITEMID
                       AND HARISKCATEGORY.SVR = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SVR
                       AND HARISKCATEGORY.DBNAME = CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.DBNAME
                    LEFT OUTER JOIN CHANGETABLE (CHANGES BASE_HFIT_HEALTHASSESMENTUSERSTARTED, NULL) AS CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED
                        ON HAUSERSTARTED.ITEMID = CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.ITEMID
                       AND HAUSERSTARTED.SVR = CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.SVR
                       AND HAUSERSTARTED.DBNAME = CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED.DBNAME
           WHERE USERSETTINGS.HFITUSERMPINUMBER NOT IN (
        SELECT
        REJECTMPICODE
               FROM BASE_HFIT_LKP_EDW_REJECTMPI);

    DECLARE
    @Recs AS INT = @@Rowcount;

    SET @Recs = (SELECT
                 COUNT (*) 
                        FROM ##HealthAssessmentData);

    PRINT 'Temp HA Data Loaded: ';
    PRINT GETDATE () ;
    PRINT 'HA Data Load Seconds: ' + CAST ( DATEDIFF ( SECOND , @StPullTime , GETDATE ()) AS NVARCHAR (50)) ;
    PRINT CHAR ( 10) ;

    DECLARE
    @StTxPullTime AS DATETIME = GETDATE () ;

    PRINT '##HealthAssessmentData rows: ' + CAST (@Recs AS NVARCHAR (50)) ;

    IF @ReloadAll = 1
        BEGIN
            DECLARE
            @StartReload AS DATETIME = GETDATE () ;
            truncate TABLE FACT_MART_EDW_HealthAssesment;
            INSERT INTO FACT_MART_EDW_HealthAssesment
            (
            UserStartedItemID
          , HealthAssesmentUserStartedNodeGUID
          , UserID
          , UserGUID
          , HFitUserMpiNumber
          , SiteGUID
          , AccountID
          , AccountCD
          , AccountName
          , HAStartedDt
          , HACompletedDt
          , UserModuleItemId
          , UserModuleCodeName
          , HAModuleNodeGUID
          , CMSNodeGuid
          , HAModuleVersionID
          , UserRiskCategoryItemID
          , UserRiskCategoryCodeName
          , HARiskCategoryNodeGUID
          , HARiskCategoryVersionID
          , UserRiskAreaItemID
          , UserRiskAreaCodeName
          , HARiskAreaNodeGUID
          , HARiskAreaVersionID
          , UserQuestionItemID
          , Title
          , HAQuestionGuid
          , UserQuestionCodeName
          , HAQuestionDocumentID
          , HAQuestionVersionID
          , HAQuestionNodeGUID
          , UserAnswerItemID
          , HAAnswerNodeGUID
          , HAAnswerVersionID
          , UserAnswerCodeName
          , HAAnswerValue
          , HAModuleScore
          , HARiskCategoryScore
          , HARiskAreaScore
          , HAQuestionScore
          , HAAnswerPoints
          , PointResults
          , UOMCode
          , HAScore
          , ModulePreWeightedScore
          , RiskCategoryPreWeightedScore
          , RiskAreaPreWeightedScore
          , QuestionPreWeightedScore
          , QuestionGroupCodeName
          , ItemCreatedWhen
          , ItemModifiedWhen
          , IsProfessionallyCollected
          , HARiskCategory_ItemModifiedWhen
          , HAUserRiskArea_ItemModifiedWhen
          , HAUserQuestion_ItemModifiedWhen
          , HAUserAnswers_ItemModifiedWhen
          , HAPaperFlg
          , HATelephonicFlg
          , HAStartedMode
          , HACompletedMode
          , DocumentCulture_VHCJ
          , DocumentCulture_HAQuestionsView
          , CampaignNodeGUID
          , HACampaignID
          , HashCode
          , ChangeType
          , CHANGED_FLG
          , DeleteFlg
          , CT_CMS_User_UserID
          , CT_CMS_User_CHANGE_OPERATION
          , CT_UserSettingsID
          , CT_UserSettingsID_CHANGE_OPERATION
          , SiteID_CtID
          , SiteID_CHANGE_OPERATION
          , UserSiteID_CtID
          , UserSiteID_CHANGE_OPERATION
          , AccountID_CtID
          , AccountID__CHANGE_OPERATION
          , HAUserAnswers_CtID
          , HAUserAnswers_CHANGE_OPERATION
          , HFit_HealthAssesmentUserModule_CtID
          , HFit_HealthAssesmentUserModule_CHANGE_OPERATION
          , HFit_HealthAssesmentUserQuestion_CtID
          , HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
          , HFit_HealthAssesmentUserQuestionGroupResults_CtID
          , HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
          , HFit_HealthAssesmentUserRiskArea_CtID
          , HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
          , HFit_HealthAssesmentUserRiskCategory_CtID
          , HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
          , BASE_HFIT_HEALTHASSESMENTUSERSTARTED_CtID
          , BASE_HFIT_HEALTHASSESMENTUSERSTARTED_CHANGE_OPERATION
          , CT_CMS_User_SCV
          , CT_CMS_UserSettings_SCV
          , CT_CMS_Site_SCV
          , CT_CMS_UserSite_SCV
          , CT_HFit_Account_SCV
          , CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS_SCV
          , CT_HFit_HealthAssesmentUserModule_SCV
          , CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
          , CT_HFit_HealthAssesmentUserRiskArea_SCV
          , CT_HFit_HealthAssesmentUserRiskCategory_SCV
          , CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED_SCV
          , CT_HFit_HealthAssesmentUserQuestion_SCV
          , ConvertedToCentralTime
          , LastModifiedDate
          , RowNbr
          , DeletedFlg
          , TimeZone
          , PKHashCode
          , SVR
          , DBNAME) 
            SELECT
            UserStartedItemID
          , HealthAssesmentUserStartedNodeGUID
          , UserID
          , UserGUID
          , HFitUserMpiNumber
          , SiteGUID
          , AccountID
          , AccountCD
          , AccountName
          , HAStartedDt
          , HACompletedDt
          , UserModuleItemId
          , UserModuleCodeName
          , HAModuleNodeGUID
          , CMSNodeGuid
          , HAModuleVersionID
          , UserRiskCategoryItemID
          , UserRiskCategoryCodeName
          , HARiskCategoryNodeGUID
          , HARiskCategoryVersionID
          , UserRiskAreaItemID
          , UserRiskAreaCodeName
          , HARiskAreaNodeGUID
          , HARiskAreaVersionID
          , UserQuestionItemID
          , Title
          , HAQuestionGuid
          , UserQuestionCodeName
          , HAQuestionDocumentID
          , HAQuestionVersionID
          , HAQuestionNodeGUID
          , UserAnswerItemID
          , HAAnswerNodeGUID
          , HAAnswerVersionID
          , UserAnswerCodeName
          , HAAnswerValue
          , HAModuleScore
          , HARiskCategoryScore
          , HARiskAreaScore
          , HAQuestionScore
          , HAAnswerPoints
          , PointResults
          , UOMCode
          , HAScore
          , ModulePreWeightedScore
          , RiskCategoryPreWeightedScore
          , RiskAreaPreWeightedScore
          , QuestionPreWeightedScore
          , QuestionGroupCodeName
          , ItemCreatedWhen
          , ItemModifiedWhen
          , IsProfessionallyCollected
          , HARiskCategory_ItemModifiedWhen
          , HAUserRiskArea_ItemModifiedWhen
          , HAUserQuestion_ItemModifiedWhen
          , HAUserAnswers_ItemModifiedWhen
          , HAPaperFlg
          , HATelephonicFlg
          , HAStartedMode
          , HACompletedMode
          , DocumentCulture_VHCJ
          , DocumentCulture_HAQuestionsView
          , CampaignNodeGUID
          , HACampaignID
          , HashCode
          , ChangeType
          , CHANGED_FLG
          , DeleteFlg
          , CT_CMS_User_UserID
          , CT_CMS_User_CHANGE_OPERATION
          , CT_UserSettingsID
          , CT_UserSettingsID_CHANGE_OPERATION
          , SiteID_CtID
          , SiteID_CHANGE_OPERATION
          , UserSiteID_CtID
          , UserSiteID_CHANGE_OPERATION
          , AccountID_CtID
          , AccountID__CHANGE_OPERATION
          , HAUserAnswers_CtID
          , HAUserAnswers_CHANGE_OPERATION
          , HFit_HealthAssesmentUserModule_CtID
          , HFit_HealthAssesmentUserModule_CHANGE_OPERATION
          , HFit_HealthAssesmentUserQuestion_CtID
          , HFit_HealthAssesmentUserQuestion_CHANGE_OPERATION
          , HFit_HealthAssesmentUserQuestionGroupResults_CtID
          , HFit_HealthAssesmentUserQuestionGroupResults_CHANGE_OPERATION
          , HFit_HealthAssesmentUserRiskArea_CtID
          , HFit_HealthAssesmentUserRiskArea_CHANGE_OPERATION
          , HFit_HealthAssesmentUserRiskCategory_CtID
          , HFit_HealthAssesmentUserRiskCategory_CHANGE_OPERATION
          , BASE_HFIT_HEALTHASSESMENTUSERSTARTED_CtID
          , BASE_HFIT_HEALTHASSESMENTUSERSTARTED_CHANGE_OPERATION
          , CT_CMS_User_SCV
          , CT_CMS_UserSettings_SCV
          , CT_CMS_Site_SCV
          , CT_CMS_UserSite_SCV
          , CT_HFit_Account_SCV
          , CT_BASE_HFIT_HEALTHASSESMENTUSERANSWERS_SCV
          , CT_HFit_HealthAssesmentUserModule_SCV
          , CT_HFit_HealthAssesmentUserQuestionGroupResults_SCV
          , CT_HFit_HealthAssesmentUserRiskArea_SCV
          , CT_HFit_HealthAssesmentUserRiskCategory_SCV
          , CT_BASE_HFIT_HEALTHASSESMENTUSERSTARTED_SCV
          , CT_HFit_HealthAssesmentUserQuestion_SCV
          , NULL AS ConvertedToCentralTime
          , NULL AS LastModifiedDate
          , NULL AS RowNbr
          , NULL AS DeletedFlg
          , NULL AS TimeZone
          , PKHashCode
          , SVR
          , DBNAME
                   FROM ##HealthAssessmentData;

            DECLARE
            @RecsALL AS INT = @@Rowcount;
            DECLARE
            @ReLoadSecs AS DECIMAL (10 , 2) = DATEDIFF (second , @StartReload , GETDATE ()) ;
            DECLARE
            @ReloadHrs AS DECIMAL (10 , 2) = @ReLoadSecs / 60;
            PRINT 'RELOAD ALL SELECTED - ' + CAST (@RecsALL AS NVARCHAR (50)) + ' records moved into FACT_MART_EDW_HealthAssesment in' + CAST (@ReloadHrs AS NVARCHAR (50)) + ' hours.';
        END;

    DECLARE
    @Loadtimeha AS DECIMAL (10 , 2) = 0;
    DECLARE
    @Secs AS DECIMAL (10 , 2) = 0;
    SET @Secs = DATEDIFF ( SECOND , @Stdataload , GETDATE ()) ;
    SET @Loadtimeha = @Secs / 60 / 60;
    PRINT 'HA DAta Loaded: ';
    PRINT CHAR ( 10) ;
    PRINT GETDATE () ;
    PRINT CHAR ( 10) ;
    PRINT 'Total Records Loaded : ' + CAST ( @Recs AS NVARCHAR (50)) ;
    PRINT CHAR ( 10) ;
    PRINT 'Time in Hours to load TEMP TABLE: ' + CAST ( @Loadtimeha AS NVARCHAR (50)) ;
    PRINT CHAR ( 10) ;
    DECLARE
    @StIndexing AS DATETIME = GETDATE () ;
    IF NOT EXISTS ( SELECT
                    NAME
                           FROM SYS.INDEXES
                           WHERE NAME = 'temp_PI_EDW_HealthAssessment_ChangeType') 
        BEGIN
            CREATE INDEX temp_PI_EDW_HealthAssessment_ChangeType ON ##HealthAssessmentData ( CHANGETYPE) 
            WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
            ALLOW_ROW_LOCKS = ON ,
            ALLOW_PAGE_LOCKS = ON) ;
        END;
    IF NOT EXISTS ( SELECT
                    NAME
                           FROM SYS.INDEXES
                           WHERE NAME = 'temp_PI_EDW_HealthAssessment_NATKEY') 
        BEGIN
            CREATE INDEX TEMP_PI_EDW_HealthAssessment_NATKEY ON DBO.##HealthAssessmentData ( USERSTARTEDITEMID , USERGUID , PKHASHCODE , HASHCODE , LastModifiedDATE) ;
        END;
    DECLARE
    @IdxTimeHrs AS DECIMAL (10 , 2) = 0;
    DECLARE
    @Idxsecs AS DECIMAL (10 , 2) = 0;
    SET @Idxsecs = DATEDIFF ( SECOND , @StIndexing , GETDATE ()) ;
    SET @IdxTimeHrs = @Secs / 60 / 60;
    PRINT 'Indexes Created: ';
    PRINT CHAR ( 10) ;
    PRINT GETDATE () ;
    PRINT CHAR ( 10) ;
    PRINT 'Index Time in Hours : ' + CAST ( @IdxTimeHrs AS NVARCHAR (50)) ;
    PRINT CHAR ( 10) ;
    DECLARE
    @Et AS DATETIME = GETDATE () ;
    DECLARE
    @T AS DECIMAL (10 , 2) = DATEDIFF ( minute , @St , @Et) 
  , @H AS DECIMAL (10 , 2) = 0;
    SET @H = @T / 60;
    PRINT 'Process Started:';
    PRINT CHAR ( 10) ;
    PRINT @St;
    PRINT CHAR ( 10) ;
    PRINT 'Process Ended:';
    PRINT CHAR ( 10) ;
    PRINT @Et;
    PRINT CHAR ( 10) ;
    PRINT CHAR ( 10) ;
    PRINT 'TOTAL ROWS: ' + CAST ( @Recs AS NVARCHAR (50)) ;
    PRINT CHAR ( 10) ;
    PRINT 'TOTAL Hours: ' + CAST ( @H AS NVARCHAR (50)) ;
    RETURN @recs;
END;
GO
PRINT 'Created proc_Denormalize_EDW_HealthAssessment_VIEWS.sql';
GO
