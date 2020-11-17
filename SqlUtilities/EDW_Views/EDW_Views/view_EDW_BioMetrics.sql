
GO
PRINT 'Processing view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) + '  *** view_EDW_BioMetrics.sql (CR11690)';
GO
--drop table [EDW_BiometricViewRejectCriteria]
IF NOT EXISTS (SELECT [name]
			  FROM [sys].[tables]
			  WHERE [name] = 'EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'EDW_BiometricViewRejectCriteria NOT found, creating';
	   --This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
	   --Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
	   CREATE TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] nvarchar (8) NOT NULL
	 , [ItemCreatedWhen] datetime2 (7) NOT NULL
	 , [SiteID] int NOT NULL
	 , [RejectGUID] uniqueidentifier NULL
	   );

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   ADD CONSTRAINT
		  [DF_EDW_BiometricViewRejectCriteria_RejectGUID] DEFAULT NEWID () FOR [RejectGUID];

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria] SET (LOCK_ESCALATION = TABLE) ;

	   EXEC [sp_addextendedproperty]
	   @name = N'PURPOSE' , @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria';
	   --@level2type = N'Column', @level2name = NULL

	   EXEC [sp_addextendedproperty]
	   @name = N'MS_Description' , @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'AccountCD';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'SiteID';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'ItemCreatedWhen';
    END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'view_EDW_BiometricViewRejectCriteria found, updating';
	   DROP VIEW [view_EDW_BiometricViewRejectCriteria];
    END;
GO

CREATE VIEW [view_EDW_BiometricViewRejectCriteria]
AS SELECT [AccountCD]
	   , [ItemCreatedWhen]
	   , [SiteID]
	   , [RejectGUID]
	FROM [dbo].[EDW_BiometricViewRejectCriteria];
GO
PRINT 'view_EDW_BiometricViewRejectCriteria, updated';
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PKI_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria NOT found, creating';
	   CREATE UNIQUE CLUSTERED INDEX [PKI_EDW_BiometricViewRejectCriteria] ON [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] ASC ,
	   [ItemCreatedWhen] ASC ,
	   [SiteID] ASC
	   );
    END;
ELSE
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria created';
    END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Insert_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, updating.';
	   DROP PROCEDURE [proc_Insert_EDW_BiometricViewRejectCriteria];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Insert_EDW_BiometricViewRejectCriteria';
    END;
GO

CREATE PROC [proc_Insert_EDW_BiometricViewRejectCriteria] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime , @SiteID AS int) 
AS
BEGIN

    IF @SiteID IS NULL
	   BEGIN
		  SET @SiteID = -1;
	   END;

    DECLARE @iCnt integer = 0;
    SET @iCnt = (SELECT COUNT (*) 
			    FROM [EDW_BiometricViewRejectCriteria]
			    WHERE [AccountCD] = @AccountCD
				 AND [SiteID] = @SiteID) ;
    IF @iCnt <= 0
	   BEGIN
		  INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]
		  ([AccountCD]
		 , [ItemCreatedWhen]
		 , [SiteID]
		  ) 
		  VALUES
		  (@AccountCD
		  , @ItemCreatedWhen
		  , @SiteID
		  );
		  PRINT 'ADDED ' + @AccountCD + ' to EDW_BiometricViewRejectCriteria.';
	   END;
    ELSE
	   BEGIN
		  PRINT 'Account ' + @AccountCD + ' already defined to EDW_BiometricViewRejectCriteria.';
	   END;
END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Acct];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Acct';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Acct] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [AccountCD] = @AccountCD
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;
END;

GO
IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Site') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Site  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Site];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Site';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Site] (
	  @SiteID AS int , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [SiteID] = @SiteID
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;

END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BioMetrics') 
    BEGIN
	   PRINT 'Removing current view_EDW_BioMetrics.';
	   DROP VIEW [view_EDW_BioMetrics];
    END;
GO
PRINT 'Creating view_EDW_BioMetrics.';
GO

CREATE VIEW [dbo].[view_EDW_BioMetrics]
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

-- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Added the EDW_BiometricViewRejectCriteria to allow selective rejection of historical records
-- 01.19.2014 - Prepared for Simpson Willams

--*****************************************************************************************************************************************
SELECT DISTINCT
--HFit_UserTracker
[HFUT].[UserID]
, [cus].[UserSettingsUserGUID] AS [UserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, NULL AS [CreatedDate]
, NULL AS [ModifiedDate]
, NULL AS [Notes]
, NULL AS [IsProfessionallyCollected]
, NULL AS [EventDate]
, 'Not Build Yet' AS [EventName]

--HFit_TrackerWeight
, NULL AS [PPTWeight]

--HFit_TrackerHbA1C
, NULL AS [PPTHbA1C]

--HFit_TrackerCholesterol
, NULL AS [Fasting]
, NULL AS [HDL]
, NULL AS [LDL]
, NULL AS [Ratio]
, NULL AS [Total]
, NULL AS [Triglycerides]

--HFit_TrackerBloodSugarandGlucose
, NULL AS [Glucose]
, NULL AS [FastingState]

--HFit_TrackerBloodPressure
, NULL AS [Systolic]
, NULL AS [Diastolic]

--HFit_TrackerBodyFat
, NULL AS [PPTBodyFatPCT]

--HFit_TrackerBMI
, NULL AS [BMI]

--HFit_TrackerBodyMeasurements
, NULL AS [WaistInches]
, NULL AS [HipInches]
, NULL AS [ThighInches]
, NULL AS [ArmInches]
, NULL AS [ChestInches]
, NULL AS [CalfInches]
, NULL AS [NeckInches]

--HFit_TrackerHeight
, NULL AS [Height]

--HFit_TrackerRestingHeartRate
, NULL AS [HeartRate]
, --HFit_TrackerShots
NULL AS [FluShot]
, NULL AS [PneumoniaShot]

--HFit_TrackerTests
, NULL AS [PSATest]
, NULL AS [OtherExam]
, NULL AS [TScore]
, NULL AS [DRA]
, NULL AS [CotinineTest]
, NULL AS [ColoCareKit]
, NULL AS [CustomTest]
, NULL AS [CustomDesc]
, NULL AS [CollectionSource]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFUT].[ItemCreatedWhen] = COALESCE ([HFUT].[ItemModifiedWhen] , [hfut].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFUT].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFUT].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, 0   AS [TrackerCollectionSourceID]
, [HFUT].[itemid]
, 'HFit_UserTracker' AS [TBL]
, NULL AS [VendorID]		--VENDOR.ItemID as VendorID
, NULL AS [VendorName]		--VENDOR.VendorName
  FROM
	  [dbo].[HFit_UserTracker] AS [HFUT]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [hfut].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
  --left outer join HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
    AND [HFUT].[ItemCreatedWhen] IS NOT NULL		--Add per Robert and Laura 12.4.2014

UNION ALL
SELECT
[hftw].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTW].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFTW].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, [HFTW].[Notes]
, [HFTW].[IsProfessionallyCollected]
, cast([HFTW].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, [hftw].Value AS [PPTWeight]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTW].[ItemCreatedWhen] = COALESCE ([HFTW].[ItemModifiedWhen] , [HFTW].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTW].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFTW].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTW].[itemid]
, 'HFit_TrackerWeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerWeight] AS [HFTW]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTW].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTW].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTW].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria	  
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTW].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTW].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014			

UNION ALL
SELECT
[HFTHA].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTHA].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTHA].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTHA].[Notes]
, [HFTHA].[IsProfessionallyCollected]
, cast([HFTHA].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, [HFTHA].Value AS [PPTHbA1C]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTHA].[ItemCreatedWhen] = COALESCE ([HFTHA].[ItemModifiedWhen] , [HFTHA].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTHA].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTHA].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTHA].[itemid]
, 'HFit_TrackerHbA1c' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHbA1c] AS [HFTHA]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTHA].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTHA].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTHA].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTHA].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTHA].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTC].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTC].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTC].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTC].[Notes]
, [HFTC].[IsProfessionallyCollected]
, cast([HFTC].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, [HFTC].[Fasting]
, [HFTC].[HDL]
, [HFTC].[LDL]
, [HFTC].[Ratio]
, [HFTC].[Total]
, [HFTC].[Tri]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTC].[ItemCreatedWhen] = COALESCE ([HFTC].[ItemModifiedWhen] , [HFTC].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTC].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTC].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTC].[itemid]
, 'HFit_TrackerCholesterol' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerCholesterol] AS [HFTC]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTC].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTC].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTC].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTC].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTC].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBSAG].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBSAG].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBSAG].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBSAG].[Notes]
, [HFTBSAG].[IsProfessionallyCollected]
, cast([HFTBSAG].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBSAG].[Units]
, [HFTBSAG].[FastingState]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBSAG].[ItemCreatedWhen] = COALESCE ([HFTBSAG].[ItemModifiedWhen] , [HFTBSAG].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBSAG].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBSAG].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBSAG].[itemid]
, 'HFit_TrackerBloodSugarAndGlucose' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodSugarAndGlucose] AS [HFTBSAG]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBSAG].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBSAG].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBSAG].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBSAG].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBSAG].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBP].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBP].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBP].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBP].[Notes]
, [HFTBP].[IsProfessionallyCollected]
, cast([HFTBP].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBP].[Systolic]
, [HFTBP].[Diastolic]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBP].[ItemCreatedWhen] = COALESCE ([HFTBP].[ItemModifiedWhen] , [HFTBP].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBP].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBP].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBP].[itemid]
, 'HFit_TrackerBloodPressure' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodPressure] AS [HFTBP]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBP].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBP].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBP].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBP].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBP].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBF].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBF].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBF].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBF].[Notes]
, [HFTBF].[IsProfessionallyCollected]
, cast([HFTBF].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBF].Value AS [PPTBodyFatPCT]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBF].[ItemCreatedWhen] = COALESCE ([HFTBF].[ItemModifiedWhen] , [HFTBF].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBF].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBF].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBF].[itemid]
, 'HFit_TrackerBodyFat' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyFat] AS [HFTBF]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBF].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBF].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBF].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBF].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBF].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTB].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTB].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTB].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTB].[Notes]
, [HFTB].[IsProfessionallyCollected]
, cast([HFTB].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTB].[BMI]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTB].[ItemCreatedWhen] = COALESCE ([HFTB].[ItemModifiedWhen] , [HFTB].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTB].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTB].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTB].[itemid]
, 'HFit_TrackerBMI' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBMI] AS [HFTB]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTB].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTB].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTB].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTB].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTB].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTBM].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBM].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBM].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBM].[Notes]
, [HFTBM].[IsProfessionallyCollected]
, cast([HFTBM].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBM].[WaistInches]
, [HFTBM].[HipInches]
, [HFTBM].[ThighInches]
, [HFTBM].[ArmInches]
, [HFTBM].[ChestInches]
, [HFTBM].[CalfInches]
, [HFTBM].[NeckInches]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBM].[ItemCreatedWhen] = COALESCE ([HFTBM].[ItemModifiedWhen] , [HFTBM].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBM].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBM].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBM].[itemid]
, 'HFit_TrackerBodyMeasurements' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyMeasurements] AS [HFTBM]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBM].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBM].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBM].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBM].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBM].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTH].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTH].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTH].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTH].[Notes]
, [HFTH].[IsProfessionallyCollected]
, cast([HFTH].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTH].[Height]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTH].[ItemCreatedWhen] = COALESCE ([HFTH].[ItemModifiedWhen] , [HFTH].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTH].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTH].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTH].[itemid]
, 'HFit_TrackerHeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHeight] AS [HFTH]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTH].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTH].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTH].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTH].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTH].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014
UNION ALL
SELECT
[HFTRHR].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTRHR].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTRHR].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTRHR].[Notes]
, [HFTRHR].[IsProfessionallyCollected]
, cast([HFTRHR].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTRHR].[HeartRate]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTRHR].[ItemCreatedWhen] = COALESCE ([HFTRHR].[ItemModifiedWhen] , [HFTRHR].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTRHR].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTRHR].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTRHR].[itemid]
, 'HFit_TrackerRestingHeartRate' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerRestingHeartRate] AS [HFTRHR]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTRHR].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTRHR].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTRHR].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTRHR].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTRHR].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTS].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTS].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTS].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTS].[Notes]
, [HFTS].[IsProfessionallyCollected]
, cast([HFTS].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTS].[FluShot]
, [HFTS].[PneumoniaShot]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTS].[ItemCreatedWhen] = COALESCE ([HFTS].[ItemModifiedWhen] , [HFTS].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTS].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTS].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTS].[itemid]
, 'HFit_TrackerShots' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerShots] AS [HFTS]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTS].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTS].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTS].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTS].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTS].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT
[HFTT].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTT].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTT].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTT].[Notes]
, [HFTT].[IsProfessionallyCollected]
, cast([HFTT].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTT].[PSATest]
, [HFTT].[OtherExam]
, [HFTT].[TScore]
, [HFTT].[DRA]
, [HFTT].[CotinineTest]
, [HFTT].[ColoCareKit]
, [HFTT].[CustomTest]
, [HFTT].[CustomDesc]
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTT].[ItemCreatedWhen] = COALESCE ([HFTT].[ItemModifiedWhen] , [HFTT].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTT].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTT].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTT].[itemid]
, 'HFit_TrackerTests' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerTests] AS [HFTT]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTT].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTT].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTT].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTT].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTT].[EventDate] IS NOT NULL);		--Add per RObert and Laura 12.4.2014

--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

GO

PRINT 'Created view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_BioMetrics.sql';
GO

----***************************************************************************************************************************
----** REMOVE THE INSERTS AFTER INTITAL LOAD
----***************************************************************************************************************************
--truncate table EDW_BiometricViewRejectCriteria ;
--go 
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'trstmark','11/4/2013',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'entergy','1/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'mcwp','1/27/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'stateneb','4/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'jnj','5/28/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'coopers','7/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'cnh','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'amat','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'dupont','8/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'ejones','9/3/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'avera','9/15/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'sprvalu','9/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'firstgrp','10/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'rexnord','12/2/2014',-1) ;
--GO
PRINT '***** COMPLETED : view_EDW_BioMetrics.sql';
GO 
