create view dbo.view_HFit_TrackerCompositeDetails
as
--WDM 6/26/2014
--This view is needed by EDW in order to process the Tracker tables' data.
--As of now, the Tracker tables are representative of objects and that would cause 
--large volumes of ETL to be devloped and maintained. 
--This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
--Each tracker table to be processed into the EDW must be represented in this view.
--ALL new tracker tables need only be entered once using the structure contained within this view
--and the same EDW ETL should be able to process it.
--If there is a change to the strucuture of any one query in this view, then all have to be modified 
--to be support the change.
--NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
--be avoided here.

--USE:
--select * from view_HFit_TrackerCompositeDetails
--where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'

--Set statistics IO ON
--GO

SELECT 'BloodPressure' as TrackerCD
	  ,TT.[ItemID], [EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Systolic' as KEY1,[Systolic] as VAL1
	  ,'Diastolic' as KEY2,[Diastolic] as VAL2
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerBloodPressure] TT
	inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID	
	inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union 
SELECT 'BloodSugarAndGlucose' as TrackerCD
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Units' as KEY1,[Units] as VAL1
	  ,'FastingState' as KEY2, cast([FastingState] as int) as VAL2
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerBloodSugarAndGlucose] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'BMI' as TrackerCD
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
      ,'BMI' as KEY1,[BMI] as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerBMI] TT
      inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'BodyFat' as TrackerCD
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
      ,'Value' as KEY1,[Value] as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerBodyFat] TT
     inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
--******************************************************************************
SELECT 'BodyMeasurements' as TrackerCD
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'WaistInches' as KEY1, [WaistInches] as VAL1
      ,'HipInches' as KEY2, [HipInches] as VAL2
	  ,'ThighInches' as KEY3, [ThighInches] as VAL3
	  ,'ArmInches' as KEY4, [ArmInches] as VAL4
      ,'ChestInches' as KEY5, [ChestInches] as VAL5
      ,'CalfInches' as KEY6, [CalfInches] as VAL6
	  ,'NeckInches' as KEY7, [NeckInches] as VAL7
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerBodyMeasurements] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
--******************************************************************************
union
SELECT 'Cardio' as TrackerCD
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
      ,'Minutes' as KEY1, Minutes as VAL1
	  ,'Distance' as KEY2, [Distance] as VAL2
	  ,'DistanceUnit' as KEY3, [DistanceUnit] as VAL3
	  ,'Intensity' as KEY4, [Intensity] as VAL4
      ,'ActivityID' as KEY5, [ActivityID] as VAL5
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerCardio] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Cholesterol' as TrackerCD
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
      ,'HDL' as KEY1, [HDL] as VAL1
	  ,'LDL' as KEY2, [LDL] as VAL2
	  ,'Total' as KEY3, [Total] as VAL3
	  ,'Tri' as KEY4, [Tri] as VAL4
      ,'Ratio' as KEY5, [Ratio] as VAL5
      ,'Fasting' as KEY6, cast([Fasting] as int) as VAL6
	  ,'VLDL' as [VLDL], null as VAL7
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerCholesterol] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Cholesterol' as TrackerCD
   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Steps' as KEY1, [Steps] as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerDailySteps] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Flexibility' as TrackerCD
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	,'HasStretched' as KEY1, HasStretched as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].[HFit_TrackerFlexibility] TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
UNION
SELECT 'Fruits' as TrackerCD	  
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Cups' as KEY1, Cups as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerFruits TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'HbA1c' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Value' as KEY1, Value as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerHbA1c TT
      inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Height' as TrackerCD
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerHeight TT
      inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'HighFatFoods' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Times' as KEY1, Times as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerHighFatFoods TT
  inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'HighSodiumFoods' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Times' as KEY1, Times as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerHighSodiumFoods TT
     inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Instance_Tracker' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'TrackerDefID' as KEY1, TrackerDefID as VAL1
	  ,'YesNoValue' as KEY2, cast(YesNoValue as int) as VAL2
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerInstance_Tracker TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'MealPortions' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Portions' as KEY1, Portions as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerMealPortions TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'MedicalCarePlan' as TrackerCD
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'FollowedPlan' as KEY1, cast(FollowedPlan as int) as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerMedicalCarePlan TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'RegularMeals' as TrackerCD
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Units' as KEY1, Units as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerRegularMeals TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'RestingHeartRate' as TrackerCD
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'HeartRate' as KEY1, HeartRate as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerRestingHeartRate TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Shots' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'FluShot' as KEY1, cast( FluShot as int) as VAL1
	  ,'PneumoniaShot' as KEY2, cast(PneumoniaShot as int) as VAL2
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerShots TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'SitLess' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Times' as KEY1, Times as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerSitLess TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'SleepPlan' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'DidFollow' as KEY1, cast(DidFollow as int) as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerSleepPlan TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Strength' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'HasTrained' as KEY1, cast(HasTrained as int) as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerStrength TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Stress' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Intensity' as KEY1, Intensity as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerStress TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'StressManagement' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'HasPracticed' as KEY1, HasPracticed as VAL1
	  ,'Effectiveness' as KEY2, Effectiveness as VAL2
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerStressManagement TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'SugaryDrinks' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Ounces' as KEY1, Ounces as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerSugaryDrinks TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'SugaryFoods' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Portions' as KEY1, Portions as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerSugaryFoods TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Tests' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'PSATest' as KEY1, PSATest as VAL1
	  ,'OtherExam' as OtherExam, null as VAL2
	  ,'TScore' as KEY3, TScore as VAL3
	  ,'DRA' as KEY4, DRA as VAL4
      ,'CotinineTest' as CotinineTest, null as VAL5
      ,'ColoCareKit' as ColoCareKit, null as VAL6
	  ,'CustomTest' as CustomTest, null as VAL7
	  ,'TSH' as KEY8, TSH as VAL8
	  ,'NA' as KEY9, null as VAL9
	  ,'NA' as KEY10, null as VAL10
	  ,TT.[ItemCreatedBy],TT.[ItemCreatedWhen],TT.[ItemModifiedBy],TT.[ItemModifiedWhen]
      ,null as [IsProcessedForHa]
	  ,'CustomDesc' as TXTKEY1
	  ,CustomDesc as TXTVAL1
	  ,'NA' as TXTKEY2
	  ,null as TXTVAL2
	  ,'NA' as TXTKEY3
	  ,null as TXTVAL3
	  ,TT.ItemOrder
	  ,TT.ItemGuid
	  ,C.UserGuid, PP.MPI, PP.ClientCode 
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerTests TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'TobaccoFree' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'WasTobaccoFree' as KEY1, WasTobaccoFree as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerTobaccoFree TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Vegetables' as TrackerCD 
	   	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Cups' as KEY1, Cups as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerVegetables TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Water' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Ounces' as KEY1, Ounces as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerWater TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'Weight' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Value' as KEY1, Value as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerWeight TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
union
SELECT 'WholeGrains' as TrackerCD 
	  ,[ItemID] ,[EventDate],TT.[IsProfessionallyCollected],TT.[TrackerCollectionSourceID],[Notes],TT.[UserID]
	  ,CollectionSourceName_Internal,CollectionSourceName_External,'MISSING' as EventName
	  ,'Servings' as KEY1, Servings as VAL1
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
	  ,S.SiteGUID, ACCT.AccountID, ACCT.AccountCD
  FROM [dbo].HFit_TrackerWholeGrains TT
    inner join dbo.CMS_User C on C.UserID = TT.UserID
	inner join dbo.hfit_ppteligibility PP on TT.UserID = PP.userID
	inner join dbo.HFit_Account [ACCT] on PP.ClientCode = ACCT.AccountCD
	inner join dbo.CMS_Site S on ACCT.SiteID = S.SiteID
		inner join dbo.HFit_TrackerCollectionSource TC on TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
