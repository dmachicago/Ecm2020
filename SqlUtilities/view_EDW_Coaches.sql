
go

if exists (select name from sys.views where name = 'view_EDW_Coaches')
drop view view_EDW_Coaches
go

create VIEW [dbo].[view_EDW_Coaches]

AS

SELECT distinct
    cu.UserGUID
   ,cs.SiteGUID
   ,HFA.AccountID
   ,HFA.AccountCD
   ,CoachID
   ,hfc.LastName
   ,hfc.FirstName
   ,cast(hfc.StartDate as datetime) as StartDate
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
   ,cast(hfc.Last_Update_Dt as datetime) as Last_Update_Dt
FROM
    dbo.HFit_Coaches AS HFC
LEFT OUTER JOIN dbo.CMS_User AS CU ON hfc.KenticoUserID = cu.UserID
LEFT OUTER JOIN dbo.CMS_UserSite AS CUS ON cu.userid = cus.UserID
LEFT OUTER JOIN dbo.CMS_Site AS CS ON CS.SiteID = CUS.SiteID
LEFT OUTER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID
GO


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
