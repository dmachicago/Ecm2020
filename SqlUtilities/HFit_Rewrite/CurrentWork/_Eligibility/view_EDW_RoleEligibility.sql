
--select top 100 * from EDW_RoleMemberHistory
--select top 100 * from view_EDW_RoleEligibility
--select * from information_schema.columns where column_name = 'userguid'
GO
PRINT 'Creating VIEW view_EDW_RoleEligibility';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_EDW_RoleEligibility') 
    BEGIN
        DROP VIEW
             view_EDW_RoleEligibility;
    END;
GO
CREATE VIEW view_EDW_RoleEligibility
AS SELECT DISTINCT
   --CHANGE HISTORY:
   -- 05.14.2015 - (WDM) ROLEHISTORY.RowNbr per Shankar
   -- 05.15.2015 - (WDM) John and I set RoleStart and Stopdate to reflect the eligibility dates.
          ROLEHISTORY.UserID
 , [USER].UserGUID
 , ROLEHISTORY.RoleID
 , ROLEHISTORY.RoleGUID
 , ROLEHISTORY.RoleName
 , CAST (ROLEHISTORY.ValidTo AS datetime) AS ValidTo
 , ROLEHISTORY.HFitUserMPINumber
 , ROLEHISTORY.AccountCD
 , ROLEHISTORY.AccountID
 , ROLEHISTORY.SiteGUID
 , CAST (RoleStartDate AS datetime) AS EligibilityStartDate
 , CAST (RoleEndDate AS datetime) AS EligibilityEndDate
 , CAST (LastModifiedDate AS datetime) AS LastModifiedDate
 , CASE
       WHEN ROLEHISTORY.RoleEndDate IS NULL
           THEN 'I'
       ELSE 'U'
   END AS ChangeType
   --, ROLEHISTORY.RowNbr	  --Removed 05.14.2015 per Shankar
          FROM
              dbo.EDW_RoleMemberHistory AS ROLEHISTORY
                  JOIN CMS_USER AS [USER]
                      ON ROLEHISTORY.UserID = [USER].UserID;
GO
PRINT 'CREATED VIEW view_EDW_RoleEligibility';
GO
