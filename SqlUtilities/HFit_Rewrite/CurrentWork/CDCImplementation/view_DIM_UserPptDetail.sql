
GO
-- use KenticoCMS_DataMart
PRINT 'Executing view_DIM_UserPPTDetail.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_DIM_UserPPTDetail') 
    BEGIN
        DROP VIEW
             dbo.view_DIM_UserPPTDetail;
    END;
GO
-- select top 100 * from view_DIM_UserPPTDetail
CREATE VIEW view_DIM_UserPPTDetail
AS SELECT
          BASE_cms_user.SVR
        , BASE_cms_user.UserName
        , BASE_cms_user.FirstName
        , BASE_cms_user.MiddleName
        , BASE_cms_user.LastName
        , BASE_cms_user.FullName
        , BASE_cms_user.Email
        , BASE_cms_user.PreferredCultureCode
        , BASE_cms_user.PreferredUICultureCode
        , BASE_cms_user.UserEnabled
        , BASE_cms_user.UserID
        , BASE_cms_user.SurrogateKey_cms_user
        , BASE_cms_user.LASTMODIFIEDDATE
        , BASE_hfit_PPTEligibility.LASTMODIFIEDDATE AS BASE_hfit_PPTEligibility_LASTMODIFIEDDATE
        , BASE_hfit_PPTEligibility.SurrogateKey_hfit_PPTEligibility
        , BASE_hfit_PPTEligibility.BirthDate
        , BASE_hfit_PPTEligibility.Gender
        , BASE_hfit_PPTEligibility.City
        , BASE_hfit_PPTEligibility.State
        , BASE_hfit_PPTEligibility.PostalCode
        , BASE_hfit_PPTEligibility.HireDate
        , BASE_hfit_PPTEligibility.TermDate
        , BASE_hfit_PPTEligibility.RetireeDate
        , BASE_hfit_PPTEligibility.PlanName
        , BASE_hfit_PPTEligibility.PlanDescription
        , BASE_hfit_PPTEligibility.PlanID
        , BASE_hfit_PPTEligibility.PlanStartDate
        , BASE_hfit_PPTEligibility.PlanEndDate
        , BASE_hfit_PPTEligibility.Company
        , BASE_hfit_PPTEligibility.CompanyCd
        , BASE_hfit_PPTEligibility.LocationName
        , BASE_hfit_PPTEligibility.DepartmentName
        , BASE_hfit_PPTEligibility.DepartmentCd
        , BASE_hfit_PPTEligibility.UnionCd
        , BASE_hfit_PPTEligibility.BenefitGrp
        , BASE_hfit_PPTEligibility.PayGrp
        , BASE_hfit_PPTEligibility.Division
        , BASE_hfit_PPTEligibility.JobTitle
        , BASE_hfit_PPTEligibility.JobCd
        , BASE_hfit_PPTEligibility.TeamName
        , BASE_hfit_PPTEligibility.MaritalStatus
        , BASE_hfit_PPTEligibility.PersonType
        , BASE_hfit_PPTEligibility.PersonStatus
        , BASE_hfit_PPTEligibility.EmployeeType
        , BASE_hfit_PPTEligibility.EmployeeStatus
        , BASE_hfit_PPTEligibility.CoverageType
        , BASE_hfit_PPTEligibility.PayCd
        , BASE_hfit_PPTEligibility.BenefitStatus
        , BASE_hfit_PPTEligibility.PlanType
        , BASE_hfit_PPTEligibility.ClientPlatformElig
        , BASE_hfit_PPTEligibility.ClientHRAElig
        , BASE_hfit_PPTEligibility.ClientLMElig
        , BASE_hfit_PPTEligibility.PPTID
        , BASE_cms_user.DBNAME
   FROM
        dbo.BASE_cms_user
        INNER JOIN dbo.BASE_hfit_PPTEligibility
        ON
          BASE_cms_user.UserID = BASE_hfit_PPTEligibility.UserID AND
          BASE_cms_user.SVR = BASE_hfit_PPTEligibility.SVR AND
          BASE_cms_user.DBNAME = BASE_hfit_PPTEligibility.DBNAME;
GO
PRINT 'Executed view_DIM_UserPPTDetail.sql';
GO
