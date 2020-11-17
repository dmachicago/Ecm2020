
/**************************************************************
TEST proc_EDW_HealthInterestList
***************************************************************/
PRINT '****************************************************************';
PRINT '** TEST #1 proc_EDW_HealthInterestList Initial counts ';
PRINT '****************************************************************';
RAISERROR ('PRINT Check', 10, 1) WITH NOWAIT;


DECLARE
       @DBN AS nvarchar (100) = DB_NAME () ;
DECLARE
       @JNAME AS nvarchar (100) = 'job_EDW_GetStagingData_HA_' + @DBN;
DECLARE
       @b AS int = 0;
EXEC @b = isJobRunning @JNAME;
IF @b = 1
    BEGIN
	   PRINT ' ' ; PRINT ' ' ;
	   --PRINT '*********************************** NOTICE ***************************************';
	   PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
	   PRINT 'XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX WARNING XXXX';
        PRINT '*********************************** NOTICE ***************************************';
        PRINT @JNAME + ' Currently running, aborting test.';
        PRINT 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        RETURN;
    END;

/*********DISABLE ANY JOBS THAT MIGHT INTERFERE *********************************************/
DECLARE
       @NewJname AS nvarchar (100) = @JNAME + ' -- Disabled';
DECLARE
       @NewJdesc AS nvarchar (100) = @JNAME + ' disabled during TESTING.';

EXEC dbo.sp_update_job @job_name = @JNAME, @new_name = @NewJname, @description = @NewJdesc, @enabled = 0;
PRINT '*********************************** NOTICE ****************************************';
PRINT @JNAME + ' DISABLED FOR TEST.';
PRINT '*********************************** NOTICE ****************************************';

DECLARE
       @iCnt AS int = 0
     , @iTotalRecs AS int = 0;

SET @iTotalRecs = (SELECT
                          COUNT (*) 
                          FROM view_EDW_HealthAssesmentDeffinition);
SET @iCnt = (SELECT
                    COUNT (*) 
                    FROM view_EDW_HealthAssessmentDefinition_CT);
PRINT 'Row count from view_EDW_HealthAssessmentDefinition_CT : ' + CAST (@iTotalRecs AS nvarchar (50)) ;
PRINT 'Row count from parent view_EDW_HealthAssesmentDeffinition: ' + CAST (@iCnt AS nvarchar (50)) ;

--TEST THE Change Tracking View
DECLARE
       @iCntCT AS int = 0;
SET @iCntCT = (SELECT
                      COUNT (*) 
                      FROM view_EDW_HealthAssessmentDefinition_CT);
PRINT 'Row count from CT view: ' + CAST (@iCntCT AS nvarchar (50)) ;

DECLARE
       @iCntDIFF AS int = 0;
SET @iCntDIFF = @iCnt - @iCntCT;
if @iCntDIFF = 0 
PRINT 'PASSED: ROW DIFF Between BASE View and CT View : ' + CAST (@iCntDIFF AS nvarchar (50)) ;
else 
PRINT 'ERROR: Difference Between BASE View and CT View : ' + CAST (@iCntDIFF AS nvarchar (50)) ;

--Test the RELOAD ALL of the procedure 130
EXEC proc_EDW_HealthInterestList 1;
declare @RecsLoaded as int = (select count(*) from DIM_EDW_HealthInterestList) ;
print ('Records Loaded in initial load: ' + cast(@RecsLoaded as nvarchar(50)));
--Test the LOAD Changes Only of the procedure
EXEC proc_EDW_HealthInterestList 0;
print ('Records Loaded in initial load: ' + cast(@RecsLoaded as nvarchar(50)));

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'temp_InterestList') 
    BEGIN
        PRINT 'Dropped temp_InterestList table ';
        DROP TABLE
             temp_InterestList;
    END;

/*** BACKUP THE BASE TABLE BEFORE PROCEEDING ***/

if not exists(select name from sys.tables where name = 'temp_InterestList_FULL_Backup')
begin
SELECT
       *
INTO
     temp_InterestList_FULL_Backup
       FROM HFit_CoachingHealthArea;
end ;

/*Get 100 rows and save them for testing purposes*/

SELECT TOP 100
       *
INTO
     temp_InterestList
       FROM HFit_CoachingHealthArea
       ORDER BY
                CoachingHealthAreaID DESC;
--select * from temp_InterestList

/**************************************************************************************************************************
    Modify a portion of the 100 rows AND validate that change tracking finds them and updates the staging table.
    NOTE: The column to be modified will have to be validated for each base table to ensure it is used in the view.
**************************************************************************************************************************/

--DBCC DROPCLEANBUFFERS; 

--select * from view_EDW_HealthAssessmentDefinition_CT WHERE NodeID = 85807;
UPDATE HFit_CoachingHealthArea
       SET
           HealthAreaDescription = 'ZXZXX'
WHERE
       CoachingHealthAreaID IN (SELECT
                                       CoachingHealthAreaID
                                       FROM temp_InterestList) 
   AND DATALENGTH (HealthAreaDescription) = 0;
DECLARE
       @iChgCnt AS int = 0;
SET @iChgCnt = (SELECT
                       COUNT (*) 
                       FROM HFit_CoachingHealthArea
                       WHERE HealthAreaDescription = 'ZXZXX');
PRINT 'Count of changes to Expect: ' + CAST (@iChgCnt AS nvarchar (50)) ;

/***************************************
    Make sure Changes ARE detected
***************************************/

PRINT 'Make sure Changes ARE detected.';
EXEC proc_EDW_HealthInterestList ;

/***************************************
    Put back the original Data
***************************************/

--delete from DIM_EDW_HealthInterestList where HealthAreaDescription like 'Z%' ;
PRINT 'Reset data in base table.';
UPDATE HFit_CoachingHealthArea
       SET
           HealthAreaDescription = ''
WHERE
      HealthAreaDescription LIKE 'ZXZXX';
PRINT 'Changes to data reset: ';

/*******************************************
    DROP ROWS AND LOOK FOR DELETES 
*******************************************/

PRINT 'Record count before delete: ' + CAST (@iTotalRecs AS nvarchar (50)) ;
DELETE FROM HFit_CoachingHealthArea
WHERE
      CoachingHealthAreaID IN (SELECT
                                      CoachingHealthAreaID
                                      FROM temp_InterestList) ;
DECLARE
       @CntAfterDelete AS int = 0;
SET @CntAfterDelete = (SELECT
                              COUNT (*) 
                              FROM HFit_CoachingHealthArea);
PRINT 'Changes to data reset: ';
PRINT 'Record count After delete: ' + CAST (@CntAfterDelete AS nvarchar (50)) ;

PRINT 'Validate deletes are detected and marked.';
EXEC proc_EDW_HealthInterestList;
DECLARE
       @CntMArkedAsDeleted AS int = 0;
SET @CntMArkedAsDeleted = (SELECT
                                  COUNT (*) 
                                  FROM DIM_EDW_HealthInterestList
                                  WHERE DeletedFlg IS NOT NULL);
print ('**************************************************************');
if @CntMArkedAsDeleted > 0 
    PRINT 'PASSED DELETES: Record count marked as deleted: ' + CAST (@CntMArkedAsDeleted AS nvarchar (50)) ;
else 
    PRINT 'FAILED DELETES: Record count marked as deleted: ' + CAST (@CntMArkedAsDeleted AS nvarchar (50)) ;
print ('**************************************************************');
PRINT 'Put back the deleted records to the base table.';

/*************************************************************
USE The columns from the base table and the temp table here
*************************************************************/

SET IDENTITY_INSERT HFit_CoachingHealthArea ON;

INSERT INTO HFit_CoachingHealthArea (
       CoachingHealthAreaID
     , HealthAreaDescription
     , CodeName) 
SELECT
       CoachingHealthAreaID
     , HealthAreaDescription
     , CodeName
       FROM temp_InterestList
       WHERE CoachingHealthAreaID NOT IN (
             SELECT
                    CoachingHealthAreaID
                    FROM HFit_CoachingHealthArea);

SET IDENTITY_INSERT HFit_CoachingHealthArea OFF;

DECLARE
       @NewTotal AS int = 0;
SET @NewTotal = (SELECT
                        COUNT (*) 
                        FROM HFit_CoachingHealthArea);
PRINT 'Record count after reinsertion: ' + CAST (@NewTotal AS nvarchar (50)) ;
PRINT 'Original Record Count: ' + CAST (@iTotalRecs AS nvarchar (50)) ;

EXEC proc_EDW_HealthInterestList;

/*
Confirm that INSERTS are detected and registered.
select * from Temp_HealthInterestList
NOTE: This statement will have to be tailored for each use
*/

DECLARE
       @iCntBeforeInsert AS int = 0;
SET @iCntBeforeInsert = (SELECT
                                COUNT (*) 
                                FROM Temp_HealthInterestList);
PRINT 'Staging Record Count Before Insert: ' + CAST (@iCntBeforeInsert AS nvarchar (50)) ;

INSERT INTO dbo.Temp_HealthInterestList
(
       HealthAreaID
     , NodeID
     , NodeGuid
     , AccountCD
     , HealthAreaName
     , HealthAreaDescription
     , CodeName
     , DocumentCreatedWhen
     , DocumentModifiedWhen
     , HashCode) 
VALUES
       (
       -100
       , -100
       , NEWID () 
       , 'XX'
       , 'XXYY'
       , 'XXXXYYYYZZZZ'
       , 'NA'
       , GETDATE () 
       , GETDATE () 
       , HASHBYTES ('sha1', 'XXXXYYYYZZZZ')) ;

INSERT INTO dbo.Temp_HealthInterestList
(
       HealthAreaID
     , NodeID
     , NodeGuid
     , AccountCD
     , HealthAreaName
     , HealthAreaDescription
     , CodeName
     , DocumentCreatedWhen
     , DocumentModifiedWhen
     , HashCode) 
VALUES
       (
       -200
       , -200
       , NEWID () 
       , 'XX'
       , 'XXYY'
       , 'XXXXAAAABBBB'
       , 'NA'
       , GETDATE () 
       , GETDATE () 
       , HASHBYTES ('sha1', 'XXXXAAAABBBB')) ;

DECLARE
       @iCntAfterInsert AS int = 0;
SET @iCntAfterInsert = (SELECT
                                COUNT (*) 
                                FROM Temp_HealthInterestList);
PRINT 'Staging Record Count After Insert: ' + CAST (@iCntAfterInsert AS nvarchar (50)) ;

/**************************************************************************
THIS IS A SEMI-MANUAL TEST STEP: Test Finding and inserting new records
1 - OPEN proc_EDW_HealthInterestList
2 - FIND "--INSERT TEST START"
3 - HIGHLIGHT THRU "--INSERT TEST END"
4 - EXECUTE THE HIGHLIGHTED CODE
5 - CANNOT execute proc_EDW_HealthInterestList as it
    drops and recreates all the records. Must be internal here.
**************************************************************************/
--INSERT TEST START
WITH CTE_NEW (
     HealthAreaID
   ,NodeID
   ,NodeGuid
   ,AccountCD) 
    AS ( SELECT
                HealthAreaID
              ,NodeID
              ,NodeGuid
              ,AccountCD
                FROM Temp_HealthInterestList
         EXCEPT
         SELECT
                HealthAreaID
              ,NodeID
              ,NodeGuid
              ,AccountCD
                FROM DIM_EDW_HealthInterestList
                WHERE LastModifiedDate IS NULL) 
    INSERT INTO DIM_EDW_HealthInterestList
    SELECT
           T.HealthAreaID
         ,T.NodeID
         ,T.NodeGuid
         ,T.AccountCD
         ,T.HealthAreaName
         ,T.HealthAreaDescription
         ,T.CodeName
         ,T.DocumentCreatedWhen
         ,T.DocumentModifiedWhen
         ,HashCode
         ,NULL AS DeletedFlg
         ,NULL AS LastModifiedDate
           FROM
                Temp_HealthInterestList AS T
                    JOIN CTE_NEW AS C
                    ON
           T.HealthAreaID = C.HealthAreaID
       AND T.NodeID = C.NodeID
       AND T.NodeGuid = C.NodeGuid
       AND T.AccountCD = C.AccountCD;
declare @InsertedRecCnt as int = @@ROWCOUNT ;
/************************************************************************/

DECLARE
       @iCntAfterInsert2 AS int = 0;
SET @iCntAfterInsert2 = (SELECT
                               COUNT (*) 
                               FROM DIM_EDW_HealthInterestList);
PRINT '*******************************************************************';
PRINT 'New Records found: ' + CAST ( @InsertedRecCnt AS nvarchar (50)) ;
IF @InsertedRecCnt = 0
    BEGIN
        PRINT 'ERROR: New inserts not found';
    END
ELSE
    BEGIN
	   PRINT 'INSERT TEST PASSED: ' + CAST (@InsertedRecCnt AS nvarchar (50)) + ' records inserted.';
    END;
PRINT '*******************************************************************';

/*
Remove the newly added test records 
NOTE: This statement will have to be tailored for each use
*/

DELETE FROM Temp_HealthInterestList
WHERE
      HealthAreaDescription LIKE 'XXXX%';
PRINT '#Test Records removed: ' + CAST (@@ROWCOUNT AS nvarchar (50)) ;

/************************************************************
Now, let's make totally certain deleted records are found.
************************************************************/

DECLARE
       @iCntBeforeDEL AS int = 0;
SET @iCntBeforeDEL = (SELECT
                             COUNT (*) 
                             FROM DIM_EDW_HealthInterestList);
PRINT 'Staging Record Count Before Delete: ' + CAST (@iCntBeforeInsert AS nvarchar (50)) ;

EXEC proc_EDW_HealthInterestList ;

SET @iCntAfterInsert2 = (SELECT
                               COUNT (*) 
                               FROM DIM_EDW_HealthInterestList);
PRINT '*******************************************************************';
PRINT 'Staging Record Count After Insert: ' + CAST (@iCntAfterInsert2 AS nvarchar (50)) ;
PRINT 'New Records found: ' + CAST ( @iCntAfterInsert2 - @iCntBeforeInsert AS nvarchar (50)) ;
DECLARE
       @diffdel AS int = @iCntAfterInsert2 - @iCntBeforeInsert;
IF @iCntAfterInsert2 - @iCntBeforeInsert = 0
    BEGIN
        PRINT 'ERROR: New inserts not found';
    END
ELSE
    BEGIN
        PRINT 'DELETE TEST PASSED: New inserts found - ' + CAST (@diffdel AS nvarchar (50)) ;
    END;
PRINT '*******************************************************************';
PRINT 'TEST COMPLETE.';


/*********ENABLE ANY JOBS THAT WERE DISABLED    *********************************************/

SET @NewJname = @JNAME + ' -- Disabled';
SET @NewJdesc = @JNAME + ' disabled during TESTING.';
EXEC dbo.sp_update_job
@job_name = @JNAME,
@new_name = @NewJname,
@description = @NewJdesc,
@enabled = 0;
PRINT '*********************************** NOTICE ****************************************';
PRINT @JNAME + ' RE-ENABLED.';
PRINT '*********************************** NOTICE ****************************************';
/********************************************************************************************/


SELECT
       *
       FROM EDW_CT_ExecutionLog
       WHERE CT_NAME = 'proc_EDW_HealthInterestList'
       ORDER BY
                CT_Start DESC;
