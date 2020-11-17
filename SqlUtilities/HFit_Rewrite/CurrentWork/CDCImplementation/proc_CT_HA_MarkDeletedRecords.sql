
/*------------------------------------------------------------
DELETE FROM FACT_MART_EDW_HealthAssesment
WHERE
      PkHashCode IN (SELECT TOP 1000
                            PkHashCode
                          FROM FACT_MART_EDW_HealthAssesment) ;

SELECT
       COUNT (*) 
       FROM FACT_MART_EDW_HealthAssesment;
*/
GO

PRINT 'Execute proc_CT_HA_MarkDeletedRecords.sql';

GO

--0.23.2015 03:36:42
--0.24.2015 00:08:42 @ 1,000,000 no CT
--0.24.2015 00:05:16 @ 1,000,000 no CT / no DUPS
--0.24.2015 00:04:56 @ 1,000,000 no CT / no DUPS / TEMP TABLE
-- select count(*) from [@EdwHAHashkeys]
-- exec [proc_CT_HA_MarkDeletedRecords]

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_CT_HA_MarkDeletedRecords') 
    BEGIN
        DROP PROCEDURE
             proc_CT_HA_MarkDeletedRecords;
    END;

GO
-- exec [proc_CT_HA_MarkDeletedRecords]
CREATE PROCEDURE proc_CT_HA_MarkDeletedRecords
AS
BEGIN

    --************************************************
    --MAKE SURE THE STAGED HASH KEY Table exists
    EXEC proc_Create_FACT_EDW_PkHashkey_TBL ;
    --************************************************

    DECLARE @st AS datetime = GETDATE () ;
    DECLARE @ET AS datetime = GETDATE () ;
    DECLARE @CT AS datetime = GETDATE () ;

    DECLARE @LatestDbVersionToPull AS bigint = 0;
    SET @LatestDbVersionToPull = CHANGE_TRACKING_CURRENT_VERSION () - 1;

    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: START determine if DELETED records present', @CT, NULL;
    --**************************************************************

declare @iChgTypes as int = 0 ; 
declare @NbrOfDetectedChanges as bigint = 0 ; 
    EXEC @iChgTypes = proc_CkHaDataChanged NULL, @NbrOfDetectedChanges OUTPUT;
    PRINT 'iChgType is: ' + CAST (@iChgTypes AS nvarchar (50)) ;
    PRINT 'Total Number Of Changes to process is: ' + CAST (@NbrOfDetectedChanges AS nvarchar (50)) ;
    --**************************************************************
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: END determine if DELETED records present', @CT, @ET;
/*-------------------------------
if @iChgTypes = 
    0 - no changes
    1 - updates only
    2 - deletes only
    3 - deletes and updates
    4 - inserts only
    5 - inserts and updates
    6 - inserts and deletes
    7 - inserts, updates, and deletes
*/
    IF @iChgTypes = 0
    OR @iChgTypes = 1
    OR @iChgTypes = 4
    OR @iChgTypes = 5
        BEGIN
            PRINT 'NO DELETES found.';
		  RETURN 0;
        END;

    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: START Process proc_EDW_Gen_Temp_PkHashKeys', @CT, NULL;
    --****************************************
    exec proc_EDW_Gen_Temp_PkHashKeys ;
    --****************************************
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: START Process proc_EDW_Gen_Temp_PkHashKeys', @CT, @ET;

    --***************************************************************************************************************
    SET @CT = GETDATE () ;    
    EXEC proc_trace 'MARK Deleted Recs: START Process MarkDeletedRecords - CREATE TABLE VAR', @CT, NULL;
    
    
    EXEC proc_trace 'MARK Deleted Recs: START Process MarkDeletedRecords - Remove DUPS', @CT, NULL;
    --select * from @HASHKEYS
    DECLARE @ms AS float = DATEDIFF (ms, @st, GETDATE ()) ;
    DECLARE @secs AS float = @ms / 1000;
    DECLARE @mins AS float = @ms / 1000 / 60;
    PRINT '1 - @Secs = ' + CAST (@secs AS nvarchar (50)) ;
    PRINT '1 - @mins = ' + CAST (@mins AS nvarchar (50)) ;

    DECLARE @RemoveDups AS bit = 1;

    IF @RemoveDups = 1
        BEGIN
            WITH CTE (
                 PKHASHCODE
               , HAUSERSTARTED_ITEMID
               , HASHCODE
               , DuplicateCount) 
                AS (
                SELECT
                       PKHASHCODE
                     , HAUSERSTARTED_ITEMID
                     , HASHCODE
                     , ROW_NUMBER () OVER ( PARTITION BY PKHASHCODE
                                                       , HAUSERSTARTED_ITEMID
                                                       , HASHCODE  ORDER BY PKHASHCODE , HAUSERSTARTED_ITEMID , HASHCODE) AS DuplicateCount
                       FROM ##FACT_EDW_PkHashkey
                ) 
                DELETE
                FROM CTE
                WHERE
                      DuplicateCount > 1;
        END;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: END Process MarkDeletedRecords - Remove DUPS', @CT, @ET;
    --***************************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: START Process MarkDeletedRecords - Remove NULL RECS', @CT, NULL;

    DELETE FROM FACT_MART_EDW_HealthAssesment
    WHERE
          PKHashCode IS NULL;

    DELETE FROM ##FACT_EDW_PkHashkey
    WHERE
          PKHashCode IS NULL;

    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: END Process MarkDeletedRecords - Remove NULL RECS', @CT, @ET;
    --***************************************************************************************************************
    SET @CT = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: START Process MarkDeletedRecords - FIND AND MARK Deleted Recs', @CT, NULL;

    --delete from FACT_EDW_PkHashkey where RowNbr in (select top 100 RowNbr from FACT_EDW_PkHashkey)
    DECLARE
    @DELDATE AS  datetime2 ( 7) = GETDATE () ;
    -- select top 100 * from FACT_EDW_PkHashkey
    --  drop table LKUP_DeletedEdwHAHashkeys
if exists (select name from sys.tables where name = 'LKUP_DeletedEdwHAHashkeys')
    drop table LKUP_DeletedEdwHAHashkeys;

    create table LKUP_DeletedEdwHAHashkeys 
            (
                                    HAUSERSTARTED_ITEMID int  NOT NULL
                                  , USERGUID uniqueidentifier  NOT NULL
                                  , PKHASHCODE nvarchar (100) NOT NULL
                                  --, RowNbr int IDENTITY (1 , 1) 
                                  --             NOT NULL
                                  --  PRIMARY KEY ( PKHASHCODE ASC, HAUSERSTARTED_ITEMID ASC, USERGUID ASC, RowNbr ASC) 
            );

    CREATE CLUSTERED INDEX CI_TEMPEdwHAHashkeys ON dbo.LKUP_DeletedEdwHAHashkeys
	   (
		    HAUSERSTARTED_ITEMID ASC,
		    USERGUID ASC,
		    PKHASHCODE ASC
	   );
    
    -- delete from ##FACT_EDW_PkHashkey where PKHashCode in (select top 1000 PKHashCode from FACT_EDW_PkHashkey)
    -- exec proc_CT_HA_MarkDeletedRecords

    --*********************************************************************
    --If a record exists in the Staging Table and not in the temp table
    --Then it has been deleted. Take all the HASH KEYS in the Staging
    --table and remove those HASH KEYS that exists in the TEMP table,
    --and the ones remaining have been deleted from the STAGING table.
    --*********************************************************************
    WITH CTE_DEL (
         HAUserStarted_ItemID
       , UserGUID
       , PKHashCode
    ) 
        AS (
        SELECT
               HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
               FROM FACT_EDW_PkHashkey
			WHERE ISNULL (DeletedFlg, 0) = 0
        EXCEPT
        SELECT
               HAUserStarted_ItemID
             , UserGUID
             , PKHashCode
               FROM ##FACT_EDW_PkHashkey               
        ) 
        INSERT INTO LKUP_DeletedEdwHAHashkeys
        (
               HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE) 
        SELECT
               HAUSERSTARTED_ITEMID
             , USERGUID
             , PKHASHCODE
               FROM CTE_DEL;


    -- select  count(*) from LKUP_DeletedEdwHAHashkeys ;

    UPDATE S
           SET
               S.DeletedFlg = 1
             ,S.ChangeDate = GETDATE () 
             ,S.ChangeType = 'D'
               FROM FACT_EDW_PkHashkey AS S
                        JOIN
                        LKUP_DeletedEdwHAHashkeys AS C
                            ON
                            C.PKHashCode = S.PKHashCode
                        AND C.HAUSERSTARTED_ITEMID = S.HAUSERSTARTED_ITEMID
                        AND C.UserGUID = S.UserGUID;    

    UPDATE S
           SET
               DeletedFlg = 1
             ,LastModifiedDate = GETDATE () 
             --,ChangeType = 'D'
               FROM FACT_MART_EDW_HealthAssesment AS S
                        JOIN
                        LKUP_DeletedEdwHAHashkeys AS C
                            ON
                            C.PKHashCode = S.PKHashCode
                        AND C.HAUSERSTARTED_ITEMID = S.UserStartedItemID
                        AND C.UserGUID = S.UserGUID;
    
    DECLARE
    @iDels AS int = @@ROWCOUNT;

        UPDATE dbo.CT_VersionTracking
           SET
               CNT_Delete = @iDels
    WHERE
          SVRName = @@SERVERNAME
      AND DBName = DB_NAME () 
      AND TgtView = 'view_EDW_HealthAssesment'
      AND rownbr = (select max(RowNbr) from CT_VersionTracking where TgtView = 'view_EDW_HealthAssesment')

    PRINT 'NUMBER OF ROWS flagged as deleted: ' + CAST (@iDels AS nvarchar (50)) ;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: END Process MarkDeletedRecords - FIND AND MARK Deleted Recs', @CT, @ET;
    SET @ET = GETDATE () ;
    EXEC proc_trace 'MARK Deleted Recs: END Process', @CT, @ET;
    RETURN @iDels;

END;

GO
PRINT 'Executed MarkDeletedRecords.sql';
--select top 1000 * from [@EdwHAHashkeys] order by RowNbr
GO
