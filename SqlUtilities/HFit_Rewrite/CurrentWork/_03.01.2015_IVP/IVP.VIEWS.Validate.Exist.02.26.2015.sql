
GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_Awards') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_Awards , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW view_EDW_Awards
AS

	 --*************************************************************************************
	 -- 2.3.2015 : WDM - Created the initial view for Awards (HEW)
	 -- 2.3.2015 : WDM - Laura B. had objections as to how the data was pulled, Nate agreed
	 --					to look at it again.
	 --*************************************************************************************

	 SELECT
			AWARD.*
		  , ATYPE.AwardType
		  , ATRIGGER.RewardTriggerLKPName
		  , ATRIGGER.RewardTriggerRewardActivityLKPID
		  , ATRIGGER.RewardTriggerLKPDisplayName
		  , ATRIGGER.HESCode
	   FROM HFit_HES_Award AS AWARD
				JOIN HFit_LKP_RewardTrigger AS ATRIGGER
					ON AWARD.RewardTriggerID = ATRIGGER.RewardTriggerLKPID
				JOIN HFit_LKP_HES_AwardType AS ATYPE
					ON AWARD.HESAwardID = ATYPE.itemID;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_Awards found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_BioMetrics') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_BioMetrics , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW dbo.view_EDW_BioMetrics
AS

	 --*****************************************************************************************************************************************
	 --************** TEST Criteria and Results for view_EDW_BioMetrics ************************************************************************
	 --INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES(''XX'',''2013-12-01'',17  )  
	 --NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
	 --GO	--Tested by wdm on 11.21.2014
	 -- select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9
	 --select * from view_EDW_BioMetrics	 where AccountCD = ''peabody'' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < ''2013-12-01''	: 9 
	 --select * from view_Hfit_BioMetrics where AccountCD = ''peabody'' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < ''2013-12-01''	: 9 
	 --select * from view_EDW_BioMetrics	where AccountCD = ''peabody'' and ItemCreatedWhen < ''2013-12-01 00:00:00.000''		: 7 
	 --select * from view_EDW_BioMetrics	where AccountCD = ''peaboOK dy'' and EventDate < ''2013-12-01 00:00:00.000''		: 9 
	 --select count(*) from view_EDW_BioMetrics		--NO REJECT FILTER : 136348
	 --select count(*) from view_EDW_BioMetrics		--REJECT FILTER ON : 136339 == 9 GOOD TEST
	 --select count(*) from view_Hfit_BioMetrics	:136393
	 --select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348
	 --NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014
	 --truncate table EDW_BiometricViewRejectCriteria
	 --INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES(''peabody'',''2013-12-01'',-1)         
	 --NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
	 --GO	--Tested by wdm on 11.21.2014
	 --select * from view_EDW_BioMetrics where ItemCreatedWhen < ''2013-12-01'' and AccountCD = ''peabody'' returns 1034
	 --		so the number should be 43814 - 1034 = 42780 with AccountCD = ''peabody'' and ItemCreatedWhen = ''2014-03-19''
	 --		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	 --GO	--Tested by wdm on 11.21.2014
	 --select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < ''2014-03-19'' returns 22,974
	 --		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = ''2014-03-19''
	 --		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	 --GO	--Tested by wdm on 11.21.2014
	 --	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.
	 -- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
	 -- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
	 -- 12.25.2014 - Added the EDW_BiometricViewRejectCriteria to allow selective rejection of historical records
	 -- 01.19.2014 - Prepared for Simpson Willams
	 --*****************************************************************************************************************************************

	 SELECT DISTINCT

	 --HFit_UserTracker

			HFUT.UserID
   , cus.UserSettingsUserGUID AS UserGUID
   , cus.HFitUserMpiNumber
   , cus2.SiteID
   , cs.SiteGUID
   , NULL AS CreatedDate
   , NULL AS ModifiedDate
   , NULL AS Notes
   , NULL AS IsProfessionallyCollected
   , NULL AS EventDate
   , ''Not Build Yet'' AS EventName

			--HFit_TrackerWeight

   , NULL AS PPTWeight

			--HFit_TrackerHbA1C

   , NULL AS PPTHbA1C

			--HFit_TrackerCholesterol

   , NULL AS Fasting
   , NULL AS HDL
   , NULL AS LDL
   , NULL AS Ratio
   , NULL AS Total
   , NULL AS Triglycerides

			--HFit_TrackerBloodSugarandGlucose

   , NULL AS Glucose
   , NULL AS FastingState

			--HFit_TrackerBloodPressure

   , NULL AS Systolic
   , NULL AS Diastolic

			--HFit_TrackerBodyFat

   , NULL AS PPTBodyFatPCT

			--HFit_TrackerBMI

   , NULL AS BMI

			--HFit_TrackerBodyMeasurements

   , NULL AS WaistInches
   , NULL AS HipInches
   , NULL AS ThighInches
   , NULL AS ArmInches
   , NULL AS ChestInches
   , NULL AS CalfInches
   , NULL AS NeckInches

			--HFit_TrackerHeight

   , NULL AS Height

			--HFit_TrackerRestingHeartRate

   , NULL AS HeartRate
   ,

			--HFit_TrackerShots

			NULL AS FluShot
   , NULL AS PneumoniaShot

			--HFit_TrackerTests

   , NULL AS PSATest
   , NULL AS OtherExam
   , NULL AS TScore
   , NULL AS DRA
   , NULL AS CotinineTest
   , NULL AS ColoCareKit
   , NULL AS CustomTest
   , NULL AS CustomDesc
   , NULL AS CollectionSource
   , HFA.AccountID
   , HFA.AccountCD
   , CASE
		 WHEN HFUT.ItemCreatedWhen = COALESCE (HFUT.ItemModifiedWhen, hfut.ItemCreatedWhen) 
		 THEN ''I''
		 ELSE ''U''
	 END AS ChangeType
   , HFUT.ItemCreatedWhen
   , HFUT.ItemModifiedWhen
   , 0 AS TrackerCollectionSourceID
   , HFUT.itemid
   , ''HFit_UserTracker'' AS TBL
   , NULL AS VendorID

			--VENDOR.ItemID as VendorID

   , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_UserTracker AS HFUT
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON hfut.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID

	   --left outer join HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE HFUT.ItemCreatedWhen < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND HFUT.ItemCreatedWhen < ItemCreatedWhen) 

			 --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria

		 AND HFUT.ItemCreatedWhen IS NOT NULL

	 --Add per Robert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			hftw.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTW.ItemCreatedWhen
		  , HFTW.ItemModifiedWhen
		  , HFTW.Notes
		  , HFTW.IsProfessionallyCollected
		  , HFTW.EventDate
		  , ''Not Build Yet'' AS EventName
		  , hftw.Value AS PPTWeight
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTW.ItemCreatedWhen = COALESCE (HFTW.ItemModifiedWhen, HFTW.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTW.ItemCreatedWhen
		  , HFTW.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTW.itemid
		  , ''HFit_TrackerWeight'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerWeight AS HFTW
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTW.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTW.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria	  

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTW.EventDate, HFTW.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTW.EventDate, HFTW.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTW.ItemCreatedWhen IS NOT NULL
		   OR HFTW.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014			

	 UNION ALL
	 SELECT
			HFTHA.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTHA.ItemCreatedWhen
		  , HFTHA.ItemModifiedWhen
		  , HFTHA.Notes
		  , HFTHA.IsProfessionallyCollected
		  , HFTHA.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , HFTHA.Value AS PPTHbA1C
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTHA.ItemCreatedWhen = COALESCE (HFTHA.ItemModifiedWhen, HFTHA.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTHA.ItemCreatedWhen
		  , HFTHA.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTHA.itemid
		  , ''HFit_TrackerHbA1c'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerHbA1c AS HFTHA
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTHA.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTHA.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTHA.EventDate, HFTHA.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTHA.EventDate, HFTHA.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTHA.ItemCreatedWhen IS NOT NULL
		   OR HFTHA.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTC.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTC.ItemCreatedWhen
		  , HFTC.ItemModifiedWhen
		  , HFTC.Notes
		  , HFTC.IsProfessionallyCollected
		  , HFTC.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , HFTC.Fasting
		  , HFTC.HDL
		  , HFTC.LDL
		  , HFTC.Ratio
		  , HFTC.Total
		  , HFTC.Tri
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTC.ItemCreatedWhen = COALESCE (HFTC.ItemModifiedWhen, HFTC.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTC.ItemCreatedWhen
		  , HFTC.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTC.itemid
		  , ''HFit_TrackerCholesterol'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerCholesterol AS HFTC
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTC.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTC.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTC.EventDate, HFTC.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTC.EventDate, HFTC.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTC.ItemCreatedWhen IS NOT NULL
		   OR HFTC.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBSAG.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBSAG.ItemCreatedWhen
		  , HFTBSAG.ItemModifiedWhen
		  , HFTBSAG.Notes
		  , HFTBSAG.IsProfessionallyCollected
		  , HFTBSAG.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBSAG.Units
		  , HFTBSAG.FastingState
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBSAG.ItemCreatedWhen = COALESCE (HFTBSAG.ItemModifiedWhen, HFTBSAG.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTBSAG.ItemCreatedWhen
		  , HFTBSAG.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBSAG.itemid
		  , ''HFit_TrackerBloodSugarAndGlucose'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBSAG.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBSAG.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBSAG.EventDate, HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBSAG.EventDate, HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBSAG.ItemCreatedWhen IS NOT NULL
		   OR HFTBSAG.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBP.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBP.ItemCreatedWhen
		  , HFTBP.ItemModifiedWhen
		  , HFTBP.Notes
		  , HFTBP.IsProfessionallyCollected
		  , HFTBP.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBP.Systolic
		  , HFTBP.Diastolic
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBP.ItemCreatedWhen = COALESCE (HFTBP.ItemModifiedWhen, HFTBP.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTBP.ItemCreatedWhen
		  , HFTBP.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBP.itemid
		  , ''HFit_TrackerBloodPressure'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodPressure AS HFTBP
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBP.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBP.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBP.EventDate, HFTBP.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBP.EventDate, HFTBP.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBP.ItemCreatedWhen IS NOT NULL
		   OR HFTBP.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBF.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBF.ItemCreatedWhen
		  , HFTBF.ItemModifiedWhen
		  , HFTBF.Notes
		  , HFTBF.IsProfessionallyCollected
		  , HFTBF.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBF.Value AS PPTBodyFatPCT
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBF.ItemCreatedWhen = COALESCE (HFTBF.ItemModifiedWhen, HFTBF.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTBF.ItemCreatedWhen
		  , HFTBF.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBF.itemid
		  , ''HFit_TrackerBodyFat'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyFat AS HFTBF
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBF.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBF.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBF.EventDate, HFTBF.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBF.EventDate, HFTBF.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBF.ItemCreatedWhen IS NOT NULL
		   OR HFTBF.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTB.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTB.ItemCreatedWhen
		  , HFTB.ItemModifiedWhen
		  , HFTB.Notes
		  , HFTB.IsProfessionallyCollected
		  , HFTB.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTB.BMI
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTB.ItemCreatedWhen = COALESCE (HFTB.ItemModifiedWhen, HFTB.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTB.ItemCreatedWhen
		  , HFTB.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTB.itemid
		  , ''HFit_TrackerBMI'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBMI AS HFTB
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTB.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTB.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTB.EventDate, HFTB.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTB.EventDate, HFTB.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTB.ItemCreatedWhen IS NOT NULL
		   OR HFTB.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTBM.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBM.ItemCreatedWhen
		  , HFTBM.ItemModifiedWhen
		  , HFTBM.Notes
		  , HFTBM.IsProfessionallyCollected
		  , HFTBM.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTBM.WaistInches
		  , HFTBM.HipInches
		  , HFTBM.ThighInches
		  , HFTBM.ArmInches
		  , HFTBM.ChestInches
		  , HFTBM.CalfInches
		  , HFTBM.NeckInches
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTBM.ItemCreatedWhen = COALESCE (HFTBM.ItemModifiedWhen, HFTBM.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTBM.ItemCreatedWhen
		  , HFTBM.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBM.itemid
		  , ''HFit_TrackerBodyMeasurements'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyMeasurements AS HFTBM
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTBM.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTBM.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBM.EventDate, HFTBM.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBM.EventDate, HFTBM.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBM.ItemCreatedWhen IS NOT NULL
		   OR HFTBM.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTH.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTH.ItemCreatedWhen
		  , HFTH.ItemModifiedWhen
		  , HFTH.Notes
		  , HFTH.IsProfessionallyCollected
		  , HFTH.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTH.Height
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTH.ItemCreatedWhen = COALESCE (HFTH.ItemModifiedWhen, HFTH.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTH.ItemCreatedWhen
		  , HFTH.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTH.itemid
		  , ''HFit_TrackerHeight'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerHeight AS HFTH
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTH.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTH.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTH.EventDate, HFTH.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTH.EventDate, HFTH.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTH.ItemCreatedWhen IS NOT NULL
		   OR HFTH.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTRHR.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTRHR.ItemCreatedWhen
		  , HFTRHR.ItemModifiedWhen
		  , HFTRHR.Notes
		  , HFTRHR.IsProfessionallyCollected
		  , HFTRHR.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTRHR.HeartRate
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTRHR.ItemCreatedWhen = COALESCE (HFTRHR.ItemModifiedWhen, HFTRHR.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTRHR.ItemCreatedWhen
		  , HFTRHR.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTRHR.itemid
		  , ''HFit_TrackerRestingHeartRate'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerRestingHeartRate AS HFTRHR
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTRHR.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTRHR.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTRHR.EventDate, HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTRHR.EventDate, HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTRHR.ItemCreatedWhen IS NOT NULL
		   OR HFTRHR.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTS.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTS.ItemCreatedWhen
		  , HFTS.ItemModifiedWhen
		  , HFTS.Notes
		  , HFTS.IsProfessionallyCollected
		  , HFTS.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTS.FluShot
		  , HFTS.PneumoniaShot
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTS.ItemCreatedWhen = COALESCE (HFTS.ItemModifiedWhen, HFTS.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTS.ItemCreatedWhen
		  , HFTS.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTS.itemid
		  , ''HFit_TrackerShots'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS HFTS
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTS.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTS.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTS.EventDate, HFTS.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTS.EventDate, HFTS.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTS.ItemCreatedWhen IS NOT NULL
		   OR HFTS.EventDate IS NOT NULL) 

	 --Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT
			HFTT.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTT.ItemCreatedWhen
		  , HFTT.ItemModifiedWhen
		  , HFTT.Notes
		  , HFTT.IsProfessionallyCollected
		  , HFTT.EventDate
		  , ''Not Build Yet'' AS EventName
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , NULL
		  , HFTT.PSATest
		  , HFTT.OtherExam
		  , HFTT.TScore
		  , HFTT.DRA
		  , HFTT.CotinineTest
		  , HFTT.ColoCareKit
		  , HFTT.CustomTest
		  , HFTT.CustomDesc
		  , HFTCS.CollectionSourceName_External
		  , HFA.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN HFTT.ItemCreatedWhen = COALESCE (HFTT.ItemModifiedWhen, HFTT.ItemCreatedWhen) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFTT.ItemCreatedWhen
		  , HFTT.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTT.itemid
		  , ''HFit_TrackerTests'' AS TBL
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS HFTT
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
					ON HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON HFTT.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON HFTT.VendorID = VENDOR.ItemID

	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria

	   WHERE CS.SITEID NOT IN (
							   SELECT
									  SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTT.EventDate, HFTT.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT
										  AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTT.EventDate, HFTT.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTT.ItemCreatedWhen IS NOT NULL
		   OR HFTT.EventDate IS NOT NULL) ;

--Add per RObert and Laura 12.4.2014
--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_BioMetrics found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_BiometricViewRejectCriteria') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_BiometricViewRejectCriteria , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW view_EDW_BiometricViewRejectCriteria
AS
	 SELECT
			AccountCD
		  , ItemCreatedWhen
		  , SiteID
		  , RejectGUID
	   FROM dbo.EDW_BiometricViewRejectCriteria;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_BiometricViewRejectCriteria found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_ClientCompany') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_ClientCompany , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '


CREATE VIEW [dbo].[view_EDW_ClientCompany]
AS
--************************************************************
--One of the few views in the system that is not nested. 
--It combines the Account, Site and Company data.
--Last Tested: 09/04/2014 WDM
--WDM 9.10.2014 - verified dates were available to the EDW
--************************************************************
	SELECT
		hfa.AccountID
		, HFA.AccountCD
		, HFA.AccountName
		, HFA.ItemCreatedWhen as AccountCreated
		, HFA.ItemModifiedWhen as AccountModified
		, HFA.ItemGUID AccountGUID
		, CS.SiteID
		, CS.SiteGUID
		, CS.SiteLastModified
		, HFC.CompanyID
		, HFC.ParentID
		, HFC.CompanyName
		, HFC.CompanyShortName
		, HFC.CompanyStartDate
		, HFC.CompanyEndDate
		, HFC.CompanyStatus
		, CASE	WHEN CAST(hfa.ItemCreatedWhen AS DATE) = CAST(HFA.ItemModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, NULL AS CompanyCreated
		, NULL AS CompanyModified
	FROM
		dbo.HFit_Account AS HFA
	INNER JOIN dbo.CMS_Site AS CS ON HFA.SiteID = cs.SiteID
	LEFT OUTER JOIN dbo.HFit_Company AS HFC ON HFA.AccountID = hfc.AccountID






';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_ClientCompany found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_Coaches') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_Coaches , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--****************************************************
-- Verified last mod date available to EDW 9.10.2014
--****************************************************
CREATE VIEW [dbo].[view_EDW_Coaches]

AS

SELECT distinct
    cu.UserGUID
   ,cs.SiteGUID
   ,HFA.AccountID
   ,HFA.AccountCD
   ,CoachID
   ,hfc.LastName
   ,hfc.FirstName
   ,hfc.StartDate
   ,hfc.Phone
   ,hfc.email
   ,hfc.Supervisor
   ,hfc.SuperCoach
   ,hfc.MaxParticipants
   ,hfc.Inactive
   ,hfc.MaxRiskLevel
   ,hfc.Locked
   ,hfc.TimeLocked
   ,hfc.terminated
   ,hfc.APMaxParticipants
   ,hfc.RNMaxParticipants
   ,hfc.RNPMaxParticipants
   ,hfc.Change_Type
   ,hfc.Last_Update_Dt
FROM
    dbo.HFit_Coaches AS HFC
LEFT OUTER JOIN dbo.CMS_User AS CU ON hfc.KenticoUserID = cu.UserID
LEFT OUTER JOIN dbo.CMS_UserSite AS CUS ON cu.userid = cus.UserID
LEFT OUTER JOIN dbo.CMS_Site AS CS ON CS.SiteID = CUS.SiteID
LEFT OUTER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_Coaches found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_CoachingDefinition') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_CoachingDefinition , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '

--GRANT SELECT
--	ON [dbo].[view_EDW_CoachingDefinition]
--	TO [EDWReader_PRD]
--GO


CREATE VIEW [dbo].[view_EDW_CoachingDefinition]
AS
--********************************************************************************************************
--8/7/2014 - added DocumentGuid 
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
--11.17.2014 - (wdm) John Croft found an issue with multiple languages being returned.
--		View_EDW_CoachingDefinition pulls its data from a nested view View_HFit_Tobacco_Goal_Joined. I added 
--		a Document Culture filter on the SELECT STATEMENT pulling the data from View_HFit_Tobacco_Goal_Joined.
--		In LAB DB, when the view is executed W/O the filter, I get 90 rows. When executed with the filter, I 
--		get 89 rows. This would indicate the filter can be applied at the SELCT statement level. The view has 
--		the change applied and is ready to be regenerated. Also, I needed to add a language filter to 
--		View_HFit_Goal_Joined. Additionally, I allow the view to return the Document Culture as a column so 
--		that we can see the associated language. This can be removed if not wanted, but for troubleshooting 
--		it is useful.
--********************************************************************************************************
SELECT
	GJ.GoalID
	, GJ.DocumentGuid	--, GJ.DocumentID
	, GJ.NodeSiteID
	, cs.SiteGUID
	, GJ.GoalImage
	, GJ.Goal
	, dbo.udf_StripHTML(GJ.GoalText) GoalText --
	, dbo.udf_StripHTML(GJ.GoalSummary) GoalSummary --
	, GJ.TrackerAssociation  --GJ.TrackerAssociation
	, GJ.GoalFrequency
	, HFLF.FrequencySingular
	, HFLF.FrequencyPlural
	, GJ.GoalUnitOfMeasure
	, HFLUOM.UnitOfMeasure
	, GJ.GoalDirection
	, GJ.GoalPrecision
	, GJ.GoalAbsoluteMin
	, GJ.GoalAbsoluteMax
	, dbo.udf_StripHTML(GJ.SetGoalText) SetGoalText --
	, dbo.udf_StripHTML(GJ.HelpText) HelpText --
	, GJ.EvaluationType
	, GJ.CatalogDisplay
	, GJ.AllowModification
	, GJ.ActivityText
	, dbo.udf_StripHTML(GJ.SetGoalModifyText) SetgoalModifyText
	, GJ.IsLifestyleGoal
	, GJ.CodeName
	, CASE	WHEN CAST(gj.DocumentCreatedWhen AS DATE) = CAST(gj.DocumentModifiedWhen AS DATE)
			THEN ''I''
			ELSE ''U''
		END AS ChangeType
	, GJ.DocumentCreatedWhen
	, GJ.DocumentModifiedWhen
	, GJ.DocumentCulture
FROM
	(
		SELECT
			VHFGJ.GoalID
			, VHFGJ.DocumentGuid	--, VHFGJ.DocumentID
			, VHFGJ.NodeSiteID
			, VHFGJ.GoalImage
			, VHFGJ.Goal
			, VHFGJ.GoalText
			, VHFGJ.GoalSummary
			, VHFGJ.TrackerNodeGUID as TrackerAssociation  --VHFGJ.TrackerAssociation
			, VHFGJ.GoalFrequency
			, VHFGJ.GoalUnitOfMeasure
			, VHFGJ.GoalDirection
			, VHFGJ.GoalPrecision
			, VHFGJ.GoalAbsoluteMin
			, VHFGJ.GoalAbsoluteMax
			, VHFGJ.SetGoalText
			, VHFGJ.HelpText
			, VHFGJ.EvaluationType
			, VHFGJ.CatalogDisplay
			, VHFGJ.AllowModification
			, VHFGJ.ActivityText
			, VHFGJ.SetGoalModifyText
			, VHFGJ.IsLifestyleGoal
			, VHFGJ.CodeName
			, VHFGJ.DocumentCreatedWhen
			, VHFGJ.DocumentModifiedWhen
			, VHFGJ.DocumentCulture
		FROM
			dbo.View_HFit_Goal_Joined AS VHFGJ
			where VHFGJ.DocumentCulture = ''en-US''
		UNION ALL
		SELECT
			VHFTGJ.GoalID
			, VHFTGJ.DocumentGuid	--, VHFTGJ.DocumentID
			, VHFTGJ.NodeSiteID
			, VHFTGJ.GoalImage
			, VHFTGJ.Goal
			, NULL AS GoalText
			, VHFTGJ.GoalSummary
			, VHFTGJ.TrackerNodeGUID as TrackerAssociation  --VHFTGJ.TrackerAssociation
			, VHFTGJ.GoalFrequency
			, NULL AS GoalUnitOfMeasure
			, VHFTGJ.GoalDirection
			, VHFTGJ.GoalPrecision
			, VHFTGJ.GoalAbsoluteMin
			, VHFTGJ.GoalAbsoluteMax
			, NULL AS SetGoalText
			, NULL AS HelpText
			, VHFTGJ.EvaluationType
			, VHFTGJ.CatalogDisplay
			, VHFTGJ.AllowModification
			, VHFTGJ.ActivityText
			, NULL SetGoalModifyText
			, VHFTGJ.IsLifestyleGoal
			, VHFTGJ.CodeName
			, VHFTGJ.DocumentCreatedWhen
			, VHFTGJ.DocumentModifiedWhen
			, VHFTGJ.DocumentCulture
		FROM
			dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ
			where VHFTGJ.DocumentCulture = ''en-US''
	) AS GJ
LEFT OUTER JOIN dbo.HFit_LKP_UnitOfMeasure AS HFLUOM ON GJ.GoalUnitOfMeasure = HFLUOM.UnitOfMeasureID
LEFT OUTER JOIN dbo.HFit_LKP_Frequency AS HFLF ON GJ.GoalFrequency = HFLF.FrequencyID
INNER JOIN cms_site AS CS ON gj.nodesiteid = cs.siteid
--INNER JOIN cms_site AS CS ON gj.siteguid = cs.siteguid
WHERE
	gj.DocumentCreatedWhen IS NOT NULL
	AND gj.DocumentModifiedWhen IS NOT NULL 

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_CoachingDefinition found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_CoachingDetail') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_CoachingDetail , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail]]
--	TO [EDWReader_PRD]
--GO

/******************************************************************
 TEST Queries
select * from [view_EDW_CoachingDetail]
select * from [view_EDW_CoachingDetail] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail]
******************************************************************/

CREATE VIEW dbo.view_EDW_CoachingDetail
AS

	 --********************************************************************************************
	 --8/7/2014 - added and commented out DocumentGuid in case needed later
	 --8/8/2014 - Generated corrected view in DEV (WDM)
	 -- Verified last mod date available to EDW 9.10.2014
	 -- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923
	 -- 01.06.2014 (WDM) Tested with team B and found that the data was being returned. Stipulating that 
	 --					we converted the inner join to left outer join dbo.HFit_GoalOutcome. This 
	 --					allows data to be returned with the meaning that if NULL HFGO.EvaluationDate
	 --					is returned, the GOAL may exist without any input/update from the coach or
	 --					PPT
	 -- 01.07.2014 (WDM) This also takes care of 47976
	 --********************************************************************************************

	 SELECT
			HFUG.ItemID
		  , HFUG.ItemGUID
		  , GJ.GoalID
		  , HFUG.UserID
		  , cu.UserGUID
		  , cus.HFitUserMpiNumber
		  , cs.SiteGUID
		  , hfa.AccountID
		  , hfa.AccountCD
		  , hfa.AccountName
		  , HFUG.IsCreatedByCoach
		  , HFUG.BaselineAmount
		  , HFUG.GoalAmount
		  , NULL AS DocumentID
		  , HFUG.GoalStatusLKPID
		  , HFLGS.GoalStatusLKPName
		  , HFUG.EvaluationStartDate
		  , HFUG.EvaluationEndDate
		  , HFUG.GoalStartDate
		  , HFUG.CoachDescription
		  , HFGO.EvaluationDate
		  , HFGO.Passed
		  , HFGO.WeekendDate
		  , CASE
				WHEN CAST (HFUG.ItemCreatedWhen AS date) = CAST (HFUG.ItemModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFUG.ItemCreatedWhen
		  , HFUG.ItemModifiedWhen
		  , GJ.NodeGUID
		  , HFUG.CloseReasonLKPID
		  , GRC.CloseReason
	   FROM dbo.HFit_UserGoal AS HFUG WITH (NOLOCK) 
				INNER JOIN (
							SELECT
								   VHFGJ.GoalID
								 , VHFGJ.NodeID
								 , VHFGJ.NodeGUID
								 , VHFGJ.DocumentCulture
								 , VHFGJ.DocumentGuid
								 , VHFGJ.DocumentModifiedWhen

							--WDM added 9.10.2014

							  FROM dbo.View_HFit_Goal_Joined AS VHFGJ WITH (NOLOCK) 
							UNION ALL
							SELECT
								   VHFTGJ.GoalID
								 , VHFTGJ.NodeID
								 , VHFTGJ.NodeGUID
								 , VHFTGJ.DocumentCulture
								 , VHFTGJ.DocumentGuid
								 , VHFTGJ.DocumentModifiedWhen

							--WDM added 9.10.2014

							  FROM dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ WITH (NOLOCK)) AS GJ
					ON hfug.NodeID = gj.NodeID
				   AND GJ.DocumentCulture = ''en-us''
				LEFT OUTER JOIN dbo.HFit_GoalOutcome AS HFGO WITH (NOLOCK) 
					ON HFUG.ItemID = HFGO.UserGoalItemID
				INNER JOIN dbo.HFit_LKP_GoalStatus AS HFLGS WITH (NOLOCK) 
					ON HFUG.GoalStatusLKPID = HFLGS.GoalStatusLKPID
				INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
					ON HFUG.UserID = cu.UserID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON CU.UserGUID = CUS.UserSettingsUserGUID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cu.UserID = CUS2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = hfa.SiteID
				LEFT OUTER JOIN HFit_LKP_GoalCloseReason AS GRC
					ON GRC.CloseReasonID = HFUG.CloseReasonLKPID;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_CoachingDetail found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_EDW_TEST_DEL_DelAudit') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_EDW_TEST_DEL_DelAudit , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW view_EDW_EDW_TEST_DEL_DelAudit AS  SELECT * from EDW_TEST_DEL_DelAudit';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_EDW_TEST_DEL_DelAudit found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_Eligibility') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_Eligibility , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--select top 100 * from view_EDW_Eligibility

CREATE VIEW view_EDW_Eligibility
AS

	 --*************************************************************************************************************************
	 --view_EDW_Eligibility is the starting point for the EDW to pull data. As of 11.11.2014, all columns
	 --within the view are just a starting point. We will work with the EDW team to define and pull all the data
	 --they are needing.
	 --A PPT becomes eligible to participate through the Rules
	 --Rules of Engagement:
	 --00: ROLES are tied to a feature ; if the ROLE is not on a Kentico page - you don''t see it.
	 --01: When the Kentico group rebuild executes, all is lost. There is no retained MEMBER/User history.
	 --02: The group does not track when a member enters or leaves a group, simply that they exist in that group.
	 --NOTE: Any data deemed necessary can be added to this view for the EDW
	 --01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
	 --	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
	 --	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
	 --02.02.2015 (WDM) #44691 - Added the Site ID, Site Name, and Site Display Name to the returned cols of data
	 --	  per the conversation with John C. earlier this morning.
	 --02.05.2015 (WDM) #44691 - Added the Site GUID
	 --*************************************************************************************************************************

	 SELECT
			ROLES.RoleID
		  , ROLES.RoleName
		  , ROLES.RoleDescription
		  , ROLES.RoleGUID
		  , MemberROLE.MembershipID
		  , MemberROLE.RoleID AS MbrRoleID
		  , MemberSHIP.UserID AS MemberShipUserID
		  , MemberSHIP.ValidTo AS MemberShipValidTo
		  , USERSET.HFitUserMpiNumber
		  , USERSET.UserNickName
		  , USERSET.UserDateOfBirth
		  , USERSET.UserGender
		  , PPT.PPTID
		  , PPT.FirstName
		  , PPT.LastName
		  , PPT.City
		  , PPT.State
		  , PPT.PostalCode
		  , PPT.UserID AS PPTUserID
		  , GRPMBR.ContactGroupMemberContactGroupID
		  , GRPMBR.ContactGroupMemberRelatedID
		  , GRPMBR.ContactGroupMemberType
		  , GRP.ContactGroupName
		  , GRP.ContactGroupDisplayName
		  , PPT.ClientCode
		  , ACCT.AccountName
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , ACCT.SiteID
		  , SITE.SiteGUID
		  , SITE.SiteName
		  , SITE.SiteDisplayName
		  , EHIST.GroupName AS EligibilityGroupName
		  , EHIST.StartedDate AS EligibilityStartDate
		  , EHIST.EndedDate AS EligibilityEndDate
		  , GHIST.GroupName AS GroupName
		  , GHIST.StartedDate AS GroupStartDate
		  , GHIST.EndedDate AS GroupEndDate
	   FROM CMS_Role AS ROLES
				JOIN cms_MembershipRole AS MemberROLE
					ON ROLES.RoleID = MemberROLE.RoleID
				JOIN cms_MembershipUser AS MemberSHIP
					ON MemberROLE.MembershipID = MemberSHIP.MembershipID
				JOIN HFit_PPTEligibility AS PPT
					ON PPT.UserID = MemberSHIP.UserID
				JOIN CMS_USERSettings AS USERSET
					ON USERSET.UserSettingsUserID = PPT.UserID
				JOIN OM_ContactGroupMember AS GRPMBR
					ON GRPMBR.ContactGroupMemberRelatedID = USERSET.HFitPrimaryContactID
				JOIN OM_ContactGroup AS GRP
					ON GRP.ContactGroupID = GRPMBR.ContactGroupMemberContactGroupID
				JOIN HFit_ContactGroupMembership AS GroupMBR
					ON GroupMBR.cmsMembershipID = MemberSHIP.MembershipID

	 --LEFT OUTER JOIN [Hfit_Client] AS [CLIENT]
	 --ON [PPT].[ClientCode] = [CLIENT].[ClientName]

				LEFT OUTER JOIN HFit_Account AS ACCT
					ON ROLES.SiteID = ACCT.SiteID
				LEFT OUTER JOIN CMS_Site AS SITE
					ON SITE.SiteID = ACCT.SiteID
				LEFT OUTER JOIN view_EDW_EligibilityHistory AS EHIST
					ON EHIST.UserMpiNumber = USERSET.HFitUserMpiNumber
				LEFT OUTER JOIN EDW_GroupMemberHistory AS GHIST
					ON GHIST.UserMpiNumber = USERSET.HFitUserMpiNumber;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_Eligibility found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_EligibilityHistory') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_EligibilityHistory , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--************************************************************************************
--view_EDW_EligibilityHistory provides users access to the EDW_GroupMemberHistory table.
--************************************************************************************

CREATE VIEW view_EDW_EligibilityHistory
AS
	 SELECT
			GroupName
		  , UserMpiNumber
		  , StartedDate
		  , EndedDate
		  , RowNbr
	   FROM dbo.EDW_GroupMemberHistory;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_EligibilityHistory found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthAssesment') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthAssesment , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--select top 100 * from [view_EDW_HealthAssesment]

CREATE VIEW dbo.view_EDW_HealthAssesment
AS

	 --********************************************************************************************************
	 --7/15/2014 17:19 min. 46,750 Rows DEV
	 --7/15/2014 per Mark Turner
	 --HAModuleDocumentID is on its way out, so is - 
	 --Module - RiskCategory - RiskArea - Question - Answer 
	 --all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
	 --8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 00:43:10.
	 --8/8/2014 - Generated corrected view in DEV
	 -- Verified last mod date available to EDW 9.10.2014
	 --09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
	 --of the EDW to recognize changes to database records based on the last modified date of a row. 
	 --The views that we are currently using in the database or deeply nested. This means that 
	 --several base tables are involved in building a single view of data.
	 --09.30.2014: Verified with John Croft that he does want this view to return multi-languages.
	 --
	 --The views were initially designed to recognize a date change based on a record change very 
	 --high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
	 --and I recognize that data can change at any level in the hierarchy and those changes must be 
	 --recognized as well. Currently, that is not the case. With the new modification to the views, 
	 --changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
	 --process will be able to realize that a change in this row’s data may affect and intrude into 
	 --the warehouse.
	 -- 10.01.2014 - Reviewed by Mark and Dale for use of the GUIDS
	 -- 10.01.2014 - Reviewed by Mark and Dale for use of Joins and fixed two that were incorrect (Thanks to Mark)
	 -- 10.23.2014 - (WDM) added two columns for the EDW HAPaperFlg / HATelephonicFlg
	 --			HAPaperFlg is whether the question was reveived electronically or on paper
	 --			HATelephonicFlg is whether the question was reveived by telephone or not
	 -- FIVE Pieces needed per John C. 10.16.2014
	 --	Document GUID -> HealthAssesmentUserStartedNodeGUID
	 --	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
	 --	Category GUID -> Category
	 --	RiskArea Node Guid -> RiskArea 
	 --	Question Node Guid -> Question
	 --	Answer Node Guid -> Answer 
	 --   10.30.2014 : Sowmiya 
	 --   The following are the possible values allowed in the HAStartedMode and HACompletedMode columns of the Hfit_HealthAssesmentUserStarted table
	 --      Unknown = 0, 
	 --       Paper = 1,  // Paper HA
	 --       Telephonic = 2, // Telephonic HA
	 --       Online = 3, // Online HA
	 --       Ipad = 4 // iPAD
	 -- 08/07/2014 - (WDM) as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014
	 -- 09/30/2014 - (WDM) as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
	 --WDM 10.02.2014 place holder for EDW ETL
	 --Per John C. 10.16.2014 requested that this be put back into the view.	
	 --11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
	 -- 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
	 -- 11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
	 --11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
	 --inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
	 --	and VCTJ.DocumentCulture = ''en-US''	--10.01.2014 put here to match John C. req. for language agnostic.
	 -- 12.02.2014 - (wdm)Found that the view was being overwritten between Prod 1 and the copy of Prod 5 / Prod 1. Found a script inside a job on PRod 5 that reverted the view to a previous state. Removed the script and the view migrates correctly (d. miller and m. kimenski)
	 -- 12.02.2014 - (wdm) Found DUPS in Prod 1 and Prod 2, none in Prod 3. 
	 -- 12.17.2014 - Added two columns requested by the EDW team as noted by comments next to each column.
	 -- 12.29.2014 - Stripped HTML out of Title #47619
	 -- 12.31.2014 - Eliminated negative MPI''s in response to CR47516 
	 -- 01.02.2014 - Tested the removal of negative MPI''s in response to CR47516 
	 --01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
	 --	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
	 --	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
	 --	   This is NOT needed as the data is already contained in columns [AccountID] and [AccountCD]
	 --	   NOTE: Added the column [AccountName], just in case it were to be needed later.
	 --02.04.2015 (WDM) #48828 added:
	 --	    [HAUserStarted].[HACampaignNodeGUID], VCJ.BiometricCampaignStartDate
	 --	   , VCJ.BiometricCampaignEndDate, VCJ.CampaignStartDate
	 --	   , VCJ.CampaignEndDate, VCJ.Name as CampaignName, HACampaignID
	 --02.05.2015 Ashwin and I reviewed and approved
	 --********************************************************************************************************

	 SELECT
			HAUserStarted.ItemID AS UserStartedItemID
		  , VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
		  , HAUserStarted.UserID
		  , CMSUser.UserGUID
		  , UserSettings.HFitUserMpiNumber
		  , CMSSite.SiteGUID
		  , ACCT.AccountID
		  , ACCT.AccountCD
		  , ACCT.AccountName
		  , HAUserStarted.HAStartedDt
		  , HAUserStarted.HACompletedDt
		  , HAUserModule.ItemID AS UserModuleItemId
		  , HAUserModule.CodeName AS UserModuleCodeName
		  , HAUserModule.HAModuleNodeGUID
		  , VHAJ.NodeGUID AS CMSNodeGuid
		  , NULL AS HAModuleVersionID
		  , HARiskCategory.ItemID AS UserRiskCategoryItemID
		  , HARiskCategory.CodeName AS UserRiskCategoryCodeName
		  , HARiskCategory.HARiskCategoryNodeGUID

			--WDM 8/7/2014 as HARiskCategoryDocumentID

		  , NULL AS HARiskCategoryVersionID

			--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserRiskArea.ItemID AS UserRiskAreaItemID
		  , HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		  , HAUserRiskArea.HARiskAreaNodeGUID

			--WDM 8/7/2014 as HARiskAreaDocumentID

		  , NULL AS HARiskAreaVersionID

			--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserQuestion.ItemID AS UserQuestionItemID
		  , dbo.udf_StripHTML (HAQuestionsView.Title) AS Title

			--WDM 47619 12.29.2014

		  , HAUserQuestion.HAQuestionNodeGUID AS HAQuestionGuid

			--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID and matches to the definition file to get the question. This tells you the question, language agnostic.

		  , HAUserQuestion.CodeName AS UserQuestionCodeName
		  , NULL AS HAQuestionDocumentID

			--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL

		  , NULL AS HAQuestionVersionID

			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserQuestion.HAQuestionNodeGUID

			--WDM 10.01.2014	Left this in place to preserve column structure.		

		  , HAUserAnswers.ItemID AS UserAnswerItemID
		  , HAUserAnswers.HAAnswerNodeGUID

			--WDM 8/7/2014 as HAAnswerDocumentID

		  , NULL AS HAAnswerVersionID

			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL

		  , HAUserAnswers.CodeName AS UserAnswerCodeName
		  , HAUserAnswers.HAAnswerValue
		  , HAUserModule.HAModuleScore
		  , HARiskCategory.HARiskCategoryScore
		  , HAUserRiskArea.HARiskAreaScore
		  , HAUserQuestion.HAQuestionScore
		  , HAUserAnswers.HAAnswerPoints
		  , HAUserQuestionGroupResults.PointResults
		  , HAUserAnswers.UOMCode
		  , HAUserStarted.HAScore
		  , HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		  , HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
		  , HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		  , HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		  , HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName
		  , CASE
				WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HAUserAnswers.ItemCreatedWhen
		  , HAUserAnswers.ItemModifiedWhen
		  , HAUserQuestion.IsProfessionallyCollected
		  , HARiskCategory.ItemModifiedWhen AS HARiskCategory_ItemModifiedWhen
		  , HAUserRiskArea.ItemModifiedWhen AS HAUserRiskArea_ItemModifiedWhen
		  , HAUserQuestion.ItemModifiedWhen AS HAUserQuestion_ItemModifiedWhen
		  , HAUserAnswers.ItemModifiedWhen AS HAUserAnswers_ItemModifiedWhen
		  , HAUserStarted.HAPaperFlg
		  , HAUserStarted.HATelephonicFlg
		  , HAUserStarted.HAStartedMode

			--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

		  , HAUserStarted.HACompletedMode

			--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

		  , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
		  , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
		  , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID

	 -- PER John C. 2.6.2015 - Please comment out all columns except the GUID in the Assesment view.  It will reduce the amount of data coming through the delta process.  Thank you
	 --, [VHCJ].BiometricCampaignStartDate
	 --, [VHCJ].BiometricCampaignEndDate
	 --, [VHCJ].CampaignStartDate
	 --, [VHCJ].CampaignEndDate
	 --, [VHCJ].Name as CampaignName 
	 --, [VHCJ].HACampaignID

/****************************************
--the below are need in this view 
, HACampaign.BiometricCampaignStartDate
, HACampaign.BiometricCampaignEndDate
, HACampaign.CampaignStartDate
, HACampaign.CampaignEndDate
, HACampaign.Name

or only the 
select * from HAUserStarted
, HACampaign.NodeGuid as CampaignNodeGuid
****************************************/

	   FROM dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
				INNER JOIN dbo.CMS_User AS CMSUser
					ON HAUserStarted.UserID = CMSUser.UserID
				INNER JOIN dbo.CMS_UserSettings AS UserSettings
					ON UserSettings.UserSettingsUserID = CMSUser.UserID
				   AND HFitUserMpiNumber >= 0
				   AND HFitUserMpiNumber IS NOT NULL

	 -- (WDM) CR47516 

				INNER JOIN dbo.CMS_UserSite AS UserSite
					ON CMSUser.UserID = UserSite.UserID
				INNER JOIN dbo.CMS_Site AS CMSSite
					ON UserSite.SiteID = CMSSite.SiteID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON ACCT.SiteID = CMSSite.SiteID
				INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule
					ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
				INNER JOIN View_HFit_HACampaign_Joined AS VHCJ
					ON VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID
				   AND VHCJ.NodeSiteID = UserSite.SiteID
				   AND VHCJ.DocumentCulture = ''en-US''

	 --11.05.2014 - Mark T. / Dale M. - 

				INNER JOIN View_HFit_HealthAssessment_Joined AS VHAJ
					ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
				INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
					ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
				INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
					ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
				INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion
					ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
				INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
					ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
				   AND HAQuestionsView.DocumentCulture = ''en-US''
				LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
					ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
				INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers
					ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID

	   --left outer join View_HFit_HACampaign_Joined as VCJ 
	   --on VCJ.NodeGuid = [HAUserStarted].[HACampaignNodeGUID]

	   WHERE UserSettings.HFitUserMpiNumber NOT IN (
													SELECT
														   RejectMPICode
													  FROM HFit_LKP_EDW_RejectMPI) ;

--CMSUser.UserGUID not in  (Select RejectUserGUID from HFit_LKP_EDW_RejectMPI)	--61788DF7-955D-4A78-B77E-3DA340847AE7

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthAssesment found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'View_EDW_HealthAssesmentAnswers') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW View_EDW_HealthAssesmentAnswers , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '

CREATE VIEW [dbo].[View_EDW_HealthAssesmentAnswers]
AS
--********************************************************************************************************
--WDM 8.8.2014 - Created this view in order to add the DocumentGUID as 
--			required by the EDW team. Was having a bit of push-back
--			from the developers, so created this one in order to 
--			expedite filling the need for runnable views for the EDW.
-- Verified last mod date available to EDW 9.10.2014
--********************************************************************************************************
      SELECT
        VHFHAPAJ.ClassName AS AnswerType
       ,VHFHAPAJ.Value
       ,VHFHAPAJ.Points
       ,VHFHAPAJ.NodeGUID
       ,VHFHAPAJ.IsEnabled
       ,VHFHAPAJ.CodeName
	   ,VHFHAPAJ.InputType
       ,VHFHAPAJ.UOM
       ,VHFHAPAJ.NodeAliasPath
       ,VHFHAPAJ.DocumentPublishedVersionHistoryID
       ,VHFHAPAJ.NodeID
       ,VHFHAPAJ.NodeOrder
       ,VHFHAPAJ.NodeLevel
       ,VHFHAPAJ.NodeParentID
       ,VHFHAPAJ.NodeLinkedNodeID
	   ,VHFHAPAJ.DocumentCulture
	   ,VHFHAPAJ.DocumentGuid
	   ,VHFHAPAJ.DocumentModifiedWhen
      FROM
        dbo.View_HFit_HealthAssesmentPredefinedAnswer_Joined AS VHFHAPAJ WITH(NOLOCK)
	where VHFHAPAJ.DocumentCulture = ''en-US''

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: View_EDW_HealthAssesmentAnswers found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthAssesmentClientView') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthAssesmentClientView , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO
--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--02.04.2015 (wdm) #48828 added , HACampaign.BiometricCampaignStartDate, 
--		  HACampaign.BiometricCampaignEndDate, HACampaign.CampaignStartDate, 
--		  HACampaign.CampaignEndDate, HACampaign.Name, 
--		  HACampaign.NodeGuid as CampaignNodeGuid
--02.05.2015 Ashwin and I reviewed and approved
-- select top 100 * from view_EDW_HealthAssesmentClientView
--******************************************************************************

CREATE VIEW dbo.view_EDW_HealthAssesmentClientView
AS
	 SELECT
			HFitAcct.AccountID
		  , HFitAcct.AccountCD
		  , HFitAcct.AccountName
		  , HFitAcct.ItemGUID AS ClientGuid
		  , CMSSite.SiteGUID
		  , NULL AS CompanyID
		  , NULL AS CompanyGUID
		  , NULL AS CompanyName
		  , HAJoined.DocumentName
		  , HACampaign.DocumentPublishFrom AS HAStartDate
		  , HACampaign.DocumentPublishTo AS HAEndDate
		  , HACampaign.NodeSiteID
		  , HAAssessmentMod.Title
		  , HAAssessmentMod.CodeName
		  , HAAssessmentMod.IsEnabled
		  , CASE
				WHEN CAST (HACampaign.DocumentCreatedWhen AS date) = CAST (HACampaign.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HACampaign.DocumentCreatedWhen
		  , HACampaign.DocumentModifiedWhen
		  , HAAssessmentMod.DocumentModifiedWhen AS AssesmentModule_DocumentModifiedWhen

			--09.11.2014 (wdm) added to facilitate EDW last mod date

		  , HAAssessmentMod.DocumentCulture AS DocumentCulture_HAAssessmentMod
		  , HACampaign.DocumentCulture AS DocumentCulture_HACampaign
		  , HAJoined.DocumentCulture AS DocumentCulture_HAJoined
		  , HACampaign.BiometricCampaignStartDate
		  , HACampaign.BiometricCampaignEndDate
		  , HACampaign.CampaignStartDate
		  , HACampaign.CampaignEndDate
		  , HACampaign.Name
		  , HACampaign.NodeGuid AS CampaignNodeGuid
		  , HACampaign.HACampaignID
	   FROM dbo.View_HFit_HACampaign_Joined AS HACampaign
				INNER JOIN dbo.CMS_Site AS CMSSite
					ON HACampaign.NodeSiteID = CMSSite.SiteID
				INNER JOIN dbo.HFit_Account AS HFitAcct
					ON HACampaign.NodeSiteID = HFitAcct.SiteID
				INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined
					ON CASE
						   WHEN HACampaign.HealthAssessmentConfigurationID < 0
						   THEN HACampaign.HealthAssessmentID
						   ELSE HACampaign.HealthAssessmentConfigurationID
					   END = HAJoined.DocumentID
				   AND HAJoined.DocumentCulture = ''en-US''
				INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod
					ON HAJoined.nodeid = HAAssessmentMod.NodeParentID
				   AND HAAssessmentMod.DocumentCulture = ''en-US''
	   WHERE HACampaign.DocumentCulture = ''en-US'';
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthAssesmentClientView found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthAssesmentDeffinition') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthAssesmentDeffinition , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW dbo.view_EDW_HealthAssesmentDeffinition
AS
	 SELECT DISTINCT

	 --**************************************************************************************************************
	 --NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
	 --		unchanged when other dates added for the Last Mod Date additions. 
	 --		Therefore, the ''ChangeType'' was left dependent upon this date only. 09.12.2014 (wdm)
	 --*****************************************************************************************************************************************************
	 --Test Queries:
	 --select * from view_EDW_HealthAssesmentDeffinition where AnsDocumentGuid is not NULL
	 --Changes:
	 --WDM - 6/25/2014
	 --Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
	 --Worked with Shane to discover the CMS Tree had been modified.
	 --Modified the code so that reads it reads the CMS tree correctly - working.
	 --7/14/2014 1:29 time to run - 79024 rows - DEV
	 --7/14/2014 0:58 time to run - 57472 rows - PROD1
	 --7/15/2014 - Query was returning NodeName of ''Campaigns'' only
	 --	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
	 --7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
	 --8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
	 --8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
	 --8/8/2014 - Generated corrected view in DEV
	 --8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
	 --				them out. With them in the QRY, returned 43104 rows, with them nulled
	 --				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
	 --				time doubled approximately.
	 --				Has to add a DISTINCT to all the queries - .
	 --				Original Query 0:25 @ 43104
	 --				Original Query 0:46 @ 28736 (distinct)
	 --				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
	 --				Filter added - and VHFHARCJ.DocumentCulture = ''en-us''	 0:06 @ 3568
	 --				Filter added - and VHFHARAJ.DocumentCulture = ''en-us''	 0:03 @ 1784
	 --8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
	 --				such that when running the view in QA: 
	 --8/12/2014 - select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between ''2000-11-14'' and 
	 --				''2014-11-15'' now runs exceptionally fast
	 --08/12/2014 - ProdStaging 00:21:52 @ 2442
	 --08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
	 --08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
	 --08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
	 --08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
	 --08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
	 --08/12/2014 - DEV 00:00:58 @ 3792
	 --09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
	 --10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as 
	 --				well as Site and Account data
	 --11.25.2014 - (wdm) added multi-select column capability. The values can be 0,1, NULL
	 --12.29.2014 - (wdm) Added HTML stripping to two columns #47619, the others mentioned already had stripping applied
	 --12.31.2014 - (wdm) Started the review to apply CR-47517: Eliminate Matrix Questions with NULL Answer GUID''s
	 --01.07.2014 - (wdm) 47619 The Health Assessment Definition interface view contains HTML tags - corrected with udf_StripHTML
	 --************************************************************************************************************************************************************

			NULL AS SiteGUID

			--cs.SiteGUID								--WDM 08.12.2014 per John C.

   , NULL AS AccountCD

			--, HFA.AccountCD						--WDM 08.07.2014 per John C.

   , HA.NodeID AS HANodeID

			--WDM 08.07.2014

   , HA.NodeName AS HANodeName

			--WDM 08.07.2014
			--, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history

   , NULL AS HADocumentID

			--WDM 08.07.2014; 09.29.2014: Mark and Dale discussed that NODEGUID should be used such that the multi-language/culture is not a problem.

   , HA.NodeSiteID AS HANodeSiteID

			--WDM 08.07.2014

   , HA.DocumentPublishedVersionHistoryID AS HADocPubVerID

			--WDM 08.07.2014

   , dbo.udf_StripHTML (VHFHAMJ.Title) AS ModTitle

			--WDM 47619

   , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText

			--WDM 47619

   , VHFHAMJ.NodeGuid AS ModDocGuid

			--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHAMJ.Weight AS ModWeight
   , VHFHAMJ.IsEnabled AS ModIsEnabled
   , VHFHAMJ.CodeName AS ModCodeName
   , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
   , dbo.udf_StripHTML (VHFHARCJ.Title) AS RCTitle

			--WDM 47619

   , VHFHARCJ.Weight AS RCWeight
   , VHFHARCJ.NodeGuid AS RCDocumentGUID

			--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHARCJ.IsEnabled AS RCIsEnabled
   , VHFHARCJ.CodeName AS RCCodeName
   , VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
   , dbo.udf_StripHTML (VHFHARAJ.Title) AS RATytle

			--WDM 47619

   , VHFHARAJ.Weight AS RAWeight
   , VHFHARAJ.NodeGuid AS RADocumentGuid

			--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHARAJ.IsEnabled AS RAIsEnabled
   , VHFHARAJ.CodeName AS RACodeName
   , VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
   , VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
   , VHFHAQ.QuestionType
   , dbo.udf_StripHTML (LEFT (VHFHAQ.Title, 4000)) AS QuesTitle

			--WDM 47619

   , VHFHAQ.Weight AS QuesWeight
   , VHFHAQ.IsRequired AS QuesIsRequired

			--, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014

   , VHFHAQ.NodeGuid AS QuesDocumentGuid

			--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014

   , VHFHAQ.IsEnabled AS QuesIsEnabled
   , LEFT (VHFHAQ.IsVisible, 4000) AS QuesIsVisible
   , VHFHAQ.IsStaging AS QuesIsSTaging
   , VHFHAQ.CodeName AS QuestionCodeName
   , VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
   , VHFHAA.Value AS AnsValue
   , VHFHAA.Points AS AnsPoints
   , VHFHAA.NodeGuid AS AnsDocumentGuid

			--ref: #47517

   , VHFHAA.IsEnabled AS AnsIsEnabled
   , VHFHAA.CodeName AS AnsCodeName
   , VHFHAA.UOM AS AnsUOM
   , VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
   , CASE
		 WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
		 THEN ''I''
		 ELSE ''U''
	 END AS ChangeType
   , HA.DocumentCreatedWhen
   , HA.DocumentModifiedWhen
   , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014 ADDED TO the returned Columns

   , HA.NodeGUID AS HANodeGUID

			--, NULL as SiteLastModified

   , NULL AS SiteLastModified

			--, NULL as Account_ItemModifiedWhen

   , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

   , NULL AS Campaign_DocumentModifiedWhen
   , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
   , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
   , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
   , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
   , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
   , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
   , HAMCQ.AllowMultiSelect
   , ''SID01'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHARAJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND VHFHAA.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM Retrieve Matrix Level 1 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 

			--WDM 47619

		  , dbo.udf_StripHTML (LEFT (LEFT (VHFHAMJ.IntroText, 4000) , 4000)) AS IntroText

			--WDM 47619

		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 

			--WDM 47619

		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 

			--WDM 47619

		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ2.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ2.Title, 4000)) AS QuesTitle

			--WDM 47619

		  , VHFHAQ2.Weight
		  , VHFHAQ2.IsRequired
		  , VHFHAQ2.NodeGuid
		  , VHFHAQ2.IsEnabled
		  , LEFT (VHFHAQ2.IsVisible, 4000) 
		  , VHFHAQ2.IsStaging
		  , VHFHAQ2.CodeName AS QuestionCodeName

			--,VHFHAQ2.NodeAliasPath

		  , VHFHAQ2.DocumentPublishedVersionHistoryID
		  , VHFHAA2.Value
		  , VHFHAA2.Points
		  , VHFHAA2.NodeGuid

			--ref: #47517

		  , VHFHAA2.IsEnabled
		  , VHFHAA2.CodeName
		  , VHFHAA2.UOM

			--,VHFHAA2.NodeAliasPath

		  , VHFHAA2.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID02'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2
			 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2
			 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA2.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ3.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ3.Title, 4000)) AS QuesTitle
		  , VHFHAQ3.Weight
		  , VHFHAQ3.IsRequired
		  , VHFHAQ3.NodeGuid
		  , VHFHAQ3.IsEnabled
		  , LEFT (VHFHAQ3.IsVisible, 4000) 
		  , VHFHAQ3.IsStaging
		  , VHFHAQ3.CodeName AS QuestionCodeName

			--,VHFHAQ3.NodeAliasPath

		  , VHFHAQ3.DocumentPublishedVersionHistoryID
		  , VHFHAA3.Value
		  , VHFHAA3.Points
		  , VHFHAA3.NodeGuid

			--ref: #47517

		  , VHFHAA3.IsEnabled
		  , VHFHAA3.CodeName
		  , VHFHAA3.UOM

			--,VHFHAA3.NodeAliasPath

		  , VHFHAA3.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID03'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA3.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ7.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ7.Title, 4000)) AS QuesTitle
		  , VHFHAQ7.Weight
		  , VHFHAQ7.IsRequired
		  , VHFHAQ7.NodeGuid
		  , VHFHAQ7.IsEnabled
		  , LEFT (VHFHAQ7.IsVisible, 4000) 
		  , VHFHAQ7.IsStaging
		  , VHFHAQ7.CodeName AS QuestionCodeName

			--,VHFHAQ7.NodeAliasPath

		  , VHFHAQ7.DocumentPublishedVersionHistoryID
		  , VHFHAA7.Value
		  , VHFHAA7.Points
		  , VHFHAA7.NodeGuid

			--ref: #47517

		  , VHFHAA7.IsEnabled
		  , VHFHAA7.CodeName
		  , VHFHAA7.UOM

			--,VHFHAA7.NodeAliasPath

		  , VHFHAA7.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID04'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

	 --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	 --Matrix Level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
			 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
			 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA7.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --****************************************************
	 --WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	 --THE PROBLEM LIES HERE in this part of query : 1:40 minute
	 -- Added two perf indexes to the first query: 25 Sec
	 --****************************************************

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ8.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ8.Title, 4000)) AS QuesTitle
		  , VHFHAQ8.Weight
		  , VHFHAQ8.IsRequired
		  , VHFHAQ8.NodeGuid
		  , VHFHAQ8.IsEnabled
		  , LEFT (VHFHAQ8.IsVisible, 4000) 
		  , VHFHAQ8.IsStaging
		  , VHFHAQ8.CodeName AS QuestionCodeName

			--,VHFHAQ8.NodeAliasPath

		  , VHFHAQ8.DocumentPublishedVersionHistoryID
		  , VHFHAA8.Value
		  , VHFHAA8.Points
		  , VHFHAA8.NodeGuid

			--ref: #47517

		  , VHFHAA8.IsEnabled
		  , VHFHAA8.CodeName
		  , VHFHAA8.UOM

			--,VHFHAA8.NodeAliasPath

		  , VHFHAA8.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID05'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID

	 --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	 --Matrix Level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
			 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
			 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

	 --Matrix branching level 1 question group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8
			 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8
			 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA8.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --****************************************************
	 --WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	 --THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	 --With the new indexes: 29 Secs
	 --****************************************************

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ4.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ4.Title, 4000)) AS QuesTitle
		  , VHFHAQ4.Weight
		  , VHFHAQ4.IsRequired
		  , VHFHAQ4.NodeGuid
		  , VHFHAQ4.IsEnabled
		  , LEFT (VHFHAQ4.IsVisible, 4000) 
		  , VHFHAQ4.IsStaging
		  , VHFHAQ4.CodeName AS QuestionCodeName

			--,VHFHAQ4.NodeAliasPath

		  , VHFHAQ4.DocumentPublishedVersionHistoryID
		  , VHFHAA4.Value
		  , VHFHAA4.Points
		  , VHFHAA4.NodeGuid

			--ref: #47517

		  , VHFHAA4.IsEnabled
		  , VHFHAA4.CodeName
		  , VHFHAA4.UOM

			--,VHFHAA4.NodeAliasPath

		  , VHFHAA4.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID06'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA4.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM 6/25/2014 Retrieve the Branching level 3 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ5.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ5.Title, 4000)) AS QuesTitle
		  , VHFHAQ5.Weight
		  , VHFHAQ5.IsRequired
		  , VHFHAQ5.NodeGuid
		  , VHFHAQ5.IsEnabled
		  , LEFT (VHFHAQ5.IsVisible, 4000) 
		  , VHFHAQ5.IsStaging
		  , VHFHAQ5.CodeName AS QuestionCodeName

			--,VHFHAQ5.NodeAliasPath

		  , VHFHAQ5.DocumentPublishedVersionHistoryID
		  , VHFHAA5.Value
		  , VHFHAA5.Points
		  , VHFHAA5.NodeGuid

			--ref: #47517

		  , VHFHAA5.IsEnabled
		  , VHFHAA5.CodeName
		  , VHFHAA5.UOM

			--,VHFHAA5.NodeAliasPath

		  , VHFHAA5.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID07'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
			 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
			 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA5.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM 6/25/2014 Retrieve the Branching level 4 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ6.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ6.Title, 4000)) AS QuesTitle
		  , VHFHAQ6.Weight
		  , VHFHAQ6.IsRequired
		  , VHFHAQ6.NodeGuid
		  , VHFHAQ6.IsEnabled
		  , LEFT (VHFHAQ6.IsVisible, 4000) 
		  , VHFHAQ6.IsStaging
		  , VHFHAQ6.CodeName AS QuestionCodeName

			--,VHFHAQ6.NodeAliasPath

		  , VHFHAQ6.DocumentPublishedVersionHistoryID
		  , VHFHAA6.Value
		  , VHFHAA6.Points
		  , VHFHAA6.NodeGuid

			--ref: #47517

		  , VHFHAA6.IsEnabled
		  , VHFHAA6.CodeName
		  , VHFHAA6.UOM

			--,VHFHAA6.NodeAliasPath

		  , VHFHAA6.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID08'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group
	 --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
			 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
			 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

	 --Branching level 4 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
			 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
			 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA6.NodeGuid IS NOT NULL

	 --ref: #47517

	 UNION ALL

	 --UNION
	 --WDM 6/25/2014 Retrieve the Branching level 5 Question Group

	 SELECT DISTINCT
			NULL AS SiteGUID

			--cs.SiteGUID		--WDM 08.12.2014

		  , NULL AS AccountCD

			--, HFA.AccountCD												--WDM 08.07.2014

		  , HA.NodeID

			--WDM 08.07.2014

		  , HA.NodeName

			--WDM 08.07.2014

		  , NULL AS HADocumentID

			--WDM 08.07.2014

		  , HA.NodeSiteID

			--WDM 08.07.2014
			--,VCTJ.NodeAliasPath

		  , HA.DocumentPublishedVersionHistoryID

			--WDM 08.07.2014

		  , dbo.udf_StripHTML (VHFHAMJ.Title) 
		  , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
		  , VHFHAMJ.NodeGuid
		  , VHFHAMJ.Weight
		  , VHFHAMJ.IsEnabled
		  , VHFHAMJ.CodeName

			--,VHFHAMJ.NodeAliasPath

		  , VHFHAMJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARCJ.Title) 
		  , VHFHARCJ.Weight
		  , VHFHARCJ.NodeGuid
		  , VHFHARCJ.IsEnabled
		  , VHFHARCJ.CodeName

			--,VHFHARCJ.NodeAliasPath

		  , VHFHARCJ.DocumentPublishedVersionHistoryID
		  , dbo.udf_StripHTML (VHFHARAJ.Title) 
		  , VHFHARAJ.Weight
		  , VHFHARAJ.NodeGuid
		  , VHFHARAJ.IsEnabled
		  , VHFHARAJ.CodeName

			--,VHFHARAJ.NodeAliasPath

		  , VHFHARAJ.ScoringStrategyID
		  , VHFHARAJ.DocumentPublishedVersionHistoryID
		  , VHFHAQ9.QuestionType
		  , dbo.udf_StripHTML (LEFT (VHFHAQ9.Title, 4000)) AS QuesTitle
		  , VHFHAQ9.Weight
		  , VHFHAQ9.IsRequired
		  , VHFHAQ9.NodeGuid
		  , VHFHAQ9.IsEnabled
		  , LEFT (VHFHAQ9.IsVisible, 4000) 
		  , VHFHAQ9.IsStaging
		  , VHFHAQ9.CodeName AS QuestionCodeName

			--,VHFHAQ9.NodeAliasPath

		  , VHFHAQ9.DocumentPublishedVersionHistoryID
		  , VHFHAA9.Value
		  , VHFHAA9.Points
		  , VHFHAA9.NodeGuid

			--ref: #47517

		  , VHFHAA9.IsEnabled
		  , VHFHAA9.CodeName
		  , VHFHAA9.UOM

			--,VHFHAA9.NodeAliasPath

		  , VHFHAA9.DocumentPublishedVersionHistoryID
		  , CASE
				WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HA.DocumentCreatedWhen
		  , HA.DocumentModifiedWhen
		  , HA.NodeGuid AS CmsTreeNodeGuid

			--WDM 08.07.2014

		  , HA.NodeGUID AS HANodeGUID
		  , NULL AS SiteLastModified
		  , NULL AS Account_ItemModifiedWhen

			--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen

		  , NULL AS Campaign_DocumentModifiedWhen
		  , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
		  , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
		  , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
		  , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
		  , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
		  , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
		  , HAMCQ.AllowMultiSelect
		  , ''SID09'' AS LocID
	   FROM

	 --dbo.View_CMS_Tree_Joined AS VCTJ
	 --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
	 --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
	 --Campaign links Client which links to Assessment
	 --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

	 View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
		 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
			 ON HA.NodeID = VHFHAMJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
			 ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
			 ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
			 ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
			 ON VHFHAQ.NodeID = VHFHAA.NodeParentID

	 --matrix level 1 questiongroup
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
	 --Branching Level 1 Question 

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
			 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
			 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

	 --Matrix Level 2 Question Group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	 --Matrix branching level 1 question group
	 --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
	 --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
	 --Branching level 2 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
			 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
			 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

	 --Branching level 3 Question Group
	 --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
			 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
			 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

	 --Branching level 4 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
			 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
			 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

	 --Branching level 5 Question Group

		 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9
			 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		 INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9
			 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
		 LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
			 ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = ''en-US''
	   WHERE VHFHAQ.DocumentCulture = ''en-us''
		 AND (VHFHAA.DocumentCulture = ''en-us''
		   OR VHFHAA.DocumentCulture IS NULL) 

			 --WDM 08.12.2014		

		 AND VHFHARCJ.DocumentCulture = ''en-us''
		 AND VHFHARAJ.DocumentCulture = ''en-us''
		 AND VHFHAMJ.DocumentCulture = ''en-us''

			 --WDM 08.12.2014	

		 AND HA.DocumentCulture = ''en-us''

			 --WDM 08.12.2014		

		 AND VHFHAA9.NodeGuid IS NOT NULL;

--ref: #47517

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthAssesmentDeffinition found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthAssesmentDeffinitionCustom') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthAssesmentDeffinitionCustom , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
--	TO [EDWReader_PRD]
--GO

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
AS
	--8/8/2014 - DocGUID changes, NodeGuid
	--8/8/2014 - Generated corrected view in DEV
	--8/10/2014 - added WHERE to limit to English language
	--09.11.2014 - WDM : Added date fields to facilitate Last Mod Date determination
	SELECT 
		cs.SiteGUID
		, HFA.AccountCD		--WDM 08.07.2014
		, HA.NodeID AS HANodeID		--WDM 08.07.2014
		, HA.NodeName AS HANodeName		--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID		--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we''ll just do it here
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
			THEN ''I''
			ELSE ''U''
		END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
	 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
		INNER JOIN View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		--WDM 08.07.2014
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''
UNION ALL
--WDM Retrieve Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentGUID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentGUID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentGUID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
 dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentGUID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentGUID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentGUID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentGUID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''

UNION ALL
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentGUID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, VCTJ.DocumentCreatedWhen
		, VCTJ.DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CS.SiteLastModified
		, hfa.ItemModifiedWhen as Account_ItemModifiedWhen
		, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
where VCTJ.DocumentCulture = ''en-us''	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = ''Custom''




';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthAssesmentDeffinitionCustom found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'View_EDW_HealthAssesmentQuestions') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW View_EDW_HealthAssesmentQuestions , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
create VIEW [dbo].[View_EDW_HealthAssesmentQuestions]

AS 
--**********************************************************************************
--09.11.2014 (wdm) Added the DocumentModifiedWhen to facilitate the EDW need to 
--		determine the last mod date of a record.
--10.17.2014 (wdm)
-- view_EDW_HealthAssesmentDeffinition calls 
-- View_EDW_HealthAssesmentQuestions which calls
-- View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
--		and two other JOINED views.
--View view_EDW_HealthAssesmentDeffinition has a filter on document culture of ''EN-US''
--		which limits the retured data to Engoish only.
--Today, John found a number of TITLES in view_EDW_HealthAssesmentDeffinition that were Spanish.
--The problem seems to come from sevel levels of nesting causing intersection data to seep through 
--the EN-US filter if placed at the highest level of a set of nested views.
--I took the filter and applied it to all the joined views within View_EDW_HealthAssesmentQuestions 
--		and the issue seems to have resolved itself.
--10.17.2014 (wdm) Added a filter "DocumentCulture" - the issue appears to be 
--			caused in view view_EDW_HealthAssesmentDeffinition becuase
--			the FILTER at that level on EN-US allows a portion of the intersection 
--			data to be missed for whatever reason. Adding the filter at this level
--			of the nesting seems to omit the non-english titles found by John Croft.
--**********************************************************************************
SELECT 
	VHFHAMCQJ.ClassName AS QuestionType,
	VHFHAMCQJ.Title,
	VHFHAMCQJ.Weight,
	VHFHAMCQJ.IsRequired,
	VHFHAMCQJ.QuestionImageLeft,
	VHFHAMCQJ.QuestionImageRight,
	VHFHAMCQJ.NodeGUID,	
	VHFHAMCQJ.DocumentCulture,
	VHFHAMCQJ.IsEnabled,
	VHFHAMCQJ.IsVisible,
	VHFHAMCQJ.IsStaging,
	VHFHAMCQJ.CodeName,
	VHFHAMCQJ.QuestionGroupCodeName,
	VHFHAMCQJ.NodeAliasPath,
	VHFHAMCQJ.DocumentPublishedVersionHistoryID,
	VHFHAMCQJ.NodeLevel,
	VHFHAMCQJ.NodeOrder,
	VHFHAMCQJ.NodeID,
	VHFHAMCQJ.NodeParentID,
	VHFHAMCQJ.NodeLinkedNodeID, 
	0 AS DontKnowEnabled, 
	'''' AS DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMCQJ.DocumentGuid
	,VHFHAMCQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH(NOLOCK)
where VHFHAMCQJ.DocumentCulture = ''en-US''   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAMQJ.ClassName AS QuestionType,
	VHFHAMQJ.Title,
	VHFHAMQJ.Weight,
	VHFHAMQJ.IsRequired,
	VHFHAMQJ.QuestionImageLeft,
	VHFHAMQJ.QuestionImageRight,
	VHFHAMQJ.NodeGUID,
	VHFHAMQJ.DocumentCulture,
	VHFHAMQJ.IsEnabled,
	VHFHAMQJ.IsVisible,
	VHFHAMQJ.IsStaging,
	VHFHAMQJ.CodeName,
	VHFHAMQJ.QuestionGroupCodeName,
	VHFHAMQJ.NodeAliasPath,
	VHFHAMQJ.DocumentPublishedVersionHistoryID,
	VHFHAMQJ.NodeLevel,
	VHFHAMQJ.NodeOrder,
	VHFHAMQJ.NodeID,
	VHFHAMQJ.NodeParentID,
	VHFHAMQJ.NodeLinkedNodeID,
	0 AS DontKnowEnabled, 
	'''' AS DontKnowLabel,
		(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMQJ.DocumentGuid
	,VHFHAMQJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH(NOLOCK)
where VHFHAMQJ.DocumentCulture = ''en-US''   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAFFJ.ClassName AS QuestionType,
	VHFHAFFJ.Title,
	VHFHAFFJ.Weight,
	VHFHAFFJ.IsRequired,
	VHFHAFFJ.QuestionImageLeft,
	'''' AS QuestionImageRight,
	VHFHAFFJ.NodeGUID,
	VHFHAFFJ.DocumentCulture,
	VHFHAFFJ.IsEnabled,
	VHFHAFFJ.IsVisible,
	VHFHAFFJ.IsStaging,
	VHFHAFFJ.CodeName,
	VHFHAFFJ.QuestionGroupCodeName,
	VHFHAFFJ.NodeAliasPath,
	VHFHAFFJ.DocumentPublishedVersionHistoryID,
	VHFHAFFJ.NodeLevel,
	VHFHAFFJ.NodeOrder,
	VHFHAFFJ.NodeID,
	VHFHAFFJ.NodeParentID,
	VHFHAFFJ.NodeLinkedNodeID,
	VHFHAFFJ.DontKnowEnabled,
	VHFHAFFJ.DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
	,VHFHAFFJ.DocumentGuid
	,VHFHAFFJ.DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH(NOLOCK)
where VHFHAFFJ.DocumentCulture = ''en-US''   --(WDM) 10.19.2014 added to filter at this level of nesting

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: View_EDW_HealthAssesmentQuestions found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthAssessment_Staged') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthAssessment_Staged , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
create view [dbo].[view_EDW_HealthAssessment_Staged]
as
--****************************************************************************
--09/04/2014 WDM
--The view Health Assessment runs poorly. This view/table is created as 
--as a staging table allowing the data to already exist when the EDW needs it.
--This is the view that pulls data from the staging table (EDW_HealthAssessment) 
--allowing the EDW to launch a much faster start when processing Health 
--Assessment data.
--****************************************************************************

SELECT [UserStartedItemID]
      ,[HealthAssesmentUserStartedNodeGUID]
      ,[UserID]
      ,[UserGUID]
      ,[HFitUserMpiNumber]
      ,[SiteGUID]
      ,[AccountID]
      ,[AccountCD]
      ,[HAStartedDt]
      ,[HACompletedDt]
      ,[UserModuleItemId]
      ,[UserModuleCodeName]
      ,[HAModuleNodeGUID]
      ,[CMSNodeGuid]
      ,[HAModuleVersionID]
      ,[UserRiskCategoryItemID]
      ,[UserRiskCategoryCodeName]
      ,[HARiskCategoryNodeGUID]
      ,[HARiskCategoryVersionID]
      ,[UserRiskAreaItemID]
      ,[UserRiskAreaCodeName]
      ,[HARiskAreaNodeGUID]
      ,[HARiskAreaVersionID]
      ,[UserQuestionItemID]
      ,[Title]
      ,[HAQuestionGuid]
      ,[UserQuestionCodeName]
      ,[HAQuestionDocumentID]
      ,[HAQuestionVersionID]
      ,[HAQuestionNodeGUID]
      ,[UserAnswerItemID]
      ,[HAAnswerNodeGUID]
      ,[HAAnswerVersionID]
      ,[UserAnswerCodeName]
      ,[HAAnswerValue]
      ,[HAModuleScore]
      ,[HARiskCategoryScore]
      ,[HARiskAreaScore]
      ,[HAQuestionScore]
      ,[HAAnswerPoints]
      ,[PointResults]
      ,[UOMCode]
      ,[HAScore]
      ,[ModulePreWeightedScore]
      ,[RiskCategoryPreWeightedScore]
      ,[RiskAreaPreWeightedScore]
      ,[QuestionPreWeightedScore]
      ,[QuestionGroupCodeName]
      ,[ChangeType]
      ,[IsProfessionallyCollected]
      ,[ItemCreatedWhen]
      ,[ItemModifiedWhen]
      ,[HARiskCategory_ItemModifiedWhen]
      ,[HAUserRiskArea_ItemModifiedWhen]
      ,[HAUserQuestion_ItemModifiedWhen]
      ,[HAUserAnswers_ItemModifiedWhen]
  FROM [dbo].[EDW_HealthAssessment]
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthAssessment_Staged found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthAssessmentDefinition_Staged') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthAssessmentDefinition_Staged , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
create view [dbo].[view_EDW_HealthAssessmentDefinition_Staged]
as
--****************************************************************************
--09/04/2014 WDM
--The view Health Assessment Definition runs very poorly. This view/table is 
--created as as a staging table allowing the data to already exist when the 
--EDW needs it. This is the view that data from the staging table 
--(EDW_HealthAssessmentDefinition) allowing the EDW to launch a much faster 
--start when processing Health Assessment Definition data.
--****************************************************************************
SELECT [SiteGuid]
      ,[AccountCD]
      ,[HANodeID]
      ,[HANodeName]
      ,[HADocumentID]
      ,[HANodeSiteID]
      ,[HADocPubVerID]
      ,[ModTitle]
      ,[IntroText]
      ,[ModDocGuid]
      ,[ModWeight]
      ,[ModIsEnabled]
      ,[ModCodeName]
      ,[ModDocPubVerID]
      ,[RCTitle]
      ,[RCWeight]
      ,[RCDocumentGUID]
      ,[RCIsEnabled]
      ,[RCCodeName]
      ,[RCDocPubVerID]
      ,[RATytle]
      ,[RAWeight]
      ,[RADocumentGuid]
      ,[RAIsEnabled]
      ,[RACodeName]
      ,[RAScoringStrategyID]
      ,[RADocPubVerID]
      ,[QuestionType]
      ,[QuesTitle]
      ,[QuesWeight]
      ,[QuesIsRequired]
      ,[QuesDocumentGuid]
      ,[QuesIsEnabled]
      ,[QuesIsVisible]
      ,[QuesIsSTaging]
      ,[QuestionCodeName]
      ,[QuesDocPubVerID]
      ,[AnsValue]
      ,[AnsPoints]
      ,[AnsDocumentGuid]
      ,[AnsIsEnabled]
      ,[AnsCodeName]
      ,[AnsUOM]
      ,[AnsDocPUbVerID]
      ,[ChangeType]
      ,[DocumentCreatedWhen]
      ,[DocumentModifiedWhen]
      ,[CmsTreeNodeGuid]
      ,[HANodeGUID]
  FROM [dbo].[EDW_HealthAssessmentDefinition]

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthAssessmentDefinition_Staged found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthInterestDetail') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthInterestDetail , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
CREATE VIEW [dbo].[view_EDW_HealthInterestDetail]
AS
	SELECT
		HI.UserID
		,U.UserGUID
		,US.HFitUserMpiNumber
		,S.SiteGUID
		,HI.CoachingHealthInterestID

		,HA1.CoachingHealthAreaID AS FirstHealthAreaID
		,HA1.NodeID AS FirstNodeID
		,HA1.NodeGuid AS FirstNodeGuid
		,HA1.DocumentName AS FirstHealthAreaName
		,HA1.HealthAreaDescription AS FirstHealthAreaDescription
		,HA1.CodeName AS FirstCodeName
	
		,HA2.CoachingHealthAreaID AS SecondHealthAreaID
		,HA2.NodeID AS SecondNodeID
		,HA2.NodeGuid AS SecondNodeGuid
		,HA2.DocumentName AS SecondHealthAreaName
		,HA2.HealthAreaDescription AS SecondHealthAreaDescription
		,HA2.CodeName AS SecondCodeName
	
		,HA3.CoachingHealthAreaID AS ThirdHealthAreaID
		,HA3.NodeID AS ThirdNodeID
		,HA3.NodeGuid AS ThirdNodeGuid
		,HA3.DocumentName AS ThirdHealthAreaName
		,HA3.HealthAreaDescription AS ThirdHealthAreaDescription
		,HA3.CodeName AS ThirdCodeName

		,HI.ItemCreatedWhen
		,HI.ItemModifiedWhen
	FROM
		HFit_CoachingHealthInterest AS HI
		JOIN CMS_User AS U ON HI.UserID = U.UserID
		JOIN CMS_UserSettings AS US ON HI.UserID = US.UserSettingsUserID
		JOIN CMS_UserSite AS US1 ON HI.UserID = US1.UserID
		JOIN CMS_Site AS S ON US1.SiteID = S.SiteID
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA1 ON HI.FirstInterest = HA1.NodeID
			AND HA1.DocumentCulture = ''en-us''
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA2 ON HI.SecondInterest = HA2.NodeID	
			AND HA2.DocumentCulture = ''en-us''
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA3 ON HI.ThirdInterest = HA3.NodeID
			AND HA3.DocumentCulture = ''en-us''
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthInterestDetail found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_HealthInterestList') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_HealthInterestList , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
CREATE VIEW [dbo].[view_EDW_HealthInterestList]
AS
	SELECT
		CHA.CoachingHealthAreaID AS HealthAreaID
		,CHA.NodeID
		,CHA.NodeGuid
		,A.AccountCD
		,CHA.NodeName AS HealthAreaName
		,CHA.HealthAreaDescription
		,CHA.CodeName
		,CHA.DocumentCreatedWhen
		,CHA.DocumentModifiedWhen
	FROM
		View_HFit_CoachingHealthArea_Joined AS CHA
		JOIN HFit_Account AS A ON A.SiteID = CHA.NodeSiteID
	WHERE DocumentCulture = ''en-us''
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_HealthInterestList found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_Participant') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_Participant , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '

--*********************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 (wdm) added date fields to facilitate EDW determination of last mod date 
--*********************************************************************************************
create VIEW [dbo].[view_EDW_Participant]
AS
	SELECT
		cus.HFitUserMpiNumber
		, cu.UserID
		, cu.UserGUID
		, CS.SiteGUID
		, hfa.AccountID
		, hfa.AccountCD
		, cus.HFitUserPreferredMailingAddress
		, cus.HFitUserPreferredMailingCity
		, cus.HFitUserPreferredMailingState
		, cus.HFitUserPreferredMailingPostalCode
		, cus.HFitCoachingEnrollDate
		, cus.HFitUserAltPreferredPhone
		, cus.HFitUserAltPreferredPhoneExt
		, cus.HFitUserAltPreferredPhoneType
		, cus.HFitUserPreferredPhone
		, cus.HFitUserPreferredFirstName
		, CASE	WHEN CAST(cu.UserCreated AS DATE) = CAST(cu.UserLastModified AS DATE)
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		, cu.UserCreated
		, cu.UserLastModified
		, HFA.ItemModifiedWhen as Account_ItemModifiedWhen	--wdm: 09.11.2014 added to view
	FROM
		dbo.CMS_User AS CU
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON CU.UserID = CUS2.UserID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cus2.SiteID = hfa.SiteID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserSettingsUserID







';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_Participant found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_RewardAwardDetail') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_RewardAwardDetail , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW dbo.view_EDW_RewardAwardDetail
AS

	 --*************************************************************************************************
	 --WDM Reviewed 8/6/2014 for needed updates, none required
	 --09.11.2014 : (wdm) reviewed for EDW last mod date and the view is OK as is
	 --11.19.2014 : added language to verify returned data
	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
	 --*************************************************************************************************

	 SELECT DISTINCT
			cu.UserGUID
		  , cs.SiteGUID
		  , cus.HFitUserMpiNumber
		  , RL_Joined.RewardLevelID
		  , HFRAUD.AwardDisplayName
		  , HFRAUD.RewardValue
		  , HFRAUD.ThresholdNumber
		  , HFRAUD.UserNotified
		  , HFRAUD.IsFulfilled
		  , hfa.AccountID
		  , HFA.AccountCD
		  , CASE
				WHEN CAST (HFRAUD.ItemCreatedWhen AS date) = CAST (HFRAUD.ItemModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , HFRAUD.ItemCreatedWhen
		  , HFRAUD.ItemModifiedWhen
		  , RL_Joined.DocumentCulture
		  , HFRAUD.CultureCode
		  , RL_Joined.LevelName
		  , RL_Joined.LevelHeader
		  , RL_Joined.GroupHeadingText
		  , RL_Joined.GroupHeadingDescription
	   FROM dbo.HFit_RewardsAwardUserDetail AS HFRAUD
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON hfraud.RewardLevelNodeId = RL_Joined.NodeID
				   AND RL_Joined.DocumentCulture = ''en-US''
				   AND HFRAUD.CultureCode = ''en-US''
				INNER JOIN dbo.CMS_User AS CU
					ON hfraud.UserId = cu.UserID
				INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cu.UserID = cus2.UserID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cus2.SiteID = HFA.SiteID
				INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS
					ON cu.UserID = cus.UserSettingsUserID;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_RewardAwardDetail found - passed check.') ;
--*****************************************************************************
     GO
--drop view View_EDW_RewardProgram_Joined
--*****************************************************************************
     if not exists (select name from sys.views where name = 'View_EDW_RewardProgram_Joined') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW View_EDW_RewardProgram_Joined , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--This view is created in place of View_Hfit_RewardProgram_Joined so that 
--Document Culture can be taken into consideration. 
CREATE VIEW [dbo].[View_EDW_RewardProgram_Joined] AS 
SELECT View_CMS_Tree_Joined.*, HFit_RewardProgram.* 
	FROM View_CMS_Tree_Joined 
	INNER JOIN HFit_RewardProgram 
		ON View_CMS_Tree_Joined.DocumentForeignKeyValue = HFit_RewardProgram.[RewardProgramID] 
WHERE ClassName = ''HFit.RewardProgram''
AND View_CMS_Tree_Joined.documentculture = ''en-US''
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: View_EDW_RewardProgram_Joined found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_RewardsDefinition') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_RewardsDefinition , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW dbo.view_EDW_RewardsDefinition
AS

	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription

	 SELECT DISTINCT
			cs.SiteGUID
		  , HFA.AccountID
		  , hfa.AccountCD
		  , RewardProgramID
		  , RewardProgramName
		  , RewardProgramPeriodStart
		  , RewardProgramPeriodEnd
		  , ProgramDescription
		  , RewardGroupID
		  , GroupName
		  , RewardContactGroups
		  , RewardGroupPeriodStart
		  , RewardGroupPeriodEnd
		  , RewardLevelID
		  , Level
		  , RewardLevelTypeLKPName
		  , RewardLevelPeriodStart
		  , RewardLevelPeriodEnd
		  , FrequencyMenu
		  , AwardDisplayName
		  , AwardType
		  , AwardThreshold1
		  , AwardThreshold2
		  , AwardThreshold3
		  , AwardThreshold4
		  , AwardValue1
		  , AwardValue2
		  , AwardValue3
		  , AwardValue4
		  , CompletionText
		  , ExternalFulfillmentRequired
		  , RewardHistoryDetailDescription
		  , VHFRAJ.RewardActivityID
		  , VHFRAJ.ActivityName
		  , VHFRAJ.ActivityFreqOrCrit
		  , VHFRAJ.RewardActivityPeriodStart
		  , VHFRAJ.RewardActivityPeriodEnd
		  , VHFRAJ.RewardActivityLKPID
		  , VHFRAJ.ActivityPoints
		  , VHFRAJ.IsBundle
		  , VHFRAJ.IsRequired
		  , VHFRAJ.MaxThreshold
		  , VHFRAJ.AwardPointsIncrementally
		  , VHFRAJ.AllowMedicalExceptions
		  , VHFRAJ.BundleText
		  , RewardTriggerID
		  , HFLRT.RewardTriggerDynamicValue
		  , TriggerName
		  , RequirementDescription
		  , VHFRTPJ.RewardTriggerParameterOperator
		  , VHFRTPJ.Value
		  , vhfrtpj.ParameterDisplayName
		  , CASE
				WHEN CAST (VHFRPJ.DocumentCreatedWhen AS date) = CAST (VHFRPJ.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , VHFRPJ.DocumentCreatedWhen
		  , VHFRPJ.DocumentModifiedWhen
		  , RL_Joined.LevelName
		  , RL_Joined.LevelHeader
		  , RL_Joined.GroupHeadingText
		  , RL_Joined.GroupHeadingDescription
	   FROM dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
				INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON VHFRGJ.NodeID = RL_Joined.NodeParentID
				INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT
					ON RL_Joined.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ
					ON RL_Joined.NodeID = VHFRAJ.NodeParentID
				INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.nodeid = vhfrtpj.nodeparentid
				INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT
					ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
				INNER JOIN dbo.CMS_Site AS CS
					ON VHFRPJ.NodeSiteID = cs.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_RewardsDefinition found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_RewardTriggerParameters') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_RewardTriggerParameters , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--GRANT SELECT
--	ON [dbo].[view_EDW_RewardTriggerParameters]
--	TO [EDWReader_PRD]
--GO
--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = ''en-US'' AND VHFRTPJ.DocumentCulture = ''en-US''
--				This appears to have eliminated the Spanish.
--********************************************************************************************************

CREATE VIEW dbo.view_EDW_RewardTriggerParameters
AS

	 --8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
	 --8/8/2014 - Generated corrected view in DEV (WDM)

	 SELECT DISTINCT
			cs.SiteGUID
		  , VHFRTJ.RewardTriggerID
		  , VHFRTJ.TriggerName
		  , HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName
		  , VHFRTPJ.ParameterDisplayName
		  , VHFRTPJ.RewardTriggerParameterOperator
		  , VHFRTPJ.Value
		  , hfa.AccountID
		  , hfa.AccountCD
		  , CASE
				WHEN CAST (VHFRTJ.DocumentCreatedWhen AS date) = CAST (VHFRTJ.DocumentModifiedWhen AS date) 
				THEN ''I''
				ELSE ''U''
			END AS ChangeType
		  , VHFRTJ.DocumentGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRTJ.NodeGuid

			--WDM Added 8/7/2014 in case needed

		  , VHFRTJ.DocumentCreatedWhen
		  , VHFRTJ.DocumentModifiedWhen
		  , VHFRTPJ.DocumentModifiedWhen AS RewardTriggerParameter_DocumentModifiedWhen
		  , VHFRTPJ.documentculture AS documentculture_VHFRTPJ
		  , VHFRTJ.documentculture AS documentculture_VHFRTJ
	   FROM dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ

	 --dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ 		

				INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ
					ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
				INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO
					ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
				INNER JOIN dbo.CMS_Site AS CS
					ON VHFRTJ.NodeSiteID = cs.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs.SiteID = HFA.SiteID
	   WHERE VHFRTJ.DocumentCulture = ''en-US''
		 AND VHFRTPJ.DocumentCulture = ''en-US'';
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_RewardTriggerParameters found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_RewardUserDetail') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_RewardUserDetail , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW dbo.view_EDW_RewardUserDetail
AS
	 SELECT DISTINCT

	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription

			cu.UserGUID
   , CS2.SiteGUID
   , cus2.HFitUserMpiNumber
   , VHFRAJ.RewardActivityID
   , VHFRPJ.RewardProgramName
   , VHFRPJ.RewardProgramID
   , VHFRPJ.RewardProgramPeriodStart
   , VHFRPJ.RewardProgramPeriodEnd
   , VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
   , VHFRGJ.GroupName
   , VHFRGJ.RewardGroupID
   , VHFRGJ.RewardGroupPeriodStart
   , VHFRGJ.RewardGroupPeriodEnd
   , VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
   , RL_Joined.Level
   , HFLRLT.RewardLevelTypeLKPName
   , RL_Joined.DocumentModifiedWhen AS RewardLevelModifiedDate
   , HFRULD.LevelCompletedDt
   , HFRULD.LevelVersionHistoryID
   , RL_Joined.RewardLevelPeriodStart
   , RL_Joined.RewardLevelPeriodEnd
   , VHFRAJ.ActivityName
   , HFRUAD.ActivityPointsEarned
   , HFRUAD.ActivityCompletedDt
   , HFRUAD.ActivityVersionID
   , HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate
   , VHFRAJ.RewardActivityPeriodStart
   , VHFRAJ.RewardActivityPeriodEnd
   , VHFRAJ.ActivityPoints
   , HFRE.UserAccepted
   , HFRE.UserExceptionAppliedTo
   , HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate
   , VHFRTJ.TriggerName
   , VHFRTJ.RewardTriggerID
   , HFLRT2.RewardTriggerLKPDisplayName
   , HFLRT2.RewardTriggerDynamicValue
   , HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
   , HFLRT.RewardTypeLKPName
   , HFA.AccountID
   , HFA.AccountCD
   , CASE
		 WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
		 THEN ''I''
		 ELSE ''U''
	 END AS ChangeType
   , HFRULD.ItemCreatedWhen
   , HFRULD.ItemModifiedWhen
   , RL_Joined.LevelName
   , RL_Joined.LevelHeader
   , RL_Joined.GroupHeadingText
   , RL_Joined.GroupHeadingDescription
	   FROM dbo.View_HFit_RewardProgram_Joined AS VHFRPJ
				LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ
					ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
				LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON VHFRGJ.NodeID = RL_Joined.NodeParentID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT
					ON RL_Joined.AwardType = HFLRT.RewardTypeLKPID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT
					ON RL_Joined.LevelType = HFLRLT.RewardLevelTypeLKPID
				INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD
					ON RL_Joined.NodeID = HFRULD.LevelNodeID
				INNER JOIN dbo.CMS_User AS CU
					ON hfruld.UserID = cu.UserID
				INNER JOIN dbo.CMS_UserSite AS CUS
					ON CU.UserID = CUS.UserID
				INNER JOIN dbo.CMS_Site AS CS2
					ON CUS.SiteID = CS2.SiteID
				INNER JOIN dbo.HFit_Account AS HFA
					ON cs2.SiteID = HFA.SiteID
				INNER JOIN dbo.CMS_UserSettings AS CUS2
					ON cu.UserID = cus2.UserSettingsUserID
				LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ
					ON RL_Joined.NodeID = VHFRAJ.NodeParentID
				INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD
					ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
				LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ
					ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
				LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2
					ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
				LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE
					ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				   AND HFRE.UserID = cu.UserID;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_RewardUserDetail found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_RewardUserLevel') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_RewardUserLevel , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW view_EDW_RewardUserLevel
AS

	 --***************************************************************************************************
	 --Changes:
	 --01.20.2015 - (WDM) Added RL_Joined.nodeguid to satisfy #38393
	 --02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription, SiteGuid
	 --***************************************************************************************************

	 SELECT DISTINCT
			us.UserId
		  , dl.LevelCompletedDt
		  , RL_Joined.NodeName AS LevelName
		  , s.SiteName
		  , RL_Joined.nodeguid
		  , s.SiteGuid
		  , RL_Joined.LevelHeader
		  , RL_Joined.GroupHeadingText
		  , RL_Joined.GroupHeadingDescription
	   FROM HFit_RewardsUserLevelDetail AS dl
				INNER JOIN View_HFit_RewardLevel_Joined AS RL_Joined
					ON RL_Joined.NodeId = dl.LevelNodeId
				JOIN CMS_UserSite AS us
					ON us.UserId = dl.UserId
				JOIN CMS_Site AS s
					ON s.SiteId = us.SiteId;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_RewardUserLevel found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_ScreeningsFromTrackers') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_ScreeningsFromTrackers , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '
--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT
	t.userid
	, t.EventDate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, t.ItemCreatedWhen
	, t.ItemModifiedBy
	, t.ItemModifiedWhen
FROM
	(
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBloodPressure
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBloodSugarAndGlucose
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBMI
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBodyFat
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerBodyMeasurements
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerCardio
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerCholesterol
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerDailySteps
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerFlexibility
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerFruits
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHbA1c
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHeight
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHighFatFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerHighSodiumFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerInstance_Tracker
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerMealPortions
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerMedicalCarePlan
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerRegularMeals
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerRestingHeartRate
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerShots
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSitLess
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSleepPlan
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStrength
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStress
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerStressManagement
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSugaryDrinks
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerSugaryFoods
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerTests
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerTobaccoFree
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerVegetables
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWater
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWeight
		UNION ALL
		SELECT
			userid
			, eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, ItemCreatedWhen
			, ItemModifiedBy
			, ItemModifiedWhen
		FROM
			HFit_TrackerWholeGrains
	) as T
INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS ON t.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
WHERE HFTCS.isProfessionallyCollected = 1


';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_ScreeningsFromTrackers found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_SmallStepResponses') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_SmallStepResponses , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW dbo.view_EDW_SmallStepResponses
AS

	 --********************************************************************************************************
	 --02.13.2014 : (Sowmiya Venkiteswaran) : Updated the view to include  the fields:
	 --AccountCD, SiteGUID,SSOutcomeMessage as info. text,
	 -- Small Steps Program Info( HACampaignNodeGUID,HACampaignName,HACampaignStartDate,HACampaignEndDate)
	 -- HAUserStartedRecord Info (HAStartedDate,HACompletedDate,HAStartedMode,HACompletedMode)
	 -- Added filters by document culture and replacing HTML quote with a SQL single quote
	 --********************************************************************************************************
	 --02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning - removed the following WHERE clause and 
	 --			incorporated them into the JOIN statements for perfoamnce enhancement.
	 -- WHERE vwOutcome.DocumentCulture = ''en-US'' AND vwCamp.DocumentCulture = ''en-US'';
	 --********************************************************************************************************
	 --02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning
	 --	Prod1, 2 and 3 Labs - Incorporated doc. culture to the Joins
	 -- 1 - executed DBCC dropcleanbuffers everytime
	 -- 2 - Tested REPLACE against No REPLACE, insignificant perf. hit.
	 -- Test Controls:
	 -- Prod1 Lab - NO SQL DISTINCT - 184311 ( rows) - 14 (seconds) 
	 -- Prod1 Lab - WITH SQL DISTINCT - 184311 ( rows) - 32 (seconds) 
	 -- Prod2 Lab - NO SQL DISTINCT -  81120( rows) -  10(seconds) 
	 -- Prod2 Lab - WITH SQL DISTINCT - 81120 ( rows) -  22(seconds) 
	 -- Prod3 Lab - NO SQL DISTINCT - 136763 ( rows) - 10 (seconds) 
	 -- Prod3 Lab - WITH SQL DISTINCT - 136763 ( rows) -  21(seconds)  
	 --02.24.2015 (SV) - Added column SSHealthAssesmentUserStartedItemID per request from John C.
	 --********************************************************************************************************

	 SELECT
			ss.UserID
		  , acct.AccountCD
		  , ste.SiteGUID
		  , ss.ItemID AS SSItemID
		  , ss.ItemCreatedBy AS SSItemCreatedBy
		  , ss.ItemCreatedWhen AS SSItemCreatedWhen
		  , ss.ItemModifiedBy AS SSItemModifiedBy
		  , ss.ItemModifiedWhen AS SSItemModifiedWhen
		  , ss.ItemOrder AS SSItemOrder
		  , ss.ItemGUID AS SSItemGUID
		  , ss.HealthAssesmentUserStartedItemID AS SSHealthAssesmentUserStartedItemID
		  , ss.OutComeMessageGUID AS SSOutcomeMessageGuid
		  , REPLACE (vwOutcome.Message, ''&#39;'', '''''''') AS SSOutcomeMessage
		  , usrstd.HACampaignNodeGUID
		  , vwCamp.Name AS HACampaignName
		  , vwCamp.CampaignStartDate AS HACampaignStartDate
		  , vwCamp.CampaignEndDate AS HACampaignEndDate
		  , usrstd.HAStartedDt AS HAStartedDate
		  , usrstd.HACompletedDt AS HACompletedDate
		  , usrstd.HAStartedMode
		  , usrstd.HACompletedMode
	   FROM dbo.Hfit_SmallStepResponses AS ss
				JOIN HFit_HealthAssesmentUserStarted AS usrstd
					ON usrstd.UserID = ss.UserID
				   AND usrstd.ItemID = ss.HealthAssesmentUserStartedItemID
				JOIN View_HFit_HACampaign_Joined AS vwCamp
					ON vwCamp.NodeGuid = usrstd.HACampaignNodeGUID
				   AND vwCamp.DocumentCulture = ''en-US''
				JOIN View_HFit_OutComeMessages_Joined AS vwOutcome
					ON vwOutcome.NodeGUID = ss.OutComeMessageGUID
				   AND vwOutcome.DocumentCulture = ''en-US''
				JOIN CMS_UserSite AS usrste
					ON usrste.UserID = ss.UserID
				JOIN CMS_Site AS ste
					ON ste.SiteID = usrste.SiteID
				JOIN HFit_Account AS acct
					ON acct.SiteID = usrste.SiteID;
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_SmallStepResponses found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_TrackerCompositeDetails') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_TrackerCompositeDetails , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = 'CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
AS

	 --************************************************************************************************************************************
	 -- NOTES:
	 --************************************************************************************************************************************
	 --WDM 6/26/2014
	 --This view is needed by EDW in order to process the Tracker tables'' data.
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
	 --************************************************************************************************************************************
	 --USE:
	 --select * from view_EDW_TrackerCompositeDetails where EventDate between ''2013-11-01 15:02:00.000'' and ''2013-12-01 15:02:00.000''
	 --Set statistics IO ON
	 --GO

	 SELECT
			''HFit_TrackerBloodPressure'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''mm/Hg'' AS UOM
		  , ''Systolic'' AS KEY1
		  , CAST (Systolic AS float) AS VAL1
		  , ''Diastolic'' AS KEY2
		  , CAST (Diastolic AS float) AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  , ISNULL (T.UniqueName, ''bp'') AS UniqueName
		  , ISNULL (T.UniqueName, ''bp'') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodPressure AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerBloodPressure''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerBloodSugarAndGlucose'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''mmol/L'' AS UOM
		  , ''Units'' AS KEY1
		  , CAST (Units AS float) AS VAL1
		  , ''FastingState'' AS KEY2
		  , CAST (FastingState AS float) AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  , ISNULL (T.UniqueName, ''glucose'') AS UniqueName
		  , ISNULL (T.UniqueName, ''glucose'') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodSugarAndGlucose AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerBloodSugarAndGlucose''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerBMI'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''kg/m2'' AS UOM
		  , ''BMI'' AS KEY1
		  , CAST (BMI AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , 0 AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  , ISNULL (T.UniqueName, ''HFit_TrackerBMI'') AS UniqueName
		  , ISNULL (T.UniqueName, ''HFit_TrackerBMI'') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBMI AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerBMI''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerBodyFat'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''PCT'' AS UOM
		  , ''Value'' AS KEY1
		  , CAST ([Value] AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , 0 AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemModifiedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  , ISNULL (T.UniqueName, ''HFit_TrackerBodyFat'') AS UniqueName
		  , ISNULL (T.UniqueName, ''HFit_TrackerBodyFat'') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyFat AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerBodyFat''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION

	 --******************************************************************************

	 SELECT
			''HFit_TrackerBodyMeasurements'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Inch'' AS UOM
		  , ''WaistInches'' AS KEY1
		  , CAST (WaistInches AS float) AS VAL1
		  , ''HipInches'' AS KEY2
		  , CAST (HipInches AS float) AS VAL2
		  , ''ThighInches'' AS KEY3
		  , CAST (ThighInches AS float) AS VAL3
		  , ''ArmInches'' AS KEY4
		  , CAST (ArmInches AS float) AS VAL4
		  , ''ChestInches'' AS KEY5
		  , CAST (ChestInches AS float) AS VAL5
		  , ''CalfInches'' AS KEY6
		  , CAST (CalfInches AS float) AS VAL6
		  , ''NeckInches'' AS KEY7
		  , CAST (NeckInches AS float) AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemModifiedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerBodyMeasurements AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerBodyMeasurements''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID

	 --******************************************************************************

	 UNION
	 SELECT
			''HFit_TrackerCardio'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA'' AS UOM
		  , ''Minutes'' AS KEY1
		  , CAST (Minutes AS float) AS VAL1
		  , ''Distance'' AS KEY2
		  , CAST (Distance AS float) AS VAL2
		  , ''DistanceUnit'' AS KEY3
		  , CAST (DistanceUnit AS float) AS VAL3
		  , ''Intensity'' AS KEY4
		  , CAST (Intensity AS float) AS VAL4
		  , ''ActivityID'' AS KEY5
		  , CAST (ActivityID AS float) AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemModifiedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerCardio AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerCardio''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerCholesterol'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''mg/dL'' AS UOM
		  , ''HDL'' AS KEY1
		  , CAST (HDL AS float) AS VAL1
		  , ''LDL'' AS KEY2
		  , CAST (LDL AS float) AS VAL2
		  , ''Total'' AS KEY3
		  , CAST (Total AS float) AS VAL3
		  , ''Tri'' AS KEY4
		  , CAST (Tri AS float) AS VAL4
		  , ''Ratio'' AS KEY5
		  , CAST (Ratio AS float) AS VAL5
		  , ''Fasting'' AS KEY6
		  , CAST (Fasting AS float) AS VAL6
		  , ''VLDL'' AS VLDL
		  , CAST (VLDL AS float) AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  , ISNULL (T.UniqueName, ''HFit_TrackerCholesterol'') AS UniqueName
		  , ISNULL (T.UniqueName, ''HFit_TrackerCholesterol'') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerCholesterol AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerCholesterol''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerDailySteps'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Step'' AS UOM
		  , ''Steps'' AS KEY1
		  , CAST (Steps AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  , ISNULL (T.UniqueName, ''HFit_TrackerDailySteps'') AS UniqueName
		  , ISNULL (T.UniqueName, ''HFit_TrackerDailySteps'') AS ColDesc
		  , NULL AS VendorID

			--VENDOR.ItemID as VendorID

		  , NULL AS VendorName

	 --VENDOR.VendorName

	   FROM dbo.HFit_TrackerDailySteps AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerDailySteps''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerFlexibility'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Y/N'' AS UOM
		  , ''HasStretched'' AS KEY1
		  , CAST (HasStretched AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''Activity'' AS TXTKEY1
		  , Activity AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerFlexibility AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerFlexibility''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerFruits'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''CUP(8oz)'' AS UOM
		  , ''Cups'' AS KEY1
		  , CAST (Cups AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerFruits AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerFruits''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerHbA1c'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''mmol/mol'' AS UOM
		  , ''Value'' AS KEY1
		  , CAST ([Value] AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerHbA1c AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerHbA1c''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerHeight'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''inch'' AS UOM
		  , ''Height'' AS KEY1
		  , Height AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  , ISNULL (T.UniqueName, ''HFit_TrackerHeight'') AS UniqueName
		  , ISNULL (T.UniqueName, ''HFit_TrackerHeight'') AS ColDesc
		  , VENDOR.ItemID AS VendorID
		  , VENDOR.VendorName
	   FROM dbo.HFit_TrackerHeight AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerHeight''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerHighFatFoods'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Occurs'' AS UOM
		  , ''Times'' AS KEY1
		  , CAST (Times AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerHighFatFoods AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerHighFatFoods''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerHighSodiumFoods'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Occurs'' AS UOM
		  , ''Times'' AS KEY1
		  , CAST (Times AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerHighSodiumFoods AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerHighSodiumFoods''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerInstance_Tracker'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Y/N'' AS UOM
		  , ''TrackerDefID'' AS KEY1
		  , CAST (TrackerDefID AS float) AS VAL1
		  , ''YesNoValue'' AS KEY2
		  , CAST (YesNoValue AS float) AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerInstance_Tracker AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerInstance_Tracker''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerMealPortions'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA-portion'' AS UOM
		  , ''Portions'' AS KEY1
		  , CAST (Portions AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerMealPortions AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerMealPortions''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerMedicalCarePlan'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Y/N'' AS UOM
		  , ''FollowedPlan'' AS KEY1
		  , CAST (FollowedPlan AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerMedicalCarePlan AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerMedicalCarePlan''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerRegularMeals'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Occurs'' AS UOM
		  , ''Units'' AS KEY1
		  , CAST (Units AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerRegularMeals AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerRegularMeals''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerRestingHeartRate'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''BPM'' AS UOM
		  , ''HeartRate'' AS KEY1
		  , CAST (HeartRate AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerRestingHeartRate AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerRestingHeartRate''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerShots'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Y/N'' AS UOM
		  , ''FluShot'' AS KEY1
		  , CAST (FluShot AS float) AS VAL1
		  , ''PneumoniaShot'' AS KEY2
		  , CAST (PneumoniaShot AS float) AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerShots AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerShots''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerSitLess'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Occurs'' AS UOM
		  , ''Times'' AS KEY1
		  , CAST (Times AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerSitLess AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerSitLess''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerSleepPlan'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''HR'' AS UOM
		  , ''DidFollow'' AS KEY1
		  , CAST (DidFollow AS float) AS VAL1
		  , ''HoursSlept'' AS KEY2
		  , HoursSlept AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''Techniques'' AS TXTKEY1
		  , Techniques AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerSleepPlan AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerSleepPlan''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerStrength'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Y/N'' AS UOM
		  , ''HasTrained'' AS KEY1
		  , CAST (HasTrained AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''Activity'' AS TXTKEY1
		  , Activity AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerStrength AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerStrength''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerStress'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''gradient'' AS UOM
		  , ''Intensity'' AS KEY1
		  , CAST (Intensity AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''Awareness'' AS TXTKEY1
		  , Awareness AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerStress AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerStress''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerStressManagement'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''gradient'' AS UOM
		  , ''HasPracticed'' AS KEY1
		  , CAST (HasPracticed AS float) AS VAL1
		  , ''Effectiveness'' AS KEY2
		  , CAST (Effectiveness AS float) AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''Activity'' AS TXTKEY1
		  , Activity AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerStressManagement AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerStressManagement''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerSugaryDrinks'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''OZ'' AS UOM
		  , ''Ounces'' AS KEY1
		  , CAST (Ounces AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerSugaryDrinks AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerSugaryDrinks''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerSugaryFoods'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA-portion'' AS UOM
		  , ''Portions'' AS KEY1
		  , CAST (Portions AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerSugaryFoods AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerSugaryFoods''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerTests'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA'' AS UOM
		  , ''PSATest'' AS KEY1
		  , CAST (PSATest AS float) AS VAL1
		  , ''OtherExam'' AS KEY1
		  , CAST (OtherExam AS float) AS VAL2
		  , ''TScore'' AS KEY3
		  , CAST (TScore AS float) AS VAL3
		  , ''DRA'' AS KEY4
		  , CAST (DRA AS float) AS VAL4
		  , ''CotinineTest'' AS KEY5
		  , CAST (CotinineTest AS float) AS VAL5
		  , ''ColoCareKit'' AS KEY6
		  , CAST (ColoCareKit AS float) AS VAL6
		  , ''CustomTest'' AS KEY7
		  , CAST (CustomTest AS float) AS VAL7
		  , ''TSH'' AS KEY8
		  , CAST (TSH AS float) AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''CustomDesc'' AS TXTKEY1
		  , CustomDesc AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerTests AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerTests''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerTobaccoFree'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''Y/N'' AS UOM
		  , ''WasTobaccoFree'' AS KEY1
		  , CAST (WasTobaccoFree AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''QuitAids'' AS TXTKEY1
		  , QuitAids AS TXTVAL1
		  , ''QuitMeds'' AS TXTKEY2
		  , QuitMeds AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerTobaccoFree AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerTobaccoFree''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerVegetables'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''CUP(8oz)'' AS UOM
		  , ''Cups'' AS KEY1
		  , CAST (Cups AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerVegetables AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerVegetables''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerWater'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''OZ'' AS UOM
		  , ''Ounces'' AS KEY1
		  , CAST (Ounces AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerWater AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerWater''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerWeight'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''LBS'' AS UOM
		  , ''Value'' AS KEY1
		  , [Value] AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerWeight AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerWeight''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerWholeGrains'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , CollectionSourceName_Internal
		  , CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA-serving'' AS UOM
		  , ''Servings'' AS KEY1
		  , CAST (Servings AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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

	   FROM dbo.HFit_TrackerWholeGrains AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerWholeGrains''

	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID

	 UNION
	 SELECT
			''HFit_TrackerShots'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA'' AS UOM
		  , ''FluShot'' AS KEY1
		  , CAST (FluShot AS float) AS VAL1
		  , ''PneumoniaShot'' AS KEY2
		  , CAST (PneumoniaShot AS float) AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerShots AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerShots''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerTests'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA'' AS UOM
		  , ''PSATest'' AS KEY1
		  , CAST (PSATest AS float) AS VAL1
		  , ''OtherExam'' AS KEY2
		  , CAST (OtherExam AS float) AS VAL2
		  , ''TScore'' AS KEY3
		  , CAST (TScore AS float) AS VAL3
		  , ''DRA'' AS KEY4
		  , CAST (DRA AS float) AS VAL4
		  , ''CotinineTest'' AS KEY5
		  , CAST (CotinineTest AS float) AS VAL5
		  , ''ColoCareKit'' AS KEY6
		  , CAST (ColoCareKit AS float) AS VAL6
		  , ''CustomTest'' AS KEY7
		  , CAST (CustomTest AS float) AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , NULL AS IsProcessedForHa
		  , ''CustomDesc'' AS TXTKEY1
		  , CustomDesc AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
	   FROM dbo.HFit_TrackerTests AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerTests''
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT
			''HFit_TrackerCotinine'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA'' AS UOM
		  , ''NicotineAssessment'' AS KEY1
		  , CAST (NicotineAssessment AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  ,

			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,

			NULL AS VendorID
		  , NULL AS VendorName
	   FROM dbo.HFit_TrackerCotinine AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerTests''

	 --LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
	 --	ON TT.VendorID = VENDOR.ItemID;

	 UNION
	 SELECT
			''HFit_TrackerPreventiveCare'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA'' AS UOM
		  , ''PreventiveCare'' AS KEY1
		  , CAST (PreventiveCare AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  ,

			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,

			NULL AS VendorID
		  , NULL AS VendorName
	   FROM dbo.HFit_TrackerPreventiveCare AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerTests''

	 --LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
	 --	ON TT.VendorID = VENDOR.ItemID;

	 UNION
	 SELECT
			''HFit_TrackerTobaccoAttestation'' AS TrackerNameAggregateTable
		  , TT.ItemID
		  , EventDate
		  , TT.IsProfessionallyCollected
		  , TT.TrackerCollectionSourceID
		  , Notes
		  , TT.UserID
		  , NULL AS CollectionSourceName_Internal
		  , NULL AS CollectionSourceName_External
		  , ''MISSING'' AS EventName
		  , ''NA'' AS UOM
		  , ''TobaccoAttestation'' AS KEY1
		  , CAST (TobaccoAttestation AS float) AS VAL1
		  , ''NA'' AS KEY2
		  , NULL AS VAL2
		  , ''NA'' AS KEY3
		  , NULL AS VAL3
		  , ''NA'' AS KEY4
		  , NULL AS VAL4
		  , ''NA'' AS KEY5
		  , NULL AS VAL5
		  , ''NA'' AS KEY6
		  , NULL AS VAL6
		  , ''NA'' AS KEY7
		  , NULL AS VAL7
		  , ''NA'' AS KEY8
		  , NULL AS VAL8
		  , ''NA'' AS KEY9
		  , NULL AS VAL9
		  , ''NA'' AS KEY10
		  , NULL AS VAL10
		  , TT.ItemCreatedBy
		  , TT.ItemCreatedWhen
		  , TT.ItemModifiedBy
		  , TT.ItemModifiedWhen
		  , IsProcessedForHa
		  , ''NA'' AS TXTKEY1
		  , NULL AS TXTVAL1
		  , ''NA'' AS TXTKEY2
		  , NULL AS TXTVAL2
		  , ''NA'' AS TXTKEY3
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
		  ,

			--VENDOR.ItemID AS VendorID ,
			--VENDOR.VendorName,

			NULL AS VendorID
		  , NULL AS VendorName
	   FROM dbo.HFit_TrackerTobaccoAttestation AS TT
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
					ON T.AggregateTableName = ''HFit_TrackerTests'';

--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_TrackerCompositeDetails found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_TrackerMetadata') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_TrackerMetadata , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '

CREATE View [dbo].[view_EDW_TrackerMetadata]
as
--******************************************************************************************************
--TableName - this is the CMS_CLASS ClassName and is used to identify the needed metadata. 
--ColumnName - Each Class has a set of columns. This is the name of the column as contained
--				within the CLASS.
--AttrName - The name of the attribute as it applies to the column (e.g. column type 
--				describes the datatype of the column (ColName) within the CLASS (ClassName).
--AttrVal - the value assigned to the AttrName.
--CreatedDate - the date this row of metadata was created.
--LastModifiedDate - the date this row of metadata was last changed in the Tracker_EDW_Metadata table.
--ID - An identity field within the Tracker_EDW_Metadata table.
--ClassLastModified - The last date the CLASS within CMS_CLASS was changed.
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--******************************************************************************************************
SELECT TableName, ColName, AttrName, AttrVal, CreatedDate, LastModifiedDate, ID, CMS_CLASS.ClassLastModified
FROM     Tracker_EDW_Metadata
join CMS_CLASS on CMS_CLASS.ClassName = TableName


';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_TrackerMetadata found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_TrackerShots') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_TrackerShots , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerShots]
AS
	SELECT
		HFTS.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTS.ItemID
		, HFTS.EventDate
		, HFTS.IsProfessionallyCollected
		, HFTS.TrackerCollectionSourceID
		, HFTS.Notes
		, HFTS.FluShot
		, HFTS.PneumoniaShot
		, HFTS.ItemCreatedWhen
		, HFTS.ItemModifiedWhen
		, HFTS.ItemGUID
	FROM
		dbo.HFit_TrackerShots AS HFTS
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTS.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID

';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_TrackerShots found - passed check.') ;
--*****************************************************************************
     GO

--*****************************************************************************
     if not exists (select name from sys.views where name = 'view_EDW_TrackerTests') 
     BEGIN
          PRINT ('**************************************************') ;
          PRINT ('* ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ') ;
          PRINT ('* MISSING VIEW view_EDW_TrackerTests , created. ') ;
          PRINT ('**************************************************') ;
          DECLARE @MSQL as nvarchar(max) = '' ;
          Set @MSQL = '

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerTests]
AS
	SELECT
		HFTT.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTT.EventDate
		, HFTT.IsProfessionallyCollected
		, HFTT.TrackerCollectionSourceID
		, HFTT.Notes
		, HFTT.PSATest
		, HFTT.OtherExam
		, HFTT.TScore
		, HFTT.DRA
		, HFTT.CotinineTest
		, HFTT.ColoCareKit
		, HFTT.CustomTest
		, HFTT.CustomDesc
		, HFTT.TSH
		, HFTT.ItemCreatedWhen
		, HFTT.ItemModifiedWhen
		, HFTT.ItemGUID
	FROM
		dbo.HFit_TrackerTests AS HFTT
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTT.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID
';
          EXEC (@MSQL);
     END
     ELSE
          PRINT ('VIEW: view_EDW_TrackerTests found - passed check.') ;
--*****************************************************************************
     GO

