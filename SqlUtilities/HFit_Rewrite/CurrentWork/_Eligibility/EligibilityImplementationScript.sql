
PRINT 'Processing eligibility: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO

/*-----------------------------------------------------------------------------
*****************************************************************************
***************************************************************************
DBCC FREEPROCCACHE
EXEC proc_EDW_EligibilityDaily
EXEC proc_EDW_EligibilityStarted
EXEC proc_EDW_EligibilityExpired

exec proc_build_EDW_Eligibility

WITH CTE AS
(
SELECT TOP 20 *
FROM [EDW_GroupMemberToday]
--ORDER BY HFitUserMpiNumber
)
select* from CTE


WITH CTE AS
(
SELECT TOP 10 *
FROM [EDW_GroupMemberToday]
--ORDER BY HFitUserMpiNumber
)
DELETE FROM CTE

--delete from [EDW_GroupMemberToday] where ContactGroupMemberRelatedID = 21805 
--and HFitUserMpiNumber = 8705496
--and GroupName = 'KraigTesting'

--Select * from EDW_GroupMemberHistory where EndedDate is not null
--Select * from view_EDW_Eligibility where GroupEndDate  is not null

***************************************************************************
*****************************************************************************
*/
--  select * from EDW_GroupMemberHistory
--IF EXISTS (SELECT
--				  name
--			 FROM sys.tables
--			 WHERE name = 'EDW_GroupMemberHistory') 
--	BEGIN
--		DROP TABLE
--			 dbo.EDW_GroupMemberHistory;
--	END;
--GO
--*********************************************************************************************************************
--EDW_GroupMemberHistory is used to track starting and ending dates of a PPT’s participation and enrollment into a group.
-- select top 100 * from EDW_GroupMemberHistory
--*********************************************************************************************************************

IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'EDW_GroupMemberHistory') 
    BEGIN
        CREATE TABLE dbo.EDW_GroupMemberHistory (
                     GroupName nvarchar (200) NOT NULL
                   , UserMpiNumber bigint NOT NULL
                   , StartedDate [date] NULL
                   , EndedDate [date] NULL
                   , RowNbr int IDENTITY (1, 1) 
                                NOT NULL) ;
        CREATE UNIQUE CLUSTERED INDEX PKI_EDW_GroupMemberHistory ON dbo.EDW_GroupMemberHistory (GroupName ASC, UserMpiNumber ASC, StartedDate ASC, EndedDate ASC) ;
        CREATE INDEX PI_EDW_GroupMemberHistory_MPI ON dbo.EDW_GroupMemberHistory (UserMpiNumber ASC) ;
        CREATE NONCLUSTERED INDEX PI_EDW_GroupMemberHistory_RowNbr ON dbo.EDW_GroupMemberHistory (RowNbr ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;
    END;
ELSE
    BEGIN
        PRINT 'EDW_GroupMemberHistory: ALREADY EXISTS - Do not have to create again' + CAST (GETDATE () AS nvarchar (50)) ;
    END;
GO
PRINT 'creating EDW_GroupMemberHistory: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO

-- select * from EDW_GroupMemberToday
--IF EXISTS (SELECT
--				  name
--			 FROM sys.tables
--			 WHERE name = 'EDW_GroupMemberToday') 
--	BEGIN
--		DROP TABLE
--			 dbo.EDW_GroupMemberToday;
--	END;
--GO
--*****************************************************************************
--EDW_GroupMemberToday is used to store the PPT group members for "today". It is
--then used to compare new to no longer existing.
--  Select top 1000 * from EDW_GroupMemberToday
--*****************************************************************************

IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'EDW_GroupMemberToday') 
    BEGIN
        CREATE TABLE dbo.EDW_GroupMemberToday (
                     ContactGroupMemberRelatedID int NOT NULL
                   , GroupName nvarchar (200) NOT NULL
                   , HFitUserMpiNumber bigint NULL
                   , Today [date] NOT NULL) ;
        CREATE CLUSTERED INDEX PKI_EDW_GroupMemberToday ON dbo.EDW_GroupMemberToday (ContactGroupMemberRelatedID ASC, GroupName ASC, HFitUserMpiNumber ASC, Today ASC) ;
    END;
ELSE
    BEGIN
        PRINT 'EDW_GroupMemberHistory: ALREADY EXISTS - Do not have to create again' + CAST (GETDATE () AS nvarchar (50)) ;
    END;
GO
PRINT 'created EDW_GroupMemberHistory: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_EDW_EligibilityHistory') 
    BEGIN
        DROP VIEW
             view_EDW_EligibilityHistory;
    END;
GO

--************************************************************************************
--view_EDW_EligibilityHistory provides users access to the EDW_GroupMemberHistory table.
-- select top 100 * from view_EDW_EligibilityHistory
--************************************************************************************

CREATE VIEW view_EDW_EligibilityHistory
AS SELECT
          GroupName
        , UserMpiNumber
        , StartedDate
        , EndedDate
        , RowNbr
          FROM dbo.EDW_GroupMemberHistory;
GO
IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'PI_EDW_EligibilityHistory_MPI') 
    BEGIN
        CREATE INDEX PI_EDW_EligibilityHistory_MPI ON dbo.EDW_GroupMemberHistory (UserMpiNumber ASC) ;
    END;
PRINT 'created view_EDW_EligibilityHistory: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_EDW_Eligibility') 
    BEGIN
        DROP VIEW
             view_EDW_Eligibility;
    END;
GO
PRINT 'Creating view_EDW_Eligibility: ' + CAST (GETDATE () AS nvarchar (50)) ;
PRINT 'Now covering Task #48941 as well. ';
GO

--select top 1000 * from view_EDW_Eligibility where EligibilityStartDate > getdate() -1 

CREATE VIEW view_EDW_Eligibility
AS

--*************************************************************************************************************************
--Total returned 2473454
--Select count(*) from view_EDW_Eligibility (82201407) (10823368)
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
--				Found that the table EDW_GroupMemberHistory was referenced twice, once as a base table abd once as a view.
--				Removed one of the joins and the number of returned rows fell drastically - from 800M to 50M - 100M.	 
--03.02.2015 (WDM) John C. provided the list of Rolenames and they are applied to the VIEW DDL - Hardcoded in the view.
--*************************************************************************************************************************

SELECT
       ROLES.RoleID
     , ROLES.RoleName
     , ROLES.RoleDescription
     , ROLES.RoleGUID
     , MemberROLE.MembershipID
     , MemberROLE.RoleID AS MbrRoleID
     , MemberSHIP.UserID AS MemberShipUserID
     , MemberSHIP.ValidTo AS MemberShipValidTo
     , USERSET.HFitUserMpiNumber
     , USERSET.UserNickName
     , USERSET.UserDateOfBirth
     , USERSET.UserGender
     , PPT.PPTID
     , PPT.FirstName
     , PPT.LastName
     , PPT.City
     , PPT.State
     , PPT.PostalCode
     , PPT.UserID AS PPTUserID
     , PPT.PlanStartDate
     , PPT.PlanEndDate
     , PPT.Last_Update_Dt
     , GRPMBR.ContactGroupMemberContactGroupID
     , GRPMBR.ContactGroupMemberRelatedID
     , GRPMBR.ContactGroupMemberType
     , GRP.ContactGroupName
     , GRP.ContactGroupDisplayName
     , PPT.ClientCode
     , ACCT.AccountName
     , ACCT.AccountID
     , ACCT.AccountCD
     , ACCT.SiteID
     , SITE.SiteGUID
     , SITE.SiteName
     , SITE.SiteDisplayName

       --, EHIST.GroupName AS EligibilityGroupName

     , EHIST.StartedDate AS EligibilityStartDate
     , EHIST.EndedDate AS EligibilityEndDate

--, GHIST.GroupName AS GroupName
--, GHIST.StartedDate AS GroupStartDate
--, GHIST.EndedDate AS GroupEndDate
--select count(*) 

       FROM
           CMS_Role AS ROLES
               JOIN cms_MembershipRole AS MemberROLE
                   ON ROLES.RoleID = MemberROLE.RoleID
                  AND RoleName IN ('AccessTo_Coaching', 'AccessTo_Screenings', 'Challenges', 'Coaching', 'CoachingEligible', 'HealthAdvising', 'HealthAssessment', 'Rewards', 'Screeners', 'ScreeningScheduler') 
               JOIN cms_MembershipUser AS MemberSHIP
                   ON MemberROLE.MembershipID = MemberSHIP.MembershipID
               JOIN HFit_PPTEligibility AS PPT
                   ON PPT.UserID = MemberSHIP.UserID
               JOIN CMS_USERSettings AS USERSET
                   ON USERSET.UserSettingsUserID = PPT.UserID
                  AND HFitUserMpiNumber > 0
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
PRINT 'created view_EDW_Eligibility: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO

--select table_name from information_schema.columns where column_name = 'SiteID' and table_name in 
--('CMS_Role','cms_MembershipUser','HFit_PPTEligibility','CMS_USERSettings','OM_ContactGroupMember','OM_ContactGroup')
--**********************************
--exec proc_EDW_EligibilityDaily
--**********************************

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_EligibilityDaily') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_EligibilityDaily;
    END;
GO
PRINT 'created [proc_EDW_EligibilityDaily]: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO

--exec [proc_EDW_EligibilityDaily]

CREATE PROCEDURE proc_EDW_EligibilityDaily
AS
BEGIN

/*------------------------------------------------------------------------------------------
	In our initial talks, the statement was made that a PPT eligibility was not known 
	   as in a start and end date, only that they are “eligible”.

	In order to overcome this, the routine initializes the daily table (A new EDW table) 
	   with everyone that is “eligible” and assigns the date that the eligibility was 
	   determined to be in place as “today’s date’.

	Each row in the daily table is then compared to the eligibility historical table  
	   (A new EDW table). If it exists in the table already, it is skipped. If it does not 
	   exist, then it is inserted as an entry showing that PPT became eligible today.

	The next step goes though the existing historical PPTs that have eligibility and 
	   checks to see if they exist in the daily table. If not, they are then marked as 
	   “ineligible” based on today's date.

     Find all members and their respective groups that exist at this point in time.
	    This is a snapshot of PPTs, Groups, and Memberships as it appears in the moment.
	    This will allow us to track members when they go into or leave a group, daily.
	    Get all records of PPTs within groups and save them as the daily starting point
	    for tracking PPT group membership. To ensure the data is fresh, drop the
	    EDW_GroupMemberToday table and fill it with current PPTs.
	    Step 1 - Call procedure proc_EDW_EligibilityDaily
	    Step 2 - Call procedure proc_EDW_EligibilityStarted
	    Step 3 - Call procedure proc_EDW_EligibilityExpired
	    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
*/
    IF EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'EDW_GroupMemberToday') 
        BEGIN
            truncate TABLE EDW_GroupMemberToday;
        END;
    INSERT INTO dbo.EDW_GroupMemberToday (
           ContactGroupMemberRelatedID
         , GroupName
         , HFitUserMpiNumber
         , Today) 
    SELECT
           GRPMBR.ContactGroupMemberRelatedID
         , GRP.ContactGroupName AS GroupName
         , USERSET.HFitUserMpiNumber
         , (
           SELECT
                  CONVERT (date, GETDATE () , 110)) AS Today
           FROM
               OM_CONTACTGroupMember AS GRPMBR
                   JOIN CMS_USERSettings AS USERSET
                       ON USERSET.HFitPRimaryContactID = GRPMBR.ContactGroupMemberRelatedID
                   JOIN OM_ContactGroup AS GRP
                       ON GRP.ContactGroupID = GRPMBR.ContactGroupMemberContactGroupID
           WHERE HFitUserMpiNumber IS NOT NULL;
    DECLARE @iCnt AS integer = 0;
    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM EDW_GroupMemberToday);
    PRINT 'Beginning to process: ' + CAST (@iCnt AS nvarchar (50)) + ' eligibility records on ' + CAST (GETDATE () AS nvarchar (50)) ;
END;
GO
PRINT 'created proc_EDW_EligibilityDaily: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO

--************************************************************************************
--exec proc_EDW_EligibilityStarted
--************************************************************************************

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_EligibilityStarted') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_EligibilityStarted;
    END;
GO
PRINT 'created proc_EDW_EligibilityStarted: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
CREATE PROCEDURE proc_EDW_EligibilityStarted
AS
BEGIN
    SET NOCOUNT ON;

    --**********************************************************************************************************
    --    This procedure, proc_EDW_EligibilityStarted, is a starting point point for new PPTs that are eligibile
    --    to participate. In order to capture those PPTs that may have closed and eligibility, lost it, or had it
    --    expire, an END DATE is also tracked. This is done through the table, EDW_GroupMemberHistory.
    --    Step 1 - Call procedure proc_EDW_EligibilityDaily
    --    Step 2 - Call procedure proc_EDW_EligibilityStarted
    --    Step 3 - Call procedure proc_EDW_EligibilityExpired
    --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
    -- NOTES:
    --	  John and I discussed the PPT eligilibilty and he feels that PPT eligilbility will be replaced by 
    --	  group eligibility and the need for this set of routines is depricated. 
    --**********************************************************************************************************

    PRINT 'Starting proc_EDW_EligibilityStarted: ' + CAST (GETDATE () AS nvarchar (50)) ;
    WITH NewPPT (
         GroupName
       , MpiNumber) 
        AS (SELECT
                   GroupName
                 , HFitUserMpiNumber
                   FROM EDW_GroupMemberToday
            EXCEPT
            SELECT
                   GroupName
                 , UserMpiNumber
                   FROM EDW_GroupMemberHistory
                   WHERE EndedDate IS NULL) 
        INSERT INTO EDW_GroupMemberHistory (
               GroupName
             , UserMpiNumber
             , StartedDate) 
        SELECT
               GroupName
             , MpiNumber
             , (
               SELECT
                      CONVERT (date, GETDATE () , 110)) AS Today
               FROM NewPPT;
    DECLARE @iAdded AS int = 0;
    SET @iAdded = (SELECT
                          COUNT (*) 
                          FROM EDW_GroupMemberHistory
                          WHERE CAST (StartedDate AS date) = CAST (GETDATE () AS date));
    SET NOCOUNT OFF;
    PRINT CAST (@iAdded AS nvarchar (50)) + ' Eligibility Records Processed on: ' + CAST (GETDATE () AS nvarchar (50)) ;
    PRINT 'Ending [proc_EDW_EligibilityStarted]: ' + CAST (GETDATE () AS nvarchar (50)) ;
END;
GO

--************************************************************************************
--**************************************************************************************
--exec proc_EDW_EligibilityExpired
--************************************************************************************

PRINT 'created proc_EDW_EligibilityExpired: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_EligibilityExpired') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_EligibilityExpired;
    END;
GO

--exec proc_EDW_EligibilityExpired

CREATE PROCEDURE proc_EDW_EligibilityExpired
AS
BEGIN

    --******************************************************************************************
    --proc_EDW_EligibilityExpired looks for PPT group memebers that existed previously and
    --    does not currently exist in the daily pull. If one is found missing from the daily,
    --    that PPT is maked with an END DATE indicating the participation within that group
    --    for that PPT has ended. Every 1,000 records processed will generate a message and at
    --    the end, a total records closed count will be displayed.
    --    Step 1 - Call procedure proc_EDW_EligibilityDaily
    --    Step 2 - Call procedure proc_EDW_EligibilityStarted
    --    Step 3 - Call procedure proc_EDW_EligibilityExpired
    --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
    --	  select top 100 * from view_EDW_EligibilityHistory
    --******************************************************************************************

    SET NOCOUNT OFF;
    PRINT 'Starting [proc_EDW_EligibilityExpired] NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
    DECLARE @iCnt AS integer = 0;

    --SET @iCnt = (SELECT COUNT (*) 
    --			FROM EDW_GroupMemberHistory
    --			WHERE EndedDate IS NULL AND UserMpiNumber IS NOT NULL AND UserMpiNumber NOT IN (
    --																							SELECT HFitUserMpiNumber
    --																							  FROM EDW_GroupMemberToday)) ;

    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM
                            EDW_GroupMemberHistory AS HIST
                                LEFT JOIN EDW_GroupMemberToday AS TDAY
                                    ON HIST.UserMpiNumber = TDAY.HFitUserMpiNumber
                        WHERE HIST.EndedDate IS NULL
                          AND TDAY.HFitUserMpiNumber IS NULL);
    IF @iCnt > 0
        BEGIN
            PRINT CAST (@iCnt AS nvarchar (50)) + ' EligibilityExpired PPTs FOUND: ' + CAST (GETDATE () AS nvarchar (50)) ;
            UPDATE HIST
                   SET
                       EndedDate = GETDATE () 
                       FROM EDW_GroupMemberHistory HIST
                                LEFT JOIN EDW_GroupMemberToday TDAY
                                    ON HIST.UserMpiNumber = TDAY.HFitUserMpiNumber
                       WHERE
                             HIST.EndedDate IS NULL
                         AND TDAY.HFitUserMpiNumber IS NULL;
        END;
    ELSE
        BEGIN
            PRINT 'NO EligibilityExpired PPTs: ' + CAST (GETDATE () AS nvarchar (50)) ;
        END;
    PRINT 'Completed proc_EDW_EligibilityExpired: ' + CAST (GETDATE () AS nvarchar (50)) ;
    PRINT '*******************************************************';
    PRINT 'Ending NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
END;
GO

--*****************************
--exec proc_build_EDW_Eligibility
--*****************************

PRINT 'created proc_build_EDW_Eligibility: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_build_EDW_Eligibility') 
    BEGIN
        DROP PROCEDURE
             proc_build_EDW_Eligibility;
    END;
GO
CREATE PROCEDURE proc_build_EDW_Eligibility
AS
BEGIN

    --*******************************************************************************************
    --Step 1 - Call procedure proc_EDW_EligibilityDaily
    --    Step 2 - Call procedure proc_EDW_EligibilityStarted
    --    Step 3 - Call procedure proc_EDW_EligibilityExpired
    --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
    --    proc_build_EDW_Eligibility runs all three required procedures that are needed
    --    to apply current eligibility new, current, and expired (missing).
    --*******************************************************************************************

    SET NOCOUNT ON;
    EXEC proc_EDW_EligibilityDaily;
    EXEC proc_EDW_EligibilityStarted;
    EXEC proc_EDW_EligibilityExpired;
    SET NOCOUNT OFF;
END;
GO
PRINT '******************************************************';
PRINT 'Starting Eligibility BUILD : ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
EXEC proc_build_EDW_Eligibility;
GO
PRINT 'Eligibility Completed: ' + CAST (GETDATE () AS nvarchar (50)) ;
PRINT '******************************************************';
GO
