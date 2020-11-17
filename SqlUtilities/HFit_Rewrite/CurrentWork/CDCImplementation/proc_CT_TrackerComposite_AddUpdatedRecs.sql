
GO
PRINT 'Executing proc_CT_TrackerComposite_AddUpdatedRecs.SQL';
GO
IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE
              name = 'proc_CT_TrackerComposite_AddUpdatedRecs')
    BEGIN
        DROP PROCEDURE
             proc_CT_TrackerComposite_AddUpdatedRecs;
    END;
GO

--select top 100 * from FACT_EDW_Trackers
-- exec proc_CT_TrackerComposite_AddUpdatedRecs

CREATE PROCEDURE proc_CT_TrackerComposite_AddUpdatedRecs
AS
BEGIN
    IF NOT EXISTS ( SELECT
                           name
                      FROM tempdb.dbo.sysobjects
                      WHERE
                      id = OBJECT_ID ( N'tempdb..##TempCompositeData'))
        BEGIN
            PRINT 'Reading changed data, standby...';
            EXEC proc_CkTrackerDataChanged;
        END;
    DECLARE
       @RUNDATE AS datetime2 ( 7) = GETDATE ();
    DECLARE
       @CurrentChgVersion AS  bigint = CHANGE_TRACKING_CURRENT_VERSION ();
    PRINT 'Processing Current Change Version: ' + CAST ( @CurrentChgVersion AS nvarchar(50));
    UPDATE S
    SET
        S.TrackerNameAggregateTable = T.TrackerNameAggregateTable
      ,S.ItemID = T.ItemID
      ,S.EventDate = T.EventDate
      ,S.IsProfessionallyCollected = T.IsProfessionallyCollected
      ,S.TrackerCollectionSourceID = T.TrackerCollectionSourceID
      ,S.Notes = T.Notes
      ,S.UserID = T.UserID
      ,S.CollectionSourceName_Internal = T.CollectionSourceName_Internal
      ,S.CollectionSourceName_External = T.CollectionSourceName_External
      ,S.EventName = T.EventName
      ,S.UOM = T.UOM
      ,S.KEY1 = T.KEY1
      ,S.VAL1 = T.VAL1
      ,S.KEY2 = T.KEY2
      ,S.VAL2 = T.VAL2
      ,S.KEY3 = T.KEY3
      ,S.VAL3 = T.VAL3
      ,S.KEY4 = T.KEY4
      ,S.VAL4 = T.VAL4
      ,S.KEY5 = T.KEY5
      ,S.VAL5 = T.VAL5
      ,S.KEY6 = T.KEY6
      ,S.VAL6 = T.VAL6
      ,S.KEY7 = T.KEY7
      ,S.VAL7 = T.VAL7
      ,S.KEY8 = T.KEY8
      ,S.VAL8 = T.VAL8
      ,S.KEY9 = T.KEY9
      ,S.VAL9 = T.VAL9
      ,S.KEY10 = T.KEY10
      ,S.VAL10 = T.VAL10
      ,S.ItemCreatedBy = T.ItemCreatedBy
      ,S.ItemCreatedWhen = T.ItemCreatedWhen
      ,S.ItemModifiedBy = T.ItemModifiedBy
      ,S.ItemModifiedWhen = T.ItemModifiedWhen
      ,S.IsProcessedForHa = T.IsProcessedForHa
      ,S.TXTKEY1 = T.TXTKEY1
      ,S.TXTVAL1 = T.TXTVAL1
      ,S.TXTKEY2 = T.TXTKEY2
      ,S.TXTVAL2 = T.TXTVAL2
      ,S.TXTKEY3 = T.TXTKEY3
      ,S.TXTVAL3 = T.TXTVAL3
      ,S.ItemOrder = T.ItemOrder
      ,S.ItemGuid = T.ItemGuid
      ,S.UserGuid = T.UserGuid
      ,S.MPI = T.MPI
      ,S.ClientCode = T.ClientCode
      ,S.SiteGUID = T.SiteGUID
      ,S.AccountID = T.AccountID
      ,S.AccountCD = T.AccountCD
      ,S.IsAvailable = T.IsAvailable
      ,S.IsCustom = T.IsCustom
      ,S.UniqueName = T.UniqueName
      ,S.ColDesc = T.ColDesc
      ,S.VendorID = T.VendorID
      ,S.VendorName = T.VendorName
      ,S.CT_ItemID = T.CT_ItemID
      ,S.CT_ChangeVersion = @CurrentChgVersion
      ,S.CMS_Operation = T.CMS_Operation
      ,S.LastModifiedDate = GETDATE ()
      ,S.ConvertedToCentralTime = NULL
      FROM FACT_EDW_Trackers AS S
           JOIN
           ##TempCompositeData AS TTEMP
               ON
               TTEMP.TGTTBL = S.TrackerNameAggregateTable
           AND TTEMP.ItemID = S.ItemID
           AND TTEMP.SYS_CHANGE_OPERATION = 'U'
           JOIN
           DIM_TEMP_EDW_Tracker_DATA AS T
               ON
               T.ItemID = S.ItemID
           AND T.TrackerNameAggregateTable = S.TrackerNameAggregateTable
           AND T.DeletedFlg IS NULL;

    --AND T.CMS_Operation = 'U' 

    DECLARE
       @iUpdated AS int = + @@ROWCOUNT;
    RETURN @iUpdated;
END;
GO
PRINT 'Executed proc_CT_TrackerComposite_AddUpdatedRecs.SQL';
GO
