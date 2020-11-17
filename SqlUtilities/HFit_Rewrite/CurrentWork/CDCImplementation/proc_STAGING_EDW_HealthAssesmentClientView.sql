

/*---------------------------------------
use KenticoCMS_Prod1

Developer	  :	 W. Dale Miller
05.28.2015  :	 WDM - completed unit testing
Last Tested :	 10.19.2015 WDM
*/

/*--------------------------------------------------------------------------------------------------------------------
select count(*),
 AccountID, AccountCD, AccountName, ClientGuid, SiteGUID, NodeSiteID, CampaignNodeGuid, HACampaignID, CodeName
from FACT_EDW_HealthAssesmentClientView
group by AccountID, AccountCD, AccountName, ClientGuid, SiteGUID, NodeSiteID, CampaignNodeGuid, HACampaignID, CodeName
select * from  FACT_EDW_HealthAssesmentClientView
exec proc_EDW_HealthAssesmentClientView 1
exec proc_EDW_HealthAssesmentClientView
*/

GO
PRINT 'creating proc_EDW_HealthAssesmentClientView';
PRINT GETDATE () ;
GO

IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_EDW_HealthAssesmentClientView') 
    BEGIN
        PRINT 'Replacing proc_EDW_HealthAssesmentClientView';
        DROP PROCEDURE
             proc_EDW_HealthAssesmentClientView;
    END;

GO
--drop table FACT_EDW_HealthAssesmentClientView
--exec proc_EDW_HealthAssesmentClientView 
--exec proc_EDW_HealthAssesmentClientView 1
CREATE PROCEDURE proc_EDW_HealthAssesmentClientView (
     @Reloadall AS int = NULL) 
AS
BEGIN
    BEGIN

/*--------------------------------------------------------------------------------------------
    AUTHOR: W. Dale Miller
    WDM - This proc is executed by JOB the file create_job_EDW_getStaging_RewardUserDetail.sql
*/
        --DECLARE @Reloadall AS int = 0;
        DECLARE
        @iTotal AS bigint = 0;

        EXEC @iTotal = proc_QuickRowCount 'FACT_EDW_HealthAssesmentClientView';

        IF @iTotal = 1
            BEGIN
                PRINT 'NO RECORDS FOUND IN STAGING TABLE - Reloading all.';
                SET @Reloadall = 1;
            END;

        SET NOCOUNT ON;

        DECLARE
        @RecordID AS uniqueidentifier = NEWID () ;
        DECLARE
        @CT_DateTimeNow AS datetime = GETDATE () ;
        DECLARE
        @CT_NAME AS nvarchar ( 50) = 'proc_EDW_RewardUserDetail';
        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , 0 , 'I';

        IF @Reloadall = 1
            BEGIN
                PRINT 'RELOADING table FACT_EDW_HealthAssesmentClientView';
                DROP TABLE
                     FACT_EDW_HealthAssesmentClientView;
            END;

        IF NOT EXISTS ( SELECT
                               name
                               FROM sys.tables
                               WHERE name = 'FACT_EDW_HealthAssesmentClientView') 
            BEGIN
                SELECT
                       * INTO
                              FACT_EDW_HealthAssesmentClientView
                       FROM view_EDW_HealthAssesmentClientView_CT;
                DECLARE
                @irecs AS int = @@ROWCOUNT;

                EXEC proc_Add_EDW_CT_StdCols 'FACT_EDW_HealthAssesmentClientView';

                PRINT 'RELOAD Count: ' + CAST ( @irecs AS nvarchar ( 50)) ;
                EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @irecs;
                EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @irecs , 'U';

                SET ANSI_PADDING ON;

                CREATE CLUSTERED INDEX PI_EDW_HealthAssesmentClientView ON dbo.FACT_EDW_HealthAssesmentClientView ( AccountID , AccountCD , AccountName , ClientGuid , SiteGUID
                --, CompanyID
                --, CompanyGUID
                , NodeSiteID , CampaignNodeGuid , HACampaignID , CodeName) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                CREATE NONCLUSTERED INDEX PI_EDW_HealthAssesmentClientView_RowNbrCDate ON dbo.FACT_EDW_HealthAssesmentClientView ( RowNbr , LastModifiedDate , DeletedFlg) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

                EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_HealthAssesmentClientView';

                RETURN;
            END;
        --select * from tempdb.information_schema.columns where table_name = '##Temp_HealthAssesmentClientView'
        --select * from information_schema.columns where table_name = 'FACT_EDW_HealthAssesmentClientView'
        IF EXISTS ( SELECT
                           table_name
                           FROM tempdb.information_schema.tables
                           WHERE table_name = '##Temp_HealthAssesmentClientView') 
            BEGIN
                PRINT 'Dropping ##Temp_HealthAssesmentClientView';
                DROP TABLE
                     ##Temp_HealthAssesmentClientView;
            END;

        SELECT
               * INTO
                      ##Temp_HealthAssesmentClientView
               FROM view_EDW_HealthAssesmentClientView_CT;

        EXEC proc_Add_EDW_CT_StdCols '##Temp_HealthAssesmentClientView';

        EXEC proc_EDW_CT_ExecutionLog_Update @RecordID , @CT_NAME , @CT_DateTimeNow , @@ROWCOUNT , 'U';

        CREATE CLUSTERED INDEX PI_TEMP_EDW_HealthAssesmentClientView ON ##Temp_HealthAssesmentClientView ( AccountID , AccountCD , AccountName , ClientGuid , SiteGUID
        --, CompanyID
        --, CompanyGUID
        , NodeSiteID , CampaignNodeGuid , HACampaignID , CodeName) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

        --************************************************
        --get the NEW records and insert them
        --************************************************
        --select top 100 * from FACT_EDW_HealthAssesmentClientView
        --delete from FACT_EDW_HealthAssesmentClientView where AccountID = 9 
        --select count(*) from ##Temp_HealthAssesmentClientView 
        --select count(*) from FACT_EDW_HealthAssesmentClientView
        WITH CTE_NEW (
             AccountID
           , AccountCD
           , AccountName
           , ClientGuid
           , SiteGUID
           , NodeSiteID
           , CampaignNodeGuid
           , HACampaignID
           , CodeName) 
            AS ( SELECT
                        AccountID
                      , AccountCD
                      , AccountName
                      , ClientGuid
                      , SiteGUID
                      , NodeSiteID
                      , CampaignNodeGuid
                      , HACampaignID
                      , CodeName
                        FROM ##Temp_HealthAssesmentClientView
                 EXCEPT
                 SELECT
                        AccountID
                      , AccountCD
                      , AccountName
                      , ClientGuid
                      , SiteGUID
                      , NodeSiteID
                      , CampaignNodeGuid
                      , HACampaignID
                      , CodeName
                        FROM FACT_EDW_HealthAssesmentClientView
                        WHERE LastModifiedDate IS NULL) 
            INSERT INTO FACT_EDW_HealthAssesmentClientView
            (
                   AccountID
                 , AccountCD
                 , AccountName
                 , ClientGuid
                 , SiteGUID
                 , CompanyID
                 , CompanyGUID
                 , CompanyName
                 , DocumentName
                 , HAStartDate
                 , HAEndDate
                 , NodeSiteID
                 , Title
                 , CodeName
                 , IsEnabled
                 , ChangeType
                 , DocumentCreatedWhen
                 , DocumentModifiedWhen
                 , AssesmentModule_DocumentModifiedWhen
                 , DocumentCulture_HAAssessmentMod
                 , DocumentCulture_HACampaign
                 , DocumentCulture_HAJoined
                 , BiometricCampaignStartDate
                 , BiometricCampaignEndDate
                 , CampaignStartDate
                 , CampaignEndDate
                 , Name
                 , CampaignNodeGuid
                 , HACampaignID
                 , HashCode
                 , LastModifiedDate
                 , RowNbr
                 , DeletedFlg
                 , ConvertedToCentralTime
                 , TimeZone
                 , SVR
                 , DBNAME) 
            SELECT
                   T.AccountID
                 , T.AccountCD
                 , T.AccountName
                 , T.ClientGuid
                 , T.SiteGUID
                 , T.CompanyID
                 , T.CompanyGUID
                 , T.CompanyName
                 , T.DocumentName
                 , T.HAStartDate
                 , T.HAEndDate
                 , T.NodeSiteID
                 , T.Title
                 , T.CodeName
                 , T.IsEnabled
                 , T.ChangeType
                 , T.DocumentCreatedWhen
                 , T.DocumentModifiedWhen
                 , T.AssesmentModule_DocumentModifiedWhen
                 , T.DocumentCulture_HAAssessmentMod
                 , T.DocumentCulture_HACampaign
                 , T.DocumentCulture_HAJoined
                 , T.BiometricCampaignStartDate
                 , T.BiometricCampaignEndDate
                 , T.CampaignStartDate
                 , T.CampaignEndDate
                 , T.Name
                 , T.CampaignNodeGuid
                 , T.HACampaignID
                 , T.HashCode
                 , NULL AS LastModifiedDate
                 , NULL AS RowNbr
                 , NULL AS DeletedFlg
                 , NULL AS ConvertedToCentralTime
                 , NULL AS TimeZone
                 , SVR
                 , DBNAME
                   FROM
                       ##Temp_HealthAssesmentClientView AS T
                           JOIN CTE_NEW AS C
                               ON C.AccountID = T.AccountID
                              AND C.AccountCD = T.AccountCD
                              AND C.AccountName = T.AccountName
                              AND C.ClientGuid = T.ClientGuid
                              AND C.SiteGUID = T.SiteGUID
                              AND C.NodeSiteID = T.NodeSiteID
                              AND C.CampaignNodeGuid = T.CampaignNodeGuid
                              AND C.HACampaignID = T.HACampaignID
                              AND C.CodeName = T.CodeName;

        DECLARE
        @iIns AS int = @@ROWCOUNT;
        PRINT 'Insert Count: ' + CAST ( @iIns AS nvarchar (50)) ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'I' , @iIns;

        --************************************************
        --get the changed records and update them
        --select top 100 * from FACT_EDW_HealthAssesmentClientView
        --update FACT_EDW_HealthAssesmentClientView set HashCode = (select top 1 HashCode from FACT_EDW_HealthAssesmentClientView where AccountId = 2)  where AccountID = 8
        --select * from ##Temp_HealthAssesmentClientView 
        --select count(*) from FACT_EDW_HealthAssesmentClientView
        --Use below to test:
        --delete from ##Temp_HealthAssesmentClientView where HACampaignID = 49 ;
        --update ##Temp_HealthAssesmentClientView set hashcode = hashbytes ('sha1','YYYY') where HACampaignID = 50 ;
        --************************************************
        DECLARE
        @RUNDATE AS datetime2 ( 7) = GETDATE () ;

        UPDATE S
               SET
                   S.CompanyName = T.CompanyName
                 ,S.DocumentName = T.DocumentName
                 ,S.HAStartDate = T.HAStartDate
                 ,S.HAEndDate = T.HAEndDate
                 ,S.Title = T.Title
                 ,S.CodeName = T.CodeName
                 ,S.IsEnabled = T.IsEnabled
                 ,S.ChangeType = T.ChangeType
                 ,S.DocumentCreatedWhen = T.DocumentCreatedWhen
                 ,S.DocumentModifiedWhen = T.DocumentModifiedWhen
                 ,S.AssesmentModule_DocumentModifiedWhen = T.AssesmentModule_DocumentModifiedWhen
                 ,S.DocumentCulture_HAAssessmentMod = T.DocumentCulture_HAAssessmentMod
                 ,S.DocumentCulture_HACampaign = T.DocumentCulture_HACampaign
                 ,S.DocumentCulture_HAJoined = T.DocumentCulture_HAJoined
                 ,S.BiometricCampaignStartDate = T.BiometricCampaignStartDate
                 ,S.BiometricCampaignEndDate = T.BiometricCampaignEndDate
                 ,S.CampaignStartDate = T.CampaignStartDate
                 ,S.CampaignEndDate = T.CampaignEndDate
                 ,S.Name = T.Name
                 ,S.HashCode = T.HashCode
                 ,S.LastModifiedDate = @RUNDATE
                 ,S.DeletedFlg = NULL
                 ,S.ConvertedToCentralTime = NULL
                   FROM ##Temp_HealthAssesmentClientView AS T
                            JOIN FACT_EDW_HealthAssesmentClientView AS S
                                ON
                                S.AccountID = T.AccountID
                            AND S.AccountCD = T.AccountCD
                            AND S.AccountName = T.AccountName
                            AND S.ClientGuid = T.ClientGuid
                            AND S.SiteGUID = T.SiteGUID
                            AND S.NodeSiteID = T.NodeSiteID
                            AND S.CampaignNodeGuid = T.CampaignNodeGuid
                            AND S.HACampaignID = T.HACampaignID
                            AND S.HASHCODE != T.HASHCODE
                            AND S.LastModifiedDate IS NULL
                            AND S.CodeName = T.CodeName;

        DECLARE
        @iUpdt AS int = @@ROWCOUNT;
        PRINT 'Update Count: ' + CAST ( @iUpdt AS nvarchar (50)) ;
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'U' , @iUpdt;

        --************************************************
        --select top 100 * from ##Temp_HealthAssesmentClientView
        --delete from ##Temp_HealthAssesmentClientView where HFitUserMpiNumber = 8021925

        --get the deleted records flag them
        --************************************************
        --select top 100 * from ##Temp_HealthAssesmentClientView
        --delete from ##Temp_HealthAssesmentClientView where AccountID = 9
        DECLARE
        @DELDATE AS datetime2 ( 7) = GETDATE () ;
        WITH CTE_DEL (
             AccountID
           , AccountCD
           , AccountName
           , ClientGuid
           , SiteGUID
             --, CompanyID
             --, CompanyGUID
           ,
             NodeSiteID
           , CampaignNodeGuid
           , HACampaignID
           , CodeName) 
            AS ( SELECT
                        AccountID
                      , AccountCD
                      , AccountName
                      , ClientGuid
                      , SiteGUID
                      , NodeSiteID
                      , CampaignNodeGuid
                      , HACampaignID
                      , CodeName
                        FROM FACT_EDW_HealthAssesmentClientView
                 EXCEPT
                 SELECT
                        AccountID
                      , AccountCD
                      , AccountName
                      , ClientGuid
                      , SiteGUID
                      , NodeSiteID
                      , CampaignNodeGuid
                      , HACampaignID
                      , CodeName
                        FROM ##Temp_HealthAssesmentClientView) 

            UPDATE S
                   SET
                       DeletedFlg = 1
                     ,LastModifiedDate = @DELDATE
                       FROM FACT_EDW_HealthAssesmentClientView AS S
                                JOIN CTE_DEL AS C
                                    ON
                                    S.AccountID = C.AccountID
                                AND S.AccountCD = C.AccountCD
                                AND S.AccountName = C.AccountName
                                AND S.ClientGuid = C.ClientGuid
                                AND S.SiteGUID = C.SiteGUID
                                AND S.NodeSiteID = C.NodeSiteID
                                AND S.CampaignNodeGuid = C.CampaignNodeGuid
                                AND S.HACampaignID = C.HACampaignID
                                AND S.CodeName = C.CodeName;

        DECLARE
        @idel AS int = @@ROWCOUNT;
        PRINT 'Delete Count: ' + CAST ( @idel  AS nvarchar (50)) ;

        EXEC proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_HealthAssesmentClientView';
        EXEC proc_EDW_CT_ExecutionLog_Update_Counts @RecordID , 'D' , @idel;

        PRINT 'Records Marked As Deleted: ' + CAST ( @@RowCount AS nvarchar (5)) ;
    END;
END;

GO
PRINT 'CREATED proc_EDW_HealthAssesmentClientView';
PRINT GETDATE () ;
GO
