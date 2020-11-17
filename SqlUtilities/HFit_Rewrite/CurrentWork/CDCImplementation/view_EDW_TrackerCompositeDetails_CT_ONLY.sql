GO
PRINT 'Processing: view_EDW_TrackerCompositeDetails_CT_ONLY ';
GO

--SELECT * FROM HFit_TrackerCotinine
--select * from view_EDW_TrackerCompositeDetails_CT_ONLY
--select * from HFit_TrackerBMI
--select * from HFit_TrackerCholesterol
--update HFit_TrackerBMI set Notes = 'TEST CHANGE' where ItemID in (15234,15235,15236)
--update HFit_TrackerCholesterol set Notes = 'TEST CHANGE' where ItemID BETWEEN 55922 AND 55928
--update HFit_TrackerCotinine set Notes = 'TEST CHANGE' where ItemID = 3

IF EXISTS ( SELECT
                   TABLE_NAME
                   FROM INFORMATION_SCHEMA.VIEWS
                   WHERE TABLE_NAME = 'view_EDW_TrackerCompositeDetails_CT_ONLY'
) 
    BEGIN
        DROP VIEW
             view_EDW_TrackerCompositeDetails_CT_ONLY;
    END;
GO
CREATE VIEW dbo.BASE_view_EDW_TrackerCompositeDetails_CT_ONLY
AS

--************************************************************************************************************************************
-- NOTES:
--************************************************************************************************************************************
--WDM 6/26/2014
--This view is needed by EDW in order to process the Tracker tables' data.
--As of now, the Tracker tables are representative of objects and that would cause 
--	large volumes of ETL to be devloped and maintained. 
--This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
--Each tracker table to be processed into the EDW must be represented in this view.
--ALL new tracker tables need only be entered once using the structure contained within this view
--	and the same EDW ETL should be able to process it.
--If there is a change to the strucuture of any one query in this view, then all have to be modified 
--	to be support the change.
--Column TrackerNameAggregratetable (AggregateTableName) will be NULL if the Tracker is not a member 
--		of the DISPLAYED Trackers. This allows us to capture all trackers, displayed or not.
--7/29/2014
--ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
--		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
--		This raises the need for the Tracker Definition Table.
--NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
--		be avoided here if possible.
--**************** SPECIFIC TRACKER DATA **********************
--**************** on 7/29/2014          **********************
--Tracker GUID or Unique ID across all DB Instances (ItemGuid)
--Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
--Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
--Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
--		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
--Tracker Column Description (In English) (???)
--Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
--	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
--Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
--Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
--Tracker Insert Date ([ItemCreatedWhen])
--Tracker Last Update Date ([ItemModifiedWhen])
--NOTE: Convert all numerics to floats 7/30/2104 John/Dale
--****************************************************************************************************************************
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
--****************************************************************************************************************************
-- NEW ADDITIONS: 02.01.2015	Need for the updates to be completed and then we add.
--HFit_TrackerTobaccoAttestation
--HFit_TrackerPreventiveCare
--HFit_TrackerCotinine
--****************************************************************************************************************************
--USE:
--select * from view_EDW_TrackerCompositeDetails_CT_ONLY where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'
--Set statistics IO ON
--GO

SELECT DISTINCT
       'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mm/Hg' AS UOM
     , 'Systolic' AS KEY1
     , CAST ( Systolic AS FLOAT
       )AS VAL1
     , 'Diastolic' AS KEY2
     , CAST ( Diastolic AS FLOAT
       )AS VAL2
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     , ISNULL ( T.UniqueName , 'bp'
       )AS UniqueName
     , ISNULL ( T.UniqueName , 'bp'
       )AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerBloodPressure AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerBloodPressure, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/L' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS FLOAT
       )AS VAL1
     , 'FastingState' AS KEY2
     , CAST ( FastingState AS FLOAT
       )AS VAL2
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     , ISNULL ( T.UniqueName , 'glucose'
       )AS UniqueName
     , ISNULL ( T.UniqueName , 'glucose'
       )AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerBloodSugarAndGlucose AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerBloodSugarAndGlucose, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL

/*
SELECT Distinct
	  [CT].[ItemID]
  FROM CHANGETABLE (CHANGES BASE_[HFit_TrackerBMI] , NULL) AS [CT];

*/

SELECT DISTINCT
       'HFit_TrackerBMI' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'kg/m2' AS UOM
     , 'BMI' AS KEY1
     , CAST ( BMI AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI'
       )AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI'
       )AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerBMI AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerBMI'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerBMI, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'PCT' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat'
       )AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat'
       )AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerBodyFat AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerBodyFat'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerBodyFat, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL

--******************************************************************************

SELECT DISTINCT
       'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Inch' AS UOM
     , 'WaistInches' AS KEY1
     , CAST ( WaistInches AS FLOAT
       )AS VAL1
     , 'HipInches' AS KEY2
     , CAST ( HipInches AS FLOAT
       )AS VAL2
     , 'ThighInches' AS KEY3
     , CAST ( ThighInches AS FLOAT
       )AS VAL3
     , 'ArmInches' AS KEY4
     , CAST ( ArmInches AS FLOAT
       )AS VAL4
     , 'ChestInches' AS KEY5
     , CAST ( ChestInches AS FLOAT
       )AS VAL5
     , 'CalfInches' AS KEY6
     , CAST ( CalfInches AS FLOAT
       )AS VAL6
     , 'NeckInches' AS KEY7
     , CAST ( NeckInches AS FLOAT
       )AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
       FROM dbo.BASE_HFit_TrackerBodyMeasurements AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID --******************************************************************************
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerBodyMeasurements, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCardio' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'Minutes' AS KEY1
     , CAST ( Minutes AS FLOAT
       )AS VAL1
     , 'Distance' AS KEY2
     , CAST ( Distance AS FLOAT
       )AS VAL2
     , 'DistanceUnit' AS KEY3
     , CAST ( DistanceUnit AS FLOAT
       )AS VAL3
     , 'Intensity' AS KEY4
     , CAST ( Intensity AS FLOAT
       )AS VAL4
     , 'ActivityID' AS KEY5
     , CAST ( ActivityID AS FLOAT
       )AS VAL5
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerCardio AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerCardio' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerCardio, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mg/dL' AS UOM
     , 'HDL' AS KEY1
     , CAST ( HDL AS FLOAT
       )AS VAL1
     , 'LDL' AS KEY2
     , CAST ( LDL AS FLOAT
       )AS VAL2
     , 'Total' AS KEY3
     , CAST ( Total AS FLOAT
       )AS VAL3
     , 'Tri' AS KEY4
     , CAST ( Tri AS FLOAT
       )AS VAL4
     , 'Ratio' AS KEY5
     , CAST ( Ratio AS FLOAT
       )AS VAL5
     , 'Fasting' AS KEY6
     , CAST ( Fasting AS FLOAT
       )AS VAL6
     , 'VLDL' AS VLDL
     , CAST ( VLDL AS FLOAT
       )AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol'
       )AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol'
       )AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerCholesterol AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerCholesterol'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerCholesterol, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Step' AS UOM
     , 'Steps' AS KEY1
     , CAST ( Steps AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps'
       )AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps'
       )AS ColDesc
     , NULL AS VendorID

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerDailySteps AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerDailySteps' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerDailySteps, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasStretched' AS KEY1
     , CAST ( HasStretched AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerFlexibility AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerFlexibility' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerFlexibility, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFruits' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerFruits AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerFruits' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerFruits, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/mol' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
       FROM dbo.BASE_HFit_TrackerHbA1c AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerHbA1c'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerHbA1c, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight'
       )AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight'
       )AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerHeight AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerHeight'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerHeight, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerHighFatFoods AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerHighFatFoods' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerHighFatFoods, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerHighSodiumFoods AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerHighSodiumFoods, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'TrackerDefID' AS KEY1
     , CAST ( TrackerDefID AS FLOAT
       )AS VAL1
     , 'YesNoValue' AS KEY2
     , CAST ( YesNoValue AS FLOAT
       )AS VAL2
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
       FROM dbo.BASE_HFit_TrackerInstance_Tracker AS TT
                INNER JOIN dbo.BASE_HFit_TrackerDef_Tracker AS TDT
                    ON TDT.trackerid = TT.trackerDefID
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
                   AND T.uniquename = TDT.name
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerInstance_Tracker, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerMealPortions AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerMealPortions' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerMealPortions, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FollowedPlan' AS KEY1
     , CAST ( FollowedPlan AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerMedicalCarePlan AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerMedicalCarePlan, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerRegularMeals AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerRegularMeals' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerRegularMeals, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'BPM' AS UOM
     , 'HeartRate' AS KEY1
     , CAST ( HeartRate AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
       FROM dbo.BASE_HFit_TrackerRestingHeartRate AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerRestingHeartRate, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerShots' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FluShot' AS KEY1
     , CAST ( FluShot AS FLOAT
       )AS VAL1
     , 'PneumoniaShot' AS KEY2
     , CAST ( PneumoniaShot AS FLOAT
       )AS VAL2
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
       FROM dbo.BASE_HFit_TrackerShots AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerShots'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerShots, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSitLess' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerSitLess AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerSitLess' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerSitLess, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'HR' AS UOM
     , 'DidFollow' AS KEY1
     , CAST ( DidFollow AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerSleepPlan AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerSleepPlan' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerSleepPlan, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStrength' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasTrained' AS KEY1
     , CAST ( HasTrained AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerStrength AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerStrength' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerStrength, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStress' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'Intensity' AS KEY1
     , CAST ( Intensity AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerStress AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerStress' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerStress, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'HasPracticed' AS KEY1
     , CAST ( HasPracticed AS FLOAT
       )AS VAL1
     , 'Effectiveness' AS KEY2
     , CAST ( Effectiveness AS FLOAT
       )AS VAL2
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerStressManagement AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerStressManagement' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerStressManagement, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerSugaryDrinks AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerSugaryDrinks, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerSugaryFoods AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerSugaryFoods' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerSugaryFoods, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTests' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PSATest' AS KEY1
     , CAST ( PSATest AS FLOAT
       )AS VAL1
     , 'OtherExam' AS KEY1
     , CAST ( OtherExam AS FLOAT
       )AS VAL2
     , 'TScore' AS KEY3
     , CAST ( TScore AS FLOAT
       )AS VAL3
     , 'DRA' AS KEY4
     , CAST ( DRA AS FLOAT
       )AS VAL4
     , 'CotinineTest' AS KEY5
     , CAST ( CotinineTest AS FLOAT
       )AS VAL5
     , 'ColoCareKit' AS KEY6
     , CAST ( ColoCareKit AS FLOAT
       )AS VAL6
     , 'CustomTest' AS KEY7
     , CAST ( CustomTest AS FLOAT
       )AS VAL7
     , 'TSH' AS KEY8
     , CAST ( TSH AS FLOAT
       )AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
       FROM dbo.BASE_HFit_TrackerTests AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerTests'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerTests, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'WasTobaccoFree' AS KEY1
     , CAST ( WasTobaccoFree AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerTobaccoFree AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerTobaccoFree' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerTobaccoFree, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerVegetables' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerVegetables AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerVegetables' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerVegetables, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWater' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerWater AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerWater' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerWater, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
       FROM dbo.BASE_HFit_TrackerWeight AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerWeight'
                LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
                    ON TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerWeight, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-serving' AS UOM
     , 'Servings' AS KEY1
     , CAST ( Servings AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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

       --VENDOR.ItemID as VendorID

     , NULL AS VendorName

       --VENDOR.VendorName

     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerWholeGrains AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerWholeGrains' --left outer JOIN dbo.BASE_HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerWholeGrains, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCotinine' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'NicotineAssessment' AS KEY1
     , CAST ( NicotineAssessment AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     ,--VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,

       NULL AS VendorID
     , NULL AS VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerCotinine AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerCotinine' --LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerCotinine, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PreventiveCare' AS KEY1
     , CAST ( PreventiveCare AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     ,--VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,

       NULL AS VendorID
     , NULL AS VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerPreventiveCare AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerPreventiveCare' --LEFT OUTER JOIN dbo.BASE_HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerPreventiveCare, NULL) AS CT
                    ON TT.itemid = CT.itemid
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
     , TT.ItemID
     , CAST ( EventDate AS DATETIME) AS EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'TobaccoAttestation' AS KEY1
     , CAST ( TobaccoAttestation AS FLOAT
       )AS VAL1
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
     , CAST ( TT.ItemCreatedWhen AS DATETIME) AS ItemCreatedWhen
     , TT.ItemModifiedBy
     , CAST ( TT.ItemModifiedWhen AS DATETIME) AS ItemModifiedWhen
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
     ,--VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,

       NULL AS VendorID
     , NULL AS VendorName
     , CT.ItemID AS CT_ItemID
     , CT.SYS_CHANGE_VERSION AS CT_ChangeVersion
     , CT.SYS_CHANGE_OPERATION AS CMS_Operation
       FROM dbo.BASE_HFit_TrackerTobaccoAttestation AS TT
                INNER JOIN dbo.BASE_CMS_User AS C
                    ON C.UserID = TT.UserID
                INNER JOIN dbo.BASE_hfit_ppteligibility AS PP
                    ON TT.UserID = PP.userID
                INNER JOIN dbo.BASE_HFit_Account AS ACCT
                    ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.BASE_CMS_Site AS S
                    ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS TC
                    ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.BASE_HFIT_Tracker AS T
                    ON T.AggregateTableName = 'HFit_TrackerTobaccoAttestation'
                INNER JOIN CHANGETABLE (CHANGES BASE_HFit_TrackerTobaccoAttestation, NULL) AS CT
                    ON TT.itemid = CT.itemid;
GO

--  
--  

GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails_CT_ONLY.sql';
PRINT '***** CREATED view_EDW_TrackerCompositeDetails_CT_ONLY ';
GO 


