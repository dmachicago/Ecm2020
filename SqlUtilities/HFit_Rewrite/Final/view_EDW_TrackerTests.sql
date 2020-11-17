
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerTests')
BEGIN
	drop view view_EDW_TrackerTests ;
END

GO

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerTests]
AS
	SELECT
		HFTT.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTT.EventDate
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
		, HFTT.ItemCreatedWhen
		, HFTT.ItemModifiedWhen
		, HFTT.ItemGUID
	FROM
		dbo.HFit_TrackerTests AS HFTT
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTT.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID

GO


