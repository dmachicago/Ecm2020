
/*------------------------------------------------------------
DELETE FROM FACT_MART_EDW_HealthAssesment
WHERE
      PkHashCode IN (SELECT TOP 1000
                            PkHashCode
                          FROM FACT_MART_EDW_HealthAssesment) ;

SELECT
       COUNT (*) 
       FROM FACT_MART_EDW_HealthAssesment;
*/
GO

PRINT 'Execute proc_CT_HA_MarkUpdatedRecords.sql';

GO

-- exec [proc_CT_HA_MarkUpdatedRecords]

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_HA_MarkUpdatedRecords') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HA_MarkUpdatedRecords;
    END;

GO
-- exec [proc_CT_HA_MarkUpdatedRecords]
CREATE PROCEDURE proc_CT_HA_MarkUpdatedRecords
AS
BEGIN

    DECLARE @st AS datetime = GETDATE () ;
    DECLARE @ET AS datetime = GETDATE () ;
    DECLARE @CT AS datetime = GETDATE () ;

    DECLARE @LatestDbVersionToPull AS bigint = 0;
    SET @LatestDbVersionToPull = CHANGE_TRACKING_CURRENT_VERSION () - 1;


    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK Updated Recs: START determine if DELETED records present', @CT, NULL;
    --**************************************************************
declare @iChgTypes as int = 0 ; 
declare @NbrOfDetectedChanges as bigint = 0 ; 
    EXEC @iChgTypes = proc_CkHaDataChanged NULL, @NbrOfDetectedChanges OUTPUT;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS nvarchar (50)) ;
    PRINT 'Total Number Of Changes to process is: ' + CAST (@NbrOfDetectedChanges AS nvarchar (50)) ;
    --**************************************************************
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Updated Recs: END determine if DELETED records present', @CT, @ET;
/*-----------------------------------
-------------------------------
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
            RETURN 0;
        END;

    --************************************************
    --MAKE SURE THE STAGED HASH KEY Table exists
    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK Updated Recs: START Process proc_Create_FACT_EDW_PkHashkey_TBL', @CT, NULL;
    EXEC proc_Create_FACT_EDW_PkHashkey_TBL ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Updated Recs: START Process proc_Create_FACT_EDW_PkHashkey_TBL', @CT, @ET;
    --************************************************

    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK Updated Recs: START Process MarkUpdatedRecords - FIND AND MARK Deleted Recs', @CT, NULL;

    -- select top 100 * from FACT_EDW_PkHashkey
    --  drop table LKUP_UpdatedEdwHAHashkeys

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE name = 'LKUP_UpdatedEdwHAHashkeys') 
        BEGIN
            PRINT 'Creating LKUP_UpdatedEdwHAHashkeys';
            CREATE TABLE LKUP_UpdatedEdwHAHashkeys
            (
                         HAUSERSTARTED_ITEMID int  NOT NULL
                       , USERGUID uniqueidentifier  NOT NULL
                       , PKHASHCODE nvarchar (100) NOT NULL
                       , HASHCODE nvarchar (100) NOT NULL
            --, RowNbr int IDENTITY (1 , 1) 
            --             NOT NULL
            --  PRIMARY KEY ( PKHASHCODE ASC, HAUSERSTARTED_ITEMID ASC, USERGUID ASC, RowNbr ASC) 
            );

            CREATE CLUSTERED INDEX CI_TEMPEdwHAHashkeys ON dbo.LKUP_UpdatedEdwHAHashkeys
            (
            HAUSERSTARTED_ITEMID ASC,
            PKHASHCODE ASC,
            HASHCODE ASC,
            USERGUID ASC
            );
        END;
    ELSE
        BEGIN
            PRINT 'RELOADING LKUP_UpdatedEdwHAHashkeys';
            truncate TABLE LKUP_UpdatedEdwHAHashkeys;
        END;

    -- select count(*) from LKUP_UpdatedEdwHAHashkeys
    -- update FACT_EDW_PkHashkey set HASHCODE = cast(hashbytes('sha1','WDaleMiller') as nvarchar(100)) where RowNbr in (select top 100 RowNbr from FACT_EDW_PkHashkey)
    -- exec proc_CT_HA_MarkUpdatedRecords

    --****************************************************************************
    --If a record exists in both the temp table and the staging table
    --and the Hashcode is not the same, then the record has been updated.
    --It is critical to skip records that have been previously marked as deleted. 
    --Take all HASH KEYS and HASH CODES from the temp table and remove
    --The ones that are the same in the staging TABLE. The remaining keys
    --belong to records that have been UPDATED as the HASCODE will be 
    --different. Apply those records back to the staged data.
    --****************************************************************************
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
               FROM ##FACT_EDW_PkHashkey
        EXCEPT
        SELECT
               HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
             , HashCode
               FROM FACT_EDW_PkHashkey
               WHERE ISNULL (DeletedFlg, 0) = 0
        ) 
        INSERT INTO LKUP_UpdatedEdwHAHashkeys
        (
               HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE
             , HASHCODE) 
        SELECT
               HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE
             , HASHCODE
               FROM CTE_TBL;

    -- JUST INCASE, REMOVE DUPS
    WITH CTE (
         PKHASHCODE
       , HAUSERSTARTED_ITEMID
       , HASHCODE
       , USERGUID
       , DuplicateCount) 
        AS (
        SELECT
               PKHASHCODE
             , HAUSERSTARTED_ITEMID
             , HASHCODE
             , USERGUID
             , ROW_NUMBER () OVER ( PARTITION BY PKHASHCODE
                                               , HAUSERSTARTED_ITEMID
                                               , HASHCODE
                                               , USERGUID  ORDER BY PKHASHCODE , HAUSERSTARTED_ITEMID , HASHCODE, USERGUID) AS DuplicateCount
               FROM LKUP_UpdatedEdwHAHashkeys
        ) 
        DELETE
        FROM CTE
        WHERE
              DuplicateCount > 1;
    -- select  count(*) from LKUP_UpdatedEdwHAHashkeys ;

    UPDATE S
           SET
               S.DeletedFlg = 0
             ,S.ChangeDate = GETDATE () 
             ,S.ChangeType = 'U'
               FROM FACT_EDW_PkHashkey AS S
                        JOIN
                        LKUP_UpdatedEdwHAHashkeys AS C
                            ON
                            C.PKHashCode = S.PKHashCode
                        AND C.HAUSERSTARTED_ITEMID = S.HAUSERSTARTED_ITEMID
                        AND C.UserGUID = S.UserGUID;

    --******************************************************************************
    DECLARE
    @RUNDATE AS  datetime2 ( 7) = GETDATE () ;

    UPDATE S
           SET
               S.UserStartedITEMID = T.UserStartedITEMID
             ,S.HEALTHASSESMENTUserStartedNODEGUID = T.HEALTHASSESMENTUserStartedNODEGUID
             ,S.USERID = T.USERID
             ,S.USERGUID = T.USERGUID
             ,S.HFITUSERMPINUMBER = T.HFITUSERMPINUMBER
             ,S.SITEGUID = T.SITEGUID
             ,S.ACCOUNTID = T.ACCOUNTID
             ,S.ACCOUNTCD = T.ACCOUNTCD
             ,S.ACCOUNTNAME = T.ACCOUNTNAME
             ,S.HASTARTEDDT = T.HASTARTEDDT
             ,S.HACOMPLETEDDT = T.HACOMPLETEDDT
             ,S.USERMODULEITEMID = T.USERMODULEITEMID
             ,S.USERMODULECODENAME = T.USERMODULECODENAME
             ,S.HAMODULENODEGUID = T.HAMODULENODEGUID
             ,S.CMSNODEGUID = T.CMSNODEGUID
             ,S.HAMODULEVERSIONID = T.HAMODULEVERSIONID
             ,S.USERRISKCATEGORYITEMID = T.USERRISKCATEGORYITEMID
             ,S.USERRISKCATEGORYCODENAME = T.USERRISKCATEGORYCODENAME
             ,S.HARISKCATEGORYNODEGUID = T.HARISKCATEGORYNODEGUID
             ,S.HARISKCATEGORYVERSIONID = T.HARISKCATEGORYVERSIONID
             ,S.USERRISKAREAITEMID = T.USERRISKAREAITEMID
             ,S.USERRISKAREACODENAME = T.USERRISKAREACODENAME
             ,S.HARISKAREANODEGUID = T.HARISKAREANODEGUID
             ,S.HARISKAREAVERSIONID = T.HARISKAREAVERSIONID
             ,S.USERQUESTIONITEMID = T.USERQUESTIONITEMID
             ,S.TITLE = T.TITLE
             ,S.HAQUESTIONGUID = T.HAQUESTIONGUID
             ,S.USERQUESTIONCODENAME = T.USERQUESTIONCODENAME
             ,S.HAQUESTIONDOCUMENTID = T.HAQUESTIONDOCUMENTID
             ,S.HAQUESTIONVERSIONID = T.HAQUESTIONVERSIONID
             ,S.HAQUESTIONNODEGUID = T.HAQUESTIONNODEGUID
             ,S.USERANSWERITEMID = T.USERANSWERITEMID
             ,S.HAANSWERNODEGUID = T.HAANSWERNODEGUID
             ,S.HAANSWERVERSIONID = T.HAANSWERVERSIONID
             ,S.USERANSWERCODENAME = T.USERANSWERCODENAME
             ,S.HAANSWERVALUE = T.HAANSWERVALUE
             ,S.HAMODULESCORE = T.HAMODULESCORE
             ,S.HARISKCATEGORYSCORE = T.HARISKCATEGORYSCORE
             ,S.HARISKAREASCORE = T.HARISKAREASCORE
             ,S.HAQUESTIONSCORE = T.HAQUESTIONSCORE
             ,S.HAANSWERPOINTS = T.HAANSWERPOINTS
             ,S.POINTRESULTS = T.POINTRESULTS
             ,S.UOMCODE = T.UOMCODE
             ,S.HASCORE = T.HASCORE
             ,S.MODULEPREWEIGHTEDSCORE = T.MODULEPREWEIGHTEDSCORE
             ,S.RISKCATEGORYPREWEIGHTEDSCORE = T.RISKCATEGORYPREWEIGHTEDSCORE
             ,S.RISKAREAPREWEIGHTEDSCORE = T.RISKAREAPREWEIGHTEDSCORE
             ,S.QUESTIONPREWEIGHTEDSCORE = T.QUESTIONPREWEIGHTEDSCORE
             ,S.QUESTIONGROUPCODENAME = T.QUESTIONGROUPCODENAME
             ,S.ITEMCREATEDWHEN = T.ITEMCREATEDWHEN
             ,S.ITEMMODIFIEDWHEN = T.ITEMMODIFIEDWHEN
             ,S.ISPROFESSIONALLYCOLLECTED = T.ISPROFESSIONALLYCOLLECTED
             ,S.HARISKCATEGORY_ITEMMODIFIEDWHEN = T.HARISKCATEGORY_ITEMMODIFIEDWHEN
             ,S.HAUSERRISKAREA_ITEMMODIFIEDWHEN = T.HAUSERRISKAREA_ITEMMODIFIEDWHEN
             ,S.HAUSERQUESTION_ITEMMODIFIEDWHEN = T.HAUSERQUESTION_ITEMMODIFIEDWHEN
             ,S.HAUSERANSWERS_ITEMMODIFIEDWHEN = T.HAUSERANSWERS_ITEMMODIFIEDWHEN
             ,S.HAPAPERFLG = T.HAPAPERFLG
             ,S.HATELEPHONICFLG = T.HATELEPHONICFLG
             ,S.HASTARTEDMODE = T.HASTARTEDMODE
             ,S.HACOMPLETEDMODE = T.HACOMPLETEDMODE
             ,S.DOCUMENTCULTURE_VHCJ = T.DOCUMENTCULTURE_VHCJ
             ,S.DOCUMENTCULTURE_HAQUESTIONSVIEW = T.DOCUMENTCULTURE_HAQUESTIONSVIEW
             ,S.CAMPAIGNNODEGUID = T.CAMPAIGNNODEGUID
             ,S.HACAMPAIGNID = T.HACAMPAIGNID
             ,S.HASHCODE = T.HASHCODE
             ,S.CHANGED_FLG = T.CHANGED_FLG
             ,S.HEALTHASSESSMENTTYPE = T.HEALTHASSESSMENTTYPE
             ,S.HAUserStarted_LASTMODIFIED = T.HAUserStarted_LASTMODIFIED
             ,S.CMSUSER_LASTMODIFIED = T.CMSUSER_LASTMODIFIED
             ,S.USERSETTINGS_LASTMODIFIED = T.USERSETTINGS_LASTMODIFIED
             ,S.USERSITE_LASTMODIFIED = T.USERSITE_LASTMODIFIED
             ,S.CMSSITE_LASTMODIFIED = T.CMSSITE_LASTMODIFIED
             ,S.ACCT_LASTMODIFIED = T.ACCT_LASTMODIFIED
             ,S.HAUSERMODULE_LASTMODIFIED = T.HAUSERMODULE_LASTMODIFIED
             ,S.VHCJ_LASTMODIFIED = T.VHCJ_LASTMODIFIED
             ,S.VHAJ_LASTMODIFIED = T.VHAJ_LASTMODIFIED
             ,S.HARISKCATEGORY_LASTMODIFIED = T.HARISKCATEGORY_LASTMODIFIED
             ,S.HAUSERRISKAREA_LASTMODIFIED = T.HAUSERRISKAREA_LASTMODIFIED
             ,S.HAUSERQUESTION_LASTMODIFIED = T.HAUSERQUESTION_LASTMODIFIED
             ,S.HAQUESTIONSVIEW_LASTMODIFIED = T.HAQUESTIONSVIEW_LASTMODIFIED
             ,S.HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED = T.HAUSERQUESTIONGROUPRESULTS_LASTMODIFIED
             ,S.HAUSERANSWERS_LASTMODIFIED = T.HAUSERANSWERS_LASTMODIFIED
             ,S.HAUserStarted_LastUpdateID = T.HAUserStarted_LastUpdateID
             ,S.CMSUSER_LastUpdateID = T.CMSUSER_LastUpdateID
             ,S.USERSETTINGS_LastUpdateID = T.USERSETTINGS_LastUpdateID
             ,S.USERSITE_LastUpdateID = T.USERSITE_LastUpdateID
             ,S.ACCT_LastUpdateID = T.ACCT_LastUpdateID
             ,S.HAUSERMODULE_LastUpdateID = T.HAUSERMODULE_LastUpdateID
             ,S.VHCJ_LastUpdateID = T.VHCJ_LastUpdateID
             ,S.VHAJ_LastUpdateID = T.VHAJ_LastUpdateID
             ,S.HARISKCATEGORY_LastUpdateID = T.HARISKCATEGORY_LastUpdateID
             ,S.HAUSERRISKAREA_LastUpdateID = T.HAUSERRISKAREA_LastUpdateID
             ,S.HAUSERQUESTION_LastUpdateID = T.HAUSERQUESTION_LastUpdateID
             ,S.HAQUESTIONSVIEW_LastUpdateID = T.HAQUESTIONSVIEW_LastUpdateID
             ,S.HAUSERQUESTIONGROUPRESULTS_LastUpdateID = T.HAUSERQUESTIONGROUPRESULTS_LastUpdateID
             ,S.HAUSERANSWERS_LastUpdateID = T.HAUSERANSWERS_LastUpdateID

             ,S.DELETEFLG = T.DELETEFLG
             ,S.SVR = T.SVR
             ,S.DBNAME = T.DBNAME

             ,S.ConvertedToCentralTime = NULL
             ,S.LastModifiedDate = GETDATE () 
             ,S.RowNbr = NULL
             ,S.DeletedFlg = NULL
             ,S.TimeZone = NULL
             ,S.PKHashCode = T.PKHashCode
             --,S.ChangeType = 'U'
               FROM
               view_EDW_PullHAData_NoCT_Updates AS T
                   JOIN
                   FACT_MART_EDW_HealthAssesment AS S
                       ON
                       S.UserStartedItemID = T.UserStartedItemID
                   AND S.UserGUID = T.UserGUID
                   AND S.PKHashCode = T.PKHashCode
                   AND S.HashCode != T.HashCode;
    --******************************************************************************
    -- select count(*) from LKUP_UpdatedEdwHAHashkeys
    -- select * from view_EDW_PullHAData_NoCT_Updates
    DECLARE
    @iUpdatedRecs AS int = @@ROWCOUNT;

            UPDATE dbo.CT_VersionTracking
           SET
               CNT_Update = @iUpdatedRecs
    WHERE
          SVRName = @@SERVERNAME
      AND DBName = DB_NAME () 
      AND TgtView = 'view_EDW_HealthAssesment'
      AND rownbr = (select max(RowNbr) from CT_VersionTracking where TgtView = 'view_EDW_HealthAssesment')

    PRINT 'NUMBER OF ROWS flagged as deleted: ' + CAST (@iUpdatedRecs AS nvarchar (50)) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Updated Recs: END Process MarkUpdatedRecords - FIND AND MARK Deleted Recs', @CT, @ET;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Updated Recs: END Process', @CT, @ET;
    RETURN @iUpdatedRecs;

END;

GO
PRINT 'Executed MarkUpdatedRecords.sql';
--select top 1000 * from [@EdwHAHashkeys] order by RowNbr
GO
