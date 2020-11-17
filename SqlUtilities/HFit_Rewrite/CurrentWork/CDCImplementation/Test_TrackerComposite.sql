
--*****************************
--TEST Composite Tracker
-- use KenticoCMS_Prod1
--*****************************

SET NOCOUNT ON;
DECLARE
@iCnt AS INT = 0
, @iTotalRecs AS INT = 0
, @RELOADALL AS INT = 0;
SET @iTotalRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_TrackerCompositeDetails );
SET @iCnt = ( SELECT
                     COUNT ( *) 
                     FROM HFit_TrackerBloodPressure );
PRINT 'Row count from BASE TABLE HFit_TrackerBloodPressure : ' + CAST ( @iTotalRecs AS NVARCHAR (50)) ;
PRINT 'Row count from parent view: ' + CAST ( @iCnt AS NVARCHAR (50)) ;

--TEST THE Change Tracking View

DECLARE
@iCntCT AS INT = 0;
SET @iCntCT = ( SELECT
                       COUNT ( *) 
                       FROM view_EDW_TrackerCompositeDetails_CT );
PRINT 'Row count from CT view: ' + CAST ( @iCntCT AS NVARCHAR (50)) ;
DECLARE
@iCntDIFF AS INT = 0;
SET @iCntDIFF = @iCnt - @iCntCT;
PRINT 'ROW DIFF Between BASE View and CT View (zero is good check): ' + CAST ( @iCntDIFF AS NVARCHAR (50)) ;

--Test the RELOAD ALL of the procedure

IF @RELOADALL = 1
    BEGIN
        EXEC proc_STAGING_EDW_CompositeTracker 1;
    END;

--Test the LOAD Changes Only of the procedure

EXEC proc_STAGING_EDW_CompositeTracker 0;
IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE
                   name = 'temp_composite') 
    BEGIN
        PRINT 'Dropped temp_composite table ';
        DROP TABLE
             temp_composite;
    END;

/*-------------------------------------------
*******************************************
** BACKUP THE BASE TABLE BEFORE PROCEEDING **
*******************************************
*/

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.tables
                       WHERE
                       name = 'temp_composite_FULL_Backup') 
    BEGIN
        SELECT
               *
        INTO
             temp_composite_FULL_Backup
               FROM HFit_TrackerBloodPressure;
    END;
IF EXISTS ( SELECT
                   name
                   FROM sys.tables
                   WHERE
                   name = 'temp_composite') 
    BEGIN
        DROP TABLE
             temp_composite;
    END;

/*---------------------------------------------
*********************************************
Get 100 rows and save them for testing purposes
*********************************************
*/

SELECT TOP 100
       *
INTO
     temp_composite
       FROM HFit_TrackerBloodPressure
       ORDER BY
                ItemID DESC;

--select * from temp_composite

/*-----------------------------------------------------------------------------------------------------------------------
***********************************************************************************************************************
*************************************************************************************************************************
    Modify a portion of the 100 rows AND validate that change tracking finds them and updates the staging table.
    NOTE: The column to be modified will have to be validated for each base table to ensure it is used in the view.
*************************************************************************************************************************
***********************************************************************************************************************
*/

DELETE FROM FACT_EDW_Trackers
WHERE
      Notes = '@@@';

--select * from HFit_TrackerBloodPressure

UPDATE HFit_TrackerBloodPressure
       SET
           Notes = '@@@'
WHERE
      ItemID IN ( SELECT
                         ItemId
                         FROM temp_composite) 
  AND Notes IS NULL;
DECLARE
@iChgCnt AS INT = 0;
SET @iChgCnt = ( SELECT
                        COUNT ( *) 
                        FROM HFit_TrackerBloodPressure
                        WHERE Notes = '@@@' );
PRINT 'Count of changes to Expect: ' + CAST ( @iChgCnt AS NVARCHAR (50)) ;

/*------------------------------------
************************************
**************************************
    Make sure Changes ARE detected
**************************************
************************************
*/

PRINT 'Make sure Changes ARE detected.';
EXEC proc_STAGING_EDW_CompositeTracker;
DECLARE
@iChgFoundCnt AS INT = 0;
SET @iChgCnt = ( SELECT
                        COUNT ( *) 
                        FROM FACT_EDW_Trackers
                        WHERE Notes = '@@@' );
IF @iChgCnt > 0
    BEGIN
        PRINT '********************************************************************************';
        PRINT 'CHANGE DETECTION PASSED: ' + CAST ( @iChgCnt AS NVARCHAR ( 50)) + ' records found to be updated.';
        PRINT '********************************************************************************';
    END;
ELSE
    BEGIN
        PRINT '********************************************************************************';
        PRINT 'CHANGE DETECTION FAILED: NO records found to be updated.';
        PRINT '********************************************************************************';
    END;

/*------------------------------------
************************************
**************************************
    Put back the original Data
**************************************
************************************
*/

PRINT 'Reset data in base table.';
UPDATE HFit_TrackerBloodPressure
       SET
           Notes = NULL
WHERE
      Notes = '@@@';
DECLARE
@iChangesVerifiedCnt AS INT = ( SELECT
                                       COUNT ( *) 
                                       FROM FACT_EDW_Trackers
                                       WHERE Notes = '@@@' );
PRINT '#CHANGES VERIFIED in Staging Table: ' + CAST ( @iChangesVerifiedCnt AS NVARCHAR (50)) ;
DELETE FROM FACT_EDW_Trackers
WHERE
      Notes = '@@@';
PRINT 'Changes to data reset: ';
PRINT 'Make sure REVERTED Changes ARE detected.';
EXEC proc_STAGING_EDW_CompositeTracker;

/*--------------------------------------
**************************************
****************************************
    DROP ROWS AND LOOK FOR DELETES 
****************************************
**************************************
*/

PRINT 'Record count before delete: ' + CAST ( @iTotalRecs AS NVARCHAR (50)) ;

--select * from temp_composite

DELETE FROM HFit_TrackerBloodPressure
WHERE
      ItemID IN ( SELECT
                         ItemId
                         FROM temp_composite) ;
DECLARE
@CntAfterDelete AS INT = 0;
SET @CntAfterDelete = ( SELECT
                               COUNT ( *) 
                               FROM HFit_TrackerBloodPressure );
PRINT 'Changes to data reset: ';
PRINT 'Record count After delete: ' + CAST ( @CntAfterDelete AS NVARCHAR (50)) ;
PRINT 'Validate deletes are detected and marked.';
EXEC proc_STAGING_EDW_CompositeTracker;
DECLARE
@CntMArkedAsDeleted AS INT = ( SELECT
                                      COUNT ( *) 
                                      FROM FACT_EDW_Trackers
                                      WHERE DeletedFlg IS NOT NULL );
IF
@CntMArkedAsDeleted = 0
    BEGIN
        PRINT '********************************************************************************************';
        PRINT 'ERROR: Deleted records not found and marked.';
        PRINT '********************************************************************************************';
    END;
ELSE
    BEGIN
        PRINT '********************************************************************************************';
        PRINT 'DELETION TEST PASSED: Record count marked as deleted: ' + CAST ( @CntMArkedAsDeleted AS NVARCHAR ( 50)) ;
        PRINT '********************************************************************************************';
    END;
PRINT 'Put back the deleted records to the base table.';

/*---------------------------------------------------------
*********************************************************
**********************************************************
USE The columns from the base table and the temp table here
**********************************************************
*********************************************************
*/

SET IDENTITY_INSERT HFit_TrackerBloodPressure ON;
INSERT INTO HFit_TrackerBloodPressure (
       ItemID
     , EventDate
     , IsProfessionallyCollected
     , TrackerCollectionSourceID
     , Notes
     , UserID
     , Systolic
     , Diastolic
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , IsProcessedForHa
     , VendorID
     , IncludeTime) 
SELECT
       ItemID
     , EventDate
     , IsProfessionallyCollected
     , TrackerCollectionSourceID
     , Notes
     , UserID
     , Systolic
     , Diastolic
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , IsProcessedForHa
     , VendorID
     , IncludeTime
       FROM temp_composite
       WHERE ItemID NOT IN (
    SELECT
           itemId
           FROM HFit_TrackerBloodPressure );
SET IDENTITY_INSERT HFit_TrackerBloodPressure OFF;
DECLARE
@NewTotal AS INT = 0;
SET @NewTotal = ( SELECT
                         COUNT ( *) 
                         FROM HFit_TrackerBloodPressure );
PRINT 'Record count after reinsertion: ' + CAST ( @NewTotal AS NVARCHAR (50)) ;
PRINT 'Original Record Count: ' + CAST ( @iTotalRecs AS NVARCHAR (50)) ;
EXEC proc_STAGING_EDW_CompositeTracker;

/*--------------------------------------------------------
********************************************************
Confirm that INSERTS are detected and registered.
NOTE: This statement will have to be tailored for each use
********************************************************
*/

INSERT INTO dbo.DIM_TEMP_EDW_Tracker_DATA
(
       TrackerNameAggregateTable
     , ItemID
     , EventDate
     , IsProfessionallyCollected
     , TrackerCollectionSourceID
     , Notes
     , UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , EventName
     , UOM
     , KEY1
     , VAL1
     , KEY2
     , VAL2
     , KEY3
     , VAL3
     , KEY4
     , VAL4
     , KEY5
     , VAL5
     , KEY6
     , VAL6
     , KEY7
     , VAL7
     , KEY8
     , VAL8
     , KEY9
     , VAL9
     , KEY10
     , VAL10
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , IsProcessedForHa
     , TXTKEY1
     , TXTVAL1
     , TXTKEY2
     , TXTVAL2
     , TXTKEY3
     , TXTVAL3
     , ItemOrder
     , ItemGuid
     , UserGuid
     , MPI
     , ClientCode
     , SiteGUID
     , AccountID
     , AccountCD
     , IsAvailable
     , IsCustom
     , UniqueName
     , ColDesc
     , VendorID
     , VendorName
     , CT_ItemID
     , CT_ChangeVersion
     , CMS_Operation
     , DeletedFlg
     , ItemLastUpdated) 
SELECT TOP 50
       TrackerNameAggregateTable
     , ItemID * -1 AS ItemID
     , EventDate
     , IsProfessionallyCollected
     , TrackerCollectionSourceID
     , Notes
     , UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , EventName
     , UOM
     , KEY1
     , VAL1
     , KEY2
     , VAL2
     , KEY3
     , VAL3
     , KEY4
     , VAL4
     , KEY5
     , VAL5
     , KEY6
     , VAL6
     , KEY7
     , VAL7
     , KEY8
     , VAL8
     , KEY9
     , VAL9
     , KEY10
     , VAL10
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , IsProcessedForHa
     , TXTKEY1
     , TXTVAL1
     , TXTKEY2
     , TXTVAL2
     , TXTKEY3
     , TXTVAL3
     , ItemOrder
     , ItemGuid
     , UserGuid
     , MPI
     , ClientCode
     , SiteGUID
     , AccountID
     , AccountCD
     , IsAvailable
     , IsCustom
     , UniqueName
     , ColDesc
     , VendorID
     , VendorName
     , CT_ItemID
     , CT_ChangeVersion
     , CMS_Operation
     , DeletedFlg
     , ItemLastUpdated
       FROM FACT_EDW_Trackers;

/*---------------
***************
    TEST INSERTS 
***************
*/

DECLARE
@iCntBeforeInsert AS INT = 0;
DECLARE
@iCntAfterInsert AS INT = 0;
SET @iCntBeforeInsert = ( SELECT
                                 COUNT ( *) 
                                 FROM FACT_EDW_Trackers );
PRINT 'Staging Record Count Before Insert: ' + CAST ( @iCntBeforeInsert AS NVARCHAR (50)) ;
DELETE FROM DIM_TEMP_EDW_Tracker_DATA
WHERE
      TrackerNameAggregateTable  LIKE 'Z-%';
DECLARE
@NowDate AS DATETIME = GETDATE () ;
DECLARE
@strTrackerNameAggregateTable AS NVARCHAR ( 50) = 'Z-' + CAST ( @NowDate AS NVARCHAR ( 50)) ;
INSERT INTO dbo.DIM_TEMP_EDW_Tracker_DATA
(
       TrackerNameAggregateTable
     , ItemID
     , EventDate
     , IsProfessionallyCollected
     , TrackerCollectionSourceID
     , Notes
     , UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , EventName
     , UOM
     , KEY1
     , VAL1
     , KEY2
     , VAL2
     , KEY3
     , VAL3
     , KEY4
     , VAL4
     , KEY5
     , VAL5
     , KEY6
     , VAL6
     , KEY7
     , VAL7
     , KEY8
     , VAL8
     , KEY9
     , VAL9
     , KEY10
     , VAL10
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , IsProcessedForHa
     , TXTKEY1
     , TXTVAL1
     , TXTKEY2
     , TXTVAL2
     , TXTKEY3
     , TXTVAL3
     , ItemOrder
     , ItemGuid
     , UserGuid
     , MPI
     , ClientCode
     , SiteGUID
     , AccountID
     , AccountCD
     , IsAvailable
     , IsCustom
     , UniqueName
     , ColDesc
     , VendorID
     , VendorName
     , CT_ItemID
     , CT_ChangeVersion
     , CMS_Operation
     , DeletedFlg
     , ItemLastUpdated) 
SELECT TOP 10
       @strTrackerNameAggregateTable
     , ItemID * -1 AS ItemID
     , EventDate
     , IsProfessionallyCollected
     , TrackerCollectionSourceID
     , Notes
     , UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , EventName
     , UOM
     , KEY1
     , -999.99

       --[VAL1]

     , KEY2
     , VAL2
     , KEY3
     , VAL3
     , KEY4
     , VAL4
     , KEY5
     , VAL5
     , KEY6
     , VAL6
     , KEY7
     , VAL7
     , KEY8
     , VAL8
     , KEY9
     , VAL9
     , KEY10
     , VAL10
     , ItemCreatedBy
     , ItemCreatedWhen
     , ItemModifiedBy
     , ItemModifiedWhen
     , IsProcessedForHa
     , TXTKEY1
     , TXTVAL1
     , TXTKEY2
     , TXTVAL2
     , TXTKEY3
     , TXTVAL3
     , ItemOrder
     , ItemGuid
     , UserGuid
     , MPI
     , ClientCode
     , SiteGUID
     , AccountID
     , AccountCD
     , IsAvailable
     , IsCustom
     , UniqueName
     , ColDesc
     , VendorID
     , VendorName
     , CT_ItemID
     , CT_ChangeVersion
     , CMS_Operation
     , DeletedFlg
     , ItemLastUpdated
       FROM FACT_EDW_Trackers;
DECLARE
@iNewRecsInserted AS INT = @@ROWCOUNT;
PRINT 'NEW TEst Recs Inserted: ' + CAST ( @iNewRecsInserted AS NVARCHAR (50)) ;
WITH CTE_NEW (
     TrackerNameAggregateTable
   , ItemID) 
    AS (
    SELECT
           TrackerNameAggregateTable
         , ItemID
           FROM DIM_TEMP_EDW_Tracker_DATA
    EXCEPT
    SELECT
           TrackerNameAggregateTable
         , ItemID
           FROM FACT_EDW_Trackers
    ) 
    INSERT INTO dbo.FACT_EDW_Trackers (
           TrackerNameAggregateTable
         , ItemID
         , EventDate
         , IsProfessionallyCollected
         , TrackerCollectionSourceID
         , Notes
         , UserID
         , CollectionSourceName_Internal
         , CollectionSourceName_External
         , EventName
         , UOM
         , KEY1
         , VAL1
         , KEY2
         , VAL2
         , KEY3
         , VAL3
         , KEY4
         , VAL4
         , KEY5
         , VAL5
         , KEY6
         , VAL6
         , KEY7
         , VAL7
         , KEY8
         , VAL8
         , KEY9
         , VAL9
         , KEY10
         , VAL10
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , IsProcessedForHa
         , TXTKEY1
         , TXTVAL1
         , TXTKEY2
         , TXTVAL2
         , TXTKEY3
         , TXTVAL3
         , ItemOrder
         , ItemGuid
         , UserGuid
         , MPI
         , ClientCode
         , SiteGUID
         , AccountID
         , AccountCD
         , IsAvailable
         , IsCustom
         , UniqueName
         , ColDesc
         , VendorID
         , VendorName
         , CT_ItemID
         , CT_ChangeVersion
         , CMS_Operation
         , ItemLastUpdated) 
    SELECT
           T1.TrackerNameAggregateTable
         , T1.ItemID
         , T1.EventDate
         , T1.IsProfessionallyCollected
         , T1.TrackerCollectionSourceID
         , T1.Notes
         , T1.UserID
         , T1.CollectionSourceName_Internal
         , T1.CollectionSourceName_External
         , T1.EventName
         , T1.UOM
         , T1.KEY1
         , T1.VAL1
         , T1.KEY2
         , T1.VAL2
         , T1.KEY3
         , T1.VAL3
         , T1.KEY4
         , T1.VAL4
         , T1.KEY5
         , T1.VAL5
         , T1.KEY6
         , T1.VAL6
         , T1.KEY7
         , T1.VAL7
         , T1.KEY8
         , T1.VAL8
         , T1.KEY9
         , T1.VAL9
         , T1.KEY10
         , T1.VAL10
         , T1.ItemCreatedBy
         , T1.ItemCreatedWhen
         , T1.ItemModifiedBy
         , T1.ItemModifiedWhen
         , T1.IsProcessedForHa
         , T1.TXTKEY1
         , T1.TXTVAL1
         , T1.TXTKEY2
         , T1.TXTVAL2
         , T1.TXTKEY3
         , T1.TXTVAL3
         , T1.ItemOrder
         , T1.ItemGuid
         , T1.UserGuid
         , T1.MPI
         , T1.ClientCode
         , T1.SiteGUID
         , T1.AccountID
         , T1.AccountCD
         , T1.IsAvailable
         , T1.IsCustom
         , T1.UniqueName
         , T1.ColDesc
         , T1.VendorID
         , T1.VendorName
         , T1.CT_ItemID
         , T1.CT_ChangeVersion
         , T1.CMS_Operation
         , GETDATE () 
           FROM DIM_TEMP_EDW_Tracker_DATA AS T1
                    INNER JOIN CTE_NEW AS T2
                        ON T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable
                       AND T1.ItemId = T2.ItemId;
DECLARE
@iInserts AS INT = @@ROWCOUNT;
SET @iCntAfterInsert = ( SELECT
                                COUNT ( *) 
                                FROM FACT_EDW_Trackers );
PRINT 'Staging Record Count After Insert: ' + CAST ( @iCntAfterInsert AS NVARCHAR (50)) ;
PRINT 'New Records found: ' + CAST ( @iCntAfterInsert - @iCntBeforeInsert AS NVARCHAR (50)) ;
DECLARE
@iNew AS INT = @iCntAfterInsert - @iCntBeforeInsert;
PRINT '**********************************************************************';
IF @iInserts > 0
    BEGIN
        PRINT 'PASSED INSERT TEST - NEW RECORDS found: ' + CAST ( @iNew AS NVARCHAR ( 50)) ;
    END;
ELSE
    BEGIN
        PRINT 'FAILED INSERT TEST - NO NEW RECORDS found';
    END;
PRINT '**********************************************************************';

/*-----------------------------------------------------------
-------------------------------------------------------------
*************************************************************
********************************************************
Remove the newly added test records 
NOTE: This statement will have to be tailored for each use
--select * from DIM_TEMP_EDW_Tracker_DATA WHERE ItemID < 0;
********************************************************
*************************************************************
*/

UPDATE DIM_TEMP_EDW_Tracker_DATA
       SET
           DeletedFlg = 1
         ,CMS_Operation = 'D'
WHERE
      TrackerNameAggregateTable = @strTrackerNameAggregateTable;
PRINT 'Tagged for delete: ' + CAST ( @@ROWCOUNT AS NVARCHAR (50)) ;
SET NOCOUNT ON;

--***************************************************************

UPDATE StagedData
       SET
           DeletedFlg = 1
         ,ItemLastUpdated = GETDATE () 
         ,CMS_Operation = 'D'
           FROM DIM_TEMP_EDW_Tracker_DATA AS CT
                    INNER JOIN FACT_EDW_Trackers AS StagedData
                        ON
                        CT.ItemID = StagedData.ItemID
                    AND CT.TrackerNameAggregateTable = StagedData.TrackerNameAggregateTable
                    AND CT.CMS_Operation = 'D';
DECLARE
@nbrMarkedForDel AS INT = @@ROWCOUNT;
PRINT '#Test Records removed: ' + CAST ( @nbrMarkedForDel AS NVARCHAR (50)) ;

--***************************************************************

IF
@nbrMarkedForDel > 0
    BEGIN
        PRINT '**********************************************';
        PRINT 'PASSED DELETION TEST.';
        PRINT '**********************************************';
    END ;
ELSE
    BEGIN
        PRINT '**********************************************';
        PRINT 'PASSED DELETION TEST.';
        PRINT '**********************************************';
    END;
SET NOCOUNT OFF;
PRINT '********************************************************************************************';
IF @iChgCnt > 0
    BEGIN
        PRINT 'CHANGE DETECTION PASSED: ' + CAST ( @iChgCnt AS NVARCHAR ( 50)) ;
    END;
IF
@CntMArkedAsDeleted > 0
    BEGIN
        PRINT 'DELETION DETECTION PASSED: ' + CAST ( @CntMArkedAsDeleted AS NVARCHAR ( 50)) ;
    END;
IF @iNew > 0
    BEGIN
        PRINT 'NEW RECORDS DETECTION PASSED: ' + CAST ( @iNew AS NVARCHAR ( 50)) ;
    END;
PRINT '********************************************************************************************';

--SELECT
--	  *
--  FROM EDW_CT_ExecutionLog
--  WHERE CT_NAME = 'proc_STAGING_EDW_CompositeTracker'
--  ORDER BY
--		 CT_Start DESC;
