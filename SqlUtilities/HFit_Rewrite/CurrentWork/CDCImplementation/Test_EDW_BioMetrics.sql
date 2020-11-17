
--TEST proc_EDW_BioMetrics
SET NOCOUNT ON;
PRINT '****************************************************************';
PRINT '** TEST #1 Initial counts proc_EDW_BioMetrics ';
PRINT '****************************************************************';
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;
DECLARE
@iCnt AS int = 0
, @iTotalRecs AS int = 0
, @PerformReloadTest AS bit = 0
, @ErrCnt AS int = 0;

/*-----------------------------
*****************************
******************************
TEST the Parent View
*******************************
*****************************
*/

SET @iTotalRecs = ( SELECT
                           COUNT ( *) 
                           FROM view_EDW_BioMetrics) ;
SET @iCnt = ( SELECT
                     COUNT ( *) 
                     FROM HFit_Account) ;
PRINT 'Row count from BASE TABLE HFit_Account : ' + CAST ( @iTotalRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view: ' + CAST ( @iCnt AS nvarchar (50)) ;
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

--TEST THE Change Tracking View

DECLARE
@iCntCT AS int = 0;
SET @iCntCT = ( SELECT
                       COUNT ( *) 
                       FROM view_EDW_BioMetrics_CT) ;
PRINT 'Row count from CT view: ' + CAST ( @iCntCT AS nvarchar (50)) ;
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;
DECLARE
@iCntDIFF AS int = 0;
SET @iCntDIFF = @iTotalRecs - @iCntCT;
IF @iCntDIFF = 0
    BEGIN
        PRINT '*****************************************************************';
        PRINT 'TEST #1 PASSED - ROW DIFF Between BASE View and CT View is ZERO) ';
        PRINT '*****************************************************************';
    END;
ELSE
    BEGIN
        PRINT '*****************************************************************';
        PRINT 'TEST #1 FAILED - ROW DIFF Between BASE View and CT View: ' + CAST ( @iCntDIFF AS nvarchar ( 50)) + ', should be ZERO.';
        PRINT '*****************************************************************';
    END;
print 'PRINT Check';

--Test the RELOAD ALL of the procedure 130

PRINT '**----------------------------------------------------------------**';
PRINT '** TEST #2 Initial LOADS ';
PRINT '**----------------------------------------------------------------**';

IF @PerformReloadTest = 1
    BEGIN
        EXEC proc_EDW_BioMetrics 1;
        EXEC proc_EDW_BioMetrics 0;
        DECLARE
        @iTempRecCnt AS int = ( SELECT
                                       COUNT ( *) 
                                       FROM ##Temp_BioMetrics) ;
        DECLARE
        @iStagingRecCnt AS int = ( SELECT
                                          COUNT ( *) 
                                          FROM DIM_EDW_BioMetrics) ;
        PRINT '****************************************************************';
        PRINT '** TEST #2 Initial LOADS COUNTS: ';
        PRINT 'Temp Records Created: ' + CAST ( @iTempRecCnt AS nvarchar ( 50)) ;
        PRINT 'Staging Records Created: ' + CAST ( @iStagingRecCnt AS nvarchar ( 50)) ;
        PRINT '****************************************************************';

        IF EXISTS ( SELECT
                           name
                           FROM sys.tables
                           WHERE name = 'Temp_BioMetricsTEST') 
            BEGIN
                PRINT 'Dropped Temp_BioMetricsTEST table ';
                DROP TABLE
                     Temp_BioMetricsTEST;
            END;
    END;
ELSE
    BEGIN
        PRINT '****************************************************************';
        PRINT '** TEST #2 Initial LOADS COUNTS: ';
        PRINT 'WAS NOT SELECTED, continuing.';
        PRINT '****************************************************************';
    END;

/*-----------------------------------------------------------------------
-------------------------------------------------------------------
SAVE THE DATA TO A TEMPFILE IF DESIRED:
    select * into TEMP_EDW_BioMetrics from DIM_EDW_BioMetrics
    exec quickcount TEMP_EDW_BioMetrics
*/

DECLARE @RecCount AS int = 0;
IF NOT EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE id = OBJECT_ID ( N'tempdb..##Temp_BioMetrics')) 
    BEGIN
        PRINT '##Temp_BioMetrics MISSING - adding data';
        SELECT
               * INTO
                      ##Temp_BioMetrics
               FROM DIM_EDW_BioMetrics;
        SET @RecCount = @@ROWCOUNT;
    END;
ELSE
    BEGIN
        SET @RecCount = (SELECT
                                COUNT (*) 
                                FROM ##Temp_BioMetrics) ;
    END;

PRINT 'RECORDS COUNT: ' + CAST (@RecCount AS nvarchar (50)) ;
IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'PI_EDW_BioMetrics_IDs') 
    BEGIN
        PRINT 'Adding INDEX PI_EDW_BioMetrics_IDs at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
        CREATE CLUSTERED INDEX PI_EDW_BioMetrics_IDs ON dbo.DIM_EDW_BioMetrics ( UserID , UserGUID , SiteID ,
        SiteGUID , itemid , TBL) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF ,
        DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
    END;
IF NOT EXISTS ( SELECT
                       name
                       FROM sys.indexes
                       WHERE name = 'temp_PI_EDW_BioMetrics_IDs') 
    BEGIN
        PRINT 'Adding INDEX temp_PI_EDW_BioMetrics_IDs at: ' + CAST ( GETDATE () AS nvarchar ( 50)) ;
        CREATE CLUSTERED INDEX temp_PI_EDW_BioMetrics_IDs ON dbo.##Temp_BioMetrics ( UserID , UserGUID , SiteID , SiteGUID ,
        itemid , TBL) WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF ,
        ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ;
    END;

/*-----------------------------------------
-------------------------------------------
TEST THE ABILITY TO FIND CHANGES
*/
DECLARE @iTypeChangesFound AS int = 0;
EXEC @iTypeChangesFound = proc_CkBioMetricChanges ;
PRINT 'Return from @iTypeChangesFound: ' + CAST (@iTypeChangesFound AS nvarchar (50)) ;

/*-----------------------------------------
-------------------------------------------
BACKUP THE BASE TABLE BEFORE PROCEEDING 
*/

IF NOT EXISTS ( SELECT
                       name
                       FROM sys.tables
                       WHERE name = 'Temp_HFit_Account_BioMetrics_FULL_Backup') 
    BEGIN
        SELECT
               * INTO
                      Temp_HFit_Account_BioMetrics_FULL_Backup
               FROM HFit_Account;
    END;

/*------------------------------------------------------
********************************************************
** GET A FULL BACKUP OF THE DATA BEFORE PROCEEDING **
********************************************************
*/

/*--------------------------------------------
Get 50 rows and save them for testing purposes
*/
IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'Temp_BioMetricsTEST') 
    BEGIN
        DROP TABLE
             Temp_BioMetricsTEST;
    END;

SELECT TOP 50
       *
INTO
     Temp_BioMetricsTEST
       FROM HFit_Account
       ORDER BY
                AccountID;

/*---------------------------------------------------------------------------------------------------------------------
***********************************************************************************************************************
    Modify a portion of the 100 rows AND validate that change tracking finds them and updates the staging table.
    NOTE: The column to be modified will have to be validated for each base table to ensure it is used in the view.
***********************************************************************************************************************
*/

--DBCC DROPCLEANBUFFERS; 
--select top 100 * from Temp_BioMetricsTEST WHERE AccountNAme  = 'brunswic';
--select top 100 * from ##Temp_BioMetrics
-- select top 100 * from HFit_Account

UPDATE HFit_Account
  SET
      AccountCD = UPPER (AccountCD) 
       WHERE
             AccountCD = (SELECT TOP 1
                                 AccountCD
                                 FROM ##Temp_BioMetrics
                                 ORDER BY
                                          AccountCD) ;

DECLARE
@iChgCnt AS int = 0;
SET @iChgCnt = ( SELECT
                        COUNT ( *) 
                        FROM HFit_Account
                        WHERE AccountCD = (SELECT TOP 1
                                                  AccountCD
                                                  FROM ##Temp_BioMetrics
                                                  ORDER BY
                                                           AccountCD)) ;

PRINT 'ROWS changed: ' + CAST ( @iChgCnt AS nvarchar (50)) ;
RAISERROR ( 'PRINT Check' , 10 , 1) WITH NOWAIT;

--EXEC proc_Add_EDW_CT_StdCols '##Temp_BioMetrics';

/*------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
----------------------------------
************************************
    Make sure Changes ARE detected
    select distinct count(*), accountCD from ##Temp_BioMetrics group by accountCD
    select top 100 * from ##Temp_BioMetrics WHERE AccountCD  = 'brunswic';
    delete from ##Temp_BioMetrics WHERE AccountCD  = 'brunswic' and UserID = 26399;    
************************************
*/

--************************************************************
PRINT 'Make sure NEW Records : ';
DECLARE @iNewInserts AS int = 0;
DELETE FROM DIM_EDW_BioMetrics
       WHERE
             AccountCD = 'brunswic';
EXEC @iNewInserts = proc_CT_BioMetrics_AddNewRecs;
PRINT 'NEW Records found: ' + CAST ( @iNewInserts AS nvarchar (50)) ;

--************************************************************
PRINT 'Make sure UPDATED Records are found: ';
DECLARE @iUpdates  AS int = 0;
UPDATE ##Temp_BioMetrics
  SET
      Notes = UPPER (notes) 
       WHERE
             UserID = (SELECT TOP 1
                              UserID
                              FROM ##Temp_BioMetrics) AND
             notes IS NOT NULL;
SET @iUpdates = @@ROWCOUNT;

UPDATE ##Temp_BioMetrics
  SET
      HashCode = HASHBYTES ( 'SHA1' ,
      ISNULL ( CAST ( UserID AS nvarchar (50)) , '-') + ISNULL ( CAST ( Notes AS nvarchar (50)) , '-')) 
       WHERE
             UserID = (SELECT TOP 1
                              UserID
                              FROM ##Temp_BioMetrics) AND
             notes IS NOT NULL;

DECLARE @iNewUpdates AS int = 0;
EXEC @iNewUpdates = proc_CT_BioMetrics_AddUpdatedRecs;
PRINT 'UPDATED Records found: ' + CAST ( @iNewUpdates AS nvarchar (50)) ;

--************************************************************
PRINT 'Make sure DELETED Records are found: ';
-- select top 1 AccountCD from ##Temp_BioMetrics
DELETE FROM ##Temp_BioMetrics
       WHERE
             AccountCD = (SELECT TOP 1
                                 AccountCD
                                 FROM ##Temp_BioMetrics) ;

DECLARE
@iDeleted AS int = @@ROWCOUNT;
PRINT 'Records just now Deleted: ' + CAST ( @iDeleted AS nvarchar (50)) ;
EXEC @iDeleted = proc_CT_BioMetrics_AddDeletedRecs;
PRINT 'Records Marked as Deleted in STAGED TABLE: ' + CAST ( @iDeleted AS nvarchar (50)) ;

--************************************************************
DECLARE
@i1 AS int = ( SELECT
                      COUNT ( *) 
                      FROM DIM_EDW_BioMetrics
                      WHERE DeletedFlg IS NOT NULL) ;
PRINT 'TOTAL Recs marked as deleted: ' + CAST (@i1  AS nvarchar (50)) ;

--************************************************************
--EXEC proc_EDW_BioMetrics 0;

DECLARE
@i2 AS int = ( SELECT
                      COUNT ( *) 
                      FROM DIM_EDW_BioMetrics
                      WHERE DeletedFlg IS NOT NULL) ;

PRINT 'Number of rows marked as deleted before execution: ' + CAST ( @i1 AS nvarchar (50)) ;
PRINT 'Number of rows marked as deleted AFTER  execution: ' + CAST ( @i2 AS nvarchar (50)) ;
DECLARE
@i3 AS int = @i2 - @i1;
PRINT 'Number of rows marked for deletion: ' + CAST ( @i3 AS nvarchar (50)) ;
PRINT '***************************************************************************************************************';
IF @i3 = 0
    BEGIN
        SET @ErrCnt = @ErrCnt + 1;
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        PRINT 'TEST DELETED FAILED: ';
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
    END;
ELSE
    BEGIN
        PRINT 'TEST DELETED SUCCESSFUL: ';
    END;
PRINT '***************************************************************************************************************';

/*----------------------------------
************************************
    Put back the original Data
************************************
*/

--delete from DIM_EDW_BioMetrics where AccountCD like 'Z%' ;
--SELECT TOP 1
--       AccountCD
--       FROM ##Temp_BioMetrics
--       ORDER BY
--                AccountCD;
PRINT 'Reset data in base table.';
UPDATE HFit_Account
  SET
      AccountCD = LOWER (AccountCD) 
       WHERE
             AccountCD = (SELECT TOP 1
                                 AccountCD
                                 FROM ##Temp_BioMetrics
                                 ORDER BY
                                          AccountCD) ;

--select top 100 * from ##Temp_BioMetrics
--select top 100 * from DIM_EDW_BioMetrics

UPDATE ##Temp_BioMetrics
  SET
      Userid = -1
       WHERE
             UserID = (SELECT TOP 1
                              UserID
                              FROM ##Temp_BioMetrics
                              ORDER BY
                                       UserID DESC) ;
UPDATE DIM_EDW_BioMetrics
  SET
      Userid = -2
       WHERE
             UserID = (SELECT TOP 1
                              UserID
                              FROM DIM_EDW_BioMetrics
                              ORDER BY
                                       UserID) ;

DECLARE
@II AS int = 0;

PRINT '************************************************************';
PRINT 'FINAL CHECK';
PRINT '------------------------------------------------------------';
EXEC @II = proc_CT_BioMetrics_AddNewRecs;
print 'INSERTED: ' + cast(@II as nvarchar(50)) ;
EXEC @II = proc_CT_BioMetrics_AddDeletedRecs;
print 'DELETED: ' + cast(@II as nvarchar(50)) ;
EXEC @II = proc_CT_BioMetrics_AddUpdatedRecs;
print 'UPDATED: ' + cast(@II as nvarchar(50)) ;

declare @iInserted int = 0 ;


PRINT '------------------------------------------------------------';
PRINT '************************************************************';
print 'TEST COMPLETE';
PRINT '************************************************************';

SET NOCOUNT OFF;
/*
SELECT
       *
       FROM EDW_CT_ExecutionLog
       WHERE CT_NAME = 'proc_EDW_BioMetrics'
       ORDER BY
                CT_Start DESC;
*/
