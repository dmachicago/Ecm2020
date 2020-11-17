use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Participant' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Participant
END
GO


--****************************************************
Select DISTINCT top 100 
     HFitUserMpiNumber
    ,UserID
    ,UserGUID
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,HFitUserPreferredMailingAddress
    ,HFitUserPreferredMailingCity
    ,HFitUserPreferredMailingState
    ,HFitUserPreferredMailingPostalCode
    ,HFitCoachingEnrollDate
    ,HFitUserAltPreferredPhone
    ,HFitUserAltPreferredPhoneExt
    ,HFitUserAltPreferredPhoneType
    ,HFitUserPreferredPhone
    ,HFitUserPreferredFirstName
--    ,HFitUserPreferredEmail                  --MISSING from one view
    ,ChangeType
    ,UserCreated
    ,UserLastModified
    ,Account_ItemModifiedWhen
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Participant
FROM
view_EDW_Participant where HFitUserMpiNumber is not null and HFitUserMpiNumber > 0;;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Participant' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Participant
END
GO


--****************************************************
Select DISTINCT top 100 
     HFitUserMpiNumber
    ,UserID
    ,UserGUID
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,HFitUserPreferredMailingAddress
    ,HFitUserPreferredMailingCity
    ,HFitUserPreferredMailingState
    ,HFitUserPreferredMailingPostalCode
    ,HFitCoachingEnrollDate
    ,HFitUserAltPreferredPhone
    ,HFitUserAltPreferredPhoneExt
    ,HFitUserAltPreferredPhoneType
    ,HFitUserPreferredPhone
    ,HFitUserPreferredFirstName
--    ,HFitUserPreferredEmail                  --MISSING from one view
    ,ChangeType
    ,UserCreated
    ,UserLastModified
    ,Account_ItemModifiedWhen
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Participant
FROM
view_EDW_Participant where HFitUserMpiNumber is not null and HFitUserMpiNumber > 0;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Participant order by HFitUserMpiNumber;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Participant order by HFitUserMpiNumber;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_Participant'; 