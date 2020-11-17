
/****** Object:  View [dbo].[View_HFit_GroupConfiguration]    Script Date: 8/12/2014 3:35:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[View_HFit_GroupConfiguration]

AS
/*******************************************************************************
Description: A view that shows users, the groups they belong to, the membership and roles.

8/30/2013 SReutzel: Initial
9/4/2013 bwright: added site GUID and modified when and UserGUID

*******************************************************************************/
	SELECT DISTINCT
		CU.UserGUID
		, cus.HFitUserMpiNumber
		, CU.FirstName
		, CU.LastName
		, OCG.ContactGroupName
		, HFLCGT.ContactGroupType
		, cm.MembershipName
		, CR.RoleName AS Feature
       --,cgm.ItemModifiedWhen
		, cs.SiteGUID
		, hfa.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFCF.ItemCreatedWhen AS DATE) = CAST(HFCF.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HFCF.ItemCreatedWhen
		, HFCF.ItemModifiedWhen
	FROM
		dbo.OM_Contact AS OC WITH ( NOLOCK )
	INNER JOIN dbo.OM_Membership AS OM WITH ( NOLOCK ) ON oc.ContactID = om.OriginalContactID
	INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON om.RelatedID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON cu.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cu.UserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = hfa.SiteID
	INNER JOIN dbo.OM_ContactGroupMember AS OCGM WITH ( NOLOCK ) ON oc.ContactID = OCGM.ContactGroupMemberRelatedID
	INNER JOIN dbo.OM_ContactGroup AS OCG WITH ( NOLOCK ) ON ocgm.ContactGroupMemberContactGroupID = ocg.ContactGroupID
	INNER JOIN dbo.HFit_ContactGroupMembership AS HFCGM WITH ( NOLOCK ) ON ocg.ContactGroupID = HFCGM.omContactGroupID
	LEFT OUTER JOIN dbo.HFit_LKP_ContactGroupType AS HFLCGT WITH ( NOLOCK ) ON hfcgm.ContactGroupTypeID = HFLCGT.ItemID
	INNER JOIN dbo.CMS_Membership AS CM WITH ( NOLOCK ) ON hfcgm.cmsMembershipID = cm.MembershipID
	INNER JOIN dbo.CMS_MembershipRole AS CMR WITH ( NOLOCK ) ON CM.MembershipID = CMR.MembershipID
	INNER JOIN dbo.CMS_Role AS CR WITH ( NOLOCK ) ON CMR.RoleID = CR.RoleID
	INNER JOIN dbo.HFit_configGroupToFeature AS HFCGTF WITH ( NOLOCK ) ON HFCGM.ContactGroupMembershipID = HFCGTF.ContactGroupMembershipID
	INNER JOIN dbo.HFit_configFeatures AS HFCF WITH ( NOLOCK ) ON HFCGTF.ConfigFeatureID = HFCF.ItemID
																AND CR.RoleID = HFCF.RoleID
	WHERE
		HFCF.ItemCreatedWhen IS NOT NULL
		AND HFCF.ItemModifiedWhen IS NOT NULL 



GO


