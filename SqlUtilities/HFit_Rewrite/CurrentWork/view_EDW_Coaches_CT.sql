

go
-- use KenticoCMS_Prod1

print ('Processing: view_EDW_Coaches_CT ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_Coaches_CT')
BEGIN
	drop view view_EDW_Coaches_CT ;
END
GO

/****************************************************
WDM Verified last mod date available to EDW 9.10.2014

select count(*) from view_EDW_Coaches_CT
select * from view_EDW_Coaches_CT

select count(*), HashCode
from view_EDW_Coaches_CT
group by HashCode 
having count(*) > 1

select * from view_EDW_Coaches_CT
where UserGuid in ('92281FC6-565B-4657-BBC0-D250BE87F59A','DC60654C-8796-4789-B0A0-FC359215BB7B')

select count(*), 
    UserGUID
    ,SiteGUID
    ,AccountID
    ,AccountCD
    ,CoachID
    ,email   
from [view_EDW_Coaches_CT]
group by 
UserGUID
   ,SiteGUID
   ,AccountID
   ,AccountCD
   ,CoachID
   ,email   
having count(*) > 1

****************************************************/
CREATE VIEW [dbo].[view_EDW_Coaches_CT]

AS

SELECT distinct
    cu.UserGUID
   ,cs.SiteGUID
   ,HFA.AccountID
   ,HFA.AccountCD
   ,CoachID
   ,hfc.LastName
   ,hfc.FirstName
   ,hfc.StartDate
   ,hfc.Phone
   ,hfc.email
   ,hfc.Supervisor
   ,hfc.SuperCoach
   ,hfc.MaxParticipants
   ,hfc.Inactive
   ,hfc.MaxRiskLevel
   ,hfc.Locked
   ,hfc.TimeLocked
   ,hfc.terminated
   ,hfc.APMaxParticipants
   ,hfc.RNMaxParticipants
   ,hfc.RNPMaxParticipants
   ,hfc.Change_Type
   ,hfc.Last_Update_Dt
,hashbytes ('sha1',
    isnull(cast(cu.UserGUID as nvarchar(100)),'-')
   + isnull(cast(cs.SiteGUID as nvarchar(100)),'-')
   + isnull(cast(HFA.AccountID as nvarchar(100)),'-')
   + isnull(cast(HFA.AccountCD as nvarchar(100)),'-')
   + isnull(cast(CoachID as nvarchar(100)),'-')
   + isnull(cast(hfc.LastName as nvarchar(250)),'-')
   + isnull(cast(hfc.FirstName as nvarchar(250)),'-')
   + isnull(cast(hfc.StartDate as nvarchar(100)),'-')
   + isnull(cast(hfc.Phone as nvarchar(100)),'-')
   + isnull(cast(hfc.email as nvarchar(250)),'-')
   + isnull(cast(hfc.Supervisor as nvarchar(100)),'-')
   + isnull(cast(hfc.SuperCoach as nvarchar(100)),'-')
   + isnull(cast(hfc.MaxParticipants as nvarchar(100)),'-')
   + isnull(cast(hfc.Inactive as nvarchar(100)),'-')
   + isnull(cast(hfc.MaxRiskLevel as nvarchar(100)),'-')
   + isnull(cast(hfc.Locked as nvarchar(100)),'-')
   + isnull(cast(hfc.TimeLocked as nvarchar(100)),'-')
   + isnull(cast(hfc.terminated as nvarchar(100)),'-')
   + isnull(cast(hfc.APMaxParticipants as nvarchar(100)),'-')
   + isnull(cast(hfc.RNMaxParticipants as nvarchar(100)),'-')
   + isnull(cast(hfc.RNPMaxParticipants as nvarchar(100)),'-')
   + isnull(cast(hfc.Last_Update_Dt as nvarchar(100)),'-')
) as HashCode
, @@SERVERNAME as SVR
    , DB_NAME() as DBNAME
	  FROM
    dbo.HFit_Coaches AS HFC
LEFT OUTER JOIN dbo.CMS_User AS CU ON hfc.KenticoUserID = cu.UserID
LEFT OUTER JOIN dbo.CMS_UserSite AS CUS ON cu.userid = cus.UserID
LEFT OUTER JOIN dbo.CMS_Site AS CS ON CS.SiteID = CUS.SiteID
LEFT OUTER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID

GO


  --  
  --  
GO 
print('***** FROM: view_EDW_Coaches_CT.sql'); 
GO 
