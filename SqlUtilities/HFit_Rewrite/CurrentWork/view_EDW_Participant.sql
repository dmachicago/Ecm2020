
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
--select top 300 * from view_EDW_Participant
if not exists (select column_name from information_schema.columns where column_name = 'HFitUserIsRegistered' and table_name = 'CMS_UserSettings')
begin
    alter table CMS_UserSettings add HFitUserIsRegistered bit null ;
End;
go

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
     , cast(CUS.HFitUserRegistrationDate as datetime2)	as HFitUserRegistrationDate
     , CUS.HFitUserIsRegistered
     , CASE
           WHEN CAST (cu.UserCreated AS date) = CAST (cu.UserLastModified AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , CAST (cu.UserCreated AS datetime) AS UserCreated
     , CAST (cu.UserLastModified AS datetime) AS UserLastModified
     , CAST (HFA.ItemModifiedWhen AS datetime) AS Account_ItemModifiedWhen	--wdm: 09.11.2014 added to view
       FROM dbo.CMS_User AS CU
            INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
                    ON CU.UserID = CUS2.UserID
            INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
                    ON cus2.SiteID = hfa.SiteID
            INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
                    ON CUS2.SiteID = CS.SiteID
            INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
                    ON CU.UserID = CUS.UserSettingsUserID and CUS.HFitUserMpiNumber > 0 and CUS.HFitUserMpiNumber is not null;

GO

--  
--  
GO
PRINT 'Created/Updated: view_EDW_Participant ';
PRINT '***** FROM: view_EDW_Participant.sql';
GO 
