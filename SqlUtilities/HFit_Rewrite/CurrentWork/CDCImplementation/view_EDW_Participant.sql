
GO
PRINT 'Processing: view_EDW_Participant ';
PRINT '***** FROM: view_EDW_Participant.sql';
GO

IF EXISTS (SELECT
           TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
                  WHERE TABLE_NAME = 'view_EDW_Participant') 
    BEGIN
        PRINT 'View exists, dropping to recreate.';
        DROP VIEW
        view_EDW_Participant;
    END;
GO
--select count(*) from view_EDW_Participant
--select top * from view_EDW_Participant where LastModifiedDate between d2 and d2
IF NOT EXISTS (SELECT column_name
                      FROM information_schema.columns
                      WHERE column_name = 'HFitUserIsRegistered'
                        AND table_name = 'FACT_CMS_UserSettings') 
    BEGIN
        ALTER TABLE FACT_CMS_UserSettings
        ADD HFitUserIsRegistered bit NULL;
    END;
GO

CREATE VIEW dbo.view_EDW_Participant
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
    , CAST (cus.HFitCoachingEnrollDate AS datetime) AS HFitCoachingEnrollDate
    , cus.HFitUserAltPreferredPhone
    , cus.HFitUserAltPreferredPhoneExt
    , cus.HFitUserAltPreferredPhoneType
    , cus.HFitUserPreferredPhone
    , cus.HFitUserPreferredFirstName
    , CUS.HFitUserPreferredEmail
    , CAST (CUS.HFitUserRegistrationDate AS datetime2) AS HFitUserRegistrationDate
    , CUS.HFitUserIsRegistered
    , CASE
		WHEN CAST (cu.UserCreated AS date) = CAST (cu.UserLastModified AS date) 
		    THEN 'I'
		ELSE 'U'
	 END AS ChangeType
    , CAST (cu.UserCreated AS datetime) AS User_Created
    , CAST (cu.UserLastModified AS datetime) AS User_LastModified
    , CAST (HFA.ItemModifiedWhen AS datetime) AS Account_LastModified	--wdm: 09.11.2014 added to view
    , CUS2.LASTMODIFIEDDATE AS UserSite_LastModified
    , CS.LASTMODIFIEDDATE AS Site_LastModified
    , CUS.LASTMODIFIEDDATE AS UserSettings_LastModified
    , (SELECT MAX (LASTMODIFIEDDATE) 
			   FROM (VALUES (
						 CUS.LASTMODIFIEDDATE) , (
						 CS.LASTMODIFIEDDATE) , (
						 CUS2.LASTMODIFIEDDATE) , (
						 HFA.ItemModifiedWhen) , (
						 cu.UserLastModified)) AS LastModDate) AS LastModifiedDate
       FROM
           dbo.FACT_CMS_User AS CU
               INNER JOIN dbo.FACT_CMS_UserSite AS CUS2 WITH (NOLOCK) 
                   ON CU.UserID = CUS2.UserID
                  AND CU.DBNAME = CUS2.DBNAME
                  AND CU.SVR = CUS2.SVR
               INNER JOIN dbo.FACT_HFit_Account AS HFA WITH (NOLOCK) 
                   ON cus2.SiteID = hfa.SiteID
                  AND cus2.DBNAME = hfa.DBNAME
                  AND cus2.SVR = hfa.SVR
               INNER JOIN dbo.FACT_CMS_Site AS CS WITH (NOLOCK) 
                   ON CUS2.SiteID = CS.SiteID
                  AND cus2.DBNAME = CS.DBNAME
                  AND cus2.SVR = CS.SVR
               INNER JOIN dbo.FACT_CMS_UserSettings AS CUS WITH (NOLOCK) 
                   ON CU.UserID = CUS.UserSettingsUserID
                  AND CUS.HFitUserMpiNumber > 0
                  AND CUS.HFitUserMpiNumber IS NOT NULL
                  AND CU.DBNAME = CUS.DBNAME
                  AND CU.SVR = CUS.SVR;
GO

IF NOT EXISTS (SELECT name
                      FROM sys.indexes
                      WHERE name = 'CI_FACT_cms_usersettings02') 
    BEGIN
        PRINT 'Created/Updated: CI_FACT_cms_usersettings02';
        CREATE NONCLUSTERED INDEX CI_FACT_cms_usersettings02
        ON dbo.FACT_cms_usersettings (HFitUserMpiNumber) 
        INCLUDE (UserSettingsUserID, HFitUserPreferredEmail, HFitUserPreferredPhone, HFitUserPreferredFirstName, HfitUserPreferredMailingAddress, HfitUserPreferredMailingCity, HfitUserPreferredMailingState, HfitUserPreferredMailingPostalCode, HFitCoachingEnrollDate, HFitUserAltPreferredPhone, HFitUserAltPreferredPhoneType, HFitUserAltPreferredPhoneExt, HFitUserRegistrationDate, HFitUserIsRegistered, LASTMODIFIEDDATE, SVR, DBNAME) ;
    END;

IF NOT EXISTS (SELECT name
                      FROM sys.indexes
                      WHERE name = 'CI_FACT_cms_usersettings03') 
    BEGIN
        CREATE NONCLUSTERED INDEX CI_FACT_cms_usersettings03
        ON dbo.FACT_cms_user (UserID, SVR, DBNAME) 
        INCLUDE (UserCreated, UserGUID, UserLastModified) ;
    END;
GO
IF NOT EXISTS (SELECT name
                      FROM sys.indexes
                      WHERE name = 'CI_FACT_cms_usersettings04') 
    BEGIN
        CREATE NONCLUSTERED INDEX CI_FACT_cms_usersettings04
        ON dbo.FACT_cms_usersettings (UserSettingsUserID, SVR, DBNAME, HFitUserMpiNumber) 
        INCLUDE (HFitUserPreferredEmail, HFitUserPreferredPhone, HFitUserPreferredFirstName, HfitUserPreferredMailingAddress, HfitUserPreferredMailingCity, HfitUserPreferredMailingState, HfitUserPreferredMailingPostalCode, HFitCoachingEnrollDate, HFitUserAltPreferredPhone, HFitUserAltPreferredPhoneType, HFitUserAltPreferredPhoneExt, HFitUserRegistrationDate, HFitUserIsRegistered, LASTMODIFIEDDATE) ;
    END;
GO
PRINT 'Created/Updated: view_EDW_Participant ';
PRINT '***** FROM: view_EDW_Participant.sql';
GO 
