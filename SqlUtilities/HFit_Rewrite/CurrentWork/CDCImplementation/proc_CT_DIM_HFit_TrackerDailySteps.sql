USE [KenticoCMS_DataMart];
GO
/****** Object:  StoredProcedure [dbo].[proc_CT_DIM_HFit_TrackerDailySteps]    Script Date: 12/8/2015 12:30:40 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE dbo.proc_CT_DIM_HFit_TrackerDailySteps (
      @ReloadAll AS INT = 0) 
AS
BEGIN
    --*********************************************************************
    -- ** This code is generated using proc_GenTrackerCTProc.
    -- **      If changes are needed, please modify the generator and 
    -- **      regen ALL the procs for consistency. 
    -- **      
    -- ** Author:    W.Dale Miller
    -- ** Contact:   wdalemiller@gmail.com
    -- ** Use:	  Set @ReloadAll = 1 to delete and reload ALL records
    -- **            for the this Tracker.
    -- ** GenDate:   Dec  8 2015  5:51PM
    --*********************************************************************

/* 
drop procedure proc_CT_DIM_HFit_TrackerDailySteps
exec proc_CT_DIM_HFit_TrackerDailySteps
select top 100 * from BASE_HFit_TrackerDailySteps
update BASE_HFit_TrackerDailySteps set HashCode = 'NA' where ItemID in (select top 100 ItemID from BASE_HFit_TrackerDailySteps) 
*/

    --SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
    SET NOCOUNT OFF;

    DECLARE @ItemCreatedBy INT = NULL;
    DECLARE @ItemCreatedWhen DATETIME2 = NULL;
    DECLARE @ItemModifiedBy INT = NULL;
    DECLARE @ItemModifiedWhen DATETIME2 = NULL;
    DECLARE @EventDate DATETIME2 = NULL;
    DECLARE @Steps INT = NULL;
    DECLARE @Notes NVARCHAR (1000) = NULL;
    DECLARE @TrackerCollectionSourceID INT = NULL;
    DECLARE @IsProfessionallyCollected BIT = NULL;
    DECLARE @UserID INT = NULL;
    DECLARE @ItemID INT = NULL;
    DECLARE @Action CHAR (1) = NULL;
    DECLARE @SYS_CHANGE_VERSION BIGINT = NULL;
    DECLARE @LASTMODIFIEDDATE DATETIME = NULL;
    DECLARE @HashCode NVARCHAR (75) = NULL;
    DECLARE @SVR NVARCHAR (100) = NULL;
    DECLARE @DBNAME NVARCHAR (100) = NULL;
    DECLARE @msg AS NVARCHAR (2000) = NULL;

    DECLARE @MCnt AS BIGINT = NULL;
    DECLARE @PerfAction AS NVARCHAR (10) = NULL;
    DECLARE @NbrRecs AS BIGINT = 0;
    DECLARE @RowGuid AS NVARCHAR (100) = CAST (NEWID () AS NVARCHAR (50)) ;
    SET @PerfAction = 'N';
    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @PerfAction, 'KenticoCMS_DataMart', 'BASE_HFit_TrackerDailySteps', @NbrRecs, 'proc_CT_DIM_HFit_TrackerDailySteps';
    SET @PerfAction = 'IS';
    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @PerfAction, 'KenticoCMS_DataMart', 'BASE_HFit_TrackerDailySteps', @NbrRecs, 'proc_CT_DIM_HFit_TrackerDailySteps';
    DECLARE @synchronization_version AS BIGINT = NULL;
    SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;
    DECLARE @LastVersion AS BIGINT = 0;
    SET @LastVersion = (SELECT
                               MAX (SYS_CHANGE_VERSION) 
                               FROM BASE_HFit_TrackerDailySteps_CTVerHIST);
    -- PULL AND INSERT ALL RECORDS FROM: BASE_HFit_TrackerDailySteps
    IF @ReloadAll = 1
        BEGIN
            DELETE FROM FACT_TrackerData
            WHERE
                  TrackerName = 'BASE_HFit_TrackerDailySteps';
            INSERT INTO FACT_TrackerData (
                   TrackerName
                 , ItemCreatedBy
                 , ItemCreatedWhen
                 , ItemModifiedBy
                 , ItemModifiedWhen
                 , EventDate
                 , Steps
                 , Notes
                 , TrackerCollectionSourceID
                 , IsProfessionallyCollected
                 , UserID
                 , ItemID
                 , [ACTION]
                 , SYS_CHANGE_VERSION
                 , LASTMODIFIEDDATE
                 , HashCode
                 , SVR
                 , DBNAME
            ) 
            SELECT
                   'BASE_HFit_TrackerDailySteps'
                 , ItemCreatedBy
                 , ItemCreatedWhen
                 , ItemModifiedBy
                 , ItemModifiedWhen
                 , EventDate
                 , Steps
                 , Notes
                 , TrackerCollectionSourceID
                 , IsProfessionallyCollected
                 , UserID
                 , ItemID
                 , [ACTION]
                 , SYS_CHANGE_VERSION
                 , LASTMODIFIEDDATE
                 , HashCode
                 , SVR
                 , DBNAME
                   FROM BASE_HFit_TrackerDailySteps;
            SET @NbrRecs = @@ROWCOUNT;
            SET @Msg = 'RELOADED: ' + CAST (@NbrRecs AS NVARCHAR (50)) + ' records.';
            EXEC printImmediate @msg;
            SET @PerfAction = 'IE';
            EXEC proc_PERFMON_PullTime_HIST @RowGuid, @PerfAction, 'KenticoCMS_DataMart', 'BASE_HFit_TrackerDailySteps', @NbrRecs, 'proc_CT_DIM_HFit_TrackerDailySteps';
            SET @PerfAction = 'T';
            EXEC proc_PERFMON_PullTime_HIST @RowGuid, @PerfAction, 'KenticoCMS_DataMart', 'BASE_HFit_TrackerDailySteps', @NbrRecs, 'proc_CT_DIM_HFit_TrackerDailySteps';
            SET NOCOUNT OFF;

            DECLARE @iCnt AS BIGINT = (SELECT
                                              COUNT (*) 
                                              FROM BASE_HFit_TrackerDailySteps_CTVerHIST
                                              WHERE SYS_CHANGE_VERSION = @synchronization_version);
            IF @iCnt = 0
                BEGIN
                    INSERT INTO BASE_HFit_TrackerDailySteps_CTVerHIST (
                           SYS_CHANGE_VERSION
                         , DBMS) 
                    VALUES (
                           @synchronization_version, DB_NAME ()) ;
                    EXEC printImmediate 'Saved version id';
                END;

            RETURN 1;
        END;

    --***************************************************************
    -- PULL ALL NEW RECORDS FROM: BASE_HFit_TrackerDailySteps
    exec printImmediate 'Begining NEW inserts' ;
    WITH CTE (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM BASE_HFit_TrackerDailySteps
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM FACT_TrackerData
               WHERE TrackerName = 'BASE_HFit_TrackerDailySteps'
        ) 
        INSERT INTO FACT_TrackerData
        (
               TrackerName
             , ItemCreatedBy
             , ItemCreatedWhen
             , ItemModifiedBy
             , ItemModifiedWhen
             , EventDate
             , Steps
             , Notes
             , TrackerCollectionSourceID
             , IsProfessionallyCollected
             , UserID
             , ItemID
             , ACTION
             , SYS_CHANGE_VERSION
             , LASTMODIFIEDDATE
             , HashCode
             , SVR
             , DBNAME
        ) 
        SELECT
               'BASE_HFit_TrackerDailySteps'
             , BT.ItemCreatedBy
             , BT.ItemCreatedWhen
             , BT.ItemModifiedBy
             , BT.ItemModifiedWhen
             , BT.EventDate
             , BT.Steps
             , BT.Notes
             , BT.TrackerCollectionSourceID
             , BT.IsProfessionallyCollected
             , BT.UserID
             , BT.ItemID
             , BT.ACTION
             , BT.SYS_CHANGE_VERSION
             , BT.LASTMODIFIEDDATE
             , BT.HashCode
             , BT.SVR
             , BT.DBNAME
               FROM BASE_HFit_TrackerDailySteps AS BT
                        JOIN CTE
                            ON CTE.SVR = BT.SVR
                           AND CTE.DBNAME = BT.DBNAME
                           AND CTE.ItemID = BT.ItemID
               OPTION (
                      MAXDOP 1) ;
    SET @NbrRecs = @NbrRecs + @@ROWCOUNT;
    SET @msg = 'INSERTED: ' + CAST (@NbrRecs AS NVARCHAR (50)) + ' records.';
    EXEC printImmediate @msg;

    --***************************************************************
    -- APPLY ALL DELETES IF ANY
    DELETE FT
           FROM CHANGETABLE (CHANGES BASE_HFit_TrackerDailySteps, @LastVersion) AS C
                    INNER JOIN FACT_TrackerData AS FT
                        ON C.DBNAME = FT.DBNAME
                       AND C.DBNAME = FT.DBNAME
                       AND C.ItemID = FT.ItemID
                       AND C.SYS_CHANGE_OPERATION = 'D';
    SET @NbrRecs = @NbrRecs + @@ROWCOUNT;
    SET @msg = 'DELETED: ' + CAST (@@ROWCOUNT AS NVARCHAR (50)) + ' records.';
    EXEC printImmediate @msg;

    --***************************************************************
    DECLARE @iChg AS BIGINT = (SELECT
                                      COUNT (*) 
                                      FROM
                               CHANGETABLE (CHANGES BASE_HFit_TrackerDailySteps, @LastVersion) AS C
                                      WHERE C.SYS_CHANGE_OPERATION = 'U');

    IF @iChg > 0
        BEGIN
            DECLARE CC CURSOR
                FOR SELECT

                           BT.ItemCreatedBy
                         , BT.ItemCreatedWhen
                         , BT.ItemModifiedBy
                         , BT.ItemModifiedWhen
                         , BT.EventDate
                         , BT.Steps
                         , BT.Notes
                         , BT.TrackerCollectionSourceID
                         , BT.IsProfessionallyCollected
                         , BT.UserID
                         , BT.ItemID
                         , BT.[Action]
                         , BT.SYS_CHANGE_VERSION
                         , BT.LASTMODIFIEDDATE
                         , BT.HashCode
                         , BT.SVR
                         , BT.DBNAME
                         , C.SYS_CHANGE_VERSION
                           FROM
                    BASE_HFit_TrackerDailySteps AS BT
                        INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerDailySteps , @LastVersion) AS C
                            ON
                            C.DBNAME = BT.DBNAME
                        AND C.DBNAME = BT.DBNAME
                        AND C.ItemID = BT.ItemID
                        AND C.SYS_CHANGE_OPERATION = 'U';
            OPEN CC;
            FETCH NEXT FROM CC
            INTO
            @ItemCreatedBy
            , @ItemCreatedWhen
            , @ItemModifiedBy
            , @ItemModifiedWhen
            , @EventDate
            , @Steps
            , @Notes
            , @TrackerCollectionSourceID
            , @IsProfessionallyCollected
            , @UserID
            , @ItemID
            , @Action
            , @SYS_CHANGE_VERSION
            , @LASTMODIFIEDDATE
            , @HashCode
            , @SVR
            , @DBNAME, @SYS_CHANGE_VERSION;

            DECLARE @II AS INT = 0;
            SET @msg = '1 of ' + CAST (@iChg AS NVARCHAR (50)) ;
            EXEC PrintImmediate @msg;
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    SET @II = @II + 1;
                    SET @MCnt = @II % 1000;
                    IF @MCnt = 0
                        BEGIN
                            SET @msg = CAST (@II AS NVARCHAR (50)) + ' of ' + CAST (@iChg AS NVARCHAR (50)) ;
                            EXEC PrintImmediate @msg;
                        END;
                    SET @ACTION = 'U';
                    UPDATE Fact_TrackerData
                           SET
                               ItemCreatedBy = @ItemCreatedBy
                             ,ItemCreatedWhen = @ItemCreatedWhen
                             ,ItemModifiedBy = @ItemModifiedBy
                             ,ItemModifiedWhen = @ItemModifiedWhen
                             ,EventDate = @EventDate
                             ,Steps = @Steps
                             ,Notes = @Notes
                             ,TrackerCollectionSourceID = @TrackerCollectionSourceID
                             ,IsProfessionallyCollected = @IsProfessionallyCollected
                             ,UserID = @UserID
                               ----,ItemID =    @ItemID
                             ,
                               ACTION = @Action
                             ,SYS_CHANGE_VERSION = @SYS_CHANGE_VERSION
                             ,LASTMODIFIEDDATE = GETDATE () 
                             ,HashCode = @HashCode
                             ,SVR = @SVR
                             ,DBNAME = @DBNAME
                    WHERE
                          TrackerName = 'BASE_HFit_TrackerDailySteps'
                      AND SVR = @SVR
                      AND DBNAME = @DBNAME
                      AND ItemID = @Itemid;

                    FETCH NEXT FROM CC
                    INTO
                    @ItemCreatedBy
                    , @ItemCreatedWhen
                    , @ItemModifiedBy
                    , @ItemModifiedWhen
                    , @EventDate
                    , @Steps
                    , @Notes
                    , @TrackerCollectionSourceID
                    , @IsProfessionallyCollected
                    , @UserID
                    , @ItemID
                    , @Action
                    , @SYS_CHANGE_VERSION
                    , @LASTMODIFIEDDATE
                    , @HashCode
                    , @SVR
                    , @DBNAME, @SYS_CHANGE_VERSION;

                END; --while 
            CLOSE CC;
            DEALLOCATE CC;
            SET @msg = CAST (@II AS NVARCHAR (50)) + ' UPDATES applied.';
            EXEC PrintImmediate @msg;
        END;

    --***************************************************************
    set @iCnt = (SELECT
                                      COUNT (*) 
                                      FROM BASE_HFit_TrackerDailySteps_CTVerHIST
                                      WHERE SYS_CHANGE_VERSION = @synchronization_version);
    IF @iCnt = 0
        BEGIN
            INSERT INTO BASE_HFit_TrackerDailySteps_CTVerHIST (
                   SYS_CHANGE_VERSION
                 , DBMS) 
            VALUES (
                   @synchronization_version, DB_NAME ()) ;
            EXEC printImmediate 'Saved version id';
        END;
    SET @NbrRecs = @NbrRecs + @@ROWCOUNT;
    SET @msg = 'RELOADED: ' + CAST (@NbrRecs AS NVARCHAR (50)) + ' records.';
    EXEC printImmediate @msg;
    SET @PerfAction = 'IE';
    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @PerfAction, 'KenticoCMS_DataMart', 'BASE_HFit_TrackerDailySteps', @NbrRecs, 'proc_CT_DIM_HFit_TrackerDailySteps';
    SET @PerfAction = 'T';
    EXEC proc_PERFMON_PullTime_HIST @RowGuid, @PerfAction, 'KenticoCMS_DataMart', 'BASE_HFit_TrackerDailySteps', @NbrRecs, 'proc_CT_DIM_HFit_TrackerDailySteps';
    SET NOCOUNT OFF;

END; 
