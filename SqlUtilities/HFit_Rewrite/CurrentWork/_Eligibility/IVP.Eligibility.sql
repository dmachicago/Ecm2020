--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

go
print 'Creating proc proc_build_EDW_Eligibility.sql'
go

if exists (select name from sys.procedures where name = 'proc_build_EDW_Eligibility')
    drop procedure proc_build_EDW_Eligibility;

go
CREATE PROCEDURE [dbo].[proc_build_EDW_Eligibility]
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


print 'Created proc proc_build_EDW_Eligibility,sql'
go--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

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
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

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
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

GO
-- use KenticoCMS_Prod3
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());

DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

--USE [msdb]
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

--This statement is here so that if the old version exists, it will be removed.
IF EXISTS (SELECT
                  job_id
                  FROM msdb.dbo.sysjobs_view
                  WHERE name = 'JOB_Update_EDW_Eligibility') 
    BEGIN
        PRINT 'Dropping JOB JOB_Update_EDW_Eligibility';
        EXEC msdb.dbo.sp_delete_job @job_name = 'JOB_Update_EDW_Eligibility', @delete_unused_schedule = 1;
    END;

IF EXISTS (SELECT
                  job_id
                  FROM msdb.dbo.sysjobs_view
                  WHERE name = @Jname) 
    BEGIN
        PRINT 'Dropping JOB JOB_Update_EDW_Eligibility';
        EXEC msdb.dbo.sp_delete_job @job_name = @Jname, @delete_unused_schedule = 1;
    END;
ELSE
    BEGIN
        PRINT 'JOB_Update_EDW_Eligibility DOES NOT exists.';
    END;
GO

PRINT 'Creating JOB JOB_Update_EDW_Eligibility';
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

DECLARE @jobId binary (16) ;
EXEC msdb.dbo.sp_add_job @job_name = @Jname,
@enabled = 1,
@notify_level_eventlog = 0,
@notify_level_email = 2,
@notify_level_netsend = 2,
@notify_level_page = 2,
@delete_level = 0,
@description = N'Updates the daily status of the PPT eligibility allowing for the EDW to track current and expired eligibilities.',
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'SA', @job_id = @jobId OUTPUT;
--select @jobId
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

DECLARE @ServerName nvarchar (80) ;
SET @ServerName = (SELECT
                          @@SERVERNAME );
EXEC msdb.dbo.sp_add_jobserver @job_name = @Jname, @server_name = @ServerName;
GO
--USE [msdb]
GO

DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

EXEC msdb.dbo.sp_add_jobstep @job_name = @Jname, @step_name = N'update the eligibility history',
@step_id = 1,
@cmdexec_success_code = 0,
@on_success_action = 1,
@on_fail_action = 2,
@retry_attempts = 0,
@retry_interval = 0,
@os_run_priority = 0, @subsystem = N'TSQL',
@command = N'exec proc_build_EDW_Eligibility',
@database_name = @DBN,
@flags = 0;
GO
--USE [msdb]

GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

EXEC msdb.dbo.sp_update_job @job_name = @Jname,
@enabled = 1,
@start_step_id = 1,
@notify_level_eventlog = 0,
@notify_level_email = 2,
@notify_level_netsend = 2,
@notify_level_page = 2,
@delete_level = 0,
@description = N'Updates the daily status of the PPT eligibility allowing for the EDW to track current and expired eligibilities.',
@category_name = N'[Uncategorized (Local)]',
@owner_login_name = N'SA',
@notify_email_operator_name = N'DBA_Email',
@notify_netsend_operator_name = N'',
@notify_page_operator_name = N'';
GO
--USE [msdb]
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_Eligibility' + @DBN;

DECLARE @schedule_id int;
EXEC msdb.dbo.sp_add_jobschedule @job_name = @Jname, @name = N'Schedule for Update EDW Eligibility',
@enabled = 1,
@freq_type = 4,
@freq_interval = 1,
@freq_subday_type = 1,
@freq_subday_interval = 0,
@freq_relative_interval = 0,
@freq_recurrence_factor = 1,
@active_start_date = 20150204,
@active_end_date = 99991231,
@active_start_time = 190000,
@active_end_time = 235959, @schedule_id = @schedule_id OUTPUT;
--select @schedule_id
GO


--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

GO

PRINT 'Creating proc_EDW_RoleEligibilityExpired';
PRINT 'FROM proc_EDW_RoleEligibilityExpired.sql';

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
             WHERE name = 'proc_EDW_RoleEligibilityExpired') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_RoleEligibilityExpired;
    END;

GO
--select count(*) from EDW_RoleMemberHistory where RoleEndDate is null  --1364405
--EXEC proc_EDW_RoleEligibilityExpired;

CREATE PROCEDURE dbo.proc_EDW_RoleEligibilityExpired
AS
BEGIN

    --******************************************************************************************
    --proc_EDW_RoleEligibilityExpired looks for PPT ROLE memebers that existed previously and
    --    does not currently exist in the daily pull. If one is found missing from the daily,
    --    that PPT is maked with an END DATE indicating the participation within that ROLE
    --    for that PPT has ended. Every 1,000 records processed will generate a message and at
    --    the end, a total records closed count will be displayed.
    --    Step 1 - Call procedure proc_EDW_EligibilityDaily
    --    Step 2 - Call procedure proc_EDW_EligibilityStarted
    --    Step 3 - Call procedure proc_EDW_RoleEligibilityExpired
    --    Step 4 - Retrieve the PPT membership history using the view view_EDW_EligibilityHistory
    --******************************************************************************************

    SET NOCOUNT OFF;
    PRINT 'Starting [proc_EDW_RoleEligibilityExpired] NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
    
declare @iCnt as integer = 0 ;

    with CTE (RoleName, UserID) AS
	(SELECT
				   RoleName
				 , UserID
				   FROM EDW_RoleMemberHistory
			 EXCEPT
			 SELECT
				   RoleName
				 , UserID
				   FROM EDW_RoleMemberToday) 
    update HIST  
	   set HIST.RoleEndDate = getdate()	
    from EDW_RoleMemberHistory  as HIST
    inner join CTE 
    on CTE.RoleName = HIST.RoleName and CTE.UserID = HIST.UserID 


    SET @iCnt = @@ROWCOUNT ;

    IF @iCnt > 0
        BEGIN
            PRINT CAST (@iCnt AS nvarchar (50)) + ' Expired ROLE Eligibility FOUND: ' + CAST (GETDATE () AS nvarchar (50)) ;
        END;
    ELSE
        BEGIN
            PRINT 'NO EligibilityExpired PPTs: ' + CAST (GETDATE () AS nvarchar (50)) ;
        END;
    PRINT 'Completed proc_EDW_RoleEligibilityExpired: ' + CAST (GETDATE () AS nvarchar (50)) ;
    PRINT '*******************************************************';
    PRINT 'Ending NOW: ' + CAST (GETDATE () AS nvarchar (50)) ;
END;

GO
PRINT 'Created proc_EDW_RoleEligibilityExpired';

GO--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

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

--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************


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

--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

GO
-- use KenticoCMS_Prod3
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;

GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;

--This statement is here so that if the old version exists, it will be removed.
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = 'JOB_Update_EDW_RoleEligibility')
BEGIN
    print ('Dropping JOB JOB_Update_EDW_RoleEligibility');
    EXEC msdb.dbo.sp_delete_job @job_name='JOB_Update_EDW_RoleEligibility', @delete_unused_schedule=1
END

IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @Jname)
BEGIN
    print ('Dropping JOB JOB_Update_EDW_RoleEligibility');
    EXEC msdb.dbo.sp_delete_job @job_name=@Jname, @delete_unused_schedule=1
END
ELSE
    print ('JOB_Update_EDW_RoleEligibility DOES NOT exist, creating new instance.');
GO

print ('Creating JOB JOB_Update_EDW_RoleEligibility');
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=@Jname, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Update PPT eilgibility daily based upon ROLE.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBA_Email',
		@job_id = @jobId OUTPUT
--select @jobId
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


declare @SVRNAME nvarchar(100) ;
set @SVRNAME = (select @@SERVERNAME);

EXEC msdb.dbo.sp_add_jobserver @job_name=@Jname, @server_name = @SVRNAME
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


EXEC msdb.dbo.sp_add_jobstep @job_name=@Jname, @step_name=N'Update ROLE Eligibility', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec proc_EDW_RoleEligibilityDaily;
		  exec proc_EDW_RoleEligibilityStarted;
		  exec proc_EDW_RoleEligibilityExpired;', 
		@database_name=@DBN, 
		@flags=0
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


EXEC msdb.dbo.sp_update_job @job_name=@Jname, 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'Update PPT eilgibility daily based upon ROLE.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBA_Email', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N''
GO
DECLARE @DBN nvarchar (200) ;
SET @DBN = (SELECT
                   DB_NAME ());
DECLARE @Jname nvarchar (100) = 'JOB_Update_EDW_RoleEligibility' + @DBN;


DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=@Jname, @name=N'EDW_Role_Eligibility_Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=12, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20150409, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
--select @schedule_id
GO
print ('JOB_Update_EDW_RoleEligibility CREATED.');
go 
--**************
print('END: ' + cast(getdate() as nvarchar(50)));
print('@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-@-');
print'***************************************************************' ;
print('START: ' + cast(getdate() as nvarchar(50)));
--**************

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
