
/*------------------------------------------------------------
*************************************************************
TEST TEST_EDW_RewardAwardDetail
**************************************************************
*/
SET NOCOUNT ON;
PRINT '****************************************************************';
PRINT '** TEST #1 proc_EDW_RewardAwardDetail Initial counts ';
PRINT '****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

DECLARE
@testReload AS int = 1;
DECLARE
@DBN AS nvarchar ( 100) = DB_NAME () ;

DECLARE
@iCntCTRecs AS int = 0
, @iTotalRecs AS int = 0;

SET @iTotalRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_RewardAwardDetail) ;
SET @iCntCTRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_RewardAwardDetail_CT) ;
PRINT 'Row count from view_EDW_RewardAwardDetail_CT : ' + CAST ( @iCntCTRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_RewardAwardDetail: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

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
                                 FROM DIM_EDW_RewardAwardDetail) ;

IF
   @testReload = 1 OR
   @StagingRecCnt = 0
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_EDW_RewardAwardDetail 1 ;

        SET @StagingRecCnt = ( SELECT
                                      COUNT ( *) 
                                      FROM DIM_EDW_RewardAwardDetail) ;
        PRINT 'Records Loaded in initial load: ' + CAST ( @StagingRecCnt AS nvarchar ( 50)) ;
    END;

--Test the LOAD Changes Only of the procedure
EXEC proc_EDW_RewardAwardDetail 0 , 1 , 0;
PRINT 'Records Loaded in staging table: ' + CAST ( @StagingRecCnt AS nvarchar (50)) ;
-- drop table ##TEMP_EDW_RewardAwardDetail_DATA
IF EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE
                       id = OBJECT_ID ( N'tempdb..##TEMP_EDW_RewardAwardDetail_DATA')) 
    BEGIN
        PRINT 'ERROR - TEMP TABLE MISING - loading all!';
        drop table ##TEMP_EDW_RewardAwardDetail_DATA ;
    END;

update DIM_EDW_RewardAwardDetail SET DeletedFlg = null, LastModifiedDate = null;
select * into ##TEMP_EDW_RewardAwardDetail_DATA from DIM_EDW_RewardAwardDetail ;

/*
 select * from ##TEMP_EDW_RewardAwardDetail_DATA
 select top 1000 * from DIM_EDW_RewardAwardDetail where DeletedFlg is null ;
 select top 1000 * from DIM_EDW_RewardAwardDetail where DeletedFlg is NOT null ;
*/


--**************************************
-- MARK DELETED RECORDS
DELETE FROM ##TEMP_EDW_RewardAwardDetail_DATA
       WHERE
             UserGUID IN ( SELECT TOP 2
                                  UserGUID
                                  FROM DIM_EDW_RewardAwardDetail
                                  WHERE UserGUID IS NOT NULL    --and AwardType = 7
                                  ORDER BY
                                           UserGUID desc ) and AwardType = 7 ;
declare @iCntDEl as int = 0 ; 
EXEC @iCntDEl = proc_CT_RewardAwardDetail_AddDeletedRecs ;
PRINT 'Records Marked as deleted: ' + CAST (@iCntDEl AS nvarchar (50)) ;

UPDATE ##TEMP_EDW_RewardAwardDetail_DATA
  SET
      AwardDisplayName = lower ( AwardDisplayName) 
       WHERE
             UserGUID IN ( SELECT TOP 5
                                  UserGUID
                                  FROM DIM_EDW_RewardAwardDetail
                                  WHERE UserGUID IS NOT NULL
                                  ORDER BY
                                           UserGUID) ;
UPDATE ##TEMP_EDW_RewardAwardDetail_DATA
  SET HashCode = HASHBYTES ( 'sha1' ,
      ISNULL ( CAST ( UserGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( SiteGUID AS nvarchar (100)) , '-') + ISNULL ( CAST ( AwardDisplayName AS nvarchar (100)), '-') )
       WHERE
             UserGUID IN ( SELECT TOP 5
                                  UserGUID
                                  FROM DIM_EDW_RewardAwardDetail
                                  WHERE UserGUID IS NOT NULL
                                  ORDER BY
                                           UserGUID) ;

DECLARE @iCnt AS int = 0;
EXEC @iCnt = proc_CT_RewardAwardDetail_AddUpdatedRecs ;
PRINT 'Updates applied: ' + CAST (@iCnt AS nvarchar (50)) ;

--**************************************
-- INSERT NEW RECORDS

DELETE FROM DIM_EDW_RewardAwardDetail
       WHERE
             UserGUID IN ( SELECT distinct TOP 5
                                  UserGUID
                                  FROM ##TEMP_EDW_RewardAwardDetail_DATA
                                  WHERE UserGUID IS NOT NULL
                                  ORDER BY
                                           UserGUID  ) ;
declare @iCntNew as int = 0 ;
EXEC @iCntNew = proc_CT_RewardAwardDetail_AddNewRecs ;
PRINT 'New records added: ' + CAST (@iCntNew AS nvarchar (50)) ;



SET NOCOUNT OFF;
