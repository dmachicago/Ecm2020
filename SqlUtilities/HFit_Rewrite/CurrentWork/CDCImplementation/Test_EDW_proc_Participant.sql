
/*------------------------------------------------------------
*************************************************************
TEST proc_DIM_EDW_Participant
**************************************************************
*/
SET NOCOUNT ON;
PRINT '****************************************************************';
PRINT '** TEST #1 proc_DIM_EDW_Participant Initial counts ';
PRINT '****************************************************************';

DECLARE
@iCntCTRecs AS int = 0
, @iTotalRecs AS int = 0
, @testReload AS int = 1;

SET @iTotalRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_Participant) ;
SET @iCntCTRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_Participant_CT) ;
PRINT 'Row count from view_EDW_Participant_CT : ' + CAST ( @iCntCTRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_Participant: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

DECLARE
@iCntDIFF AS int = 0;
SET @iCntDIFF = @iCntCTRecs - @iTotalRecs;
IF @iCntDIFF = 0
    BEGIN
        PRINT 'PASSED: ROW DIFF Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50)) ;
    END;
ELSE
    BEGIN
        PRINT 'NOTICE: Difference Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50)) ;
    END;

DECLARE
@StagingRecCnt AS int = ( SELECT
                                 COUNT ( *) 
                                 FROM DIM_EDW_Participant) ;
IF @testReload = 1
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_DIM_EDW_Participant 1 , 1 , 0;

        SET @StagingRecCnt = ( SELECT
                                      COUNT ( *) 
                                      FROM DIM_EDW_Participant) ;
        PRINT 'Records Loaded in initial load: ' + CAST ( @StagingRecCnt AS nvarchar ( 50)) ;
    END;

/*----------------------------------------------------------------------------
select TOP 50 * from DIM_EDW_Participant
select TOP 50 * from ##TEMP_DIM_EDW_Participant_DATA
select * into ##TEMP_DIM_EDW_Participant_DATA from DIM_EDW_Participant
*/

--Test the LOAD Changes Only of the procedure
EXEC proc_DIM_EDW_Participant 0 , 1 , 0;
PRINT 'Records Loaded in staging table: ' + CAST ( @StagingRecCnt AS nvarchar (50)) ;

IF EXISTS ( SELECT
                   name
                   FROM tempdb.dbo.sysobjects
                   WHERE id = OBJECT_ID ( N'tempdb..##TEMP_DIM_EDW_Participant_DATA')) 

    BEGIN
        DROP TABLE
             ##TEMP_DIM_EDW_Participant_DATA;
    END;

SELECT
       * INTO
              ##TEMP_DIM_EDW_Participant_DATA
       FROM view_EDW_Participant_CT;

ALTER TABLE ##TEMP_DIM_EDW_Participant_DATA
ADD
            LastModifiedDate datetime NULL;
ALTER TABLE ##TEMP_DIM_EDW_Participant_DATA
ADD
            RowNbr int NULL;
ALTER TABLE ##TEMP_DIM_EDW_Participant_DATA
ADD
            DeletedFlg bit NULL;

CREATE CLUSTERED INDEX temp_PI_DIM_EDW_Participant_IDs ON dbo.##TEMP_DIM_EDW_Participant_DATA
(   UserGUID , SiteGUID , AccountID , AccountCD) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

--select top 100 * from ##TEMP_DIM_EDW_Participant_DATA

UPDATE ##TEMP_DIM_EDW_Participant_DATA
  SET
      AccountCD = LOWER (AccountCD) 
       WHERE
             HFitUserMpiNumber IN ( SELECT TOP 5
                                           HFitUserMpiNumber
                                           FROM DIM_EDW_Participant
                                           WHERE
                                                 HFitUserMpiNumber IS NOT NULL AND
                                                 HFitUserMpiNumber > 0
                                           ORDER BY
                                                    HFitUserMpiNumber) ;

UPDATE ##TEMP_DIM_EDW_Participant_DATA
  SET
      HashCode = HASHBYTES ('sha1' ,
      ISNULL ( CAST ( HFitUserMpiNumber AS nvarchar (50)) , '-') + ISNULL ( CAST ( UserID AS nvarchar (50)) , '-') + ISNULL ( CAST ( UserGUID AS nvarchar (50)) , '-') + ISNULL ( CAST ( SiteGUID AS nvarchar (50)) , '-') + ISNULL ( CAST ( AccountID AS nvarchar (50)) , '-') + ISNULL ( CAST ( AccountCD AS nvarchar (50)) , '-') + ISNULL ( HFitUserPreferredMailingAddress , '-') + ISNULL ( HFitUserPreferredMailingCity , '-') + ISNULL ( HFitUserPreferredMailingState , '-') + ISNULL ( CAST ( HFitUserPreferredMailingPostalCode AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitCoachingEnrollDate  AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserAltPreferredPhone AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserAltPreferredPhoneExt AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserAltPreferredPhoneType AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserPreferredPhone AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserPreferredFirstName AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserPreferredEmail AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserRegistrationDate AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserIsRegistered AS nvarchar (50)) , '-') 
      ) 
       WHERE
             HFitUserMpiNumber IN ( SELECT TOP 5
                                           HFitUserMpiNumber
                                           FROM DIM_EDW_Participant
                                           WHERE
                                                 HFitUserMpiNumber IS NOT NULL AND
                                                 HFitUserMpiNumber > 0
                                           ORDER BY
                                                    HFitUserMpiNumber) ;

DECLARE @iCnt AS int = 0;
EXEC @iCnt = proc_CT_Participant_AddUpdatedRecs ;
PRINT 'Updates applied: ' + CAST (@iCnt AS nvarchar (50)) ;

--**************************************
-- INSERT NEW RECORDS
DELETE FROM DIM_EDW_Participant
       WHERE
             HFitUserMpiNumber IN ( SELECT TOP 5
                                           HFitUserMpiNumber
                                           FROM DIM_EDW_Participant
                                           WHERE
                                                 HFitUserMpiNumber IS NOT NULL AND
                                                 HFitUserMpiNumber > 0
                                           ORDER BY
                                                    HFitUserMpiNumber) ;
DECLARE @iNew AS int = 0;
EXEC @iNew = proc_CT_Participant_AddNewRecs ;
PRINT 'New records added: ' + CAST (@iNew AS nvarchar (50)) ;

--**************************************
-- MARK DELETED RECORDS
DELETE FROM ##TEMP_DIM_EDW_Participant_DATA
       WHERE
             HFitUserMpiNumber IN ( SELECT TOP 5
                                           HFitUserMpiNumber
                                           FROM DIM_EDW_Participant
                                           WHERE
                                                 HFitUserMpiNumber IS NOT NULL AND
                                                 HFitUserMpiNumber > 0
                                           ORDER BY
                                                    HFitUserMpiNumber) ;

DECLARE @iDel AS int = 0;
EXEC @iDel = proc_CT_Participant_AddDeletedRecs ;
PRINT 'Records Marked as deleted: ' + CAST (@iDel AS nvarchar (50)) ;

IF @iCnt > 0
    BEGIN
        PRINT 'UPDATES CHECKED GOOD: ' + CAST (@iDel AS nvarchar (50)) 
    END;
IF @iNew > 0
    BEGIN
        PRINT 'INSERTS CHECKED GOOD: ' + CAST (@iDel AS nvarchar (50)) 
    END;
IF @iDel > 0
    BEGIN
        PRINT 'DELETES CHECKED GOOD: ' + CAST (@iDel AS nvarchar (50)) 
    END;

SET NOCOUNT OFF;