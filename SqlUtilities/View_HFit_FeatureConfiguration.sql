USE [KenticoCMS_DEV]
GO

/****** Object:  View [dbo].[View_HFit_FeatureConfiguration]    Script Date: 7/30/2014 12:26:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[View_HFit_FeatureConfiguration]
/*******************************************************************************
Description: A view that shows the available features

8/30/2013 SReutzel: Initial
9/4/2013 bwright: changed site id to site guid

*******************************************************************************/
AS
	SELECT DISTINCT
		cs.SiteGUID
		, r.RoleName AS Feature
		, f.ValidFromDate
		, f.ValidToDate
		, f.AlwaysActive
		, HFA.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(f.ItemCreatedWhen AS DATE) = CAST(f.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, f.ItemCreatedWhen
		, f.ItemModifiedWhen
	FROM
		HFit_ConfigFeatures f WITH ( NOLOCK )
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON f.SiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	INNER JOIN CMS_Role r WITH ( NOLOCK ) ON f.RoleID = r.RoleID
	WHERE
		f.ItemCreatedWhen IS NOT NULL
		AND f.ItemModifiedWhen IS NOT NULL 






GO



-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
