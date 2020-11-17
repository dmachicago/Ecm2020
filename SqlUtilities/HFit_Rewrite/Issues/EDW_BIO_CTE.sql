WITH BIO_CTE
(
	[UserID]
	,[UserGUID]
	,[HFitUserMpiNumber]
	,[SiteID]
	,[SiteGUID]
	,[CreatedDate]
	,[ModifiedDate]
	,[Notes]
	,[IsProfessionallyCollected]
	,[EventDate]
	,[EventName]
	,[PPTWeight]
	,[PPTHbA1C]
	,[Fasting]
	,[HDL]
	,[LDL]
	,[Ratio]
	,[Total]
	,[Triglycerides]
	,[Glucose]
	,[FastingState]
	,[Systolic]
	,[Diastolic]
	,[PPTBodyFatPCT]
	,[BMI]
	,[WaistInches]
	,[HipInches]
	,[ThighInches]
	,[ArmInches]
	,[ChestInches]
	,[CalfInches]
	,[NeckInches]
	,[Height]
	,[HeartRate]
	,[FluShot]
	,[PneumoniaShot]
	,[PSATest]
	,[OtherExam]
	,[TScore]
	,[DRA]
	,[CotinineTest]
	,[ColoCareKit]
	,[CustomTest]
	,[CustomDesc]
	,[CollectionSource]
	,[AccountID]
	,[AccountCD]
	,[ChangeType]
	,[ItemCreatedWhen]
	,[ItemModifiedWhen]
	,[TrackerCollectionSourceID]
	,TBL
)
AS
(
	SELECT DISTINCT
			--HFit_UserTracker
			HFUT.UserID
			,cus.UserSettingsUserGUID AS UserGUID
			,cus.HFitUserMpiNumber
			,cus2.SiteID
			,cs.SiteGUID
			,NULL AS CreatedDate
			,NULL AS ModifiedDate
			,NULL AS Notes
			,NULL AS IsProfessionallyCollected
			,NULL AS EventDate
			,'Not Build Yet' AS EventName
       
			--HFit_TrackerWeight
			,NULL AS PPTWeight
       
			--HFit_TrackerHbA1C
			,NULL AS PPTHbA1C
       
			--HFit_TrackerCholesterol
			,NULL AS Fasting
			,NULL AS HDL
			,NULL AS LDL
			,NULL AS Ratio
			,NULL AS Total
			,NULL AS Triglycerides
       
			--HFit_TrackerBloodSugarandGlucose
			,NULL AS Glucose
			,NULL AS FastingState
       
			--HFit_TrackerBloodPressure
			,NULL AS Systolic
			,NULL AS Diastolic
       
			--HFit_TrackerBodyFat
			,NULL AS PPTBodyFatPCT
       
			--HFit_TrackerBMI
			,NULL AS BMI
       
			--HFit_TrackerBodyMeasurements
			,NULL AS WaistInches
			,NULL AS HipInches
			,NULL AS ThighInches
			,NULL AS ArmInches
			,NULL AS ChestInches
			,NULL AS CalfInches
			,NULL AS NeckInches
       
			--HFit_TrackerHeight
			,NULL AS Height
       
			--HFit_TrackerRestingHeartRate
			,NULL AS HeartRate
			,
			--HFit_TrackerShots
			NULL AS FluShot
			,NULL AS PneumoniaShot
       
			--HFit_TrackerTests
			,NULL AS PSATest
			,NULL AS OtherExam
			,NULL AS TScore
			,NULL AS DRA
			,NULL AS CotinineTest
			,NULL AS ColoCareKit
			,NULL AS CustomTest
			,NULL AS CustomDesc
			,NULL AS CollectionSource
			,HFA.AccountID
			,HFA.AccountCD
			,CASE WHEN HFUT.ItemCreatedWhen = COALESCE(HFUT.ItemModifiedWhen, hfut.ItemCreatedWhen) THEN 'I'
				ELSE 'U'
			END AS ChangeType
			,HFUT.ItemCreatedWhen
			,HFUT.ItemModifiedWhen
			,0   As TrackerCollectionSourceID 
			,'HFit_UserTracker' as TBL
      FROM
      dbo.HFit_UserTracker AS HFUT WITH ( NOLOCK )
		  INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON hfut.UserID = cus.UserSettingsUserID
		  INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
		  INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
		  INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFUT.ItemCreatedWhen < ItemCreatedWhen)	  
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFUT.ItemCreatedWhen < ItemCreatedWhen)
			--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
			AND HFUT.ItemCreatedWhen is not NULL		--Add per Robert and Laura 12.4.2014

	  UNION ALL
      SELECT
        hftw.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTW.ItemCreatedWhen
       ,HFTW.ItemModifiedWhen
       ,HFTW.Notes
       ,HFTW.IsProfessionallyCollected
       ,HFTW.EventDate
       ,'Not Build Yet' AS EventName
       ,hftw.Value AS PPTWeight
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTW.ItemCreatedWhen = COALESCE(HFTW.ItemModifiedWhen, HFTW.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTW.ItemCreatedWhen
       ,HFTW.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerWeight' as TBL
      FROM
        dbo.HFit_TrackerWeight AS HFTW WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTW.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria	  
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTW.EventDate,HFTW.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTW.EventDate,HFTW.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTW.ItemCreatedWhen is not NULL or HFTW.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014			

      UNION ALL
      SELECT
        HFTHA.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTHA.ItemCreatedWhen
       ,HFTHA.ItemModifiedWhen
       ,HFTHA.Notes
       ,HFTHA.IsProfessionallyCollected
       ,HFTHA.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,HFTHA.Value AS PPTHbA1C
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTHA.ItemCreatedWhen = COALESCE(HFTHA.ItemModifiedWhen, HFTHA.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTHA.ItemCreatedWhen
       ,HFTHA.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerHbA1c' as TBL
      FROM
        dbo.HFit_TrackerHbA1c AS HFTHA WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTHA.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTHA.EventDate,HFTHA.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTHA.EventDate,HFTHA.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTHA.ItemCreatedWhen is not NULL or HFTHA.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTC.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTC.ItemCreatedWhen
       ,HFTC.ItemModifiedWhen
       ,HFTC.Notes
       ,HFTC.IsProfessionallyCollected
       ,HFTC.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,HFTC.Fasting
       ,HFTC.HDL
       ,HFTC.LDL
       ,HFTC.Ratio
       ,HFTC.Total
       ,HFTC.Tri
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTC.ItemCreatedWhen = COALESCE(HFTC.ItemModifiedWhen, HFTC.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTC.ItemCreatedWhen
       ,HFTC.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerCholesterol' as TBL
      FROM
        dbo.HFit_TrackerCholesterol AS HFTC WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTC.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTC.EventDate,HFTC.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTC.EventDate,HFTC.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTC.ItemCreatedWhen is not NULL or HFTC.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBSAG.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBSAG.ItemCreatedWhen
       ,HFTBSAG.ItemModifiedWhen
       ,HFTBSAG.Notes
       ,HFTBSAG.IsProfessionallyCollected
       ,HFTBSAG.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBSAG.Units
       ,HFTBSAG.FastingState
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBSAG.ItemCreatedWhen = COALESCE(HFTBSAG.ItemModifiedWhen, HFTBSAG.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBSAG.ItemCreatedWhen
       ,HFTBSAG.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerBloodSugarAndGlucose' as TBL
      FROM
        dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBSAG.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBSAG.EventDate,HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTBSAG.EventDate,HFTBSAG.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTBSAG.ItemCreatedWhen is not NULL or HFTBSAG.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBP.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBP.ItemCreatedWhen
       ,HFTBP.ItemModifiedWhen
       ,HFTBP.Notes
       ,HFTBP.IsProfessionallyCollected
       ,HFTBP.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBP.Systolic
       ,HFTBP.Diastolic
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBP.ItemCreatedWhen = COALESCE(HFTBP.ItemModifiedWhen, HFTBP.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBP.ItemCreatedWhen
       ,HFTBP.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerBloodPressure' as TBL
      FROM
        dbo.HFit_TrackerBloodPressure AS HFTBP WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBP.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBP.EventDate,HFTBP.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTBP.EventDate,HFTBP.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTBP.ItemCreatedWhen is not NULL or HFTBP.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBF.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBF.ItemCreatedWhen
       ,HFTBF.ItemModifiedWhen
       ,HFTBF.Notes
       ,HFTBF.IsProfessionallyCollected
       ,HFTBF.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBF.Value AS PPTBodyFatPCT
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBF.ItemCreatedWhen = COALESCE(HFTBF.ItemModifiedWhen, HFTBF.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBF.ItemCreatedWhen
       ,HFTBF.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerBodyFat' as TBL
      FROM
        dbo.HFit_TrackerBodyFat AS HFTBF WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBF.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBF.EventDate,HFTBF.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND  COALESCE(HFTBF.EventDate,HFTBF.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTBF.ItemCreatedWhen is not NULL or HFTBF.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTB.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTB.ItemCreatedWhen
       ,HFTB.ItemModifiedWhen
       ,HFTB.Notes
       ,HFTB.IsProfessionallyCollected
       ,HFTB.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTB.BMI
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTB.ItemCreatedWhen = COALESCE(HFTB.ItemModifiedWhen, HFTB.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTB.ItemCreatedWhen
       ,HFTB.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerBMI' as TBL
      FROM
        dbo.HFit_TrackerBMI AS HFTB WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTB.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTB.EventDate,HFTB.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTB.EventDate,HFTB.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTB.ItemCreatedWhen is not NULL or HFTB.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBM.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBM.ItemCreatedWhen
       ,HFTBM.ItemModifiedWhen
       ,HFTBM.Notes
       ,HFTBM.IsProfessionallyCollected
       ,HFTBM.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBM.WaistInches
       ,HFTBM.HipInches
       ,HFTBM.ThighInches
       ,HFTBM.ArmInches
       ,HFTBM.ChestInches
       ,HFTBM.CalfInches
       ,HFTBM.NeckInches
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBM.ItemCreatedWhen = COALESCE(HFTBM.ItemModifiedWhen, HFTBM.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBM.ItemCreatedWhen
       ,HFTBM.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerBodyMeasurements' as TBL
      FROM
        dbo.HFit_TrackerBodyMeasurements AS HFTBM WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBM.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBM.EventDate,HFTBM.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTBM.EventDate,HFTBM.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTBM.ItemCreatedWhen is not NULL or HFTBM.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTH.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTH.ItemCreatedWhen
       ,HFTH.ItemModifiedWhen
       ,HFTH.Notes
       ,HFTH.IsProfessionallyCollected
       ,HFTH.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTH.Height
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTH.ItemCreatedWhen = COALESCE(HFTH.ItemModifiedWhen, HFTH.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTH.ItemCreatedWhen
       ,HFTH.ItemModifiedWhen 
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerHeight' as TBL
      FROM
		dbo.HFit_TrackerHeight AS HFTH WITH ( NOLOCK )
		INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
		INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTH.UserID = cus.UserSettingsUserID
		INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
		INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
		--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		
		Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTH.EventDate,HFTH.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTH.EventDate,HFTH.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTH.ItemCreatedWhen is not NULL or HFTH.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
      UNION ALL
      SELECT
        HFTRHR.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTRHR.ItemCreatedWhen
       ,HFTRHR.ItemModifiedWhen
       ,HFTRHR.Notes
       ,HFTRHR.IsProfessionallyCollected
       ,HFTRHR.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTRHR.HeartRate
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTRHR.ItemCreatedWhen = COALESCE(HFTRHR.ItemModifiedWhen, HFTRHR.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTRHR.ItemCreatedWhen
       ,HFTRHR.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerRestingHeartRate' as TBL
      FROM
        dbo.HFit_TrackerRestingHeartRate AS HFTRHR WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTRHR.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTRHR.EventDate,HFTRHR.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND  COALESCE(HFTRHR.EventDate,HFTRHR.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTRHR.ItemCreatedWhen is not NULL or HFTRHR.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTS.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTS.ItemCreatedWhen
       ,HFTS.ItemModifiedWhen
       ,HFTS.Notes
       ,HFTS.IsProfessionallyCollected
       ,HFTS.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTS.FluShot
       ,HFTS.PneumoniaShot
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTS.ItemCreatedWhen = COALESCE(HFTS.ItemModifiedWhen, HFTS.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTS.ItemCreatedWhen
       ,HFTS.ItemModifiedWhen
		,HFTCS.TrackerCollectionSourceID
		,'HFit_TrackerShots' as TBL
      FROM
        dbo.HFit_TrackerShots AS HFTS WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTS.EventDate,HFTS.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTS.EventDate,HFTS.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTS.ItemCreatedWhen is not NULL or HFTS.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTT.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTT.ItemCreatedWhen
       ,HFTT.ItemModifiedWhen
       ,HFTT.Notes
       ,HFTT.IsProfessionallyCollected
       ,HFTT.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTT.PSATest
       ,HFTT.OtherExam
       ,HFTT.TScore
       ,HFTT.DRA
       ,HFTT.CotinineTest
       ,HFTT.ColoCareKit
       ,HFTT.CustomTest
       ,HFTT.CustomDesc
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTT.ItemCreatedWhen = COALESCE(HFTT.ItemModifiedWhen, HFTT.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTT.ItemCreatedWhen
       ,HFTT.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,'HFit_TrackerTests' as TBL
      FROM
        dbo.HFit_TrackerTests AS HFTT WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTT.EventDate,HFTT.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTT.EventDate,HFTT.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTT.ItemCreatedWhen is not NULL or HFTT.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
)
Select * from BIO_CTE
where userguid='dc6d507d-8fa1-4c42-8929-0000bcb80bef' and SiteGUID='7eb5f3d0-fd01-444c-97d2-442c0b10d843' and ItemCreatedWhen='2014-12-17 19:43:58.430'

