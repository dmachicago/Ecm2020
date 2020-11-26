
go
use KenticoCMS_DataMart

GO
PRINT 'Executing proc_EDW_Gen_Temp_PkHashKeys.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_EDW_Gen_Temp_PkHashKeys') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_Gen_Temp_PkHashKeys;
    END;

GO
--exec proc_EDW_Gen_Temp_PkHashKeys
CREATE PROCEDURE proc_EDW_Gen_Temp_PkHashKeys
AS
BEGIN
    DECLARE
    @CT AS DATETIME = GETDATE () ;
    DECLARE
    @ET AS DATETIME = GETDATE () ;
    DECLARE
    @ST AS DATETIME = GETDATE () ;
    DECLARE
    @ms AS FLOAT = 0;
    DECLARE
    @secs AS FLOAT = 0;
    DECLARE
    @mins AS FLOAT = 0;
    --***************************************************************************************************************
    IF NOT EXISTS ( SELECT
                           name
                           FROM tempdb.dbo.sysobjects
                           WHERE
                           id = OBJECT_ID ( N'tempdb..##FACT_EDW_PkHashkey')) 
        BEGIN
		  -- drop table ##FACT_EDW_PkHashkey
            PRINT 'Generating ##FACT_EDW_PkHashkey';
            EXEC proc_trace 'Temp_PkHashKeys: START Process MarkNewRecords - CREATE TABLE VAR' , @CT , NULL;
            CREATE TABLE dbo.##FACT_EDW_PkHashkey (
				 SVR NVARCHAR (100) NULL
				    ,DBNAME NVARCHAR (100) NULL
                       , HAUSERSTARTED_ITEMID INT NULL
                       , USERGUID UNIQUEIDENTIFIER NOT NULL
                       , HASHCODE NVARCHAR (100) NULL
                       , PKHASHCODE NVARCHAR (100) NULL
                       , RowNbr INT IDENTITY (1 , 1) 
                                    NOT NULL
                       , ChangeType NCHAR (1) NULL
                       , ChangeDate NCHAR (1) NULL
            );
            CREATE CLUSTERED INDEX PK_FACT_EDW_PkHashkey_TEMP ON dbo.##FACT_EDW_PkHashkey
            (SVR ASC, 
		  DBNAME ASC,
            HAUSERSTARTED_ITEMID ASC ,
            USERGUID ASC ,
            HASHCODE ASC ,
            PKHASHCODE ASC
            );
            INSERT INTO ##FACT_EDW_PkHashkey
            (
                 SVR, DBNAME,   HAUSERSTARTED_ITEMID
                 , USERGUID
                 , HASHCODE
                 , PKHASHCODE) 
            SELECT 
                 HAUSERSTARTED.SVR, HAUSERSTARTED.DBNAME,   HAUSERSTARTED.ITEMID AS HAUSERSTARTED_ITEMID
                 , USERGUID
                 , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUSERSTARTED.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.USERID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( CMSUSER.USERGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( USERSETTINGS.HFITUSERMPINUMBER AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( CMSSITE.SITEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTCD AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTNAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HASTARTEDDT AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACOMPLETEDDT AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULENODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREANODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( LEFT ( HAQUESTIONSVIEW.TITLE , 1000) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERVALUE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULESCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREASCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERPOINTS AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTIONGROUPRESULTS.POINTRESULTS AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.UOMCODE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HASCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.PREWEIGHTEDSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.PREWEIGHTEDSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.PREWEIGHTEDSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.PREWEIGHTEDSCORE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTIONGROUPRESULTS.CODENAME AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMCREATEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ISPROFESSIONALLYCOLLECTED AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HAPAPERFLG AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HATELEPHONICFLG AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HASTARTEDMODE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACOMPLETEDMODE AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACAMPAIGNNODEGUID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( VHCJ.HACAMPAIGNID AS NVARCHAR (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS NVARCHAR (100)) , '-')) AS VARCHAR (100)) AS HASHCODE
                 , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUSERSTARTED.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( USERGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( SITEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( ACCOUNTCD AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERMODULE.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAMODULENODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORYNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS VARCHAR (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HARISKAREANODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.CODENAME AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAQUESTIONNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAANSWERNODEGUID AS VARCHAR (50)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACAMPAIGNNODEGUID AS VARCHAR (50)) , '-')) AS VARCHAR (100)) AS PKHASHCODE

select count(*) 
                   FROM
            FACT_EDW_HFIT_HEALTHASSESMENTUSERSTARTED AS HAUSERSTARTED
                INNER JOIN FACT_EDW_CMS_USER AS CMSUSER
                    ON
                    HAUSERSTARTED.USERID = CMSUSER.USERID
				and HAUSERSTARTED.SVR = CMSUSER.SVR
				and HAUSERSTARTED.DBNAME = CMSUSER.DBNAME
                INNER JOIN FACT_EDW_CMS_USERSETTINGS AS USERSETTINGS
                    ON
                    USERSETTINGS.USERSETTINGSUSERID = CMSUSER.USERID
				and USERSETTINGS.SVR = CMSUSER.SVR
				and USERSETTINGS.DBNAME = CMSUSER.DBNAME
                AND HFITUSERMPINUMBER >= 0
                AND HFITUSERMPINUMBER IS NOT NULL
                INNER JOIN FACT_EDW_CMS_USERSITE AS USERSITE
                    ON
                    CMSUSER.USERID = USERSITE.USERID
								and USERSITE.SVR = CMSUSER.SVR
				and USERSITE.DBNAME = CMSUSER.DBNAME
                INNER JOIN DBO.BASE_CMS_SITE AS CMSSITE
                    ON
                    USERSITE.SITEID = CMSSITE.SITEID
				and USERSITE.SVR = CMSSITE.SVR
				and USERSITE.DBNAME = CMSSITE.DBNAME
                INNER JOIN DBO.BASE_HFIT_ACCOUNT AS ACCT
                    ON
                    ACCT.SITEID = CMSSITE.SITEID
				    				and ACCT.SVR = CMSSITE.SVR
				and USERSITE.DBNAME = ACCT.DBNAME
                INNER JOIN FACT_EDW_HFIT_HEALTHASSESMENTUSERMODULE AS HAUSERMODULE
                    ON
                    HAUSERSTARTED.ITEMID = HAUSERMODULE.HASTARTEDITEMID
and HAUSERSTARTED.SVR = HAUSERMODULE.SVR
and HAUSERSTARTED.DBNAME = HAUSERMODULE.DBNAME
                INNER JOIN FACT_EDW_VIEW_HFIT_HACAMPAIGN_JOINED AS VHCJ
                    ON
                    VHCJ.NODEGUID = HAUSERSTARTED.HACAMPAIGNNODEGUID
and VHCJ.SVR = HAUSERSTARTED.SVR
and VHCJ.DBNAME = HAUSERSTARTED.DBNAME
                AND VHCJ.NODESITEID = USERSITE.SITEID
and VHCJ.SVR = USERSITE.SVR
and VHCJ.DBNAME = USERSITE.DBNAME
                AND VHCJ.DOCUMENTCULTURE = 'en-US'
                INNER JOIN FACT_VIEW_HFIT_HEALTHASSESSMENT_JOINED AS VHAJ
                    ON
                    VHAJ.DOCUMENTID = VHCJ.HEALTHASSESSMENTID
and VHCJ.SVR = VHAJ.SVR
and VHCJ.DBNAME = VHAJ.DBNAME

                INNER JOIN FACT_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY
                    ON
                    HAUSERMODULE.ITEMID = HARISKCATEGORY.HAMODULEITEMID
and HAUSERMODULE.SVR = HARISKCATEGORY.SVR
and HAUSERMODULE.DBNAME = HARISKCATEGORY.DBNAME
                INNER JOIN FACT_EDW_HFit_HealthAssesmentUserRiskArea AS HAUSERRISKAREA
                    ON
                    HARISKCATEGORY.ITEMID = HAUSERRISKAREA.HARISKCATEGORYITEMID
and HARISKCATEGORY.SVR = HAUSERRISKAREA.SVR
and HARISKCATEGORY.DBNAME = HAUSERRISKAREA.DBNAME
                INNER JOIN FACT_EDW_HFit_HealthAssesmentUserQuestion AS HAUSERQUESTION
                    ON
                    HAUSERRISKAREA.ITEMID = HAUSERQUESTION.HARISKAREAITEMID
and HAUSERQUESTION.SVR = HAUSERRISKAREA.SVR
and HAUSERQUESTION.DBNAME = HAUSERRISKAREA.DBNAME

			 --INNER JOIN FACT_View_EDW_HealthAssesmentQuestions AS HAQUESTIONSVIEW
                INNER JOIN View_EDW_HealthAssesmentQuestions AS HAQUESTIONSVIEW
                    ON
                    HAUSERQUESTION.HAQUESTIONNODEGUID = HAQUESTIONSVIEW.NODEGUID
and HAUSERQUESTION.SVR = HAQUESTIONSVIEW.SVR
and HAUSERQUESTION.DBNAME = HAQUESTIONSVIEW.DBNAME

                LEFT OUTER JOIN FACT_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS HAUSERQUESTIONGROUPRESULTS
                    ON
                    HAUSERRISKAREA.ITEMID = HAUSERQUESTIONGROUPRESULTS.HARISKAREAITEMID
and HAUSERRISKAREA.SVR = HAUSERQUESTIONGROUPRESULTS.SVR
and HAUSERRISKAREA.DBNAME = HAUSERQUESTIONGROUPRESULTS.DBNAME
--here
                INNER JOIN FACT_EDW_HFIT_HealthAssesmentUserAnswers AS HAUSERANSWERS
                    ON
                    HAUSERQUESTION.ITEMID = HAUSERANSWERS.HAQUESTIONITEMID --Add in the change tracking data
and HAUSERQUESTION.SVR = HAUSERANSWERS.SVR
and HAUSERQUESTION.DBNAME = HAUSERANSWERS.DBNAME
                   WHERE USERSETTINGS.HFITUSERMPINUMBER NOT IN (
                SELECT
                       REJECTMPICODE
                       FROM BASE_HFIT_LKP_EDW_REJECTMPI);

            SET @ET = GETDATE () ;
            EXEC proc_trace 'Temp_PkHashKeys: END Process MarkNewRecords - CREATE TABLE VAR' , @CT , @ET;

            EXEC proc_trace 'Temp_PkHashKeys: START Process MarkNewRecords - Remove DUPS' , @CT , NULL;
            --select * from @HASHKEYS
            SET @ms = DATEDIFF (ms , @st , GETDATE ()) ;
            SET  @secs = @ms / 1000;
            SET @mins = @ms / 1000 / 60;
            PRINT '1 - @Secs = ' + CAST (@secs AS NVARCHAR (50)) ;
            PRINT '1 - @mins = ' + CAST (@mins AS NVARCHAR (50)) ;

            DECLARE
            @RemoveDups AS BIT = 1;

            IF @RemoveDups = 1
                BEGIN
                    WITH CTE (
                         PKHASHCODE
                       , HAUSERSTARTED_ITEMID
                       , HASHCODE
                       , DuplicateCount) 
                        AS (
                        SELECT
                               PKHASHCODE
                             , HAUSERSTARTED_ITEMID
                             , HASHCODE
                             , ROW_NUMBER () OVER ( PARTITION BY PKHASHCODE
                                                               , HAUSERSTARTED_ITEMID
                                                               , HASHCODE  ORDER BY PKHASHCODE , HAUSERSTARTED_ITEMID , HASHCODE) AS DuplicateCount
                               FROM ##FACT_EDW_PkHashkey
                        ) 
                        DELETE
                        FROM CTE
                        WHERE
                              DuplicateCount > 1;
                END;
            SET @ET = GETDATE () ;
            EXEC proc_trace 'Temp_PkHashKeys: END Process MarkNewRecords - Remove DUPS' , @CT , @ET;

            SET @CT = GETDATE () ;
            EXEC proc_trace 'Temp_PkHashKeys: START Process MarkNewRecords - Remove NULL RECS' , @CT , NULL;

            DELETE FROM FACT_MART_EDW_HealthAssesment
            WHERE
                  PKHashCode IS NULL;

            DELETE FROM ##FACT_EDW_PkHashkey
            WHERE
                  PKHashCode IS NULL;

            SET @ET = GETDATE () ;
            EXEC proc_trace 'Temp_PkHashKeys: END Process MarkNewRecords - Remove NULL RECS' , @CT , @ET;

        END;
--***************************************************************************************************************
END;

GO
PRINT 'Executed proc_EDW_Gen_Temp_PkHashKeys.sql';
GO