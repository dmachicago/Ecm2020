USE [DataMartPlatform];
GO

/***********************************************************************************************
***** Object:  View [dbo].[view_EDW_Eligibility_MART]    Script Date: 4/13/2016 7:04:29 PM *****
***********************************************************************************************/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

--select top 1000 * from view_EDW_Eligibility_MART where EligibilityStartDate > getdate() -1 
--select count(*) from view_EDW_Eligibility_MART 

CREATE VIEW dbo.view_EDW_Eligibility_MART
AS

--*************************************************************************************************************************
--Total returned 2473454
--select count(*)  from CMS_Role --305
--select count(*) from cms_MembershipRole --256
--select count(*) from cms_MembershipUser --37215
--select count(*) from CMS_Role --305
--select count(*) from view_EDW_EligibilityHistory	--58540
--select count(*) from EDW_GroupMemberHistory			--58540
--view_EDW_Eligibility_MART is the starting point for the EDW to pull data. As of 11.11.2014, all columns
--within the view are just a starting point. We will work with the EDW team to define and pull all the data
--they are needing.
--A PPT becomes eligible to participate through the Rules
--Rules of Engagement:
--00: ROLES are tied to a feature ; if the ROLE is not on a Kentico page - you don't see it.
--01: When the Kentico group rebuild executes, all is lost. There is no retained MEMBER/User history.
--02: The group does not track when a member enters or leaves a group, simply that they exist in that group.
--NOTE: Any data deemed necessary can be added to this view for the EDW
--01.27.2015 (WDM) #48941 - Add Client Identifier to view_EDW_Eligibility_MART
--	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
--	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
--02.02.2015 (WDM) #44691 - Added the Site ID, Site Name, and Site Display Name to the returned cols of data
--	  per the conversation with John C. earlier this morning.
--02.05.2015 (WDM) #44691 - Added the Site GUID
--02.27.2015 (WDM) Yesterday, John C. found a potential problem in with what appeared to be a cross-product join.
--			Found that the table EDW_GroupMemberHistory was referenced twice, once as a base table and once as a view.
--			Removed one of the joins and the number of returned rows fell drastically - from 800M to 50M - 100M.
-- 04.27.2015 (WDM) - modified all dates to be cast as datetime NOT datetime2 per EDW decision.
--*************************************************************************************************************************

SELECT
       ROLES.RoleID
     ,ROLES.RoleName
     ,ROLES.RoleDescription
     ,ROLES.RoleGUID
     ,MemberROLE.MembershipID
     ,MemberROLE.RoleID AS MbrRoleID
     ,MemberSHIP.UserID AS MemberShipUserID
     ,CAST (MemberSHIP.ValidTo AS DATETIME) AS MemberShipValidTo
     ,USERSET.HFitUserMpiNumber
     ,USERSET.UserNickName
     ,CAST (USERSET.UserDateOfBirth AS DATETIME) AS UserDateOfBirth
     ,USERSET.UserGender
     ,PPT.PPTID
     ,PPT.FirstName
     ,PPT.LastName
     ,PPT.City
     ,PPT.State
     ,PPT.PostalCode
     ,PPT.UserID AS PPTUserID
     ,GRPMBR.ContactGroupMemberContactGroupID
     ,GRPMBR.ContactGroupMemberRelatedID
     ,GRPMBR.ContactGroupMemberType
     ,GRP.ContactGroupName
     ,GRP.ContactGroupDisplayName
     ,PPT.ClientCode
     ,ACCT.AccountName
     ,ACCT.AccountID
     ,ACCT.AccountCD
     ,ACCT.SiteID
     ,SITE.SiteGUID
     ,SITE.SiteName
     ,SITE.SiteDisplayName
     ,EHIST.GroupName AS EligibilityGroupName
     ,CAST (EHIST.StartedDate AS DATETIME) AS EligibilityStartDate
     ,CAST (EHIST.EndedDate AS DATETIME) AS EligibilityEndDate
     ,CASE
      WHEN
       ROLES.CT_RoleID = 1
          THEN 1
      WHEN
       ROLES.CT_RoleDescription = 1
          THEN 2
      WHEN
       ROLES.CT_RoleGUID = 1
          THEN 3
      WHEN
       MemberROLE.CT_MembershipID = 1
          THEN 4
      WHEN
       MemberROLE.CT_RoleID = 1
          THEN 5
      WHEN
       MemberSHIP.CT_UserID = 1
          THEN 6
      WHEN
       MemberSHIP.CT_ValidTo = 1
          THEN 7
      WHEN
       USERSET.CT_HFitUserMpiNumber = 1
          THEN 8
      WHEN
       USERSET.CT_UserNickName = 1
          THEN 9
      WHEN
       USERSET.CT_UserDateOfBirth = 1
          THEN 10
      WHEN
       USERSET.CT_UserGender = 1
          THEN 11
      WHEN PPT.CT_PPTID = 1
          THEN 12
      WHEN PPT.CT_PPTID = 1
          THEN 13
      WHEN
       PPT.CT_FirstName = 1
          THEN 14
      WHEN
       PPT.CT_LastName = 1
          THEN 15
      WHEN PPT.CT_City = 1
          THEN 16
      WHEN PPT.CT_State = 1
          THEN 17
      WHEN
       PPT.CT_PostalCode = 1
          THEN 18
      WHEN
       PPT.CT_UserID = 1
          THEN 19
      WHEN
       ACCT.CT_AccountName = 1
          THEN 20
      WHEN
       ACCT.CT_AccountID = 1
          THEN 21
      WHEN
       ACCT.CT_AccountCD = 1
          THEN 22
      WHEN
       ACCT.CT_SiteID = 1
          THEN 23
      WHEN
       SITE.CT_SiteGUID = 1
          THEN 24
      WHEN
       SITE.CT_SiteName = 1
          THEN 25
      WHEN
       SITE.CT_SiteDisplayName = 1
          THEN 26
      WHEN
       EHIST.CT_GroupName = 1
          THEN 27
      WHEN
       EHIST.CT_StartedDate = 1
          THEN 28
      WHEN
       EHIST.CT_EndedDate = 1
          THEN 29
      ELSE 0
      END AS RowDataChanged
     ,ROLES.LastModifiedDate AS ROLES_LastModifiedDate
     ,MemberROLE.LastModifiedDate AS MemberROLE_LastModifiedDate
     ,PPT.LastModifiedDate AS PPT_LastModifiedDate
     ,USERSET.LastModifiedDate AS USERSET_LastModifiedDate
     ,GRPMBR.LastModifiedDate AS GRPMBR_LastModifiedDate
     ,GRP.LastModifiedDate AS GRP_LastModifiedDate
     ,GroupMBR.LastModifiedDate AS GroupMBR_LastModifiedDate
     ,SITE.LastModifiedDate AS SITE_LastModifiedDate
     ,EHIST.LastModifiedDate AS EHIST_LastModifiedDate
FROM
     BASE_CMS_Role AS ROLES
          JOIN BASE_cms_MembershipRole AS MemberROLE
          ON
       ROLES.RoleID = MemberROLE.RoleID AND
       ROLES.DBNAME = MemberROLE.DBNAME
          JOIN BASE_cms_MembershipUser AS MemberSHIP
          ON
       MemberROLE.MembershipID = MemberSHIP.MembershipID AND
       MemberROLE.DBNAME = MemberSHIP.DBNAME
          JOIN BASE_HFit_PPTEligibility AS PPT
          ON
       PPT.UserID = MemberSHIP.UserID AND
       PPT.DBNAME = MemberSHIP.DBNAME
          JOIN BASE_CMS_USERSettings AS USERSET
          ON
       USERSET.UserSettingsUserID = PPT.UserID AND
       USERSET.DBNAME = PPT.DBNAME
          JOIN BASE_OM_ContactGroupMember AS GRPMBR
          ON
       GRPMBR.ContactGroupMemberRelatedID = USERSET.HFitPrimaryContactID AND
       GRPMBR.DBNAME = USERSET.DBNAME
          JOIN BASE_OM_ContactGroup AS GRP
          ON
       GRP.ContactGroupID = GRPMBR.ContactGroupMemberContactGroupID AND
       GRP.DBNAME = GRPMBR.DBNAME
          JOIN BASE_HFit_ContactGroupMembership AS GroupMBR
          ON
       GroupMBR.cmsMembershipID = MemberSHIP.MembershipID AND
       GroupMBR.DBNAME = MemberSHIP.DBNAME
          JOIN BASE_HFit_Account AS ACCT
          ON
       ROLES.SiteID = ACCT.SiteID AND
       ROLES.DBNAME = ACCT.DBNAME
          JOIN BASE_CMS_Site AS SITE
          ON
       SITE.SiteID = ACCT.SiteID AND
       SITE.DBNAME = ACCT.DBNAME
          LEFT OUTER JOIN BASE_EDW_GroupMemberHistory AS EHIST
          ON
       EHIST.UserMpiNumber = USERSET.HFitUserMpiNumber
	  and EHIST.DBNAME = USERSET.DBNAME;

GO


