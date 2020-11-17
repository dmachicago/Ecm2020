

GO
PRINT 'Creating procedure proc_EDW_RoleEligibilityDaily';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
             WHERE name = 'proc_EDW_RoleEligibilityDaily') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_RoleEligibilityDaily;
    END;
GO
--exec proc_EDW_RoleEligibilityDaily
--select top 100 * from EDW_RoleMemberToday
CREATE PROCEDURE dbo.proc_EDW_RoleEligibilityDaily
AS
BEGIN

    --************************************************************************************************************************************************
    --In our initial talks, the statement was made that a PPT eligibility was not known as in a start and end date, only that they are “eligible”.
    --In order to overcome this, the routine initializes the daily table (A new EDW table) with everyone that is “eligible” and assigns the date 
    --  that the eligibility was determined to be in place as “today’s date’.
    --
    --Each row in the daily table is then compared to the eligibility historical table  (A new EDW table). If it exists in the table already, it 
    --  is skipped. If it does not exist, then it is inserted as an entry showing that PPT became eligible today.
    --
    --The next step goes though the existing historical PPTs that have eligibility and checks to see if they exist in the daily table. If not, 
    --  they are then marked as “ineligible” based on today's date.
    --
    --  Find all members and their respective groups that exist at this point in time.
    --    This is a snapshot of PPTs, Groups, and Memberships as it appears in the moment.
    --    This will allow us to track members when they go into or leave a group, daily.
    --    Get all records of PPTs within groups and save them as the daily starting point
    --    for tracking PPT group membership. To ensure the data is fresh, drop the
    --    EDW_RoleMemberToday table and fill it with current PPTs.
    --    Step 1 - Call procedure proc_EDW_RoleEligibilityDaily
    --    Step 2 - Call procedure proc_EDW_RoleEligibilityStarted
    --    Step 3 - Call procedure proc_EDW_RoleEligibilityExpired
    --    Step 4 - Retrieve the PPT ROLE membership history using the view view_EDW_EligibilityHistory
    --************************************************************************************************************************************************

    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                 WHERE name = 'EDW_RoleMemberToday') 
        BEGIN
            truncate TABLE EDW_RoleMemberToday;
        END;
    INSERT INTO dbo.EDW_RoleMemberToday (
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
    --ALL Of the currently existing ROLE records for MemberShip User
    --This is the daily starting point
    SELECT
           MU.UserID
         , R.RoleID
         , R.RoleGUID
         , R.RoleName
         , MU.ValidTo
         , US.HFitUserMPINumber
         , ACCT.AccountCD
         , ACCT.AccountID
         , ACCT.ItemGUID AS SiteGUID
         , GETDATE () AS RoleStartDate
         , NULL AS RoleEndDate
           FROM
                CMS_Role AS R
                    JOIN CMS_MembershipRole AS MR
                        ON R.RoleID = MR.RoleID
                    JOIN CMS_MembershipUser AS MU
                        ON MR.MembershipID = MU.MembershipID
                    JOIN CMS_UserSettings AS US
                        ON MU.UserID = US.UserSettingsUserID
                    JOIN HFit_Account AS ACCT
                        ON R.SiteID = ACCT.SiteID
      WHERE US.HFitUserMPINumber > 0
        AND RoleName IN ( 
            SELECT
                   RoleName
                   FROM LKP_EDW_CMSRole) ;

    DECLARE
       @iCnt AS integer = 0;
    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM EDW_RoleMemberToday) ;
    PRINT 'Loaded: ' + CAST (@iCnt AS nvarchar (50)) + ' eligibility records on ' + CAST (GETDATE () AS nvarchar (50)) ;
END;
GO
PRINT 'Created procedure proc_EDW_RoleEligibilityDaily';
GO

