USE [KenticoCMS_DataMart];
GO
/****** Object:  StoredProcedure [dbo].[proc_CT_DIM_HFit_TrackerStress]    Script Date: 12/3/2015 7:46:22 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- exec proc_CT_DIM_HFit_TrackerStress 1
ALTER PROCEDURE dbo.proc_CT_DIM_HFit_TrackerStress (
      @ReloadAll AS INT = 0) 
AS
BEGIN
    --*********************************************************************
    -- ** This code is generated using proc_GenTrackerCTProc.
    -- ** Author:    W.Dale Miller
    -- ** Contact:   wdalemiller@gmail.com
    -- ** Use:	  Set @ReloadAll = 1 to delete and reload ALL records
    -- **            for the this Tracker.
    -- ** GenDate:   Dec  3 2015  8:44PM
    --*********************************************************************

    DECLARE @synchronization_version AS BIGINT = NULL;
    SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION () ;
    DECLARE @LastVersion AS BIGINT = 0;
    SET @LastVersion = (SELECT
                               MAX (SYS_CHANGE_VERSION) 
                               FROM BASE_HFit_TrackerStress_CTVerHIST);
    -- PULL AND INSERT ALL RECORDS FROM: BASE_HFit_TrackerStress


    IF @ReloadAll = 1
        BEGIN
    delete_more1:
            DELETE FROM FACT_TrackerData
            WHERE
                  TrackerName = 'BASE_HFit_TrackerStress';
print 'Deletes: ' + cast(@@ROWCOUNT  as nvarchar(50)) ;


            INSERT INTO FACT_TrackerData (
                   TrackerName
                 , EventDate
                 , Awareness
                 , TrackerCollectionSourceID
                 , IsProfessionallyCollected
                 , Intensity
                 , Notes
                 , UserID
                 , ItemCreatedBy
                 , ItemCreatedWhen
                 , ItemModifiedBy
                 , ItemModifiedWhen
                 , ItemID
                 , ACTION
                 , SYS_CHANGE_VERSION
                 , LASTMODIFIEDDATE
                 , HashCode
                 , SVR
                 , DBNAME
            ) 
            SELECT
                   'BASE_HFit_TrackerStress'
                 , EventDate
                 , Awareness
                 , TrackerCollectionSourceID
                 , IsProfessionallyCollected
                 , Intensity
                 , Notes
                 , UserID
                 , ItemCreatedBy
                 , ItemCreatedWhen
                 , ItemModifiedBy
                 , ItemModifiedWhen
                 , ItemID
                 , ACTION
                 , SYS_CHANGE_VERSION
                 , LASTMODIFIEDDATE
                 , HashCode
                 , SVR
                 , DBNAME
                   FROM BASE_HFit_TrackerStress;

print 'INSERTED: ' + cast(@@ROWCOUNT as nvarchar(50)) ;
            RETURN 1;
        END;

    --***************************************************************
    -- PULL ALL NEW RECORDS FROM: BASE_HFit_TrackerStress
    WITH CTE (
         SVR
       , DBNAME
       , ItemID) 
        AS (
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM BASE_HFit_TrackerStress
        EXCEPT
        SELECT
               SVR
             , DBNAME
             , ItemID
               FROM FACT_TrackerData
               WHERE TrackerName = 'BASE_HFit_TrackerStress'
        ) 
        INSERT INTO FACT_TrackerData
        (
               TrackerName
             , EventDate
             , Awareness
             , TrackerCollectionSourceID
             , IsProfessionallyCollected
             , Intensity
             , Notes
             , UserID
             , ItemCreatedBy
             , ItemCreatedWhen
             , ItemModifiedBy
             , ItemModifiedWhen
             , ItemID
             , ACTION
             , SYS_CHANGE_VERSION
             , LASTMODIFIEDDATE
             , HashCode
             , SVR
             , DBNAME
        ) 
        SELECT
               'BASE_HFit_TrackerStress'
             , BT.EventDate
             , BT.Awareness
             , BT.TrackerCollectionSourceID
             , BT.IsProfessionallyCollected
             , BT.Intensity
             , BT.Notes
             , BT.UserID
             , BT.ItemCreatedBy
             , BT.ItemCreatedWhen
             , BT.ItemModifiedBy
             , BT.ItemModifiedWhen
             , BT.ItemID
             , BT.ACTION
             , BT.SYS_CHANGE_VERSION
             , BT.LASTMODIFIEDDATE
             , BT.HashCode
             , BT.SVR
             , BT.DBNAME
               FROM BASE_HFit_TrackerStress AS BT
                        JOIN CTE
                            ON CTE.SVR = BT.SVR
                           AND CTE.DBNAME = BT.DBNAME
                           AND CTE.ItemID = BT.ItemID;

    PRINT 'INSERTED: ' + CAST (@@ROWCOUNT AS NVARCHAR (50)) + ' records.';

    --***************************************************************
    -- APPLY ALL DELETES IF ANY

    DELETE FT
           FROM CHANGETABLE (CHANGES BASE_HFit_TrackerStress, @LastVersion) AS C
                    INNER JOIN FACT_TrackerData AS FT
                        ON C.DBNAME = FT.DBNAME
                       AND C.DBNAME = FT.DBNAME
                       AND C.ItemID = FT.ItemID
                       AND C.SYS_CHANGE_OPERATION = 'D';
    PRINT 'DELETED: ' + CAST (@@ROWCOUNT AS NVARCHAR (50)) + ' records.';

    --***************************************************************

    UPDATE FACT_TrackerData
           SET
               EventDate = BT.EventDate
             ,Awareness = BT.Awareness
             ,TrackerCollectionSourceID = BT.TrackerCollectionSourceID
             ,IsProfessionallyCollected = BT.IsProfessionallyCollected
             ,Intensity = BT.Intensity
             ,Notes = BT.Notes
             ,UserID = BT.UserID
             ,ItemCreatedBy = BT.ItemCreatedBy
             ,ItemCreatedWhen = BT.ItemCreatedWhen
             ,ItemModifiedBy = BT.ItemModifiedBy
             ,ItemModifiedWhen = BT.ItemModifiedWhen
             ,ItemID = BT.ItemID
             ,ACTION = BT.ACTION
             ,SYS_CHANGE_VERSION = BT.SYS_CHANGE_VERSION
             ,LASTMODIFIEDDATE = BT.LASTMODIFIEDDATE
             ,HashCode = BT.HashCode
             ,SVR = BT.SVR
             ,DBNAME = BT.DBNAME
               FROM
               CHANGETABLE (CHANGES BASE_HFit_TrackerStress, @LastVersion) AS C
                   INNER JOIN BASE_HFit_TrackerStress AS BT
                       ON C.SVR = BT.SVR
                      AND C.DBNAME = BT.DBNAME
                      AND C.ItemID = BT.ItemID
                      AND C.SYS_CHANGE_OPERATION = 'U';
    PRINT 'UPDATED: ' + CAST (@@ROWCOUNT AS NVARCHAR (50)) + ' records.';


    --***************************************************************
    DECLARE @iCnt AS BIGINT = (SELECT
                                      COUNT (*) 
                                      FROM BASE_HFit_TrackerStress_CTVerHIST
                                      WHERE SYS_CHANGE_VERSION = @synchronization_version);
    IF @iCnt = 0
        BEGIN
            INSERT INTO BASE_HFit_TrackerStress_CTVerHIST (
                   SYS_CHANGE_VERSION
                 , DBMS) 
            VALUES (
                   @synchronization_version, DB_NAME ()) ;
            PRINT 'Saved version id';
        END;
END; 
