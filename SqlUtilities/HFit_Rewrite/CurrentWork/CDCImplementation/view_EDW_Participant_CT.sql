
GO
PRINT 'Processing: view_EDW_Participant_CT ';
PRINT '***** FROM: view_EDW_Participant_CT.sql';
GO

IF EXISTS ( SELECT
                   TABLE_NAME
              FROM INFORMATION_SCHEMA.VIEWS
              WHERE TABLE_NAME = 'view_EDW_Participant_CT' )
    BEGIN
        PRINT 'View exists, dropping to recreate.';
        DROP VIEW
             view_EDW_Participant_CT;
    END;
GO
--select top 300 * from view_EDW_Participant_CT where CHANGED_FLG is not null
-- select count(*) from view_EDW_Participant_CT
CREATE VIEW dbo.view_EDW_Participant_CT
AS
--*********************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 (wdm) added date fields to facilitate EDW determination of last mod date 
--05.06.2015 (wdm) added HFitUserPreferredEmail to the view to resolve 52888 per a 
--				conversation with Vijay, Shankar, and John K.
--05.15.2015 (WDM) John and I, while working on this item, found the story has been removed ??? No idea why.
--05.15.2015 (WDM) CUS.HFitUserRegistrationDate (52189)  The contract (story) was removed by Vijay causing John and I to miss this one. We luckily caught it today and fixed the missing columns
--05.15.2015 (WDM) CUS.HFitUserIsRegistered  (52189)	  The contract (story) was removed by Vijay causing John and I to miss this one. We luckily caught it today and fixed the missing columns
--*********************************************************************************************

/*
Natural Key:
    [UserID]
    ,[UserGUID]
    ,[SiteGUID]
    ,[AccountID]
    ,[AccountCD]   
*/

SELECT  
       cus.HFitUserMpiNumber
       ,cu.UserID
       ,cu.UserGUID
       ,CS.SiteGUID
       ,hfa.AccountID
       ,hfa.AccountCD
       ,cus.HFitUserPreferredMailingAddress
       ,cus.HFitUserPreferredMailingCity
       ,cus.HFitUserPreferredMailingState
       ,cus.HFitUserPreferredMailingPostalCode
       ,CAST ( cus.HFitCoachingEnrollDate AS datetime ) AS HFitCoachingEnrollDate
       ,cus.HFitUserAltPreferredPhone
       ,cus.HFitUserAltPreferredPhoneExt
       ,cus.HFitUserAltPreferredPhoneType
       ,cus.HFitUserPreferredPhone
       ,cus.HFitUserPreferredFirstName
       ,CUS.HFitUserPreferredEmail
       ,CAST( CUS.HFitUserRegistrationDate AS datetime2 )	AS HFitUserRegistrationDate
       ,CUS.HFitUserIsRegistered
       ,CASE
        WHEN CAST ( cu.UserCreated AS date ) = CAST ( cu.UserLastModified AS date )
        THEN 'I'
            ELSE 'U'
        END AS ChangeType
       ,CAST ( cu.UserCreated AS datetime ) AS UserCreated
       ,CAST ( cu.UserLastModified AS datetime ) AS UserLastModified
       ,CAST ( HFA.ItemModifiedWhen AS datetime ) AS Account_ItemModifiedWhen	--wdm: 09.11.2014 added to view

       ,CAST( HASHBYTES( 'sha1' ,
			 ISNULL( CAST( cus.HFitUserMpiNumber AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cu.UserID AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cu.UserGUID AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( CS.SiteGUID AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( hfa.AccountID AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( hfa.AccountCD AS nvarchar( 50 )) , '-' ) +
			 ISNULL( cus.HFitUserPreferredMailingAddress , '-' ) +
			 ISNULL( cus.HFitUserPreferredMailingCity , '-' ) +
			 ISNULL( cus.HFitUserPreferredMailingState , '-' ) +
			 ISNULL( CAST( cus.HFitUserPreferredMailingPostalCode AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cus.HFitCoachingEnrollDate  AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cus.HFitUserAltPreferredPhone AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cus.HFitUserAltPreferredPhoneExt AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cus.HFitUserAltPreferredPhoneType AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cus.HFitUserPreferredPhone AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( cus.HFitUserPreferredFirstName AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( CUS.HFitUserPreferredEmail AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( CUS.HFitUserRegistrationDate AS nvarchar( 50 )) , '-' ) +
			 ISNULL( CAST( CUS.HFitUserIsRegistered AS nvarchar( 50 )) , '-' )
       ) AS nvarchar( 100 )) AS HashCode
       , COALESCE ( 
		  CT_CMS_User.SYS_CHANGE_OPERATION
		  ,CT_CMS_UserSettings.SYS_CHANGE_OPERATION
		  ,CT_HFit_Account.SYS_CHANGE_OPERATION
		  ,CT_CMS_Site.SYS_CHANGE_OPERATION
		  ,CT_CMS_UserSettings.SYS_CHANGE_OPERATION) AS CHANGED_FLG
    , @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	   FROM
		  dbo.FACT_CMS_User AS CU 
		  INNER JOIN dbo.FACT_CMS_UserSite AS CMSUS WITH ( NOLOCK )
                          ON CU.UserID = CMSUS.UserID
				        and CU.DBNAME = CMSUS.DBNAME
					   and CU.SVR = CMSUS.SVR
		  INNER JOIN dbo.FACT_HFit_Account AS HFA WITH ( NOLOCK )
                          ON CMSUS.SiteID = hfa.SiteID
					   and CMSUS.DBNAME = hfa.DBNAME
					   and CMSUS.SVR = hfa.SVR
		  INNER JOIN dbo.FACT_CMS_Site AS CS WITH ( NOLOCK )
                          ON CMSUS.SiteID = CS.SiteID
					   and CMSUS.DBNAME = CS.DBNAME
					   and CMSUS.SVR = CS.SVR
		  INNER JOIN dbo.FACT_CMS_UserSettings AS CUS WITH ( NOLOCK )
                          ON CU.UserID = CUS.UserSettingsUserID
					   and CUS.HFitUserMpiNumber > 0 and CUS.HFitUserMpiNumber is not null
					   and CU.DBNAME = CUS.DBNAME
					   and CU.SVR = CUS.SVR
		  LEFT JOIN CHANGETABLE(CHANGES FACT_CMS_User , NULL)AS CT_CMS_User
			 ON CU.UserID = CT_CMS_User.UserID 
			 AND CU.SVR = CT_CMS_User.SVR
			 AND CU.DBNAME = CT_CMS_User.DBNAME
		  LEFT JOIN CHANGETABLE(CHANGES FACT_CMS_UserSite , NULL) AS CT_CMS_UserSite
			 ON CMSUS.UserSiteID = CT_CMS_UserSite.UserSiteID
			 AND CMSUS.SVR = CT_CMS_UserSite.SVR
			 AND CMSUS.DBNAME = CT_CMS_UserSite.DBNAME
		  LEFT JOIN CHANGETABLE(CHANGES FACT_HFit_Account , NULL)AS CT_HFit_Account
			 ON HFA.AccountID = CT_HFit_Account.AccountID
			 AND HFA.SVR = CT_HFit_Account.SVR
			 AND HFA.DBNAME = CT_HFit_Account.DBNAME
		  LEFT JOIN CHANGETABLE(CHANGES FACT_CMS_Site , NULL)AS CT_CMS_Site
			 ON CS.SiteID = CT_CMS_Site.SiteID
			 			 AND CS.SVR = CT_CMS_Site.SVR
			 AND CS.DBNAME = CT_CMS_Site.DBNAME
		  LEFT JOIN CHANGETABLE(CHANGES FACT_CMS_UserSettings , NULL)AS CT_CMS_UserSettings
			 ON CUS.UserSettingsID = CT_CMS_UserSettings.UserSettingsID
			 			 AND CUS.SVR = CT_CMS_UserSettings.SVR
			 AND CUS.DBNAME = CT_CMS_UserSettings.DBNAME
GO

--  
--  
GO
PRINT 'Created/Updated: view_EDW_Participant_CT ';
PRINT '***** FROM: view_EDW_Participant_CT.sql';
GO 
