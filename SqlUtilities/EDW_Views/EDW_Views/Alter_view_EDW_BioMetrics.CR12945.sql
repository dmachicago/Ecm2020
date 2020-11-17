
PRINT 'Altering view_EDW_BioMetrics';
GO
ALTER VIEW dbo.view_EDW_BioMetrics
AS
	 --*****************************************************************************************************************************************
	 --************** TEST Criteria and Results for view_EDW_BioMetrics ************************************************************************
	 --INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01',17  )  
	 --NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
	 --GO	--Tested by wdm on 11.21.2014

	 -- select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9

	 --select * from view_EDW_BioMetrics	 where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
	 --select * from view_Hfit_BioMetrics where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 

	 --select * from view_EDW_BioMetrics	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 
	 --select * from view_EDW_BioMetrics	where AccountCD = 'peaboOK dy' and EventDate < '2013-12-01 00:00:00.000'		: 9 

	 --select count(*) from view_EDW_BioMetrics		--NO REJECT FILTER : 136348
	 --select count(*) from view_EDW_BioMetrics		--REJECT FILTER ON : 136339 == 9 GOOD TEST

	 --select count(*) from view_Hfit_BioMetrics	:136393
	 --select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348

	 --NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014

	 --truncate table EDW_BiometricViewRejectCriteria

	 --INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01',-1)         
	 --NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
	 --GO	--Tested by wdm on 11.21.2014

	 --select * from view_EDW_BioMetrics where ItemCreatedWhen < '2013-12-01' and AccountCD = 'peabody' returns 1034
	 --		so the number should be 43814 - 1034 = 42780 with AccountCD = 'peabody' and ItemCreatedWhen = '2014-03-19'
	 --		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	 --GO	--Tested by wdm on 11.21.2014

	 --select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
	 --		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
	 --		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	 --GO	--Tested by wdm on 11.21.2014

	 --	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.

	 -- select * from EDW_BiometricViewRejectCriteria
	 -- truncate table EDW_BiometricViewRejectCriteria
	 --select count(*) from view_EDW_BioMetrics

	 -- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
	 -- 12.28.20145 - (WDM) This update will apply to CR12945

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
   , 'Not Build Yet' AS EventName

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
		 WHEN HFUT.ItemCreatedWhen = COALESCE (HFUT.ItemModifiedWhen , hfut.ItemCreatedWhen) 
		   THEN 'I'
		 ELSE 'U'
	 END AS ChangeType
   , HFUT.ItemCreatedWhen
   , HFUT.ItemModifiedWhen
   , 0 AS TrackerCollectionSourceID
   , HFUT.itemid							-- CR12945
   , 'HFit_UserTracker' AS TBL				-- CR12945
	   FROM dbo.HFit_UserTracker AS HFUT WITH (NOLOCK) 
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON hfut.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE HFUT.ItemCreatedWhen < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND HFUT.ItemCreatedWhen < ItemCreatedWhen) 
			 --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
		 AND HFUT.ItemCreatedWhen IS NOT NULL		--Add per Robert and Laura 12.4.2014

	 UNION ALL
	 SELECT hftw.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTW.ItemCreatedWhen
		  , HFTW.ItemModifiedWhen
		  , HFTW.Notes
		  , HFTW.IsProfessionallyCollected
		  , HFTW.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTW.ItemCreatedWhen = COALESCE (HFTW.ItemModifiedWhen , HFTW.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTW.ItemCreatedWhen
		  , HFTW.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTW.itemid
		  , 'HFit_TrackerWeight' AS TBL
	   FROM dbo.HFit_TrackerWeight AS HFTW WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTW.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria	  
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTW.EventDate , HFTW.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTW.EventDate , HFTW.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTW.ItemCreatedWhen IS NOT NULL
		   OR HFTW.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014			

	 UNION ALL
	 SELECT HFTHA.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTHA.ItemCreatedWhen
		  , HFTHA.ItemModifiedWhen
		  , HFTHA.Notes
		  , HFTHA.IsProfessionallyCollected
		  , HFTHA.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTHA.ItemCreatedWhen = COALESCE (HFTHA.ItemModifiedWhen , HFTHA.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTHA.ItemCreatedWhen
		  , HFTHA.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTHA.itemid
		  , 'HFit_TrackerHbA1c' AS TBL
	   FROM dbo.HFit_TrackerHbA1c AS HFTHA WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTHA.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTHA.EventDate , HFTHA.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTHA.EventDate , HFTHA.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTHA.ItemCreatedWhen IS NOT NULL
		   OR HFTHA.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTC.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTC.ItemCreatedWhen
		  , HFTC.ItemModifiedWhen
		  , HFTC.Notes
		  , HFTC.IsProfessionallyCollected
		  , HFTC.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTC.ItemCreatedWhen = COALESCE (HFTC.ItemModifiedWhen , HFTC.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTC.ItemCreatedWhen
		  , HFTC.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTC.itemid
		  , 'HFit_TrackerCholesterol' AS TBL
	   FROM dbo.HFit_TrackerCholesterol AS HFTC WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTC.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTC.EventDate , HFTC.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTC.EventDate , HFTC.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTC.ItemCreatedWhen IS NOT NULL
		   OR HFTC.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTBSAG.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBSAG.ItemCreatedWhen
		  , HFTBSAG.ItemModifiedWhen
		  , HFTBSAG.Notes
		  , HFTBSAG.IsProfessionallyCollected
		  , HFTBSAG.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTBSAG.ItemCreatedWhen = COALESCE (HFTBSAG.ItemModifiedWhen , HFTBSAG.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBSAG.ItemCreatedWhen
		  , HFTBSAG.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBSAG.itemid
		  , 'HFit_TrackerBloodSugarAndGlucose' AS TBL
	   FROM dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTBSAG.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBSAG.EventDate , HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBSAG.EventDate , HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBSAG.ItemCreatedWhen IS NOT NULL
		   OR HFTBSAG.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTBP.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBP.ItemCreatedWhen
		  , HFTBP.ItemModifiedWhen
		  , HFTBP.Notes
		  , HFTBP.IsProfessionallyCollected
		  , HFTBP.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTBP.ItemCreatedWhen = COALESCE (HFTBP.ItemModifiedWhen , HFTBP.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBP.ItemCreatedWhen
		  , HFTBP.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBP.itemid
		  , 'HFit_TrackerBloodPressure' AS TBL
	   FROM dbo.HFit_TrackerBloodPressure AS HFTBP WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTBP.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBP.EventDate , HFTBP.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBP.EventDate , HFTBP.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBP.ItemCreatedWhen IS NOT NULL
		   OR HFTBP.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTBF.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBF.ItemCreatedWhen
		  , HFTBF.ItemModifiedWhen
		  , HFTBF.Notes
		  , HFTBF.IsProfessionallyCollected
		  , HFTBF.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTBF.ItemCreatedWhen = COALESCE (HFTBF.ItemModifiedWhen , HFTBF.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBF.ItemCreatedWhen
		  , HFTBF.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBF.itemid
		  , 'HFit_TrackerBodyFat' AS TBL
	   FROM dbo.HFit_TrackerBodyFat AS HFTBF WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTBF.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBF.EventDate , HFTBF.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBF.EventDate , HFTBF.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBF.ItemCreatedWhen IS NOT NULL
		   OR HFTBF.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTB.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTB.ItemCreatedWhen
		  , HFTB.ItemModifiedWhen
		  , HFTB.Notes
		  , HFTB.IsProfessionallyCollected
		  , HFTB.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTB.ItemCreatedWhen = COALESCE (HFTB.ItemModifiedWhen , HFTB.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTB.ItemCreatedWhen
		  , HFTB.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTB.itemid
		  , 'HFit_TrackerBMI' AS TBL
	   FROM dbo.HFit_TrackerBMI AS HFTB WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTB.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTB.EventDate , HFTB.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTB.EventDate , HFTB.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTB.ItemCreatedWhen IS NOT NULL
		   OR HFTB.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTBM.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTBM.ItemCreatedWhen
		  , HFTBM.ItemModifiedWhen
		  , HFTBM.Notes
		  , HFTBM.IsProfessionallyCollected
		  , HFTBM.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTBM.ItemCreatedWhen = COALESCE (HFTBM.ItemModifiedWhen , HFTBM.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTBM.ItemCreatedWhen
		  , HFTBM.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTBM.itemid
		  , 'HFit_TrackerBodyMeasurements' AS TBL
	   FROM dbo.HFit_TrackerBodyMeasurements AS HFTBM WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTBM.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTBM.EventDate , HFTBM.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTBM.EventDate , HFTBM.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTBM.ItemCreatedWhen IS NOT NULL
		   OR HFTBM.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTH.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTH.ItemCreatedWhen
		  , HFTH.ItemModifiedWhen
		  , HFTH.Notes
		  , HFTH.IsProfessionallyCollected
		  , HFTH.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTH.ItemCreatedWhen = COALESCE (HFTH.ItemModifiedWhen , HFTH.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTH.ItemCreatedWhen
		  , HFTH.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTH.itemid
		  , 'HFit_TrackerHeight' AS TBL
	   FROM dbo.HFit_TrackerHeight AS HFTH WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTH.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTH.EventDate , HFTH.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTH.EventDate , HFTH.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTH.ItemCreatedWhen IS NOT NULL
		   OR HFTH.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014
	 UNION ALL
	 SELECT HFTRHR.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTRHR.ItemCreatedWhen
		  , HFTRHR.ItemModifiedWhen
		  , HFTRHR.Notes
		  , HFTRHR.IsProfessionallyCollected
		  , HFTRHR.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTRHR.ItemCreatedWhen = COALESCE (HFTRHR.ItemModifiedWhen , HFTRHR.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTRHR.ItemCreatedWhen
		  , HFTRHR.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTRHR.itemid
		  , 'HFit_TrackerRestingHeartRate' AS TBL
	   FROM dbo.HFit_TrackerRestingHeartRate AS HFTRHR WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTRHR.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTRHR.EventDate , HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTRHR.EventDate , HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTRHR.ItemCreatedWhen IS NOT NULL
		   OR HFTRHR.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTS.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTS.ItemCreatedWhen
		  , HFTS.ItemModifiedWhen
		  , HFTS.Notes
		  , HFTS.IsProfessionallyCollected
		  , HFTS.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTS.ItemCreatedWhen = COALESCE (HFTS.ItemModifiedWhen , HFTS.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTS.ItemCreatedWhen
		  , HFTS.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTS.itemid
		  , 'HFit_TrackerShots' AS TBL
	   FROM dbo.HFit_TrackerShots AS HFTS WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTS.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTS.EventDate , HFTS.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTS.EventDate , HFTS.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTS.ItemCreatedWhen IS NOT NULL
		   OR HFTS.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

	 UNION ALL
	 SELECT HFTT.UserID
		  , cus.UserSettingsUserGUID
		  , cus.HFitUserMpiNumber
		  , cus2.SiteID
		  , cs.SiteGUID
		  , HFTT.ItemCreatedWhen
		  , HFTT.ItemModifiedWhen
		  , HFTT.Notes
		  , HFTT.IsProfessionallyCollected
		  , HFTT.EventDate
		  , 'Not Build Yet' AS EventName
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
				WHEN HFTT.ItemCreatedWhen = COALESCE (HFTT.ItemModifiedWhen , HFTT.ItemCreatedWhen) 
				  THEN 'I'
				ELSE 'U'
			END AS ChangeType
		  , HFTT.ItemCreatedWhen
		  , HFTT.ItemModifiedWhen
		  , HFTCS.TrackerCollectionSourceID
		  , HFTT.itemid
		  , 'HFit_TrackerTests' AS TBL
	   FROM dbo.HFit_TrackerTests AS HFTT WITH (NOLOCK) 
				INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH (NOLOCK) 
					ON HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
				INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
					ON HFTT.UserID = cus.UserSettingsUserID
				INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
					ON cus.UserSettingsUserID = cus2.UserID
				INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
					ON CUS2.SiteID = CS.SiteID
				INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
					ON cs.SiteID = HFA.SiteID
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	   WHERE CS.SITEID NOT IN (
							   SELECT SiteID
								 FROM EDW_BiometricViewRejectCriteria
								 WHERE COALESCE (HFTT.EventDate , HFTT.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND HFA.AccountCD NOT IN (
								   SELECT AccountCD
									 FROM EDW_BiometricViewRejectCriteria
									 WHERE HFA.AccountCD = AccountCD
									   AND COALESCE (HFTT.EventDate , HFTT.ItemCreatedWhen) < ItemCreatedWhen) 
		 AND (HFTT.ItemCreatedWhen IS NOT NULL
		   OR HFTT.EventDate IS NOT NULL);		--Add per RObert and Laura 12.4.2014

--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests
GO

PRINT 'Successfully Altered view_EDW_BioMetrics';
GO
