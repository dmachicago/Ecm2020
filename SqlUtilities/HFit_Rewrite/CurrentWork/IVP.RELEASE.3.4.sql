


go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

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



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing: view_EDW_Participant ';
PRINT '***** FROM: view_EDW_Participant.sql';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
                  WHERE TABLE_NAME = 'view_EDW_Participant') 
    BEGIN
        PRINT 'View exists, dropping to recreate.';
        DROP VIEW
             view_EDW_Participant;
    END;
GO
--select top 300 * from view_EDW_Participant
if not exists (select column_name from information_schema.columns where column_name = 'HFitUserIsRegistered' and table_name = 'CMS_UserSettings')
begin
    alter table CMS_UserSettings add HFitUserIsRegistered bit null ;
End;
go

CREATE VIEW dbo.view_EDW_Participant
AS
--*********************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 (wdm) added date fields to facilitate EDW determination of last mod date 
--05.06.2015 (wdm) added HFitUserPreferredEmail to the view to resolve 52888 per a 
--				conversation with Vijay, Shankar, and John K.
--05.15.2015 (WDM) John and I, while working on this item, found the story has been removed ??? No idea why.
--05.15.2015 (WDM) CUS.HFitUserRegistrationDate (52189)  The contract (story) was removed by Vijay causing John and I to miss this one. We luckily caught it today and fixed the missing columns
--05.15.2015 (WDM) CUS.HFitUserIsRegistered  (52189)	  The contract (story) was removed by Vijay causing John and I to miss this one. We luckily caught it today and fixed the missing columns
--*********************************************************************************************

SELECT
       cus.HFitUserMpiNumber
     , cu.UserID
     , cu.UserGUID
     , CS.SiteGUID
     , hfa.AccountID
     , hfa.AccountCD
     , cus.HFitUserPreferredMailingAddress
     , cus.HFitUserPreferredMailingCity
     , cus.HFitUserPreferredMailingState
     , cus.HFitUserPreferredMailingPostalCode
     , CAST (cus.HFitCoachingEnrollDate AS datetime) AS HFitCoachingEnrollDate
     , cus.HFitUserAltPreferredPhone
     , cus.HFitUserAltPreferredPhoneExt
     , cus.HFitUserAltPreferredPhoneType
     , cus.HFitUserPreferredPhone
     , cus.HFitUserPreferredFirstName
     , CUS.HFitUserPreferredEmail
     , cast(CUS.HFitUserRegistrationDate as datetime2)	as HFitUserRegistrationDate
     , CUS.HFitUserIsRegistered
     , CASE
           WHEN CAST (cu.UserCreated AS date) = CAST (cu.UserLastModified AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , CAST (cu.UserCreated AS datetime) AS UserCreated
     , CAST (cu.UserLastModified AS datetime) AS UserLastModified
     , CAST (HFA.ItemModifiedWhen AS datetime) AS Account_ItemModifiedWhen	--wdm: 09.11.2014 added to view
       FROM dbo.CMS_User AS CU
            INNER JOIN dbo.CMS_UserSite AS CUS2 WITH (NOLOCK) 
                    ON CU.UserID = CUS2.UserID
            INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
                    ON cus2.SiteID = hfa.SiteID
            INNER JOIN dbo.CMS_Site AS CS WITH (NOLOCK) 
                    ON CUS2.SiteID = CS.SiteID
            INNER JOIN dbo.CMS_UserSettings AS CUS WITH (NOLOCK) 
                    ON CU.UserID = CUS.UserSettingsUserID and CUS.HFitUserMpiNumber > 0 and CUS.HFitUserMpiNumber is not null;

GO

--  
--  
GO
PRINT 'Created/Updated: view_EDW_Participant ';
PRINT '***** FROM: view_EDW_Participant.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing: view_EDW_RewardUserDetail ';
GO

IF EXISTS (SELECT
                  NAME
                  FROM sys.VIEWS
                  WHERE NAME = 'view_EDW_RewardUserDetail') 
    BEGIN
        DROP VIEW
             view_EDW_RewardUserDetail;
    END;
GO
-- select count(*) from view_EDW_RewardUserDetail --334654
CREATE VIEW dbo.view_EDW_RewardUserDetail
AS

--**************************************************************************************************************************************************
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/08/2014 - Generated corrected view in DEV (WDM)
--8/12/2014 - Performance Issue - 00:06:49 @ 258502
--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:46 @ 258502
--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
--8/12/2014 - Performance Issue - 00:03:45 @ 258502
--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardsUserActivity_ItemModifiedWhen
--				RewardExceptionModifiedDate, RewardTrigger_DocumentModifiedWhen. Warned Laura this might create many dups.
--11.14.2014 : (wdm) The dups have surfaced. The combination of  HFRUAD.ActivityCompletedDt, 
--				HFRUAD.ItemModifiedWhen, HFRE.ItemModifiedWhen, HFRUAD.ItemModifiedWhen, VHFRTJ.DocumentModifiedWhen has exposed
--				tens of thousands of semi-redundant rows. Today, I commented these dates out and added a distinct and went from \
--				returning more than 100,000 rows for a given MPI and Client to 4 rows. I left in place the original dates of 
--				HFRULD.ItemCreatedWhen and HFRULD.ItemModifiedWhen. This gives us whether it is an insert or update. If multiple 
--				dates are used to determine changes, then it will be necessary to use a DATE filter to bring back only the 
--				rows indicating a change.
--11.18.2014 : (wdm) Found a USERID qualifier missing on the join of HFit_RewardsUserActivityDetail. Added this qualifier to USERID
--				and the view now appears to be functioning correctly returning about 160K rows in 2.5 minutes. The DISTINCT clause
--				made no difference in the number of returned rows, so it was removed and the execution time of the query was cut in half.
--11.18.2014 (wdm) added this filter so that only USER Detail was returned.
--01.01.2015 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view - reference CR-47520
--01.01.2015 (WDM) Tested modifications - reference CR-47520
--02.17.2015 (WDM) and (SR) - modified the indexes and moved the where into a join to force the execution plan to modifiy itself. The 
--				view would not run in several hours since the deployment of this past Friday. Now, runs in a few minutes (less than 2).
-- 03.03.2015 Reviewed by nathan and dale and changes made as noted within.
--			ADDED THE FOLLOWING:
--				VHFRAJ.NodeGuid as RewardActivityGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRPJ.DocumentGuid 	--(03.03.2015 dale/nathan corrected)
--				VHFRPJ.NodeGuid		--as RewardProgramGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRGJ.NodeGuid	as RewardGroupGUID	--(03.03.2015 dale/nathan corrected)
--				VHFRTJ.NodeGuid AS RewardTriggerGUID	--(03.03.2015 dale/nathan corrected)
--03.19.2015 : by request of the EDW team, removed all columns not specificially requested
--			 and verified that was the request before initiating. The commented out columns
--			 were removed as a the solution to this request. 
--03.26.2015 : RewardGroupGUID removed per Shankar
--03.26.2015 : RewardExceptionModifiedDate Removed per Shankar
--03.26.2015 : Removed the following per Shankar  (ItemModifiedWhen/RewardExceptionModifiedDate)
--05.02.2015 : WDM - modified view for change tracking implementation (testing only)
--05.13.2015 : PUT IT BACK per discussion with Lee Allison. However, I can easily remove it again. (ItemModifiedWhen/RewardExceptionModifiedDate)
--05.13.2015 : Pulled the column from HFRUAD.ActivityCompletedDt AS RewardExceptionModifiedDate per Nathan 
--05.14.2015 : VHFRGJ.NodeGuid AS RewardGroupGUID	 --(03.03.2015 dale/nathan corrected) and removed 03.26.2015 per Shankar; put back 03.30.2015 deemed needed; removed 05.14.2015 who knows why.
--06.26.2015 : Dhaval and Dale discuss change request to view. 
--			 HFRUAD -> HFit_RewardsUserActivityDetail, we are asked to change a field (UserExceptionAppliedTo)
--			 to now point to ActivityCompletedId -> HFit_RewardsUserActivityDetail. This req made today 
--			 from Corina thru Laura. Dhaval and I CONNOT make this change without a CR. 
--			 We decided to implement as: HFRAUD.ActivityCompletedId as UserExceptionAppliedTo
--06.28.2015 : Reviewed, tested, and Passed by Corina
--07.13.2015 : #55054 raised by Corina indicates there may be data anomolies (returned number of rows) based on whether 
--			 a LEFT or INNER join is used. WDM tested the return counts on all machines using both inner and left joins.
--				288,480 with inner join   P5/P1	 @ 07.13.2015
--				288,480 with left join	 P5/P1	 @ 07.13.2015
--				372,060 with 2 left join	 P5/P1	 @ 07.13.2015
--				24,833 with inner join    P5/P2	 @ 07.13.2015
--				24,833 with left join	 P5/P2	 @ 07.13.2015
--				40,738 with 2 left join	 P5/P2	 @ 07.13.2015    
--				374,876 with inner join   P5/P3	 @ 07.13.2015
--				374,876 with left join	 P5/P3	 @ 07.13.2015
--				523,203 with 2 left join	 P5/P3	 @ 07.13.2015		  
--			 NOTE: In all instances on Prod5 and TGT, the returned row count is the same.
--08.02.2015	 Corina and Dale reviewed and tested the view DDL with corrections suggested by Corina that will cause a more 
--			 complete set of User Rewards to be returned.
--08.06.2015	 Yesterday the ciew was approved by Corina and is being scheduled for implementation tonight.
--**************************************************************************************************************************************************

SELECT DISTINCT
       cu.UserGUID
     , CS2.SiteGUID
     , cus2.HFitUserMpiNumber
     , VHFRAJ.NodeGuid AS RewardActivityGUID	--(03.03.2015 dale/nathan corrected)
     , VHFRPJ.RewardProgramName
     , CAST (VHFRPJ.DocumentModifiedWhen AS datetime) AS RewardModifiedDate

     , CAST (VHFRLJ.DocumentModifiedWhen  AS datetime) AS RewardLevelModifiedDate
     , CAST (HFRULD.LevelCompletedDt AS datetime) AS LevelCompletedDt
     , HFRUAD.ActivityPointsEarned
     , CAST (HFRUAD.ActivityCompletedDt AS datetime) AS ActivityCompletedDt
     , CAST (HFRUAD.ItemModifiedWhen  AS datetime) AS RewardActivityModifiedDate
     , VHFRAJ.ActivityPoints
     , HFRE.UserAccepted		  --Corina, please verify whether this column is needde or not
       --, HFRE.UserExceptionAppliedTo
     , HFRUAD.ActivityCompletedId AS UserExceptionAppliedTo
     , VHFRTJ.NodeGuid AS RewardTriggerGUID	--(03.03.2015 dale/nathan corrected)
     , HFA.AccountID
     , HFA.AccountCD
     , CASE
           WHEN CAST (HFRULD.ItemCreatedWhen AS date) = CAST (HFRULD.ItemModifiedWhen AS date) 
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , CAST (HFRUAD.ActivityCompletedDt AS datetime) AS RewardExceptionModifiedDate

       FROM
           dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH (NOLOCK) 
               INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH (NOLOCK) 
                   ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
                  AND VHFRAJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH (NOLOCK) 
                   ON HFRUAD.rewardgroupnodeid = VHFRGJ.NodeID
                  AND VHFRGJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH (NOLOCK) 
                   ON HFRUAD.rewardprogramnodeid = VHFRPJ.NodeID
                  AND VHFRPJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH (NOLOCK) 
                   ON HFRUAD.rewardlevelnodeid = VHFRLJ.NodeID
                  AND VHFRLJ.DocumentCulture = 'en-us'
               INNER JOIN dbo.CMS_User AS CU WITH (NOLOCK) 
                   ON cu.UserID = HFRUAD.userid
               INNER JOIN dbo.CMS_UserSite AS CUS WITH (NOLOCK) 
                   ON CU.UserID = CUS.UserID
               INNER JOIN dbo.CMS_Site AS CS2 WITH (NOLOCK) 
                   ON CUS.SiteID = CS2.SiteID
               INNER JOIN dbo.HFit_Account AS HFA WITH (NOLOCK) 
                   ON cs2.SiteID = HFA.SiteID
               INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH (NOLOCK) 
                   ON cu.UserID = cus2.UserSettingsUserID
               LEFT JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH (NOLOCK) 
                   ON HFRUAD.rewardlevelnodeid = HFRULD.LevelNodeID
                  AND HFRULD.rewardgroupnodeid = HFRUAD.rewardgroupnodeid
                  AND HFRULD.rewardprogramnodeid = HFRUAD.rewardprogramnodeid
                  AND HFRULD.userid = HFRUAD.userid
               LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH (NOLOCK) 
                   ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
                  AND VHFRTJ.DocumentCulture = 'en-us'
               LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH (NOLOCK) 
                   ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
                  AND HFRE.UserID = cu.UserID
       WHERE  cus2.HFitUserMpiNumber > 0;

GO
PRINT 'Completed : view_EDW_RewardUserDetail ';
GO

/*----------------------------------------
(WDM) Kept only these coulmns IAW CR-51005
UserGUID
SiteGUID 
HFitUserMPINumber
RewardActivityGUID
RewardProgramName
RewardModifiedDate
RewardGroupGUID
RewardLevelModifiedDate
LevelCompletedDt
ActivityPointsEarned
ActivityCompletedDt
RewardActivityModifiedDate
ActivityPoints
UserAccepted
UserExceptionAppliedTo
RewardTriggerGUID
AccountID
AccountCD 
ChangeType
RewardExceptionModifiedDate
*/

PRINT '***** FROM: view_EDW_RewardUserDetail.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go




go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing: view_EDW_RewardAwardDetail ';
GO
IF EXISTS (SELECT
				  TABLE_NAME
				  FROM INFORMATION_SCHEMA.VIEWS
				  WHERE TABLE_NAME = 'view_EDW_RewardAwardDetail') 
	BEGIN
		DROP VIEW
			 view_EDW_RewardAwardDetail;
	END;
GO
--04.03.2015 : CR 51853 requested to put back columns that were previously removed. AwardDisplayName and AwardType (per Laura B. via Shankar) this is a CYA.
CREATE VIEW dbo.view_EDW_RewardAwardDetail
AS

--*************************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, none required
--09.11.2014 : (wdm) reviewed for EDW last mod date and the view is OK as is
--11.19.2014 : added language to verify returned data
--02.03.2015 : LevelName, LevelHeader, GroupHeadingText, GroupHeadingDescription
--03.03.2015 : (dale/nathan) Added RewardLevelGUID
--03.19.2015 : by request of the EDW team, removed all columns not specificially requested
--			 and verified that was the request before initiating. The commented out columns
--			 were removed as a the solution to this request. 
--			 /*
--			 (WDM) Kept only these coulmns IAW CR-51005
--			 UserGUID
--			 SiteGUID 
--			 HFitUserMPINumber
--			 RewardLevelGUID
--			 RewardValue
--			 ThresholdNumber
--			 UserNotified
--			 IsFulfilled
--			 AccountID
--			 AccountCD
--			 ChangeType
--*/
--04.03.2015 : CR 51853 requested to put back columns that were previously removed. 
--			 AwardDisplayName and AwardType
--*************************************************************************************************

SELECT DISTINCT
	   cu.UserGUID
	 , cs.SiteGUID
	 , cus.HFitUserMpiNumber
	 --, RL_Joined.RewardLevelID
	 , RL_Joined.NodeGuid AS RewardLevelGUID
	   , RL_Joined.AwardType
	 , HFRAUD.AwardDisplayName
	 , HFRAUD.RewardValue
	 , HFRAUD.ThresholdNumber
	 , HFRAUD.UserNotified
	 , HFRAUD.IsFulfilled
	 , hfa.AccountID
	 , HFA.AccountCD
	 , CASE
		   WHEN CAST (HFRAUD.ItemCreatedWhen AS date) = CAST (HFRAUD.ItemModifiedWhen AS date) 
		   THEN 'I'
		   ELSE 'U'
	   END AS                ChangeType
	 --, HFRAUD.ItemCreatedWhen
	 --, HFRAUD.ItemModifiedWhen
	 --, RL_Joined.DocumentCulture 
	 --, HFRAUD.CultureCode
	 --, RL_Joined.LevelName
	 --, RL_Joined.LevelHeader
	 --, RL_Joined.GroupHeadingText
	 --, RL_Joined.GroupHeadingDescription
	   FROM dbo.HFit_RewardsAwardUserDetail AS HFRAUD
				INNER JOIN dbo.View_HFit_RewardLevel_Joined AS RL_Joined
					ON hfraud.RewardLevelNodeId = RL_Joined.NodeID
				   AND RL_Joined.DocumentCulture = 'en-US'
				   AND HFRAUD.CultureCode = 'en-US'
				 INNER JOIN dbo.CMS_User AS CU
					ON hfraud.UserId = cu.UserID
				 INNER JOIN dbo.CMS_UserSite AS CUS2
					ON cu.UserID = cus2.UserID
				 INNER JOIN dbo.HFit_Account AS HFA
					ON cus2.SiteID = HFA.SiteID
				 INNER JOIN dbo.CMS_Site AS CS
					ON CUS2.SiteID = CS.SiteID
				 INNER JOIN dbo.CMS_UserSettings AS CUS
					ON cu.UserID = cus.UserSettingsUserID;
GO
PRINT 'Processed: view_EDW_RewardAwardDetail ';


GO
PRINT '***** FROM: view_EDW_RewardAwardDetail.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


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



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO 
print 'Creating view view_EDW_CoachingPPTEnrolled';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO
if exists (select name from sys.views where name = 'view_EDW_CoachingPPTEnrolled')
    drop view view_EDW_CoachingPPTEnrolled
go

-- select count(*) from view_EDW_CoachingPPTEnrolled
CREATE VIEW [dbo].[view_EDW_CoachingPPTEnrolled]
AS
       SELECT
              U.UserID
              ,U.UserGUID
              ,US1.HFitUserMpiNumber
              ,S.SiteGUID
              ,A.AccountID
              ,A.AccountCD
              ,A.AccountName
              ,R.RoleGUID
              ,R.RoleDisplayName
		    ,R.RoleName
              ,CASE
                     WHEN CSL.IsConditionManagement = 0 THEN 'LM'
                     WHEN CSL.IsConditionManagement = 1 THEN 'CM'
                     ELSE NULL
              END AS CoachingDescription
              ,CSL.Description AS ServiceLevelDescription
       FROM
              CMS_User AS U
              JOIN dbo.CMS_UserSettings AS US1 ON U.UserID = US1.UserSettingsUserID
              JOIN dbo.CMS_UserSite AS US2 ON U.UserID = US2.UserID
              JOIN dbo.CMS_Site AS S ON US2.SiteID = S.SiteID
              JOIN dbo.HFit_Account AS A ON S.SiteID = A.SiteID
              JOIN CMS_UserRole AS UR ON U.UserID = UR.UserID
              JOIN CMS_Role AS R ON UR.RoleID = R.RoleID
                     AND R.RoleDisplayName = 'SYSTEM.Coaching Enrollment' -- Enrolled (BOTH LM and CM)
              LEFT JOIN HFit_CoachingUserServiceLevel AS CUSL ON U.UserID = CUSL.UserID
                     AND CUSL.ServiceLevelStatusItemID = 1 -- Enrolled
              LEFT JOIN HFit_LKP_CoachingServiceLevel AS CSL ON CUSL.ServiceLevelItemID = CSL.ItemID
       WHERE ISNULL(US1.HFitUserMpiNumber, 0) > 0
GO
print 'Created view view_EDW_CoachingPPTEnrolled';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO 
print 'Creating view view_EDW_CoachingPPTEligible';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO
-- select top 100 * from view_EDW_CoachingPPTEligible
-- select count(*) from view_EDW_CoachingPPTEligible
if not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RoleDisplayName' and TABLE_NAME = 'CMS_Role')
    alter table CMS_Role add RoleDisplayName nvarchar(100) null ;

go
if exists (select name from sys.views where name = 'view_EDW_CoachingPPTEligible')
    drop view view_EDW_CoachingPPTEligible
go
CREATE VIEW [dbo].[view_EDW_CoachingPPTEligible]
AS
       SELECT
              U.UserID
              ,U.UserGUID
              ,US1.HFitUserMpiNumber
              ,S.SiteGUID
              ,A.AccountID
              ,A.AccountCD
              ,A.AccountName
              ,TMP.RoleGUID
              --,TMP.RoleDisplayName
		, 'SYSTEM.Coaching Eligible'  as RoleDisplayName
		    ,TMP.RoleName
              ,TMP.CoachingDescription
              ,TMP.ServiceLevelDescription
       FROM
              CMS_User AS U
              JOIN dbo.CMS_UserSettings AS US1 ON U.UserID = US1.UserSettingsUserID
              JOIN dbo.CMS_UserSite AS US2 ON U.UserID = US2.UserID
              JOIN dbo.CMS_Site AS S ON US2.SiteID = S.SiteID
              JOIN dbo.HFit_Account AS A ON S.SiteID = A.SiteID
              JOIN (SELECT
                                  CUSL.UserID
                                  ,NULL AS RoleGUID
                                  --,NULL AS RoleDisplayName
							 ,NULL AS RoleName
                                  ,CSL.Description AS ServiceLevelDescription
                                  ,'CM' AS CoachingDescription
                           FROM
                                  HFit_CoachingUserServiceLevel AS CUSL
                                  JOIN HFit_LKP_CoachingServiceLevel AS CSL ON CUSL.ServiceLevelItemID = CSL.ItemID
                                         AND CSL.IsConditionManagement = 1 -- CM
                           WHERE CUSL.ServiceLevelStatusItemID = 2 -- Recommended (Eligible ONLY CM)
                           UNION
                           SELECT
                                  MU.UserID
                                  ,R.RoleGUID
                                  --,R.RoleDisplayName
							 ,R.RoleName
                                  ,'LM' AS ServiceLevelDescription
                                  ,'LM' AS CoachingDescription
                           FROM
                                  CMS_MembershipUser AS MU
                                  JOIN CMS_MembershipRole AS MR ON MU.[MembershipID] = MR.[MembershipID]
                                  JOIN CMS_Role AS R ON MR.RoleID = R.RoleID
                                         AND R.RoleDisplayName = 'SYSTEM.Coaching Eligible') AS TMP ON U.UserID = TMP.UserID -- Eligible (ONLY LM)
       WHERE ISNULL(US1.HFitUserMpiNumber, 0) > 0
GO
print 'Created view view_EDW_CoachingPPTEligible';
print 'FROM view_EDW_CoachingPPTEnrolled.sql';
GO



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--DISABLE TRIGGER trgSchemaMonitor ON DATABASE;

GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails.sql';
PRINT 'Processing: view_EDW_TrackerCompositeDetails ';
GO
--SELECT * from view_EDW_TrackerCompositeDetails
IF EXISTS ( SELECT DISTINCT
                   TABLE_NAME
                   FROM INFORMATION_SCHEMA.VIEWS
                   WHERE
                   TABLE_NAME = 'view_EDW_TrackerCompositeDetails') 
    BEGIN
        DROP VIEW
             view_EDW_TrackerCompositeDetails;
    END;
GO
--count with UNION ALL xx @ 00:00:24
--count with UNION ALL and DISTINCT xx @ 00:00:24
--count with UNION 3,218,556 @ 00:00:24
--SELECT count(*) from view_EDW_TrackerCompositeDetails;
GO
CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
AS
--************************************************************************************************************************************
-- NOTES:
--************************************************************************************************************************************
--WDM 6/26/2014
--This view is needed by EDW in order to process the Tracker tables' data.
--As of now, the Tracker tables are representative of objects and that would cause 
--	large volumes of ETL to be devloped and maintained. 
--This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
--Each tracker table to be processed into the EDW must be represented in this view.
--ALL new tracker tables need only be entered once using the structure contained within this view
--	and the same EDW ETL should be able to process it.
--If there is a change to the strucuture of any one query in this view, then all have to be modified 
--	to be support the change.
--Column TrackerNameAggregratetable (AggregateTableName) will be NULL if the Tracker is not a member 
--		of the DISPLAYED Trackers. This allows us to capture all trackers, displayed or not.

--7/29/2014
--ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
--		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
--		This raises the need for the Tracker Definition Table.

--NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
--		be avoided here if possible.

--**************** SPECIFIC TRACKER DATA **********************
--**************** on 7/29/2014          **********************
--Tracker GUID or Unique ID across all DB Instances (ItemGuid)
--Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
--Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
--Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
--		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
--Tracker Column Description (In English) (???)
--Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
--	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
--Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
--Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
--Tracker Insert Date ([ItemCreatedWhen])
--Tracker Last Update Date ([ItemModifiedWhen])
--NOTE: Convert all numerics to floats 7/30/2104 John/Dale
--****************************************************************************************************************************
-- 12.21.2014 - Added Select Distincts to avoid possible dups.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
--****************************************************************************************************************************
-- NEW ADDITIONS: 02.01.2015	Need for the updates to be completed and then we add.
--	  HFit_TrackerTobaccoAttestation
--	  HFit_TrackerPreventiveCare
--	  HFit_TrackerCotinine
--(03.20.2015) - (WDM) The DISTINCT in this qry in should eliminate duplicate rows found by John C.
--			 All worked correctly in 12.25.2014, NO changes effected since then, and unexplicably rows stated to 
--			 duplicate in three tables (tracker views) Shots, Tests, and TrackerInstance
--(03.20.2015) - WDM : HFit_TrackerInstance_Tracker has a problem that will require developer help - it is still OPEN.
--			    John C. and I looked at the issue and the LEFT join is causing a cartisian as there is no KEY 
--			    on which to join.
-- TGT (PRod1) NO DISTINCT: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:08:36 @ 3,210,081
--- TGT (PRod1) WITH DISTINCT and Union all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:30 @ 3,210,081
--- TGT (PRod1) No DISTINCT and UNion all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:14 @ 3,218,556
--(03.21.2015) - WDM : Implemented bew code for TrackerInstance and it returns data properly now.
--(03.22.2015) - WDM : Found and corrected the Shots and Tests duplicate rows. No DUPS at this point.
--(
--****************************************************************************************************************************
--Best USE is:		(however, I do not believe Laura is allowing this view to be called in this fashion)
--SELECT * from view_EDW_TrackerCompositeDetails where EventDate between '2013-11-04 00:00:00' and '2013-11-04 23:59:59'

--Set statistics IO ON
--GO

SELECT DISTINCT
       'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mm/Hg' AS UOM
     , 'Systolic' AS KEY1
     , CAST ( Systolic AS float) AS VAL1
     , 'Diastolic' AS KEY2
     , CAST ( Diastolic AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'bp') AS UniqueName
     , ISNULL ( T.UniqueName , 'bp') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBloodPressure AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/L' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS float) AS VAL1
     , 'FastingState' AS KEY2
     , CAST ( FastingState AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'glucose') AS UniqueName
     , ISNULL ( T.UniqueName , 'glucose') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBloodSugarAndGlucose AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBMI' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'kg/m2' AS UOM
     , 'BMI' AS KEY1
     , CAST ( BMI AS float) AS VAL1
     , 'NA' AS KEY2
     , 0 AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBMI AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBMI'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'PCT' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS float) AS VAL1
     , 'NA' AS KEY2
     , 0 AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBodyFat AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBodyFat'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
--******************************************************************************
SELECT DISTINCT
       'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Inch' AS UOM
     , 'WaistInches' AS KEY1
     , CAST ( WaistInches AS float) AS VAL1
     , 'HipInches' AS KEY2
     , CAST ( HipInches AS float) AS VAL2
     , 'ThighInches' AS KEY3
     , CAST ( ThighInches AS float) AS VAL3
     , 'ArmInches' AS KEY4
     , CAST ( ArmInches AS float) AS VAL4
     , 'ChestInches' AS KEY5
     , CAST ( ChestInches AS float) AS VAL5
     , 'CalfInches' AS KEY6
     , CAST ( CalfInches AS float) AS VAL6
     , 'NeckInches' AS KEY7
     , CAST ( NeckInches AS float) AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBodyMeasurements AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
--******************************************************************************
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCardio' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'Minutes' AS KEY1
     , CAST ( Minutes AS float) AS VAL1
     , 'Distance' AS KEY2
     , CAST ( Distance AS float) AS VAL2
     , 'DistanceUnit' AS KEY3
     , CAST ( DistanceUnit AS float) AS VAL3
     , 'Intensity' AS KEY4
     , CAST ( Intensity AS float) AS VAL4
     , 'ActivityID' AS KEY5
     , CAST ( ActivityID AS float) AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerCardio AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCardio'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mg/dL' AS UOM
     , 'HDL' AS KEY1
     , CAST ( HDL AS float) AS VAL1
     , 'LDL' AS KEY2
     , CAST ( LDL AS float) AS VAL2
     , 'Total' AS KEY3
     , CAST ( Total AS float) AS VAL3
     , 'Tri' AS KEY4
     , CAST ( Tri AS float) AS VAL4
     , 'Ratio' AS KEY5
     , CAST ( Ratio AS float) AS VAL5
     , 'Fasting' AS KEY6
     , CAST ( Fasting AS float) AS VAL6
     , 'VLDL' AS VLDL
     , CAST ( VLDL AS float) AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerCholesterol AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCholesterol'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Step' AS UOM
     , 'Steps' AS KEY1
     , CAST ( Steps AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerDailySteps AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerDailySteps'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasStretched' AS KEY1
     , CAST ( HasStretched AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerFlexibility AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerFlexibility'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFruits' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerFruits AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerFruits'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/mol' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHbA1c AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHbA1c'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'inch' AS UOM
     , 'Height' AS KEY1
     , Height AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHeight AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHeight'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHighFatFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHighSodiumFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
--w/o  distinct 00:02:07 @ 477120 PRD1
--with distinct 00:03:20 @ 475860 PRD1
--(03.20.2015) - (WDM) verified SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT 'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable ,
                     TT.ItemID ,
                     cast(EventDate as datetime) as EventDate ,
                     TT.IsProfessionallyCollected ,
                     TT.TrackerCollectionSourceID ,
                     Notes ,
                     TT.UserID ,
                     CollectionSourceName_Internal ,
                     CollectionSourceName_External ,
                     'MISSING' AS EventName ,
                     'Y/N' AS UOM ,
                     'TrackerDefID' AS KEY1 ,
                     CAST (TrackerDefID AS float) AS VAL1 ,
                     'YesNoValue' AS KEY2 ,
                     CAST (YesNoValue AS float) AS VAL2 ,
                     'NA' AS KEY3 ,
                     NULL AS VAL3 ,
                     'NA' AS KEY4 ,
                     NULL AS VAL4 ,
                     'NA' AS KEY5 ,
                     NULL AS VAL5 ,
                     'NA' AS KEY6 ,
                     NULL AS VAL6 ,
                     'NA' AS KEY7 ,
                     NULL AS VAL7 ,
                     'NA' AS KEY8 ,
                     NULL AS VAL8 ,
                     'NA' AS KEY9 ,
                     NULL AS VAL9 ,
                     'NA' AS KEY10 ,
                     NULL AS VAL10 ,
                     TT.ItemCreatedBy ,
                     cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen ,
                     TT.ItemModifiedBy ,
                     cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen ,
                     NULL AS IsProcessedForHa ,
                     'NA' AS TXTKEY1 ,
                     NULL AS TXTVAL1 ,
                     'NA' AS TXTKEY2 ,
                     NULL AS TXTVAL2 ,
                     'NA' AS TXTKEY3 ,
                     NULL AS TXTVAL3 ,
                     NULL AS ItemOrder ,
                     NULL AS ItemGuid ,
                     C.UserGuid ,
                     PP.MPI ,
                     PP.ClientCode ,
                     S.SiteGUID ,
                     ACCT.AccountID ,
                     ACCT.AccountCD ,
                     T.IsAvailable ,
                     T.IsCustom ,
                     T.UniqueName ,
                     T.UniqueName AS ColDesc ,
                     NULL AS VendorID,
                     NULL AS VendorName
          FROM dbo.HFit_TrackerInstance_Tracker AS TT
                              INNER JOIN dbo.HFit_TrackerDef_Tracker TDT     
                                  ON TDT.trackerid = TT.trackerDefID
                           INNER JOIN dbo.CMS_User AS C
                                  ON C.UserID = TT.UserID
                           INNER JOIN dbo.hfit_ppteligibility AS PP
                                  ON TT.UserID = PP.userID
                           INNER JOIN dbo.HFit_Account AS ACCT
                                  ON PP.ClientCode = ACCT.AccountCD
                           INNER JOIN dbo.CMS_Site AS S
                                  ON ACCT.SiteID = S.SiteID
                           INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                                  ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                                  ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
                                                         AND T.uniquename = TDT.name
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerMealPortions AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerMealPortions'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FollowedPlan' AS KEY1
     , CAST ( FollowedPlan AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerMedicalCarePlan AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerRegularMeals AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerRegularMeals'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'BPM' AS UOM
     , 'HeartRate' AS KEY1
     , CAST ( HeartRate AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerRestingHeartRate AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
--With DISTINCT 00:14 @ 40041
--With NO DISTINCT 00:14 @ 40060
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT
       'HFit_TrackerShots' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FluShot' AS KEY1
     , CAST ( FluShot AS float) AS VAL1
     , 'PneumoniaShot' AS KEY2
     , CAST ( PneumoniaShot AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerShots AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerShots'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSitLess' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSitLess AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSitLess'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'HR' AS UOM
     , 'DidFollow' AS KEY1
     , CAST ( DidFollow AS float) AS VAL1
     , 'HoursSlept' AS KEY2
     , HoursSlept AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Techniques' AS TXTKEY1
     , Techniques AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSleepPlan AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSleepPlan'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStrength' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasTrained' AS KEY1
     , CAST ( HasTrained AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStrength AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStrength'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStress' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'Intensity' AS KEY1
     , CAST ( Intensity AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Awareness' AS TXTKEY1
     , Awareness AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStress AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStress'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'HasPracticed' AS KEY1
     , CAST ( HasPracticed AS float) AS VAL1
     , 'Effectiveness' AS KEY2
     , CAST ( Effectiveness AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStressManagement AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStressManagement'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSugaryDrinks AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSugaryFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
--Using DISTINCT PROD1 - 00:08:41 @ 40313
--Using DISTINCT PRD1 - 00:00:09 @ 45502
--Using NO DISTINCT PRD1 00:19 @ 40332
--Using DISTINCT PRD1 - 00:00:11 @ 44483
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT
       'HFit_TrackerTests' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PSATest' AS KEY1
     , CAST ( PSATest AS float) AS VAL1
     , 'OtherExam' AS KEY1
     , CAST ( OtherExam AS float) AS VAL2
     , 'TScore' AS KEY3
     , CAST ( TScore AS float) AS VAL3
     , 'DRA' AS KEY4
     , CAST ( DRA AS float) AS VAL4
     , 'CotinineTest' AS KEY5
     , CAST ( CotinineTest AS float) AS VAL5
     , 'ColoCareKit' AS KEY6
     , CAST ( ColoCareKit AS float) AS VAL6
     , 'CustomTest' AS KEY7
     , CAST ( CustomTest AS float) AS VAL7
     , 'TSH' AS KEY8
     , CAST ( TSH AS float) AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'CustomDesc' AS TXTKEY1
     , CustomDesc AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerTests AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTests'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'WasTobaccoFree' AS KEY1
     , CAST ( WasTobaccoFree AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'QuitAids' AS TXTKEY1
     , QuitAids AS TXTVAL1
     , 'QuitMeds' AS TXTKEY2
     , QuitMeds AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerTobaccoFree AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerVegetables' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerVegetables AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerVegetables'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWater' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWater AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWater'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'LBS' AS UOM
     , 'Value' AS KEY1
     , [Value] AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWeight AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWeight'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-serving' AS UOM
     , 'Servings' AS KEY1
     , CAST ( Servings AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWholeGrains AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWholeGrains'
			 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL

SELECT DISTINCT
       'HFit_TrackerCotinine' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'NicotineAssessment' AS KEY1
     , CAST ( NicotineAssessment AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerCotinine AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCotinine'
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

UNION ALL
SELECT DISTINCT
       'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PreventiveCare' AS KEY1
     , CAST ( PreventiveCare AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerPreventiveCare AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerPreventiveCare'
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'TobaccoAttestation' AS KEY1
     , CAST ( TobaccoAttestation AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerTobaccoAttestation AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTobaccoAttestation';
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

GO

--  
--  
GO
PRINT '***** CREATED: view_EDW_TrackerCompositeDetails.sql';
GO 

--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--enable TRIGGER trgSchemaMonitor ON DATABASE;

GO


go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Creating view view_EDW_SmallStepResponses';
PRINT 'Generated FROM: view_EDW_SmallStepResponses.SQL';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
             WHERE name = 'view_EDW_SmallStepResponses') 
    BEGIN
        PRINT 'VIEW view_EDW_SmallStepResponses, replacing.';
        DROP VIEW
             view_EDW_SmallStepResponses;
    END;
GO

CREATE VIEW dbo.view_EDW_SmallStepResponses
AS

--********************************************************************************************************
--IVP Version NO: 1.0
--02.13.2014 : (Sowmiya Venkiteswaran) : Updated the view to include  the fields:
--AccountCD, SiteGUID,SSOutcomeMessage as info. text,
-- Small Steps Program Info( HACampaignNodeGUID,HACampaignName,HACampaignStartDate,HACampaignEndDate)
-- HAUserStartedRecord Info (HAStartedDate,HACompletedDate,HAStartedMode,HACompletedMode)
-- Added filters by document culture and replacing HTML quote with a SQL single quote
--********************************************************************************************************
--02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning - removed the following WHERE clause and 
--			incorporated them into the JOIN statements for perfoamnce enhancement.
--			 WHERE vwOutcome.DocumentCulture = 'en-US' AND vwCamp.DocumentCulture = 'en-US';
--********************************************************************************************************
--02.23.2014 : (Dale Miller & Sowmiya V) : Performance tuning
--	Prod1, 2 and 3 Labs - Incorporated doc. culture to the Joins
-- 1 - executed DBCC dropcleanbuffers everytime
-- 2 - Tested REPLACE against No REPLACE, insignificant perf. hit.
-- Test Controls:
-- Prod1 Lab - NO SQL DISTINCT - 184311 ( rows) - 14 (seconds) 
-- Prod1 Lab - WITH SQL DISTINCT - 184311 ( rows) - 32 (seconds) 
-- Prod2 Lab - NO SQL DISTINCT -  81120( rows) -  10(seconds) 
-- Prod2 Lab - WITH SQL DISTINCT - 81120 ( rows) -  22(seconds) 
-- Prod3 Lab - NO SQL DISTINCT - 136763 ( rows) - 10 (seconds) 
-- Prod3 Lab - WITH SQL DISTINCT - 136763 ( rows) -  21(seconds)  
--02.24.2015 (SV) - Added column SSHealthAssesmentUserStartedItemID per request from John C.
--02.24.2015 (WDM) - Verified changes applied correctly from within the IVP
--02.24.2015 (WDM) - Verified changes are tracked from within the Schema Change Monitor
--02.24.2015 (WDM) - Add the view to the Data/View IVP
--03.02.2015 (WDM) - The view got out of sync most likely due to multiple users with CRUD capability.
--		Re-executed the master DDL.
--03.03.2015 (WDM/SV) - Added new columns HaCodeName and HFitUserMPINumber.
--03.04.2015 (WDM/SV) - Tested view and reviewed output - added DISTINCT and tuned for perf.
--03.04.2015 (WDM/Ashwin) - Ashwin started testing. Modified the JOIN for UserID - now returns expected MPI.
--03.04.2015 (WDM/Ashwin) - Ashwin certified the view as tested.
--04.06.2015 (WDM/JC) John found an error in the JOIN of user ID - changed to CMS_US.UserSettingsUserID = ss.UserID
--04.15.2015 (WDM/Shane) Found an issue with duplicate rows. Added the SiteID to the JOIN (eg.
--			  vwCamp.NodeSiteID = usrste.SiteID and moved the join down in the list.)
--04.16.2015 (WDM) completed CR-51962
--********************************************************************************************************

SELECT DISTINCT
       ss.UserID
     , acct.AccountCD
     , ste.SiteGUID
     , ss.ItemID AS SSItemID
     , ss.ItemCreatedBy AS SSItemCreatedBy
     , cast(ss.ItemCreatedWhen as datetime)  AS SSItemCreatedWhen
     , ss.ItemModifiedBy AS SSItemModifiedBy
     , cast(ss.ItemModifiedWhen  as datetime) AS SSItemModifiedWhen
     , ss.ItemOrder AS SSItemOrder
     , ss.ItemGUID AS SSItemGUID
     , ss.HealthAssesmentUserStartedItemID AS SSHealthAssesmentUserStartedItemID
     , ss.OutComeMessageGUID AS SSOutcomeMessageGuid
     , REPLACE (vwOutcome.Message, '&#39;', '''') AS SSOutcomeMessage
     , usrstd.HACampaignNodeGUID
     , vwCamp.Name AS HACampaignName
     , cast(vwCamp.CampaignStartDate  as datetime) AS HACampaignStartDate
     , cast(vwCamp.CampaignEndDate  as datetime) AS HACampaignEndDate
     , cast(usrstd.HAStartedDt  as datetime) AS HAStartedDate
     , cast(usrstd.HACompletedDt  as datetime) AS HACompletedDate
     , usrstd.HAStartedMode
     , usrstd.HACompletedMode
     , TODO.HaCodeName
     , CMS_US.HFitUserMPINumber

       FROM
           dbo.Hfit_SmallStepResponses AS ss
               JOIN HFit_HealthAssesmentUserStarted AS usrstd
                   ON usrstd.UserID = ss.UserID
                  AND usrstd.ItemID = ss.HealthAssesmentUserStartedItemID
                 JOIN View_HFit_OutComeMessages_Joined AS vwOutcome
                   ON vwOutcome.NodeGUID = ss.OutComeMessageGUID
                  AND vwOutcome.DocumentCulture = 'en-US'
                 JOIN CMS_UserSite AS usrste
                   ON usrste.UserID = ss.UserID
                 JOIN CMS_Site AS ste
                   ON ste.SiteID = usrste.SiteID
                 JOIN View_HFit_HACampaign_Joined AS vwCamp
                   ON vwCamp.NodeGuid = usrstd.HACampaignNodeGUID
                  AND vwCamp.DocumentCulture = 'en-US'
                  AND vwCamp.NodeSiteID = usrste.SiteID
                 JOIN HFit_Account AS acct
                   ON acct.SiteID = usrste.SiteID
                 JOIN HFit_ToDoSmallSteps AS TODO
                   ON ss.OutComeMessageGUID = TODO.OutComeMessageGUID
                 JOIN CMS_UserSettings AS CMS_US
                   ON CMS_US.UserSettingsUserID = ss.UserID
                  AND CMS_US.HFitUserMPINumber > 0
                  AND CMS_US.HFitUserMPINumber IS NOT NULL;

GO
PRINT 'Created view view_EDW_SmallStepResponses';
GO



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) + '  *** view_EDW_BioMetrics.sql (CR11690)';
GO
--drop table [EDW_BiometricViewRejectCriteria]
IF NOT EXISTS (SELECT [name]
			  FROM [sys].[tables]
			  WHERE [name] = 'EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'EDW_BiometricViewRejectCriteria NOT found, creating';
	   --This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
	   --Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
	   CREATE TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] nvarchar (8) NOT NULL
	 , [ItemCreatedWhen] datetime2 (7) NOT NULL
	 , [SiteID] int NOT NULL
	 , [RejectGUID] uniqueidentifier NULL
	   );

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria]
	   ADD CONSTRAINT
		  [DF_EDW_BiometricViewRejectCriteria_RejectGUID] DEFAULT NEWID () FOR [RejectGUID];

	   ALTER TABLE [dbo].[EDW_BiometricViewRejectCriteria] SET (LOCK_ESCALATION = TABLE) ;

	   EXEC [sp_addextendedproperty]
	   @name = N'PURPOSE' , @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria';
	   --@level2type = N'Column', @level2name = NULL

	   EXEC [sp_addextendedproperty]
	   @name = N'MS_Description' , @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'AccountCD';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'SiteID';

	   EXEC [sp_addextendedproperty]
	   @name = N'USAGE' , @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.' ,
	   @level0type = N'Schema' , @level0name = 'dbo' ,
	   @level1type = N'Table' , @level1name = 'EDW_BiometricViewRejectCriteria' ,
	   @level2type = N'Column' , @level2name = 'ItemCreatedWhen';
    END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'view_EDW_BiometricViewRejectCriteria found, updating';
	   DROP VIEW [view_EDW_BiometricViewRejectCriteria];
    END;
GO

CREATE VIEW [view_EDW_BiometricViewRejectCriteria]
AS SELECT [AccountCD]
	   , [ItemCreatedWhen]
	   , [SiteID]
	   , [RejectGUID]
	FROM [dbo].[EDW_BiometricViewRejectCriteria];
GO
PRINT 'view_EDW_BiometricViewRejectCriteria, updated';
GO

IF NOT EXISTS (SELECT [name]
			  FROM [sys].[indexes]
			  WHERE [name] = 'PKI_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria NOT found, creating';
	   CREATE UNIQUE CLUSTERED INDEX [PKI_EDW_BiometricViewRejectCriteria] ON [dbo].[EDW_BiometricViewRejectCriteria]
	   (
	   [AccountCD] ASC ,
	   [ItemCreatedWhen] ASC ,
	   [SiteID] ASC
	   );
    END;
ELSE
    BEGIN
	   PRINT 'PKI_EDW_BiometricViewRejectCriteria created';
    END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Insert_EDW_BiometricViewRejectCriteria') 
    BEGIN
	   PRINT 'proc_Insert_EDW_BiometricViewRejectCriteria found, updating.';
	   DROP PROCEDURE [proc_Insert_EDW_BiometricViewRejectCriteria];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Insert_EDW_BiometricViewRejectCriteria';
    END;
GO

CREATE PROC [proc_Insert_EDW_BiometricViewRejectCriteria] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime , @SiteID AS int) 
AS
BEGIN

    IF @SiteID IS NULL
	   BEGIN
		  SET @SiteID = -1;
	   END;

    DECLARE @iCnt integer = 0;
    SET @iCnt = (SELECT COUNT (*) 
			    FROM [EDW_BiometricViewRejectCriteria]
			    WHERE [AccountCD] = @AccountCD
				 AND [SiteID] = @SiteID) ;
    IF @iCnt <= 0
	   BEGIN
		  INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]
		  ([AccountCD]
		 , [ItemCreatedWhen]
		 , [SiteID]
		  ) 
		  VALUES
		  (@AccountCD
		  , @ItemCreatedWhen
		  , @SiteID
		  );
		  PRINT 'ADDED ' + @AccountCD + ' to EDW_BiometricViewRejectCriteria.';
	   END;
    ELSE
	   BEGIN
		  PRINT 'Account ' + @AccountCD + ' already defined to EDW_BiometricViewRejectCriteria.';
	   END;
END;

GO

IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Acct];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Acct';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Acct] (
	  @AccountCD AS nvarchar (50) , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [AccountCD] = @AccountCD
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;
END;

GO
IF EXISTS (SELECT [name]
		   FROM [sys].[procedures]
		   WHERE [name] = 'proc_Delete_EDW_BiometricViewRejectCriteria_Site') 
    BEGIN
	   PRINT 'proc_Delete_EDW_BiometricViewRejectCriteria_Site  found, updating.';
	   DROP PROCEDURE [proc_Delete_EDW_BiometricViewRejectCriteria_Site];
    END;
ELSE
    BEGIN
	   PRINT 'Creating proc_Delete_EDW_BiometricViewRejectCriteria_Site';
    END;

GO

CREATE PROC [proc_Delete_EDW_BiometricViewRejectCriteria_Site] (
	  @SiteID AS int , @ItemCreatedWhen AS datetime) 
AS
BEGIN
    DELETE FROM [dbo].[EDW_BiometricViewRejectCriteria]
	 WHERE [SiteID] = @SiteID
	   AND [ItemCreatedWhen] = @ItemCreatedWhen;

END;
GO

IF EXISTS (SELECT [name]
		   FROM [sys].[views]
		   WHERE [name] = 'view_EDW_BioMetrics') 
    BEGIN
	   PRINT 'Removing current view_EDW_BioMetrics.';
	   DROP VIEW [view_EDW_BioMetrics];
    END;
GO
PRINT 'Creating view_EDW_BioMetrics.';
GO

CREATE VIEW [dbo].[view_EDW_BioMetrics]
AS
--*****************************************************************************************************************************************
--************** TEST Criteria and Results for view_EDW_BioMetrics ************************************************************************
--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01',17  )  
--NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

-- select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9

--select * from view_EDW_BioMetrics	 where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
--select * from view_Hfit_BioMetrics where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 

--select * from view_EDW_BioMetrics	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 
--select * from view_EDW_BioMetrics	where AccountCD = 'peaboOK dy' and EventDate < '2013-12-01 00:00:00.000'		: 9 

--select count(*) from view_EDW_BioMetrics		--NO REJECT FILTER : 136348
--select count(*) from view_EDW_BioMetrics		--REJECT FILTER ON : 136339 == 9 GOOD TEST

--select count(*) from view_Hfit_BioMetrics	:136393
--select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348

--NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014

--truncate table EDW_BiometricViewRejectCriteria

--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01',-1)         
--NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where ItemCreatedWhen < '2013-12-01' and AccountCD = 'peabody' returns 1034
--		so the number should be 43814 - 1034 = 42780 with AccountCD = 'peabody' and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
--		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
--GO	--Tested by wdm on 11.21.2014

--	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.

-- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Added the EDW_BiometricViewRejectCriteria to allow selective rejection of historical records
-- 01.19.2014 - Prepared for Simpson Willams

--*****************************************************************************************************************************************
SELECT DISTINCT
--HFit_UserTracker
[HFUT].[UserID]
, [cus].[UserSettingsUserGUID] AS [UserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast(NULL as datetime) AS [CreatedDate]
, cast(NULL as datetime) AS [ModifiedDate]
, NULL AS [Notes]
, NULL AS [IsProfessionallyCollected]
, NULL AS [EventDate]
, 'Not Build Yet' AS [EventName]

--HFit_TrackerWeight
, NULL AS [PPTWeight]

--HFit_TrackerHbA1C
, NULL AS [PPTHbA1C]

--HFit_TrackerCholesterol
, NULL AS [Fasting]
, NULL AS [HDL]
, NULL AS [LDL]
, NULL AS [Ratio]
, NULL AS [Total]
, NULL AS [Triglycerides]

--HFit_TrackerBloodSugarandGlucose
, NULL AS [Glucose]
, NULL AS [FastingState]

--HFit_TrackerBloodPressure
, NULL AS [Systolic]
, NULL AS [Diastolic]

--HFit_TrackerBodyFat
, NULL AS [PPTBodyFatPCT]

--HFit_TrackerBMI
, NULL AS [BMI]

--HFit_TrackerBodyMeasurements
, NULL AS [WaistInches]
, NULL AS [HipInches]
, NULL AS [ThighInches]
, NULL AS [ArmInches]
, NULL AS [ChestInches]
, NULL AS [CalfInches]
, NULL AS [NeckInches]

--HFit_TrackerHeight
, NULL AS [Height]

--HFit_TrackerRestingHeartRate
, NULL AS [HeartRate]
, --HFit_TrackerShots
NULL AS [FluShot]
, NULL AS [PneumoniaShot]

--HFit_TrackerTests
, NULL AS [PSATest]
, NULL AS [OtherExam]
, NULL AS [TScore]
, NULL AS [DRA]
, NULL AS [CotinineTest]
, NULL AS [ColoCareKit]
, NULL AS [CustomTest]
, NULL AS [CustomDesc]
, NULL AS [CollectionSource]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFUT].[ItemCreatedWhen] = COALESCE ([HFUT].[ItemModifiedWhen] , [hfut].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFUT].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFUT].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, 0   AS [TrackerCollectionSourceID]
, [HFUT].[itemid]
, 'HFit_UserTracker' AS [TBL]
, NULL AS [VendorID]		--VENDOR.ItemID as VendorID
, NULL AS [VendorName]		--VENDOR.VendorName
  FROM
	  [dbo].[HFit_UserTracker] AS [HFUT]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [hfut].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
  --left outer join HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND [HFUT].[ItemCreatedWhen] < [ItemCreatedWhen]) 
	   --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
    AND [HFUT].[ItemCreatedWhen] IS NOT NULL		--Add per Robert and Laura 12.4.2014

UNION ALL
SELECT distinct
[hftw].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTW].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFTW].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, [HFTW].[Notes]
, [HFTW].[IsProfessionallyCollected]
, cast([HFTW].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, [hftw].Value AS [PPTWeight]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTW].[ItemCreatedWhen] = COALESCE ([HFTW].[ItemModifiedWhen] , [HFTW].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTW].[ItemCreatedWhen] as datetime) as ItemCreatedWhen
, cast([HFTW].[ItemModifiedWhen] as datetime) as ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTW].[itemid]
, 'HFit_TrackerWeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerWeight] AS [HFTW]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTW].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTW].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTW].[VendorID] = [VENDOR].[ItemID]
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTW].[EventDate] , [HFTW].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTW].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTW].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014			

UNION ALL
SELECT distinct
[HFTHA].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTHA].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTHA].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTHA].[Notes]
, [HFTHA].[IsProfessionallyCollected]
, cast([HFTHA].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, [HFTHA].Value AS [PPTHbA1C]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTHA].[ItemCreatedWhen] = COALESCE ([HFTHA].[ItemModifiedWhen] , [HFTHA].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTHA].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTHA].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTHA].[itemid]
, 'HFit_TrackerHbA1c' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHbA1c] AS [HFTHA]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTHA].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTHA].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTHA].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTHA].[EventDate] , [HFTHA].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTHA].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTHA].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTC].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTC].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTC].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTC].[Notes]
, [HFTC].[IsProfessionallyCollected]
, cast([HFTC].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, [HFTC].[Fasting]
, [HFTC].[HDL]
, [HFTC].[LDL]
, [HFTC].[Ratio]
, [HFTC].[Total]
, [HFTC].[Tri]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTC].[ItemCreatedWhen] = COALESCE ([HFTC].[ItemModifiedWhen] , [HFTC].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTC].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTC].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTC].[itemid]
, 'HFit_TrackerCholesterol' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerCholesterol] AS [HFTC]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTC].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTC].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTC].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTC].[EventDate] , [HFTC].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTC].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTC].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBSAG].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBSAG].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBSAG].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBSAG].[Notes]
, [HFTBSAG].[IsProfessionallyCollected]
, cast([HFTBSAG].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBSAG].[Units]
, [HFTBSAG].[FastingState]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBSAG].[ItemCreatedWhen] = COALESCE ([HFTBSAG].[ItemModifiedWhen] , [HFTBSAG].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBSAG].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBSAG].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBSAG].[itemid]
, 'HFit_TrackerBloodSugarAndGlucose' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodSugarAndGlucose] AS [HFTBSAG]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBSAG].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBSAG].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBSAG].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBSAG].[EventDate] , [HFTBSAG].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBSAG].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBSAG].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBP].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBP].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBP].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBP].[Notes]
, [HFTBP].[IsProfessionallyCollected]
, cast([HFTBP].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBP].[Systolic]
, [HFTBP].[Diastolic]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBP].[ItemCreatedWhen] = COALESCE ([HFTBP].[ItemModifiedWhen] , [HFTBP].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBP].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBP].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBP].[itemid]
, 'HFit_TrackerBloodPressure' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBloodPressure] AS [HFTBP]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBP].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBP].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBP].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBP].[EventDate] , [HFTBP].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBP].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBP].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBF].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBF].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBF].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBF].[Notes]
, [HFTBF].[IsProfessionallyCollected]
, cast([HFTBF].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBF].Value AS [PPTBodyFatPCT]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBF].[ItemCreatedWhen] = COALESCE ([HFTBF].[ItemModifiedWhen] , [HFTBF].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBF].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBF].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBF].[itemid]
, 'HFit_TrackerBodyFat' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyFat] AS [HFTBF]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBF].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBF].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBF].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBF].[EventDate] , [HFTBF].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBF].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBF].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTB].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTB].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTB].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTB].[Notes]
, [HFTB].[IsProfessionallyCollected]
, cast([HFTB].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTB].[BMI]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTB].[ItemCreatedWhen] = COALESCE ([HFTB].[ItemModifiedWhen] , [HFTB].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTB].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTB].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTB].[itemid]
, 'HFit_TrackerBMI' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBMI] AS [HFTB]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTB].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTB].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTB].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTB].[EventDate] , [HFTB].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTB].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTB].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTBM].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTBM].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBM].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTBM].[Notes]
, [HFTBM].[IsProfessionallyCollected]
, cast([HFTBM].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTBM].[WaistInches]
, [HFTBM].[HipInches]
, [HFTBM].[ThighInches]
, [HFTBM].[ArmInches]
, [HFTBM].[ChestInches]
, [HFTBM].[CalfInches]
, [HFTBM].[NeckInches]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTBM].[ItemCreatedWhen] = COALESCE ([HFTBM].[ItemModifiedWhen] , [HFTBM].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTBM].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTBM].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTBM].[itemid]
, 'HFit_TrackerBodyMeasurements' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerBodyMeasurements] AS [HFTBM]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTBM].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTBM].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTBM].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTBM].[EventDate] , [HFTBM].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTBM].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTBM].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTH].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTH].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTH].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTH].[Notes]
, [HFTH].[IsProfessionallyCollected]
, cast([HFTH].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTH].[Height]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTH].[ItemCreatedWhen] = COALESCE ([HFTH].[ItemModifiedWhen] , [HFTH].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTH].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTH].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTH].[itemid]
, 'HFit_TrackerHeight' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerHeight] AS [HFTH]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTH].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTH].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTH].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTH].[EventDate] , [HFTH].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTH].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTH].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014
UNION ALL
SELECT distinct
[HFTRHR].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTRHR].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTRHR].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTRHR].[Notes]
, [HFTRHR].[IsProfessionallyCollected]
, cast([HFTRHR].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTRHR].[HeartRate]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTRHR].[ItemCreatedWhen] = COALESCE ([HFTRHR].[ItemModifiedWhen] , [HFTRHR].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTRHR].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTRHR].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTRHR].[itemid]
, 'HFit_TrackerRestingHeartRate' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerRestingHeartRate] AS [HFTRHR]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTRHR].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTRHR].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTRHR].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTRHR].[EventDate] , [HFTRHR].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTRHR].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTRHR].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTS].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTS].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTS].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTS].[Notes]
, [HFTS].[IsProfessionallyCollected]
, cast([HFTS].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTS].[FluShot]
, [HFTS].[PneumoniaShot]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTS].[ItemCreatedWhen] = COALESCE ([HFTS].[ItemModifiedWhen] , [HFTS].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTS].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTS].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTS].[itemid]
, 'HFit_TrackerShots' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerShots] AS [HFTS]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTS].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTS].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTS].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTS].[EventDate] , [HFTS].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTS].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTS].[EventDate] IS NOT NULL)		--Add per RObert and Laura 12.4.2014

UNION ALL
SELECT distinct
[HFTT].[UserID]
, [cus].[UserSettingsUserGUID]
, [cus].[HFitUserMpiNumber]
, [cus2].[SiteID]
, [cs].[SiteGUID]
, cast([HFTT].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTT].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTT].[Notes]
, [HFTT].[IsProfessionallyCollected]
, cast([HFTT].[EventDate] as datetime ) as EventDate
, 'Not Build Yet' AS [EventName]
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, NULL
, [HFTT].[PSATest]
, [HFTT].[OtherExam]
, [HFTT].[TScore]
, [HFTT].[DRA]
, [HFTT].[CotinineTest]
, [HFTT].[ColoCareKit]
, [HFTT].[CustomTest]
, [HFTT].[CustomDesc]
, [HFTCS].[CollectionSourceName_External]
, [HFA].[AccountID]
, [HFA].[AccountCD]
, CASE
	 WHEN [HFTT].[ItemCreatedWhen] = COALESCE ([HFTT].[ItemModifiedWhen] , [HFTT].[ItemCreatedWhen]) 
	 THEN 'I'
	 ELSE 'U'
  END AS [ChangeType]
, cast([HFTT].[ItemCreatedWhen] as datetime) ItemCreatedWhen
, cast([HFTT].[ItemModifiedWhen] as datetime) ItemModifiedWhen
, [HFTCS].[TrackerCollectionSourceID]
, [HFTT].[itemid]
, 'HFit_TrackerTests' AS [TBL]
, [VENDOR].[ItemID] AS [VendorID]
, [VENDOR].[VendorName]
  FROM
	  [dbo].[HFit_TrackerTests] AS [HFTT]
		 INNER JOIN [dbo].[HFit_TrackerCollectionSource] AS [HFTCS]
			ON [HFTT].[TrackerCollectionSourceID] = [HFTCS].[TrackerCollectionSourceID]
		 INNER JOIN [dbo].[CMS_UserSettings] AS [CUS]
			ON [HFTT].[UserID] = [cus].[UserSettingsUserID]
		 INNER JOIN [dbo].[CMS_UserSite] AS [CUS2]
			ON [cus].[UserSettingsUserID] = [cus2].[UserID]
		 INNER JOIN [dbo].[CMS_Site] AS [CS]
			ON [CUS2].[SiteID] = [CS].[SiteID]
		 INNER JOIN [dbo].[HFit_Account] AS [HFA]
			ON [cs].[SiteID] = [HFA].[SiteID]
		 LEFT OUTER JOIN [HFit_LKP_TrackerVendor] AS [VENDOR]
			ON [HFTT].[VendorID] = [VENDOR].[ItemID]
  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
  WHERE [CS].[SITEID] NOT IN (SELECT [SiteID]
						  FROM [EDW_BiometricViewRejectCriteria]
						  WHERE COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND [HFA].[AccountCD] NOT IN (SELECT [AccountCD]
							 FROM [EDW_BiometricViewRejectCriteria]
							 WHERE [HFA].[AccountCD] = [AccountCD]
							   AND COALESCE ([HFTT].[EventDate] , [HFTT].[ItemCreatedWhen]) < [ItemCreatedWhen]) 
    AND ([HFTT].[ItemCreatedWhen] IS NOT NULL
	 OR [HFTT].[EventDate] IS NOT NULL);		--Add per RObert and Laura 12.4.2014

--HFit_TrackerBMI
--HFit_TrackerBodyMeasurements
--HFit_TrackerHeight
--HFit_TrackerRestingHeartRate
--HFit_TrackerShots
--HFit_TrackerTests

GO

PRINT 'Created view_EDW_BioMetrics: ' + CAST (GETDATE () AS nvarchar (50)) ;
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_BioMetrics.sql';
GO

----***************************************************************************************************************************
----** REMOVE THE INSERTS AFTER INTITAL LOAD
----***************************************************************************************************************************
--truncate table EDW_BiometricViewRejectCriteria ;
--go 
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'trstmark','11/4/2013',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'entergy','1/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'mcwp','1/27/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'stateneb','4/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'jnj','5/28/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'coopers','7/1/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'cnh','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'amat','8/4/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'dupont','8/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'ejones','9/3/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'avera','9/15/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'sprvalu','9/18/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'firstgrp','10/6/2014',-1) ;
--GO
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'rexnord','12/2/2014',-1) ;
--GO
PRINT '***** COMPLETED : view_EDW_BioMetrics.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
print ('Processing: view_EDW_RewardTriggerParameters ') ;
go

if exists(select NAME from sys.VIEWS where NAME = 'view_EDW_RewardTriggerParameters')
BEGIN
	drop view view_EDW_RewardTriggerParameters ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_RewardTriggerParameters]
--	TO [EDWReader_PRD]
--GO


--*******************************************************************************************************************
--8/7/2014  VHFRTJ.DocumentGuid		  --WDM Added in case needed
--8/7/2014  VHFRTJ.NodeGuid			  --WDM Added in case needed
--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardTriggerParameter_DocumentModifiedWhen
--11.17.2014 : (wdm) John C. found that Spanish was being brought across in TriggerName and 
--				ParameterDisplayName. Found that View_HFit_RewardTrigger_Joined has no way to limit the 
--				returned data to Spanish. Created a new view, View_EDW_RewardProgram_Joined, and provided 
--				a FILTER on Document Culture. The, added Launguage fitlers as: 
--					where VHFRTJ.DocumentCulture = 'en-US' AND VHFRTPJ.DocumentCulture = 'en-US'
--				This appears to have eliminated the Spanish.
-- 03.03.2015 : (Dale/Natahn) no changes required.
-- 04.12.2015 : (WDM) In order to implement change tracking on this view, a STAGING table will simply be 
--			 dropped and recreated everytime using this view. It is too small to worry about otherwise.
--SELECT * FROM [view_EDW_RewardTriggerParameters]
--*******************************************************************************************************************
create VIEW [dbo].[view_EDW_RewardTriggerParameters]
AS
--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
	SELECT distinct
		cs.SiteGUID															 --CMS_Site
		, VHFRTJ.RewardTriggerID													 --HFit_RewardTrigger
		, VHFRTJ.TriggerName													 --HFit_RewardTrigger
		, HFLRTPO.RewardTriggerParameterOperatorLKPDisplayName							 --HFit_LKP_RewardTriggerParameterOperator 
		, VHFRTPJ.ParameterDisplayName											 --HFit_RewardTriggerParameter
		, VHFRTPJ.RewardTriggerParameterOperator									 --HFit_RewardTriggerParameter
		, VHFRTPJ.Value														 --HFit_RewardTriggerParameter
		, hfa.AccountID														 --HFit_Account
		, hfa.AccountCD														 --HFit_Account
		, CASE	WHEN CAST(VHFRTJ.DocumentCreatedWhen AS DATE) = CAST(VHFRTJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType		
		, VHFRTJ.DocumentGuid													 --CMS_Document
		, VHFRTJ.NodeGuid														 --CMS_Document
		, cast(VHFRTJ.DocumentCreatedWhen as datetime) as DocumentCreatedWhen				 --CMS_Document
		, cast(VHFRTJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen			 --CMS_Document
		, cast(VHFRTPJ.DocumentModifiedWhen  as datetime) as RewardTriggerParameter_DocumentModifiedWhen	  	 --CMS_Document
		--, cast(VHFRTPJ.documentculture  as datetime) as documentculture_VHFRTPJ							 --CMS_Document
		--, cast(VHFRTJ.documentculture  as datetime) as documentculture_VHFRTJ								 --CMS_Document
		  , VHFRTPJ.documentculture as documentculture_VHFRTPJ							 --CMS_Document
		, VHFRTJ.documentculture  as documentculture_VHFRTJ								 --CMS_Document
	FROM
		dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ 
		--dbo.[View_EDW_RewardProgram_Joined] AS VHFRTJ 		
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ  ON vhfrtj.NodeID = VHFRTPJ.NodeParentID
	INNER JOIN dbo.HFit_LKP_RewardTriggerParameterOperator AS HFLRTPO  ON VHFRTPJ.RewardTriggerParameterOperator = HFLRTPO.RewardTriggerParameterOperatorLKPID
	INNER JOIN dbo.CMS_Site AS CS  ON VHFRTJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA  ON cs.SiteID = HFA.SiteID
	where VHFRTJ.DocumentCulture = 'en-US'
	AND VHFRTPJ.DocumentCulture = 'en-US'
      

GO


  --  
  --  
GO 
print('***** Created: view_EDW_RewardTriggerParameters.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing: view_EDW_HealthAssesmentClientView ';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_HealthAssesmentClientView') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesmentClientView;
    END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO

--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--02.04.2015 (wdm) #48828 added , HACampaign.BiometricCampaignStartDate, 
--		  HACampaign.BiometricCampaignEndDate, HACampaign.CampaignStartDate, 
--		  HACampaign.CampaignEndDate, HACampaign.Name, 
--		  HACampaign.NodeGuid as CampaignNodeGuid
--02.05.2015 Ashwin and I reviewed and approved
-- select top 100 * from view_EDW_HealthAssesmentClientView
--03.27.2015 ( Sowmiya V) - made changes to the view to look at the HealthAssesmentID 
--  only in the join condition.
--  The fix was needed to handle the SR#51281: Platform CampaignNodeGuid missing. 
--	   for view view_EDW_HealthAssesmentClientView
--  Leaving the old code as commented with notes. 
-- 03.13.2015 - (WDM) set the view up for change tracking - the SIMPLE version that does not 
--			 require change tracking tables to be involved.
--select count(*) from view_EDW_HealthAssesmentClientView
--SELECT * FROM   INFORMATION_SCHEMA.VIEWS WHERE  VIEW_DEFINITION like '%view_EDW_HealthAssesmentClientView%'
--******************************************************************************
CREATE VIEW dbo.view_EDW_HealthAssesmentClientView
AS SELECT 
          HFitAcct.AccountID
        , HFitAcct.AccountCD
        , HFitAcct.AccountName
        , HFitAcct.ItemGUID AS ClientGuid
        , CMSSite.SiteGUID
        , NULL AS CompanyID
        , NULL AS CompanyGUID
        , NULL AS CompanyName
        , HAJoined.DocumentName
        , cast(HACampaign.DocumentPublishFrom as datetime) AS HAStartDate
        , cast(HACampaign.DocumentPublishTo as datetime) AS HAEndDate
        , HACampaign.NodeSiteID
        , HAAssessmentMod.Title
        , HAAssessmentMod.CodeName
        , HAAssessmentMod.IsEnabled
        , CASE
              WHEN CAST (HACampaign.DocumentCreatedWhen AS date) = CAST (HACampaign.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , cast(HACampaign.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
        , cast(HACampaign.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
        , cast(HAAssessmentMod.DocumentModifiedWhen  as datetime) AS AssesmentModule_DocumentModifiedWhen     --09.11.2014 (wdm) added to facilitate EDW last mod date
        , HAAssessmentMod.DocumentCulture AS DocumentCulture_HAAssessmentMod
        , HACampaign.DocumentCulture AS DocumentCulture_HACampaign
        , HAJoined.DocumentCulture AS DocumentCulture_HAJoined
        , cast(HACampaign.BiometricCampaignStartDate as datetime)as BiometricCampaignStartDate
        , cast(HACampaign.BiometricCampaignEndDate as datetime)as BiometricCampaignEndDate
        , cast(HACampaign.CampaignStartDate as datetime)as CampaignStartDate
        , cast(HACampaign.CampaignEndDate as datetime)as CampaignEndDate
        , HACampaign.Name
        , HACampaign.NodeGuid AS CampaignNodeGuid
        , HACampaign.HACampaignID
          FROM
               dbo.View_HFit_HACampaign_Joined AS HACampaign
                   INNER JOIN dbo.CMS_Site AS CMSSite
                       ON HACampaign.NodeSiteID = CMSSite.SiteID
                   INNER JOIN dbo.HFit_Account AS HFitAcct
                       ON HACampaign.NodeSiteID = HFitAcct.SiteID
                   INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined
                       ON HACampaign.HealthAssessmentID = HAJoined.DocumentID      --  added line to handle    SR #51281   
                          -- ON CASE ----03.27.2015 - Commented code to release the SR #51281
                          --WHEN [HACampaign].[HealthAssessmentConfigurationID] < 0
                          --THEN [HACampaign].[HealthAssessmentID]
                          --ELSE [HACampaign].[HealthAssessmentConfigurationID]
                          --END = HAJoined.DocumentID
                      AND HAJoined.DocumentCulture = 'en-US'
                   INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod
                       ON HAJoined.nodeid = HAAssessmentMod.NodeParentID
                      AND HAAssessmentMod.DocumentCulture = 'en-US'
     WHERE HACampaign.DocumentCulture = 'en-US';


GO

PRINT 'Created: view_EDW_HealthAssesmentClientView ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentClientView.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go




go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

GO
print('Creating view_EDW_HealthInterestList'); 
GO

if exists(select name from sys.views where name = 'view_EDW_HealthInterestList')
BEGIN 
	drop view view_EDW_HealthInterestList ;
END
go

CREATE VIEW [dbo].[view_EDW_HealthInterestList]
AS
	--12/03/2014 (wdm) this view was created by Chad Gurka and passed over to Team P to incloude into the build
	SELECT
		CHA.CoachingHealthAreaID AS HealthAreaID
		,CHA.NodeID
		,CHA.NodeGuid
		,A.AccountCD
		,CHA.NodeName AS HealthAreaName
		,CHA.HealthAreaDescription
		,CHA.CodeName
		,cast(CHA.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
		,cast(CHA.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
	FROM
		View_HFit_CoachingHealthArea_Joined AS CHA
		JOIN HFit_Account AS A ON A.SiteID = CHA.NodeSiteID
	WHERE DocumentCulture = 'en-us'

GO
print('Created view_EDW_HealthInterestList'); 
GO
  --  
  --  
GO 
print('***** FROM: view_EDW_HealthInterestList.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


--select * From HFit_LKP_HES_AwardType
--select * From HFit_LKP_RewardTrigger

GO
PRINT 'FROM view_EDW_Awards';
PRINT 'Creating view_EDW_Awards';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_EDW_Awards') 
    BEGIN
        DROP VIEW
             view_EDW_Awards;
    END;
GO
CREATE VIEW view_EDW_Awards
AS

--*************************************************************************************
-- 2.3.2015 : WDM - Created the initial view for Awards (HEW)
-- 2.3.2015 : WDM - Laura B. had objections as to how the data was pulled, Nate agreed
--					to look at it again.
--*************************************************************************************

SELECT
       AWARD.ItemID
     , AWARD.ItemCreatedBy
     , CAST (AWARD.ItemCreatedWhen AS datetime) AS ItemCreatedWhen
     , AWARD.ItemModifiedBy
     , CAST (AWARD.ItemModifiedWhen AS datetime) AS ItemModifiedWhen
     , AWARD.ItemOrder
     , AWARD.ItemGUID
     , AWARD.UserID
     , CAST (AWARD.EventDate AS datetime) AS EventDate
     , AWARD.RewardTriggerID
     , AWARD.[Value]
     , AWARD.Challenge_GUID
     , AWARD.HESAwardID
     , ATYPE.AwardType
     , ATRIGGER.RewardTriggerLKPName
     , ATRIGGER.RewardTriggerRewardActivityLKPID
     , ATRIGGER.RewardTriggerLKPDisplayName
     , ATRIGGER.HESCode
       FROM
            HFit_HES_Award AS AWARD
                JOIN HFit_LKP_RewardTrigger AS ATRIGGER
                ON AWARD.RewardTriggerID = ATRIGGER.RewardTriggerLKPID
                JOIN HFit_LKP_HES_AwardType AS ATYPE
                ON AWARD.HESAwardID = ATYPE.itemID;
GO
PRINT 'Created view_EDW_Awards';
GO




go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

print ('Processing: view_EDW_ClientCompany ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ClientCompany')
BEGIN
	drop view view_EDW_ClientCompany ;
END
GO



CREATE VIEW [dbo].[view_EDW_ClientCompany]
AS
--************************************************************
--One of the few views in the system that is not nested. 
--It combines the Account, Site and Company data.
--Last Tested: 09/04/2014 WDM
--WDM 9.10.2014 - verified dates were available to the EDW
--************************************************************
	SELECT
		hfa.AccountID
		, HFA.AccountCD
		, HFA.AccountName
		, cast(HFA.ItemCreatedWhen as datetime) as AccountCreated
		, cast(HFA.ItemModifiedWhen as datetime) as AccountModified
		, HFA.ItemGUID AccountGUID
		, CS.SiteID
		, CS.SiteGUID
		, cast(CS.SiteLastModified  as datetime) as SiteLastModified
		, HFC.CompanyID
		, HFC.ParentID
		, HFC.CompanyName
		, HFC.CompanyShortName
		, HFC.CompanyStartDate
		, HFC.CompanyEndDate
		, HFC.CompanyStatus
		, CASE	WHEN CAST(hfa.ItemCreatedWhen AS DATE) = CAST(HFA.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, NULL AS CompanyCreated
		, NULL AS CompanyModified
	FROM
		dbo.HFit_Account AS HFA
	INNER JOIN dbo.CMS_Site AS CS ON HFA.SiteID = cs.SiteID
	LEFT OUTER JOIN dbo.HFit_Company AS HFC ON HFA.AccountID = hfc.AccountID






GO


  --  
  --  
GO 
print('***** FROM: view_EDW_ClientCompany.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
print ('Processing: view_EDW_Coaches ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_Coaches')
BEGIN
	drop view view_EDW_Coaches ;
END
GO

-- select count(*)from view_EDW_Coaches
-- select * from view_EDW_Coaches
--****************************************************
-- Verified last mod date available to EDW 9.10.2014
--****************************************************
CREATE VIEW [dbo].[view_EDW_Coaches]

AS

SELECT distinct
    cu.UserGUID
   ,cs.SiteGUID
   ,HFA.AccountID
   ,HFA.AccountCD
   ,CoachID
   ,hfc.LastName
   ,hfc.FirstName
   ,cast(hfc.StartDate as datetime) as StartDate
   ,hfc.Phone
   ,hfc.email
   ,hfc.Supervisor
   ,hfc.SuperCoach
   ,hfc.MaxParticipants
   ,hfc.Inactive
   ,hfc.MaxRiskLevel
   ,hfc.Locked
   ,cast(hfc.TimeLocked as datetime) as TimeLocked
   ,hfc.terminated
   ,hfc.APMaxParticipants
   ,hfc.RNMaxParticipants
   ,hfc.RNPMaxParticipants
   ,hfc.Change_Type
   ,cast(hfc.Last_Update_Dt as datetime) as Last_Update_Dt
FROM
    dbo.HFit_Coaches AS HFC
LEFT OUTER JOIN dbo.CMS_User AS CU ON hfc.KenticoUserID = cu.UserID
LEFT OUTER JOIN dbo.CMS_UserSite AS CUS ON cu.userid = cus.UserID
LEFT OUTER JOIN dbo.CMS_Site AS CS ON CS.SiteID = CUS.SiteID
LEFT OUTER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = hfa.SiteID

GO


  --  
  --  
GO 
print('***** FROM: view_EDW_Coaches.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

print ('Processing: view_EDW_CoachingDefinition ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDefinition')
BEGIN
	drop view view_EDW_CoachingDefinition ;
END
GO


--GRANT SELECT
--	ON [dbo].[view_EDW_CoachingDefinition]
--	TO [EDWReader_PRD]
--GO

-- select count(*) from view_EDW_CoachingDefinition
CREATE VIEW [dbo].[view_EDW_CoachingDefinition]
AS
--********************************************************************************************************
--8/7/2014 - added DocumentGuid 
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
--11.17.2014 - (wdm) John Croft found an issue with multiple languages being returned.
--		View_EDW_CoachingDefinition pulls its data from a nested view View_HFit_Tobacco_Goal_Joined. I added 
--		a Document Culture filter on the SELECT STATEMENT pulling the data from View_HFit_Tobacco_Goal_Joined.
--		In LAB DB, when the view is executed W/O the filter, I get 90 rows. When executed with the filter, I 
--		get 89 rows. This would indicate the filter can be applied at the SELCT statement level. The view has 
--		the change applied and is ready to be regenerated. Also, I needed to add a language filter to 
--		View_HFit_Goal_Joined. Additionally, I allow the view to return the Document Culture as a column so 
--		that we can see the associated language. This can be removed if not wanted, but for troubleshooting 
--		it is useful.
--********************************************************************************************************
SELECT
	GJ.GoalID
	, GJ.DocumentGuid	--, GJ.DocumentID
	, GJ.NodeSiteID
	, cs.SiteGUID
	, GJ.GoalImage
	, GJ.Goal
	, dbo.udf_StripHTML(GJ.GoalText) GoalText --
	, dbo.udf_StripHTML(GJ.GoalSummary) GoalSummary --
	, GJ.TrackerAssociation  --GJ.TrackerAssociation
	, GJ.GoalFrequency
	, HFLF.FrequencySingular
	, HFLF.FrequencyPlural
	, GJ.GoalUnitOfMeasure
	, HFLUOM.UnitOfMeasure
	, GJ.GoalDirection
	, GJ.GoalPrecision
	, GJ.GoalAbsoluteMin
	, GJ.GoalAbsoluteMax
	, dbo.udf_StripHTML(GJ.SetGoalText) SetGoalText --
	, dbo.udf_StripHTML(GJ.HelpText) HelpText --
	, GJ.EvaluationType
	, GJ.CatalogDisplay
	, GJ.AllowModification
	, GJ.ActivityText
	, dbo.udf_StripHTML(GJ.SetGoalModifyText) SetgoalModifyText
	, GJ.IsLifestyleGoal
	, GJ.CodeName
	, CASE	WHEN CAST(gj.DocumentCreatedWhen AS DATE) = CAST(gj.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
	, cast(GJ.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
	, cast(GJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
	, GJ.DocumentCulture
FROM
	(
		SELECT
			VHFGJ.GoalID
			, VHFGJ.DocumentGuid	--, VHFGJ.DocumentID
			, VHFGJ.NodeSiteID
			, VHFGJ.GoalImage
			, VHFGJ.Goal
			, VHFGJ.GoalText
			, VHFGJ.GoalSummary
			, VHFGJ.TrackerNodeGUID as TrackerAssociation  --VHFGJ.TrackerAssociation
			, VHFGJ.GoalFrequency
			, VHFGJ.GoalUnitOfMeasure
			, VHFGJ.GoalDirection
			, VHFGJ.GoalPrecision
			, VHFGJ.GoalAbsoluteMin
			, VHFGJ.GoalAbsoluteMax
			, VHFGJ.SetGoalText
			, VHFGJ.HelpText
			, VHFGJ.EvaluationType
			, VHFGJ.CatalogDisplay
			, VHFGJ.AllowModification
			, VHFGJ.ActivityText
			, VHFGJ.SetGoalModifyText
			, VHFGJ.IsLifestyleGoal
			, VHFGJ.CodeName
			, cast(VHFGJ.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
			, cast(VHFGJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
			, VHFGJ.DocumentCulture
		FROM
			dbo.View_HFit_Goal_Joined AS VHFGJ
			where VHFGJ.DocumentCulture = 'en-US'
		UNION ALL
		SELECT
			VHFTGJ.GoalID
			, VHFTGJ.DocumentGuid	--, VHFTGJ.DocumentID
			, VHFTGJ.NodeSiteID
			, VHFTGJ.GoalImage
			, VHFTGJ.Goal
			, NULL AS GoalText
			, VHFTGJ.GoalSummary
			, VHFTGJ.TrackerNodeGUID as TrackerAssociation  --VHFTGJ.TrackerAssociation
			, VHFTGJ.GoalFrequency
			, NULL AS GoalUnitOfMeasure
			, VHFTGJ.GoalDirection
			, VHFTGJ.GoalPrecision
			, VHFTGJ.GoalAbsoluteMin
			, VHFTGJ.GoalAbsoluteMax
			, NULL AS SetGoalText
			, NULL AS HelpText
			, VHFTGJ.EvaluationType
			, VHFTGJ.CatalogDisplay
			, VHFTGJ.AllowModification
			, VHFTGJ.ActivityText
			, NULL SetGoalModifyText
			, VHFTGJ.IsLifestyleGoal
			, VHFTGJ.CodeName
			, cast(VHFTGJ.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
			, cast(VHFTGJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
			, VHFTGJ.DocumentCulture
		FROM
			dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ
			where VHFTGJ.DocumentCulture = 'en-US'
	) AS GJ
LEFT OUTER JOIN dbo.HFit_LKP_UnitOfMeasure AS HFLUOM ON GJ.GoalUnitOfMeasure = HFLUOM.UnitOfMeasureID
LEFT OUTER JOIN dbo.HFit_LKP_Frequency AS HFLF ON GJ.GoalFrequency = HFLF.FrequencyID
INNER JOIN cms_site AS CS ON gj.nodesiteid = cs.siteid
--INNER JOIN cms_site AS CS ON gj.siteguid = cs.siteguid
WHERE
	gj.DocumentCreatedWhen IS NOT NULL
	AND gj.DocumentModifiedWhen IS NOT NULL 

GO

--select * from view_EDW_CoachingDefinition  --  
  --  
GO 
print('Completed: view_EDW_CoachingDefinition.sql'); 
print('***** FROM: view_EDW_CoachingDefinition.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
print('***** FROM: view_EDW_CoachingDetail.sql'); 
go

print ('Processing: view_EDW_CoachingDetail ') ;
go

if exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
BEGIN
    print ('ANALYZING index CI2_View_CMS_Tree_Joined_Regular');
	drop index View_CMS_Tree_Joined_Regular.CI2_View_CMS_Tree_Joined_Regular;
END
GO

if not exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
BEGIN
    print ('Updating index CI2_View_CMS_Tree_Joined_Regular');

	SET ARITHABORT ON
	SET CONCAT_NULL_YIELDS_NULL ON
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	SET NUMERIC_ROUNDABORT OFF

	CREATE NONCLUSTERED INDEX [CI2_View_CMS_Tree_Joined_Regular] ON [dbo].[View_CMS_Tree_Joined_Regular]
(
	[ClassName] ASC,
	[DocumentForeignKeyValue],
	[DocumentCulture] ASC
)
INCLUDE ( 	[NodeID], [NodeGUID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END
GO

-- select count(*) from view_EDW_CoachingDetail
if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDetail')
BEGIN
	drop view view_EDW_CoachingDetail ;
END
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail]]
--	TO [EDWReader_PRD]
--GO

/* TEST Queries
select * from [view_EDW_CoachingDetail]
select * from [view_EDW_CoachingDetail] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail]
*/

create VIEW [dbo].[view_EDW_CoachingDetail]
AS
--********************************************************************************************
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
-- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923
-- 01.06.2014 (WDM) Tested with team B and found that the data was being returned. Stipulating that 
--					we converted the inner join to left outer join dbo.HFit_GoalOutcome. This 
--					allows data to be returned with the meaning that if NULL HFGO.EvaluationDate
--					is returned, the GOAL may exist without any input/update from the coach or
--					PPT
-- 01.07.2014 (WDM) This also takes care of 47976
--********************************************************************************************
	SELECT	DISTINCT
		HFUG.ItemID
		, HFUG.ItemGUID
		, GJ.GoalID
		, HFUG.UserID
		, cu.UserGUID
		, cus.HFitUserMpiNumber
		, cs.SiteGUID
		, hfa.AccountID
		, hfa.AccountCD
		, hfa.AccountName
		, HFUG.IsCreatedByCoach
		, HFUG.BaselineAmount
		, HFUG.GoalAmount
		, Null As DocumentID
		, HFUG.GoalStatusLKPID
		, HFLGS.GoalStatusLKPName
		, cast(HFUG.EvaluationStartDate as datetime) as EvaluationStartDate
		, cast(HFUG.EvaluationEndDate as datetime) as EvaluationEndDate
		, cast(HFUG.GoalStartDate as datetime) as GoalStartDate
		, HFUG.CoachDescription
		, cast(HFGO.EvaluationDate as datetime) as EvaluationDate
		, HFGO.Passed
		, cast(HFGO.WeekendDate as datetime) as WeekendDate
		, CASE	WHEN CAST(HFUG.ItemCreatedWhen AS DATE) = CAST(HFUG.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, cast(HFUG.ItemCreatedWhen as datetime) as ItemCreatedWhen
		, cast(HFUG.ItemModifiedWhen as datetime) as ItemModifiedWhen
		, GJ.NodeGUID
		, HFUG.CloseReasonLKPID
		, GRC.CloseReason

	FROM
		dbo.HFit_UserGoal AS HFUG WITH ( NOLOCK )
	INNER JOIN (
					SELECT
						VHFGJ.GoalID
						, VHFGJ.NodeID
						, VHFGJ.NodeGUID
						, VHFGJ.DocumentCulture
						, VHFGJ.DocumentGuid
						, VHFGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Goal_Joined AS VHFGJ WITH ( NOLOCK )
					UNION ALL
					SELECT
						VHFTGJ.GoalID
						, VHFTGJ.NodeID
						, VHFTGJ.NodeGUID
						, VHFTGJ.DocumentCulture
						, VHFTGJ.DocumentGuid
						, VHFTGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ WITH ( NOLOCK )
				) AS GJ ON hfug.NodeID = gj.NodeID and GJ.DocumentCulture = 'en-us'		
	left outer join dbo.HFit_GoalOutcome AS HFGO WITH ( NOLOCK ) ON HFUG.ItemID = HFGO.UserGoalItemID	
	INNER JOIN dbo.HFit_LKP_GoalStatus AS HFLGS WITH ( NOLOCK ) ON HFUG.GoalStatusLKPID = HFLGS.GoalStatusLKPID	
	INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON HFUG.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON CU.UserGUID = CUS.UserSettingsUserGUID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cu.UserID = CUS2.UserID	
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = hfa.SiteID
	left outer join HFit_LKP_GoalCloseReason as GRC on GRC.CloseReasonID = HFUG.CloseReasonLKPID
GO

  --  
  --  
GO 
print('***** Created: view_EDW_CoachingDetail'); 
GO 

--Testing History
--1.1.2015: WDM Tested table creation, data entry, and view join
--Testing Criteria
--select * from HFit_LKP_GoalCloseReason
--select * from view_EDW_CoachingDetail
--select * from view_EDW_CoachingDetail where userid in (13470, 107, 13299) and CloseReasonLKPID != 0 
--select * from view_EDW_CoachingDetail where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'
--select * from view_EDW_CoachingDetail where EvaluationDate is null 
--select * from view_EDW_CoachingDetail  where HFitUserMpiNumber in (6238677) and CloseReasonLKPID != 0 
--select * from HFit_UserGoal where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


go
print ('Processing: View_EDW_HealthAssesmentQuestions ') ;
go


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentQuestions')
BEGIN
	drop view View_EDW_HealthAssesmentQuestions ;
END
GO

create VIEW [dbo].[View_EDW_HealthAssesmentQuestions]

AS 
--**********************************************************************************
--09.11.2014 (wdm) Added the DocumentModifiedWhen to facilitate the EDW need to 
--		determine the last mod date of a record.
--10.17.2014 (wdm)
-- view_EDW_HealthAssesmentDeffinition calls 
-- View_EDW_HealthAssesmentQuestions which calls
-- View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
--		and two other JOINED views.
--View view_EDW_HealthAssesmentDeffinition has a filter on document culture of 'EN-US'
--		which limits the retured data to Engoish only.
--Today, John found a number of TITLES in view_EDW_HealthAssesmentDeffinition that were Spanish.
--The problem seems to come from sevel levels of nesting causing intersection data to seep through 
--the EN-US filter if placed at the highest level of a set of nested views.
--I took the filter and applied it to all the joined views within View_EDW_HealthAssesmentQuestions 
--		and the issue seems to have resolved itself.
--10.17.2014 (wdm) Added a filter "DocumentCulture" - the issue appears to be 
--			caused in view view_EDW_HealthAssesmentDeffinition becuase
--			the FILTER at that level on EN-US allows a portion of the intersection 
--			data to be missed for whatever reason. Adding the filter at this level
--			of the nesting seems to omit the non-english titles found by John Croft.
--**********************************************************************************
SELECT 
	VHFHAMCQJ.ClassName AS QuestionType,
	VHFHAMCQJ.Title,
	VHFHAMCQJ.Weight,
	VHFHAMCQJ.IsRequired,
	VHFHAMCQJ.QuestionImageLeft,
	VHFHAMCQJ.QuestionImageRight,
	VHFHAMCQJ.NodeGUID,	
	VHFHAMCQJ.DocumentCulture,
	VHFHAMCQJ.IsEnabled,
	VHFHAMCQJ.IsVisible,
	VHFHAMCQJ.IsStaging,
	VHFHAMCQJ.CodeName,
	VHFHAMCQJ.QuestionGroupCodeName,
	VHFHAMCQJ.NodeAliasPath,
	VHFHAMCQJ.DocumentPublishedVersionHistoryID,
	VHFHAMCQJ.NodeLevel,
	VHFHAMCQJ.NodeOrder,
	VHFHAMCQJ.NodeID,
	VHFHAMCQJ.NodeParentID,
	VHFHAMCQJ.NodeLinkedNodeID, 
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMCQJ.DocumentGuid
	,cast(VHFHAMCQJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH(NOLOCK)
where VHFHAMCQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAMQJ.ClassName AS QuestionType,
	VHFHAMQJ.Title,
	VHFHAMQJ.Weight,
	VHFHAMQJ.IsRequired,
	VHFHAMQJ.QuestionImageLeft,
	VHFHAMQJ.QuestionImageRight,
	VHFHAMQJ.NodeGUID,
	VHFHAMQJ.DocumentCulture,
	VHFHAMQJ.IsEnabled,
	VHFHAMQJ.IsVisible,
	VHFHAMQJ.IsStaging,
	VHFHAMQJ.CodeName,
	VHFHAMQJ.QuestionGroupCodeName,
	VHFHAMQJ.NodeAliasPath,
	VHFHAMQJ.DocumentPublishedVersionHistoryID,
	VHFHAMQJ.NodeLevel,
	VHFHAMQJ.NodeOrder,
	VHFHAMQJ.NodeID,
	VHFHAMQJ.NodeParentID,
	VHFHAMQJ.NodeLinkedNodeID,
	0 AS DontKnowEnabled, 
	'' AS DontKnowLabel,
		(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
	,VHFHAMQJ.DocumentGuid
	,cast(VHFHAMQJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH(NOLOCK)
where VHFHAMQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL 
SELECT 
	VHFHAFFJ.ClassName AS QuestionType,
	VHFHAFFJ.Title,
	VHFHAFFJ.Weight,
	VHFHAFFJ.IsRequired,
	VHFHAFFJ.QuestionImageLeft,
	'' AS QuestionImageRight,
	VHFHAFFJ.NodeGUID,
	VHFHAFFJ.DocumentCulture,
	VHFHAFFJ.IsEnabled,
	VHFHAFFJ.IsVisible,
	VHFHAFFJ.IsStaging,
	VHFHAFFJ.CodeName,
	VHFHAFFJ.QuestionGroupCodeName,
	VHFHAFFJ.NodeAliasPath,
	VHFHAFFJ.DocumentPublishedVersionHistoryID,
	VHFHAFFJ.NodeLevel,
	VHFHAFFJ.NodeOrder,
	VHFHAFFJ.NodeID,
	VHFHAFFJ.NodeParentID,
	VHFHAFFJ.NodeLinkedNodeID,
	VHFHAFFJ.DontKnowEnabled,
	VHFHAFFJ.DontKnowLabel,
	(select pp.NodeOrder from dbo.CMS_Tree pp inner join dbo.CMS_Tree p on p.NodeParentID = pp.NodeID where p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
	,VHFHAFFJ.DocumentGuid
	,cast(VHFHAFFJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen	--(WDM) 09.11.2014 added to facilitate determining document last mod date 
FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH(NOLOCK)
where VHFHAFFJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

GO
print ('Processed: View_EDW_HealthAssesmentQuestions ') ;
go



  --  
  --  
GO 
print('***** FROM: View_EDW_HealthAssesmentQuestions.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go



--use KenticoCMS_Prod1

GO
PRINT 'Processing view_EDW_HealthAssesment';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_EDW_HealthAssesment') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesment;
    END;
GO
--select top 100 * from [view_EDW_HealthAssesment]
CREATE VIEW dbo.view_EDW_HealthAssesment
AS
--********************************************************************************************************
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 00:43:10.
--8/8/2014 - Generated corrected view in DEV
-- Verified last mod date available to EDW 9.10.2014

--09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
--of the EDW to recognize changes to database records based on the last modified date of a row. 
--The views that we are currently using in the database or deeply nested. This means that 
--several base tables are involved in building a single view of data.

--09.30.2014: Verified with John Croft that he does want this view to return multi-languages.
--
--The views were initially designed to recognize a date change based on a record change very 
--high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
--and I recognize that data can change at any level in the hierarchy and those changes must be 
--recognized as well. Currently, that is not the case. With the new modification to the views, 
--changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
--process will be able to realize that a change in this row’s data may affect and intrude into 
--the warehouse.

-- 10.01.2014 - Reviewed by Mark and Dale for use of the GUIDS
-- 10.01.2014 - Reviewed by Mark and Dale for use of Joins and fixed two that were incorrect (Thanks to Mark)

-- 10.23.2014 - (WDM) added two columns for the EDW HAPaperFlg / HATelephonicFlg
--			HAPaperFlg is whether the question was reveived electronically or on paper
--			HATelephonicFlg is whether the question was reveived by telephone or not

-- FIVE Pieces needed per John C. 10.16.2014
--	Document GUID -> HealthAssesmentUserStartedNodeGUID
--	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
--	Category GUID -> Category
--	RiskArea Node Guid -> RiskArea 
--	Question Node Guid -> Question
--	Answer Node Guid -> Answer 

--   10.30.2014 : Sowmiya 
--   The following are the possible values allowed in the HAStartedMode and HACompletedMode columns of the Hfit_HealthAssesmentUserStarted table
--      Unknown = 0, 
--       Paper = 1,  // Paper HA
--       Telephonic = 2, // Telephonic HA
--       Online = 3, // Online HA
--       Ipad = 4 // iPAD
-- 08/07/2014 - (WDM) as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014
-- 09/30/2014 - (WDM) as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
--WDM 10.02.2014 place holder for EDW ETL
--Per John C. 10.16.2014 requested that this be put back into the view.	
--11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
-- 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
-- 11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
--11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
--	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.
-- 12.02.2014 - (wdm)Found that the view was being overwritten between Prod 1 and the copy of Prod 5 / Prod 1. Found a script inside a job on PRod 5 that reverted the view to a previous state. Removed the script and the view migrates correctly (d. miller and m. kimenski)
-- 12.02.2014 - (wdm) Found DUPS in Prod 1 and Prod 2, none in Prod 3. 
-- 12.17.2014 - Added two columns requested by the EDW team as noted by comments next to each column.
-- 12.29.2014 - Stripped HTML out of Title #47619
-- 12.31.2014 - Eliminated negative MPI's in response to CR47516 
-- 01.02.2014 - Tested the removal of negative MPI's in response to CR47516 
--01.27.2015 (WDM) #48941 - Add Client Identifier to View_EDW_Eligibility
--	   In analyzing this requirement, found that the PPT.ClientID is nvarchar (alphanumeric)
--	   and Hfit_Client.ClientID is integer. A bit of a domain/naming issue.
--	   This is NOT needed as the data is already contained in columns [AccountID] and [AccountCD]
--	   NOTE: Added the column [AccountName], just in case it were to be needed later.
--02.04.2015 (WDM) #48828 added:
--	    [HAUserStarted].[HACampaignNodeGUID], VCJ.BiometricCampaignStartDate
--	   , VCJ.BiometricCampaignEndDate, VCJ.CampaignStartDate
--	   , VCJ.CampaignEndDate, VCJ.Name as CampaignName, HACampaignID
-- PER John C. 2.6.2015 - Please comment out all columns except the GUID in the Assesment view.  It will reduce the amount of data coming through the delta process.  Thank you
--, [VHCJ].BiometricCampaignStartDate
--, [VHCJ].BiometricCampaignEndDate
--, [VHCJ].CampaignStartDate
--, [VHCJ].CampaignEndDate
--, [VHCJ].Name as CampaignName 
--, [VHCJ].HACampaignID

/*---------------------------------------
--the below are need in this view 
, HACampaign.BiometricCampaignStartDate
, HACampaign.BiometricCampaignEndDate
, HACampaign.CampaignStartDate
, HACampaign.CampaignEndDate
, HACampaign.Name

or only the 
select * from HAUserStarted
, HACampaign.NodeGuid as CampaignNodeGuid
*/

--02.05.2015 Ashwin and I reviewed and approved
--07.09.2015 (WDM) - Dea and I discussed the need to capture and present the Health Assessment Type.
--				Mark and I discussed how best to do this and the data, basically, was already in 
--				the view. I added the field HealthAssessmentType to the view.
--********************************************************************************************************

SELECT
       HAUserStarted.ItemID AS UserStartedItemID
     , VHAJ.NodeGUID AS HealthAssesmentUserStartedNodeGUID
     , HAUserStarted.UserID
     , CMSUser.UserGUID
     , UserSettings.HFitUserMpiNumber
     , CMSSite.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , ACCT.AccountName
     , CAST (HAUserStarted.HAStartedDt AS datetime) AS HAStartedDt
     , CAST (HAUserStarted.HACompletedDt AS datetime) AS HACompletedDt
     , HAUserModule.ItemID AS UserModuleItemId
     , HAUserModule.CodeName AS UserModuleCodeName
     , HAUserModule.HAModuleNodeGUID
     , VHAJ.NodeGUID AS CMSNodeGuid
     , NULL AS HAModuleVersionID
     , HARiskCategory.ItemID AS UserRiskCategoryItemID
     , HARiskCategory.CodeName AS UserRiskCategoryCodeName
     , HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
     , NULL AS HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
     , HAUserRiskArea.ItemID AS UserRiskAreaItemID
     , HAUserRiskArea.CodeName AS UserRiskAreaCodeName
     , HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
     , NULL AS HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
     , HAUserQuestion.ItemID AS UserQuestionItemID
     , dbo.udf_StripHTML (HAQuestionsView.Title) AS Title			--WDM 47619 12.29.2014
     , HAUserQuestion.HAQuestionNodeGUID	AS HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID and matches to the definition file to get the question. This tells you the question, language agnostic.
     , HAUserQuestion.CodeName AS UserQuestionCodeName
     , NULL AS HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
     , NULL AS HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
     , HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
     , HAUserAnswers.ItemID AS UserAnswerItemID
     , HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
     , NULL AS HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
     , HAUserAnswers.CodeName AS UserAnswerCodeName
     , HAUserAnswers.HAAnswerValue
     , HAUserModule.HAModuleScore
     , HARiskCategory.HARiskCategoryScore
     , HAUserRiskArea.HARiskAreaScore
     , HAUserQuestion.HAQuestionScore
     , HAUserAnswers.HAAnswerPoints
     , HAUserQuestionGroupResults.PointResults
     , HAUserAnswers.UOMCode
     , HAUserStarted.HAScore
     , HAUserModule.PreWeightedScore AS ModulePreWeightedScore
     , HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
     , HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
     , HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
     , HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName
     , CASE
           WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen
               THEN 'I'
           ELSE 'U'
       END AS ChangeType
     , CAST (HAUserAnswers.ItemCreatedWhen AS datetime) AS ItemCreatedWhen
     , CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS ItemModifiedWhen
     , HAUserQuestion.IsProfessionallyCollected
     , CAST (HARiskCategory.ItemModifiedWhen AS datetime) AS HARiskCategory_ItemModifiedWhen
     , CAST (HAUserRiskArea.ItemModifiedWhen AS datetime) AS HAUserRiskArea_ItemModifiedWhen
     , CAST (HAUserQuestion.ItemModifiedWhen AS datetime) AS HAUserQuestion_ItemModifiedWhen
     , CAST (HAUserAnswers.ItemModifiedWhen AS datetime) AS HAUserAnswers_ItemModifiedWhen
     , HAUserStarted.HAPaperFlg
     , HAUserStarted.HATelephonicFlg
     , HAUserStarted.HAStartedMode		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
     , HAUserStarted.HACompletedMode	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

     , VHCJ.DocumentCulture AS DocumentCulture_VHCJ
     , HAQuestionsView.DocumentCulture AS DocumentCulture_HAQuestionsView
     , HAUserStarted.HACampaignNodeGUID AS CampaignNodeGUID
     , CASE
           WHEN HAUserStarted.HADocumentConfigID IS NULL
               THEN 'SHORT_VER'
           WHEN HAUserStarted.HADocumentConfigID IS NOT NULL
               THEN 'LONG_VER'
           ELSE 'UNKNOWN'
       END AS HealthAssessmentType

       FROM
            dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
                 INNER JOIN dbo.CMS_User AS CMSUser
                 ON HAUserStarted.UserID = CMSUser.UserID
                 INNER JOIN dbo.CMS_UserSettings AS UserSettings
                 ON
                    UserSettings.UserSettingsUserID = CMSUser.UserID AND
                    HFitUserMpiNumber >= 0 AND
                    HFitUserMpiNumber IS NOT NULL -- (WDM) CR47516 
                 INNER JOIN dbo.CMS_UserSite AS UserSite
                 ON CMSUser.UserID = UserSite.UserID
                 INNER JOIN dbo.CMS_Site AS CMSSite
                 ON UserSite.SiteID = CMSSite.SiteID
                 INNER JOIN dbo.HFit_Account AS ACCT
                 ON ACCT.SiteID = CMSSite.SiteID
                 INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule
                 ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
                 INNER JOIN View_HFit_HACampaign_Joined AS VHCJ
                 ON
                    VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID AND
                    VHCJ.NodeSiteID = UserSite.SiteID AND
                    VHCJ.DocumentCulture = 'en-US'
                 INNER JOIN View_HFit_HealthAssessment_Joined AS VHAJ
                 ON VHAJ.DocumentID = VHCJ.HealthAssessmentID
                 INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
                 ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
                 INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
                 ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
                 INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion
                 ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
                 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView
                 ON
                    HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID AND
                    HAQuestionsView.DocumentCulture = 'en-US'
                 LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
                 ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
                 INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers
                 ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID
       WHERE UserSettings.HFitUserMpiNumber NOT IN (
       SELECT
              RejectMPICode
              FROM HFit_LKP_EDW_RejectMPI) ;
GO

PRINT 'Processed view_EDW_HealthAssesment';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesment.sql';
GO 





go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

print ('Processing: View_EDW_HealthAssesmentAnswers ') ;
go



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'View_EDW_HealthAssesmentAnswers')
BEGIN
	drop view View_EDW_HealthAssesmentAnswers ;
END
GO


CREATE VIEW [dbo].[View_EDW_HealthAssesmentAnswers]
AS
--********************************************************************************************************
--WDM 8.8.2014 - Created this view in order to add the DocumentGUID as 
--			required by the EDW team. Was having a bit of push-back
--			from the developers, so created this one in order to 
--			expedite filling the need for runnable views for the EDW.
-- Verified last mod date available to EDW 9.10.2014
--********************************************************************************************************
      SELECT
        VHFHAPAJ.ClassName AS AnswerType
       ,VHFHAPAJ.Value
       ,VHFHAPAJ.Points
       ,VHFHAPAJ.NodeGUID
       ,VHFHAPAJ.IsEnabled
       ,VHFHAPAJ.CodeName
	   ,VHFHAPAJ.InputType
       ,VHFHAPAJ.UOM
       ,VHFHAPAJ.NodeAliasPath
       ,VHFHAPAJ.DocumentPublishedVersionHistoryID
       ,VHFHAPAJ.NodeID
       ,VHFHAPAJ.NodeOrder
       ,VHFHAPAJ.NodeLevel
       ,VHFHAPAJ.NodeParentID
       ,VHFHAPAJ.NodeLinkedNodeID
	   ,VHFHAPAJ.DocumentCulture
	   ,VHFHAPAJ.DocumentGuid
	   ,cast(VHFHAPAJ.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
      FROM
        dbo.View_HFit_HealthAssesmentPredefinedAnswer_Joined AS VHFHAPAJ WITH(NOLOCK)
	where VHFHAPAJ.DocumentCulture = 'en-US'

GO

print ('Processed: View_EDW_HealthAssesmentAnswers ') ;
go



  --  
  --  
GO 
print('***** FROM: View_EDW_HealthAssesmentAnswers.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


GO
PRINT 'Processing: view_EDW_HealthAssesmentClientView ';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_HealthAssesmentClientView') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesmentClientView;
    END;
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentClientView]
--	TO [EDWReader_PRD]
--GO

--******************************************************************************
--8/8/2014 - Generated corrected view in DEV (WDM)
--09.11.2014 (wdm) added to facilitate EDW last mod date
--02.04.2015 (wdm) #48828 added , HACampaign.BiometricCampaignStartDate, 
--		  HACampaign.BiometricCampaignEndDate, HACampaign.CampaignStartDate, 
--		  HACampaign.CampaignEndDate, HACampaign.Name, 
--		  HACampaign.NodeGuid as CampaignNodeGuid
--02.05.2015 Ashwin and I reviewed and approved
-- select top 100 * from view_EDW_HealthAssesmentClientView
--03.27.2015 ( Sowmiya V) - made changes to the view to look at the HealthAssesmentID 
--  only in the join condition.
--  The fix was needed to handle the SR#51281: Platform CampaignNodeGuid missing. 
--	   for view view_EDW_HealthAssesmentClientView
--  Leaving the old code as commented with notes. 
-- 03.13.2015 - (WDM) set the view up for change tracking - the SIMPLE version that does not 
--			 require change tracking tables to be involved.
--select count(*) from view_EDW_HealthAssesmentClientView
--SELECT * FROM   INFORMATION_SCHEMA.VIEWS WHERE  VIEW_DEFINITION like '%view_EDW_HealthAssesmentClientView%'
--******************************************************************************
CREATE VIEW dbo.view_EDW_HealthAssesmentClientView
AS SELECT 
          HFitAcct.AccountID
        , HFitAcct.AccountCD
        , HFitAcct.AccountName
        , HFitAcct.ItemGUID AS ClientGuid
        , CMSSite.SiteGUID
        , NULL AS CompanyID
        , NULL AS CompanyGUID
        , NULL AS CompanyName
        , HAJoined.DocumentName
        , cast(HACampaign.DocumentPublishFrom as datetime) AS HAStartDate
        , cast(HACampaign.DocumentPublishTo as datetime) AS HAEndDate
        , HACampaign.NodeSiteID
        , HAAssessmentMod.Title
        , HAAssessmentMod.CodeName
        , HAAssessmentMod.IsEnabled
        , CASE
              WHEN CAST (HACampaign.DocumentCreatedWhen AS date) = CAST (HACampaign.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , cast(HACampaign.DocumentCreatedWhen as datetime) as DocumentCreatedWhen
        , cast(HACampaign.DocumentModifiedWhen as datetime) as DocumentModifiedWhen
        , cast(HAAssessmentMod.DocumentModifiedWhen  as datetime) AS AssesmentModule_DocumentModifiedWhen     --09.11.2014 (wdm) added to facilitate EDW last mod date
        , HAAssessmentMod.DocumentCulture AS DocumentCulture_HAAssessmentMod
        , HACampaign.DocumentCulture AS DocumentCulture_HACampaign
        , HAJoined.DocumentCulture AS DocumentCulture_HAJoined
        , cast(HACampaign.BiometricCampaignStartDate as datetime)as BiometricCampaignStartDate
        , cast(HACampaign.BiometricCampaignEndDate as datetime)as BiometricCampaignEndDate
        , cast(HACampaign.CampaignStartDate as datetime)as CampaignStartDate
        , cast(HACampaign.CampaignEndDate as datetime)as CampaignEndDate
        , HACampaign.Name
        , HACampaign.NodeGuid AS CampaignNodeGuid
        , HACampaign.HACampaignID
          FROM
               dbo.View_HFit_HACampaign_Joined AS HACampaign
                   INNER JOIN dbo.CMS_Site AS CMSSite
                       ON HACampaign.NodeSiteID = CMSSite.SiteID
                   INNER JOIN dbo.HFit_Account AS HFitAcct
                       ON HACampaign.NodeSiteID = HFitAcct.SiteID
                   INNER JOIN dbo.View_HFit_HealthAssessment_Joined AS HAJoined
                       ON HACampaign.HealthAssessmentID = HAJoined.DocumentID      --  added line to handle    SR #51281   
                          -- ON CASE ----03.27.2015 - Commented code to release the SR #51281
                          --WHEN [HACampaign].[HealthAssessmentConfigurationID] < 0
                          --THEN [HACampaign].[HealthAssessmentID]
                          --ELSE [HACampaign].[HealthAssessmentConfigurationID]
                          --END = HAJoined.DocumentID
                      AND HAJoined.DocumentCulture = 'en-US'
                   INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS HAAssessmentMod
                       ON HAJoined.nodeid = HAAssessmentMod.NodeParentID
                      AND HAAssessmentMod.DocumentCulture = 'en-US'
     WHERE HACampaign.DocumentCulture = 'en-US';


GO

PRINT 'Created: view_EDW_HealthAssesmentClientView ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentClientView.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


PRINT 'Processing: view_EDW_HealthAssesmentDeffinition ' + CAST ( GETDATE () AS NVARCHAR (50)) ;
GO
-- exec sp_depends view_EDW_HealthAssesmentDeffinition
--select count(*) from view_EDW_HealthAssesmentDeffinition

IF EXISTS ( SELECT
                   TABLE_NAME
                   FROM INFORMATION_SCHEMA.VIEWS
                   WHERE TABLE_NAME = 'view_EDW_HealthAssesmentDeffinition') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssesmentDeffinition;
    END;
GO

CREATE VIEW dbo.view_EDW_HealthAssesmentDeffinition
AS SELECT DISTINCT
   --**************************************************************************************************************
   --NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
   --		unchanged when other dates added for the Last Mod Date additions. 
   --		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
   --*****************************************************************************************************************************************************
   --Test Queries:
   --select * from view_EDW_HealthAssesmentDeffinition where AnsDocumentGuid is not NULL
   --Changes:
   --WDM - 6/25/2014
   --Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
   --Worked with Shane to discover the CMS Tree had been modified.
   --Modified the code so that reads it reads the CMS tree correctly - working.
   --7/14/2014 1:29 time to run - 79024 rows - DEV
   --7/14/2014 0:58 time to run - 57472 rows - PROD1
   --7/15/2014 - Query was returning NodeName of 'Campaigns' only
   --	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
   --7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
   --8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
   --8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
   --8/8/2014 - Generated corrected view in DEV
   --8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
   --				them out. With them in the QRY, returned 43104 rows, with them nulled
   --				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
   --				time doubled approximately.
   --				Has to add a DISTINCT to all the queries - .
   --				Original Query 0:25 @ 43104
   --				Original Query 0:46 @ 28736 (distinct)
   --				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
   --				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
   --				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
   --8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
   --				such that when running the view in QA: 
   --8/12/2014 - select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and 
   --				'2014-11-15' now runs exceptionally fast
   --08/12/2014 - ProdStaging 00:21:52 @ 2442
   --08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
   --08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
   --08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
   --08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
   --08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
   --08/12/2014 - DEV 00:00:58 @ 3792
   --09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
   --10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as 
   --				well as Site and Account data
   --11.25.2014 - (wdm) added multi-select column capability. The values can be 0,1, NULL
   --12.29.2014 - (wdm) Added HTML stripping to two columns #47619, the others mentioned already had stripping applied
   --12.31.2014 - (wdm) Started the review to apply CR-47517: Eliminate Matrix Questions with NULL Answer GUID's
   --01.07.2014 - (wdm) 47619 The Health Assessment Definition interface view contains HTML tags - corrected with udf_StripHTML
   --************************************************************************************************************************************************************
          NULL AS SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
 ,
          NULL AS AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
 ,
          HA.NodeID AS HANodeID										--WDM 08.07.2014
 ,
          HA.NodeName AS HANodeName									--WDM 08.07.2014
          --, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history
 ,
          NULL AS HADocumentID										--WDM 08.07.2014; 09.29.2014: Mark and Dale discussed that NODEGUID should be used such that the multi-language/culture is not a problem.
 ,
          HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
 ,
          HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
 ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) AS ModTitle              --WDM 47619
 ,
          dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText              --WDM 47619
 ,
          VHFHAMJ.NodeGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHAMJ.Weight AS ModWeight
 ,VHFHAMJ.IsEnabled AS ModIsEnabled
 ,VHFHAMJ.CodeName AS ModCodeName
 ,VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
 ,dbo.udf_StripHTML ( VHFHARCJ.Title) AS RCTitle              --WDM 47619
 ,
          VHFHARCJ.Weight AS RCWeight
 ,VHFHARCJ.NodeGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHARCJ.IsEnabled AS RCIsEnabled
 ,VHFHARCJ.CodeName AS RCCodeName
 ,VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
 ,dbo.udf_StripHTML ( VHFHARAJ.Title) AS RATytle              --WDM 47619
 ,
          VHFHARAJ.Weight AS RAWeight
 ,VHFHARAJ.NodeGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHARAJ.IsEnabled AS RAIsEnabled
 ,VHFHARAJ.CodeName AS RACodeName
 ,VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
 ,VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
 ,VHFHAQ.QuestionType
 ,dbo.udf_StripHTML ( LEFT ( VHFHAQ.Title , 4000)) AS QuesTitle              --WDM 47619
 ,
          VHFHAQ.Weight AS QuesWeight
 ,VHFHAQ.IsRequired AS QuesIsRequired

          --, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014
 ,
          VHFHAQ.NodeGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014

 ,VHFHAQ.IsEnabled AS QuesIsEnabled
 ,LEFT ( VHFHAQ.IsVisible , 4000) AS QuesIsVisible
 ,VHFHAQ.IsStaging AS QuesIsSTaging
 ,VHFHAQ.CodeName AS QuestionCodeName
 ,VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
 ,VHFHAA.Value AS AnsValue
 ,VHFHAA.Points AS AnsPoints
 ,VHFHAA.NodeGuid AS AnsDocumentGuid		--ref: #47517
 ,
          VHFHAA.IsEnabled AS AnsIsEnabled
 ,VHFHAA.CodeName AS AnsCodeName
 ,VHFHAA.UOM AS AnsUOM
 ,VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
 ,CASE
      WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
          THEN 'I'
      ELSE 'U'
  END AS ChangeType
 ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
 ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
 ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
 ,
          HA.NodeGUID AS HANodeGUID
          --, NULL as SiteLastModified
 ,
          NULL AS SiteLastModified
          --, NULL as Account_ItemModifiedWhen
 ,
          NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
 ,
          NULL AS Campaign_DocumentModifiedWhen
 ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
 ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
 ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
 ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
 ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
 ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
 ,HAMCQ.AllowMultiSelect
 ,'SID01' AS LocID
          FROM
               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'		--WDM 08.12.2014	
          AND
          VHFHAA.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Matrix Level 1 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title)              --WDM 47619
        ,
          dbo.udf_StripHTML ( LEFT ( LEFT ( VHFHAMJ.IntroText , 4000) , 4000)) AS IntroText              --WDM 47619
        ,
          VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title)              --WDM 47619
        ,
          VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title)              --WDM 47619
        ,
          VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ2.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ2.Title , 4000)) AS QuesTitle              --WDM 47619
        ,
          VHFHAQ2.Weight
        ,VHFHAQ2.IsRequired
        ,VHFHAQ2.NodeGuid
        ,VHFHAQ2.IsEnabled
        ,LEFT ( VHFHAQ2.IsVisible , 4000) 
        ,VHFHAQ2.IsStaging
        ,VHFHAQ2.CodeName AS QuestionCodeName
          --,VHFHAQ2.NodeAliasPath
        ,
          VHFHAQ2.DocumentPublishedVersionHistoryID
        ,VHFHAA2.Value
        ,VHFHAA2.Points
        ,VHFHAA2.NodeGuid		--ref: #47517
        ,
          VHFHAA2.IsEnabled
        ,VHFHAA2.CodeName
        ,VHFHAA2.UOM
          --,VHFHAA2.NodeAliasPath
        ,
          VHFHAA2.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID02' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2
                    ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2
                    ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA2.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ3.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ3.Title , 4000)) AS QuesTitle
        ,VHFHAQ3.Weight
        ,VHFHAQ3.IsRequired
        ,VHFHAQ3.NodeGuid
        ,VHFHAQ3.IsEnabled
        ,LEFT ( VHFHAQ3.IsVisible , 4000) 
        ,VHFHAQ3.IsStaging
        ,VHFHAQ3.CodeName AS QuestionCodeName
          --,VHFHAQ3.NodeAliasPath
        ,
          VHFHAQ3.DocumentPublishedVersionHistoryID
        ,VHFHAA3.Value
        ,VHFHAA3.Points
        ,VHFHAA3.NodeGuid		--ref: #47517
        ,
          VHFHAA3.IsEnabled
        ,VHFHAA3.CodeName
        ,VHFHAA3.UOM
          --,VHFHAA3.NodeAliasPath
        ,
          VHFHAA3.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID03' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA3.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ7.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ7.Title , 4000)) AS QuesTitle
        ,VHFHAQ7.Weight
        ,VHFHAQ7.IsRequired
        ,VHFHAQ7.NodeGuid
        ,VHFHAQ7.IsEnabled
        ,LEFT ( VHFHAQ7.IsVisible , 4000) 
        ,VHFHAQ7.IsStaging
        ,VHFHAQ7.CodeName AS QuestionCodeName
          --,VHFHAQ7.NodeAliasPath
        ,
          VHFHAQ7.DocumentPublishedVersionHistoryID
        ,VHFHAA7.Value
        ,VHFHAA7.Points
        ,VHFHAA7.NodeGuid		--ref: #47517
        ,
          VHFHAA7.IsEnabled
        ,VHFHAA7.CodeName
        ,VHFHAA7.UOM
          --,VHFHAA7.NodeAliasPath
        ,
          VHFHAA7.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID04' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

               --Matrix Level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
                    ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
                    ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA7.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --****************************************************
   --WDM 6/25/2014 Retrieve the Branching level 1 Question Group
   --THE PROBLEM LIES HERE in this part of query : 1:40 minute
   -- Added two perf indexes to the first query: 25 Sec
   --****************************************************
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ8.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ8.Title , 4000)) AS QuesTitle
        ,VHFHAQ8.Weight
        ,VHFHAQ8.IsRequired
        ,VHFHAQ8.NodeGuid
        ,VHFHAQ8.IsEnabled
        ,LEFT ( VHFHAQ8.IsVisible , 4000) 
        ,VHFHAQ8.IsStaging
        ,VHFHAQ8.CodeName AS QuestionCodeName
          --,VHFHAQ8.NodeAliasPath
        ,
          VHFHAQ8.DocumentPublishedVersionHistoryID
        ,VHFHAA8.Value
        ,VHFHAA8.Points
        ,VHFHAA8.NodeGuid		--ref: #47517
        ,
          VHFHAA8.IsEnabled
        ,VHFHAA8.CodeName
        ,VHFHAA8.UOM
          --,VHFHAA8.NodeAliasPath
        ,
          VHFHAA8.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID05' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

               --Matrix Level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
                    ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
                    ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID --Matrix branching level 1 question group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8
                    ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8
                    ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA8.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --****************************************************
   --WDM 6/25/2014 Retrieve the Branching level 2 Question Group
   --THE PROBLEM LIES HERE in this part of query : 1:48  minutes
   --With the new indexes: 29 Secs
   --****************************************************
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ4.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ4.Title , 4000)) AS QuesTitle
        ,VHFHAQ4.Weight
        ,VHFHAQ4.IsRequired
        ,VHFHAQ4.NodeGuid
        ,VHFHAQ4.IsEnabled
        ,LEFT ( VHFHAQ4.IsVisible , 4000) 
        ,VHFHAQ4.IsStaging
        ,VHFHAQ4.CodeName AS QuestionCodeName
          --,VHFHAQ4.NodeAliasPath
        ,
          VHFHAQ4.DocumentPublishedVersionHistoryID
        ,VHFHAA4.Value
        ,VHFHAA4.Points
        ,VHFHAA4.NodeGuid		--ref: #47517
        ,
          VHFHAA4.IsEnabled
        ,VHFHAA4.CodeName
        ,VHFHAA4.UOM
          --,VHFHAA4.NodeAliasPath
        ,
          VHFHAA4.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID06' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA4.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 3 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ5.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ5.Title , 4000)) AS QuesTitle
        ,VHFHAQ5.Weight
        ,VHFHAQ5.IsRequired
        ,VHFHAQ5.NodeGuid
        ,VHFHAQ5.IsEnabled
        ,LEFT ( VHFHAQ5.IsVisible , 4000) 
        ,VHFHAQ5.IsStaging
        ,VHFHAQ5.CodeName AS QuestionCodeName
          --,VHFHAQ5.NodeAliasPath
        ,
          VHFHAQ5.DocumentPublishedVersionHistoryID
        ,VHFHAA5.Value
        ,VHFHAA5.Points
        ,VHFHAA5.NodeGuid		--ref: #47517
        ,
          VHFHAA5.IsEnabled
        ,VHFHAA5.CodeName
        ,VHFHAA5.UOM
          --,VHFHAA5.NodeAliasPath
        ,
          VHFHAA5.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID07' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                    ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                    ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA5.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 4 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ6.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ6.Title , 4000)) AS QuesTitle
        ,VHFHAQ6.Weight
        ,VHFHAQ6.IsRequired
        ,VHFHAQ6.NodeGuid
        ,VHFHAQ6.IsEnabled
        ,LEFT ( VHFHAQ6.IsVisible , 4000) 
        ,VHFHAQ6.IsStaging
        ,VHFHAQ6.CodeName AS QuestionCodeName
          --,VHFHAQ6.NodeAliasPath
        ,
          VHFHAQ6.DocumentPublishedVersionHistoryID
        ,VHFHAA6.Value
        ,VHFHAA6.Points
        ,VHFHAA6.NodeGuid		--ref: #47517
        ,
          VHFHAA6.IsEnabled
        ,VHFHAA6.CodeName
        ,VHFHAA6.UOM
          --,VHFHAA6.NodeAliasPath
        ,
          VHFHAA6.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID08' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
               --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                    ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                    ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID --Branching level 4 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
                    ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
                    ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA6.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 5 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        ,
          NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        ,
          HA.NodeID		--WDM 08.07.2014
        ,
          HA.NodeName		--WDM 08.07.2014
        ,
          NULL AS HADocumentID		--WDM 08.07.2014
        ,
          HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        ,
          HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        ,
          dbo.udf_StripHTML ( VHFHAMJ.Title) 
        ,dbo.udf_StripHTML ( LEFT ( VHFHAMJ.IntroText , 4000)) AS IntroText
        ,VHFHAMJ.NodeGuid
        ,VHFHAMJ.Weight
        ,VHFHAMJ.IsEnabled
        ,VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        ,
          VHFHAMJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARCJ.Title) 
        ,VHFHARCJ.Weight
        ,VHFHARCJ.NodeGuid
        ,VHFHARCJ.IsEnabled
        ,VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        ,
          VHFHARCJ.DocumentPublishedVersionHistoryID
        ,dbo.udf_StripHTML ( VHFHARAJ.Title) 
        ,VHFHARAJ.Weight
        ,VHFHARAJ.NodeGuid
        ,VHFHARAJ.IsEnabled
        ,VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        ,
          VHFHARAJ.ScoringStrategyID
        ,VHFHARAJ.DocumentPublishedVersionHistoryID
        ,VHFHAQ9.QuestionType
        ,dbo.udf_StripHTML ( LEFT ( VHFHAQ9.Title , 4000)) AS QuesTitle
        ,VHFHAQ9.Weight
        ,VHFHAQ9.IsRequired
        ,VHFHAQ9.NodeGuid
        ,VHFHAQ9.IsEnabled
        ,LEFT ( VHFHAQ9.IsVisible , 4000) 
        ,VHFHAQ9.IsStaging
        ,VHFHAQ9.CodeName AS QuestionCodeName
          --,VHFHAQ9.NodeAliasPath
        ,
          VHFHAQ9.DocumentPublishedVersionHistoryID
        ,VHFHAA9.Value
        ,VHFHAA9.Points
        ,VHFHAA9.NodeGuid		--ref: #47517
        ,
          VHFHAA9.IsEnabled
        ,VHFHAA9.CodeName
        ,VHFHAA9.UOM
          --,VHFHAA9.NodeAliasPath
        ,
          VHFHAA9.DocumentPublishedVersionHistoryID
        ,CASE
             WHEN CAST ( HA.DocumentCreatedWhen AS DATE) = CAST ( HA.DocumentModifiedWhen AS DATE) 
                 THEN 'I'
             ELSE 'U'
         END AS ChangeType
        ,CAST ( HA.DocumentCreatedWhen AS DATETIME) AS DocumentCreatedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
        ,HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        ,
          HA.NodeGUID AS HANodeGUID
        ,NULL AS SiteLastModified
        ,NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        ,
          NULL AS Campaign_DocumentModifiedWhen
        ,CAST ( HA.DocumentModifiedWhen AS DATETIME) AS Assessment_DocumentModifiedWhen
        ,CAST ( VHFHAMJ.DocumentModifiedWhen AS DATETIME) AS Module_DocumentModifiedWhen
        ,CAST ( VHFHARCJ.DocumentModifiedWhen AS DATETIME) AS RiskCategory_DocumentModifiedWhen
        ,CAST ( VHFHARAJ.DocumentModifiedWhen AS DATETIME) AS RiskArea_DocumentModifiedWhen
        ,CAST ( VHFHAQ.DocumentModifiedWhen AS DATETIME) AS Question_DocumentModifiedWhen
        ,CAST ( VHFHAA.DocumentModifiedWhen AS DATETIME) AS Answer_DocumentModifiedWhen
        ,HAMCQ.AllowMultiSelect
        ,'SID09' AS LocID
          FROM
               --dbo.View_CMS_Tree_Joined AS VCTJ
               --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
               --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

               --Campaign links Client which links to Assessment
               --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

               View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                    INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                    ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                    ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                    ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                    ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                    ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

               --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                    ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                    ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

               --Matrix branching level 1 question group
               --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
               --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

               --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                    ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
               --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                    ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                    ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID --Branching level 4 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
                    ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
                    ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID --Branching level 5 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9
                    ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9
                    ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                    ON
                       VHFHAQ.Nodeguid = HAMCQ.Nodeguid AND
                       HAMCQ.DocumentCulture = 'en-US'
          WHERE
          VHFHAQ.DocumentCulture = 'en-us' AND
          (
            VHFHAA.DocumentCulture = 'en-us' OR
            VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
          AND
          VHFHARCJ.DocumentCulture = 'en-us' AND
          VHFHARAJ.DocumentCulture = 'en-us' AND
          VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
          AND
          HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
          AND
          VHFHAA9.NodeGuid IS NOT NULL;		--ref: #47517

GO

PRINT 'Processed: view_EDW_HealthAssesmentDeffinition ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssesmentDeffinition.sql';
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

print ('Processing: view_EDW_HealthAssesmentDeffinitionCustom ') ;
go



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinitionCustom')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinitionCustom ;
END
GO

--GRANT SELECT
--	ON [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
--	TO [EDWReader_PRD]
--GO

--***********************************************************************************************
-- 09.11.2014 : (wdm) Verified DATES to resolve EDW last mod date issue
--***********************************************************************************************
CREATE VIEW [dbo].[view_EDW_HealthAssesmentDeffinitionCustom]
AS
	--8/8/2014 - DocGUID changes, NodeGuid
	--8/8/2014 - Generated corrected view in DEV
	--8/10/2014 - added WHERE to limit to English language
	--09.11.2014 - WDM : Added date fields to facilitate Last Mod Date determination
	SELECT 
		cs.SiteGUID
		, HFA.AccountCD		--WDM 08.07.2014
		, HA.NodeID AS HANodeID		--WDM 08.07.2014
		, HA.NodeName AS HANodeName		--WDM 08.07.2014
		, HA.DocumentID AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID AS HANodeSiteID		--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, VHFHAMJ.Title AS ModTitle
		--Per EDW Team, HTML text is truncated to 4000 bytes - we'll just do it here
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, VHFHARCJ.Title AS RCTitle
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.DocumentGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, VHFHARAJ.Title AS RATytle
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.DocumentGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		
		, VHFHAA.DocumentGuid AS AnsDocumentGuid	--, VHFHAA.DocumentID AS AnsDocumentID	--WDM 08.07.2014
		
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen  as DATEtime) as DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
	 
		, CAST(CS.SiteLastModified as datetime ) AS SiteLastModified 
		, CAST(hfa.ItemModifiedWhen as datetime) as Account_ItemModifiedWhen
		, CAST(c.DocumentModifiedWhen  as datetime) as Campaign_DocumentModifiedWhen
		, CAST(HA.DocumentModifiedWhen  as datetime) as Assessment_DocumentModifiedWhen
		, CAST(VHFHAMJ.DocumentModifiedWhen  as datetime) as Module_DocumentModifiedWhen
		, CAST(VHFHARCJ.DocumentModifiedWhen  as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST(VHFHARAJ.DocumentModifiedWhen  as datetime) as RiskArea_DocumentModifiedWhen
		, CAST(VHFHAQ.DocumentModifiedWhen  as datetime) as Question_DocumentModifiedWhen
		, CAST(VHFHAA.DocumentModifiedWhen  as datetime) as Answer_DocumentModifiedWhen
FROM
		dbo.View_CMS_Tree_Joined AS VCTJ
		INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 
		INNER JOIN View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
		--WDM 08.07.2014
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
		where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'
UNION ALL
--WDM Retrieve Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.DocumentGUID
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.DocumentGUID
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen 
		, CAST(VCTJ.DocumentModifiedWhen  as DATEtime)  as DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	 
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen  as datetime) as Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen  as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen  as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen  as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen  as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen  as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen  as DATEtime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen  as DATEtime)  as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.DocumentGUID
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.DocumentGUID
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen AS DATETIME ) AS DocumentModifiedWhen 
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen  as datetime ) as Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen as datetime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen as datetime) as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.DocumentGUID
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.DocumentGUID
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen AS DATETIME ) AS DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen as datetime) as  Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen as datetime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen as datetime) as Answer_DocumentModifiedWhen
FROM
 dbo.View_CMS_Tree_Joined AS VCTJ
 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.DocumentGUID
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.DocumentGUID
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen AS DATETIME ) AS DocumentModifiedWhen 
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
	
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen as datetime) as  Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen as datetime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen as datetime) as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.DocumentGUID
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.DocumentGUID
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen AS DATETIME ) AS DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen as datetime) as  Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen as datetime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen as datetime) as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.DocumentGUID
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.DocumentGUID
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen AS DATETIME ) AS DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen as datetime) as  Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen as datetime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen as datetime) as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.DocumentGUID
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.DocumentGUID
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen AS DATETIME ) AS DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen as datetime) as  Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen as datetime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen as datetime) as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'

UNION ALL
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT
		cs.SiteGUID
		, HFA.AccountCD
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, HA.DocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, VHFHAMJ.Title
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.DocumentGUID
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, VHFHARCJ.Title
		, VHFHARCJ.Weight
		, VHFHARCJ.DocumentGUID
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, VHFHARAJ.Title
		, VHFHARAJ.Weight
		, VHFHARAJ.DocumentGUID
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.DocumentGUID
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.DocumentGUID
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(VCTJ.DocumentCreatedWhen AS DATE) = CAST(vctj.DocumentModifiedWhen  as DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, CAST(VCTJ.DocumentCreatedWhen AS DATETIME ) AS DocumentCreatedWhen
		, CAST(VCTJ.DocumentModifiedWhen AS DATETIME ) AS DocumentModifiedWhen
		, VCTJ.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
 
		, CAST( CS.SiteLastModified as datetime ) AS SiteLastModified
		, CAST( hfa.ItemModifiedWhen as datetime) as  Account_ItemModifiedWhen
		, CAST( c.DocumentModifiedWhen as datetime) as Campaign_DocumentModifiedWhen
		, CAST( HA.DocumentModifiedWhen as datetime) as Assessment_DocumentModifiedWhen
		, CAST( VHFHAMJ.DocumentModifiedWhen as datetime) as Module_DocumentModifiedWhen
		, CAST( VHFHARCJ.DocumentModifiedWhen as datetime) as RiskCategory_DocumentModifiedWhen
		, CAST( VHFHARAJ.DocumentModifiedWhen as datetime) as RiskArea_DocumentModifiedWhen
		, CAST( VHFHAQ.DocumentModifiedWhen as datetime) as Question_DocumentModifiedWhen
		, CAST( VHFHAA.DocumentModifiedWhen as datetime) as Answer_DocumentModifiedWhen
FROM
  dbo.View_CMS_Tree_Joined AS VCTJ

 INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
 INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 INNER JOIN dbo.View_HFit_HACampaign_Joined c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID
 INNER JOIN View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) ON c.HealthAssessmentID = HA.DocumentID
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
where VCTJ.DocumentCulture = 'en-us'	--WDM 08.07.2014
				AND VHFHAMJ.NodeName = 'Custom'




GO


  --  
  --  
GO 
print('***** FROM: view_EDW_HealthAssesmentDeffinitionCustom.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go



GO 
print('***** FROM: view_EDW_HealthInterestDetail.sql'); 
GO 
print ('Creating view_EDW_HealthInterestDetail');
GO

if exists(select name from sys.views where name = 'view_EDW_HealthInterestDetail')
BEGIN 
	drop view view_EDW_HealthInterestDetail ;
END
go

CREATE VIEW [dbo].[view_EDW_HealthInterestDetail]
AS
	    --06/25/2015 (jjl) added IsDeleted field to allow EDW to filter active records
    --12/03/2014 1526 (wdm) this view was created by Chad Gurka and passed over to Team P to incloude into the build
    --12/03/2014 1845 (wdm) INSTALLATION: In running the script on Prod 1, an error was encountered when creating the 
    --view view_EDW_HealthInterestDetail. A base table, HFit_CoachingHealthInterest, referenced by the view on 
    --all prod servers was missing two columns, ItemCreatedWhen and ItemModifiedWhen.
    --In order to get the view created, I nulled out these two columns and a FIX will have to be applied to the 
    --view after these two columns are added to the base table. Chad had no way of knowing these columns were 
    --missing in Prod when he developed the view. And, it tested perfectly for John C. in Prod Staging this afternoon. 
    --This table, HFit_CoachingHealthInterest, will have these columns applied as part of the upcoming migration and 
    --are not available in Prod currently. However, the fix will be very minor and should correct itself as part of 
    --coming migration. Please take note that these columns will return only NULLS until the base table is modified 
    --to contain these columns.
 
    SELECT
        HI.UserID
        ,U.UserGUID
        ,US.HFitUserMpiNumber
        ,S.SiteGUID
        ,HI.CoachingHealthInterestID
 
        ,HA1.CoachingHealthAreaID AS FirstHealthAreaID
        ,HA1.NodeID AS FirstNodeID
        ,HA1.NodeGuid AS FirstNodeGuid
        ,HA1.DocumentName AS FirstHealthAreaName
        ,HA1.HealthAreaDescription AS FirstHealthAreaDescription
        ,HA1.CodeName AS FirstCodeName
 
        ,HA2.CoachingHealthAreaID AS SecondHealthAreaID
        ,HA2.NodeID AS SecondNodeID
        ,HA2.NodeGuid AS SecondNodeGuid
        ,HA2.DocumentName AS SecondHealthAreaName
        ,HA2.HealthAreaDescription AS SecondHealthAreaDescription
        ,HA2.CodeName AS SecondCodeName
 
        ,HA3.CoachingHealthAreaID AS ThirdHealthAreaID
        ,HA3.NodeID AS ThirdNodeID
        ,HA3.NodeGuid AS ThirdNodeGuid
        ,HA3.DocumentName AS ThirdHealthAreaName
        ,HA3.HealthAreaDescription AS ThirdHealthAreaDescription
        ,HA3.CodeName AS ThirdCodeName
 
        ,cast(HI.ItemCreatedWhen as datetime ) as ItemCreatedWhen
        ,cast(HI.ItemModifiedWhen as datetime ) as ItemModifiedWhen
        ,coalesce(HI.IsDeleted,0) as IsDeleted
    FROM
        HFit_CoachingHealthInterest AS HI
        JOIN CMS_User AS U ON HI.UserID = U.UserID
        JOIN CMS_UserSettings AS US ON HI.UserID = US.UserSettingsUserID
        JOIN CMS_UserSite AS US1 ON HI.UserID = US1.UserID
        JOIN CMS_Site AS S ON US1.SiteID = S.SiteID
        LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA1 ON HI.FirstInterest = HA1.NodeID
            AND HA1.DocumentCulture = 'en-us'
        LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA2 ON HI.SecondInterest = HA2.NodeID    
            AND HA2.DocumentCulture = 'en-us'
        LEFT JOIN View_HFit_CoachingHealthArea_Joined AS HA3 ON HI.ThirdInterest = HA3.NodeID
            AND HA3.DocumentCulture = 'en-us'

GO

print ('Created view_EDW_HealthInterestDetail');
GO





go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go




go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

print ('Processing: view_EDW_ScreeningsFromTrackers ') ;
go

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_ScreeningsFromTrackers')
BEGIN
	drop view view_EDW_ScreeningsFromTrackers ;
END
GO

--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_ScreeningsFromTrackers]

AS

SELECT
	t.userid
	, cast(t.eventdate as datetime) as eventdate
	, t.TrackerCollectionSourceID
	, t.ItemCreatedBy
	, cast(t.ItemCreatedWhen as datetime) as ItemCreatedWhen
	, t.ItemModifiedBy
	, cast(t.ItemModifiedWhen as datetime) as ItemModifiedWhen
FROM
	(
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBloodPressure
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBloodSugarAndGlucose
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBMI
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBodyFat
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerBodyMeasurements
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerCardio
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerCholesterol
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerDailySteps
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerFlexibility
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerFruits
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHbA1c
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHeight
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHighFatFoods
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerHighSodiumFoods
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerInstance_Tracker
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerMealPortions
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerMedicalCarePlan
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerRegularMeals
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerRestingHeartRate
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerShots
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSitLess
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSleepPlan
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerStrength
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerStress
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerStressManagement
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSugaryDrinks
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerSugaryFoods
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerTests
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerTobaccoFree
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerVegetables
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerWater
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerWeight
		UNION ALL
		SELECT
			userid
			, cast(eventdate as datetime) as eventdate
			, TrackerCollectionSourceID
			, ItemCreatedBy
			, cast(ItemCreatedWhen as datetime) as ItemCreatedWhen
			, ItemModifiedBy
			, cast(ItemModifiedWhen as datetime) as ItemModifiedWhen
		FROM
			HFit_TrackerWholeGrains
	) as T
INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS ON t.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
WHERE HFTCS.isProfessionallyCollected = 1


GO


  --  
  --  
GO 
print('***** FROM: view_EDW_ScreeningsFromTrackers.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


PRINT 'Processing: view_EDW_TrackerMetadata ';
GO

IF EXISTS( SELECT
                  TABLE_NAME
             FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_TrackerMetadata' )
    BEGIN
        DROP VIEW
             view_EDW_TrackerMetadata;
    END;
GO


CREATE VIEW dbo.view_EDW_TrackerMetadata
AS
--******************************************************************************************************
--TableName - this is the CMS_CLASS ClassName and is used to identify the needed metadata. 
--ColumnName - Each Class has a set of columns. This is the name of the column as contained
--				within the CLASS.
--AttrName - The name of the attribute as it applies to the column (e.g. column type 
--				describes the datatype of the column (ColName) within the CLASS (ClassName).
--AttrVal - the value assigned to the AttrName.
--CreatedDate - the date this row of metadata was created.
--LastModifiedDate - the date this row of metadata was last changed in the Tracker_EDW_Metadata table.
--ID - An identity field within the Tracker_EDW_Metadata table.
--ClassLastModified - The last date the CLASS within CMS_CLASS was changed.
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--******************************************************************************************************
SELECT
       TableName , 
       ColName , 
       AttrName , 
       AttrVal , 
       cast(CreatedDate as datetime ) as CreatedDate , 
       cast(LastModifiedDate  as datetime ) as LastModifiedDate  , 
       ID , 
       cast(CMS_CLASS.ClassLastModified as datetime ) as ClassLastModified 
  FROM
       Tracker_EDW_Metadata JOIN CMS_CLASS
       ON CMS_CLASS.ClassName = TableName;


GO


--  
--  
GO 
PRINT '***** FROM: view_EDW_TrackerMetadata.sql'; 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


print ('Processing: view_EDW_TrackerShots ') ;



if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerShots')
BEGIN
	drop view view_EDW_TrackerShots ;
END
go

/****** Object:  View [dbo].[view_EDW_TrackerShots]    Script Date: 9/11/2014 11:14:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerShots]
AS
	SELECT DISTINCT
		HFTS.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, HFTS.ItemID
		, cast(HFTS.EventDate as datetime ) as EventDate
		, HFTS.IsProfessionallyCollected
		, HFTS.TrackerCollectionSourceID
		, HFTS.Notes
		, HFTS.FluShot
		, HFTS.PneumoniaShot
		, cast(HFTS.ItemCreatedWhen as datetime ) as ItemCreatedWhen
		, cast(HFTS.ItemModifiedWhen as datetime ) as ItemModifiedWhen
		, HFTS.ItemGUID
	FROM
		dbo.HFit_TrackerShots AS HFTS
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTS.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID

GO


  --  
  --  
GO 
print('***** FROM: view_EDW_TrackerShots.sql'); 
GO 



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


print ('Processing: view_EDW_TrackerTests ') ;

GO


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_TrackerTests')
BEGIN
	drop view view_EDW_TrackerTests ;
END

GO


--********************************************************************************************************
--09.11.2014 : (wdm) Verified last mod date available to EDW 
-- Select count(*) from [view_EDW_TrackerTests] 40322 vs. 40313 with distinct 44502 / 44483 on TGT P1
--									   44502 vs. 44483 with distinct on Prod5 / P1
--********************************************************************************************************
CREATE VIEW [dbo].[view_EDW_TrackerTests]
AS
	SELECT 
		HFTT.UserID
		, cus.UserSettingsUserGUID
		, CUS.HFitUserMpiNumber
		, CS.SiteID
		, cs.SiteGUID
		, cast(HFTT.EventDate as datetime) as EventDate
		, HFTT.IsProfessionallyCollected
		, HFTT.TrackerCollectionSourceID
		, HFTT.Notes
		, HFTT.PSATest
		, HFTT.OtherExam
		, HFTT.TScore
		, HFTT.DRA
		, HFTT.CotinineTest
		, HFTT.ColoCareKit
		, HFTT.CustomTest
		, HFTT.CustomDesc
		, HFTT.TSH
		, cast(HFTT.ItemCreatedWhen as datetime) as ItemCreatedWhen
		, cast(HFTT.ItemModifiedWhen as datetime) as ItemModifiedWhen
		, HFTT.ItemGUID
	FROM
		dbo.HFit_TrackerTests AS HFTT
	INNER JOIN dbo.HFit_PPTEligibility AS HFPE WITH ( NOLOCK ) ON HFTT.UserID = HFPE.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON cus2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON CS.SiteID = HFA.SiteID
GO


  --  
  --  
GO 
print('***** FROM: view_EDW_TrackerTests.sql'); 
GO 




go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go


--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--DISABLE TRIGGER trgSchemaMonitor ON DATABASE;

GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails.sql';
PRINT 'Processing: view_EDW_TrackerCompositeDetails ';
GO
--SELECT * from view_EDW_TrackerCompositeDetails
IF EXISTS ( SELECT DISTINCT
                   TABLE_NAME
                   FROM INFORMATION_SCHEMA.VIEWS
                   WHERE
                   TABLE_NAME = 'view_EDW_TrackerCompositeDetails') 
    BEGIN
        DROP VIEW
             view_EDW_TrackerCompositeDetails;
    END;
GO
--count with UNION ALL xx @ 00:00:24
--count with UNION ALL and DISTINCT xx @ 00:00:24
--count with UNION 3,218,556 @ 00:00:24
--SELECT count(*) from view_EDW_TrackerCompositeDetails;
GO
CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
AS
--************************************************************************************************************************************
-- NOTES:
--************************************************************************************************************************************
--WDM 6/26/2014
--This view is needed by EDW in order to process the Tracker tables' data.
--As of now, the Tracker tables are representative of objects and that would cause 
--	large volumes of ETL to be devloped and maintained. 
--This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
--Each tracker table to be processed into the EDW must be represented in this view.
--ALL new tracker tables need only be entered once using the structure contained within this view
--	and the same EDW ETL should be able to process it.
--If there is a change to the strucuture of any one query in this view, then all have to be modified 
--	to be support the change.
--Column TrackerNameAggregratetable (AggregateTableName) will be NULL if the Tracker is not a member 
--		of the DISPLAYED Trackers. This allows us to capture all trackers, displayed or not.

--7/29/2014
--ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
--		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
--		This raises the need for the Tracker Definition Table.

--NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
--		be avoided here if possible.

--**************** SPECIFIC TRACKER DATA **********************
--**************** on 7/29/2014          **********************
--Tracker GUID or Unique ID across all DB Instances (ItemGuid)
--Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
--Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
--Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
--		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
--Tracker Column Description (In English) (???)
--Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
--	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
--Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
--Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
--Tracker Insert Date ([ItemCreatedWhen])
--Tracker Last Update Date ([ItemModifiedWhen])
--NOTE: Convert all numerics to floats 7/30/2104 John/Dale
--****************************************************************************************************************************
-- 12.21.2014 - Added Select Distincts to avoid possible dups.
-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
-- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
--****************************************************************************************************************************
-- NEW ADDITIONS: 02.01.2015	Need for the updates to be completed and then we add.
--	  HFit_TrackerTobaccoAttestation
--	  HFit_TrackerPreventiveCare
--	  HFit_TrackerCotinine
--(03.20.2015) - (WDM) The DISTINCT in this qry in should eliminate duplicate rows found by John C.
--			 All worked correctly in 12.25.2014, NO changes effected since then, and unexplicably rows stated to 
--			 duplicate in three tables (tracker views) Shots, Tests, and TrackerInstance
--(03.20.2015) - WDM : HFit_TrackerInstance_Tracker has a problem that will require developer help - it is still OPEN.
--			    John C. and I looked at the issue and the LEFT join is causing a cartisian as there is no KEY 
--			    on which to join.
-- TGT (PRod1) NO DISTINCT: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:08:36 @ 3,210,081
--- TGT (PRod1) WITH DISTINCT and Union all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:30 @ 3,210,081
--- TGT (PRod1) No DISTINCT and UNion all: 
--  SELECT DISTINCT count(*) from view_EDW_TrackerCompositeDetails 00:00:14 @ 3,218,556
--(03.21.2015) - WDM : Implemented bew code for TrackerInstance and it returns data properly now.
--(03.22.2015) - WDM : Found and corrected the Shots and Tests duplicate rows. No DUPS at this point.
--(
--****************************************************************************************************************************
--Best USE is:		(however, I do not believe Laura is allowing this view to be called in this fashion)
--SELECT * from view_EDW_TrackerCompositeDetails where EventDate between '2013-11-04 00:00:00' and '2013-11-04 23:59:59'

--Set statistics IO ON
--GO

SELECT DISTINCT
       'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mm/Hg' AS UOM
     , 'Systolic' AS KEY1
     , CAST ( Systolic AS float) AS VAL1
     , 'Diastolic' AS KEY2
     , CAST ( Diastolic AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'bp') AS UniqueName
     , ISNULL ( T.UniqueName , 'bp') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBloodPressure AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/L' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS float) AS VAL1
     , 'FastingState' AS KEY2
     , CAST ( FastingState AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'glucose') AS UniqueName
     , ISNULL ( T.UniqueName , 'glucose') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBloodSugarAndGlucose AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBMI' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'kg/m2' AS UOM
     , 'BMI' AS KEY1
     , CAST ( BMI AS float) AS VAL1
     , 'NA' AS KEY2
     , 0 AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBMI') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBMI AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBMI'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerBodyFat' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'PCT' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS float) AS VAL1
     , 'NA' AS KEY2
     , 0 AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBodyFat AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBodyFat'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
--******************************************************************************
SELECT DISTINCT
       'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Inch' AS UOM
     , 'WaistInches' AS KEY1
     , CAST ( WaistInches AS float) AS VAL1
     , 'HipInches' AS KEY2
     , CAST ( HipInches AS float) AS VAL2
     , 'ThighInches' AS KEY3
     , CAST ( ThighInches AS float) AS VAL3
     , 'ArmInches' AS KEY4
     , CAST ( ArmInches AS float) AS VAL4
     , 'ChestInches' AS KEY5
     , CAST ( ChestInches AS float) AS VAL5
     , 'CalfInches' AS KEY6
     , CAST ( CalfInches AS float) AS VAL6
     , 'NeckInches' AS KEY7
     , CAST ( NeckInches AS float) AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerBodyMeasurements AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
--******************************************************************************
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCardio' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'Minutes' AS KEY1
     , CAST ( Minutes AS float) AS VAL1
     , 'Distance' AS KEY2
     , CAST ( Distance AS float) AS VAL2
     , 'DistanceUnit' AS KEY3
     , CAST ( DistanceUnit AS float) AS VAL3
     , 'Intensity' AS KEY4
     , CAST ( Intensity AS float) AS VAL4
     , 'ActivityID' AS KEY5
     , CAST ( ActivityID AS float) AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerCardio AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCardio'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerCholesterol' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mg/dL' AS UOM
     , 'HDL' AS KEY1
     , CAST ( HDL AS float) AS VAL1
     , 'LDL' AS KEY2
     , CAST ( LDL AS float) AS VAL2
     , 'Total' AS KEY3
     , CAST ( Total AS float) AS VAL3
     , 'Tri' AS KEY4
     , CAST ( Tri AS float) AS VAL4
     , 'Ratio' AS KEY5
     , CAST ( Ratio AS float) AS VAL5
     , 'Fasting' AS KEY6
     , CAST ( Fasting AS float) AS VAL6
     , 'VLDL' AS VLDL
     , CAST ( VLDL AS float) AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerCholesterol') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerCholesterol AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCholesterol'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerDailySteps' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Step' AS UOM
     , 'Steps' AS KEY1
     , CAST ( Steps AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerDailySteps') AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerDailySteps AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerDailySteps'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFlexibility' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasStretched' AS KEY1
     , CAST ( HasStretched AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerFlexibility AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerFlexibility'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerFruits' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerFruits AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerFruits'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHbA1c' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'mmol/mol' AS UOM
     , 'Value' AS KEY1
     , CAST ( [Value] AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHbA1c AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHbA1c'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'inch' AS UOM
     , 'Height' AS KEY1
     , Height AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS UniqueName
     , ISNULL ( T.UniqueName , 'HFit_TrackerHeight') AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHeight AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHeight'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHighFatFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerHighSodiumFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
--w/o  distinct 00:02:07 @ 477120 PRD1
--with distinct 00:03:20 @ 475860 PRD1
--(03.20.2015) - (WDM) verified SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT 'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable ,
                     TT.ItemID ,
                     cast(EventDate as datetime) as EventDate ,
                     TT.IsProfessionallyCollected ,
                     TT.TrackerCollectionSourceID ,
                     Notes ,
                     TT.UserID ,
                     CollectionSourceName_Internal ,
                     CollectionSourceName_External ,
                     'MISSING' AS EventName ,
                     'Y/N' AS UOM ,
                     'TrackerDefID' AS KEY1 ,
                     CAST (TrackerDefID AS float) AS VAL1 ,
                     'YesNoValue' AS KEY2 ,
                     CAST (YesNoValue AS float) AS VAL2 ,
                     'NA' AS KEY3 ,
                     NULL AS VAL3 ,
                     'NA' AS KEY4 ,
                     NULL AS VAL4 ,
                     'NA' AS KEY5 ,
                     NULL AS VAL5 ,
                     'NA' AS KEY6 ,
                     NULL AS VAL6 ,
                     'NA' AS KEY7 ,
                     NULL AS VAL7 ,
                     'NA' AS KEY8 ,
                     NULL AS VAL8 ,
                     'NA' AS KEY9 ,
                     NULL AS VAL9 ,
                     'NA' AS KEY10 ,
                     NULL AS VAL10 ,
                     TT.ItemCreatedBy ,
                     cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen ,
                     TT.ItemModifiedBy ,
                     cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen ,
                     NULL AS IsProcessedForHa ,
                     'NA' AS TXTKEY1 ,
                     NULL AS TXTVAL1 ,
                     'NA' AS TXTKEY2 ,
                     NULL AS TXTVAL2 ,
                     'NA' AS TXTKEY3 ,
                     NULL AS TXTVAL3 ,
                     NULL AS ItemOrder ,
                     NULL AS ItemGuid ,
                     C.UserGuid ,
                     PP.MPI ,
                     PP.ClientCode ,
                     S.SiteGUID ,
                     ACCT.AccountID ,
                     ACCT.AccountCD ,
                     T.IsAvailable ,
                     T.IsCustom ,
                     T.UniqueName ,
                     T.UniqueName AS ColDesc ,
                     NULL AS VendorID,
                     NULL AS VendorName
          FROM dbo.HFit_TrackerInstance_Tracker AS TT
                              INNER JOIN dbo.HFit_TrackerDef_Tracker TDT     
                                  ON TDT.trackerid = TT.trackerDefID
                           INNER JOIN dbo.CMS_User AS C
                                  ON C.UserID = TT.UserID
                           INNER JOIN dbo.hfit_ppteligibility AS PP
                                  ON TT.UserID = PP.userID
                           INNER JOIN dbo.HFit_Account AS ACCT
                                  ON PP.ClientCode = ACCT.AccountCD
                           INNER JOIN dbo.CMS_Site AS S
                                  ON ACCT.SiteID = S.SiteID
                           INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                                  ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                           LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                                  ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
                                                         AND T.uniquename = TDT.name
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMealPortions' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerMealPortions AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerMealPortions'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FollowedPlan' AS KEY1
     , CAST ( FollowedPlan AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerMedicalCarePlan AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Units' AS KEY1
     , CAST ( Units AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerRegularMeals AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerRegularMeals'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'BPM' AS UOM
     , 'HeartRate' AS KEY1
     , CAST ( HeartRate AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerRestingHeartRate AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
--With DISTINCT 00:14 @ 40041
--With NO DISTINCT 00:14 @ 40060
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT
       'HFit_TrackerShots' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'FluShot' AS KEY1
     , CAST ( FluShot AS float) AS VAL1
     , 'PneumoniaShot' AS KEY2
     , CAST ( PneumoniaShot AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerShots AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerShots'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSitLess' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Occurs' AS UOM
     , 'Times' AS KEY1
     , CAST ( Times AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSitLess AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSitLess'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'HR' AS UOM
     , 'DidFollow' AS KEY1
     , CAST ( DidFollow AS float) AS VAL1
     , 'HoursSlept' AS KEY2
     , HoursSlept AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Techniques' AS TXTKEY1
     , Techniques AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSleepPlan AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSleepPlan'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStrength' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'HasTrained' AS KEY1
     , CAST ( HasTrained AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStrength AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStrength'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStress' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'Intensity' AS KEY1
     , CAST ( Intensity AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Awareness' AS TXTKEY1
     , Awareness AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStress AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStress'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerStressManagement' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'gradient' AS UOM
     , 'HasPracticed' AS KEY1
     , CAST ( HasPracticed AS float) AS VAL1
     , 'Effectiveness' AS KEY2
     , CAST ( Effectiveness AS float) AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'Activity' AS TXTKEY1
     , Activity AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerStressManagement AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerStressManagement'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSugaryDrinks AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-portion' AS UOM
     , 'Portions' AS KEY1
     , CAST ( Portions AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerSugaryFoods AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
--Using DISTINCT PROD1 - 00:08:41 @ 40313
--Using DISTINCT PRD1 - 00:00:09 @ 45502
--Using NO DISTINCT PRD1 00:19 @ 40332
--Using DISTINCT PRD1 - 00:00:11 @ 44483
--(03.20.2015) - (WDM) added a SELECT DISTINCT to this qry in order to eliminate duplicate rows found by John C.
SELECT DISTINCT
       'HFit_TrackerTests' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PSATest' AS KEY1
     , CAST ( PSATest AS float) AS VAL1
     , 'OtherExam' AS KEY1
     , CAST ( OtherExam AS float) AS VAL2
     , 'TScore' AS KEY3
     , CAST ( TScore AS float) AS VAL3
     , 'DRA' AS KEY4
     , CAST ( DRA AS float) AS VAL4
     , 'CotinineTest' AS KEY5
     , CAST ( CotinineTest AS float) AS VAL5
     , 'ColoCareKit' AS KEY6
     , CAST ( ColoCareKit AS float) AS VAL6
     , 'CustomTest' AS KEY7
     , CAST ( CustomTest AS float) AS VAL7
     , 'TSH' AS KEY8
     , CAST ( TSH AS float) AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'CustomDesc' AS TXTKEY1
     , CustomDesc AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , TT.ItemOrder
     , TT.ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerTests AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTests'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'Y/N' AS UOM
     , 'WasTobaccoFree' AS KEY1
     , CAST ( WasTobaccoFree AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'QuitAids' AS TXTKEY1
     , QuitAids AS TXTVAL1
     , 'QuitMeds' AS TXTKEY2
     , QuitMeds AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerTobaccoFree AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerVegetables' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'CUP(8oz)' AS UOM
     , 'Cups' AS KEY1
     , CAST ( Cups AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerVegetables AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerVegetables'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWater' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'OZ' AS UOM
     , 'Ounces' AS KEY1
     , CAST ( Ounces AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWater AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWater'
--left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWeight' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'LBS' AS UOM
     , 'Value' AS KEY1
     , [Value] AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , VENDOR.ItemID AS VendorID
     , VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWeight AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWeight'
                LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
                ON TT.VendorID = VENDOR.ItemID
UNION ALL
SELECT DISTINCT
       'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , CollectionSourceName_Internal
     , CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA-serving' AS UOM
     , 'Servings' AS KEY1
     , CAST ( Servings AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , NULL AS IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , NULL AS VendorID	--VENDOR.ItemID as VendorID
     ,
       NULL AS VendorName --VENDOR.VendorName
       FROM
            dbo.HFit_TrackerWholeGrains AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerWholeGrains'
			 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
UNION ALL

SELECT DISTINCT
       'HFit_TrackerCotinine' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'NicotineAssessment' AS KEY1
     , CAST ( NicotineAssessment AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerCotinine AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerCotinine'
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

UNION ALL
SELECT DISTINCT
       'HFit_TrackerPreventiveCare' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'PreventiveCare' AS KEY1
     , CAST ( PreventiveCare AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerPreventiveCare AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerPreventiveCare'
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;
UNION ALL
SELECT DISTINCT
       'HFit_TrackerTobaccoAttestation' AS TrackerNameAggregateTable
     , TT.ItemID
     , cast(EventDate as datetime) as EventDate
     , TT.IsProfessionallyCollected
     , TT.TrackerCollectionSourceID
     , Notes
     , TT.UserID
     , NULL AS CollectionSourceName_Internal
     , NULL AS CollectionSourceName_External
     , 'MISSING' AS EventName
     , 'NA' AS UOM
     , 'TobaccoAttestation' AS KEY1
     , CAST ( TobaccoAttestation AS float) AS VAL1
     , 'NA' AS KEY2
     , NULL AS VAL2
     , 'NA' AS KEY3
     , NULL AS VAL3
     , 'NA' AS KEY4
     , NULL AS VAL4
     , 'NA' AS KEY5
     , NULL AS VAL5
     , 'NA' AS KEY6
     , NULL AS VAL6
     , 'NA' AS KEY7
     , NULL AS VAL7
     , 'NA' AS KEY8
     , NULL AS VAL8
     , 'NA' AS KEY9
     , NULL AS VAL9
     , 'NA' AS KEY10
     , NULL AS VAL10
     , TT.ItemCreatedBy
     , cast(TT.ItemCreatedWhen as datetime) as ItemCreatedWhen
     , TT.ItemModifiedBy
     , cast(TT.ItemModifiedWhen as datetime) as ItemModifiedWhen
     , IsProcessedForHa
     , 'NA' AS TXTKEY1
     , NULL AS TXTVAL1
     , 'NA' AS TXTKEY2
     , NULL AS TXTVAL2
     , 'NA' AS TXTKEY3
     , NULL AS TXTVAL3
     , NULL AS ItemOrder
     , NULL AS ItemGuid
     , C.UserGuid
     , PP.MPI
     , PP.ClientCode
     , S.SiteGUID
     , ACCT.AccountID
     , ACCT.AccountCD
     , T.IsAvailable
     , T.IsCustom
     , T.UniqueName
     , T.UniqueName AS ColDesc
     , --VENDOR.ItemID AS VendorID ,
       --VENDOR.VendorName,
       NULL AS VendorID
     , NULL AS VendorName
       FROM
            dbo.HFit_TrackerTobaccoAttestation AS TT
                INNER JOIN dbo.CMS_User AS C
                ON C.UserID = TT.UserID
                INNER JOIN dbo.hfit_ppteligibility AS PP
                ON TT.UserID = PP.userID
                INNER JOIN dbo.HFit_Account AS ACCT
                ON PP.ClientCode = ACCT.AccountCD
                INNER JOIN dbo.CMS_Site AS S
                ON ACCT.SiteID = S.SiteID
                INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
                ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
                LEFT OUTER JOIN dbo.HFIT_Tracker AS T
                ON T.AggregateTableName = 'HFit_TrackerTobaccoAttestation';
--LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
--	ON TT.VendorID = VENDOR.ItemID;

GO

--  
--  
GO
PRINT '***** CREATED: view_EDW_TrackerCompositeDetails.sql';
GO 

--IF EXISTS (SELECT name FROM sys.triggers where name = 'trgSchemaMonitor')    
--enable TRIGGER trgSchemaMonitor ON DATABASE;

GO


go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

go

print 'EXecute PrintNow.sql' ;

go

if exists (select name from sys.procedures where name = 'PrintNow')
    DROP PROCEDURE [dbo].[PrintNow] ;

GO

create procedure [dbo].[PrintNow] (@msg as nvarchar(500))
as
begin
raiserror (@msg, 10,1) with nowait;
end 


GO


print 'Executed PrintNow.sql' ;

go



go
Print '--------------------------------------------------------------';
Print 'END/start:';
print getdate();
Print '--------------------------------------------------------------';
go

PRINT 'Processing: Proc_EDW_TrackerMetadataExtract';
GO
IF EXISTS (SELECT
				  *
				  FROM sysobjects
				  WHERE name = 'Proc_EDW_TrackerMetadataExtract'
					AND Xtype = 'P') 
	BEGIN
		DROP PROCEDURE
			 Proc_EDW_TrackerMetadataExtract;
	END;
GO

--exec Proc_EDW_TrackerMetadataExtract 'HFit.TrackerWater'
--select * from #Temp_TrackerMetaData
--select * from Tracker_EDW_Metadata
--truncate table Tracker_EDW_Metadata

CREATE PROCEDURE dbo.Proc_EDW_TrackerMetadataExtract (
	   @TrackerClassName AS nvarchar (250)) 
AS
BEGIN
	IF EXISTS (SELECT
					  name
					  FROM tempdb.dbo.sysobjects
					  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
		BEGIN
			DROP TABLE
				 #Temp_TrackerMetaData;
		END;
	DECLARE @MetaDataLastLoadDate datetime;
	DECLARE @ClassLastModified datetime;
	DECLARE @Xml xml;
	DECLARE @docHandle int;
	DECLARE @form nvarchar (250) ;
	DECLARE @dbForm nvarchar (250) ;
	DECLARE @id int;
	DECLARE @parent int;
	DECLARE @nodetype int;
	DECLARE @localname nvarchar (250) ;
	DECLARE @prefix nvarchar (250) ;
	DECLARE @namespaceuri nvarchar (250) ;
	DECLARE @datatype nvarchar (250) ;
	DECLARE @prev nvarchar (250) ;
	DECLARE @dbText nvarchar (250) ;
	DECLARE @ParentName nvarchar (250) ;
	DECLARE @TableName nvarchar (100) ;
	DECLARE @ColName nvarchar (100) ;
	DECLARE @AttrName nvarchar (100) ;
	DECLARE @AttrVal nvarchar (250) ;
	DECLARE @CurrName nvarchar (250) ;
	DECLARE @SkipIfNoChange bit;

		--alter table [Tracker_EDW_Metadata] add ClassLastModified datetime null
	--drop table Tracker_EDW_Metadata; 
	IF NOT EXISTS (SELECT
						  name
						  FROM sysobjects
						  WHERE ID = OBJECT_ID (N'Tracker_EDW_Metadata')) 
		BEGIN
			CREATE TABLE dbo.Tracker_EDW_Metadata (
						 TableName nvarchar (100) NOT NULL
					   , ColName nvarchar (100) NOT NULL
					   , AttrName nvarchar (100) NOT NULL
					   , AttrVal nvarchar (250) NULL
					   , CreatedDate datetime2 (7) NULL
					   , LastModifiedDate datetime2 (7) NULL
					   , ID int IDENTITY (1, 1) 
								NOT NULL
					   , ClassLastModified datetime2 (7) NULL) ;
			ALTER TABLE dbo.Tracker_EDW_Metadata
			ADD
						CONSTRAINT DF_Tracker_EDW_Metadata_CreatedDate DEFAULT GETDATE () FOR CreatedDate;
			ALTER TABLE dbo.Tracker_EDW_Metadata
			ADD
						CONSTRAINT DF_Tracker_EDW_Metadata_LastModifiedDate DEFAULT GETDATE () FOR LastModifiedDate;
			CREATE UNIQUE CLUSTERED INDEX PK_Tracker_EDW_Metadata ON dbo.Tracker_EDW_Metadata (TableName ASC, ColName ASC, AttrName ASC) ;
		END;
	IF NOT EXISTS (SELECT
						  column_name
						  FROM information_schema.columns
						  WHERE column_name = 'ClassLastModified'
							AND table_name = 'Tracker_EDW_Metadata') 
		BEGIN
			PRINT 'MISSING: Tracker_EDW_Metadata ClassLastModified, added to table.';
			ALTER TABLE Tracker_EDW_Metadata
			ADD
						ClassLastModified datetime NULL;
		END;
	ELSE
		BEGIN
			PRINT 'FOUND: Tracker_EDW_Metadata ClassLastModified';
		END;

	SELECT
		   @form = @TrackerClassName;

	--select * from information_schema.columns where column_name = 'ClassLastModified'

	IF EXISTS (SELECT
					  column_name
					  FROM information_schema.columns
					  WHERE column_name = 'ClassLastModified'
						AND table_name = 'Tracker_EDW_Metadata') 
		BEGIN
			SELECT
				   @MetaDataLastLoadDate = (
											SELECT TOP 1
												   ClassLastModified
												   FROM Tracker_EDW_Metadata
												   WHERE TableName = @form) ;
			SELECT
				   @ClassLastModified = (
										 SELECT TOP 1
												ClassLastModified
												FROM CMS_CLASS
												WHERE ClassName = @form) ;
			SET @SkipIfNoChange = 1;
			IF @SkipIfNoChange = 1
				BEGIN
					IF @MetaDataLastLoadDate = @ClassLastModified
						BEGIN
							PRINT 'No Change in ' + @form + ', no updates needed.';
							RETURN;
						END;
					ELSE
						BEGIN
							PRINT 'Changes found in ' + @form + ', processing.';
						END;
				END;
			PRINT '@MetaDataLastLoadDate: ' + CAST (@MetaDataLastLoadDate AS varchar (50)) ;
			PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (50)) ;
		END;
	SELECT
		   @Xml = (
				   SELECT
						  ClassFormDefinition
						  FROM CMS_Class
						  WHERE ClassName LIKE @form) ;

	--print (cast( @Xml as varchar(max)));

	EXEC sp_xml_preparedocument @docHandle OUTPUT, @Xml;


	IF NOT EXISTS (SELECT
						  name
						  FROM tempdb.dbo.sysobjects
						  WHERE ID = OBJECT_ID (N'tempdb..#Temp_TrackerMetaData')) 
		BEGIN
			SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text INTO
							 #Temp_TrackerMetaData
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;

			--WHERE localname not in ('isPK');		

			CREATE INDEX TMPPI_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (parentid) ;
			CREATE INDEX TMPPI2_HealthAssesmentUserQuestion ON #Temp_TrackerMetaData (id) ;
		END;
	ELSE
		BEGIN
			truncate TABLE #Temp_TrackerMetaData;
			INSERT INTO #Temp_TrackerMetaData
			SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text
				   FROM OPENXML (@docHandle, N'/form/field') AS XMLDATA;
		END;
	DELETE FROM Tracker_EDW_Metadata
	WHERE
		  TableName = @form;
	SET @ClassLastModified = (SELECT
									 ClassLastModified
									 FROM CMS_CLASS
									 WHERE ClassName = @Form) ;
	PRINT '@ClassLastModified: ' + CAST (@ClassLastModified AS varchar (250)) ;
	DECLARE C CURSOR
		FOR SELECT
				   @form AS form
				 , id
				 , parentid
				 , nodetype
				 , localname
				 , prefix
				 , namespaceuri
				 , datatype
				 , prev
				 , text
				   FROM #Temp_TrackerMetaData AS XMLDATA;
	OPEN C;
	FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
	WHILE @@FETCH_STATUS = 0
		BEGIN

			--print ('* @localname :' + @localname) ;
			--print ('* @ColName :' + isnull(@ColName, 'XX') + ':') ;
			--print ('* @dbText :' + @dbText + ':') ;

			IF @localname = 'column'
				BEGIN

					--print ('** START COLUMN DEF: ') ;

					SET @ColName = (SELECT
										   text
										   FROM #Temp_TrackerMetaData
										   WHERE parentid = @id) ;

				--print ('** COLUMN DEF: ' + @form + ' : ' + @colname) ;

				END;
			IF @dbText IS NOT NULL
				BEGIN

					--print ('* ENTER @dbText :' + @dbText + ':' + cast(@parent as varchar(10))) ;

					SET @AttrName = (SELECT
											localname
											FROM #Temp_TrackerMetaData
											WHERE id = @parent) ;

					--set @ParentName = (select [localname] FROM OPENXML(@docHandle, N'/form/field') where id = @parent);	
					--print ('1 - @AttrName: ' + @form +' : ' + isnull(@ColName, 'NA') + ' : ' + @AttrName + ' : ' + @dbText) ;	

					IF EXISTS (SELECT
									  TableName
									  FROM Tracker_EDW_Metadata
									  WHERE Tablename = @form
										AND ColName = @ColName
										AND AttrName = @dbText) 
						BEGIN

							--print('Update Tracker_EDW_Metadata set AttrVal = ' + @dbText + ' Where Tablename = ' + @form + ' and ColName = ' + @ColName + ' and AttrName = ' + @AttrName + ';');

							UPDATE Tracker_EDW_Metadata
							SET
								AttrVal = @dbText
							  ,
								ClassLastModified = @ClassLastModified
							WHERE
								  Tablename = @form
							  AND ColName = @ColName
							  AND AttrName = @dbText;
						END;
					ELSE
						BEGIN

							--print ('insert into Tracker_EDW_Metadata (TableName, ColName, AttrName, AttrVal, ClassLastModified) values ('+@form+', '+@ColName+', '+@AttrName+', '+@dbText +', ' + cast(@ClassLastModified as varchar(50))+ ') ') ;

							INSERT INTO Tracker_EDW_Metadata (
										TableName
									  , ColName
									  , AttrName
									  , AttrVal
									  , ClassLastModified) 
							VALUES
								 (@form, @ColName, @AttrName, @dbText, @ClassLastModified) ;
							UPDATE Tracker_EDW_Metadata
							SET
								ClassLastModified = @ClassLastModified
							WHERE
								  Tablename = @form
							  AND ColName = @ColName
							  AND AttrName = @dbText;
						END;
				END;
			IF @localname = 'columntype'
		   AND @ColName IS NOT NULL
				BEGIN
					PRINT '---- COLUMN TYPE DEF: ' + @form + ' : ' + @colname + ' : ' + @dbText;
				END;
			IF @localname = 'field'
				BEGIN
					SET @ParentName = NULL;
					SET @ColName = NULL;

				--print ('***** field @ParentName: ' + @ParentName) ;

				END;
			FETCH NEXT FROM C INTO @dbForm, @id, @parent, @nodetype, @localname, @prefix, @namespaceuri, @datatype, @prev, @dbText;
		END;
	CLOSE C;
	DEALLOCATE C;
END;

--Clean up the EDW Tracker MetaData
--delete from Tracker_EDW_Metadata where colname in ('ItemID','ItemCreatedBy','ItemCreatedWhen','ItemModifiedBy','ItemModifiedWhen','EventDate','IsProfessionally Collected','TrackerCollectionSourceId','UserID','Notes','IsProcessedForHA');

GO
PRINT 'ProcessED and created : Proc_EDW_TrackerMetadataExtract';
GO
PRINT '***** FROM: Proc_EDW_TrackerMetadataExtract.sql';
GO 

--START ENDING THE IVP
GO


DECLARE @DBNAME nvarchar (100) ;
DECLARE @ServerName nvarchar (80) ;
SET @ServerName = (SELECT
                          @@SERVERNAME) ;
SET @DBNAME = (SELECT
                      DB_NAME () AS [Current Database]) ;

PRINT '--';
PRINT '*************************************************************************************************************';
PRINT 'IVP Processing complete - please check for errors: on database ' + @DBNAME + ' : ON SERVER : ' + @ServerName + ' ON ' + CAST (GETDATE () AS nvarchar (50)) ;
PRINT '*************************************************************************************************************';
--  
GO
PRINT '***** FROM: TheEnd.sql';
GO 
