
DECLARE
@SD AS datetime2 = GETDATE () ;
DECLARE
@ERRCNT AS int = 0;

--*************************************************************
--TEST proc_EDW_SmallSteps
--AUTHOR: W. Dale Miller
--**************************************************************

/*---------------------------------------------------
use KenticoCMS_Prod1
select top 100 * from ##Temp_SmallSteps
select count(*) from ##Temp_SmallSteps

drop table ##Temp_SmallSteps

SELECT * INTO ##Temp_SmallSteps
                  FROM view_EDW_SmallStepResponses_CT
                  WHERE ChangeType IS NOT NULL 

exec proc_CT_EDW_SmallSteps_Temp_NoDups ;
*/

SET NOCOUNT ON;

EXEC proc_EDW_SmallSteps 1;
EXEC proc_CT_EDW_SmallSteps_NoDups ;

EXEC proc_EDW_SmallSteps 0;

IF OBJECT_ID ( 'tempdb..##Temp_SmallSteps') IS NOT NULL
    BEGIN
        PRINT 'Creating ##Temp_SmallSteps';
        DROP TABLE
             ##Temp_SmallSteps;
        SELECT
               * INTO
                      ##Temp_SmallSteps
               FROM DIM_EDW_SmallSteps;
    END;
--*********************************************************************************************************************
EXEC proc_Add_EDW_CT_StdCols '##Temp_SmallSteps';

CREATE CLUSTERED INDEX PI_TEMP_EDW_SmallSteps ON ##Temp_SmallSteps ( AccountCD , SiteGUID , SSItemID , SSItemGUID ,
SSHealthAssesmentUserStartedItemID , SSOutcomeMessageGuid , HFitUserMPINumber , HACampaignNodeGUID , HAStartedMode , HACompletedMode ,
HaCodeName ,
HACampaignStartDate , HACampaignEndDate) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF ,
ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;

CREATE NONCLUSTERED INDEX PI_TEMP_EDW_SmallSteps_ItemID ON ##Temp_SmallSteps ( SSItemID) 
WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
ALLOW_ROW_LOCKS = ON ,
ALLOW_PAGE_LOCKS = ON) ;

CREATE NONCLUSTERED INDEX PI_TEMP_EDW_SmallSteps_Hashcode ON ##Temp_SmallSteps ( HFitUserMPINumber , HashCode) 
WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
ALLOW_ROW_LOCKS = ON ,
ALLOW_PAGE_LOCKS = ON) ;

EXEC proc_CT_EDW_SmallSteps_Temp_NoDups ;
--*********************************************************************************************************************
DECLARE
@iCntCT AS int = 0
, @iTotalRecs AS int = 0;

SET @iTotalRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_SmallStepResponses) ;
SET @iCntCT = ( SELECT
                       COUNT ( *) 
                       FROM view_EDW_SmallStepResponses_CT) ;

PRINT 'Row count from view_EDW_SmallStepResponses: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_SmallStepResponses_CT: ' + CAST ( @iCntCT AS nvarchar (50)) ;
PRINT 'Row count from CT view: ' + CAST ( @iCntCT AS nvarchar (50)) ;

DECLARE
@iCntDIFF AS int = 0;
SET @iCntDIFF = @iCntCT - @iCntCT;
IF @iCntDIFF = 0
    BEGIN
        PRINT '----------------------------------------------------------------------------';
        PRINT 'PASSED: ROW DIFF Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50)) ;
        PRINT '----------------------------------------------------------------------------';
    END;
ELSE
    BEGIN
        PRINT '*************************************************************************';
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        PRINT 'NOTICE: Difference Between BASE View and CT View : ' + CAST ( @iCntDIFF AS nvarchar ( 50)) ;
        SET @ERRCNT = @ERRCNT + 1;
        PRINT '*************************************************************************';
    END;
--Test the RELOAD ALL of the procedure 130
EXEC proc_EDW_SmallSteps 1;
DECLARE
@RecsLoaded AS int = ( SELECT
                              COUNT ( *) 
                              FROM DIM_EDW_SmallSteps) ;
PRINT 'Records Loaded in initial load: ' + CAST ( @RecsLoaded AS nvarchar (50)) ;
--Test the LOAD Changes Only of the procedure
EXEC proc_EDW_SmallSteps 0;
PRINT 'Records Loaded in initial load: ' + CAST ( @RecsLoaded AS nvarchar (50)) ;

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'PI_EDW_SmallSteps_HashCode') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_EDW_SmallSteps_HashCode ON dbo.DIM_EDW_SmallSteps ( HFitUserMPINumber , HashCode) 
        WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON ,
        ALLOW_PAGE_LOCKS = ON) ;
    END;

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'PI_EDW_UK_TempSmallSteps') 
    BEGIN
        CREATE CLUSTERED INDEX PI_EDW_UK_TempSmallSteps
        ON dbo.##Temp_SmallSteps (
        AccountCD ASC ,
        SiteGUID ASC ,
        SSItemID ASC ,
        SSItemGUID ASC ,
        SSHealthAssesmentUserStartedItemID ASC ,
        SSOutcomeMessageGuid ASC ,
        HFitUserMPINumber ASC ,
        HACampaignNodeGUID ASC ,
        HAStartedMode ASC ,
        HACompletedMode ASC ,
        HaCodeName ASC ,
        HACampaignStartDate ASC ,
        HACampaignEndDate ASC
        )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
    END;

IF NOT EXISTS ( SELECT
                       name
                       FROM tempdb.sys.indexes
                       WHERE name = 'PI_TEMP_EDW_SmallSteps_Hashcode') 
    BEGIN
        CREATE NONCLUSTERED INDEX PI_TEMP_EDW_SmallSteps_Hashcode ON ##Temp_SmallSteps ( HFitUserMPINumber , HashCode) 
        WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON ,
        ALLOW_PAGE_LOCKS = ON) ;
    END;

/*-------------------------------------------
** BACKUP THE BASE TABLE BEFORE PROCEEDING **
*/

--drop table TEMP_SmallSteps_FULL_Backup
IF NOT EXISTS ( SELECT
                       name
                       FROM sys.tables
                       WHERE name = 'TEMP_SmallSteps_FULL_Backup') 
    BEGIN
        SELECT
               *
        INTO
             TEMP_SmallSteps_FULL_Backup
               FROM Hfit_SmallStepResponses;

/*----------------------------------------------
select count(*) from TEMP_SmallSteps_FULL_Backup
select count(*) from Hfit_SmallStepResponses
*/

    END;

/*---------------------------------------------
Get 100 rows and save them for testing purposes
*/

IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE name = 'TEMP_SmallStepsTestData') 
    BEGIN
        PRINT 'Dropped TEMP_SmallStepsTestData table ';
        DROP TABLE
             TEMP_SmallStepsTestData;
    END;
-- Select top 100 * from Hfit_SmallStepResponses 
SELECT TOP 100
       *
INTO
     TEMP_SmallStepsTestData
       FROM Hfit_SmallStepResponses
       ORDER BY
                ItemID DESC;
--select * from TEMP_SmallStepsTestData

/*-----------------------------------------------------------------------------------------------------------------------
*************************************************************************************************************************
    Modify a portion of the 100 rows AND validate that change tracking finds them and updates the staging table.
    NOTE: The column to be modified will have to be validated for each base table to ensure it is used in the view.
*************************************************************************************************************************
*/

--DBCC DROPCLEANBUFFERS; 
UPDATE Hfit_SmallStepResponses
  SET
      ItemOrder = -1
       WHERE
             ItemID IN ( SELECT
                                ItemID
                                FROM TEMP_SmallStepsTestData) AND
             ItemOrder IS NULL;

/*-----------------------------
SELECT TOP 100
       *
  FROM ##Temp_SmallSteps
  WHERE HACodeName = 'SSSleep';
*/

UPDATE ##Temp_SmallSteps
  SET
      HACodeName = UPPER ( HACodeName) 
       WHERE
             HACodeName = 'SSSleep';

UPDATE ##Temp_SmallSteps
  SET
      HashCode = HASHBYTES ( 'sha1' , ISNULL ( LEFT ( SSOutcomeMessage , 2000) , '-') + ISNULL ( CAST ( SSItemModifiedBy AS nvarchar (50)) , '-') + ISNULL ( CAST ( SSItemModifiedWhen AS nvarchar (50)) , '-') + ISNULL ( CAST ( SSItemOrder AS nvarchar (50)) , '-') + ISNULL ( HACampaignName , '-') + ISNULL ( CAST ( HACampaignStartDate AS nvarchar (50)) , '-') + ISNULL ( CAST ( HACampaignEndDate AS nvarchar (50)) , '-') + ISNULL ( CAST ( HAStartedDate AS nvarchar (50)) , '-') + ISNULL ( CAST ( HACompletedDate AS nvarchar (50)) , '-') + ISNULL ( CAST ( HAStartedMode AS nvarchar (50)) , '-') + ISNULL ( CAST ( HACompletedMode AS nvarchar (50)) , '-') + ISNULL ( HaCodeName , '-') + ISNULL ( CAST ( SSItemGUID AS nvarchar (50)) , '-') + ISNULL ( CAST ( HACampaignStartDate AS nvarchar (50)) , '-') + ISNULL ( CAST ( HACampaignEndDate AS nvarchar (50)) , '-') + ISNULL ( CAST ( HFitUserMPINumber AS nvarchar (50)) , '-') 
      ) 
       WHERE
             HACodeName = 'SSSleep';

/*------------------------------------
**************************************
    Make sure Changes ARE detected
**************************************
*/
DECLARE @iUpdated AS int = 0;
EXEC @iUpdated = proc_CT_SmallSteps_AddUpdatedRecs ;
PRINT 'Updated Records: ' + CAST (@iUpdated AS nvarchar (50)) ;

DECLARE
@iChgCnt AS int = 0;
SET @iChgCnt = ( SELECT
                        COUNT ( *) 
                        FROM ##Temp_SmallSteps
                        WHERE HACodeName = 'SSSleep') ;
PRINT 'Count of changes to Expect: ' + CAST ( @iChgCnt AS nvarchar (50)) ;

/*------------------------------------
**************************************
    Put back the original Data
**************************************
*/

PRINT '*** Reset data in base table.';
UPDATE ##Temp_SmallSteps
  SET
      HACodeName = 'SSSleep'
       WHERE
             HACodeName = 'SSSleep';

/*----------------------------------------
******************************************
    DROP ROWS AND LOOK FOR DELETES 
******************************************
*/

--select * from TEMP_SmallStepsTestData
PRINT 'Record count before delete: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;
--select top 100 * from ##Temp_SmallSteps

DELETE FROM ##Temp_SmallSteps
       WHERE
             UserID IN ( SELECT TOP 1
                                UserID
                                FROM ##Temp_SmallSteps
                                ORDER BY
                                         UserID DESC) ;
DECLARE
@CntAfterDelete AS int = 0;
SET @CntAfterDelete = ( SELECT
                               COUNT ( *) 
                               FROM ##Temp_SmallSteps) ;
--select count(*) from view_EDW_SmallStepResponses_CT ;
PRINT 'Changes to data reset: ';
PRINT 'Record count After delete: ' + CAST ( @CntAfterDelete AS nvarchar (50)) ;
--SELECT TOP 100 * FROM DIM_EDW_SmallSteps;

/*------------------------------------------------------------
**************************************************************

**************************************************************
*/
PRINT 'Validate deletes are detected and marked.';
DECLARE @CntMArkedAsDeleted AS int = 0;
EXEC @CntMArkedAsDeleted = proc_CT_SmallSteps_AddDeletedRecs;
PRINT 'Marked as Deleted: ' + CAST (@CntMArkedAsDeleted  AS nvarchar (50)) ;
PRINT '**************************************************************';
IF @CntMArkedAsDeleted > 0
    BEGIN
        PRINT '----------------------------------------------------------------------------';
        PRINT 'PASSED DELETES: Record count marked as deleted: ' + CAST ( @CntMArkedAsDeleted AS nvarchar ( 50)) ;
        PRINT '----------------------------------------------------------------------------';
    END;
ELSE
    BEGIN
        PRINT 'FAILED DELETES: Record count marked as deleted: ' + CAST ( @CntMArkedAsDeleted AS nvarchar ( 50)) ;
    END;
PRINT '**************************************************************';
PRINT 'Put back the deleted records to the base table.';

/*----------------------------------------------------------
************************************************************
USE The columns from the base table and the temp table here
************************************************************
*/

SET IDENTITY_INSERT Hfit_SmallStepResponses ON;

INSERT INTO Hfit_SmallStepResponses (
       ItemID
     , UserID
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , ItemOrder
     , ItemGUID
     , HealthAssesmentUserStartedItemID
     , OutComeMessageGUID
     , HADocumentID_old) 
SELECT
       ItemID
     , UserID
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , ItemOrder
     , ItemGUID
     , HealthAssesmentUserStartedItemID
     , OutComeMessageGUID
     , HADocumentID_old
       FROM TEMP_SmallStepsTestData
       WHERE ItemID NOT IN (
       SELECT
              ItemID
              FROM Hfit_SmallStepResponses) ;

SET IDENTITY_INSERT Hfit_SmallStepResponses OFF;
UPDATE Hfit_SmallStepResponses
  SET
      UserID = 662
       WHERE
             UserID = -999;
PRINT '*** Data reset to original condition';

DECLARE
@NewTotal AS int = 0;
SET @NewTotal = ( SELECT
                         COUNT ( *) 
                         FROM Hfit_SmallStepResponses) ;
PRINT 'Record count after reinsertion: ' + CAST ( @NewTotal AS nvarchar (50)) ;
PRINT 'Original Record Count: ' + CAST ( @iTotalRecs AS nvarchar (50)) ;

EXEC proc_EDW_SmallSteps;

/*--------------------------------------------------------
Confirm that INSERTS are detected and registered.
select * from ##Temp_SmallSteps
NOTE: This statement will have to be tailored for each use
*/

/*---------------------------------
 Make sure the TEMP Table is clean 
*/

DELETE FROM ##Temp_SmallSteps
       WHERE
             UserID < 0;

/*--------------------
 Insert 2 new records 
*/

DECLARE
@iCntBeforeInsert AS int = 0;
SET @iCntBeforeInsert = ( SELECT
                                 COUNT ( *) 
                                 FROM ##Temp_SmallSteps) ;
PRINT 'Staging Record Count Before Insert: ' + CAST ( @iCntBeforeInsert AS nvarchar (50)) ;

INSERT INTO dbo.##Temp_SmallSteps
(
       UserID
     , AccountCD
     , SiteGUID
     , SSItemID
     , SSItemCreatedBy
     , SSItemCreatedWhen
     , SSItemModifiedBy
     , SSItemModifiedWhen
     , SSItemOrder
     , SSItemGUID
     , SSHealthAssesmentUserStartedItemID
     , SSOutcomeMessageGuid
     , SSOutcomeMessage
     , HACampaignNodeGUID
     , HACampaignName
     , HACampaignStartDate
     , HACampaignEndDate
     , HAStartedDate
     , HACompletedDate
     , HAStartedMode
     , HACompletedMode
     , HaCodeName
     , HFitUserMPINumber
     , HashCode
     , LastModifiedDate
     , DeletedFlg
     , ChangeType) 
VALUES
(
-100
, 'XXX_01'
, NEWID () 
, -100
, -100
, GETDATE () 
, -100
, GETDATE () 
, -100
, NEWID () 
, -100
, NEWID () 
, 'XXX_01'
, NEWID () 
, 'XXX_01'
, GETDATE () 
, GETDATE () 
, GETDATE () 
, GETDATE () 
, -100
, -100
, 'XXX_01'
, -100
, HASHBYTES ( 'sha1' , 'XXX_01') 
, GETDATE () 
, NULL
, NULL) ;

INSERT INTO dbo.##Temp_SmallSteps
(
       UserID
     , AccountCD
     , SiteGUID
     , SSItemID
     , SSItemCreatedBy
     , SSItemCreatedWhen
     , SSItemModifiedBy
     , SSItemModifiedWhen
     , SSItemOrder
     , SSItemGUID
     , SSHealthAssesmentUserStartedItemID
     , SSOutcomeMessageGuid
     , SSOutcomeMessage
     , HACampaignNodeGUID
     , HACampaignName
     , HACampaignStartDate
     , HACampaignEndDate
     , HAStartedDate
     , HACompletedDate
     , HAStartedMode
     , HACompletedMode
     , HaCodeName
     , HFitUserMPINumber
     , HashCode
     , LastModifiedDate
     , DeletedFlg
     , ChangeType) 
VALUES
(
-600
, 'XXX_02'
, NEWID () 
, -600
, -600
, GETDATE () 
, -600
, GETDATE () 
, -600
, NEWID () 
, -600
, NEWID () 
, 'XXX_02'
, NEWID () 
, 'XXX_02'
, GETDATE () 
, GETDATE () 
, GETDATE () 
, GETDATE () 
, -600
, -600
, 'XXX_02'
, -600
, HASHBYTES ( 'sha1' , 'XXX_03') 
, GETDATE () 
, NULL
, NULL) ;

DECLARE
@iCntAfterInsert AS int = 0;
SET @iCntAfterInsert = ( SELECT
                                COUNT ( *) 
                                FROM ##Temp_SmallSteps) ;
PRINT 'Staging Record Count After Insert: ' + CAST ( @iCntAfterInsert AS nvarchar (50)) ;

DECLARE
@InsertedRecCnt AS int = 0;

EXEC @InsertedRecCnt = proc_CT_SmallSteps_AddNewRecs ;
PRINT 'Inserted records: ' + CAST (@InsertedRecCnt  AS nvarchar (50)) ;

/*--------------------------------------------------------------------
**********************************************************************
*/

DECLARE
@iCntAfterInsert2 AS int = 0;
SET @iCntAfterInsert2 = ( SELECT
                                 COUNT ( *) 
                                 FROM DIM_EDW_SmallSteps) ;
PRINT '*******************************************************************';
PRINT '01 New Records found: ' + CAST ( @InsertedRecCnt AS nvarchar (50)) ;
IF @InsertedRecCnt = 0
    BEGIN
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        PRINT 'ERROR: New inserts not found';
        SET @ERRCNT = @ERRCNT + 1;
    END;
ELSE
    BEGIN
        PRINT '----------------------------------------------------------------------------';
        PRINT 'INSERT TEST PASSED: ' + CAST ( @InsertedRecCnt AS nvarchar ( 50)) + ' records inserted.';
        PRINT '----------------------------------------------------------------------------';
    END;
PRINT '*******************************************************************';

/*--------------------------------------------------------
Remove the newly added test records 
NOTE: This statement will have to be tailored for each use
*/

DELETE FROM ##Temp_SmallSteps
       WHERE
             UserID < 0;
PRINT '#Test Records removed from TEMP TBL: ' + CAST ( @@ROWCOUNT AS nvarchar (50)) ;

/*---------------------------------------------------------
***********************************************************
Now, let's make totally certain deleted records are found.
***********************************************************
*/

DECLARE
@iCntBeforeDEL AS int = 0;
SET @iCntBeforeDEL = ( SELECT
                              COUNT ( *) 
                              FROM DIM_EDW_SmallSteps
                              WHERE DeletedFlg IS NULL) ;
PRINT 'Staging Record Count Before Delete: ' + CAST ( @iCntBeforeDEL AS nvarchar (50)) ;

EXEC proc_CT_SmallSteps_AddDeletedRecs ;

DECLARE
@iCntAfterDel2 AS int = ( SELECT
                                 COUNT ( *) 
                                 FROM DIM_EDW_SmallSteps
                                 WHERE DeletedFlg IS NULL) ;
PRINT '*******************************************************************';
PRINT 'Staging Record Count Before: ' + CAST ( @iCntBeforeDEL AS nvarchar (50)) ;
PRINT 'Staging Record Count After : ' + CAST ( @iCntAfterDel2 AS nvarchar (50)) ;
PRINT '02 Deleted Records found: ' + CAST ( @iCntBeforeDEL - @iCntAfterDel2 AS nvarchar (50)) ;
DECLARE
@diffdel AS int = @iCntAfterDel2 - @iCntBeforeDEL;

IF @diffdel = 0
    BEGIN
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        PRINT 'ERROR: New deletes not found';
        SET @ERRCNT = @ERRCNT + 1;
    END;
ELSE
    BEGIN
        PRINT '----------------------------------------------------------------------------';
        PRINT 'FINAL DELETE TEST PASSED: - ' + CAST ( ABS (@diffdel) AS nvarchar ( 50)) + ' deleted records tagged.';
        PRINT '----------------------------------------------------------------------------';
    END;
PRINT '*******************************************************************';
PRINT 'TEST COMPLETE.';
SET NOCOUNT OFF;

DECLARE
@ED AS datetime2 = GETDATE () ;
DECLARE
@ELAPSEDTime AS decimal ( 10 , 2) = ( SELECT
                                             DATEDIFF ( second , @SD , @ED)) ;
DECLARE
@minutes AS decimal ( 10 , 2) = @ELAPSEDTime / 60;
PRINT ' ';
PRINT '*********************************************************************************';
PRINT '******* TOTAL MINUTES TO RUN TEST: ' + CAST ( @minutes AS nvarchar (50)) + ' *************';
PRINT '******* TOTAL ERRORS FOUND       : ' + CAST ( @ERRCNT AS nvarchar (50)) + ' *************';
PRINT '*********************************************************************************';
PRINT ' ';
PRINT 'Check for and remove DUPS';
EXEC proc_CT_EDW_SmallSteps_NoDups ;
PRINT ' ';
PRINT 'Check for and remove TEMP DUPS';
EXEC proc_CT_EDW_SmallSteps_Temp_NoDups ;

declare @TotRecs as int = (select count(*) from DIM_EDW_SmallSteps);
PRINT ' ';
PRINT '*********************************************************************************';
print 'Total Recs : ' + cast(@TotRecs as nvarchar(50)) ;
print 'Updated    : ' + cast(@iUpdated as nvarchar(50)) ;
print 'Deleted    : ' + cast(@CntMArkedAsDeleted as nvarchar(50)) ;
print 'Inserted   : ' + cast(@InsertedRecCnt as nvarchar(50)) ;
PRINT '*********************************************************************************';
