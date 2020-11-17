
/**************************************************************
TEST proc_STAGING_EDW_CoachingDefinition
***************************************************************/
set NOCOUNT on ;
PRINT '****************************************************************';
PRINT '** TEST #1 proc_STAGING_EDW_CoachingDefinition Initial counts ';
PRINT '****************************************************************';

DECLARE
   @iCntCTRecs AS int = 0
   ,@iTotalRecs AS int = 0
    , @testReload as int =1 ;

SET @iTotalRecs = ( SELECT
                           COUNT ( * )
                      FROM view_EDW_CoachingDefinition );
SET @iCntCTRecs = ( SELECT
                           COUNT ( * )
                      FROM view_EDW_CoachingDefinition_CT );
PRINT 'Row count from view_EDW_CoachingDefinition_CT : ' + CAST ( @iCntCTRecs AS nvarchar( 50 ));
PRINT 'Row count from parent view_EDW_CoachingDefinition: ' + CAST ( @iTotalRecs AS nvarchar( 50 ));

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
                               FROM STAGING_EDW_CoachingDefinition );
IF @testReload = 1
    BEGIN
        PRINT 'TESTING full reload of data';
        EXEC proc_STAGING_EDW_CoachingDefinition 1 , 1 , 0;

        SET @StagingRecCnt = ( SELECT
                                      COUNT( * )
                                 FROM STAGING_EDW_CoachingDefinition );
        PRINT 'Records Loaded in initial load: ' + CAST( @StagingRecCnt AS nvarchar( 50 ));
    END;

/*
select TOP 50 * from STAGING_EDW_CoachingDefinition
select TOP 50 * from ##TEMP_STAGING_EDW_CoachingDefinition_DATA
select * into ##TEMP_STAGING_EDW_CoachingDefinition_DATA from STAGING_EDW_CoachingDefinition
*/

--Test the LOAD Changes Only of the procedure
EXEC proc_STAGING_EDW_CoachingDefinition 0 , 1 , 0;
PRINT 'Records Loaded in staging table: ' + CAST( @StagingRecCnt AS nvarchar( 50 ));

IF NOT EXISTS ( SELECT
                       name
                  FROM tempdb.dbo.sysobjects
                  WHERE
                  id = OBJECT_ID ( N'tempdb..##TEMP_STAGING_EDW_CoachingDefinition_DATA' ))
    BEGIN
        PRINT 'ERROR - TEMP TABLE MISING - ABORTING!';
        RETURN;
    END;

/*
drop table ##TEMP_STAGING_EDW_CoachingDefinition_DATA ;
 SELECT
                   * INTO
                          ##TEMP_STAGING_EDW_CoachingDefinition_DATA
              FROM view_EDW_CoachingDefinition_CT;
*/

UPDATE ##TEMP_STAGING_EDW_CoachingDefinition_DATA
  SET
      goal = lower(goal)
  WHERE
        DocumentGuid IN ( SELECT TOP 5
                             DocumentGuid
                        FROM STAGING_EDW_CoachingDefinition
                        WHERE DocumentGuid IS NOT NULL
                        ORDER BY
                                 DocumentGuid);

UPDATE ##TEMP_STAGING_EDW_CoachingDefinition_DATA
  SET
      HashCode = hashbytes('sha1',
		   isNull(cast(GoalID as nvarchar(50)),'-')
		   + isNull(cast(DocumentGuid as nvarchar(50)),'-')
		   + isNull(cast(NodeSiteID as nvarchar(50)),'-')
		   + isNull(cast(SiteGUID as nvarchar(50)),'-')
		   + isNull(cast(GoalImage as nvarchar(50)),'-')
		   + isNull(cast(Goal as nvarchar(50)),'-')
		   + isnull(LEFT(GoalText,1000),'-')
		   + isnull(left(GoalSummary,1000),'-')
		   + isNull(cast(TrackerAssociation as nvarchar(50)),'-')
		   + isNull(cast(GoalFrequency as nvarchar(50)),'-')
		   + isNull(cast(FrequencySingular as nvarchar(50)),'-')
		   + isNull(cast(FrequencyPlural as nvarchar(50)),'-')
		   + isNull(cast(GoalUnitOfMeasure as nvarchar(50)),'-')
		   + isNull(cast(UnitOfMeasure as nvarchar(50)),'-')
		   + isNull(cast(GoalDirection as nvarchar(50)),'-')
		   + isNull(cast(GoalPrecision as nvarchar(50)),'-')
		   + isNull(cast(GoalAbsoluteMin as nvarchar(50)),'-')
		   + isNull(cast(GoalAbsoluteMax as nvarchar(50)),'-')
		   + isnull(left(SetGoalText,1000),'-')
		   + isnull(left(HelpText,1000),'-')
		   + isNull(cast(EvaluationType as nvarchar(50)),'-')
		   + isNull(cast(CatalogDisplay as nvarchar(50)),'-')
		   + isNull(cast(AllowModification as nvarchar(50)),'-')
		   + isnull(left(ActivityText, 1000),'-')
		   + isnull(left(SetGoalModifyText,1000),'-')
		   + isNull(cast(IsLifestyleGoal as nvarchar(50)),'-')
		   + isNUll(CodeName, '-')
		   + isNull(cast(DocumentCreatedWhen as nvarchar(50)),'-')
		   + isNull(cast(DocumentModifiedWhen as nvarchar(50)),'-')
		   + isNull(DocumentCulture, '-')
	   )
  WHERE
        DocumentGuid IN ( SELECT TOP 5
                             DocumentGuid
                        FROM STAGING_EDW_CoachingDefinition
                        WHERE DocumentGuid IS NOT NULL
                        ORDER BY
                                 DocumentGuid);

declare @iCnt as int = 0 ;
EXEC @iCnt = proc_CT_CoachingDefinition_AddUpdatedRecs ;
print 'Updates applied: ' + cast(@iCnt as nvarchar(50)) ;

--**************************************
-- INSERT NEW RECORDS
DELETE FROM STAGING_EDW_CoachingDefinition
  WHERE
        DocumentGuid IN ( SELECT TOP 5
                             DocumentGuid
                        FROM STAGING_EDW_CoachingDefinition
                        WHERE DocumentGuid IS NOT NULL
                        ORDER BY
                                 DocumentGuid);
declare @iNew as int = 0 
exec @iNew = proc_CT_CoachingDefinition_AddNewRecs ;
print 'New records added: ' + cast(@iNew as nvarchar(50)) ;

--**************************************
-- MARK DELETED RECORDS
DELETE FROM ##TEMP_STAGING_EDW_CoachingDefinition_DATA
  WHERE
        DocumentGuid IN ( SELECT TOP 5
                             DocumentGuid
                        FROM STAGING_EDW_CoachingDefinition
                        WHERE DocumentGuid IS NOT NULL
                        ORDER BY
                                 DocumentGuid);
EXEC @iCnt = proc_CT_CoachingDefinition_AddDeletedRecs ;
print 'Records Marked as deleted: ' + cast(@iCnt as nvarchar(50)) ;

set NOCOUNT off ;