

go
-- USE KenticoCMS_Prod1

/*------------------------------------------------------------
*************************************************************
TEST TEST_EDW_RewardsDefinition
**************************************************************
*/
SET NOCOUNT ON;
PRINT '****************************************************************';
PRINT '** TEST #1 proc_EDW_RewardsDefinition Initial counts ';
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
                           FROM view_EDW_RewardsDefinition) ;
SET @iCntCTRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_RewardsDefinition_CT) ;
PRINT 'Row count from view_EDW_RewardsDefinition_CT : ' + CAST ( @iCntCTRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_RewardsDefinition: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

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
                                 FROM DIM_EDW_RewardsDefinition) ;

IF
   @testReload = 1 OR
   @StagingRecCnt = 0
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_EDW_RewardsDefinition 1 ;

        SET @StagingRecCnt = ( SELECT
                                      COUNT ( *) 
                                      FROM DIM_EDW_RewardsDefinition) ;
        PRINT 'Records Loaded in initial load: ' + CAST ( @StagingRecCnt AS nvarchar ( 50)) ;
    END;

--Test the LOAD Changes Only of the procedure
EXEC proc_EDW_RewardsDefinition 0 , 1 , 0;
PRINT 'Records Loaded in staging table: ' + CAST ( @StagingRecCnt AS nvarchar (50)) ;
-- drop table ###TEMP_EDW_RewardsDefinition_DATA
IF EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE
                       id = OBJECT_ID ( N'tempdb..##TEMP_EDW_RewardsDefinition_DATA')) 
    BEGIN
        PRINT 'RELOADING TEMP TABLE - loading all!';
        drop table ##TEMP_EDW_RewardsDefinition_DATA ;
    END;

update DIM_EDW_RewardsDefinition SET DeletedFlg = null, LastModifiedDate = null;
select * into ##TEMP_EDW_RewardsDefinition_DATA from DIM_EDW_RewardsDefinition ;
CREATE CLUSTERED INDEX temp_PI_EDW_RewardsDefinition_IDs ON dbo.##TEMP_EDW_RewardsDefinition_DATA ( SiteGUID , AccountID , AccountCD , RewardProgramGUID , RewardGroupGuid , RewardLevelGuid , RewardActivityGuid , RewardTriggerGuid , RewardTriggerParmGUID ) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON );

/*
 select * from ##TEMP_EDW_RewardsDefinition_DATA
 select top 10 * from DIM_EDW_RewardsDefinition where DeletedFlg is null ;
 select top 1000 * from DIM_EDW_RewardsDefinition where DeletedFlg is NOT null ;
*/


--**************************************
-- MARK DELETED RECORDS
DELETE FROM ##TEMP_EDW_RewardsDefinition_DATA
       WHERE
             TriggerName IN ( SELECT TOP 1
                                  TriggerNAme
                                  FROM DIM_EDW_RewardsDefinition
                                  ORDER BY
                                           TriggerNAme desc ) ;

declare @iCntDEl as int = 0 ; 
EXEC @iCntDEl = proc_CT_RewardsDefinition_AddDeletedRecs ;
PRINT 'Records Marked as deleted: ' + CAST (@iCntDEl AS nvarchar (50)) ;

UPDATE ##TEMP_EDW_RewardsDefinition_DATA
  SET
      TriggerName = lower ( TriggerName) 
       WHERE
             TriggerName IN ( SELECT TOP 1
                                  TriggerName
                                  FROM DIM_EDW_RewardsDefinition
                                  WHERE TriggerName IS NOT NULL
                                  ORDER BY
                                           TriggerName  ) ;

UPDATE ##TEMP_EDW_RewardsDefinition_DATA
  SET HashCode = 
	   hashbytes ('sha1',
	 isNull(cast( SiteGUID as nvarchar(50)),'-')
	 + isNull(cast( AccountID as nvarchar(50)),'-')
	 + isNull(cast( AccountCD as nvarchar(50)),'-')
	 
+ isNull(left( RewardLevelTypeLKPName,250),'-')
+ isNull(left( AwardDisplayName,250),'-')

+ isNull(left( TriggerName,250),'-')

)
      WHERE
             TriggerName IN ( SELECT TOP 1
                                  TriggerName
                                  FROM DIM_EDW_RewardsDefinition
                                  WHERE TriggerName IS NOT NULL
                                  ORDER BY
                                           TriggerName  ) ;

DECLARE @iCnt AS int = 0;
EXEC @iCnt = proc_CT_RewardsDefinition_AddUpdatedRecs ;
PRINT 'Updates applied: ' + CAST (@iCnt AS nvarchar (50)) ;

--**************************************
-- INSERT NEW RECORDS

DELETE FROM DIM_EDW_RewardsDefinition
       WHERE
             TriggerName IN ( SELECT TOP 1
                                  TriggerName
                                  FROM DIM_EDW_RewardsDefinition
                                  WHERE TriggerName IS NOT NULL
                                  ORDER BY
                                           TriggerName  ) ;
declare @iCntNew as int = 0 ;
EXEC @iCntNew = proc_CT_RewardsDefinition_AddNewRecs ;
PRINT 'New records added: ' + CAST (@iCntNew AS nvarchar (50)) ;



SET NOCOUNT OFF;
