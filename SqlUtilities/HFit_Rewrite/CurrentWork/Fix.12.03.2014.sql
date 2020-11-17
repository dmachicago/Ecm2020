
go
print ('Processing view_EDW_BioMetrics: ' +  cast(getdate() as nvarchar(50)) + '  *** view_EDW_BioMetrics.sql' );
GO


if NOT exists (Select name from sys.tables where name = 'EDW_BiometricViewRejectCriteria')
BEGIN
	print('EDW_BiometricViewRejectCriteria NOT found, creating');
	--This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
	CREATE TABLE dbo.EDW_BiometricViewRejectCriteria
	(
		--Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
		AccountCD nvarchar(8) NOT NULL,
		ItemCreatedWhen datetime NOT NULL,
		SiteID int NOT NULL,
		RejectGUID uniqueidentifier NULL
	) ;

	ALTER TABLE dbo.EDW_BiometricViewRejectCriteria ADD CONSTRAINT
		DF_EDW_BiometricViewRejectCriteria_RejectGUID DEFAULT newid() FOR RejectGUID ;

	ALTER TABLE dbo.EDW_BiometricViewRejectCriteria SET (LOCK_ESCALATION = TABLE) ;
	
	EXEC sp_addextendedproperty 
    @name = N'PURPOSE', @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria' ;
    --@level2type = N'Column', @level2name = NULL

	EXEC sp_addextendedproperty 
    @name = N'MS_Description', @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'AccountCD' ;

	EXEC sp_addextendedproperty 
    @name = N'USAGE', @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'SiteID' ;

	EXEC sp_addextendedproperty 
    @name = N'USAGE', @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'ItemCreatedWhen' ;
END
GO


if exists (Select name from sys.views where name = 'view_EDW_BiometricViewRejectCriteria')
BEGIN
	print('view_EDW_BiometricViewRejectCriteria found, updating');
	drop view view_EDW_BiometricViewRejectCriteria ;
END
GO

create view view_EDW_BiometricViewRejectCriteria
as
SELECT [AccountCD]
      ,[ItemCreatedWhen]
      ,[SiteID]
      ,[RejectGUID]
  FROM [dbo].[EDW_BiometricViewRejectCriteria]
GO
print('view_EDW_BiometricViewRejectCriteria, updated');
GO

if not exists (select name from sys.indexes where name = 'PKI_EDW_BiometricViewRejectCriteria')
BEGIN
	print('PKI_EDW_BiometricViewRejectCriteria NOT found, creating');
	CREATE UNIQUE CLUSTERED INDEX [PKI_EDW_BiometricViewRejectCriteria] ON [dbo].[EDW_BiometricViewRejectCriteria]
	(
		[AccountCD] ASC,
		[ItemCreatedWhen] ASC,
		[SiteID] ASC
	) ;
END
ELSE
	print('PKI_EDW_BiometricViewRejectCriteria created');

GO

if exists (select name from sys.procedures where name = 'proc_Insert_EDW_BiometricViewRejectCriteria')
BEGIN
	print('proc_Insert_EDW_BiometricViewRejectCriteria found, updating.');
	drop procedure proc_Insert_EDW_BiometricViewRejectCriteria ;
END
ELSE
	print('Creating proc_Insert_EDW_BiometricViewRejectCriteria');
GO

create proc proc_Insert_EDW_BiometricViewRejectCriteria (@AccountCD as nvarchar(50), @ItemCreatedWhen as DateTime , @SiteID as int)
as 
BEGIN	
	INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]
           ([AccountCD]
           ,[ItemCreatedWhen]
           ,[SiteID]
           )
     VALUES
           (@AccountCD
           ,@ItemCreatedWhen
           ,@SiteID
		   );
END

GO

if exists (select name from sys.procedures where name = 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct')
BEGIN
	print('proc_Delete_EDW_BiometricViewRejectCriteria_Acct  found, updating.');
	drop procedure proc_Delete_EDW_BiometricViewRejectCriteria_Acct ;
END
ELSE
	print('Creating proc_Delete_EDW_BiometricViewRejectCriteria_Acct');

GO


create proc proc_Delete_EDW_BiometricViewRejectCriteria_Acct (@AccountCD as nvarchar(50), @ItemCreatedWhen as DateTime)
as 
BEGIN
	delete from [dbo].[EDW_BiometricViewRejectCriteria]
           where [AccountCD] = @AccountCD
           AND [ItemCreatedWhen] = @ItemCreatedWhen;
END

GO 
if exists (select name from sys.procedures where name = 'proc_Delete_EDW_BiometricViewRejectCriteria_Site')
BEGIN
	print('proc_Delete_EDW_BiometricViewRejectCriteria_Site  found, updating.');
	drop procedure proc_Delete_EDW_BiometricViewRejectCriteria_Site ;
END
ELSE
	print('Creating proc_Delete_EDW_BiometricViewRejectCriteria_Site');

GO


create proc proc_Delete_EDW_BiometricViewRejectCriteria_Site (@SiteID as int, @ItemCreatedWhen as DateTime )
as 
BEGIN
	delete from [dbo].[EDW_BiometricViewRejectCriteria]
		where SiteID = @SiteID
           AND [ItemCreatedWhen] = @ItemCreatedWhen;
		   
END
GO

if exists (Select name from sys.views where name = 'view_EDW_BioMetrics')
BEGIN
	print('Replacing view_EDW_BioMetrics.');
	drop view view_EDW_BioMetrics ;
END
GO
print('Creating view_EDW_BioMetrics.');
go

CREATE VIEW [dbo].[view_EDW_BioMetrics]
AS
	--*****************************************************************************************************************************************
	--************** TEST Criteria and Results ************************************************************************************************
	--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01 00:00:00.000',17  )  
	--NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
	--GO	--Tested by wdm on 11.21.2014

	--select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136355}
	-- A good test would indicate 136355 - 7 = 136348

	--select count(*) from view_EDW_BioMetrics	where AccountCD = 'peabody'		: 371 
	--select count(*) from view_EDW_BioMetrics	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 

	--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01 00:00:00.000',-1)         
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

	--*****************************************************************************************************************************************
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
      FROM
        dbo.HFit_TrackerWeight AS HFTW WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTW.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTW.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTW.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerHbA1c AS HFTHA WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTHA.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTHA.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTHA.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerCholesterol AS HFTC WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTC.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTC.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTC.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBSAG.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBSAG.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBSAG.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerBloodPressure AS HFTBP WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBP.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBP.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBP.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerBodyFat AS HFTBF WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBF.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBF.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBF.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerBMI AS HFTB WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTB.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTB.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTB.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerBodyMeasurements AS HFTBM WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBM.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTBM.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTBM.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
		dbo.HFit_TrackerHeight AS HFTH WITH ( NOLOCK )
		INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
		INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTH.UserID = cus.UserSettingsUserID
		INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
		INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
		--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
		Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTH.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTH.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerRestingHeartRate AS HFTRHR WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTRHR.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTRHR.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTRHR.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerShots AS HFTS WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTS.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTS.ItemCreatedWhen < ItemCreatedWhen)
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
      FROM
        dbo.HFit_TrackerTests AS HFTT WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFTT.ItemCreatedWhen < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFTT.ItemCreatedWhen < ItemCreatedWhen)
	--HFit_TrackerBMI
	--HFit_TrackerBodyMeasurements
	--HFit_TrackerHeight
	--HFit_TrackerRestingHeartRate
	--HFit_TrackerShots
	--HFit_TrackerTests

GO

print ('Created view_EDW_BioMetrics: ' +  cast(getdate() as nvarchar(50)));
GO

GO
print('Creating view_EDW_HealthInterestList'); 
GO

if exists(select name from sys.views where name = 'view_EDW_HealthInterestList')
BEGIN 
	drop view view_EDW_HealthInterestList ;
END
go

CREATE VIEW [dbo].[view_EDW_HealthInterestList]
AS
	--12/03/2014 (wdm) this view was created by Chad Gurka and passed over to Team P to incloude into the build
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
	WHERE DocumentCulture = 'en-us'

GO
print('Created view_EDW_HealthInterestList'); 
GO


GO

print ('Creating view_EDW_HealthInterestDetail');
GO

if exists(select name from sys.views where name = 'view_EDW_HealthInterestDetail')
BEGIN 
	drop view view_EDW_HealthInterestDetail ;
END
go

CREATE VIEW [dbo].[view_EDW_HealthInterestDetail]
AS
	--12/03/2014 (wdm) this view was created by Chad Gurka and passed over to Team P to incloude into the build
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
			AND HA1.DocumentCulture = 'en-us'
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA2 ON HI.SecondInterest = HA2.NodeID	
			AND HA2.DocumentCulture = 'en-us'
		LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA3 ON HI.ThirdInterest = HA3.NodeID
			AND HA3.DocumentCulture = 'en-us'
GO

print ('Created view_EDW_HealthInterestDetail');
GO

print ('JOB COMPLETED - please check for errors.');


  --  
  --  
GO 
print('***** FROM: Fix.12.03.2014.sql'); 
GO 
