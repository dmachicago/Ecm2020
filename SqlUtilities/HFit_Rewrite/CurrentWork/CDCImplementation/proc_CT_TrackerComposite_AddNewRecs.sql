
go 
print 'Executing proc_CT_TrackerComposite_AddNewRecs.SQL'
go

if exists (select name from sys.procedures where name = 'proc_CT_TrackerComposite_AddNewRecs')    
    drop procedure proc_CT_TrackerComposite_AddNewRecs;
go
--exec proc_CT_TrackerComposite_AddNewRecs
create procedure proc_CT_TrackerComposite_AddNewRecs
as
WITH CTE_NEW (
                 TrackerNameAggregateTable
                 ,ItemID )
                AS
                (
                SELECT
                       TrackerNameAggregateTable
                       ,ItemID
                  FROM DIM_TEMP_EDW_Tracker_DATA
                EXCEPT
                SELECT
                       TrackerNameAggregateTable
                       ,ItemID
                  FROM FACT_EDW_Trackers
			 where deletedflg is null
                )
                INSERT INTO dbo.FACT_EDW_Trackers (
                       TrackerNameAggregateTable
                       ,ItemID
                       ,EventDate
                       ,IsProfessionallyCollected
                       ,TrackerCollectionSourceID
                       ,Notes
                       ,UserID
                       ,CollectionSourceName_Internal
                       ,CollectionSourceName_External
                       ,EventName
                       ,UOM
                       ,KEY1
                       ,VAL1
                       ,KEY2
                       ,VAL2
                       ,KEY3
                       ,VAL3
                       ,KEY4
                       ,VAL4
                       ,KEY5
                       ,VAL5
                       ,KEY6
                       ,VAL6
                       ,KEY7
                       ,VAL7
                       ,KEY8
                       ,VAL8
                       ,KEY9
                       ,VAL9
                       ,KEY10
                       ,VAL10
                       ,ItemCreatedBy
                       ,ItemCreatedWhen
                       ,ItemModifiedBy
                       ,ItemModifiedWhen
                       ,IsProcessedForHa
                       ,TXTKEY1
                       ,TXTVAL1
                       ,TXTKEY2
                       ,TXTVAL2
                       ,TXTKEY3
                       ,TXTVAL3
                       ,ItemOrder
                       ,ItemGuid
                       ,UserGuid
                       ,MPI
                       ,ClientCode
                       ,SiteGUID
                       ,AccountID
                       ,AccountCD
                       ,IsAvailable
                       ,IsCustom
                       ,UniqueName
                       ,ColDesc
                       ,VendorID
                       ,VendorName
                       ,CT_ItemID
                       ,CT_ChangeVersion
                       ,CMS_Operation
                       ,ItemLastUpdated )
                SELECT
                       T1.TrackerNameAggregateTable
                       ,T1.ItemID
                       ,T1.EventDate
                       ,T1.IsProfessionallyCollected
                       ,T1.TrackerCollectionSourceID
                       ,T1.Notes
                       ,T1.UserID
                       ,T1.CollectionSourceName_Internal
                       ,T1.CollectionSourceName_External
                       ,T1.EventName
                       ,T1.UOM
                       ,T1.KEY1
                       ,T1.VAL1
                       ,T1.KEY2
                       ,T1.VAL2
                       ,T1.KEY3
                       ,T1.VAL3
                       ,T1.KEY4
                       ,T1.VAL4
                       ,T1.KEY5
                       ,T1.VAL5
                       ,T1.KEY6
                       ,T1.VAL6
                       ,T1.KEY7
                       ,T1.VAL7
                       ,T1.KEY8
                       ,T1.VAL8
                       ,T1.KEY9
                       ,T1.VAL9
                       ,T1.KEY10
                       ,T1.VAL10
                       ,T1.ItemCreatedBy
                       ,T1.ItemCreatedWhen
                       ,T1.ItemModifiedBy
                       ,T1.ItemModifiedWhen
                       ,T1.IsProcessedForHa
                       ,T1.TXTKEY1
                       ,T1.TXTVAL1
                       ,T1.TXTKEY2
                       ,T1.TXTVAL2
                       ,T1.TXTKEY3
                       ,T1.TXTVAL3
                       ,T1.ItemOrder
                       ,T1.ItemGuid
                       ,T1.UserGuid
                       ,T1.MPI
                       ,T1.ClientCode
                       ,T1.SiteGUID
                       ,T1.AccountID
                       ,T1.AccountCD
                       ,T1.IsAvailable
                       ,T1.IsCustom
                       ,T1.UniqueName
                       ,T1.ColDesc
                       ,T1.VendorID
                       ,T1.VendorName
                       ,T1.CT_ItemID
                       ,T1.CT_ChangeVersion
                       ,T1.CMS_Operation
                       ,GETDATE ( )
                  FROM
                       DIM_TEMP_EDW_Tracker_DATA AS T1 INNER JOIN
                            CTE_NEW AS T2
                                                           ON
                       T1.TrackerNameAggregateTable = T2.TrackerNameAggregateTable
                   AND T1.ItemId = T2.ItemId;

        DECLARE
           @iInserted AS int = @@ROWCOUNT;
	   PRINT 'Records Added: ' + CAST ( @iInserted AS nvarchar( 5 ));
	   return @iInserted ;
go 
print 'Executed proc_CT_TrackerComposite_AddNewRecs.SQL'
go
