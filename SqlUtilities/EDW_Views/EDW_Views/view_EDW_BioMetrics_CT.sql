

GO
PRINT 'Creating view_EDW_BioMetrics_CT: ' + CAST( GETDATE( )AS nvarchar( 50 )) + '  *** FROM: view_EDW_BioMetrics_CT.sql';
GO

if exists (select name from sys.views where name = 'view_EDW_BioMetrics_CT')
    drop view view_EDW_BioMetrics_CT;
go

/*
select count(*) from view_EDW_BioMetrics_CT
*/

CREATE VIEW dbo.view_EDW_BioMetrics_CT
AS SELECT DISTINCT
   --HFit_UserTracker
          HFUT.UserID , 
          cus.UserSettingsUserGUID AS UserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          NULL AS                     CreatedDate , 
          NULL AS                     ModifiedDate , 
          NULL AS                     Notes , 
          NULL AS                     IsProfessionallyCollected , 
          NULL AS                     EventDate , 
          'Not Build Yet' AS          EventName

          --HFit_TrackerWeight
          , 
          NULL AS                     PPTWeight

          --HFit_TrackerHbA1C
          , 
          NULL AS                     PPTHbA1C

          --HFit_TrackerCholesterol
          , 
          NULL AS                     Fasting , 
          NULL AS                     HDL , 
          NULL AS                     LDL , 
          NULL AS                     Ratio , 
          NULL AS                     Total , 
          NULL AS                     Triglycerides, 
          NULL AS                     Glucose , 
          NULL AS                     FastingState, 
          NULL AS                     Systolic , 
          NULL AS                     Diastolic, 
          NULL AS                     PPTBodyFatPCT, 
          NULL AS                     BMI, 
          NULL AS                     WaistInches , 
          NULL AS                     HipInches , 
          NULL AS                     ThighInches , 
          NULL AS                     ArmInches , 
          NULL AS                     ChestInches , 
          NULL AS                     CalfInches , 
          NULL AS                     NeckInches, 
          NULL AS                     Height, 
          NULL AS                     HeartRate , 
          NULL AS                     FluShot , 
          NULL AS                     PneumoniaShot, 
          NULL AS                     PSATest , 
          NULL AS                     OtherExam , 
          NULL AS                     TScore , 
          NULL AS                     DRA , 
          NULL AS                     CotinineTest , 
          NULL AS                     ColoCareKit , 
          NULL AS                     CustomTest , 
          NULL AS                     CustomDesc , 
          NULL AS                     CollectionSource , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFUT.ItemCreatedWhen = COALESCE( HFUT.ItemModifiedWhen , hfut.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                      ChangeType , 
          HFUT.ItemCreatedWhen , 
          HFUT.ItemModifiedWhen , 
          0 AS                        TrackerCollectionSourceID , 
          HFUT.itemid , 
          'HFit_UserTracker' AS       TBL , 
          NULL AS                     VendorID, 
          NULL AS                     VendorName, 
          HASHBYTES( 'SHA1' ,
           ISNULL(cast(HFUT.UserID as nvarchar(50)),'-')    
          + ISNULL(cast(cus.UserSettingsUserGUID  as nvarchar(50)),'-')   
          + ISNULL(cast(cus.HFitUserMpiNumber  as nvarchar(50)),'-')   
          + ISNULL(cast(cus2.SiteID  as nvarchar(50)),'-')   
          + ISNULL(cast(cs.SiteGUID  as nvarchar(50)),'-')   
          + ISNULL(cast(HFA.AccountID  as nvarchar(50)),'-')   
          + ISNULL(cast(HFA.AccountCD  as nvarchar(50)),'-')   
          + ISNULL(cast(HFUT.ItemCreatedWhen  as nvarchar(50)),'-')   
          + ISNULL(cast(HFUT.ItemModifiedWhen  as nvarchar(50)),'-')   
          + ISNULL(cast(HFUT.itemid  as nvarchar(50)),'-')   
          + 'HFit_UserTracker' )AS      HashCode
     FROM
          dbo.HFit_UserTracker AS HFUT INNER JOIN dbo.CMS_UserSettings AS CUS
          ON hfut.UserID = cus.UserSettingsUserID
                                       INNER JOIN dbo.CMS_UserSite AS CUS2
          ON cus.UserSettingsUserID = cus2.UserID
                                       INNER JOIN dbo.CMS_Site AS CS
          ON CUS2.SiteID = CS.SiteID
                                       INNER JOIN dbo.HFit_Account AS HFA
          ON cs.SiteID = HFA.SiteID
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE HFUT.ItemCreatedWhen < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND HFUT.ItemCreatedWhen < ItemCreatedWhen ) 
          --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
      AND HFUT.ItemCreatedWhen IS NOT NULL		--Add per Robert and Laura 12.4.2014

   UNION ALL
   SELECT
          hftw.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTW.ItemCreatedWhen , 
          HFTW.ItemModifiedWhen , 
          HFTW.Notes , 
          HFTW.IsProfessionallyCollected , 
          HFTW.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   EventName , 
          hftw.Value AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        PPTWeight , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTW.ItemCreatedWhen = COALESCE( HFTW.ItemModifiedWhen , HFTW.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ChangeType , 
          HFTW.ItemCreatedWhen , 
          HFTW.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTW.itemid , 
          'HFit_TrackerWeight' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , +ISNULL( CAST( hftw.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTW.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTW.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTW.Notes , 1000 ) , '-' ) + ISNULL( CAST( HFTW.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTW.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( hftw.Value AS nvarchar( 50 )) , '-' ) + ISNULL( HFTCS.CollectionSourceName_External , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTW.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTW.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTW.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 500 ) , '-' ) + 'HFit_TrackerWeight' )AS HashCode
     FROM
          dbo.HFit_TrackerWeight AS HFTW INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTW.EventDate , HFTW.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTW.EventDate , HFTW.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTW.ItemCreatedWhen IS NOT NULL
       OR HFTW.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014			

   UNION ALL
   SELECT
          HFTHA.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTHA.ItemCreatedWhen , 
          HFTHA.ItemModifiedWhen , 
          HFTHA.Notes , 
          HFTHA.IsProfessionallyCollected , 
          HFTHA.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            EventName , 
          NULL , 
          HFTHA.Value AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                PPTHbA1C , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTHA.ItemCreatedWhen = COALESCE( HFTHA.ItemModifiedWhen , HFTHA.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ChangeType , 
          HFTHA.ItemCreatedWhen , 
          HFTHA.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTHA.itemid , 
          'HFit_TrackerHbA1c' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , +ISNULL( CAST( HFTHA.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTHA.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTHA.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTHA.Notes , 1000 ) , '-' ) + ISNULL( CAST( HFTHA.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTHA.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTHA.Value AS nvarchar( 250 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 1000 ) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTHA.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTHA.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTHA.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 250 ) , '-' ) + 'HFit_TrackerHbA1c' )AS HashCode
     FROM
          dbo.HFit_TrackerHbA1c AS HFTHA INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTHA.EventDate , HFTHA.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTHA.EventDate , HFTHA.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTHA.ItemCreatedWhen IS NOT NULL
       OR HFTHA.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTC.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTC.ItemCreatedWhen , 
          HFTC.ItemModifiedWhen , 
          HFTC.Notes , 
          HFTC.IsProfessionallyCollected , 
          HFTC.EventDate , 
          'Not Build Yet' AS EventName , 
          NULL , 
          NULL , 
          HFTC.Fasting , 
          HFTC.HDL , 
          HFTC.LDL , 
          HFTC.Ratio , 
          HFTC.Total , 
          HFTC.Tri , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTC.ItemCreatedWhen = COALESCE( HFTC.ItemModifiedWhen , HFTC.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                              ChangeType , 
          HFTC.ItemCreatedWhen , 
          HFTC.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTC.itemid , 
          'HFit_TrackerCholesterol' AS                        TBL , 
          VENDOR.ItemID AS                                    VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , 
                              + isNull(cast( HFTC.UserID  as Nvarchar(50) ),'-')  
                              + isNull(cast( cus.UserSettingsUserGUID  as Nvarchar(50) ),'-')  
                              + isNull(cast(cus.HFitUserMpiNumber  as Nvarchar(50) ),'-')  
                              + isNull(cast(       cus2.SiteID  as Nvarchar(50) ),'-')  
                              + isNull(cast(      cs.SiteGUID  as Nvarchar(50) ),'-')  
                              + isNull(cast(     HFTC.ItemCreatedWhen  as Nvarchar(50) ),'-')  
                              + isNull(cast(    HFTC.ItemModifiedWhen  as Nvarchar(50) ),'-')  
                              + isNull(left(   HFTC.Notes , 1000),'-')
                              + isNull(cast(  HFTC.IsProfessionallyCollected  as Nvarchar(50) ),'-')  
                              + isNull(cast( HFTC.EventDate  as Nvarchar(50) ),'-')  
                              + isNull(cast(       HFTC.Fasting  as Nvarchar(50) ),'-')  
                              + isNull(cast(      HFTC.HDL  as Nvarchar(50) ),'-')  
                              + isNull(cast(     HFTC.LDL  as Nvarchar(50) ),'-')  
                              + isNull(cast(    HFTC.Ratio  as Nvarchar(50) ),'-')  
                              + isNull(cast(   HFTC.Total  as Nvarchar(50) ),'-')  
                              + isNull(cast(  HFTC.Tri  as Nvarchar(50) ),'-')  
                              + isNull(left( HFTCS.CollectionSourceName_External,250),'-')
                              + isNull(cast(       HFA.AccountID  as Nvarchar(50) ),'-')  
                              + isNull(cast(      HFA.AccountCD  as Nvarchar(50) ),'-')  
                              + isNull(cast(     HFTC.ItemCreatedWhen  as Nvarchar(50) ),'-')  
                              + isNull(cast(    HFTC.ItemModifiedWhen  as Nvarchar(50) ),'-')  
                              + isNull(cast(   HFTCS.TrackerCollectionSourceID  as Nvarchar(50) ),'-')  
                              + isNull(cast(  HFTC.itemid  as Nvarchar(50) ),'-')         
                              + isNull(cast( VENDOR.ItemID  as Nvarchar(50) ),'-') 
                              + isNull(left(       VENDOR.VendorName,250),'-')
                              + 'HFit_TrackerCholesterol' )AS HashCode
     FROM
          dbo.HFit_TrackerCholesterol AS HFTC INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTC.EventDate , HFTC.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTC.EventDate , HFTC.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTC.ItemCreatedWhen IS NOT NULL
       OR HFTC.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTBSAG.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTBSAG.ItemCreatedWhen , 
          HFTBSAG.ItemModifiedWhen , 
          HFTBSAG.Notes , 
          HFTBSAG.IsProfessionallyCollected , 
          HFTBSAG.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTBSAG.Units , 
          HFTBSAG.FastingState , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTBSAG.ItemCreatedWhen = COALESCE( HFTBSAG.ItemModifiedWhen , HFTBSAG.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ChangeType , 
          HFTBSAG.ItemCreatedWhen , 
          HFTBSAG.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTBSAG.itemid , 
          'HFit_TrackerBloodSugarAndGlucose' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , +ISNULL( CAST( HFTBSAG.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTBSAG.Notes , 250 ) , '-' ) + ISNULL( CAST( HFTBSAG.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.Units AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.FastingState AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 250 ) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBSAG.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 250 ) , '-' ) + 'HFit_TrackerBloodSugarAndGlucose' )AS HashCode
     FROM
          dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTBSAG.EventDate , HFTBSAG.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTBSAG.EventDate , HFTBSAG.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTBSAG.ItemCreatedWhen IS NOT NULL
       OR HFTBSAG.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTBP.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTBP.ItemCreatedWhen , 
          HFTBP.ItemModifiedWhen , 
          HFTBP.Notes , 
          HFTBP.IsProfessionallyCollected , 
          HFTBP.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTBP.Systolic , 
          HFTBP.Diastolic , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTBP.ItemCreatedWhen = COALESCE( HFTBP.ItemModifiedWhen , HFTBP.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ChangeType , 
          HFTBP.ItemCreatedWhen , 
          HFTBP.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTBP.itemid , 
          'HFit_TrackerBloodPressure' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , +ISNULL( CAST( HFTBP.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTBP.Notes , 500 ) , '-' ) + ISNULL( CAST( HFTBP.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.Systolic AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.Diastolic AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 500 ) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBP.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 500 ) , '-' ) + 'HFit_TrackerBloodPressure' )AS HashCode
     FROM
          dbo.HFit_TrackerBloodPressure AS HFTBP INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTBP.EventDate , HFTBP.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTBP.EventDate , HFTBP.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTBP.ItemCreatedWhen IS NOT NULL
       OR HFTBP.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTBF.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTBF.ItemCreatedWhen , 
          HFTBF.ItemModifiedWhen , 
          HFTBF.Notes , 
          HFTBF.IsProfessionallyCollected , 
          HFTBF.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTBF.Value AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               PPTBodyFatPCT , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTBF.ItemCreatedWhen = COALESCE( HFTBF.ItemModifiedWhen , HFTBF.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ChangeType , 
          HFTBF.ItemCreatedWhen , 
          HFTBF.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTBF.itemid , 
          'HFit_TrackerBodyFat' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , ISNULL( CAST( HFTBF.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBF.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBF.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTBF.Notes , 1000 ) , '-' ) + ISNULL( CAST( HFTBF.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBF.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBF.Value AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 250 ) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBF.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBF.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBF.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 250 ) , '-' ) + 'HFit_TrackerBodyFat' )AS HashCode
     FROM
          dbo.HFit_TrackerBodyFat AS HFTBF INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTBF.EventDate , HFTBF.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTBF.EventDate , HFTBF.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTBF.ItemCreatedWhen IS NOT NULL
       OR HFTBF.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTB.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTB.ItemCreatedWhen , 
          HFTB.ItemModifiedWhen , 
          HFTB.Notes , 
          HFTB.IsProfessionallyCollected , 
          HFTB.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTB.BMI , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTB.ItemCreatedWhen = COALESCE( HFTB.ItemModifiedWhen , HFTB.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ChangeType , 
          HFTB.ItemCreatedWhen , 
          HFTB.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTB.itemid , 
          'HFit_TrackerBMI' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , ISNULL( CAST( HFTB.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTB.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTB.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTB.Notes , 1000 ) , '-' ) + ISNULL( CAST( HFTB.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTB.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTB.BMI AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 1000 ) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTB.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTB.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTB.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 1000 ) , '-' ) + 'HFit_TrackerBMI' )AS HashCode
     FROM
          dbo.HFit_TrackerBMI AS HFTB INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTB.EventDate , HFTB.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTB.EventDate , HFTB.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTB.ItemCreatedWhen IS NOT NULL
       OR HFTB.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTBM.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTBM.ItemCreatedWhen , 
          HFTBM.ItemModifiedWhen , 
          HFTBM.Notes , 
          HFTBM.IsProfessionallyCollected , 
          HFTBM.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTBM.WaistInches , 
          HFTBM.HipInches , 
          HFTBM.ThighInches , 
          HFTBM.ArmInches , 
          HFTBM.ChestInches , 
          HFTBM.CalfInches , 
          HFTBM.NeckInches , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTBM.ItemCreatedWhen = COALESCE( HFTBM.ItemModifiedWhen , HFTBM.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ChangeType , 
          HFTBM.ItemCreatedWhen , 
          HFTBM.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTBM.itemid , 
          'HFit_TrackerBodyMeasurements' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , ISNULL( CAST( HFTBM.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTBM.Notes , 1000 ) , '-' ) + ISNULL( CAST( HFTBM.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.WaistInches AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.HipInches AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.ThighInches AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.ArmInches AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.ChestInches AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.CalfInches AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.NeckInches AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 1000 ) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTBM.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 1000 ) , '-' ) + 'HFit_TrackerBodyMeasurements' )AS HashCode
     FROM
          dbo.HFit_TrackerBodyMeasurements AS HFTBM INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTBM.EventDate , HFTBM.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTBM.EventDate , HFTBM.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTBM.ItemCreatedWhen IS NOT NULL
       OR HFTBM.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTH.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTH.ItemCreatedWhen , 
          HFTH.ItemModifiedWhen , 
          HFTH.Notes , 
          HFTH.IsProfessionallyCollected , 
          HFTH.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTH.Height , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTH.ItemCreatedWhen = COALESCE( HFTH.ItemModifiedWhen , HFTH.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ChangeType , 
          HFTH.ItemCreatedWhen , 
          HFTH.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTH.itemid , 
          'HFit_TrackerHeight' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , ISNULL( CAST( HFTH.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTH.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTH.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTH.Notes , 1000 ) , '-' ) + ISNULL( CAST( HFTH.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTH.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTH.Height AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 1000 ) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTH.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTH.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTH.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 1000 ) , '-' ) + 'HFit_TrackerHeight' )AS HashCode
     FROM
          dbo.HFit_TrackerHeight AS HFTH INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTH.EventDate , HFTH.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTH.EventDate , HFTH.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTH.ItemCreatedWhen IS NOT NULL
       OR HFTH.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014
   UNION ALL
   SELECT
          HFTRHR.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTRHR.ItemCreatedWhen , 
          HFTRHR.ItemModifiedWhen , 
          HFTRHR.Notes , 
          HFTRHR.IsProfessionallyCollected , 
          HFTRHR.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTRHR.HeartRate , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTRHR.ItemCreatedWhen = COALESCE( HFTRHR.ItemModifiedWhen , HFTRHR.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ChangeType , 
          HFTRHR.ItemCreatedWhen , 
          HFTRHR.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTRHR.itemid , 
          'HFit_TrackerRestingHeartRate' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , ISNULL( CAST( HFTRHR.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.HeartRate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTRHR.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTRHR.Notes , 1000 ) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 1000 ) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 1000 ) , '-' ) + 'HFit_TrackerRestingHeartRate' )AS HashCode
     FROM
          dbo.HFit_TrackerRestingHeartRate AS HFTRHR INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTRHR.EventDate , HFTRHR.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTRHR.EventDate , HFTRHR.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTRHR.ItemCreatedWhen IS NOT NULL
       OR HFTRHR.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTS.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTS.ItemCreatedWhen , 
          HFTS.ItemModifiedWhen , 
          HFTS.Notes , 
          HFTS.IsProfessionallyCollected , 
          HFTS.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTS.FluShot , 
          HFTS.PneumoniaShot , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTS.ItemCreatedWhen = COALESCE( HFTS.ItemModifiedWhen , HFTS.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ChangeType , 
          HFTS.ItemCreatedWhen , 
          HFTS.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTS.itemid , 
          'HFit_TrackerShots' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , ISNULL( CAST( HFTS.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.FluShot AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.PneumoniaShot AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTS.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTS.Notes , 1000 ) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 1000 ) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 1000 ) , '-' ) + 'HFit_TrackerShots' )AS HashCode
     FROM
          dbo.HFit_TrackerShots AS HFTS INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTS.EventDate , HFTS.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTS.EventDate , HFTS.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTS.ItemCreatedWhen IS NOT NULL
       OR HFTS.EventDate IS NOT NULL)		--Add per RObert and Laura 12.4.2014

   UNION ALL
   SELECT
          HFTT.UserID , 
          cus.UserSettingsUserGUID , 
          cus.HFitUserMpiNumber , 
          cus2.SiteID , 
          cs.SiteGUID , 
          HFTT.ItemCreatedWhen , 
          HFTT.ItemModifiedWhen , 
          HFTT.Notes , 
          HFTT.IsProfessionallyCollected , 
          HFTT.EventDate , 
          'Not Build Yet' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              EventName , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          NULL , 
          HFTT.PSATest , 
          HFTT.OtherExam , 
          HFTT.TScore , 
          HFTT.DRA , 
          HFTT.CotinineTest , 
          HFTT.ColoCareKit , 
          HFTT.CustomTest , 
          HFTT.CustomDesc , 
          HFTCS.CollectionSourceName_External , 
          HFA.AccountID , 
          HFA.AccountCD , 
          CASE
          WHEN HFTT.ItemCreatedWhen = COALESCE( HFTT.ItemModifiedWhen , HFTT.ItemCreatedWhen )THEN 'I'
              ELSE 'U'
          END AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ChangeType , 
          HFTT.ItemCreatedWhen , 
          HFTT.ItemModifiedWhen , 
          HFTCS.TrackerCollectionSourceID , 
          HFTT.itemid , 
          'HFit_TrackerTests' AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          TBL , 
          VENDOR.ItemID AS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                VendorID , 
          VENDOR.VendorName , 
          HASHBYTES( 'SHA1' , +ISNULL( CAST( HFTT.UserID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.UserSettingsUserGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cus2.SiteID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( cs.SiteGUID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.IsProfessionallyCollected AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.EventDate AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.PSATest AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.OtherExam AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.TScore AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.DRA AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.CotinineTest AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.ColoCareKit AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.CustomTest AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFA.AccountCD AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.ItemCreatedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.ItemModifiedWhen AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTCS.TrackerCollectionSourceID AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( HFTT.itemid AS nvarchar( 50 )) , '-' ) + ISNULL( CAST( VENDOR.ItemID AS nvarchar( 50 )) , '-' ) + ISNULL( LEFT( HFTCS.CollectionSourceName_External , 1000 ) , '-' ) + ISNULL( LEFT( HFTT.Notes , 1000 ) , '-' ) + ISNULL( LEFT( HFTT.CustomDesc , 1000 ) , '-' ) + ISNULL( LEFT( VENDOR.VendorName , 1000 ) , '-' ) + 'HFit_TrackerTests' )AS HashCode
     FROM
          dbo.HFit_TrackerTests AS HFTT INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS
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
     WHERE
          CS.SITEID NOT IN( 
                            SELECT
                                   SiteID
                              FROM EDW_BiometricViewRejectCriteria
                              WHERE COALESCE( HFTT.EventDate , HFTT.ItemCreatedWhen ) < ItemCreatedWhen )
      AND HFA.AccountCD NOT IN( 
                                SELECT
                                       AccountCD
                                  FROM EDW_BiometricViewRejectCriteria
                                  WHERE
                                       HFA.AccountCD = AccountCD
                                   AND COALESCE( HFTT.EventDate , HFTT.ItemCreatedWhen ) < ItemCreatedWhen )
      AND (
          HFTT.ItemCreatedWhen IS NOT NULL
       OR HFTT.EventDate IS NOT NULL);		--Add per RObert and Laura 12.4.2014

--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

GO

PRINT 'Created view_EDW_BioMetrics_CT: ' + CAST( GETDATE( )AS nvarchar( 50 ));
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_BioMetrics_CT.sql';
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
PRINT '***** COMPLETED : view_EDW_BioMetrics_CT.sql';
GO 
