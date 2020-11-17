
GO
PRINT 'Creating Role Eligibility tables.';
PRINT 'FROM Create_Tables_RoleEligibility.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.tables
             WHERE name = 'EDW_RoleMemberHistory') 
    BEGIN
        DROP TABLE
             EDW_RoleMemberHistory;
    END;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.triggers
             WHERE name = 'trgEDWRoleEligibilityLastModDate') 
    BEGIN
        DROP TRIGGER
             trgEDWRoleEligibilityLastModDate;
    END;
GO
PRINT 'Creating EDW_RoleMemberHistory.';
GO
CREATE TABLE dbo.EDW_RoleMemberHistory (
             UserID int NOT NULL
           , RoleID int NOT NULL
           , RoleGUID uniqueidentifier NOT NULL
           , RoleName nvarchar (100) NOT NULL
           , ValidTo datetime2 (7) NULL
           , HFitUserMPINumber bigint NOT NULL
           , AccountCD nvarchar (8) NOT NULL
           , AccountID int NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , RoleStartDate datetime2 (7) NOT NULL
           , RoleEndDate datetime2 (7) NULL
           , LastModifiedDate datetime2 (7) DEFAULT GETDATE () 
           , RowNbr int IDENTITY (1, 1) 
);
GO

PRINT 'Creating [PI_EDW_RoleMemberHistory_RowNbr]';
CREATE NONCLUSTERED INDEX PI_EDW_RoleMemberHistory_RowNbr ON dbo.EDW_RoleMemberHistory
(
RowNbr ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

PRINT 'Creating [PI_EDW_RoleMemberHistory_LastMod]';
CREATE NONCLUSTERED INDEX PI_EDW_RoleMemberHistory_LastMod ON dbo.EDW_RoleMemberHistory
(
LastModifiedDate
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

PRINT 'Creating [PI_EDW_RoleMemberHistory_UserID]';
CREATE NONCLUSTERED INDEX PI_EDW_RoleMemberHistory_UserID ON dbo.EDW_RoleMemberHistory
(
UserID ASC, RoleName, RoleEndDate
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

PRINT 'Creating [PI_EDW_RoleMemberHistory_RoleEndDate]';
CREATE NONCLUSTERED INDEX PI_EDW_RoleMemberHistory_RoleEndDate
ON EDW_RoleMemberHistory (RoleEndDate) 
INCLUDE (UserID) ;

GO
PRINT '********************************************************************';
PRINT 'Creating trgSchemaMonitor                         ******************';
PRINT '********************************************************************';

--select * from EDW_RoleMemberHistory
GO
CREATE TRIGGER trgEDWRoleEligibilityLastModDate ON EDW_RoleMemberHistory
    AFTER UPDATE
AS
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
SET QUOTED_IDENTIFIER ON;
SET NOCOUNT ON;

UPDATE HIST
       SET
           LastModifiedDate = GETDATE () 
           FROM EDW_RoleMemberHistory AS HIST
                    JOIN INSERTED AS I
                        ON I.RowNbr = HIST.RowNbr;

SET NOCOUNT OFF;
GO

PRINT '********************************************************************';
PRINT 'Created trgSchemaMonitor HAS BEEN CREATED       ******************';
PRINT '********************************************************************';

IF EXISTS (SELECT
                  name
                  FROM sys.tables
             WHERE name = 'EDW_RoleMemberToday') 
    BEGIN
        DROP TABLE
             EDW_RoleMemberToday;
    END;
GO
PRINT 'Creating EDW_RoleMemberToday.';

GO
CREATE TABLE dbo.EDW_RoleMemberToday (
             UserID int NOT NULL
           , RoleID int NOT NULL
           , RoleGUID uniqueidentifier NOT NULL
           , RoleName nvarchar (100) NOT NULL
           , ValidTo datetime2 (7) NULL
           , HFitUserMPINumber bigint NOT NULL
           , AccountCD nvarchar (8) NOT NULL
           , AccountID int NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , RoleStartDate datetime2 (7) NOT NULL
           , RoleEndDate datetime2 (7) NULL
           , LastModifiedDate datetime2 (7) DEFAULT GETDATE () 
);
GO
PRINT 'Creating [PI_EDW_RoleMemberToday_UserID]';
CREATE NONCLUSTERED INDEX PI_EDW_RoleMemberToday_UserID ON dbo.EDW_RoleMemberToday
(
UserID, RoleName, RoleEndDate
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

GO
IF EXISTS (SELECT
                  name
                  FROM sys.tables
             WHERE name = 'EDW_RoleMembership') 
    BEGIN
        DROP TABLE
             EDW_RoleMembership;
    END;
GO
PRINT 'Creating EDW_RoleMembership.';
GO
CREATE TABLE dbo.EDW_RoleMembership (
             UserID int NOT NULL
           , RoleID int NOT NULL
           , RoleGUID uniqueidentifier NOT NULL
           , RoleName nvarchar (100) NOT NULL
           , ValidTo datetime2 (7) NULL
           , HFitUserMPINumber bigint NOT NULL
           , AccountCD nvarchar (8) NOT NULL
           , AccountID int NOT NULL
           , SiteGUID uniqueidentifier NOT NULL
           , RoleStartDate datetime2 (7) NOT NULL
           , RoleEndDate datetime2 (7) NULL
           , LastModifiedDate datetime2 (7) DEFAULT GETDATE () 
);
GO
PRINT 'Creating [PI_EDW_RoleMembership_UserID]';
CREATE NONCLUSTERED INDEX PI_EDW_RoleMembership_UserID ON dbo.EDW_RoleMembership
(
    UserID, RoleName, RoleEndDate
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

GO
IF EXISTS (SELECT
                  name
                  FROM sys.tables
             WHERE name = 'LKP_EDW_CMSRole') 
    BEGIN
        DROP TABLE
             LKP_EDW_CMSRole;
    END;
GO
PRINT 'Creating LKP_EDW_CMSRole.';
CREATE TABLE dbo.LKP_EDW_CMSRole (
             RoleName nvarchar (100) NOT NULL,
);

CREATE unique CLUSTERED INDEX PK_LKP_EDW_CMSRole ON dbo.LKP_EDW_CMSRole
(
RoleName
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;


GO
--proc_build_EDW_Eligibility
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('Platform') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('Challenges') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('HealthAdvising') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('HealthAssessment') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('Rewards') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('Screeners') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('ScreeningScheduler') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('Coaching') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('CoachingEligible') ;
INSERT INTO LKP_EDW_CMSRole (
       RoleName) 
VALUES
       ('CoachingEnrollment') ;

GO
PRINT 'Created Role Eligibility tables.';
GO 






