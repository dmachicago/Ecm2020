
--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--DISABLE TRIGGER trgSchemaMonitor ON DATABASE;

GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails.sql';
PRINT 'Processing: view_EDW_TrackerCompositeDetails ';
GO
--SELECT top 10 * from view_EDW_TrackerCompositeDetails
IF EXISTS(SELECT DISTINCT TABLE_NAME
            FROM INFORMATION_SCHEMA.VIEWS
            WHERE TABLE_NAME = 'view_EDW_TrackerCompositeDetails')
    BEGIN
        DROP VIEW dbo.view_EDW_TrackerCompositeDetails;
    END;
GO
--count with UNION ALL xx @ 00:00:24
--count with UNION ALL and DISTINCT xx @ 00:00:24
--count with UNION 3,218,556 @ 00:00:24
--SELECT count(*) from view_EDW_TrackerCompositeDetails;
GO
CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
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
--EventDate is the qualifier to pull a date or between dates.
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
-- 12.21.2014 - Added Select Distincts to avoid possible dups.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
--****************************************************************************************************************************
-- NEW ADDITIONS: 02.01.2015	Need for the updates to be completed and then we add.
--	  HFit_TrackerTobaccoAttestation
--	  HFit_TrackerPreventiveCare
--	  HFit_TrackerCotinine
--(03.20.2015) - (WDM) The DISTINCT in this qry in should eliminate duplicate rows found by John C.
--			 All worked correctly in 12.25.2014, NO changes effected since then, and unexplicably rows stated to 
--			 duplicate in three tables (tracker views) Shots, Tests, and TrackerInstance
--(03.20.2015) - WDM : HFit_TrackerInstance_Tracker has a problem that will require developer help - it is still OPEN.
--			    John C. and I looked at the issue and the LEFT join is causing a cartisian as there is no KEY 
--			    on which to join.
-- TGT (PRod1) NO DISTINCT: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:08:36 @ 3,210,081
--- TGT (PRod1) WITH DISTINCT and Union all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:30 @ 3,210,081
--- TGT (PRod1) No DISTINCT and UNion all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:14 @ 3,218,556
--(03.21.2015) - WDM : Implemented bew code for TrackerInstance and it returns data properly now.
--(03.22.2015) - WDM : Found and corrected the Shots and Tests duplicate rows. No DUPS at this point.
--(12.03.2015) = Scott and Dale: The problem has resurfaced per Robert.
--			  the following where clause was added on 11/23/2015 as a result of BAD DATA from the PPT
--****************************************************************************************************************************
--Best USE is:		(however, I do not believe Laura is allowing this view to be called in this fashion)
--SELECT * from view_EDW_TrackerCompositeDetails where EventDate between '2013-11-04 00:00:00' and '2013-11-04 23:59:59'

--Set statistics IO ON
--GO

SELECT DISTINCT 'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'mm/Hg' AS UOM
              , 'Systolic' AS KEY1
              , CAST(TT.Systolic AS float)AS VAL1
              , 'Diastolic' AS KEY2
              , CAST(TT.Diastolic AS float)AS VAL2
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
              , ISNULL(T.UniqueName , 'bp')AS UniqueName
              , ISNULL(T.UniqueName , 'bp')AS ColDesc
              , VENDOR.ItemID AS VendorID
              , VENDOR.VendorName
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'mmol/L' AS UOM
              , 'Units' AS KEY1
              , CAST(TT.Units AS float)AS VAL1
              , 'FastingState' AS KEY2
              , CAST(TT.FastingState AS float)AS VAL2
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
              , ISNULL(T.UniqueName , 'glucose')AS UniqueName
              , ISNULL(T.UniqueName , 'glucose')AS ColDesc
              , VENDOR.ItemID AS VendorID
              , VENDOR.VendorName
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerBMI' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'kg/m2' AS UOM
              , 'BMI' AS KEY1
              , CAST(TT.BMI AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , ISNULL(T.UniqueName , 'HFit_TrackerBMI')AS UniqueName
              , ISNULL(T.UniqueName , 'HFit_TrackerBMI')AS ColDesc
              , VENDOR.ItemID AS VendorID
              , VENDOR.VendorName
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'PCT' AS UOM
              , 'Value' AS KEY1
              , CAST(TT.[Value] AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , ISNULL(T.UniqueName , 'HFit_TrackerBodyFat')AS UniqueName
              , ISNULL(T.UniqueName , 'HFit_TrackerBodyFat')AS ColDesc
              , VENDOR.ItemID AS VendorID
              , VENDOR.VendorName
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
--******************************************************************************
SELECT DISTINCT 'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Inch' AS UOM
              , 'WaistInches' AS KEY1
              , CAST(TT.WaistInches AS float)AS VAL1
              , 'HipInches' AS KEY2
              , CAST(TT.HipInches AS float)AS VAL2
              , 'ThighInches' AS KEY3
              , CAST(TT.ThighInches AS float)AS VAL3
              , 'ArmInches' AS KEY4
              , CAST(TT.ArmInches AS float)AS VAL4
              , 'ChestInches' AS KEY5
              , CAST(TT.ChestInches AS float)AS VAL5
              , 'CalfInches' AS KEY6
              , CAST(TT.CalfInches AS float)AS VAL6
              , 'NeckInches' AS KEY7
              , CAST(TT.NeckInches AS float)AS VAL7
              , 'NA' AS KEY8
              , NULL AS VAL8
              , 'NA' AS KEY9
              , NULL AS VAL9
              , 'NA' AS KEY10
              , NULL AS VAL10
              , TT.ItemCreatedBy
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
--******************************************************************************
UNION ALL
SELECT DISTINCT 'HFit_TrackerCardio' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA' AS UOM
              , 'Minutes' AS KEY1
              , CAST(TT.Minutes AS float)AS VAL1
              , 'Distance' AS KEY2
              , CAST(TT.Distance AS float)AS VAL2
              , 'DistanceUnit' AS KEY3
              , CAST(TT.DistanceUnit AS float)AS VAL3
              , 'Intensity' AS KEY4
              , CAST(TT.Intensity AS float)AS VAL4
              , 'ActivityID' AS KEY5
              , CAST(TT.ActivityID AS float)AS VAL5
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerCardio'
  --the following where clause was added on 11/23/2015 as a result of BAD DATA from the PPT
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'mg/dL' AS UOM
              , 'HDL' AS KEY1
              , CAST(TT.HDL AS float)AS VAL1
              , 'LDL' AS KEY2
              , CAST(TT.LDL AS float)AS VAL2
              , 'Total' AS KEY3
              , CAST(TT.Total AS float)AS VAL3
              , 'Tri' AS KEY4
              , CAST(TT.Tri AS float)AS VAL4
              , 'Ratio' AS KEY5
              , CAST(TT.Ratio AS float)AS VAL5
              , 'Fasting' AS KEY6
              , CAST(TT.Fasting AS float)AS VAL6
              , 'VLDL' AS VLDL
              , CAST(TT.VLDL AS float)AS VAL7
              , 'NA' AS KEY8
              , NULL AS VAL8
              , 'NA' AS KEY9
              , NULL AS VAL9
              , 'NA' AS KEY10
              , NULL AS VAL10
              , TT.ItemCreatedBy
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
              , ISNULL(T.UniqueName , 'HFit_TrackerCholesterol')AS UniqueName
              , ISNULL(T.UniqueName , 'HFit_TrackerCholesterol')AS ColDesc
              , VENDOR.ItemID AS VendorID
              , VENDOR.VendorName
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Step' AS UOM
              , 'Steps' AS KEY1
              , CAST(TT.Steps AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , ISNULL(T.UniqueName , 'HFit_TrackerDailySteps')AS UniqueName
              , ISNULL(T.UniqueName , 'HFit_TrackerDailySteps')AS ColDesc
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerDailySteps'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Y/N' AS UOM
              , 'HasStretched' AS KEY1
              , CAST(TT.HasStretched AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , NULL AS IsProcessedForHa
              , 'Activity' AS TXTKEY1
              , TT.Activity AS TXTVAL1
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerFlexibility'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerFruits' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'CUP(8oz)' AS UOM
              , 'Cups' AS KEY1
              , CAST(TT.Cups AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerFruits'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'mmol/mol' AS UOM
              , 'Value' AS KEY1
              , CAST(TT.[Value] AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerHeight' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'inch' AS UOM
              , 'Height' AS KEY1
              , TT.Height AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
              , ISNULL(T.UniqueName , 'HFit_TrackerHeight')AS UniqueName
              , ISNULL(T.UniqueName , 'HFit_TrackerHeight')AS ColDesc
              , VENDOR.ItemID AS VendorID
              , VENDOR.VendorName
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Occurs' AS UOM
              , 'Times' AS KEY1
              , CAST(TT.Times AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Occurs' AS UOM
              , 'Times' AS KEY1
              , CAST(TT.Times AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
--w/o  distinct 00:02:07 @ 477120 PRD1
--with distinct 00:03:20 @ 475860 PRD1
--(03.20.2015) - (WDM) verified SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT 'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Y/N' AS UOM
              , 'TrackerDefID' AS KEY1
              , CAST(TT.TrackerDefID AS float)AS VAL1
              , 'YesNoValue' AS KEY2
              , CAST(TT.YesNoValue AS float)AS VAL2
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA-portion' AS UOM
              , 'Portions' AS KEY1
              , CAST(TT.Portions AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerMealPortions'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Y/N' AS UOM
              , 'FollowedPlan' AS KEY1
              , CAST(TT.FollowedPlan AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Occurs' AS UOM
              , 'Units' AS KEY1
              , CAST(TT.Units AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerRegularMeals'
  WHERE TT.EventDate <= '01/01/1960'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT 'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'BPM' AS UOM
              , 'HeartRate' AS KEY1
              , CAST(TT.HeartRate AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
--With DISTINCT 00:14 @ 40041
--With NO DISTINCT 00:14 @ 40060
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT 'HFit_TrackerShots' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Y/N' AS UOM
              , 'FluShot' AS KEY1
              , CAST(TT.FluShot AS float)AS VAL1
              , 'PneumoniaShot' AS KEY2
              , CAST(TT.PneumoniaShot AS float)AS VAL2
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerSitLess' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Occurs' AS UOM
              , 'Times' AS KEY1
              , CAST(TT.Times AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerSitLess'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'HR' AS UOM
              , 'DidFollow' AS KEY1
              , CAST(TT.DidFollow AS float)AS VAL1
              , 'HoursSlept' AS KEY2
              , TT.HoursSlept AS VAL2
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , NULL AS IsProcessedForHa
              , 'Techniques' AS TXTKEY1
              , TT.Techniques AS TXTVAL1
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerSleepPlan'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerStrength' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Y/N' AS UOM
              , 'HasTrained' AS KEY1
              , CAST(TT.HasTrained AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , NULL AS IsProcessedForHa
              , 'Activity' AS TXTKEY1
              , TT.Activity AS TXTVAL1
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerStrength'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerStress' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'gradient' AS UOM
              , 'Intensity' AS KEY1
              , CAST(TT.Intensity AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , NULL AS IsProcessedForHa
              , 'Awareness' AS TXTKEY1
              , TT.Awareness AS TXTVAL1
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerStress'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'gradient' AS UOM
              , 'HasPracticed' AS KEY1
              , CAST(TT.HasPracticed AS float)AS VAL1
              , 'Effectiveness' AS KEY2
              , CAST(TT.Effectiveness AS float)AS VAL2
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , NULL AS IsProcessedForHa
              , 'Activity' AS TXTKEY1
              , TT.Activity AS TXTVAL1
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerStressManagement'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'OZ' AS UOM
              , 'Ounces' AS KEY1
              , CAST(TT.Ounces AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA-portion' AS UOM
              , 'Portions' AS KEY1
              , CAST(TT.Portions AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
--Using DISTINCT PROD1 - 00:08:41 @ 40313
--Using DISTINCT PRD1 - 00:00:09 @ 45502
--Using NO DISTINCT PRD1 00:19 @ 40332
--Using DISTINCT PRD1 - 00:00:11 @ 44483
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT 'HFit_TrackerTests' AS TrackerNameAggregateTable
              , TT.ItemID
 		    , TT.EventDate 
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA' AS UOM
              , 'PSATest' AS KEY1
              , CAST(TT.PSATest AS float)AS VAL1
              , 'OtherExam' AS KEY1
              , CAST(TT.OtherExam AS float)AS VAL2
              , 'TScore' AS KEY3
              , CAST(TT.TScore AS float)AS VAL3
              , 'DRA' AS KEY4
              , CAST(TT.DRA AS float)AS VAL4
              , 'CotinineTest' AS KEY5
              , CAST(TT.CotinineTest AS float)AS VAL5
              , 'ColoCareKit' AS KEY6
              , CAST(TT.ColoCareKit AS float)AS VAL6
              , 'CustomTest' AS KEY7
              , CAST(TT.CustomTest AS float)AS VAL7
              , 'TSH' AS KEY8
              , CAST(TT.TSH AS float)AS VAL8
              , 'NA' AS KEY9
              , NULL AS VAL9
              , 'NA' AS KEY10
              , NULL AS VAL10
              , TT.ItemCreatedBy
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , NULL AS IsProcessedForHa
              , 'CustomDesc' AS TXTKEY1
              , TT.CustomDesc AS TXTVAL1
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate < '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'Y/N' AS UOM
              , 'WasTobaccoFree' AS KEY1
              , CAST(TT.WasTobaccoFree AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , NULL AS IsProcessedForHa
              , 'QuitAids' AS TXTKEY1
              , TT.QuitAids AS TXTVAL1
              , 'QuitMeds' AS TXTKEY2
              , TT.QuitMeds AS TXTVAL2
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerVegetables' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'CUP(8oz)' AS UOM
              , 'Cups' AS KEY1
              , CAST(TT.Cups AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerVegetables'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerWater' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'OZ' AS UOM
              , 'Ounces' AS KEY1
              , CAST(TT.Ounces AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerWater'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerWeight' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'LBS' AS UOM
              , 'Value' AS KEY1
              , TT.[Value] AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
       LEFT OUTER JOIN dbo.HFit_LKP_TrackerVendor AS VENDOR
            ON TT.VendorID = VENDOR.ItemID
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , TC.CollectionSourceName_Internal
              , TC.CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA-serving' AS UOM
              , 'Servings' AS KEY1
              , CAST(TT.Servings AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
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
              , NULL AS VendorID	--VENDOR.ItemID as VendorID
              , NULL AS VendorName --VENDOR.VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerWholeGrains'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerCotinine' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , NULL AS CollectionSourceName_Internal
              , NULL AS CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA' AS UOM
              , 'NicotineAssessment' AS KEY1
              , CAST(TT.NicotineAssessment AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
              , --VENDOR.ItemID AS VendorID ,
                --VENDOR.VendorName,
                NULL AS VendorID
              , NULL AS VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerCotinine'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , NULL AS CollectionSourceName_Internal
              , NULL AS CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA' AS UOM
              , 'PreventiveCare' AS KEY1
              , CAST(TT.PreventiveCare AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
              , --VENDOR.ItemID AS VendorID ,
                --VENDOR.VendorName,
                NULL AS VendorID
              , NULL AS VendorName
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
            ON T.AggregateTableName = 'HFit_TrackerPreventiveCare'
  WHERE TT.EventDate <= '01/01/1960'
UNION ALL
SELECT DISTINCT 'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
              , TT.ItemID
              , TT.EventDate
              , TT.IsProfessionallyCollected
              , TT.TrackerCollectionSourceID
              , TT.Notes
              , TT.UserID
              , NULL AS CollectionSourceName_Internal
              , NULL AS CollectionSourceName_External
              , 'MISSING' AS EventName
              , 'NA' AS UOM
              , 'TobaccoAttestation' AS KEY1
              , CAST(TT.TobaccoAttestation AS float)AS VAL1
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
              , CAST(TT.ItemCreatedWhen AS datetime)AS ItemCreatedWhen
              , TT.ItemModifiedBy
              , CAST(TT.ItemModifiedWhen AS datetime)AS ItemModifiedWhen
              , TT.IsProcessedForHa
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
              , --VENDOR.ItemID AS VendorID ,
                --VENDOR.VendorName,
                NULL AS VendorID
              , NULL AS VendorName
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
  WHERE TT.EventDate <= '01/01/1960';

GO

--  
--  
GO
PRINT '***** CREATED: view_EDW_TrackerCompositeDetails.sql';
GO

--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--enable TRIGGER trgSchemaMonitor ON DATABASE;

GO