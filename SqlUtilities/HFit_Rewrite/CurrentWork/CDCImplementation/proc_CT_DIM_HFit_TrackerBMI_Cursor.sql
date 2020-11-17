USE [KenticoCMS_DataMart];
GO

/*------------------------------------------------------------------------------------------------------------------
***** Object:  StoredProcedure [dbo].[proc_CT_DIM_HFit_TrackerBMI_Cursor]    Script Date: 12/7/2015 2:52:22 PM *****
*/
SET ANSI_NULLS ON;
GO

DROP PROCEDURE
   dbo.proc_CT_DIM_HFit_TrackerBMI_Cursor;

SET QUOTED_IDENTIFIER ON;
GO

--  select top 100 * from BASE_HFit_TrackerBMI
--  update BASE_HFit_TrackerBMI set HASHCODE = '-' where ItemID in (select top 20000 ItemID from BASE_HFit_TrackerBMI)
--  exec proc_CT_DIM_HFit_TrackerBMI_Cursor
CREATE PROCEDURE dbo.proc_CT_DIM_HFit_TrackerBMI_Cursor (
       @ReloadAll AS INT = 0) 
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
    --*********************************************************************
    -- ** This code is generated using proc_GenTrackerCTProc.
    -- ** Author:    W.Dale Miller
    -- ** Contact:   wdalemiller@gmail.com
    -- ** Use:	  Set @ReloadAll = 1 to delete and reload ALL records
    -- **            for the this Tracker.
    -- ** GenDate:   Dec  7 2015  7:37PM
    --*********************************************************************

    SET NOCOUNT ON;

    --    SET TRANSACTION ISOLATION LEVEL SNAPSHOT; 

    DECLARE
           @EventDate AS DATETIME2 = NULL;
    DECLARE
           @IsProfessionallyCollected AS BIT = NULL;
    DECLARE
           @TrackerCollectionSourceID AS INT = NULL;
    DECLARE
           @Notes AS NVARCHAR (100) = NULL;
    DECLARE
           @UserID AS INT = NULL;
    DECLARE
           @BMI AS FLOAT = NULL;
    DECLARE
           @ItemCreatedBy AS INT = NULL;
    DECLARE
           @ItemCreatedWhen AS DATETIME2 = NULL;
    DECLARE
           @ItemModifiedBy AS INT = NULL;
    DECLARE
           @ItemModifiedWhen AS DATETIME2 = NULL;
    DECLARE
           @ItemOrder AS INT = NULL;
    DECLARE
           @VendorID AS INT = NULL;
    DECLARE
           @ItemGuid AS UNIQUEIDENTIFIER = NULL;
    DECLARE
           @ItemID AS INT = NULL;
    DECLARE
           @Action AS CHAR = NULL;
    DECLARE
           @SYS_CHANGE_VERSION AS BIGINT = NULL;
    DECLARE
           @LASTMODIFIEDDATE AS DATETIME = NULL;
    DECLARE
           @HashCode AS NVARCHAR (100) = NULL;
    DECLARE
           @SVR AS NVARCHAR (100) = NULL;
    DECLARE
           @DBNAME AS NVARCHAR (100) = NULL;

    DECLARE
           @TAction AS NVARCHAR (10) = NULL;
    DECLARE
           @NbrRecs AS BIGINT = 0;
    DECLARE
           @RowGuid AS NVARCHAR (100) = CAST (NEWID () AS NVARCHAR (50)) ;
    SET @Action = 'N';
    EXEC dbo.proc_PERFMON_PullTime_HIST @RowGuid , @Action , 'KenticoCMS_DataMart' , 'BASE_HFit_TrackerBMI' , @NbrRecs , 'proc_CT_DIM_HFit_TrackerBMI_Cursor';
    SET @Action = 'IS';
    EXEC dbo.proc_PERFMON_PullTime_HIST @RowGuid , @Action , 'KenticoCMS_DataMart' , 'BASE_HFit_TrackerBMI' , @NbrRecs , 'proc_CT_DIM_HFit_TrackerBMI_Cursor';
    DECLARE
           @synchronization_version AS BIGINT = NULL;
    SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;

    DECLARE
           @LastVersion AS BIGINT = 0;
    SET @LastVersion = (SELECT
                           MAX (BASE_HFit_TrackerBMI_CTVerHIST.SYS_CHANGE_VERSION) 
                               FROM BASE_HFit_TrackerBMI_CTVerHIST) ;
    -- PULL AND INSERT ALL RECORDS FROM: BASE_HFit_TrackerBMI
    IF @ReloadAll = 1
        BEGIN
            DELETE FROM FACT_TrackerData
                   WHERE
                   TrackerName = 'BASE_HFit_TrackerBMI';
            INSERT INTO FACT_TrackerData (
               TrackerName
             , EventDate
             , IsProfessionallyCollected
             , TrackerCollectionSourceID
             , Notes
             , UserID
             , BMI
             , ItemCreatedBy
             , ItemCreatedWhen
             , ItemModifiedBy
             , ItemModifiedWhen
             , ItemOrder
             , VendorID
             , ItemGuid
             , ItemID
             , ACTION
             , SYS_CHANGE_VERSION
             , LASTMODIFIEDDATE
             , HashCode
             , SVR
             , DBNAME
            ) 
            SELECT
               'BASE_HFit_TrackerBMI'
             , EventDate
             , IsProfessionallyCollected
             , TrackerCollectionSourceID
             , Notes
             , UserID
             , BMI
             , ItemCreatedBy
             , ItemCreatedWhen
             , ItemModifiedBy
             , ItemModifiedWhen
             , ItemOrder
             , VendorID
             , ItemGuid
             , ItemID
             , ACTION
             , SYS_CHANGE_VERSION
             , LASTMODIFIEDDATE
             , HashCode
             , SVR
             , DBNAME
                   FROM BASE_HFit_TrackerBMI;
            SET @NbrRecs = @@ROWCOUNT;
            PRINT 'RELOADED: ' + CAST (@NbrRecs AS NVARCHAR (50)) + ' records.';
            SET @Action = 'IE';
            EXEC proc_PERFMON_PullTime_HIST @RowGuid , @Action , 'KenticoCMS_DataMart' , 'BASE_HFit_TrackerBMI' , @NbrRecs , 'proc_CT_DIM_HFit_TrackerBMI_Cursor';
            SET @Action = 'T';
            EXEC proc_PERFMON_PullTime_HIST @RowGuid , @Action , 'KenticoCMS_DataMart' , 'BASE_HFit_TrackerBMI' , @NbrRecs , 'proc_CT_DIM_HFit_TrackerBMI_Cursor';
            RETURN 1;
        END;

    --***************************************************************
    -- PULL ALL NEW RECORDS FROM: BASE_HFit_TrackerBMI
    WITH CTE (
       SVR
     , DBNAME
     , ItemID) 
        AS (
        SELECT
           SVR
         , DBNAME
         , ItemID
               FROM BASE_HFit_TrackerBMI
        EXCEPT
        SELECT
           SVR
         , DBNAME
         , ItemID
               FROM FACT_TrackerData
               WHERE
               TrackerName = 'BASE_HFit_TrackerBMI'
        ) 
        INSERT INTO FACT_TrackerData
        (
           TrackerName
         , EventDate
         , IsProfessionallyCollected
         , TrackerCollectionSourceID
         , Notes
         , UserID
         , BMI
         , ItemCreatedBy
         , ItemCreatedWhen
         , ItemModifiedBy
         , ItemModifiedWhen
         , ItemOrder
         , VendorID
         , ItemGuid
         , ItemID
         , ACTION
         , SYS_CHANGE_VERSION
         , LASTMODIFIEDDATE
         , HashCode
         , SVR
         , DBNAME
        ) 
        SELECT
           'BASE_HFit_TrackerBMI'
         , BT.EventDate
         , BT.IsProfessionallyCollected
         , BT.TrackerCollectionSourceID
         , BT.Notes
         , BT.UserID
         , BT.BMI
         , BT.ItemCreatedBy
         , BT.ItemCreatedWhen
         , BT.ItemModifiedBy
         , BT.ItemModifiedWhen
         , BT.ItemOrder
         , BT.VendorID
         , BT.ItemGuid
         , BT.ItemID
         , BT.ACTION
         , BT.SYS_CHANGE_VERSION
         , BT.LASTMODIFIEDDATE
         , BT.HashCode
         , BT.SVR
         , BT.DBNAME
               FROM BASE_HFit_TrackerBMI AS BT
                    JOIN CTE ON
                                CTE.SVR = BT.SVR AND
               CTE.DBNAME = BT.DBNAME AND
               CTE.ItemID = BT.ItemID;
    SET @NbrRecs = @NbrRecs + @@ROWCOUNT;
    PRINT 'INSERTED: ' + CAST (@NbrRecs AS NVARCHAR (50)) + ' records.';

    --***************************************************************
    -- APPLY ALL DELETES IF ANY
    DELETE FT
           FROM CHANGETABLE (CHANGES BASE_HFit_TrackerBMI , @LastVersion) AS C
                INNER JOIN FACT_TrackerData AS FT
           ON
           C.DBNAME = FT.DBNAME AND
           C.DBNAME = FT.DBNAME AND
           C.ItemID = FT.ItemID AND
           C.SYS_CHANGE_OPERATION = 'D';
    SET @NbrRecs = @NbrRecs + @@ROWCOUNT;
    PRINT 'DELETED: ' + CAST (@@ROWCOUNT AS NVARCHAR (50)) + ' records.';

    --***************************************************************
    --update BASE_HFit_TrackerBMI set hashcode = '-' where ITemID in  (select top 100 itemid from BASE_HFit_TrackerBMI)
    DECLARE
           @MCnt AS FLOAT = 0;
    DECLARE
           @iChg AS BIGINT = (SELECT
                                 COUNT (*) 
                                     FROM
                              CHANGETABLE (CHANGES BASE_HFit_TrackerBMI , @LastVersion) AS C
                                     WHERE
                                     C.SYS_CHANGE_OPERATION = 'U') ;
    IF @iChg > 0
        BEGIN
            DECLARE C CURSOR
                FOR
                    SELECT
                       BT.EventDate
                     , BT.IsProfessionallyCollected
                     , BT.TrackerCollectionSourceID
                     , BT.Notes
                     , BT.UserID
                     , BT.BMI
                     , BT.ItemCreatedBy
                     , BT.ItemCreatedWhen
                     , BT.ItemModifiedBy
                     , BT.ItemModifiedWhen
                     , BT.ItemOrder
                     , BT.VendorID
                     , BT.ItemGuid
                     , BT.ItemID
                     , BT.[Action]
                     , BT.SYS_CHANGE_VERSION
                     , BT.LASTMODIFIEDDATE
                     , BT.HashCode
                     , BT.SVR
                     , BT.DBNAME
                     , C.SYS_CHANGE_VERSION
                           FROM
                    BASE_HFit_TrackerBMI AS BT
                    INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerBMI , @LastVersion) AS C
                    ON
                           C.DBNAME = BT.DBNAME AND
                           C.DBNAME = BT.DBNAME AND
                           C.ItemID = BT.ItemID AND
                           C.SYS_CHANGE_OPERATION = 'U';
            OPEN C;
            FETCH NEXT FROM C
            INTO    @EventDate ,
            @IsProfessionallyCollected ,
            @TrackerCollectionSourceID ,
            @Notes ,
            @UserID ,
            @BMI ,
            @ItemCreatedBy ,
            @ItemCreatedWhen ,
            @ItemModifiedBy ,
            @ItemModifiedWhen ,
            @ItemOrder ,
            @VendorID ,
            @ItemGuid ,
            @ItemID ,
            @Action ,
            @SYS_CHANGE_VERSION ,
            @LASTMODIFIEDDATE ,
            @HashCode ,
            @SVR ,
            @DBNAME ,
            @SYS_CHANGE_VERSION;

            DECLARE
                   @msg AS NVARCHAR (2000) = '';
            DECLARE
                   @II AS INT = 0;
            SET @msg = '1 of ' + cast (@iChg AS NVARCHAR (50)) ;
            EXEC PrintImmediate @msg;
            WHILE
                   @@FETCH_STATUS = 0
                BEGIN
                    SET @II = @II + 1;
                    SET @MCnt = @II % 1000;
                    --set @msg = cast(@Mcnt as nvarchar(50)) + ' / ' + cast(@II as nvarchar(50)) ;
                    --exec printimmediate @msg ;
                    IF @MCnt = 0
                        BEGIN
                            SET @msg = CAST (@II AS NVARCHAR (50)) + ' of ' + cast (@iChg AS NVARCHAR (50)) ;
                            EXEC PrintImmediate @msg;
                        END;
                    UPDATE Fact_TrackerData
                           SET
                       EventDate = @EventDate
                     ,IsProfessionallyCollected = @IsProfessionallyCollected
                     ,TrackerCollectionSourceID = @TrackerCollectionSourceID
                     ,Notes = @Notes
                     ,UserID = @UserID
                     ,BMI = @BMI
                     ,ItemCreatedBy = @ItemCreatedBy
                     ,ItemCreatedWhen = @ItemCreatedWhen
                     ,ItemModifiedBy = @ItemModifiedBy
                     ,ItemModifiedWhen = @ItemModifiedWhen
                     ,ItemOrder = @ItemOrder
                     ,VendorID = @VendorID
                     ,ItemGuid = @ItemGuid
                     , --@ItemID,
                       [Action] = 'U'
                     ,SYS_CHANGE_VERSION = @SYS_CHANGE_VERSION
                     ,LASTMODIFIEDDATE = GETDATE () 
                     ,HashCode = @HashCode
                           WHERE
                           TrackerName = 'BASE_HFit_TrackerBMI' AND
                           SVR = @SVR AND
                           DBNAME = @DBNAME AND
                           ItemID = @Itemid;

                    FETCH NEXT FROM C
                    INTO    @EventDate ,
                    @IsProfessionallyCollected ,
                    @TrackerCollectionSourceID ,
                    @Notes ,
                    @UserID ,
                    @BMI ,
                    @ItemCreatedBy ,
                    @ItemCreatedWhen ,
                    @ItemModifiedBy ,
                    @ItemModifiedWhen ,
                    @ItemOrder ,
                    @VendorID ,
                    @ItemGuid ,
                    @ItemID ,
                    @Action ,
                    @SYS_CHANGE_VERSION ,
                    @LASTMODIFIEDDATE ,
                    @HashCode ,
                    @SVR ,
                    @DBNAME ,
                    @SYS_CHANGE_VERSION;
                END;
            CLOSE C;
            DEALLOCATE C;
        END;

    SET @NbrRecs = @NbrRecs + @II;
    PRINT 'UPDATED: ' + CAST (@II AS NVARCHAR (50)) + ' records.';

    --***************************************************************
    DECLARE
           @iCnt AS BIGINT = (SELECT
                                 COUNT (*) 
                                     FROM BASE_HFit_TrackerBMI_CTVerHIST
                                     WHERE
                                     SYS_CHANGE_VERSION = @synchronization_version) ;
    IF @iCnt = 0
        BEGIN
            INSERT INTO BASE_HFit_TrackerBMI_CTVerHIST (
               SYS_CHANGE_VERSION
             , DBMS) 
            VALUES (
                   @synchronization_version , DB_NAME ()) ;
            PRINT 'Saved version id';
        END;
    SET @NbrRecs = @NbrRecs + @@ROWCOUNT;
    PRINT 'RELOADED: ' + CAST (@NbrRecs AS NVARCHAR (50)) + ' records.';
    SET @Action = 'IE';
    EXEC proc_PERFMON_PullTime_HIST @RowGuid , @Action , 'KenticoCMS_DataMart' , 'BASE_HFit_TrackerBMI' , @NbrRecs , 'proc_CT_DIM_HFit_TrackerBMI_Cursor';
    SET @Action = 'T';
    EXEC proc_PERFMON_PullTime_HIST @RowGuid , @Action , 'KenticoCMS_DataMart' , 'BASE_HFit_TrackerBMI' , @NbrRecs , 'proc_CT_DIM_HFit_TrackerBMI_Cursor';
    SET NOCOUNT OFF;
END;

GO


