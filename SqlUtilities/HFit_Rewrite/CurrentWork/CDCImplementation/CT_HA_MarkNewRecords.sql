
/*------------------------------------------------------------
DELETE FROM DIM_EDW_HealthAssessment
WHERE
      PkHashCode IN (SELECT TOP 1000
                            PkHashCode
                          FROM DIM_EDW_HealthAssessment) ;

SELECT
       COUNT (*) 
       FROM DIM_EDW_HealthAssessment;
*/
GO

PRINT 'Execute CT_HA_MarkNewRecords.sql';

GO

--0.23.2015 03:36:42
--0.24.2015 00:08:42 @ 1,000,000 no CT
--0.24.2015 00:05:16 @ 1,000,000 no CT / no DUPS
--0.24.2015 00:04:56 @ 1,000,000 no CT / no DUPS / TEMP TABLE
-- select count(*) from [@EdwHAHashkeys]
-- exec [CT_HA_MarkNewRecords]

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'CT_HA_MarkNewRecords') 
    BEGIN
        DROP PROCEDURE
             CT_HA_MarkNewRecords;
    END;

GO
-- exec [CT_HA_MarkNewRecords]
CREATE PROCEDURE CT_HA_MarkNewRecords
AS
BEGIN

    --************************************************
    --MAKE SURE THE STAGED HASH KEY Table exists
    EXEC proc_Create_STAGED_EDW_PkHashkey_TBL ;
    --************************************************

    DECLARE @st AS datetime = GETDATE () ;
    DECLARE @ET AS datetime = GETDATE () ;
    DECLARE @CT AS datetime = GETDATE () ;

    DECLARE
    @iChgTypes AS int = 0;

    SET @CT = GETDATE () ;
    EXEC proc_trace 'START determine if NEW records present', @CT, NULL;
    --**************************************************************
    EXEC @iChgTypes = proc_CkHaDataChanged NULL;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS nvarchar (50)) ;
    --**************************************************************
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END determine if NEW records present', @CT, @ET;
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
    IF @iChgTypes = 0
    OR @iChgTypes = 2
    OR @iChgTypes = 4
    OR @iChgTypes = 6
        BEGIN
            PRINT 'NO INSERTS found.';
        --RETURN 0;
        END;

    SET @CT = GETDATE () ;

    -- EXEC proc_EDW_BuildStagingTables null

    --****************************************
    exec proc_EDW_Gen_Temp_PkHashKeys ;
    --****************************************

    SET @CT = GETDATE () ;
    EXEC proc_trace 'START Process MarkNewRecords - FIND AND MARK NEW Recs', @CT, NULL;

    -- select top 100 * from STAGED_EDW_PkHashkey
    --  drop table LKUP_NewEdwHAHashkeys

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE name = 'LKUP_NewEdwHAHashkeys') 
        BEGIN
            PRINT 'Creating LKUP_NewEdwHAHashkeys';
            CREATE TABLE LKUP_NewEdwHAHashkeys
            (
                         HAUSERSTARTED_ITEMID int  NOT NULL
                       , USERGUID uniqueidentifier  NOT NULL
                       , PKHASHCODE nvarchar (100) NOT NULL
                       , HASHCODE nvarchar (100) NOT NULL
            );

            CREATE CLUSTERED INDEX CI_TEMPEdwNewHAHashkeys ON dbo.LKUP_NewEdwHAHashkeys
            (
            PKHASHCODE ASC,
            HAUSERSTARTED_ITEMID ASC,
            HASHCODE ASC,
            USERGUID ASC
            );
        END;
    ELSE
        BEGIN
            PRINT 'RELOADING LKUP_NewEdwHAHashkeys';
            truncate TABLE LKUP_NewEdwHAHashkeys;
        END;

    -- select count(*) from LKUP_NewEdwHAHashkeys
    -- delete from STAGED_EDW_PkHashkey where RowNbr in (select top 100 RowNbr from STAGED_EDW_PkHashkey)
    -- exec CT_HA_MarkNewRecords

    --***************************************************************************
    --If a record exists in the TEMP table and not in the staging table,
    --it is a NEW record. Take all the PKHASHKEYS from the temp table
    --and remove those same keys that exist in the STAGED table and those 
    --that are remaining in the TEMP table are newly added records. Add those 
    --records to the staged data.
    --NOTE: The HASHCODE need not be considered here as the PHHASHCODE is the 
    --	  only one of importance.
    --***************************************************************************
    WITH CTE_TBL (
         HAUserStarted_ItemID
       , UserGUID
       , PKHashCode
       , HashCode) 
        AS (
        SELECT
               HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
             , HashCode
               FROM ##STAGED_EDW_PkHashkey
        EXCEPT
        SELECT
               HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
             , HashCode
               FROM STAGED_EDW_PkHashkey
               WHERE ISNULL (DeletedFlg, 0) = 0
        ) 
        INSERT INTO LKUP_NewEdwHAHashkeys
        (
               HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE
             , HashCode) 
        SELECT
               HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE
             , HashCode
               FROM CTE_TBL;

    -- JUST INCASE, REMOVE DUPS
    -- select * from LKUP_NewEdwHAHashkeys
    WITH CTE (
         PKHASHCODE
       , HAUSERSTARTED_ITEMID
       , USERGUID
       , HashCode
       , DuplicateCount) 
        AS (
        SELECT
               PKHASHCODE
             , HAUSERSTARTED_ITEMID
             , USERGUID
             , HashCode
             , ROW_NUMBER () OVER ( PARTITION BY PKHASHCODE
                                               , HAUSERSTARTED_ITEMID
                                               , USERGUID
                                               , HashCode
               ORDER BY PKHASHCODE , HAUSERSTARTED_ITEMID , USERGUID, HashCode) AS DuplicateCount
               FROM LKUP_NewEdwHAHashkeys
        ) 
        DELETE
        FROM CTE
        WHERE
              DuplicateCount > 1;
    -- select  count(*) from LKUP_NewEdwHAHashkeys ;
    INSERT INTO STAGED_EDW_PkHashkey
    (
           HAUSERSTARTED_ITEMID
         , USERGUID
         , HASHCODE
         , PKHASHCODE
         , ChangeType
         , ChangeDate
         , DeletedFlg
         , SVR
         , DBNAME) 
    SELECT
           HAUSERSTARTED_ITEMID
         , USERGUID
         , HASHCODE
         , PKHASHCODE
         , 'I' AS ChangeType
         , GETDATE () AS ChangeDate
         , 0 AS DeletedFlg
         , @@SERVERNAME AS SVR
         , DB_NAME () AS DBNAME
           FROM LKUP_NewEdwHAHashkeys;

    INSERT INTO DIM_EDW_HealthAssessment
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
         , T.LASTMODIFIEDDATE
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
         , 'I' AS ChangeType
           FROM
               view_EDW_PullHAData_NoCT_Inserts AS T
                   JOIN LKUP_NewEdwHAHashkeys AS C
                       ON C.HAUSERSTARTED_ITEMID = T.UserStartedItemID
                      AND C.UserGUID = T.UserGUID
                      AND C.PKHashCode = T.PKHashCode;

    --******************************************************************************
    DECLARE
    @iDels AS int = @@ROWCOUNT;

    --WITH CTE (
    --     PKHASHCODE
    --   , HAUSERSTARTEDITEMID
    --   , USERGUID
    --   , HashCode
    --   , DuplicateCount) 
    --    AS (
    --    SELECT
    --           PKHASHCODE
    --         , UserStartedITEMID
    --         , USERGUID
    --         , HashCode
    --         , ROW_NUMBER () OVER ( PARTITION BY PKHASHCODE
    --                                           , UserStartedITEMID
    --                                           , USERGUID
    --                                           , HashCode
    --           ORDER BY PKHASHCODE , UserStartedITEMID , USERGUID, HashCode) AS DuplicateCount
    --           FROM DIM_EDW_HealthAssessment
    --    ) 
    --    DELETE
    --    FROM CTE
    --    WHERE
    --          DuplicateCount > 1;

    PRINT 'NUMBER OF ROWS flagged as NEW: ' + CAST (@iDels AS nvarchar (50)) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process MarkNewRecords - FIND AND MARK NEW Recs', @CT, @ET;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'END Process', @CT, @ET;
    RETURN @iDels;

END;

GO
PRINT 'Executed MarkNewRecords.sql';
--select top 1000 * from [@EdwHAHashkeys] order by RowNbr
GO
