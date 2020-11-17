

GO
-- USE KenticoCMS_Prod1

/*------------------------------------------------------------
*************************************************************
TEST TEST_EDW_RewardTriggerParameters
**************************************************************
*/
SET NOCOUNT ON;
PRINT '****************************************************************';
PRINT '** TEST #1 proc_EDW_RewardTriggerParameters Initial counts ';
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
                           FROM view_EDW_RewardTriggerParameters) ;
SET @iCntCTRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_RewardTriggerParameters_CT) ;
PRINT 'Row count from view_EDW_RewardTriggerParameters_CT : ' + CAST ( @iCntCTRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_RewardTriggerParameters: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

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
                                 FROM DIM_EDW_RewardTriggerParameters) ;

IF
@testReload = 1 OR
@StagingRecCnt = 0
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_EDW_RewardTriggerParameters 1;

        SET @StagingRecCnt = ( SELECT
                                      COUNT ( *) 
                                      FROM DIM_EDW_RewardTriggerParameters) ;
        PRINT 'Records Loaded in initial load: ' + CAST ( @StagingRecCnt AS nvarchar ( 50)) ;
    END;

--Test the LOAD Changes Only of the procedure
PRINT 'LOADING ONLY CHANGED RECORDS.';
EXEC proc_EDW_RewardTriggerParameters 0 , 1 , 0;
declare @iChageCnt as int = (select count(*) from ##TEMP_RewardTriggerParameters) ;
PRINT 'Records with changes loaded into temp table: ' + CAST ( @iChageCnt AS nvarchar (50)) ;
-- drop table ##TEMP_RewardTriggerParameters
IF EXISTS ( SELECT
                   name
                   FROM tempdb.dbo.sysobjects
                   WHERE
                   id = OBJECT_ID ( N'tempdb..##TEMP_RewardTriggerParameters')) 
    BEGIN
        PRINT 'RELOADING TEMP TABLE - loading all!';
        DROP TABLE
             ##TEMP_RewardTriggerParameters;
    END;

UPDATE DIM_EDW_RewardTriggerParameters
  SET
      DeletedFlg = NULL
    ,LastModifiedDate = NULL;
SELECT
       * INTO
              ##TEMP_RewardTriggerParameters
       FROM DIM_EDW_RewardTriggerParameters;
EXEC proc_Add_EDW_CT_StdCols '##TEMP_RewardTriggerParameters';
CREATE CLUSTERED INDEX temp_PI_EDW_RewardTriggerParameters_IDs ON dbo.##TEMP_RewardTriggerParameters (
SiteGUID
, RewardTriggerID
, ParameterDisplayName
, RewardTriggerParameterOperator
, [Value]
, AccountID
, AccountCD
, DocumentGuid
, NodeGuid) 
WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

/*----------------------------------------------------------------------------------------
 select * from ##TEMP_RewardTriggerParameters
 select top 10 * from DIM_EDW_RewardTriggerParameters where DeletedFlg is null ;
 select top 1000 * from DIM_EDW_RewardTriggerParameters where DeletedFlg is NOT null ;
*/

--**************************************
-- MARK DELETED RECORDS
DELETE FROM ##TEMP_RewardTriggerParameters
       WHERE
             TriggerName IN ( SELECT TOP 1
                                     TriggerNAme
                                     FROM DIM_EDW_RewardTriggerParameters
                                     ORDER BY
                                              TriggerNAme DESC) ;

DECLARE @iCntDEl AS int = 0;
EXEC @iCntDEl = proc_CT_RewardTriggerParameters_AddDeletedRecs ;
PRINT 'Records Marked as deleted: ' + CAST (@iCntDEl AS nvarchar (50)) ;

UPDATE ##TEMP_RewardTriggerParameters
  SET
      TriggerName = LOWER ( TriggerName) 
       WHERE
             TriggerName IN ( SELECT TOP 1
                                     TriggerName
                                     FROM DIM_EDW_RewardTriggerParameters
                                     WHERE TriggerName IS NOT NULL
                                     ORDER BY
                                              TriggerName) ;

UPDATE ##TEMP_RewardTriggerParameters
  SET
      HashCode = HASHBYTES ('sha1' ,
      ISNULL (CAST ( SiteGUID AS nvarchar (50)) , '-') + ISNULL (CAST ( AccountID AS nvarchar (50)) , '-') + ISNULL (CAST ( AccountCD AS nvarchar (50)) , '-') + ISNULL (LEFT ( TriggerName , 250) , '-') 

      ) 
       WHERE
             TriggerName IN ( SELECT TOP 1
                                     TriggerName
                                     FROM DIM_EDW_RewardTriggerParameters
                                     WHERE TriggerName IS NOT NULL
                                     ORDER BY
                                              TriggerName) ;

DECLARE @iCnt AS int = 0;
EXEC @iCnt = proc_CT_RewardTriggerParameters_AddUpdatedRecs ;
PRINT 'Updates applied: ' + CAST (@iCnt AS nvarchar (50)) ;

--**************************************
-- INSERT NEW RECORDS

DELETE FROM DIM_EDW_RewardTriggerParameters
       WHERE
             TriggerName IN ( SELECT TOP 1
                                     TriggerName
                                     FROM DIM_EDW_RewardTriggerParameters
                                     WHERE TriggerName IS NOT NULL
                                     ORDER BY
                                              TriggerName) ;
DECLARE @iCntNew AS int = 0;
EXEC @iCntNew = proc_CT_RewardTriggerParameters_AddNewRecs ;
PRINT 'New records added: ' + CAST (@iCntNew AS nvarchar (50)) ;

SET NOCOUNT OFF;
