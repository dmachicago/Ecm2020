

GO
PRINT 'Executing view_EDW_PullHAData_NoCT_Deletes.sql';
GO
IF EXISTS ( SELECT
                   NAME
                   FROM SYS.VIEWS
                   WHERE
                   NAME = 'view_EDW_PullHAData_NoCT_Deletes') 
    BEGIN
        DROP VIEW
             DBO.view_EDW_PullHAData_NoCT_Deletes;
    END;
GO
/*---------------------------------------------------------------
select * from view_EDW_PullHAData_NoCT_Deletes
where
	   HAUserStarted_LastUpdateID > 0
        or  CMSUSER_LastUpdateID > 0
        or  USERSETTINGS_LastUpdateID > 0
        or  USERSITE_LastUpdateID > 0
        --or  CMSSITE_LastUpdateID > 0
        --or  ACCT_LastUpdateID > 0
        or  HAUSERMODULE_LastUpdateID > 0
        or  VHCJ_LastUpdateID > 0
        or  VHAJ_LastUpdateID > 0
        or  HARISKCATEGORY_LastUpdateID > 0
        or  HAUSERRISKAREA_LastUpdateID > 0
        or  HAUSERQUESTION_LastUpdateID > 0
        or  HAQUESTIONSVIEW_LastUpdateID > 0
        or  HAUSERQUESTIONGROUPRESULTS_LastUpdateID > 0
        or  HAUSERANSWERS_LastUpdateID > 0

select top 1000 * 
into #xxx
from view_EDW_PullHAData_NoCT_Deletes
where
        HAUserStarted_LASTMODIFIED > '2015-07-28'
        OR CMSUSER_LASTMODIFIED > '2015-07-28'
        OR USERSETTINGS_LASTMODIFIED > '2015-07-28'
        OR USERSITE_LASTMODIFIED > '2015-07-28'
        OR CMSSITE_LASTMODIFIED > '2015-07-28'
        OR ACCT_LASTMODIFIED > '2015-07-28'
        OR HAUSERMODULE_LASTMODIFIED > '2015-07-28'
        OR VHCJ_LASTMODIFIED > '2015-07-28'
        OR VHAJ_LASTMODIFIED > '2015-07-28'
        OR HARISKCATEGORY_LASTMODIFIED > '2015-07-28'
        OR HAUSERRISKAREA_LASTMODIFIED > '2015-07-28'
        OR HAUSERQUESTION_LASTMODIFIED > '2015-07-28'
        OR HAQUESTIONSVIEW_LASTMODIFIED > '2015-07-28'
        OR HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED > '2015-07-28'
        OR HAUSERANSWERS_LASTMODIFIED > '2015-07-28'
*/
CREATE VIEW view_EDW_PullHAData_NoCT_Deletes
    WITH SCHEMABINDING
AS SELECT
          HAUserStarted.ITEMID AS UserStartedITEMID
        , VHAJ.NODEGUID AS HEALTHASSESMENTUserStartedNODEGUID
        , HAUserStarted.USERID
        , CMSUSER.USERGUID
        , USERSETTINGS.HFITUSERMPINUMBER
        , CMSSITE.SITEGUID
        , ACCT.ACCOUNTID
        , ACCT.ACCOUNTCD
        , ACCT.ACCOUNTNAME
        , HAUserStarted.HASTARTEDDT
        , HAUserStarted.HACOMPLETEDDT
        , HAUSERMODULE.ITEMID AS USERMODULEITEMID
        , HAUSERMODULE.CODENAME AS USERMODULECODENAME
        , HAUSERMODULE.HAMODULENODEGUID
        , VHAJ.NODEGUID AS CMSNODEGUID
        , NULL AS HAMODULEVERSIONID
        , HARISKCATEGORY.ITEMID AS USERRISKCATEGORYITEMID
        , HARISKCATEGORY.CODENAME AS USERRISKCATEGORYCODENAME
        , HARISKCATEGORY.HARISKCATEGORYNODEGUID
        , NULL AS HARISKCATEGORYVERSIONID
        , HAUSERRISKAREA.ITEMID AS USERRISKAREAITEMID
        , HAUSERRISKAREA.CODENAME AS USERRISKAREACODENAME
        , HAUSERRISKAREA.HARISKAREANODEGUID
        , NULL AS HARISKAREAVERSIONID
        , HAUSERQUESTION.ITEMID AS USERQUESTIONITEMID
        , HAQUESTIONSVIEW.TITLE
        , HAUSERQUESTION.HAQUESTIONNODEGUID AS HAQUESTIONGUID
        , HAUSERQUESTION.CODENAME AS USERQUESTIONCODENAME
        , NULL AS HAQUESTIONDOCUMENTID
        , NULL AS HAQUESTIONVERSIONID
        , HAUSERQUESTION.HAQUESTIONNODEGUID
        , HAUSERANSWERS.ITEMID AS USERANSWERITEMID
        , HAUSERANSWERS.HAANSWERNODEGUID
        , NULL AS HAANSWERVERSIONID
        , HAUSERANSWERS.CODENAME AS USERANSWERCODENAME
        , HAUSERANSWERS.HAANSWERVALUE
        , HAUSERMODULE.HAMODULESCORE
        , HARISKCATEGORY.HARISKCATEGORYSCORE
        , HAUSERRISKAREA.HARISKAREASCORE
        , HAUSERQUESTION.HAQUESTIONSCORE
        , HAUSERANSWERS.HAANSWERPOINTS
        , HAUSERQUESTIONGROUPRESULTS.POINTRESULTS
        , HAUSERANSWERS.UOMCODE
        , HAUserStarted.HASCORE
        , HAUSERMODULE.PREWEIGHTEDSCORE AS MODULEPREWEIGHTEDSCORE
        , HARISKCATEGORY.PREWEIGHTEDSCORE AS RISKCATEGORYPREWEIGHTEDSCORE
        , HAUSERRISKAREA.PREWEIGHTEDSCORE AS RISKAREAPREWEIGHTEDSCORE
        , HAUSERQUESTION.PREWEIGHTEDSCORE AS QUESTIONPREWEIGHTEDSCORE
        , HAUSERQUESTIONGROUPRESULTS.CODENAME AS QUESTIONGROUPCODENAME

          --, COALESCE ( CT_CMS_USER.SYS_CHANGE_OPERATION , CT_CMS_USERSETTINGS.SYS_CHANGE_OPERATION , CT_CMS_SITE.SYS_CHANGE_OPERATION , CT_CMS_USERSITE.SYS_CHANGE_OPERATION , CT_HFIT_ACCOUNT.SYS_CHANGE_OPERATION , CT_HFIT_HealthAssesmentUserAnswers.SYS_CHANGE_OPERATION , CT_HFIT_HEALTHASSESMENTUSERMODULE.SYS_CHANGE_OPERATION , CT_HFIT_HEALTHASSESMENTUSERQUESTION.SYS_CHANGE_OPERATION , CT_HFIT_HealthAssesmentUserQuestionGroupResults.SYS_CHANGE_OPERATION , CT_HFIT_HEALTHASSESMENTUSERRISKAREA.SYS_CHANGE_OPERATION , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.SYS_CHANGE_OPERATION , CT_HFIT_HEALTHASSESMENTUserStarted.SYS_CHANGE_OPERATION) AS CHANGETYPE

        , HAUSERANSWERS.ITEMCREATEDWHEN
        , HAUSERANSWERS.ITEMMODIFIEDWHEN
        , HAUSERQUESTION.ISPROFESSIONALLYCOLLECTED
        , HARISKCATEGORY.ITEMMODIFIEDWHEN AS HARISKCATEGORY_ITEMMODIFIEDWHEN
        , HAUSERRISKAREA.ITEMMODIFIEDWHEN AS HAUSERRISKAREA_ITEMMODIFIEDWHEN
        , HAUSERQUESTION.ITEMMODIFIEDWHEN AS HAUSERQUESTION_ITEMMODIFIEDWHEN
        , HAUSERANSWERS.ITEMMODIFIEDWHEN AS HAUSERANSWERS_ITEMMODIFIEDWHEN
        , HAUserStarted.HAPAPERFLG
        , HAUserStarted.HATELEPHONICFLG
        , HAUserStarted.HASTARTEDMODE
        , HAUserStarted.HACOMPLETEDMODE
        , VHCJ.DOCUMENTCULTURE AS DOCUMENTCULTURE_VHCJ
        , HAQUESTIONSVIEW.DOCUMENTCULTURE AS DOCUMENTCULTURE_HAQUESTIONSVIEW
        , HAUserStarted.HACAMPAIGNNODEGUID AS CAMPAIGNNODEGUID
        , VHCJ.HACAMPAIGNID
        , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUserStarted.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.USERID AS nvarchar (100)) , '-') + ISNULL ( CAST ( CMSUSER.USERGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( USERSETTINGS.HFITUSERMPINUMBER AS nvarchar (100)) , '-') + ISNULL ( CAST ( CMSSITE.SITEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTCD AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTNAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HASTARTEDDT AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HACOMPLETEDDT AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULENODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREANODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS nvarchar (100)) , '-') + ISNULL ( LEFT ( HAQUESTIONSVIEW.TITLE , 1000) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERVALUE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULESCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREASCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERPOINTS AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTIONGROUPRESULTS.POINTRESULTS AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.UOMCODE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HASCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTIONGROUPRESULTS.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMCREATEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ISPROFESSIONALLYCOLLECTED AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HAPAPERFLG AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HATELEPHONICFLG AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HASTARTEDMODE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HACOMPLETEDMODE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUserStarted.HACAMPAIGNNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHCJ.HACAMPAIGNID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-')) AS varchar (100)) AS HASHCODE
        , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUserStarted.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( CMSUSER.USERGUID AS varchar (50)) , '-') + ISNULL ( CAST ( CMSSITE.SITEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS varchar (50)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTCD AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERMODULE.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULENODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS varchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREANODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.CODENAME AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUserStarted.HACAMPAIGNNODEGUID AS varchar (50)) , '-')) AS varchar (100)) AS PKHASHCODE

          --, COALESCE ( CT_CMS_USER.USERID , CT_CMS_USERSETTINGS.USERSETTINGSID , CT_CMS_SITE.SITEID , CT_CMS_USERSITE.USERSITEID , CT_HFIT_ACCOUNT.ACCOUNTID , CT_HFIT_HealthAssesmentUserAnswers.ITEMID , CT_HFIT_HEALTHASSESMENTUSERMODULE.ITEMID , CT_HFIT_HEALTHASSESMENTUSERQUESTION.ITEMID , CT_HFIT_HealthAssesmentUserQuestionGroupResults.ITEMID , CT_HFIT_HEALTHASSESMENTUSERRISKAREA.ITEMID , CT_HFIT_HEALTHASSESMENTUSERRISKCATEGORY.ITEMID , CT_HFIT_HEALTHASSESMENTUserStarted.ITEMID) AS CHANGED_FLG

        , NULL AS CHANGED_FLG
        , HAUSERANSWERS.ITEMMODIFIEDWHEN AS LASTMODIFIEDDATE
        , CASE
              WHEN HAUserStarted.HADOCUMENTCONFIGID IS NULL
                  THEN 'SHORT_VER'
              WHEN HAUserStarted.HADOCUMENTCONFIGID IS NOT NULL
                  THEN 'LONG_VER'
              ELSE 'UNKNOWN'
          END AS HEALTHASSESSMENTTYPE

        , HAUserStarted.LASTLOADEDDATE AS HAUserStarted_LASTMODIFIED
        , CMSUSER.LASTLOADEDDATE AS CMSUSER_LASTMODIFIED
        , USERSETTINGS.LASTLOADEDDATE AS USERSETTINGS_LASTMODIFIED
        , USERSITE.LASTLOADEDDATE AS USERSITE_LASTMODIFIED
        , CMSSITE.SITELASTMODIFIED AS CMSSITE_LASTMODIFIED
        , ACCT.ITEMMODIFIEDWHEN AS ACCT_LASTMODIFIED
        , HAUSERMODULE.LASTLOADEDDATE AS HAUSERMODULE_LASTMODIFIED
        , VHCJ.LASTLOADEDDATE AS VHCJ_LASTMODIFIED
        , VHAJ.LASTLOADEDDATE AS VHAJ_LASTMODIFIED
        , HARISKCATEGORY.LASTLOADEDDATE AS HARISKCATEGORY_LASTMODIFIED
        , HAUSERRISKAREA.LASTLOADEDDATE AS HAUSERRISKAREA_LASTMODIFIED
        , HAUSERQUESTION.LASTLOADEDDATE AS HAUSERQUESTION_LASTMODIFIED
        , HAQUESTIONSVIEW.LASTLOADEDDATE AS HAQUESTIONSVIEW_LASTMODIFIED
        , HAUSERQUESTIONGROUPRESULTS.LASTLOADEDDATE AS HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED
        , HAUSERANSWERS.LASTLOADEDDATE AS HAUSERANSWERS_LASTMODIFIED

        , HAUserStarted.LastUpdateID AS HAUserStarted_LastUpdateID
        , CMSUSER.LastUpdateID AS CMSUSER_LastUpdateID
        , USERSETTINGS.LastUpdateID AS USERSETTINGS_LastUpdateID
        , USERSITE.LastUpdateID AS USERSITE_LastUpdateID
          --, CMSSITE.LastUpdateID AS CMSSITE_LastUpdateID
        , ACCT.ItemModifiedWhen AS ACCT_LastUpdateID
        , HAUSERMODULE.LastUpdateID AS HAUSERMODULE_LastUpdateID
        , VHCJ.LastUpdateID AS VHCJ_LastUpdateID
        , VHAJ.LastUpdateID AS VHAJ_LastUpdateID
        , HARISKCATEGORY.LastUpdateID AS HARISKCATEGORY_LastUpdateID
        , HAUSERRISKAREA.LastUpdateID AS HAUSERRISKAREA_LastUpdateID
        , HAUSERQUESTION.LastUpdateID AS HAUSERQUESTION_LastUpdateID
        , HAQUESTIONSVIEW.LastUpdateID AS HAQUESTIONSVIEW_LastUpdateID
        , HAUSERQUESTIONGROUPRESULTS.LastUpdateID AS HAUSERQUESTIONGROUPRESULTS_LastUpdateID
        , HAUSERANSWERS.LastUpdateID AS HAUSERANSWERS_LastUpdateID

        , 0 AS LASTUPDATEID
        , 0 AS DELETEFLG
        , @@Servername AS SVR
        , DB_NAME () AS DBNAME
        , 0 AS DELETEDFLG
        , NULL AS ChangeType
          FROM
              DBO.STAGED_EDW_HFIT_HEALTHASSESMENTUserStarted AS HAUserStarted
                  INNER JOIN DBO.STAGED_EDW_CMS_USER AS CMSUSER
                      ON HAUserStarted.USERID = CMSUSER.USERID
                  INNER JOIN DBO.STAGED_EDW_CMS_USERSETTINGS AS USERSETTINGS
                      ON USERSETTINGS.USERSETTINGSUSERID = CMSUSER.USERID
                     AND USERSETTINGS.HFITUSERMPINUMBER >= 0
                     AND USERSETTINGS.HFITUSERMPINUMBER IS NOT NULL
                  INNER JOIN DBO.STAGED_EDW_CMS_USERSITE AS USERSITE
                      ON CMSUSER.USERID = USERSITE.USERID
                  INNER JOIN DBO.CMS_SITE AS CMSSITE
                      ON USERSITE.SITEID = CMSSITE.SITEID
                  INNER JOIN DBO.HFIT_ACCOUNT AS ACCT
                      ON ACCT.SITEID = CMSSITE.SITEID
                  INNER JOIN DBO.STAGED_EDW_HFIT_HEALTHASSESMENTUSERMODULE AS HAUSERMODULE
                      ON HAUserStarted.ITEMID = HAUSERMODULE.HASTARTEDITEMID
                  INNER JOIN DBO.STAGED_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED AS VHCJ
                      ON VHCJ.NODEGUID = HAUserStarted.HACAMPAIGNNODEGUID
                     AND VHCJ.NODESITEID = USERSITE.SITEID
                     AND VHCJ.DOCUMENTCULTURE = 'en-US'
                  INNER JOIN DBO.STAGED_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED AS VHAJ
                      ON VHAJ.DOCUMENTID = VHCJ.HEALTHASSESSMENTID
                  INNER JOIN DBO.STAGED_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY
                      ON HAUSERMODULE.ITEMID = HARISKCATEGORY.HAMODULEITEMID
                  INNER JOIN DBO.STAGED_EDW_HFIT_HEALTHASSESMENTUSERRISKAREA AS HAUSERRISKAREA
                      ON HARISKCATEGORY.ITEMID = HAUSERRISKAREA.HARISKCATEGORYITEMID
                  INNER JOIN DBO.STAGED_EDW_HFIT_HEALTHASSESMENTUSERQUESTION AS HAUSERQUESTION
                      ON HAUSERRISKAREA.ITEMID = HAUSERQUESTION.HARISKAREAITEMID
                  INNER JOIN DBO.STAGED_EDW_VIEW_EDW_HEALTHASSESMENTQUESTIONS AS HAQUESTIONSVIEW
                      ON HAUSERQUESTION.HAQUESTIONNODEGUID = HAQUESTIONSVIEW.NODEGUID
                  LEFT JOIN DBO.STAGED_EDW_HFIT_HEALTHASSESMENTUSERQUESTIONGROUPRESULTS AS HAUSERQUESTIONGROUPRESULTS
                      ON HAUSERRISKAREA.ITEMID = HAUSERQUESTIONGROUPRESULTS.HARISKAREAITEMID
                  INNER JOIN DBO.STAGED_EDW_HFIT_HEALTHASSESMENTUSERANSWERS AS HAUSERANSWERS
                      ON HAUSERQUESTION.ITEMID = HAUSERANSWERS.HAQUESTIONITEMID
                  INNER JOIN dbo.STAGED_EDW_PkHashkey AS HKEY
                      ON HKEY.HAUSERSTARTED_ITEMID = HAUserStarted.ITEMID
                     AND HKEY.USERGUID = CMSUSER.USERGUID
                     AND HKEY.PKHASHCODE = PKHASHCODE
                     AND HKEY.ChangeType = 'I'
                     AND HKEY.ChangeDate > GETDATE () - 1
          WHERE USERSETTINGS.HFITUSERMPINUMBER NOT IN (
                SELECT
                       HFIT_LKP_EDW_REJECTMPI.REJECTMPICODE
                       FROM DBO.HFIT_LKP_EDW_REJECTMPI);
GO

--CREATE unique clustered INDEX [PI_view_EDW_PullHAData_IDX] ON [dbo].[view_EDW_PullHAData_NoCT_Deletes]
--(
--UserStartedITEMID
--, PkHashCode
--)
--GO
--CREATE unique clustered INDEX [PI_view_EDW_PullHAData_IDX_DATES] ON [dbo].[view_EDW_PullHAData_NoCT_Deletes]
--(
--HAUserStarted_LastModified
--, CMSUSER_LastModified
--, USERSETTINGS_LastModified
--, USERSITE_LastModified
--, CMSSITE_LastModified
--, ACCT_LastModified
--, HAUSERMODULE_LastModified
--, VHCJ_LastModified
--, VHAJ_LastModified
--, HARISKCATEGORY_LastModified
--, HAUSERRISKAREA_LastModified
--, HAUSERQUESTION_LastModified
--, HAQUESTIONSVIEW_LastModified
--, HAUSERQUESTIONGROUPRESULTS_LastModified
--, HAUSERANSWERS_LastModified
--)

GO
PRINT 'Executed view_EDW_PullHAData_NoCT_Deletes.sql';
GO