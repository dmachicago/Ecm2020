
GO
PRINT 'Creating view view_EDW_Trackers_STAGED';
PRINT 'Generated FROM: view_EDW_Trackers_STAGED.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE name = 'view_EDW_Trackers_STAGED') 
    BEGIN
        PRINT 'VIEW view_EDW_Trackers_STAGED, replacing.';
        DROP VIEW
             view_EDW_Trackers_STAGED;
    END;
GO

create view view_EDW_Trackers_STAGED
as
SELECT [TrackerNameAggregateTable]
      ,[ItemID]
      ,[EventDate]
      ,[IsProfessionallyCollected]
      ,[TrackerCollectionSourceID]
      ,[Notes]
      ,[UserID]
      ,[CollectionSourceName_Internal]
      ,[CollectionSourceName_External]
      ,[EventName]
      ,[UOM]
      ,[KEY1]
      ,[VAL1]
      ,[KEY2]
      ,[VAL2]
      ,[KEY3]
      ,[VAL3]
      ,[KEY4]
      ,[VAL4]
      ,[KEY5]
      ,[VAL5]
      ,[KEY6]
      ,[VAL6]
      ,[KEY7]
      ,[VAL7]
      ,[KEY8]
      ,[VAL8]
      ,[KEY9]
      ,[VAL9]
      ,[KEY10]
      ,[VAL10]
      ,[ItemCreatedBy]
      ,[ItemCreatedWhen]
      ,[ItemModifiedBy]
      ,[ItemModifiedWhen]
      ,[IsProcessedForHa]
      ,[TXTKEY1]
      ,[TXTVAL1]
      ,[TXTKEY2]
      ,[TXTVAL2]
      ,[TXTKEY3]
      ,[TXTVAL3]
      ,[ItemOrder]
      ,[ItemGuid]
      ,[UserGuid]
      ,[MPI]
      ,[ClientCode]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[IsAvailable]
      ,[IsCustom]
      ,[UniqueName]
      ,[ColDesc]
      ,[VendorID]
      ,[VendorName]
  FROM [dbo].Staging_EDW_Trackers
GO

PRINT 'Created view view_EDW_Trackers_STAGED';
GO