
/*----------------------------------------------------------
------------------------------------------------------------
DELETE FROM BASE_MART_EDW_HealthAssesment
WHERE
      PkHashCode IN (SELECT TOP 1000
                            PkHashCode
                          FROM BASE_MART_EDW_HealthAssesment) ;

SELECT
       COUNT (*) 
       FROM BASE_MART_EDW_HealthAssesment;
*/
GO

PRINT 'Execute proc_CT_HA_MarkNewRecords.sql';

GO

--0.23.2015 03:36:42
--0.24.2015 00:08:42 @ 1,000,000 no CT
--0.24.2015 00:05:16 @ 1,000,000 no CT / no DUPS
--0.24.2015 00:04:56 @ 1,000,000 no CT / no DUPS / TEMP TABLE
-- select count(*) from [@EdwHAHashkeys]
-- exec [proc_CT_HA_MarkNewRecords]

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_CT_HA_MarkNewRecords') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HA_MarkNewRecords;
    END;

GO
-- exec [proc_CT_HA_MarkNewRecords]
CREATE PROCEDURE proc_CT_HA_MarkNewRecords
AS
BEGIN

    --************************************************
    --MAKE SURE THE STAGED HASH KEY Table exists
    EXEC proc_Create_FACT_EDW_PkHashkey_TBL ;
    --************************************************

    DECLARE
    @st AS DATETIME = GETDATE () ;
    DECLARE
    @ET AS DATETIME = GETDATE () ;
    DECLARE
    @CT AS DATETIME = GETDATE () ;

    DECLARE
    @LatestDbVersionToPull AS BIGINT = 0;
    SET @LatestDbVersionToPull = CHANGE_TRACKING_CURRENT_VERSION () - 1;

    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK New Recs: START determine if NEW records present' , @CT , NULL;
    --**************************************************************
    DECLARE
    @iChgTypes AS INT = 0;
    DECLARE
    @NbrOfDetectedChanges AS BIGINT = 0;
    EXEC @iChgTypes = proc_CkHaDataChanged NULL , @NbrOfDetectedChanges OUTPUT;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS NVARCHAR (50)) ;
    PRINT 'Total Number Of Changes to process is: ' + CAST (@NbrOfDetectedChanges AS NVARCHAR (50)) ;
    --**************************************************************
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK New Recs: END determine if NEW records present' , @CT , @ET;

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
    IF
    @iChgTypes = 0
 OR @iChgTypes = 2
 OR @iChgTypes = 4
 OR @iChgTypes = 6
        BEGIN
            PRINT 'NO INSERTS found.';
        --RETURN 0;
        END;

    SET @CT = GETDATE () ;

    -- EXEC proc_EDW_UpdateDIMTables null

    --****************************************
    EXEC proc_EDW_Gen_Temp_PkHashKeys ;
    --****************************************

    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK New Recs: START Process MarkNewRecords - FIND AND MARK NEW Recs' , @CT , NULL;

    -- select top 100 * from FACT_EDW_PkHashkey
    --  drop table LKUP_NewEdwHAHashkeys

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE
                          name = 'LKUP_NewEdwHAHashkeys') 
        BEGIN
            PRINT 'Creating LKUP_NewEdwHAHashkeys';
            CREATE TABLE LKUP_NewEdwHAHashkeys
            (
                         HAUSERSTARTED_ITEMID INT  NOT NULL
                       , USERGUID UNIQUEIDENTIFIER  NOT NULL
                       , PKHASHCODE NVARCHAR (100) NOT NULL
                       , HASHCODE NVARCHAR (100) NOT NULL
                       , SVR NVARCHAR (100) NOT NULL
                       , DBNAME NVARCHAR (100) NOT NULL
            );

            EXEC proc_Add_EDW_CT_StdCols LKUP_NewEdwHAHashkeys;

            CREATE CLUSTERED INDEX CI_TEMPEdwNewHAHashkeys ON dbo.LKUP_NewEdwHAHashkeys
            (
            SVR ASC, DBNAME ASC,
            PKHASHCODE ASC ,
            HAUSERSTARTED_ITEMID ASC ,
            HASHCODE ASC ,
            USERGUID ASC
            );
        END;
    ELSE
        BEGIN
            PRINT 'RELOADING LKUP_NewEdwHAHashkeys';
            truncate TABLE LKUP_NewEdwHAHashkeys;
        END;

    -- select count(*) from LKUP_NewEdwHAHashkeys
    -- delete from FACT_EDW_PkHashkey where RowNbr in (select top 100 RowNbr from FACT_EDW_PkHashkey)
    -- exec proc_CT_HA_MarkNewRecords

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
         SVR
       , DBNAME
       ,HAUserStarted_ItemID
       , UserGUID
       , PKHashCode
       , HashCode) 
        AS (
        SELECT
               SVR
             , DBNAME
             , HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
             , HashCode
               FROM ##FACT_EDW_PkHashkey
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
             , HashCode
               FROM FACT_EDW_PkHashkey
               WHERE
               ISNULL (DeletedFlg , 0) = 0
        ) 
        INSERT INTO LKUP_NewEdwHAHashkeys
        (
               SVR
             , DBNAME
             , HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE
             , HashCode) 
        SELECT
               SVR
             , DBNAME
             , HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE
             , HashCode
               FROM CTE_TBL;

    -- JUST INCASE, REMOVE DUPS
    -- select * from LKUP_NewEdwHAHashkeys
    WITH CTE (
         SVR
       , DBNAME
       ,PKHASHCODE
       , HAUSERSTARTED_ITEMID
       , USERGUID
       , HashCode
       , DuplicateCount) 
        AS (
        SELECT
               SVR
             , DBNAME
             , PKHASHCODE
             , HAUSERSTARTED_ITEMID
             , USERGUID
             , HashCode
             , ROW_NUMBER () OVER ( PARTITION BY SVR
                                               , DBNAME
                                               , PKHASHCODE
                                               , HAUSERSTARTED_ITEMID
                                               , USERGUID
                                               , HashCode
               ORDER BY SVR, DBNAME, PKHASHCODE , HAUSERSTARTED_ITEMID , USERGUID , HashCode) AS DuplicateCount
               FROM LKUP_NewEdwHAHashkeys
        ) 
        DELETE
        FROM CTE
        WHERE
              DuplicateCount > 1;
    -- select  count(*) from LKUP_NewEdwHAHashkeys ;
    INSERT INTO FACT_EDW_PkHashkey
    (
           SVR
         , DBNAME
         , HAUSERSTARTED_ITEMID
         , USERGUID
         , HASHCODE
         , PKHASHCODE
         , ChangeType
         , ChangeDate
         , DeletedFlg
    ) 
    SELECT
           SVR
         , DBNAME
         , HAUSERSTARTED_ITEMID
         , USERGUID
         , HASHCODE
         , PKHASHCODE
         , 'I' AS ChangeType
         , GETDATE () AS ChangeDate
         , 0 AS DeletedFlg
           FROM LKUP_NewEdwHAHashkeys;

    INSERT INTO BASE_MART_EDW_HealthAssesment
    (
           SVR
         , DBNAME
         , UserStartedITEMID
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
    ) 
    SELECT
           T.SVR
         , T.DBNAME
         , T.UserStartedITEMID
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
           FROM view_EDW_PullHAData_NoCT_Inserts AS T
                    JOIN LKUP_NewEdwHAHashkeys AS C
                        ON C.HAUSERSTARTED_ITEMID = T.UserStartedItemID
                       AND C.UserGUID = T.UserGUID
                       AND C.PKHashCode = T.PKHashCode
                       AND C.SVR = T.SVR
                       AND C.DBNAME = T.DBNAME;

    --******************************************************************************
    DECLARE
    @iNewRecs AS INT = @@ROWCOUNT;

    UPDATE dbo.CT_VersionTracking
           SET
               CNT_Insert = @iNewRecs
    WHERE
          SVRName = @@SERVERNAME
      AND DBName = DB_NAME () 
      AND TgtView = 'view_EDW_HealthAssesment'
      AND rownbr = (SELECT
                           MAX (RowNbr) 
                           FROM CT_VersionTracking
                           WHERE
                           TgtView = 'view_EDW_HealthAssesment');

    PRINT 'NUMBER OF ROWS flagged as NEW: ' + CAST (@iNewRecs AS NVARCHAR (50)) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK New Recs: END Process MarkNewRecords - FIND AND MARK NEW Recs' , @CT , @ET;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK New Recs: END Process' , @CT , @ET;
    RETURN @iNewRecs;

END;

GO
PRINT 'Executed MarkNewRecords.sql';
--select top 1000 * from [@EdwHAHashkeys] order by RowNbr
GO
