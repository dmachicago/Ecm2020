
GO
PRINT 'Executing proc_CT_HA_AddNewRecs.sql';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_CT_HA_AddNewRecs') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HA_AddNewRecs;
    END;
GO
-- exec proc_CT_HA_AddNewRecs
CREATE PROCEDURE proc_CT_HA_AddNewRecs
AS
BEGIN

    WITH CTE_NEW (
         UserStartedItemID
       , UserGUID
       , PKHashCode
    ) 
        AS (
        SELECT
               UserStartedItemID
             , UserGUID
             , PKHashCode
               FROM ##HealthAssessmentData
        EXCEPT
        SELECT
               UserStartedItemID
             , UserGUID
             , PKHashCode
               FROM FACT_MART_EDW_HealthAssesment
               WHERE LastModifiedDate IS NULL
        ) 

        INSERT INTO FACT_MART_EDW_HealthAssesment
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
             , LastModifiedDATE
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
               --,[LASTUPDATEID]
             , DELETEFLG
             , SVR
             , DBNAME
             , DELETEDFLG
		   , ChangeType
        ) 
        SELECT
               T.UserStartedITEMID
             , T.HEALTHASSESMENTUserStartedNODEGUID
             , T.USERID
             , T.USERGUID
             , T.HFITUSERMPINUMBER
             , T.SITEGUID
             , T.ACCOUNTID
             , T.ACCOUNTCD
             , T.ACCOUNTNAME
             , T.HASTARTEDDT
             , T.HACOMPLETEDDT
             , T.USERMODULEITEMID
             , T.USERMODULECODENAME
             , T.HAMODULENODEGUID
             , T.CMSNODEGUID
             , T.HAMODULEVERSIONID
             , T.USERRISKCATEGORYITEMID
             , T.USERRISKCATEGORYCODENAME
             , T.HARISKCATEGORYNODEGUID
             , T.HARISKCATEGORYVERSIONID
             , T.USERRISKAREAITEMID
             , T.USERRISKAREACODENAME
             , T.HARISKAREANODEGUID
             , T.HARISKAREAVERSIONID
             , T.USERQUESTIONITEMID
             , T.TITLE
             , T.HAQUESTIONGUID
             , T.USERQUESTIONCODENAME
             , T.HAQUESTIONDOCUMENTID
             , T.HAQUESTIONVERSIONID
             , T.HAQUESTIONNODEGUID
             , T.USERANSWERITEMID
             , T.HAANSWERNODEGUID
             , T.HAANSWERVERSIONID
             , T.USERANSWERCODENAME
             , T.HAANSWERVALUE
             , T.HAMODULESCORE
             , T.HARISKCATEGORYSCORE
             , T.HARISKAREASCORE
             , T.HAQUESTIONSCORE
             , T.HAANSWERPOINTS
             , T.POINTRESULTS
             , T.UOMCODE
             , T.HASCORE
             , T.MODULEPREWEIGHTEDSCORE
             , T.RISKCATEGORYPREWEIGHTEDSCORE
             , T.RISKAREAPREWEIGHTEDSCORE
             , T.QUESTIONPREWEIGHTEDSCORE
             , T.QUESTIONGROUPCODENAME
             , T.ITEMCREATEDWHEN
             , T.ITEMMODIFIEDWHEN
             , T.ISPROFESSIONALLYCOLLECTED
             , T.HARISKCATEGORY_ITEMMODIFIEDWHEN
             , T.HAUSERRISKAREA_ITEMMODIFIEDWHEN
             , T.HAUSERQUESTION_ITEMMODIFIEDWHEN
             , T.HAUSERANSWERS_ITEMMODIFIEDWHEN
             , T.HAPAPERFLG
             , T.HATELEPHONICFLG
             , T.HASTARTEDMODE
             , T.HACOMPLETEDMODE
             , T.DOCUMENTCULTURE_VHCJ
             , T.DOCUMENTCULTURE_HAQUESTIONSVIEW
             , T.CAMPAIGNNODEGUID
             , T.HACAMPAIGNID
             , T.HASHCODE
             , T.PKHASHCODE
             , T.CHANGED_FLG
             , T.LastModifiedDATE
             , T.HEALTHASSESSMENTTYPE
             , T.HAUserStarted_LASTMODIFIED
             , T.CMSUSER_LASTMODIFIED
             , T.USERSETTINGS_LASTMODIFIED
             , T.USERSITE_LASTMODIFIED
             , T.CMSSITE_LASTMODIFIED
             , T.ACCT_LASTMODIFIED
             , T.HAUSERMODULE_LASTMODIFIED
             , T.VHCJ_LASTMODIFIED
             , T.VHAJ_LASTMODIFIED
             , T.HARISKCATEGORY_LASTMODIFIED
             , T.HAUSERRISKAREA_LASTMODIFIED
             , T.HAUSERQUESTION_LASTMODIFIED
             , T.HAQUESTIONSVIEW_LASTMODIFIED
             , T.HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED
             , T.HAUSERANSWERS_LASTMODIFIED
             , T.HAUserStarted_LastUpdateID
             , T.CMSUSER_LastUpdateID
             , T.USERSETTINGS_LastUpdateID
             , T.USERSITE_LastUpdateID
             , T.ACCT_LastUpdateID
             , T.HAUSERMODULE_LastUpdateID
             , T.VHCJ_LastUpdateID
             , T.VHAJ_LastUpdateID
             , T.HARISKCATEGORY_LastUpdateID
             , T.HAUSERRISKAREA_LastUpdateID
             , T.HAUSERQUESTION_LastUpdateID
             , T.HAQUESTIONSVIEW_LastUpdateID
             , T.HAUSERQUESTIONGROUPRESULTS_LastUpdateID
             , T.HAUSERANSWERS_LastUpdateID
               --,T.[LASTUPDATEID]
             , T.DELETEFLG
             , T.SVR
             , T.DBNAME
             , T.DELETEDFLG
			 , 'I' as ChangeType
               FROM
                   ##HealthAssessmentData AS T
                       JOIN CTE_NEW AS C
                           ON C.UserStartedItemID = T.UserStartedItemID
                          AND C.UserGUID = T.UserGUID
                          AND C.PKHashCode = T.PKHashCode;

    DECLARE
    @iInserts AS int = @@ROWCOUNT;
    PRINT 'NEW Insert Count: ' + CAST ( @iInserts AS nvarchar (50)) ;
    RETURN @iInserts;
END;

GO
PRINT 'Executed proc_CT_HA_AddNewRecs.sql';
GO
