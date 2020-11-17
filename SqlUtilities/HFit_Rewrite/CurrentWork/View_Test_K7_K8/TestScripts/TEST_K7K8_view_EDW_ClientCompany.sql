use KenticoCMS_PRD_prod3K7
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_ClientCompany' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_ClientCompany
END
GO


--****************************************************
Select distinct top 1000 
     AccountID
    ,AccountCD
    ,AccountName
    ,AccountCreated
    ,AccountModified
    ,AccountGUID
    ,SiteID
    ,SiteGUID
    ,SiteLastModified
    ,CompanyID
    ,ParentID
    ,CompanyName
    ,CompanyShortName
    ,CompanyStartDate
    ,CompanyEndDate
    ,CompanyStatus
    ,ChangeType
    ,CompanyCreated
    ,CompanyModified
INTO KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_ClientCompany
FROM
view_EDW_ClientCompany;
--****************************************************
use KenticoCMS_PRD_prod3K8
GO 
if exists (select name from sys.tables where name = 'TEST_K7K8_view_EDW_ClientCompany' )
BEGIN
    DROP Table TEST_K7K8_view_EDW_ClientCompany
END
GO


--****************************************************
Select distinct top 1000 
     AccountID
    ,AccountCD
    ,AccountName
    ,AccountCreated
    ,AccountModified
    ,AccountGUID
    ,SiteID
    ,SiteGUID
    ,SiteLastModified
    ,CompanyID
    ,ParentID
    ,CompanyName
    ,CompanyShortName
    ,CompanyStartDate
    ,CompanyEndDate
    ,CompanyStatus
    ,ChangeType
    ,CompanyCreated
    ,CompanyModified
INTO KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_ClientCompany
FROM
view_EDW_ClientCompany;
--****************************************************
GO

select top 100 * from KenticoCMS_PRD_prod3K7.dbo.TEST_K7K8_view_EDW_ClientCompany order by AccountID;

select top 100 * from KenticoCMS_PRD_prod3K8.dbo.TEST_K7K8_view_EDW_ClientCompany order by AccountID;
