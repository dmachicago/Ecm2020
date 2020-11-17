
-- use KenticoCMS_Datamart_2
GO
PRINT 'Processing view_EDW_BioMetrics_MART: ' + CAST (GETDATE () AS NVARCHAR (50)) + '  *** view_EDW_BioMetrics_MART.sql (CR11690)';
GO

IF NOT EXISTS (SELECT
                      name
               FROM sys.tables
               WHERE
                      name = 'BASE_EDW_BiometricViewRejectCriteria') 
    BEGIN
        PRINT 'BASE_EDW_BiometricViewRejectCriteria NOT found, creating';
        --This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
        --Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
        CREATE TABLE dbo.BASE_EDW_BiometricViewRejectCriteria
        (
                     AccountCD NVARCHAR (8) NOT NULL
                   , ItemCreatedWhen DATETIME2 (7) NOT NULL
                   , SiteID INT NOT NULL
                   , RejectGUID UNIQUEIDENTIFIER NULL
        );

        BEGIN TRY
            ALTER TABLE dbo.BASE_EDW_BiometricViewRejectCriteria
            ADD
                        CONSTRAINT
                        DF_EDW_BiometricViewRejectCriteria_RejectGUID DEFAULT NEWID () FOR RejectGUID;
        END TRY
        BEGIN CATCH
            PRINT 'Default constraint already exists DF_EDW_BiometricViewRejectCriteria_RejectGUID. ';
        END CATCH;

        ALTER TABLE dbo.BASE_EDW_BiometricViewRejectCriteria SET (LOCK_ESCALATION = TABLE) ;

        EXEC sp_addextendedproperty
        @name = N'PURPOSE' , @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.' ,
        @level0type = N'Schema' , @level0name = 'dbo' ,
        @level1type = N'Table' , @level1name = 'BASE_EDW_BiometricViewRejectCriteria';
        --@level2type = N'Column', @level2name = NULL

        EXEC sp_addextendedproperty
        @name = N'MS_Description' , @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.' ,
        @level0type = N'Schema' , @level0name = 'dbo' ,
        @level1type = N'Table' , @level1name = 'BASE_EDW_BiometricViewRejectCriteria' ,
        @level2type = N'Column' , @level2name = 'AccountCD';

        EXEC sp_addextendedproperty
        @name = N'USAGE' , @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.' ,
        @level0type = N'Schema' , @level0name = 'dbo' ,
        @level1type = N'Table' , @level1name = 'BASE_EDW_BiometricViewRejectCriteria' ,
        @level2type = N'Column' , @level2name = 'SiteID';

        EXEC sp_addextendedproperty
        @name = N'USAGE' , @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.' ,
        @level0type = N'Schema' , @level0name = 'dbo' ,
        @level1type = N'Table' , @level1name = 'BASE_EDW_BiometricViewRejectCriteria' ,
        @level2type = N'Column' , @level2name = 'ItemCreatedWhen';
    END;
GO

IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_EDW_BiometricViewRejectCriteria') 
    BEGIN
        PRINT 'view_EDW_BiometricViewRejectCriteria found, updating';
        DROP VIEW
             view_EDW_BiometricViewRejectCriteria;
    END;
GO

CREATE VIEW view_EDW_BiometricViewRejectCriteria
AS SELECT
          AccountCD
        , ItemCreatedWhen
        , SiteID
        , RejectGUID
   FROM dbo.BASE_EDW_BiometricViewRejectCriteria;
GO
PRINT 'view_EDW_BiometricViewRejectCriteria, updated';
GO

IF NOT EXISTS (SELECT
                      name
               FROM sys.indexes
               WHERE
                      name = 'PKI_EDW_BiometricViewRejectCriteria') 
    BEGIN
        PRINT 'PKI_EDW_BiometricViewRejectCriteria NOT found, creating';
        CREATE UNIQUE CLUSTERED INDEX PKI_EDW_BiometricViewRejectCriteria ON dbo.BASE_EDW_BiometricViewRejectCriteria
        (
        AccountCD ASC ,
        ItemCreatedWhen ASC ,
        SiteID ASC
        );
    END;
ELSE
    BEGIN
        PRINT 'PKI_EDW_BiometricViewRejectCriteria created';
    END;

GO

IF EXISTS (SELECT
                  NAME
           FROM sys.procedures
           WHERE
                  name = 'proc_Insert_EDW_BiometricViewRejectCriteria') 
    BEGIN
        PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, updating.';
        DROP PROCEDURE
             proc_Insert_EDW_BiometricViewRejectCriteria;
    END;
ELSE
    BEGIN
        PRINT 'Creating proc_Insert_EDW_BiometricViewRejectCriteria';
    END;
GO

CREATE PROC proc_Insert_EDW_BiometricViewRejectCriteria (
       @AccountCD AS NVARCHAR (50) 
     , @ItemCreatedWhen AS DATETIME
     , @SiteID AS INT) 
AS
BEGIN

    IF @SiteID IS NULL
        BEGIN
            SET @SiteID = -1;
        END;

    DECLARE
           @iCnt INTEGER = 0;
    SET @iCnt = (SELECT
                        COUNT (*) 
                 FROM BASE_EDW_BiometricViewRejectCriteria
                 WHERE
                        AccountCD = @AccountCD AND
                        SiteID = @SiteID) ;
    IF @iCnt <= 0
        BEGIN
            INSERT INTO dbo.BASE_EDW_BiometricViewRejectCriteria
            (
                   AccountCD
                 , ItemCreatedWhen
                 , SiteID
            ) 
            VALUES
            (@AccountCD
            , @ItemCreatedWhen
            , @SiteID
            );
            PRINT 'ADDED ' + @AccountCD + ' to BASE_EDW_BiometricViewRejectCriteria.';
        END;
    ELSE
        BEGIN
            PRINT 'Account ' + @AccountCD + ' already defined to BASE_EDW_BiometricViewRejectCriteria.';
        END;
END;

GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct') 
    BEGIN
        PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct  found, updating.';
        DROP PROCEDURE
             proc_Delete_EDW_BiometricViewRejectCriteria_Acct;
    END;
ELSE
    BEGIN
        PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Acct';
    END;

GO

CREATE PROC proc_Delete_EDW_BiometricViewRejectCriteria_Acct (
       @AccountCD AS NVARCHAR (50) 
     , @ItemCreatedWhen AS DATETIME2) 
AS
BEGIN
    DELETE FROM dbo.BASE_EDW_BiometricViewRejectCriteria
    WHERE
           AccountCD = @AccountCD AND
           ItemCreatedWhen = @ItemCreatedWhen;
END;

GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_Delete_EDW_BiometricViewRejectCriteria_Site') 
    BEGIN
        PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Site  found, updating.';
        DROP PROCEDURE
             proc_Delete_EDW_BiometricViewRejectCriteria_Site;
    END;
ELSE
    BEGIN
        PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Site';
    END;

GO

CREATE PROC proc_Delete_EDW_BiometricViewRejectCriteria_Site (
       @SiteID AS INT
     , @ItemCreatedWhen AS DATETIME2) 
AS
BEGIN
    DELETE FROM dbo.BASE_EDW_BiometricViewRejectCriteria
    WHERE
          SiteID = @SiteID AND
           ItemCreatedWhen = @ItemCreatedWhen;

END;
GO

IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_EDW_BioMetrics_MART') 
    BEGIN
        PRINT 'Removing current view_EDW_BioMetrics_MART.';
        DROP VIEW
             view_EDW_BioMetrics_MART;
    END;
GO
PRINT 'Creating view_EDW_BioMetrics_MART.';
GO

-- use KenticoCMS_Datamart_2
-- select top 5000 * from view_EDW_BioMetrics_MART
CREATE VIEW dbo.view_EDW_BioMetrics_MART
AS
--************** TEST Criteria and Results for view_EDW_BioMetrics_MART ************************************************************************
--INSERT INTO [dbo].[BASE_EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01',17  )  
--NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

-- select count(*) from view_EDW_BioMetrics_MART		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9

--select * from view_EDW_BioMetrics_MART	 where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
--select * from view_Hfit_BioMetrics where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 

--select * from view_EDW_BioMetrics_MART	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 
--select * from view_EDW_BioMetrics_MART	where AccountCD = 'peaboOK dy' and EventDate < '2013-12-01 00:00:00.000'		: 9 

--select count(*) from view_EDW_BioMetrics_MART		--NO REJECT FILTER : 136348
--select count(*) from view_EDW_BioMetrics_MART		--REJECT FILTER ON : 136339 == 9 GOOD TEST

--select count(*) from view_Hfit_BioMetrics	:136393
--select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348

--NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014

--truncate table BASE_EDW_BiometricViewRejectCriteria

--INSERT INTO [dbo].[BASE_EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01',-1)         
--NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics_MART where ItemCreatedWhen < '2013-12-01' and AccountCD = 'peabody' returns 1034
--		so the number should be 43814 - 1034 = 42780 with AccountCD = 'peabody' and ItemCreatedWhen = '2014-03-19'
--		in table BASE_EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics_MART where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
--		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
--		in table BASE_EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.

-- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the BASE_HFit_LKP_TrackerVendor table
-- 12.25.2014 - Added the BASE_EDW_BiometricViewRejectCriteria to allow selective rejection of historical records
-- 01.19.2014 - Prepared for Simpson Willams

--*****************************************************************************************************************************************
SELECT DISTINCT
       HFUT.UserID
     , cus.UserSettingsUserGUID AS UserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (NULL AS DATETIME2) AS CreatedDate
     , cast (NULL AS DATETIME2) AS ModifiedDate
     , NULL AS Notes
     , NULL AS IsProfessionallyCollected
     , NULL AS EventDate
     , 'Not Build Yet' AS EventName
       --BASE_HFit_TrackerWeight
     , NULL AS PPTWeight
       --BASE_HFit_TrackerHbA1c
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
     , --HFit_TrackerShots
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
           WHEN
       HFUT.ItemCreatedWhen = COALESCE (HFUT.ItemModifiedWhen , hfut.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFUT.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFUT.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , 0   AS TrackerCollectionSourceID
     , HFUT.itemid
     , 'HFit_UserTracker' AS TBL
     , NULL AS VendorID		--VENDOR.ItemID as VendorID
     , NULL AS VendorName		--VENDOR.VendorName
     , HFUT.SVR
     , HFUT.DBNAME
     , HFUT.LastModifiedDate
FROM dbo.BASE_HFit_UserTracker AS HFUT
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       hfut.UserID = cus.UserSettingsUserID AND
       hfut.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
--left outer join BASE_HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         HFUT.ItemCreatedWhen < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             HFUT.ItemCreatedWhen < ItemCreatedWhen) AND
HFUT.ItemCreatedWhen IS NOT NULL		--Add per Robert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       hftw.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTW.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTW.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTW.Notes
     , HFTW.IsProfessionallyCollected
     , cast (HFTW.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTW.ItemCreatedWhen = COALESCE (HFTW.ItemModifiedWhen , HFTW.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTW.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTW.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTW.itemid
     , 'BASE_HFit_TrackerWeight' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTW.SVR
     , HFTW.DBNAME
     , HFTW.LastModifiedDate
FROM dbo.BASE_HFit_TrackerWeight AS HFTW
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTW.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTW.UserID = cus.UserSettingsUserID AND
       HFTW.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.dbname = cus2.dbname
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.dbname = CS.dbname
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.dbname = HFA.dbname
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTW.VendorID = VENDOR.ItemID AND
       HFTW.dbname = VENDOR.dbname
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTW.EventDate , HFTW.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTW.EventDate , HFTW.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTW.ItemCreatedWhen IS NOT NULL OR
  HFTW.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014			

UNION ALL
SELECT DISTINCT
       HFTHA.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTHA.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTHA.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTHA.Notes
     , HFTHA.IsProfessionallyCollected
     , cast (HFTHA.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTHA.ItemCreatedWhen = COALESCE (HFTHA.ItemModifiedWhen , HFTHA.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTHA.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTHA.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTHA.itemid
     , 'BASE_HFit_TrackerHbA1c' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTHA.svr
     , HFTHA.dbname
     , HFTHA.LastModifiedDate
FROM dbo.BASE_HFit_TrackerHbA1c AS HFTHA
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTHA.dbname = HFTCS.dbname
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTHA.UserID = cus.UserSettingsUserID AND
       HFTHA.dbname = cus.dbname
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.dbname = cus2.dbname
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.dbname = CS.dbname
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.dbname = HFA.dbname
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTHA.VendorID = VENDOR.ItemID AND
       HFTHA.dbname = VENDOR.dbname
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTHA.EventDate , HFTHA.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTHA.EventDate , HFTHA.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTHA.ItemCreatedWhen IS NOT NULL OR
  HFTHA.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTC.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTC.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTC.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTC.Notes
     , HFTC.IsProfessionallyCollected
     , cast (HFTC.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTC.ItemCreatedWhen = COALESCE (HFTC.ItemModifiedWhen , HFTC.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTC.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTC.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTC.itemid
     , 'HFit_TrackerCholesterol' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTC.svr
     , HFTC.DBNAME
     , HFTC.LastModifiedDate
FROM dbo.BASE_HFit_TrackerCholesterol AS HFTC
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTC.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTC.UserID = cus.UserSettingsUserID AND
       HFTC.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTC.VendorID = VENDOR.ItemID AND
       HFTC.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTC.EventDate , HFTC.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTC.EventDate , HFTC.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTC.ItemCreatedWhen IS NOT NULL OR
  HFTC.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTBSAG.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTBSAG.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBSAG.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTBSAG.Notes
     , HFTBSAG.IsProfessionallyCollected
     , cast (HFTBSAG.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTBSAG.ItemCreatedWhen = COALESCE (HFTBSAG.ItemModifiedWhen , HFTBSAG.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTBSAG.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBSAG.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTBSAG.itemid
     , 'HFit_TrackerBloodSugarAndGlucose' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTBSAG.svr
     , HFTBSAG.DBNAME
     , HFTBSAG.LastModifiedDate
FROM dbo.BASE_HFit_TrackerBloodSugarAndGlucose AS HFTBSAG
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTBSAG.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTBSAG.UserID = cus.UserSettingsUserID AND
       HFTBSAG.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTBSAG.VendorID = VENDOR.ItemID AND
       HFTBSAG.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTBSAG.EventDate , HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTBSAG.EventDate , HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTBSAG.ItemCreatedWhen IS NOT NULL OR
  HFTBSAG.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTBP.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTBP.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBP.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTBP.Notes
     , HFTBP.IsProfessionallyCollected
     , cast (HFTBP.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTBP.ItemCreatedWhen = COALESCE (HFTBP.ItemModifiedWhen , HFTBP.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTBP.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBP.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTBP.itemid
     , 'HFit_TrackerBloodPressure' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTBP.svr
     , HFTBP.DBNAME
     , HFTBP.LastModifiedDate
FROM dbo.BASE_HFit_TrackerBloodPressure AS HFTBP
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTBP.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTBP.UserID = cus.UserSettingsUserID AND
       HFTBP.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTBP.VendorID = VENDOR.ItemID AND
       HFTBP.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTBP.EventDate , HFTBP.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTBP.EventDate , HFTBP.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTBP.ItemCreatedWhen IS NOT NULL OR
  HFTBP.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTBF.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTBF.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBF.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTBF.Notes
     , HFTBF.IsProfessionallyCollected
     , cast (HFTBF.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTBF.ItemCreatedWhen = COALESCE (HFTBF.ItemModifiedWhen , HFTBF.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTBF.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBF.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTBF.itemid
     , 'HFit_TrackerBodyFat' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTBF.svr
     , HFTBF.DBNAME
     , HFTBF.LastModifiedDate
FROM dbo.BASE_HFit_TrackerBodyFat AS HFTBF
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTBF.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTBF.UserID = cus.UserSettingsUserID AND
       HFTBF.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTBF.VendorID = VENDOR.ItemID AND
       HFTBF.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTBF.EventDate , HFTBF.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTBF.EventDate , HFTBF.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTBF.ItemCreatedWhen IS NOT NULL OR
  HFTBF.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTB.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTB.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTB.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTB.Notes
     , HFTB.IsProfessionallyCollected
     , cast (HFTB.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTB.ItemCreatedWhen = COALESCE (HFTB.ItemModifiedWhen , HFTB.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTB.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTB.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTB.itemid
     , 'HFit_TrackerBMI' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTB.svr
     , HFTB.DBNAME
     , HFTB.LastModifiedDate
FROM dbo.BASE_HFit_TrackerBMI AS HFTB
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTB.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTB.UserID = cus.UserSettingsUserID AND
       HFTB.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTB.VendorID = VENDOR.ItemID AND
       HFTB.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTB.EventDate , HFTB.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTB.EventDate , HFTB.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTB.ItemCreatedWhen IS NOT NULL OR
  HFTB.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTBM.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTBM.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBM.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTBM.Notes
     , HFTBM.IsProfessionallyCollected
     , cast (HFTBM.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTBM.ItemCreatedWhen = COALESCE (HFTBM.ItemModifiedWhen , HFTBM.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTBM.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTBM.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTBM.itemid
     , 'HFit_TrackerBodyMeasurements' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTBM.svr
     , HFTBM.DBNAME
     , HFTBM.LastModifiedDate
FROM dbo.BASE_HFit_TrackerBodyMeasurements AS HFTBM
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTBM.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTBM.UserID = cus.UserSettingsUserID AND
       HFTBM.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTBM.VendorID = VENDOR.ItemID AND
       HFTBM.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTBM.EventDate , HFTBM.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTBM.EventDate , HFTBM.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTBM.ItemCreatedWhen IS NOT NULL OR
  HFTBM.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTH.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTH.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTH.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTH.Notes
     , HFTH.IsProfessionallyCollected
     , cast (HFTH.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTH.ItemCreatedWhen = COALESCE (HFTH.ItemModifiedWhen , HFTH.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTH.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTH.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTH.itemid
     , 'HFit_TrackerHeight' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTH.svr
     , HFTH.DBNAME
     , HFTH.LastModifiedDate
FROM dbo.BASE_HFit_TrackerHeight AS HFTH
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTH.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTH.UserID = cus.UserSettingsUserID AND
       HFTH.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTH.VendorID = VENDOR.ItemID AND
       HFTH.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria		
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTH.EventDate , HFTH.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTH.EventDate , HFTH.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTH.ItemCreatedWhen IS NOT NULL OR
  HFTH.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014
UNION ALL
SELECT DISTINCT
       HFTRHR.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTRHR.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTRHR.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTRHR.Notes
     , HFTRHR.IsProfessionallyCollected
     , cast (HFTRHR.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTRHR.ItemCreatedWhen = COALESCE (HFTRHR.ItemModifiedWhen , HFTRHR.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTRHR.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTRHR.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTRHR.itemid
     , 'HFit_TrackerRestingHeartRate' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTRHR.svr
     , HFTRHR.DBNAME
     , HFTRHR.LastModifiedDate
FROM dbo.BASE_HFit_TrackerRestingHeartRate AS HFTRHR
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTRHR.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTRHR.UserID = cus.UserSettingsUserID AND
       HFTRHR.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTRHR.VendorID = VENDOR.ItemID AND
       HFTRHR.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTRHR.EventDate , HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTRHR.EventDate , HFTRHR.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTRHR.ItemCreatedWhen IS NOT NULL OR
  HFTRHR.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTS.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTS.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTS.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTS.Notes
     , HFTS.IsProfessionallyCollected
     , cast (HFTS.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTS.ItemCreatedWhen = COALESCE (HFTS.ItemModifiedWhen , HFTS.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTS.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTS.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTS.itemid
     , 'HFit_TrackerShots' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTS.svr
     , HFTS.DBNAME
     , HFTS.LastModifiedDate
FROM dbo.BASE_HFit_TrackerShots AS HFTS
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTS.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTS.UserID = cus.UserSettingsUserID AND
       HFTS.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTS.VendorID = VENDOR.ItemID AND
       HFTS.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTS.EventDate , HFTS.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTS.EventDate , HFTS.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTS.ItemCreatedWhen IS NOT NULL OR
  HFTS.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT DISTINCT
       HFTT.UserID
     , cus.UserSettingsUserGUID
     , cus.HFitUserMpiNumber
     , cus2.SiteID
     , cs.SiteGUID
     , cast (HFTT.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTT.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTT.Notes
     , HFTT.IsProfessionallyCollected
     , cast (HFTT.EventDate AS DATETIME2) AS EventDate
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
           WHEN
       HFTT.ItemCreatedWhen = COALESCE (HFTT.ItemModifiedWhen , HFTT.ItemCreatedWhen) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , cast (HFTT.ItemCreatedWhen AS DATETIME2) AS ItemCreatedWhen
     , cast (HFTT.ItemModifiedWhen AS DATETIME2) AS ItemModifiedWhen
     , HFTCS.TrackerCollectionSourceID
     , HFTT.itemid
     , 'HFit_TrackerTests' AS TBL
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
     , HFTT.svr
     , HFTT.DBNAME
     , HFTT.LastModifiedDate
FROM dbo.BASE_HFit_TrackerTests AS HFTT
     INNER JOIN dbo.BASE_HFit_TrackerCollectionSource AS HFTCS
     ON
       HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID AND
       HFTT.DBNAME = HFTCS.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSettings AS CUS
     ON
       HFTT.UserID = cus.UserSettingsUserID AND
       HFTT.DBNAME = cus.DBNAME
     INNER JOIN dbo.BASE_CMS_UserSite AS CUS2
     ON
       cus.UserSettingsUserID = cus2.UserID AND
       cus.DBNAME = cus2.DBNAME
     INNER JOIN dbo.BASE_CMS_Site AS CS
     ON
       CUS2.SiteID = CS.SiteID AND
       CUS2.DBNAME = CS.DBNAME
     INNER JOIN dbo.BASE_HFit_Account AS HFA
     ON
       cs.SiteID = HFA.SiteID AND
       cs.DBNAME = HFA.DBNAME
     LEFT OUTER JOIN BASE_HFit_LKP_TrackerVendor AS VENDOR
     ON
       HFTT.VendorID = VENDOR.ItemID AND
       HFTT.DBNAME = VENDOR.DBNAME
--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table BASE_EDW_BiometricViewRejectCriteria
WHERE
CS.SITEID NOT IN (SELECT
                         SiteID
                  FROM BASE_EDW_BiometricViewRejectCriteria
                  WHERE
                         COALESCE (HFTT.EventDate , HFTT.ItemCreatedWhen) < ItemCreatedWhen) AND
HFA.AccountCD NOT IN (SELECT
                             AccountCD
                      FROM BASE_EDW_BiometricViewRejectCriteria
                      WHERE
                             HFA.AccountCD = AccountCD AND
                             COALESCE (HFTT.EventDate , HFTT.ItemCreatedWhen) < ItemCreatedWhen) AND
(
  HFTT.ItemCreatedWhen IS NOT NULL OR
  HFTT.EventDate IS NOT NULL);		--Add per RObert and Laura 12.4.2014

--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

GO
PRINT '***** Executed view_EDW_BioMetrics_MART.sql';
GO

----***************************************************************************************************************************
----** REMOVE THE INSERTS AFTER INTITAL LOAD
----***************************************************************************************************************************
--truncate table BASE_EDW_BiometricViewRejectCriteria ;
--go 
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'trstmark','11/4/2013',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'entergy','1/6/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'mcwp','1/27/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'stateneb','4/1/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'jnj','5/28/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'coopers','7/1/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'cnh','8/4/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'amat','8/4/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'dupont','8/18/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'ejones','9/3/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'avera','9/15/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'sprvalu','9/18/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'firstgrp','10/6/2014',-1) ;
--GO
--insert into BASE_EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'rexnord','12/2/2014',-1) ;
--GO
PRINT '***** COMPLETED : view_EDW_BioMetrics_MART.sql';
GO 




