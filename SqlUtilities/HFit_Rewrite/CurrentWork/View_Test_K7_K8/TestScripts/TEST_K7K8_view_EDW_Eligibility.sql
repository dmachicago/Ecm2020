use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Eligibility' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Eligibility
END
GO

--select count(*) from KenticoCMS_PRD_prod3K7.dbo.view_EDW_Eligibility; --429344600
--select count(*) from KenticoCMS_PRD_prod3K8.dbo.view_EDW_Eligibility;

--****************************************************
Select DISTINCT top 150 
     RoleID
    ,RoleName
    ,RoleDescription
    ,RoleGUID
    ,MembershipID
    ,MbrRoleID
    ,MemberShipUserID
    ,MemberShipValidTo
    ,HFitUserMpiNumber
    ,UserNickName
    ,UserDateOfBirth
    ,UserGender
    ,PPTID
    ,FirstName
    ,LastName
    ,City
    ,State
    ,PostalCode
    ,PPTUserID
    ,ContactGroupMemberContactGroupID
    ,ContactGroupMemberRelatedID
    ,ContactGroupMemberType
    ,ContactGroupName
    ,ContactGroupDisplayName
    ,ClientCode
    ,AccountName
    ,AccountID
    ,AccountCD
    ,SiteID
    ,SiteGUID
    ,SiteName
    ,SiteDisplayName
    ,EligibilityGroupName
    ,EligibilityStartDate
    ,EligibilityEndDate
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Eligibility
FROM
KenticoCMS_PRD_prod3K7.dbo.view_EDW_Eligibility;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_Eligibility' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_Eligibility
END
GO


--****************************************************
Select DISTINCT top 150 
     RoleID
    ,RoleName
    ,RoleDescription
    ,RoleGUID
    ,MembershipID
    ,MbrRoleID
    ,MemberShipUserID
    ,MemberShipValidTo
    ,HFitUserMpiNumber
    ,UserNickName
    ,UserDateOfBirth
    ,UserGender
    ,PPTID
    ,FirstName
    ,LastName
    ,City
    ,State
    ,PostalCode
    ,PPTUserID
    ,ContactGroupMemberContactGroupID
    ,ContactGroupMemberRelatedID
    ,ContactGroupMemberType
    ,ContactGroupName
    ,ContactGroupDisplayName
    ,ClientCode
    ,AccountName
    ,AccountID
    ,AccountCD
    ,SiteID
    ,SiteGUID
    ,SiteName
    ,SiteDisplayName
    ,EligibilityGroupName
    ,EligibilityStartDate
    ,EligibilityEndDate
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Eligibility
FROM
KenticoCMS_PRD_prod3K8.dbo.view_EDW_Eligibility;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_Eligibility;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_Eligibility;

--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = 'view_EDW_Eligibility'; 