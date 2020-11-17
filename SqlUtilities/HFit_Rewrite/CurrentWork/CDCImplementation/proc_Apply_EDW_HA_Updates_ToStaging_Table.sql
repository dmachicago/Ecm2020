
GO
PRINT 'Executing proc_Apply_EDW_HA_Updates_ToStaging_Table.SQL';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_Apply_EDW_HA_Updates_ToStaging_Table') 
    BEGIN
        DROP PROCEDURE
             proc_Apply_EDW_HA_Updates_ToStaging_Table;
    END;
GO
-- exec proc_Apply_EDW_HA_Updates_ToStaging_Table
CREATE PROCEDURE proc_Apply_EDW_HA_Updates_ToStaging_Table
AS
BEGIN
    DECLARE
    @ST AS DATETIME = GETDATE () ;
    DECLARE
    @ST_TBLS AS DATETIME = GETDATE () ;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; -- turn it on

    --*******************************************************
    EXEC proc_EDW_UpdateDIMTables;
    --*******************************************************
    DECLARE
    @ms AS FLOAT = DATEDIFF (ms , @ST_TBLS , GETDATE ()) ;
    DECLARE
    @Secs AS FLOAT = @ms / 1000;
    DECLARE
    @Mins AS FLOAT = @ms / 1000 / 60;
    DECLARE
    @Hrs AS FLOAT = @ms / 1000 / 60 / 60;

    PRINT 'proc_EDW_UpdateDIMTables Mins: ' + CAST (@Mins AS NVARCHAR (50)) ;
    PRINT 'proc_EDW_UpdateDIMTables @Hrs: ' + CAST (@Hrs AS NVARCHAR (50)) ;

    DECLARE
    @ST_HKEY AS DATETIME = GETDATE () ;
    --*******************************************************
    EXEC proc_EDW_BuildHAHashkeys;
    --*******************************************************
    SET @ms = DATEDIFF (ms , @ST_HKEY , GETDATE ()) ;
    SET @Secs = @ms / 1000;
    SET @Mins = @ms / 1000 / 60;
    SET @Hrs = @ms / 1000 / 60 / 60;

    PRINT 'proc_EDW_BuildHAHashkeys @Secs: ' + CAST (@Secs AS NVARCHAR (50)) ;
    PRINT 'proc_EDW_BuildHAHashkeys @Mins: ' + CAST (@Mins AS NVARCHAR (50)) ;
    PRINT 'proc_EDW_BuildHAHashkeys @Hrs: ' + CAST (@Mins AS NVARCHAR (50)) ;

    SET @ms = DATEDIFF (ms , @ST , GETDATE ()) ;
    SET @Secs = @ms / 1000;
    SET @Mins = @ms / 1000 / 60;
    SET @Hrs = @ms / 1000 / 60 / 60;
    PRINT '@Total Mins: ' + CAST (@Mins AS NVARCHAR (50)) ;
    PRINT '@Total Hrs : ' + CAST (@Hrs AS NVARCHAR (50)) ;

    --select count(*) from view_EDW_PullHAData_NoCT	--7616128
    --select top 10 * from #EdwHAHashkeys
    --select Count(*) from #EdwHAHashkeys

    DECLARE
    @newtime AS DATETIME = GETDATE () ;
    --Find NEW records
    --***************************************************************************************
    WITH CTE_EDW (
         SVR
       , DBNAME
       , HSUserStarted_ItemID
       , UserGUID
       , PKHashCode) 
        AS (
        SELECT
               SVR
             , DBNAME
             , HAUSERSTARTED_ITEMID
             , UserGUID
             , PKHashCode
               FROM ##EdwHAHashkeys
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , USERSTARTEDITEMID
             , UserGUID
             , PKHashCode
               FROM FACT_MART_EDW_HealthAssesment
        ) 
        INSERT INTO FACT_MART_EDW_HealthAssesment
        (
               ACCOUNTCD
             , ACCOUNTID
             , ACCOUNTNAME
             , CAMPAIGNNODEGUID
             , CHANGED_FLG
             , ChangeType
             , CMSNODEGUID
             , DOCUMENTCULTURE_HAQUESTIONSVIEW
             , DOCUMENTCULTURE_VHCJ
             , HAANSWERNODEGUID
             , HAANSWERPOINTS
             , HAANSWERVALUE
             , HAANSWERVERSIONID
             , HACAMPAIGNID
             , HACOMPLETEDDT
             , HACOMPLETEDMODE
             , HAMODULENODEGUID
             , HAMODULESCORE
             , HAMODULEVERSIONID
             , HAPAPERFLG
             , HAQUESTIONDOCUMENTID
             , HAQUESTIONGUID
             , HAQUESTIONNODEGUID
             , HAQUESTIONSCORE
             , HAQUESTIONVERSIONID
             , HARISKAREANODEGUID
             , HARISKAREASCORE
             , HARISKAREAVERSIONID
             , HARISKCATEGORY_ITEMMODIFIEDWHEN
             , HARISKCATEGORYNODEGUID
             , HARISKCATEGORYSCORE
             , HARISKCATEGORYVERSIONID
             , HASCORE
             , HASHCODE
             , HASTARTEDDT
             , HASTARTEDMODE
             , HATELEPHONICFLG
             , HAUSERANSWERS_ITEMMODIFIEDWHEN
             , HAUSERQUESTION_ITEMMODIFIEDWHEN
             , HAUSERRISKAREA_ITEMMODIFIEDWHEN
             , HEALTHASSESMENTUSERSTARTEDNODEGUID
             , HEALTHASSESSMENTTYPE
             , HFITUSERMPINUMBER
             , ISPROFESSIONALLYCOLLECTED
             , ITEMCREATEDWHEN
             , ITEMMODIFIEDWHEN
             , MODULEPREWEIGHTEDSCORE
             , PKHASHCODE
             , POINTRESULTS
             , QUESTIONGROUPCODENAME
             , QUESTIONPREWEIGHTEDSCORE
             , RISKAREAPREWEIGHTEDSCORE
             , RISKCATEGORYPREWEIGHTEDSCORE
             , SITEGUID
             , TITLE
             , UOMCODE
             , USERANSWERCODENAME
             , USERANSWERITEMID
             , USERGUID
             , USERID
             , USERMODULECODENAME
             , USERMODULEITEMID
             , USERQUESTIONCODENAME
             , USERQUESTIONITEMID
             , USERRISKAREACODENAME
             , USERRISKAREAITEMID
             , USERRISKCATEGORYCODENAME
             , USERRISKCATEGORYITEMID
             , USERSTARTEDITEMID
             , DBNAME
             , SVR
             , LastModifiedDATE
             , ConvertedToCentralTime
             , RowNbr
             , DELETEDFLG
             , TimeZone) 
        SELECT
               V.ACCOUNTCD
             , V.ACCOUNTID
             , V.ACCOUNTNAME
             , V.CAMPAIGNNODEGUID
             , V.CHANGED_FLG
             , 'U' AS ChangeType
             , V.CMSNODEGUID
             , V.DOCUMENTCULTURE_HAQUESTIONSVIEW
             , V.DOCUMENTCULTURE_VHCJ
             , V.HAANSWERNODEGUID
             , V.HAANSWERPOINTS
             , V.HAANSWERVALUE
             , V.HAANSWERVERSIONID
             , V.HACAMPAIGNID
             , V.HACOMPLETEDDT
             , V.HACOMPLETEDMODE
             , V.HAMODULENODEGUID
             , V.HAMODULESCORE
             , V.HAMODULEVERSIONID
             , V.HAPAPERFLG
             , V.HAQUESTIONDOCUMENTID
             , V.HAQUESTIONGUID
             , V.HAQUESTIONNODEGUID
             , V.HAQUESTIONSCORE
             , V.HAQUESTIONVERSIONID
             , V.HARISKAREANODEGUID
             , V.HARISKAREASCORE
             , V.HARISKAREAVERSIONID
             , V.HARISKCATEGORY_ITEMMODIFIEDWHEN
             , V.HARISKCATEGORYNODEGUID
             , V.HARISKCATEGORYSCORE
             , V.HARISKCATEGORYVERSIONID
             , V.HASCORE
             , V.HASHCODE
             , V.HASTARTEDDT
             , V.HASTARTEDMODE
             , V.HATELEPHONICFLG
             , V.HAUSERANSWERS_ITEMMODIFIEDWHEN
             , V.HAUSERQUESTION_ITEMMODIFIEDWHEN
             , V.HAUSERRISKAREA_ITEMMODIFIEDWHEN
             , V.HEALTHASSESMENTUSERSTARTEDNODEGUID
             , V.HEALTHASSESSMENTTYPE
             , V.HFITUSERMPINUMBER
             , V.ISPROFESSIONALLYCOLLECTED
             , V.ITEMCREATEDWHEN
             , V.ITEMMODIFIEDWHEN
             , V.MODULEPREWEIGHTEDSCORE
             , V.PKHASHCODE
             , V.POINTRESULTS
             , V.QUESTIONGROUPCODENAME
             , V.QUESTIONPREWEIGHTEDSCORE
             , V.RISKAREAPREWEIGHTEDSCORE
             , V.RISKCATEGORYPREWEIGHTEDSCORE
             , V.SITEGUID
             , V.TITLE
             , V.UOMCODE
             , V.USERANSWERCODENAME
             , V.USERANSWERITEMID
             , V.USERGUID
             , V.USERID
             , V.USERMODULECODENAME
             , V.USERMODULEITEMID
             , V.USERQUESTIONCODENAME
             , V.USERQUESTIONITEMID
             , V.USERRISKAREACODENAME
             , V.USERRISKAREAITEMID
             , V.USERRISKCATEGORYCODENAME
             , V.USERRISKCATEGORYITEMID
             , V.USERSTARTEDITEMID
             , V.DBNAME
             , V.SVR
             , V.LastModifiedDATE
             , NULL AS ConvertedToCentralTime
             , NULL AS RowNbr
             , NULL AS DeletedFlg
             , NULL AS TimeZone
               FROM view_EDW_PullHAData_NoCT AS V
                        JOIN CTE_EDW AS C
                            ON C.HSUserStarted_ItemID = V.UserStartedItemID
                           AND C.UserGUID = V.UserGUID
                           AND C.PKHashCode = V.PKHashCode
                           AND C.SVR = V.SVR
                           AND C.DBNAME = V.DBNAME;

    SET @ms = DATEDIFF (ms , @newtime , GETDATE ()) ;
    SET @Secs = @ms / 1000;
    SET @Mins = @ms / 1000 / 60;
    SET @Hrs = @ms / 1000 / 60 / 60;

    PRINT 'Time required to insert new records @Mins: ' + CAST (@Mins AS NVARCHAR (50)) ;
    PRINT 'Time required to insert new records @Hrs: ' + CAST (@Hrs AS NVARCHAR (50)) ;

    --select top 20 * from ##EdwHAHashkeys
    --select top 20 * from FACT_MART_EDW_HealthAssesment
    --delete from FACT_MART_EDW_HealthAssesment where UserStartedItemID = 9335
    --delete from ##EdwHAHashkeys where HAUSERSTARTED_ITEMID = 47779

    --SELECT COUNT(*) FROM ##EdwHAHashkeys
    DECLARE
    @deltime AS DATETIME = GETDATE () ;
    --Find deleted records
    --***************************************************************************************
    WITH CTE_DEL (SVR, DBNAME, 
         USERSTARTEDITEMID
       , PKHashCode) 
        AS (
        SELECT SVR, DBNAME, 
               USERSTARTEDITEMID
             , PKHashCode
               FROM FACT_MART_EDW_HealthAssesment
        EXCEPT
        SELECT SVR, DBNAME, 
               HAUSERSTARTED_ITEMID
             , PKHashCode
               FROM ##EdwHAHashkeys
        ) 
        UPDATE S
               SET
                   DeletedFlg = 1
                 ,LastModifiedDate = GETDATE () 
                 ,ChangeType = 'D'
                   FROM FACT_MART_EDW_HealthAssesment AS S
                            JOIN
                            CTE_DEL AS C
                                ON
                                C.UserStartedItemID = S.UserStartedItemID
                            AND C.PKHashCode = S.PKHashCode
				AND C.SVR = S.SVR AND C.DBNAME = S.DBNAME

    SET @ms = DATEDIFF (ms , @deltime , GETDATE ()) ;
    SET @Secs = @ms / 1000;
    SET @Mins = @ms / 1000 / 60;
    SET @Hrs = @ms / 1000 / 60 / 60;
    PRINT 'Time required to mark deleted recs @Mins: ' + CAST (@Mins AS NVARCHAR (50)) ;
    PRINT 'Time required to mark deleted recs @Hrs: ' + CAST (@Hrs AS NVARCHAR (50)) ;

    DECLARE
    @updtetime AS DATETIME = GETDATE () ;
    --Find UPDATES
    --***************************************************************************************
    UPDATE S
           SET
               S.ACCOUNTCD = V.ACCOUNTCD
             ,S.ACCOUNTID = V.ACCOUNTID
             ,S.ACCOUNTNAME = V.ACCOUNTNAME
             ,S.CAMPAIGNNODEGUID = V.CAMPAIGNNODEGUID
             ,S.CHANGED_FLG = V.CHANGED_FLG
             --,S.ChangeType = 'U'
             ,S.CMSNODEGUID = V.CMSNODEGUID
             ,S.DOCUMENTCULTURE_HAQUESTIONSVIEW = V.DOCUMENTCULTURE_HAQUESTIONSVIEW
             ,S.DOCUMENTCULTURE_VHCJ = V.DOCUMENTCULTURE_VHCJ
             ,S.HAANSWERNODEGUID = V.HAANSWERNODEGUID
             ,S.HAANSWERPOINTS = V.HAANSWERPOINTS
             ,S.HAANSWERVALUE = V.HAANSWERVALUE
             ,S.HAANSWERVERSIONID = V.HAANSWERVERSIONID
             ,S.HACAMPAIGNID = V.HACAMPAIGNID
             ,S.HACOMPLETEDDT = V.HACOMPLETEDDT
             ,S.HACOMPLETEDMODE = V.HACOMPLETEDMODE
             ,S.HAMODULENODEGUID = V.HAMODULENODEGUID
             ,S.HAMODULESCORE = V.HAMODULESCORE
             ,S.HAMODULEVERSIONID = V.HAMODULEVERSIONID
             ,S.HAPAPERFLG = V.HAPAPERFLG
             ,S.HAQUESTIONDOCUMENTID = V.HAQUESTIONDOCUMENTID
             ,S.HAQUESTIONGUID = V.HAQUESTIONGUID
             ,S.HAQUESTIONNODEGUID = V.HAQUESTIONNODEGUID
             ,S.HAQUESTIONSCORE = V.HAQUESTIONSCORE
             ,S.HAQUESTIONVERSIONID = V.HAQUESTIONVERSIONID
             ,S.HARISKAREANODEGUID = V.HARISKAREANODEGUID
             ,S.HARISKAREASCORE = V.HARISKAREASCORE
             ,S.HARISKAREAVERSIONID = V.HARISKAREAVERSIONID
             ,S.HARISKCATEGORY_ITEMMODIFIEDWHEN = V.HARISKCATEGORY_ITEMMODIFIEDWHEN
             ,S.HARISKCATEGORYNODEGUID = V.HARISKCATEGORYNODEGUID
             ,S.HARISKCATEGORYSCORE = V.HARISKCATEGORYSCORE
             ,S.HARISKCATEGORYVERSIONID = V.HARISKCATEGORYVERSIONID
             ,S.HASCORE = V.HASCORE
             ,S.HASHCODE = V.HASHCODE
             ,S.HASTARTEDDT = V.HASTARTEDDT
             ,S.HASTARTEDMODE = V.HASTARTEDMODE
             ,S.HATELEPHONICFLG = V.HATELEPHONICFLG
             ,S.HAUSERANSWERS_ITEMMODIFIEDWHEN = V.HAUSERANSWERS_ITEMMODIFIEDWHEN
             ,S.HAUSERQUESTION_ITEMMODIFIEDWHEN = V.HAUSERQUESTION_ITEMMODIFIEDWHEN
             ,S.HAUSERRISKAREA_ITEMMODIFIEDWHEN = V.HAUSERRISKAREA_ITEMMODIFIEDWHEN
             ,S.HEALTHASSESMENTUSERSTARTEDNODEGUID = V.HEALTHASSESMENTUSERSTARTEDNODEGUID
             ,S.HEALTHASSESSMENTTYPE = V.HEALTHASSESSMENTTYPE
             ,S.HFITUSERMPINUMBER = V.HFITUSERMPINUMBER
             ,S.ISPROFESSIONALLYCOLLECTED = V.ISPROFESSIONALLYCOLLECTED
             ,S.ITEMCREATEDWHEN = V.ITEMCREATEDWHEN
             ,S.ITEMMODIFIEDWHEN = V.ITEMMODIFIEDWHEN
             ,S.MODULEPREWEIGHTEDSCORE = V.MODULEPREWEIGHTEDSCORE
               --,S.[PKHASHCODE] = V.[PKHASHCODE]
             ,
               S.POINTRESULTS = V.POINTRESULTS
             ,S.QUESTIONGROUPCODENAME = V.QUESTIONGROUPCODENAME
             ,S.QUESTIONPREWEIGHTEDSCORE = V.QUESTIONPREWEIGHTEDSCORE
             ,S.RISKAREAPREWEIGHTEDSCORE = V.RISKAREAPREWEIGHTEDSCORE
             ,S.RISKCATEGORYPREWEIGHTEDSCORE = V.RISKCATEGORYPREWEIGHTEDSCORE
             ,S.SITEGUID = V.SITEGUID
             ,S.TITLE = V.TITLE
             ,S.UOMCODE = V.UOMCODE
             ,S.USERANSWERCODENAME = V.USERANSWERCODENAME
             ,S.USERANSWERITEMID = V.USERANSWERITEMID
               --,S.[USERGUID] = V.[USERGUID]
             ,
               S.USERID = V.USERID
             ,S.USERMODULECODENAME = V.USERMODULECODENAME
             ,S.USERMODULEITEMID = V.USERMODULEITEMID
             ,S.USERQUESTIONCODENAME = V.USERQUESTIONCODENAME
             ,S.USERQUESTIONITEMID = V.USERQUESTIONITEMID
             ,S.USERRISKAREACODENAME = V.USERRISKAREACODENAME
             ,S.USERRISKAREAITEMID = V.USERRISKAREAITEMID
             ,S.USERRISKCATEGORYCODENAME = V.USERRISKCATEGORYCODENAME
             ,S.USERRISKCATEGORYITEMID = V.USERRISKCATEGORYITEMID
               --,S.[USERSTARTEDITEMID] = V.[USERSTARTEDITEMID]
             ,
               S.DBNAME = V.DBNAME
             ,S.SVR = V.SVR 
             ,S.LastModifiedDATE = V.LastModifiedDATE 
             ,S.DELETEDFLG = NULL
             ,S.ConvertedToCentralTime = NULL
             ,S.RowNbr = NULL
             ,S.TimeZone = NULL
               FROM
               view_EDW_PullHAData_NoCT AS V
                   JOIN
                   FACT_MART_EDW_HealthAssesment AS S
                       ON
                       S.UserStartedItemID = V.UserStartedItemID
                   AND S.UserGUID = V.UserGUID
                   AND S.PKHashCode = V.PKHashCode
                   AND S.HashCode != V.HashCode
				AND S.SVR = V.SVR  AND S.DBNAME = V.DBNAME 

    SET @ms = DATEDIFF (ms , @updtetime , GETDATE ()) ;
    SET @Secs = @ms / 1000;
    SET @Mins = @ms / 1000 / 60;
    SET @Hrs = @ms / 1000 / 60 / 60;
    PRINT 'Time required to apply updates @Mins: ' + CAST (@Mins AS NVARCHAR (50)) ;
    PRINT 'Time required to apply updates @Hrs : ' + CAST (@Hrs AS NVARCHAR (50)) ;

    SET @ms = DATEDIFF (ms , @ST , GETDATE ()) ;
    SET @Secs = @ms / 1000;
    SET @Mins = @ms / 1000 / 60;
    SET @Hrs = @ms / 1000 / 60 / 60;
    PRINT 'TOTAL execution time @Mins: ' + CAST (@Mins AS NVARCHAR (50)) ;
    PRINT 'TOTAL execution time @Hrs: ' + CAST (@Hrs AS NVARCHAR (50)) ;
    
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 

END;

GO
PRINT 'Executed proc_Apply_EDW_HA_Updates_ToStaging_Table.SQL';
GO
