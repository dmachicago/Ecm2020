

GO

PRINT 'Execute proc_CT_MarkDeletedRecords.sql';

GO

--0.23.2015 03:36:42
--0.24.2015 00:08:42 @ 1,000,000 no CT
--0.24.2015 00:05:16 @ 1,000,000 no CT / no DUPS
--0.24.2015 00:04:56 @ 1,000,000 no CT / no DUPS / TEMP TABLE
-- select count(*) from [@EdwHAHashkeys]
-- exec [proc_CT_MarkDeletedRecords]

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_MarkDeletedRecords') 
    BEGIN
        DROP PROCEDURE
             proc_CT_MarkDeletedRecords;
    END;

GO
-- exec [proc_CT_MarkDeletedRecords]
CREATE PROCEDURE proc_CT_MarkDeletedRecords
AS
BEGIN

DECLARE
    @iChgTypes AS int = 0;

    --**************************************************************
    EXEC @iChgTypes = proc_CkHaDataChanged null;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS nvarchar (50)) ;
    --**************************************************************
/*-------------------------------
if @iChgTypes = 
0 - no changes
1 - updates only
2 - deletes only
3 - deletes and updates
4 - inserts only
5 - inserts and updates
6 - inserts and deletes
7 - inserts, updates, and deletes
*/
if @iChgTypes = 0 or @iChgTypes  = 1 or @iChgTypes = 4 or @iChgTypes = 5 
begin
    print 'NO DELETES found.' ;
    return 0 ;
end ;
    DECLARE @st AS datetime = GETDATE () ;
    DECLARE @ET AS datetime = GETDATE () ;
    DECLARE @CT AS datetime = GETDATE () ;
    --0.23.2015 03:36:42
    --DECLARE @HASHKEYS as table

    DECLARE @EdwHAHashkeys AS TABLE
            (
                                    HAUSERSTARTED_ITEMID int  NOT NULL
                                  , USERGUID uniqueidentifier  NOT NULL
                                  , HASHCODE nvarchar (100) NOT NULL
                                  , PKHASHCODE nvarchar (100) NOT NULL
                                  , CHANGETYPE varchar (10) NULL
                                  , RowNbr int IDENTITY (1 , 1) 
                                               NOT NULL
                                    PRIMARY KEY ( PKHASHCODE ASC, HAUSERSTARTED_ITEMID ASC, USERGUID ASC, HASHCODE  ASC, RowNbr ASC) 
            );
    --***************************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START Process MarkDeletedRecords - CREATE TABLE VAR', @CT, NULL;
    INSERT INTO @EdwHAHashkeys
    (
           HAUSERSTARTED_ITEMID
         , USERGUID
         , HASHCODE
         , PKHASHCODE) 
    SELECT
           HAUSERSTARTED.ITEMID AS HAUSERSTARTED_ITEMID
         , USERGUID
         , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUSERSTARTED.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.USERID AS nvarchar (100)) , '-') + ISNULL ( CAST ( CMSUSER.USERGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( USERSETTINGS.HFITUSERMPINUMBER AS nvarchar (100)) , '-') + ISNULL ( CAST ( CMSSITE.SITEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTCD AS nvarchar (100)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTNAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HASTARTEDDT AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACOMPLETEDDT AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULENODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREANODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS nvarchar (100)) , '-') + ISNULL ( LEFT ( HAQUESTIONSVIEW.TITLE , 1000) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERVALUE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.HAMODULESCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.HARISKAREASCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.HAANSWERPOINTS AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTIONGROUPRESULTS.POINTRESULTS AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.UOMCODE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HASCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERMODULE.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.PREWEIGHTEDSCORE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTIONGROUPRESULTS.CODENAME AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMCREATEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ISPROFESSIONALLYCOLLECTED AS nvarchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HAPAPERFLG AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HATELEPHONICFLG AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HASTARTEDMODE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACOMPLETEDMODE AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACAMPAIGNNODEGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( VHCJ.HACAMPAIGNID AS nvarchar (100)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMMODIFIEDWHEN AS nvarchar (100)) , '-')) AS varchar (100)) AS HASHCODE
         , CAST ( HASHBYTES ( 'sha1' , ISNULL ( CAST ( HAUSERSTARTED.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( USERGUID AS varchar (50)) , '-') + ISNULL ( CAST ( SITEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( ACCT.ACCOUNTID AS varchar (50)) , '-') + ISNULL ( CAST ( ACCOUNTCD AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERMODULE.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HAMODULENODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( VHAJ.NODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORYNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.CODENAME AS varchar (100)) , '-') + ISNULL ( CAST ( HARISKCATEGORY.HARISKCATEGORYNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HARISKAREANODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERRISKAREA.CODENAME AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.HAQUESTIONNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERQUESTION.CODENAME AS varchar (50)) , '-') + ISNULL ( CAST ( HAQUESTIONNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERANSWERS.ITEMID AS varchar (50)) , '-') + ISNULL ( CAST ( HAANSWERNODEGUID AS varchar (50)) , '-') + ISNULL ( CAST ( HAUSERSTARTED.HACAMPAIGNNODEGUID AS varchar (50)) , '-')) AS varchar (100)) AS PKHASHCODE
           FROM
               DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED AS HAUSERSTARTED
                   INNER JOIN DIM_EDW_CMS_USER AS CMSUSER
                       ON HAUSERSTARTED.USERID = CMSUSER.USERID
                   INNER JOIN DIM_EDW_CMS_USERSETTINGS AS USERSETTINGS
                       ON USERSETTINGS.USERSETTINGSUSERID = CMSUSER.USERID
                      AND HFITUSERMPINUMBER >= 0
                      AND HFITUSERMPINUMBER IS NOT NULL
                   INNER JOIN DIM_EDW_CMS_USERSITE AS USERSITE
                       ON CMSUSER.USERID = USERSITE.USERID
                   INNER JOIN DBO.CMS_SITE AS CMSSITE
                       ON USERSITE.SITEID = CMSSITE.SITEID
                   INNER JOIN DBO.HFIT_ACCOUNT AS ACCT
                       ON ACCT.SITEID = CMSSITE.SITEID
                   INNER JOIN DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE AS HAUSERMODULE
                       ON HAUSERSTARTED.ITEMID = HAUSERMODULE.HASTARTEDITEMID
                   INNER JOIN DIM_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED AS VHCJ
                       ON VHCJ.NODEGUID = HAUSERSTARTED.HACAMPAIGNNODEGUID
                      AND VHCJ.NODESITEID = USERSITE.SITEID
                      AND VHCJ.DOCUMENTCULTURE = 'en-US'
                   INNER JOIN DIM_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED AS VHAJ
                       ON VHAJ.DOCUMENTID = VHCJ.HEALTHASSESSMENTID
                   INNER JOIN DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY AS HARISKCATEGORY
                       ON HAUSERMODULE.ITEMID = HARISKCATEGORY.HAMODULEITEMID
                   INNER JOIN DIM_EDW_HFit_HealthAssesmentUserRiskArea AS HAUSERRISKAREA
                       ON HARISKCATEGORY.ITEMID = HAUSERRISKAREA.HARISKCATEGORYITEMID
                   INNER JOIN DIM_EDW_HFit_HealthAssesmentUserQuestion AS HAUSERQUESTION
                       ON HAUSERRISKAREA.ITEMID = HAUSERQUESTION.HARISKAREAITEMID
                   INNER JOIN DIM_EDW_View_EDW_HealthAssesmentQuestions AS HAQUESTIONSVIEW
                       ON HAUSERQUESTION.HAQUESTIONNODEGUID = HAQUESTIONSVIEW.NODEGUID
                   LEFT OUTER JOIN DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults AS HAUSERQUESTIONGROUPRESULTS
                       ON HAUSERRISKAREA.ITEMID = HAUSERQUESTIONGROUPRESULTS.HARISKAREAITEMID
                   INNER JOIN DIM_EDW_HFIT_HealthAssesmentUserAnswers AS HAUSERANSWERS
                       ON HAUSERQUESTION.ITEMID = HAUSERANSWERS.HAQUESTIONITEMID --Add in the change tracking data
           WHERE USERSETTINGS.HFITUSERMPINUMBER NOT IN (
                 SELECT
                        REJECTMPICODE
                        FROM HFIT_LKP_EDW_REJECTMPI);

    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process MarkDeletedRecords - CREATE TABLE VAR', @CT, @ET;
    --***************************************************************************************************************
    EXEC proc_trace 'START Process MarkDeletedRecords - Remove DUPS', @CT, NULL;
    --select * from @HASHKEYS
    DECLARE @ms AS float = DATEDIFF (ms, @st, GETDATE ()) ;
    DECLARE @secs AS float = @ms / 1000;
    DECLARE @mins AS float = @ms / 1000 / 60;
    PRINT '1 - @Secs = ' + CAST (@secs AS nvarchar (50)) ;
    PRINT '1 - @mins = ' + CAST (@mins AS nvarchar (50)) ;

    DECLARE @RemoveDups AS bit = 0;

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
                       FROM @EdwHAHashkeys
                ) 
                DELETE
                FROM CTE
                WHERE
                      DuplicateCount > 1;
        END;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process MarkDeletedRecords - Remove DUPS', @CT, @ET;
    --***************************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START Process MarkDeletedRecords - Remove NULL RECS', @CT, NULL;

    DELETE FROM DIM_EDW_HealthAssessment
    WHERE
          PKHashCode IS NULL;

    DELETE FROM @EdwHAHashkeys
    WHERE
          PKHashCode IS NULL;

    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process MarkDeletedRecords - Remove NULL RECS', @CT, @ET;
    --***************************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START Process MarkDeletedRecords - FIND AND MARK Deleted Recs', @CT, NULL;

    DECLARE
    @DELDATE AS  datetime2 ( 7) = GETDATE () ;
    -- select top 100 * from @EdwHAHashkeys
    WITH CTE_DEL (
         UserStartedItemID
       , UserGUID
       , PKHashCode
    ) 
        AS (
        SELECT
               UserStartedItemID
             , UserGUID
             , PKHashCode
               FROM DIM_EDW_HealthAssessment
               WHERE DeletedFlg IS NULL
        EXCEPT
        SELECT
               HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
               FROM @EdwHAHashkeys
        --FROM view_EDW_PullHAData_NoCT
        ) 

        UPDATE S
               SET
                   DeletedFlg = 1
                 ,LastModifiedDate = @DELDATE
                 ,ChangeType = 'D'
                   FROM DIM_EDW_HealthAssessment AS S
                            JOIN
                            CTE_DEL AS C
                                ON
                                C.PKHashCode = S.PKHashCode
                            AND C.UserStartedItemID = S.UserStartedItemID
                            AND C.UserGUID = S.UserGUID;

    DECLARE
    @iDels AS int = @@ROWCOUNT;

    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process MarkDeletedRecords - FIND AND MARK Deleted Recs', @CT, @ET;
    --***************************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'START Process MarkDeletedRecords - SET DATE ON Deleted Recs', @CT, NULL;
    UPDATE DIM_EDW_HealthAssessment
           SET
               LastModifiedDate = GETDATE () 
    WHERE
          LastModifiedDate IS NULL
      AND DeletedFlg IS NOT NULL;

    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process MarkDeletedRecords - SET DATE ON Deleted Recs', @CT, @ET;
    --***************************************************************************************************************
    PRINT 'Deleted Record Count: ' + CAST ( @iDels AS nvarchar (50)) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process', @CT, @ET;
    RETURN @iDels;

END;

GO
PRINT 'Executed MarkDeletedRecords.sql';
--select top 1000 * from [@EdwHAHashkeys] order by RowNbr
GO
