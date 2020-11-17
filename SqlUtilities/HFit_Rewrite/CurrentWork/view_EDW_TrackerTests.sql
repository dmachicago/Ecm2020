
print ('Processing: view_EDW_TrackerTests ') ;

GO


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerTests')
BEGIN
	drop view view_EDW_TrackerTests ;
END

GO


--********************************************************************************************************
-- 09.11.2014 : (wdm) Verified last mod date available to EDW 
-- Select count(*) from [view_EDW_TrackerTests] 40322 vs. 40313 with distinct 44502 / 44483 on TGT P1
--									   44502 vs. 44483 with distinct on Prod5 / P1
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerTests]
AS
	SELECT 
		HFTT.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, cast(HFTT.EventDate as datetime) as EventDate
		, HFTT.IsProfessionallyCollected
		, HFTT.TrackerCollectionSourceID
		, HFTT.Notes
		, HFTT.PSATest
		, HFTT.OtherExam
		, HFTT.TScore
		, HFTT.DRA
		, HFTT.CotinineTest
		, HFTT.ColoCareKit
		, HFTT.CustomTest
		, HFTT.CustomDesc
		, HFTT.TSH
		, cast(HFTT.ItemCreatedWhen as datetime) as ItemCreatedWhen
		, cast(HFTT.ItemModifiedWhen as datetime) as ItemModifiedWhen
		, HFTT.ItemGUID
	FROM
		dbo.HFit_TrackerTests AS HFTT
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTT.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID
GO


  --  
  --  
GO 
print('***** FROM: view_EDW_TrackerTests.sql'); 
GO 

