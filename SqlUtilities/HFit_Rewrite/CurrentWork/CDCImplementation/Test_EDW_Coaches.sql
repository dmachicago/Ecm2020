
/**************************************************************
TEST proc_EDW_Coaches
***************************************************************/
set NOCOUNT on ;
PRINT '****************************************************************';
PRINT '** TEST #1 proc_EDW_Coaches Initial counts ';
PRINT '****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1 ) WITH NOWAIT;

DECLARE
   @testReload AS int = 1;
DECLARE
   @DBN AS nvarchar ( 100 ) = DB_NAME ( );
DECLARE
   @JNAME AS nvarchar ( 100 ) = 'job_EDW_GetStagingData_HA_' + @DBN;
DECLARE
   @b AS int = 0;
EXEC @b = isJobRunning @JNAME;
IF @b = 1
    BEGIN
        PRINT ' '; PRINT ' ';
        --PRINT '*********************************** NOTICE ***************************************';
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        PRINT 'XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX';
        PRINT '*********************************** NOTICE ***************************************';
        PRINT @JNAME + ' Currently running.';
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
    END;

DECLARE
   @iCntCTRecs AS int = 0
   ,@iTotalRecs AS int = 0;

SET @iTotalRecs = ( SELECT
                           COUNT ( * )
                      FROM view_EDW_Coaches );
SET @iCntCTRecs = ( SELECT
                           COUNT ( * )
                      FROM view_EDW_Coaches_CT );
PRINT 'Row count from view_EDW_Coaches_CT : ' + CAST ( @iCntCTRecs AS nvarchar( 50 ));
PRINT 'Row count from parent view_EDW_Coaches: ' + CAST ( @iTotalRecs AS nvarchar( 50 ));

DECLARE
   @iCntDIFF AS int = 0;
SET @iCntDIFF = @iCntCTRecs - @iTotalRecs;
IF @iCntDIFF = 0
    BEGIN
        PRINT 'PASSED: ROW DIFF Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50 )) ;
    END
ELSE
    BEGIN
        PRINT 'ERROR: Difference Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50 ));
    END;

DECLARE
   @StagingRecCnt AS int = ( SELECT
                                    COUNT( * )
                               FROM DIM_EDW_Coaches );
IF @testReload = 1
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_EDW_Coaches 1 , 1 , 0;

        SET @StagingRecCnt = ( SELECT
                                      COUNT( * )
                                 FROM DIM_EDW_Coaches );
        PRINT 'Records Loaded in initial load: ' + CAST( @StagingRecCnt AS nvarchar( 50 ));
    END;

--Test the LOAD Changes Only of the procedure
EXEC proc_EDW_Coaches 0 , 1 , 0;
PRINT 'Records Loaded in staging table: ' + CAST( @StagingRecCnt AS nvarchar( 50 ));

IF NOT EXISTS ( SELECT
                       name
                  FROM tempdb.dbo.sysobjects
                  WHERE
                  id = OBJECT_ID ( N'tempdb..##DIM_TEMPTBL_EDW_Coaches_DATA' ))
    BEGIN
        PRINT 'ERROR - TEMP TABLE MISING - ABORTING!';
        RETURN;
    END;

UPDATE ##DIM_TEMPTBL_EDW_Coaches_DATA
  SET
      FirstName = LOWER( FirstName )
  WHERE
        UserGUID IN ( SELECT TOP 5
                             UserGUID
                        FROM DIM_EDW_Coaches
                        WHERE UserGUID IS NOT NULL
                        ORDER BY
                                 UserGUID );
UPDATE ##DIM_TEMPTBL_EDW_Coaches_DATA
  SET
      HashCode = HASHBYTES ( 'sha1' ,
      ISNULL( CAST( UserGUID AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( SiteGUID AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( AccountID AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( AccountCD AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( CoachID AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( LastName AS nvarchar( 250 )) , '-' ) + ISNULL( CAST( FirstName AS nvarchar( 250 )) , '-' ) + ISNULL( CAST( StartDate AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( Phone AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( email AS nvarchar( 250 )) , '-' ) + ISNULL( CAST( Supervisor AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( SuperCoach AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( MaxParticipants AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( Inactive AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( MaxRiskLevel AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( Locked AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( TimeLocked AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( terminated AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( APMaxParticipants AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( RNMaxParticipants AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( RNPMaxParticipants AS nvarchar( 100 )) , '-' ) + ISNULL( CAST( Last_Update_Dt AS nvarchar( 100 )) , '-' ))
  WHERE
        UserGUID IN ( SELECT TOP 5
                             UserGUID
                        FROM DIM_EDW_Coaches
                        WHERE UserGUID IS NOT NULL
                        ORDER BY
                                 UserGUID );
declare @iCnt as int = 0 ;
EXEC @iCnt = proc_CT_Coaching_AddUpdatedRecs ;
print 'Updates applied: ' + cast(@iCnt as nvarchar(50)) ;

--**************************************
-- INSERT NEW RECORDS
DELETE FROM DIM_EDW_Coaches
  WHERE
        UserGUID IN ( SELECT TOP 5
                             UserGUID
                        FROM DIM_EDW_Coaches
                        WHERE UserGUID IS NOT NULL
                        ORDER BY
                                 UserGUID );
EXEC @iCnt = proc_CT_Coaching_AddNewRecs ;
print 'New records added: ' + cast(@iCnt as nvarchar(50)) ;

--**************************************
-- MARK DELETED RECORDS
DELETE FROM ##DIM_TEMPTBL_EDW_Coaches_DATA
  WHERE
        UserGUID IN ( SELECT TOP 5
                             UserGUID
                        FROM DIM_EDW_Coaches
                        WHERE UserGUID IS NOT NULL
                        ORDER BY
                                 UserGUID DESC );
EXEC @iCnt = proc_CT_Coaching_AddDeletedRecs ;
print 'Records Marked as deleted: ' + cast(@iCnt as nvarchar(50)) ;

set NOCOUNT off ;
