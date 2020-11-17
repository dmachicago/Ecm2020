
GO
--01364405
PRINT 'Creating proc_EDW_RoleEligibilityStarted';
PRINT 'FROM proc_EDW_RoleEligibilityStarted.sql';
GO
--select count(*) from EDW_RoleMemberHistory	   --1364401
--exec proc_EDW_RoleEligibilityStarted;
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
             WHERE name = 'proc_EDW_RoleEligibilityStarted') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_RoleEligibilityStarted;
    END;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE PROCEDURE dbo.proc_EDW_RoleEligibilityStarted
AS
BEGIN
    SET NOCOUNT ON;

    --**********************************************************************************************************
    --*******************************************************************************************************
    --    This procedure, proc_EDW_RoleEligibilityStarted, is a starting point point for new PPTs that are eligibile
    --    to participate. In order to capture those PPTs that may have closed and eligibility, lost it, or had it
    --    expire, an END DATE is also tracked. This is done through the table, EDW_RoleMemberHistory.
    --    Step 1 - Call procedure proc_EDW_RoleEligibilityDaily
    --    Step 2 - Call procedure proc_EDW_RoleEligibilityStarted
    --    Step 3 - Call procedure proc_EDW_RoleEligibilityExpired
    --    Step 4 - Retrieve the PPT ROLE membership history using the view view_EDW_RoleEligibilityHistory
    --    *******************************************************************************************************
    --**********************************************************************************************************
    --update EDW_RoleMemberHistory set RoleEndDate = getdate()-1 where RowNbr in (select top 1000 RowNbr from EDW_RoleMemberHistory where RowNbr between 5000 and 10000)
    PRINT 'Starting proc_EDW_RoleEligibilityStarted: ' + CAST (GETDATE () AS nvarchar (50)) ;
    WITH NewRoleMembers (
         RoleName
       , UserID) 
        AS (SELECT RoleName, UserID
               FROM EDW_RoleMemberToday
        EXCEPT
        SELECT RoleName, UserID
		  FROM EDW_RoleMemberHistory
			 WHERE RoleEndDate IS NULL) 
        INSERT INTO EDW_RoleMemberHistory (
               UserID
             , RoleID
             , RoleGUID
             , RoleName
             , ValidTo
             , HFitUserMPINumber
             , AccountCD
             , AccountID
             , SiteGUID
             , RoleStartDate
             , RoleEndDate
        ) 
        SELECT
               TDAY.UserID
             , TDAY.RoleID
             , TDAY.RoleGUID
             , TDAY.RoleName
             , TDAY.ValidTo
             , TDAY.HFitUserMPINumber
             , TDAY.AccountCD
             , TDAY.AccountID
             , TDAY.SiteGUID
             , TDAY.RoleStartDate
             , TDAY.RoleEndDate
               FROM
                    EDW_RoleMemberToday AS TDAY
                        INNER JOIN NewRoleMembers AS CTE
                            ON CTE.RoleName = TDAY.RoleName
                           AND CTE.UserID = TDAY.UserID;
    DECLARE
       @iAdded AS int = @@ROWCOUNT;
    --SET @iAdded = (SELECT
    --                      COUNT (*) 
    --                      FROM EDW_RoleMemberHistory
    --                 WHERE CAST (RoleStartDate AS date) = CAST (GETDATE () AS date)) ;
    SET NOCOUNT OFF;
    PRINT CAST (@iAdded AS nvarchar (50)) + ' NEW Eligibility Records Processed on: ' + CAST (GETDATE () AS nvarchar (50)) ;
    PRINT 'Ending [proc_EDW_RoleEligibilityStarted]: ' + CAST (GETDATE () AS nvarchar (50)) ;

END;
GO
PRINT 'Created proc_EDW_RoleEligibilityStarted';
GO 

