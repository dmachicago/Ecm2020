

go
-- use KenticoCMS_Prod1
PRINT 'Processing: view_EDW_TrackerCompositeDetails_CT ';
GO

--SELECT * from view_EDW_TrackerCompositeDetails_CT where CMS_Operation is not null

IF EXISTS ( SELECT
                   TABLE_NAME
                   FROM INFORMATION_SCHEMA.VIEWS
                   WHERE TABLE_NAME = 'view_EDW_TrackerCompositeDetails_CT') 
    BEGIN
        DROP VIEW
             view_EDW_TrackerCompositeDetails_CT;
    END;
GO

CREATE VIEW dbo.view_EDW_TrackerCompositeDetails_CT
AS SELECT DISTINCT
          'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'mm/Hg' AS UOM
        , 'Systolic' AS KEY1
        , CAST ( Systolic AS float) AS VAL1
        , 'Diastolic' AS KEY2
        , CAST ( Diastolic AS float) AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , ISNULL ( T.UniqueName , 'bp') AS UniqueName
        , ISNULL ( T.UniqueName , 'bp') AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
         , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	   FROM
               dbo.HFit_TrackerBloodPressure AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerBloodPressure, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'mmol/L' AS UOM
        , 'Units' AS KEY1
        , CAST ( Units AS float) AS VAL1
        , 'FastingState' AS KEY2
        , CAST ( FastingState AS float) AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , ISNULL ( T.UniqueName , 'glucose') AS UniqueName
        , ISNULL ( T.UniqueName , 'glucose') AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerBloodSugarAndGlucose AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerBloodSugarAndGlucose, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerBMI' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'kg/m2' AS UOM
        , 'BMI' AS KEY1
        , CAST ( BMI AS float) AS VAL1
        , 'NA' AS KEY2
        , 0 AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , TT.ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS UniqueName
        , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerBMI AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerBMI'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerBMI, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'PCT' AS UOM
        , 'Value' AS KEY1
        , CAST ( [Value] AS float) AS VAL1
        , 'NA' AS KEY2
        , 0 AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName
        , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerBodyFat AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerBodyFat'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerBodyFat, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL

   SELECT DISTINCT
          'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Inch' AS UOM
        , 'WaistInches' AS KEY1
        , CAST ( WaistInches AS float) AS VAL1
        , 'HipInches' AS KEY2
        , CAST ( HipInches AS float) AS VAL2
        , 'ThighInches' AS KEY3
        , CAST ( ThighInches AS float) AS VAL3
        , 'ArmInches' AS KEY4
        , CAST ( ArmInches AS float) AS VAL4
        , 'ChestInches' AS KEY5
        , CAST ( ChestInches AS float) AS VAL5
        , 'CalfInches' AS KEY6
        , CAST ( CalfInches AS float) AS VAL6
        , 'NeckInches' AS KEY7
        , CAST ( NeckInches AS float) AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerBodyMeasurements AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerBodyMeasurements, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerCardio' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA' AS UOM
        , 'Minutes' AS KEY1
        , CAST ( Minutes AS float) AS VAL1
        , 'Distance' AS KEY2
        , CAST ( Distance AS float) AS VAL2
        , 'DistanceUnit' AS KEY3
        , CAST ( DistanceUnit AS float) AS VAL3
        , 'Intensity' AS KEY4
        , CAST ( Intensity AS float) AS VAL4
        , 'ActivityID' AS KEY5
        , CAST ( ActivityID AS float) AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerCardio AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerCardio' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerCardio, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'mg/dL' AS UOM
        , 'HDL' AS KEY1
        , CAST ( HDL AS float) AS VAL1
        , 'LDL' AS KEY2
        , CAST ( LDL AS float) AS VAL2
        , 'Total' AS KEY3
        , CAST ( Total AS float) AS VAL3
        , 'Tri' AS KEY4
        , CAST ( Tri AS float) AS VAL4
        , 'Ratio' AS KEY5
        , CAST ( Ratio AS float) AS VAL5
        , 'Fasting' AS KEY6
        , CAST ( Fasting AS float) AS VAL6
        , 'VLDL' AS VLDL
        , CAST ( VLDL AS float) AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS UniqueName
        , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerCholesterol AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerCholesterol'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerCholesterol, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Step' AS UOM
        , 'Steps' AS KEY1
        , CAST ( Steps AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS UniqueName
        , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerDailySteps AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerDailySteps' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerDailySteps, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Y/N' AS UOM
        , 'HasStretched' AS KEY1
        , CAST ( HasStretched AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'Activity' AS TXTKEY1
        , Activity AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerFlexibility AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerFlexibility' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerFlexibility, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerFruits' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'CUP(8oz)' AS UOM
        , 'Cups' AS KEY1
        , CAST ( Cups AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerFruits AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerFruits' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerFruits, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'mmol/mol' AS UOM
        , 'Value' AS KEY1
        , CAST ( [Value] AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerHbA1c AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerHbA1c'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerHbA1c, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerHeight' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'inch' AS UOM
        , 'Height' AS KEY1
        , Height AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , TT.ItemOrder
        , TT.ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS UniqueName
        , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerHeight AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerHeight'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerHeight, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Occurs' AS UOM
        , 'Times' AS KEY1
        , CAST ( Times AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerHighFatFoods AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerHighFatFoods' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerHighFatFoods, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Occurs' AS UOM
        , 'Times' AS KEY1
        , CAST ( Times AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerHighSodiumFoods AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerHighSodiumFoods, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Y/N' AS UOM
        , 'TrackerDefID' AS KEY1
        , CAST ( TrackerDefID AS float) AS VAL1
        , 'YesNoValue' AS KEY2
        , CAST ( YesNoValue AS float) AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerInstance_Tracker AS TT
                   INNER JOIN dbo.HFit_TrackerDef_Tracker AS TDT
                   ON TDT.trackerid = TT.trackerDefID
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON
          T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
      AND T.uniquename = TDT.name
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerInstance_Tracker, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA-portion' AS UOM
        , 'Portions' AS KEY1
        , CAST ( Portions AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerMealPortions AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerMealPortions' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerMealPortions, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Y/N' AS UOM
        , 'FollowedPlan' AS KEY1
        , CAST ( FollowedPlan AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerMedicalCarePlan AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerMedicalCarePlan, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Occurs' AS UOM
        , 'Units' AS KEY1
        , CAST ( Units AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerRegularMeals AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerRegularMeals' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerRegularMeals, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'BPM' AS UOM
        , 'HeartRate' AS KEY1
        , CAST ( HeartRate AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerRestingHeartRate AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerRestingHeartRate, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerShots;' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Y/N' AS UOM
        , 'FluShot' AS KEY1
        , CAST ( FluShot AS float) AS VAL1
        , 'PneumoniaShot' AS KEY2
        , CAST ( PneumoniaShot AS float) AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , TT.ItemOrder
        , TT.ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerShots AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerShots'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerShots, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerSitLess' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Occurs' AS UOM
        , 'Times' AS KEY1
        , CAST ( Times AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerSitLess AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerSitLess' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerSitLess, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'HR' AS UOM
        , 'DidFollow' AS KEY1
        , CAST ( DidFollow AS float) AS VAL1
        , 'HoursSlept' AS KEY2
        , HoursSlept AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'Techniques' AS TXTKEY1
        , Techniques AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerSleepPlan AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerSleepPlan' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerSleepPlan, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerStrength' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Y/N' AS UOM
        , 'HasTrained' AS KEY1
        , CAST ( HasTrained AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'Activity' AS TXTKEY1
        , Activity AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerStrength AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerStrength' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerStrength, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerStress' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'gradient' AS UOM
        , 'Intensity' AS KEY1
        , CAST ( Intensity AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'Awareness' AS TXTKEY1
        , Awareness AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerStress AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerStress' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerStress, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'gradient' AS UOM
        , 'HasPracticed' AS KEY1
        , CAST ( HasPracticed AS float) AS VAL1
        , 'Effectiveness' AS KEY2
        , CAST ( Effectiveness AS float) AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'Activity' AS TXTKEY1
        , Activity AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerStressManagement AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerStressManagement' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerStressManagement, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'OZ' AS UOM
        , 'Ounces' AS KEY1
        , CAST ( Ounces AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerSugaryDrinks AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerSugaryDrinks, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA-portion' AS UOM
        , 'Portions' AS KEY1
        , CAST ( Portions AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerSugaryFoods AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerSugaryFoods' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerSugaryFoods, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerTests' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA' AS UOM
        , 'PSATest' AS KEY1
        , CAST ( PSATest AS float) AS VAL1
        , 'OtherExam' AS KEY1
        , CAST ( OtherExam AS float) AS VAL2
        , 'TScore' AS KEY3
        , CAST ( TScore AS float) AS VAL3
        , 'DRA' AS KEY4
        , CAST ( DRA AS float) AS VAL4
        , 'CotinineTest' AS KEY5
        , CAST ( CotinineTest AS float) AS VAL5
        , 'ColoCareKit' AS KEY6
        , CAST ( ColoCareKit AS float) AS VAL6
        , 'CustomTest' AS KEY7
        , CAST ( CustomTest AS float) AS VAL7
        , 'TSH' AS KEY8
        , CAST ( TSH AS float) AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'CustomDesc' AS TXTKEY1
        , CustomDesc AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , TT.ItemOrder
        , TT.ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerTests AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerTests'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerTests, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'Y/N' AS UOM
        , 'WasTobaccoFree' AS KEY1
        , CAST ( WasTobaccoFree AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'QuitAids' AS TXTKEY1
        , QuitAids AS TXTVAL1
        , 'QuitMeds' AS TXTKEY2
        , QuitMeds AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerTobaccoFree AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerTobaccoFree' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerTobaccoFree, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerVegetables' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'CUP(8oz)' AS UOM
        , 'Cups' AS KEY1
        , CAST ( Cups AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerVegetables AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerVegetables' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerVegetables, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerWater' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'OZ' AS UOM
        , 'Ounces' AS KEY1
        , CAST ( Ounces AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerWater AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerWater' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerWater, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerWeight' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'LBS' AS UOM
        , 'Value' AS KEY1
        , [Value] AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , VENDOR.ItemID AS VendorID
        , VENDOR.VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerWeight AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerWeight'
                   LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                   ON TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerWeight, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , CollectionSourceName_Internal
        , CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA-serving' AS UOM
        , 'Servings' AS KEY1
        , CAST ( Servings AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , NULL AS IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerWholeGrains AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerWholeGrains' --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerWholeGrains, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerCotinine' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , NULL AS CollectionSourceName_Internal
        , NULL AS CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA' AS UOM
        , 'NicotineAssessment' AS KEY1
        , CAST ( NicotineAssessment AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerCotinine AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerCotinine' --LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
               --	ON TT.VendorID = VENDOR.ItemID;
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerCotinine, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , NULL AS CollectionSourceName_Internal
        , NULL AS CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA' AS UOM
        , 'PreventiveCare' AS KEY1
        , CAST ( PreventiveCare AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerPreventiveCare AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerPreventiveCare' --LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
               --	ON TT.VendorID = VENDOR.ItemID;
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerPreventiveCare, NULL) AS CT
                   ON TT.itemid = CT.itemid
   UNION ALL
   SELECT DISTINCT
          'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
        , TT.ItemID
        , cast(EventDate as datetime) as EventDate
        , TT.IsProfessionallyCollected
        , TT.TrackerCollectionSourceID
        , Notes
        , TT.UserID
        , NULL AS CollectionSourceName_Internal
        , NULL AS CollectionSourceName_External
        , 'MISSING' AS EventName
        , 'NA' AS UOM
        , 'TobaccoAttestation' AS KEY1
        , CAST ( TobaccoAttestation AS float) AS VAL1
        , 'NA' AS KEY2
        , NULL AS VAL2
        , 'NA' AS KEY3
        , NULL AS VAL3
        , 'NA' AS KEY4
        , NULL AS VAL4
        , 'NA' AS KEY5
        , NULL AS VAL5
        , 'NA' AS KEY6
        , NULL AS VAL6
        , 'NA' AS KEY7
        , NULL AS VAL7
        , 'NA' AS KEY8
        , NULL AS VAL8
        , 'NA' AS KEY9
        , NULL AS VAL9
        , 'NA' AS KEY10
        , NULL AS VAL10
        , TT.ItemCreatedBy
        , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
        , TT.ItemModifiedBy
        , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
        , IsProcessedForHa
        , 'NA' AS TXTKEY1
        , NULL AS TXTVAL1
        , 'NA' AS TXTKEY2
        , NULL AS TXTVAL2
        , 'NA' AS TXTKEY3
        , NULL AS TXTVAL3
        , NULL AS ItemOrder
        , NULL AS ItemGuid
        , C.UserGuid
        , PP.MPI
        , PP.ClientCode
        , S.SiteGUID
        , ACCT.AccountID
        , ACCT.AccountCD
        , T.IsAvailable
        , T.IsCustom
        , T.UniqueName
        , T.UniqueName AS ColDesc
        , NULL AS VendorID
        , NULL AS VendorName
        , CT.ItemID AS CT_ItemID
        , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
        , CT.SYS_CHANGE_OPERATION AS CMS_Operation
          , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
               dbo.HFit_TrackerTobaccoAttestation AS TT
                   INNER JOIN dbo.CMS_User AS C
                   ON C.UserID = TT.UserID
                   INNER JOIN dbo.hfit_ppteligibility AS PP
                   ON TT.UserID = PP.userID
                   INNER JOIN dbo.HFit_Account AS ACCT
                   ON PP.ClientCode = ACCT.AccountCD
                   INNER JOIN dbo.CMS_Site AS S
                   ON ACCT.SiteID = S.SiteID
                   INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                   ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                   LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                   ON T.AggregateTableName = 'HFit_TrackerTobaccoAttestation'
                   LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_TrackerTobaccoAttestation, NULL) AS CT
                   ON TT.itemid = CT.itemid;

GO

--  
--  
GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails_CT.sql';
PRINT '***** CREATED view_EDW_TrackerCompositeDetails_CT ';
GO 


