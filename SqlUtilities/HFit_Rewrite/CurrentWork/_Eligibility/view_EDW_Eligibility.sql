
GO
PRINT 'CREATING view view_EDW_Eligibility';
GO
IF EXISTS ( SELECT
                   name
                   FROM sys.views
                   WHERE name = 'view_EDW_Eligibility') 
    BEGIN
        PRINT 'Replacing view view_EDW_Eligibility';
        DROP VIEW
             view_EDW_Eligibility;
    END;
GO

--select top 1000 * from view_EDW_Eligibility where EligibilityStartDate > getdate() -1 

CREATE VIEW view_EDW_Eligibility
AS

--*************************************************************************************************************************
--Total returned 2473454
--select count(*)  from CMS_Role --305
--select count(*) from cms_MembershipRole --256
--select count(*) from cms_MembershipUser --37215
--select count(*) from CMS_Role --305
--select count(*) from view_EDW_EligibilityHistory	--58540
--select count(*) from EDW_GroupMemberHistory			--58540
--view_EDW_Eligibility is the starting point for the EDW to pull data. As of 11.11.2014, all columns
--within the view are just a starting point. We will work with the EDW team to define and pull all the data
--they are needing.
--A PPT becomes eligible to participate through the Rules
--Rules of Engagement:
--00: ROLES are tied to a feature ; if the ROLE is not on a Kentico page - you don't see it.
--01: When the Kentico group rebuild executes, all is lost. There is no retained MEMBER/User history.
--02: The group does not track when a member enters or leaves a group, simply that they exist in that group.
--NOTE: Any data deemed necessary can be added to this view for the EDW
--01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
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
     ,CAST ( MemberSHIP.ValidTo AS datetime) AS MemberShipValidTo
     ,USERSET.HFitUserMpiNumber
     ,USERSET.UserNickName
     ,CAST ( USERSET.UserDateOfBirth AS datetime) AS UserDateOfBirth
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
     ,CAST ( EHIST.StartedDate AS datetime) AS EligibilityStartDate
     ,CAST ( EHIST.EndedDate AS datetime) AS EligibilityEndDate
       FROM
           CMS_Role AS ROLES
               JOIN cms_MembershipRole AS MemberROLE
                   ON ROLES.RoleID = MemberROLE.RoleID
               JOIN cms_MembershipUser AS MemberSHIP
                   ON MemberROLE.MembershipID = MemberSHIP.MembershipID
               JOIN HFit_PPTEligibility AS PPT
                   ON PPT.UserID = MemberSHIP.UserID
               JOIN CMS_USERSettings AS USERSET
                   ON USERSET.UserSettingsUserID = PPT.UserID
               JOIN OM_ContactGroupMember AS GRPMBR
                   ON GRPMBR.ContactGroupMemberRelatedID = USERSET.HFitPrimaryContactID
               JOIN OM_ContactGroup AS GRP
                   ON GRP.ContactGroupID = GRPMBR.ContactGroupMemberContactGroupID
               JOIN HFit_ContactGroupMembership AS GroupMBR
                   ON GroupMBR.cmsMembershipID = MemberSHIP.MembershipID
               JOIN HFit_Account AS ACCT
                   ON ROLES.SiteID = ACCT.SiteID
               JOIN CMS_Site AS SITE
                   ON SITE.SiteID = ACCT.SiteID
               LEFT OUTER JOIN view_EDW_EligibilityHistory AS EHIST
                   ON EHIST.UserMpiNumber = USERSET.HFitUserMpiNumber;

--LEFT JOIN EDW_GroupMemberHistory AS GHIST
--	ON GHIST.UserMpiNumber = USERSET.HFitUserMpiNumber

GO
PRINT 'created view_EDW_Eligibility: ' + CAST ( GETDATE () AS nvarchar (50)) ;
GO
