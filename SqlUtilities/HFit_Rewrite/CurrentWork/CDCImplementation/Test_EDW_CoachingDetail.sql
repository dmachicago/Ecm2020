
/*------------------------------------------------------------
*************************************************************
TEST proc_EDW_CoachingDetail
**************************************************************
 SELECT
                           top 10 *
                           FROM view_EDW_CoachingDetail_CT;
 SELECT
                           top 10 *
                           FROM view_EDW_CoachingDetail_MART;
*/
SET NOCOUNT ON;

PRINT '****************************************************************';
PRINT '** TEST #1 proc_EDW_CoachingDetail Initial counts ';
PRINT '****************************************************************';

DECLARE
@iCntCTRecs AS int = 0
, @iTotalRecs AS int = 0
, @testReload AS int = 1;

SET @iTotalRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_CoachingDetail_MART) ;
SET @iCntCTRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_CoachingDetail_CT) ;
PRINT 'Row count from view_EDW_CoachingDetail_CT : ' + CAST ( @iCntCTRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_CoachingDetail_MART: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

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
                                 FROM DIM_EDW_CoachingDetail) ;
IF @testReload = 1
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_EDW_CoachingDetail 1 , 1 , 0;

        SET @StagingRecCnt = ( SELECT
                                      COUNT ( *) 
                                      FROM DIM_EDW_CoachingDetail) ;
        PRINT 'Records Loaded in initial load: ' + CAST ( @StagingRecCnt AS nvarchar ( 50)) ;
    END;

/*----------------------------------------------------------------------------------
select top 100 * from DIM_EDW_CoachingDetail
select top 100 * from ##TEMP_EDW_CoachingDetail_DATA
select * into ##TEMP_EDW_CoachingDetail_DATA from DIM_EDW_CoachingDetail
*/

--Test the LOAD Changes Only of the procedure
--EXEC proc_EDW_CoachingDetail 0 , 1 , 0;
--PRINT 'Records Loaded in staging table: ' + CAST( @StagingRecCnt AS nvarchar( 50 ));

if exists (Select top 1 table_name from tempdb.information_schema.tables where table_name = '##TEMP_EDW_CoachingDetail_DATA')
    drop table ##TEMP_EDW_CoachingDetail_DATA;

SELECT
       * INTO
              ##TEMP_EDW_CoachingDetail_DATA
       FROM DIM_EDW_CoachingDetail;

EXEC proc_Add_EDW_CT_StdCols '##TEMP_EDW_CoachingDetail_DATA';

CREATE CLUSTERED INDEX temp_PI_EDW_CoachingDetail_IDs ON dbo.##TEMP_EDW_CoachingDetail_DATA ( ItemID
, ItemGUID
, GoalID
, UserGUID
, SiteGUID
, AccountID
, AccountCD
, WeekendDate
, NodeGUID) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF ,
SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

IF NOT EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE
                       id = OBJECT_ID ( N'tempdb..##TEMP_EDW_CoachingDetail_DATA')) 
    BEGIN
        PRINT 'ERROR - TEMP TABLE MISING - ABORTING!';
        RETURN;
    END;

UPDATE ##TEMP_EDW_CoachingDetail_DATA
  SET
      AccountName = LOWER ( AccountName) 
       WHERE
             ItemId IN ( SELECT TOP 5
                                ItemID
                                FROM DIM_EDW_CoachingDetail
                                WHERE ItemID IS NOT NULL
                                ORDER BY
                                         ItemID , WeekendDate) ;
UPDATE ##TEMP_EDW_CoachingDetail_DATA
  SET
      HashCode = HASHBYTES ('sha1' ,
      ISNULL (CAST (ItemID AS nvarchar (100)) , '-') + ISNULL (CAST ( ItemGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( GoalID AS nvarchar (100)) , '-') + ISNULL (CAST ( UserID AS nvarchar (100)) , '-') + ISNULL (CAST ( UserGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( HFitUserMpiNumber AS nvarchar (100)) , '-') + ISNULL (CAST ( SiteGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( AccountID AS nvarchar (100)) , '-') + ISNULL (CAST ( AccountCD AS nvarchar (100)) , '-') + ISNULL (CAST ( AccountName AS nvarchar (500)) , '-') + ISNULL (CAST ( IsCreatedByCoach AS nvarchar (100)) , '-') + ISNULL (CAST ( BaselineAmount AS nvarchar (100)) , '-') + ISNULL (CAST ( GoalAmount AS nvarchar (100)) , '-') + ISNULL (CAST ( GoalStatusLKPID AS nvarchar (100)) , '-') + ISNULL (CAST ( GoalStatusLKPName AS nvarchar (500)) , '-') + ISNULL (CAST ( EvaluationStartDate AS nvarchar (100)) , '-') + ISNULL (CAST ( EvaluationEndDate AS nvarchar (100)) , '-') + ISNULL (CAST ( GoalStartDate AS nvarchar (100)) , '-') + ISNULL (LEFT ( CoachDescription , 1000) , '-') + ISNULL (CAST ( EvaluationDate AS nvarchar (100)) , '-') + ISNULL (CAST ( Passed AS nvarchar (100)) , '-') + ISNULL (CAST ( WeekendDate AS nvarchar (100)) , '-') + ISNULL (CAST ( ItemCreatedWhen AS nvarchar (100)) , '-') + ISNULL (CAST ( ItemModifiedWhen AS nvarchar (100)) , '-') + ISNULL (CAST ( NodeGUID AS nvarchar (100)) , '-') + ISNULL (CAST ( CloseReasonLKPID AS nvarchar (100)) , '-') + ISNULL (CAST ( CloseReason AS nvarchar (100)) , '-') 
      ) 
       WHERE
             ItemId IN ( SELECT TOP 5
                                ItemID
                                FROM DIM_EDW_CoachingDetail
                                WHERE ItemID IS NOT NULL
                                ORDER BY
                                         ItemID , WeekendDate) ;

DECLARE @iCnt AS int = 0;
EXEC @iCnt = proc_CT_CoachingDetail_AddUpdatedRecs ;
PRINT 'Updates applied: ' + CAST (@iCnt AS nvarchar (50)) ;

--**************************************
-- INSERT NEW RECORDS
DELETE FROM DIM_EDW_CoachingDetail
       WHERE
             ItemId IN ( SELECT TOP 5
                                ItemID
                                FROM DIM_EDW_CoachingDetail
                                WHERE ItemID IS NOT NULL
                                ORDER BY
                                         ItemID , WeekendDate) ;
DECLARE @inewrecs AS int = 0;
EXEC @inewrecs = proc_CT_CoachingDetail_AddNewRecs ;
PRINT 'New records added: ' + CAST (@inewrecs AS nvarchar (50)) ;

--**************************************
-- MARK DELETED RECORDS
DECLARE @idels AS int = 0;
DELETE FROM ##TEMP_EDW_CoachingDetail_DATA
       WHERE
             ItemId IN ( SELECT TOP 5
                                ItemID
                                FROM DIM_EDW_CoachingDetail
                                WHERE ItemID IS NOT NULL
                                ORDER BY
                                         ItemID , WeekendDate) ;
EXEC @idels = proc_CT_CoachingDetail_AddDeletedRecs ;
PRINT '*******************************************************************';
PRINT 'Records Marked as deleted: ' + CAST (@idels AS nvarchar (50)) ;
PRINT 'Updates applied: ' + CAST (@iCnt AS nvarchar (50)) ;
PRINT 'New records added: ' + CAST (@inewrecs AS nvarchar (50)) ;
PRINT '*******************************************************************';
SET NOCOUNT OFF;
