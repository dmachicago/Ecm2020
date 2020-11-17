
/*------------------------------------------------------------
*************************************************************
TEST TEST_EDW_RewardUserDetail
**************************************************************
*/
SET NOCOUNT ON;
PRINT '****************************************************************';
PRINT '** TEST #1 proc_EDW_RewardUserDetail Initial counts ';
PRINT '****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'BACKUP_HFit_RewardsUserLevelDetail') 
    BEGIN
        SELECT
               * INTO
                      BACKUP_HFit_RewardsUserLevelDetail
               FROM HFit_RewardsUserLevelDetail;
        CREATE NONCLUSTERED INDEX PI_BACKUP_HFit_RewardsUserLevelDetail ON BACKUP_HFit_RewardsUserLevelDetail
        (
        ItemID , LevelCompletedDt
        );
    END;

/*-------------------------------------------------------------------------------------------
select top 1000 * from HFit_RewardsUserLevelDetail
--update HFit_RewardsUserLevelDetail set LevelCompletedDt = LevelCompletedDt where ItemID in 
--    (Select top 1 ItemID from HFit_RewardsUserLevelDetail order by ItemID desc)
*/
UPDATE HFit_RewardsUserLevelDetail
  SET
      LevelCompletedDt = GETDATE () 
       WHERE
             ItemID = 115104;
DELETE FROM HFit_RewardsUserLevelDetail
       WHERE
             ItemID = 68191;

DECLARE @iChanges AS int = 0;
EXEC @iChanges = proc_CkRewardUserDetailHasChanged ;
IF @iChanges = 0
    BEGIN
        PRINT 'NO Changes found for Reward User Details, competed.';
    END;
IF @iChanges = 1
    BEGIN
        PRINT 'Changes found NO DELETES.';
    END;
IF @iChanges = 2
    BEGIN
        PRINT 'DELETES Found.';
    END;

DECLARE
@testReload AS int = 1;
DECLARE
@DBN AS nvarchar ( 100) = DB_NAME () ;

DECLARE
@iCntCTRecs AS int = 0
, @iTotalRecs AS int = 0;

SET @iTotalRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_RewardUserDetail) ;
SET @iCntCTRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_RewardUserDetail_CT) ;
PRINT 'Row count from view_EDW_RewardUserDetail_CT : ' + CAST ( @iCntCTRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_RewardUserDetail: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

DECLARE
@iCntDIFF AS int = 0;
SET @iCntDIFF = @iCntCTRecs - @iTotalRecs;
IF @iCntDIFF = 0
    BEGIN
        PRINT 'PASSED: ROW DIFF Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50)) ;
    END;
ELSE
    BEGIN
        PRINT 'ERROR: Difference Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50)) ;
    END;

DECLARE
@StagingRecCnt AS int = ( SELECT
                                 COUNT ( *) 
                                 FROM DIM_EDW_RewardUserDetail) ;

IF
@testReload = 1 OR
@StagingRecCnt = 0
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_EDW_RewardUserDetail 1;

        SET @StagingRecCnt = ( SELECT
                                      COUNT ( *) 
                                      FROM DIM_EDW_RewardUserDetail) ;
        PRINT 'Records Loaded in initial load: ' + CAST ( @StagingRecCnt AS nvarchar ( 50)) ;
    END;

--*********************************************
--Test the LOAD Changes Only of the procedure
--*********************************************
EXEC proc_EDW_RewardUserDetail 0;
PRINT 'Records Loaded in staging table: ' + CAST ( @StagingRecCnt AS nvarchar (50)) ;
-- drop table ##Temp_RewardUserDetail
IF EXISTS ( SELECT
                   name
                   FROM tempdb.dbo.sysobjects
                   WHERE
                   id = OBJECT_ID ( N'tempdb..##Temp_RewardUserDetail')) 
    BEGIN
        PRINT 'ERROR - TEMP TABLE MISING - loading all!';
        DROP TABLE
             ##Temp_RewardUserDetail;
    END;

UPDATE DIM_EDW_RewardUserDetail
  SET
      DeletedFlg = NULL
    ,LastModifiedDate = NULL;

SELECT
       * INTO
              ##Temp_RewardUserDetail
       FROM view_EDW_RewardUserDetail_CT;

ALTER TABLE ##Temp_RewardUserDetail
ADD
            LastModifiedDate datetime2 (7) NULL;
ALTER TABLE ##Temp_RewardUserDetail
ADD
            RowNbr int IDENTITY ( 1 , 1) ;

ALTER TABLE ##Temp_RewardUserDetail
ADD
            DeletedFlg bit NULL;

ALTER TABLE ##Temp_RewardUserDetail
ADD
            ConvertedToCentralTime bit NULL;

ALTER TABLE ##Temp_RewardUserDetail
ADD
            TimeZone nvarchar (10) NULL;

CREATE CLUSTERED INDEX PI_TEMP_EDW_RewardUserDetail ON ##Temp_RewardUserDetail
(
UserGUID ASC ,
AccountID ASC ,
AccountCD ASC ,
SiteGUID ASC ,
HFitUserMpiNumber ASC ,
RewardActivityGUID ASC ,
RewardTriggerGUID ASC
)WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

/*---------------------------------------------------------------------------------
 select top 1000 * from ##Temp_RewardUserDetail
 select top 1000 * from DIM_EDW_RewardUserDetail where DeletedFlg is null ;
 select top 1000 * from DIM_EDW_RewardUserDetail where DeletedFlg is NOT null ;
*/

--**************************************
-- MARK DELETED RECORDS
DELETE FROM ##Temp_RewardUserDetail
       WHERE
             hashcode IN (SELECT TOP 5
                                 hashcode
                                 FROM ##Temp_RewardUserDetail
                                 ORDER BY
                                          hashcode) ;
DECLARE @iCntDEl AS int = 0;
EXEC @iCntDEl = proc_CT_RewardUserDetail_AddDeletedRecs ;
PRINT 'Records Marked as deleted: ' + CAST (@iCntDEl AS nvarchar (50)) ;

UPDATE ##Temp_RewardUserDetail
  SET
      AccountCD = UPPER ( AccountCD) 
       WHERE
             UserGUID IN ( SELECT TOP 5
                                  UserGUID
                                  FROM DIM_EDW_RewardUserDetail
                                  WHERE UserGUID IS NOT NULL
                                  ORDER BY
                                           UserGUID) ;
UPDATE ##Temp_RewardUserDetail
  SET
      HashCode = HASHBYTES ( 'sha1' ,
      ISNULL ( CAST ( UserGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( SiteGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( AccountCD AS nvarchar (100)) , '-')) 
       WHERE
             UserGUID IN ( SELECT TOP 5
                                  UserGUID
                                  FROM DIM_EDW_RewardUserDetail
                                  WHERE UserGUID IS NOT NULL
                                  ORDER BY
                                           UserGUID) ;

DECLARE @iCnt AS int = 0;
EXEC @iCnt = proc_CT_RewardUserDetail_AddUpdatedRecs ;
PRINT 'Updates applied: ' + CAST (@iCnt AS nvarchar (50)) ;

--**************************************
-- INSERT NEW RECORDS

DELETE FROM DIM_EDW_RewardUserDetail
       WHERE
             UserGUID IN ( SELECT DISTINCT TOP 5
                                  UserGUID
                                  FROM ##Temp_RewardUserDetail
                                  WHERE UserGUID IS NOT NULL
                                  ORDER BY
                                           UserGUID) ;
DECLARE @iCntNew AS int = 0;
EXEC @iCntNew = proc_CT_RewardUserDetail_AddNewRecs ;
PRINT 'New records added: ' + CAST (@iCntNew AS nvarchar (50)) ;

--update HFit_RewardsUserLevelDetail set LevelCompletedDt = getdate() where ItemID = 115104 ;
--delete from HFit_RewardsUserLevelDetail where ItemID = 68191 ;
--PUT BACK THE CHANGES
UPDATE
SRC
  SET
      LevelCompletedDt = BAK.LevelCompletedDt
      FROM
      HFit_RewardsUserLevelDetail SRC JOIN
      BACKUP_HFit_RewardsUserLevelDetail BAK
                                      ON
                                         SRC.ItemID = BAK.ItemID AND
                                         BAK.ItemID = 115104;

WITH CTE_NEW (
     ItemID
) 
    AS (
    SELECT
           ItemID
           FROM BACKUP_HFit_RewardsUserLevelDetail
    EXCEPT
    SELECT
           ItemID
           FROM HFit_RewardsUserLevelDetail
    ) 
    SELECT
           ItemID INTO
                       #XX
           FROM CTE_NEW;

SET IDENTITY_INSERT dbo.HFit_RewardsUserLevelDetail ON;
INSERT INTO HFit_RewardsUserLevelDetail
(
       ItemID
     , UserID
     , LevelVersionHistoryID
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , ItemOrder
     , ItemGUID
     , LevelCompletedDt
     , LevelNodeID
     , RewardGroupNodeId
     , RewardProgramNodeId) 
SELECT
       ItemID
     , UserID
     , LevelVersionHistoryID
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , ItemOrder
     , ItemGUID
     , LevelCompletedDt
     , LevelNodeID
     , RewardGroupNodeId
     , RewardProgramNodeId
       FROM BACKUP_HFit_RewardsUserLevelDetail
       WHERE BACKUP_HFit_RewardsUserLevelDetail.itemid = 68191;	    -- in(select * from #XX) ;

SET IDENTITY_INSERT dbo.HFit_RewardsUserLevelDetail OFF;

SET NOCOUNT OFF;
