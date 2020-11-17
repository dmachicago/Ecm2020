
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ClientCompany')
BEGIN
	drop view view_EDW_ClientCompany ;
END

GO

CREATE VIEW [dbo].[view_EDW_ClientCompany]

AS 
--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--		There is an issue with HFit_Company. There are no insert/update tracking dates.
--***********************************************************************************************
SELECT
    hfa.AccountID
   ,HFA.AccountCD
   ,HFA.AccountName
   ,HFA.ItemGUID AccountGUID
   ,CS.SiteID
   ,CS.SiteGUID
   ,CS.SiteLastModified
   ,HFC.CompanyID
   ,HFC.ParentID
   ,HFC.CompanyName
   ,HFC.CompanyShortName
   ,HFC.CompanyStartDate
   ,HFC.CompanyEndDate
   ,HFC.CompanyStatus
   ,CASE WHEN CAST(hfa.ItemCreatedWhen AS DATE) = CAST(HFA.ItemModifiedWhen AS DATE) THEN 'I' ELSE 'U' END AS ChangeType
   ,HFA.ItemCreatedWhen AccountCreated
   ,HFA.ItemModifiedWhen AccountModified
   ,NULL AS CompanyCreated
   ,NULL AS CompanyModified
FROM
    dbo.HFit_Account AS HFA
INNER JOIN dbo.CMS_Site AS CS ON HFA.SiteID = cs.SiteID
LEFT OUTER JOIN dbo.HFit_Company AS HFC ON HFA.AccountID = hfc.AccountID





GO


