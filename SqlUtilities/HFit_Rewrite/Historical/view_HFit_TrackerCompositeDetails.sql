USE [KenticoCMS_DEV]
GO

/****** Object:  View [dbo].[view_HFit_TrackerCompositeDetails]    Script Date: 9/16/2014 11:26:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[view_HFit_TrackerCompositeDetails]
as
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
--Column AggregateTableName will be NULL if the Tracker is not a member of the DISPLAYED Trackers. This 
--	allows us to capture all trackers, displayed or not.

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
--**************************************************************

--USE:
--select * from view_HFit_TrackerCompositeDetails
--where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'

--Set statistics IO ON
--GO

SELECT 'HFit_TrackerBloodPressure' as TrackerNameAggregateTable
	  ,TT.[ItemID], [EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mm/Hg' as UOM
	  ,'Systolic' as KEY1, cast([Systolic] as float) as VAL1
	  ,'Diastolic' as KEY2,cast([Diastolic] as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
	  ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'bp') as UniqueName
	  ,isnull(T.[UniqueName],'bp') as ColDesc
  FROM [dbo].[HFit_TrackerBloodPressure] TT
		inner join dbo.CMS_User C on C.UserID = TT.UserID
		inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
		inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
		inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID	
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		left outer JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBloodPressure'
union 
SELECT 'HFit_TrackerBloodSugarAndGlucose' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mmol/L' as UOM
	  ,'Units' as KEY1,cast([Units] as float) as VAL1
	  ,'FastingState' as KEY2, cast([FastingState] as float) as VAL2
      ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
	  ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'glucose') as UniqueName
	  , isnull(T.[UniqueName],'glucose') as ColDesc
  FROM [dbo].[HFit_TrackerBloodSugarAndGlucose] TT
		inner join dbo.CMS_User C on C.UserID = TT.UserID
		inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
		inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
		inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
union
SELECT 'HFit_TrackerBMI' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'kg/m2' as UOM
      ,'BMI' as KEY1,cast([BMI] as float) as VAL1
	  ,'NA' as KEY2, 0 as VAL2
      ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
	  ,null as IsProcessedForHa
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,TT.[ItemOrder]
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'HFit_TrackerBMI') as UniqueName
	  , isnull(T.[UniqueName],'HFit_TrackerBMI') as ColDesc
  FROM [dbo].[HFit_TrackerBMI] TT
		inner join dbo.CMS_User C on C.UserID = TT.UserID
		inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
		inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
		inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBMI'
union
SELECT 'HFit_TrackerBodyFat' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'PCT' as UOM
      ,'Value' as KEY1,cast([Value] as float) as VAL1
	  ,'NA' as KEY2, 0 as VAL2
      ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemModifiedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedWhen]
	  ,null as IsProcessedForHa
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'HFit_TrackerBodyFat') as UniqueName
	  , isnull(T.[UniqueName],'HFit_TrackerBodyFat') as ColDesc
  FROM [dbo].[HFit_TrackerBodyFat] TT
     inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBodyFat'
union
--******************************************************************************
SELECT 'HFit_TrackerBodyMeasurements' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Inch' as UOM
	  ,'WaistInches' as KEY1, cast([WaistInches] as float) as VAL1
      ,'HipInches' as KEY2, cast([HipInches] as float) as VAL2
	  ,'ThighInches' as KEY3, cast([ThighInches] as float) as VAL3
	  ,'ArmInches' as KEY4, cast([ArmInches]  as float) as VAL4
      ,'ChestInches' as KEY5, cast([ChestInches]  as float) as VAL5
      ,'CalfInches' as KEY6, cast([CalfInches]  as float) as VAL6
	  ,'NeckInches' as KEY7, cast([NeckInches]  as float) as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemModifiedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedWhen]
	  ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].[HFit_TrackerBodyMeasurements] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
--******************************************************************************
union
SELECT 'HFit_TrackerCardio' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA' as UOM
      ,'Minutes' as KEY1, cast([Minutes]  as float) as VAL1
	  ,'Distance' as KEY2, cast([Distance]  as float) as VAL2
	  ,'DistanceUnit' as KEY3, cast([DistanceUnit]  as float) as VAL3
	  ,'Intensity' as KEY4, cast([Intensity]  as float) as VAL4
      ,'ActivityID' as KEY5, cast([ActivityID]  as float) as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemModifiedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedWhen]
	  ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].[HFit_TrackerCardio] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerCardio'
union
SELECT 'HFit_TrackerCholesterol' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mg/dL' as UOM
      ,'HDL' as KEY1, cast([HDL]  as float) as VAL1
	  ,'LDL' as KEY2, cast([LDL]  as float) as VAL2
	  ,'Total' as KEY3, cast([Total]  as float) as VAL3
	  ,'Tri' as KEY4, cast([Tri]  as float) as VAL4
      ,'Ratio' as KEY5, cast([Ratio]  as float) as VAL5
      ,'Fasting' as KEY6, cast([Fasting] as float) as VAL6
	  ,'VLDL' as [VLDL], cast(VLDL as float ) as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
      ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName],'HFit_TrackerCholesterol') as UniqueName
	  , isnull(T.[UniqueName],'HFit_TrackerCholesterol') as ColDesc
  FROM [dbo].[HFit_TrackerCholesterol] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerCholesterol'
union
SELECT 'HFit_TrackerDailySteps' as TrackerNameAggregateTable
   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Step' as UOM
	  ,'Steps' as KEY1, cast([Steps]  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7      
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName], 'HFit_TrackerDailySteps') as UniqueName
	  , isnull(T.[UniqueName], 'HFit_TrackerDailySteps') as ColDesc
  FROM [dbo].[HFit_TrackerDailySteps] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerDailySteps'
union
SELECT 'HFit_TrackerFlexibility' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	,'HasStretched' as KEY1, cast(HasStretched  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Activity' as TXTKEY1
	  ,Activity as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].[HFit_TrackerFlexibility] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerFlexibility'
UNION
SELECT 'HFit_TrackerFruits' as TrackerNameAggregateTable	  
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'CUP(8oz)' as UOM
	  ,'Cups' as KEY1, cast(Cups  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerFruits TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerFruits'
union
SELECT 'HFit_TrackerHbA1c' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'mmol/mol' as UOM
	  ,'Value' as KEY1, cast([Value]  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerHbA1c TT
      inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHbA1c'
union
SELECT 'HFit_TrackerHeight' as TrackerNameAggregateTable
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'inch' as UOM
	  ,'Height' as KEY1, Height as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,TT.ItemOrder
	  ,TT.ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, isnull(T.[UniqueName], 'HFit_TrackerHeight') as UniqueName
	  , isnull(T.[UniqueName], 'HFit_TrackerHeight') as ColDesc
  FROM [dbo].HFit_TrackerHeight TT
      inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHeight'
union
SELECT 'HFit_TrackerHighFatFoods' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Times' as KEY1, cast(Times  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerHighFatFoods TT
  inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHighFatFoods'
union
SELECT 'HFit_TrackerHighSodiumFoods' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Times' as KEY1, cast(Times  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerHighSodiumFoods TT
     inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
union
SELECT 'HFit_TrackerInstance_Tracker' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'TrackerDefID' as KEY1, cast(TrackerDefID  as float) as VAL1
	  ,'YesNoValue' as KEY2, cast(YesNoValue as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerInstance_Tracker TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
union
SELECT 'HFit_TrackerMealPortions' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA-portion' as UOM
	  ,'Portions' as KEY1, cast(Portions  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerMealPortions TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerMealPortions'
union
SELECT 'HFit_TrackerMedicalCarePlan' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'FollowedPlan' as KEY1, cast(FollowedPlan as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerMedicalCarePlan TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
union
SELECT 'HFit_TrackerRegularMeals' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Units' as KEY1, cast(Units  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerRegularMeals TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerRegularMeals'
union
SELECT 'HFit_TrackerRestingHeartRate' as TrackerNameAggregateTable
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'BPM' as UOM
	  ,'HeartRate' as KEY1, cast(HeartRate  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerRestingHeartRate TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
union
SELECT 'HFit_TrackerShots' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'FluShot' as KEY1, cast( FluShot as float) as VAL1
	  ,'PneumoniaShot' as KEY2, cast(PneumoniaShot as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,TT.ItemOrder
	  ,TT.ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerShots TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerShots'
union
SELECT 'HFit_TrackerSitLess' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Occurs' as UOM
	  ,'Times' as KEY1, cast(Times  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSitLess TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSitLess'
union
SELECT 'HFit_TrackerSleepPlan' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'HR' as UOM
	  ,'DidFollow' as KEY1, cast(DidFollow as float) as VAL1
	  ,'HoursSlept' as KEY2, HoursSlept as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Techniques' as TXTKEY1
	  ,Techniques as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSleepPlan TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSleepPlan'
union
SELECT 'HFit_TrackerStrength' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'HasTrained' as KEY1, cast(HasTrained as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Activity' as TXTKEY1
	  ,Activity as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerStrength TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerStrength'
union
SELECT 'HFit_TrackerStress' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'gradient' as UOM
	  ,'Intensity' as KEY1, cast(Intensity  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Awareness' as TXTKEY1
	  ,Awareness as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerStress TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerStress'
union
SELECT 'HFit_TrackerStressManagement' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'gradient' as UOM
	  ,'HasPracticed' as KEY1, cast(HasPracticed  as float) as VAL1
	  ,'Effectiveness' as KEY2, cast(Effectiveness  as float) as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'Activity' as TXTKEY1
	  ,Activity as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerStressManagement TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerStressManagement'
union
SELECT 'HFit_TrackerSugaryDrinks' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'OZ' as UOM
	  ,'Ounces' as KEY1, cast(Ounces  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSugaryDrinks TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
union
SELECT 'HFit_TrackerSugaryFoods' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA-portion' as UOM
	  ,'Portions' as KEY1, cast(Portions  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerSugaryFoods TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerSugaryFoods'
union
SELECT 'HFit_TrackerTests' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA' as UOM
	  ,'PSATest' as KEY1, cast(PSATest  as float) as VAL1
	  ,'OtherExam' as KEY1, cast(OtherExam as float) as VAL2
	  ,'TScore' as KEY3, cast(TScore  as float) as VAL3
	  ,'DRA' as KEY4, cast(DRA  as float) as VAL4
      ,'CotinineTest' as KEY5, cast(CotinineTest as float) as VAL5
      ,'ColoCareKit' as KEY6, cast(ColoCareKit as float) as VAL6
	  ,'CustomTest' as KEY7, cast(CustomTest as float) as VAL7
	  ,'TSH' as KEY8, cast(TSH as float) as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'CustomDesc' as TXTKEY1, CustomDesc as TXTVAL1
	  ,'NA' as TXTKEY2, null as TXTVAL2
	  ,'NA' as TXTKEY3, null as TXTVAL3
	  ,TT.ItemOrder
	  ,TT.ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerTests TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerTests'
union
SELECT 'HFit_TrackerTobaccoFree' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'Y/N' as UOM
	  ,'WasTobaccoFree' as KEY1, cast(WasTobaccoFree as float) as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'QuitAids' as TXTKEY1
	  ,QuitAids as TXTVAL1
	  ,'QuitMeds' as TXTKEY2
	  ,QuitMeds as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerTobaccoFree TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerTobaccoFree'
union
SELECT 'HFit_TrackerVegetables' as TrackerNameAggregateTable 
	   	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'CUP(8oz)' as UOM
	  ,'Cups' as KEY1, cast(Cups  as float) as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerVegetables TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerVegetables'
union
SELECT 'HFit_TrackerWater' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'OZ' as UOM
	  ,'Ounces' as KEY1, cast(Ounces  as float) as VAL1
	  ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerWater TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerWater'
union
SELECT 'HFit_TrackerWeight' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'LBS' as UOM
	  ,'Value' as KEY1, [Value] as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,[IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerWeight TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerWeight'
union
SELECT 'HFit_TrackerWholeGrains' as TrackerNameAggregateTable 
	  ,TT.[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName, 'NA-serving' as UOM
	  ,'Servings' as KEY1, cast(Servings  as float) as VAL1
	   ,'NA' as KEY2, null as VAL2
	  ,'NA' as KEY3, null as VAL3
	  ,'NA' as KEY4, null as VAL4
      ,'NA' as KEY5, null as VAL5
      ,'NA' as KEY6, null as VAL6
	  ,'NA' as KEY7, null as VAL7
	  ,'NA' as KEY8, null as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'NA' as TXTKEY1
	  ,null as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,null as ItemOrder
	  ,null as ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD, T.IsAvailable, T.IsCustom, T.[UniqueName]
	  , T.[UniqueName] as ColDesc
  FROM [dbo].HFit_TrackerWholeGrains TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
		LEFT OUTER JOIN dbo.[HFIT_Tracker] T on T.AggregateTableName = 'HFit_TrackerWholeGrains'
		

GO


