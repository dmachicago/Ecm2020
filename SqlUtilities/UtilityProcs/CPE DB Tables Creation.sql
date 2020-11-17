/*
 * Company :      DMA Limited of Chicago
 * Project :      CpeMgt.DM1
 * Author :       DMA DBA Group
 *
 * Date Created : Sunday, March 1990 13:08:09
 * Target DBMS : Microsoft SQL Server 2000
 */

/* 
 * TABLE: CompletedCourse 
 */

CREATE TABLE CompletedCourse(
    UserLoginID    nvarchar(50)    NOT NULL,
    CourseID       nvarchar(80)    NOT NULL,
    ProviderID     nvarchar(50)    NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY CLUSTERED (UserLoginID, CourseID, ProviderID)
)
go



IF OBJECT_ID('CompletedCourse') IS NOT NULL
    PRINT '<<< CREATED TABLE CompletedCourse >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CompletedCourse >>>'
go

/* 
 * TABLE: Course 
 */

CREATE TABLE Course(
    CourseID            nvarchar(80)      NOT NULL,
    CourseDescrition    nvarchar(2000)    NULL,
    CPE                 int               NULL,
    CONSTRAINT PK2 PRIMARY KEY CLUSTERED (CourseID)
)
go



IF OBJECT_ID('Course') IS NOT NULL
    PRINT '<<< CREATED TABLE Course >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Course >>>'
go

/* 
 * TABLE: CourseProvider 
 */

CREATE TABLE CourseProvider(
    CourseID      nvarchar(80)    NOT NULL,
    ProviderID    nvarchar(50)    NOT NULL,
    CPE           int             NULL,
    StartDate     datetime        NULL,
    EndDate       datetime        NULL,
    AddrLine1     nvarchar(50)    NULL,
    AddrLine2     nvarchar(50)    NULL,
    AddrLine3     nvarchar(50)    NULL,
    AddrCity      nvarchar(50)    NULL,
    AddrState     char(50)        NULL,
    AddrZip       nvarchar(50)    NULL,
    CONSTRAINT PK7 PRIMARY KEY CLUSTERED (CourseID, ProviderID)
)
go



IF OBJECT_ID('CourseProvider') IS NOT NULL
    PRINT '<<< CREATED TABLE CourseProvider >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CourseProvider >>>'
go

/* 
 * TABLE: CpeStats 
 */

CREATE TABLE CpeStats(
    UserLoginID              nvarchar(50)     NOT NULL,
    CourseID                 nvarchar(80)     NOT NULL,
    ProviderID               nvarchar(50)     NOT NULL,
    ScheduledToStart         bit              NULL,
    CompletedSuccessfully    bit              NULL,
    FailedToAttend           bit              NULL,
    FailedCourse             bit              NULL,
    Notes                    nvarchar(max)    NULL,
    CONSTRAINT PK6 PRIMARY KEY CLUSTERED (UserLoginID, CourseID, ProviderID)
)
go



IF OBJECT_ID('CpeStats') IS NOT NULL
    PRINT '<<< CREATED TABLE CpeStats >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CpeStats >>>'
go

/* 
 * TABLE: Provider 
 */

CREATE TABLE Provider(
    ProviderID       nvarchar(50)      NOT NULL,
    ProviderName     nvarchar(100)     NULL,
    ActiveFlg        bit               NULL,
    ProviderWeb      nvarchar(100)     NULL,
    ProviderNotes    nvarchar(2000)    NULL,
    Instructor       nvarchar(100)     NULL,
    AddrLine1        nvarchar(50)      NULL,
    AddrLine2        nvarchar(50)      NULL,
    AddrLine3        nvarchar(50)      NULL,
    AddrCity         nvarchar(50)      NULL,
    AddrState        char(50)          NULL,
    AddrZip          nvarchar(50)      NULL,
    CONSTRAINT PK7_1 PRIMARY KEY CLUSTERED (ProviderID)
)
go



IF OBJECT_ID('Provider') IS NOT NULL
    PRINT '<<< CREATED TABLE Provider >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Provider >>>'
go

/* 
 * TABLE: RequiredCourse 
 */

CREATE TABLE RequiredCourse(
    UserLoginID    nvarchar(50)    NOT NULL,
    CourseID       nvarchar(80)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY CLUSTERED (UserLoginID, CourseID)
)
go



IF OBJECT_ID('RequiredCourse') IS NOT NULL
    PRINT '<<< CREATED TABLE RequiredCourse >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE RequiredCourse >>>'
go

/* 
 * TABLE: Users 
 */

CREATE TABLE Users(
    UserLoginID    nvarchar(50)     NOT NULL,
    UserEmail      nvarchar(80)     NULL,
    FirstName      nvarchar(50)     NULL,
    MiddleName     nvarchar(50)     NULL,
    LastName       nvarchar(50)     NULL,
    CellPhone      nvarchar(50)     NULL,
    OfficePhone    nvarchar(50)     NULL,
    AddrLine1      nvarchar(100)    NULL,
    AddrLine2      nvarchar(100)    NULL,
    AddrLine3      nvarchar(100)    NULL,
    AddrCity       nvarchar(50)     NULL,
    AddrState      char(2)          NULL,
    AddrZip        nvarchar(50)     NULL,
    AddrCountry    nvarchar(50)     NULL,
    CONSTRAINT PK1 PRIMARY KEY CLUSTERED (UserLoginID)
)
go



IF OBJECT_ID('Users') IS NOT NULL
    PRINT '<<< CREATED TABLE Users >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Users >>>'
go

/* 
 * INDEX: Ref14 
 */

CREATE INDEX Ref14 ON CompletedCourse(UserLoginID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('CompletedCourse') AND name='Ref14')
    PRINT '<<< CREATED INDEX CompletedCourse.Ref14 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CompletedCourse.Ref14 >>>'
go

/* 
 * INDEX: Ref710 
 */

CREATE INDEX Ref710 ON CompletedCourse(CourseID, ProviderID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('CompletedCourse') AND name='Ref710')
    PRINT '<<< CREATED INDEX CompletedCourse.Ref710 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CompletedCourse.Ref710 >>>'
go

/* 
 * INDEX: Ref21 
 */

CREATE INDEX Ref21 ON CourseProvider(CourseID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('CourseProvider') AND name='Ref21')
    PRINT '<<< CREATED INDEX CourseProvider.Ref21 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CourseProvider.Ref21 >>>'
go

/* 
 * INDEX: Ref811 
 */

CREATE INDEX Ref811 ON CourseProvider(ProviderID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('CourseProvider') AND name='Ref811')
    PRINT '<<< CREATED INDEX CourseProvider.Ref811 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CourseProvider.Ref811 >>>'
go

/* 
 * INDEX: Ref15 
 */

CREATE INDEX Ref15 ON CpeStats(UserLoginID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('CpeStats') AND name='Ref15')
    PRINT '<<< CREATED INDEX CpeStats.Ref15 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CpeStats.Ref15 >>>'
go

/* 
 * INDEX: Ref712 
 */

CREATE INDEX Ref712 ON CpeStats(CourseID, ProviderID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('CpeStats') AND name='Ref712')
    PRINT '<<< CREATED INDEX CpeStats.Ref712 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CpeStats.Ref712 >>>'
go

/* 
 * INDEX: Ref13 
 */

CREATE INDEX Ref13 ON RequiredCourse(UserLoginID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('RequiredCourse') AND name='Ref13')
    PRINT '<<< CREATED INDEX RequiredCourse.Ref13 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX RequiredCourse.Ref13 >>>'
go

/* 
 * INDEX: Ref28 
 */

CREATE INDEX Ref28 ON RequiredCourse(CourseID)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('RequiredCourse') AND name='Ref28')
    PRINT '<<< CREATED INDEX RequiredCourse.Ref28 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX RequiredCourse.Ref28 >>>'
go

/* 
 * TABLE: CompletedCourse 
 */

ALTER TABLE CompletedCourse ADD CONSTRAINT RefUsers4 
    FOREIGN KEY (UserLoginID)
    REFERENCES Users(UserLoginID) ON DELETE CASCADE ON UPDATE CASCADE
go

ALTER TABLE CompletedCourse ADD CONSTRAINT RefCourseProvider10 
    FOREIGN KEY (CourseID, ProviderID)
    REFERENCES CourseProvider(CourseID, ProviderID) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * TABLE: CourseProvider 
 */

ALTER TABLE CourseProvider ADD CONSTRAINT RefCourse1 
    FOREIGN KEY (CourseID)
    REFERENCES Course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE
go

ALTER TABLE CourseProvider ADD CONSTRAINT RefProvider11 
    FOREIGN KEY (ProviderID)
    REFERENCES Provider(ProviderID) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * TABLE: CpeStats 
 */

ALTER TABLE CpeStats ADD CONSTRAINT RefUsers5 
    FOREIGN KEY (UserLoginID)
    REFERENCES Users(UserLoginID) ON DELETE CASCADE ON UPDATE CASCADE
go

ALTER TABLE CpeStats ADD CONSTRAINT RefCourseProvider12 
    FOREIGN KEY (CourseID, ProviderID)
    REFERENCES CourseProvider(CourseID, ProviderID) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * TABLE: RequiredCourse 
 */

ALTER TABLE RequiredCourse ADD CONSTRAINT RefUsers3 
    FOREIGN KEY (UserLoginID)
    REFERENCES Users(UserLoginID) ON DELETE CASCADE ON UPDATE CASCADE
go

ALTER TABLE RequiredCourse ADD CONSTRAINT RefCourse8 
    FOREIGN KEY (CourseID)
    REFERENCES Course(CourseID) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * PROCEDURE: CompletedCourseInsProc 
 */

CREATE PROCEDURE CompletedCourseInsProc
(
    @UserLoginID     nvarchar(50),
    @CourseID        nvarchar(80),
    @ProviderID      nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO CompletedCourse(UserLoginID,
                                CourseID,
                                ProviderID)
    VALUES(@UserLoginID,
           @CourseID,
           @ProviderID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'CompletedCourseInsProc: Cannot insert because primary key value not found in CompletedCourse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('CompletedCourseInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CompletedCourseInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CompletedCourseInsProc >>>'
go



/* 
 * PROCEDURE: CompletedCourseDelProc 
 */

CREATE PROCEDURE CompletedCourseDelProc
(
    @UserLoginID     nvarchar(50),
    @CourseID        nvarchar(80),
    @ProviderID      nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM CompletedCourse
     WHERE UserLoginID = @UserLoginID
       AND CourseID    = @CourseID
       AND ProviderID  = @ProviderID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'CompletedCourseDelProc: Cannot delete because foreign keys still exist in CompletedCourse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('CompletedCourseDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CompletedCourseDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CompletedCourseDelProc >>>'
go


/* 
 * PROCEDURE: CompletedCourseSelProc 
 */

CREATE PROCEDURE CompletedCourseSelProc
(
    @UserLoginID     nvarchar(50),
    @CourseID        nvarchar(80),
    @ProviderID      nvarchar(50))
AS
BEGIN
    SELECT UserLoginID,
           CourseID,
           ProviderID
      FROM CompletedCourse
     WHERE UserLoginID = @UserLoginID
       AND CourseID    = @CourseID
       AND ProviderID  = @ProviderID

    RETURN(0)
END
go
IF OBJECT_ID('CompletedCourseSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CompletedCourseSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CompletedCourseSelProc >>>'
go


/* 
 * PROCEDURE: CourseInsProc 
 */

CREATE PROCEDURE CourseInsProc
(
    @CourseID             nvarchar(80),
    @CourseDescrition     nvarchar(2000)            = NULL,
    @CPE                  int                       = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Course(CourseID,
                       CourseDescrition,
                       CPE)
    VALUES(@CourseID,
           @CourseDescrition,
           @CPE)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'CourseInsProc: Cannot insert because primary key value not found in Course '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('CourseInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseInsProc >>>'
go


/* 
 * PROCEDURE: CourseUpdProc 
 */

CREATE PROCEDURE CourseUpdProc
(
    @CourseID             nvarchar(80),
    @CourseDescrition     nvarchar(2000)            = NULL,
    @CPE                  int                       = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Course
       SET CourseDescrition      = @CourseDescrition,
           CPE                   = @CPE
     WHERE CourseID = @CourseID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'CourseUpdProc: Cannot update  in Course '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('CourseUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseUpdProc >>>'
go


/* 
 * PROCEDURE: CourseDelProc 
 */

CREATE PROCEDURE CourseDelProc
(
    @CourseID             nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Course
     WHERE CourseID = @CourseID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'CourseDelProc: Cannot delete because foreign keys still exist in Course '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('CourseDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseDelProc >>>'
go


/* 
 * PROCEDURE: CourseSelProc 
 */

CREATE PROCEDURE CourseSelProc
(
    @CourseID             nvarchar(80))
AS
BEGIN
    SELECT CourseID,
           CourseDescrition,
           CPE
      FROM Course
     WHERE CourseID = @CourseID

    RETURN(0)
END
go
IF OBJECT_ID('CourseSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseSelProc >>>'
go


/* 
 * PROCEDURE: CourseProviderInsProc 
 */

CREATE PROCEDURE CourseProviderInsProc
(
    @CourseID       nvarchar(80),
    @ProviderID     nvarchar(50),
    @CPE            int                     = NULL,
    @StartDate      datetime                = NULL,
    @EndDate        datetime                = NULL,
    @AddrLine1      nvarchar(50)            = NULL,
    @AddrLine2      nvarchar(50)            = NULL,
    @AddrLine3      nvarchar(50)            = NULL,
    @AddrCity       nvarchar(50)            = NULL,
    @AddrState      char(50)                = NULL,
    @AddrZip        nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO CourseProvider(CourseID,
                               ProviderID,
                               CPE,
                               StartDate,
                               EndDate,
                               AddrLine1,
                               AddrLine2,
                               AddrLine3,
                               AddrCity,
                               AddrState,
                               AddrZip)
    VALUES(@CourseID,
           @ProviderID,
           @CPE,
           @StartDate,
           @EndDate,
           @AddrLine1,
           @AddrLine2,
           @AddrLine3,
           @AddrCity,
           @AddrState,
           @AddrZip)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'CourseProviderInsProc: Cannot insert because primary key value not found in CourseProvider '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('CourseProviderInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseProviderInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseProviderInsProc >>>'
go


/* 
 * PROCEDURE: CourseProviderUpdProc 
 */

CREATE PROCEDURE CourseProviderUpdProc
(
    @CourseID       nvarchar(80),
    @ProviderID     nvarchar(50),
    @CPE            int                     = NULL,
    @StartDate      datetime                = NULL,
    @EndDate        datetime                = NULL,
    @AddrLine1      nvarchar(50)            = NULL,
    @AddrLine2      nvarchar(50)            = NULL,
    @AddrLine3      nvarchar(50)            = NULL,
    @AddrCity       nvarchar(50)            = NULL,
    @AddrState      char(50)                = NULL,
    @AddrZip        nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE CourseProvider
       SET CPE             = @CPE,
           StartDate       = @StartDate,
           EndDate         = @EndDate,
           AddrLine1       = @AddrLine1,
           AddrLine2       = @AddrLine2,
           AddrLine3       = @AddrLine3,
           AddrCity        = @AddrCity,
           AddrState       = @AddrState,
           AddrZip         = @AddrZip
     WHERE CourseID   = @CourseID
       AND ProviderID = @ProviderID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'CourseProviderUpdProc: Cannot update  in CourseProvider '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('CourseProviderUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseProviderUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseProviderUpdProc >>>'
go


/* 
 * PROCEDURE: CourseProviderDelProc 
 */

CREATE PROCEDURE CourseProviderDelProc
(
    @CourseID       nvarchar(80),
    @ProviderID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM CourseProvider
     WHERE CourseID   = @CourseID
       AND ProviderID = @ProviderID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'CourseProviderDelProc: Cannot delete because foreign keys still exist in CourseProvider '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('CourseProviderDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseProviderDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseProviderDelProc >>>'
go


/* 
 * PROCEDURE: CourseProviderSelProc 
 */

CREATE PROCEDURE CourseProviderSelProc
(
    @CourseID       nvarchar(80),
    @ProviderID     nvarchar(50))
AS
BEGIN
    SELECT CourseID,
           ProviderID,
           CPE,
           StartDate,
           EndDate,
           AddrLine1,
           AddrLine2,
           AddrLine3,
           AddrCity,
           AddrState,
           AddrZip
      FROM CourseProvider
     WHERE CourseID   = @CourseID
       AND ProviderID = @ProviderID

    RETURN(0)
END
go
IF OBJECT_ID('CourseProviderSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CourseProviderSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CourseProviderSelProc >>>'
go


/* 
 * PROCEDURE: CpeStatsInsProc 
 */

CREATE PROCEDURE CpeStatsInsProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @ScheduledToStart          bit                      = NULL,
    @CompletedSuccessfully     bit                      = NULL,
    @FailedToAttend            bit                      = NULL,
    @FailedCourse              bit                      = NULL,
    @Notes                     nvarchar(max)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO CpeStats(UserLoginID,
                         CourseID,
                         ProviderID,
                         ScheduledToStart,
                         CompletedSuccessfully,
                         FailedToAttend,
                         FailedCourse,
                         Notes)
    VALUES(@UserLoginID,
           @CourseID,
           @ProviderID,
           @ScheduledToStart,
           @CompletedSuccessfully,
           @FailedToAttend,
           @FailedCourse,
           @Notes)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'CpeStatsInsProc: Cannot insert because primary key value not found in CpeStats '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('CpeStatsInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CpeStatsInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CpeStatsInsProc >>>'
go


/* 
 * PROCEDURE: CpeStatsUpdProc 
 */

CREATE PROCEDURE CpeStatsUpdProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @ScheduledToStart          bit                      = NULL,
    @CompletedSuccessfully     bit                      = NULL,
    @FailedToAttend            bit                      = NULL,
    @FailedCourse              bit                      = NULL,
    @Notes                     nvarchar(max)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE CpeStats
       SET ScheduledToStart           = @ScheduledToStart,
           CompletedSuccessfully      = @CompletedSuccessfully,
           FailedToAttend             = @FailedToAttend,
           FailedCourse               = @FailedCourse,
           Notes                      = @Notes
     WHERE UserLoginID = @UserLoginID
       AND CourseID    = @CourseID
       AND ProviderID  = @ProviderID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'CpeStatsUpdProc: Cannot update  in CpeStats '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('CpeStatsUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CpeStatsUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CpeStatsUpdProc >>>'
go


/* 
 * PROCEDURE: CpeStatsDelProc 
 */

CREATE PROCEDURE CpeStatsDelProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM CpeStats
     WHERE UserLoginID = @UserLoginID
       AND CourseID    = @CourseID
       AND ProviderID  = @ProviderID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'CpeStatsDelProc: Cannot delete because foreign keys still exist in CpeStats '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('CpeStatsDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CpeStatsDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CpeStatsDelProc >>>'
go


/* 
 * PROCEDURE: CpeStatsSelProc 
 */

CREATE PROCEDURE CpeStatsSelProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50))
AS
BEGIN
    SELECT UserLoginID,
           CourseID,
           ProviderID,
           ScheduledToStart,
           CompletedSuccessfully,
           FailedToAttend,
           FailedCourse,
           Notes
      FROM CpeStats
     WHERE UserLoginID = @UserLoginID
       AND CourseID    = @CourseID
       AND ProviderID  = @ProviderID

    RETURN(0)
END
go
IF OBJECT_ID('CpeStatsSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE CpeStatsSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE CpeStatsSelProc >>>'
go


/* 
 * PROCEDURE: ProviderInsProc 
 */

CREATE PROCEDURE ProviderInsProc
(
    @ProviderID        nvarchar(50),
    @ProviderName      nvarchar(100)             = NULL,
    @ActiveFlg         bit                       = NULL,
    @ProviderWeb       nvarchar(100)             = NULL,
    @ProviderNotes     nvarchar(2000)            = NULL,
    @Instructor        nvarchar(100)             = NULL,
    @AddrLine1         nvarchar(50)              = NULL,
    @AddrLine2         nvarchar(50)              = NULL,
    @AddrLine3         nvarchar(50)              = NULL,
    @AddrCity          nvarchar(50)              = NULL,
    @AddrState         char(50)                  = NULL,
    @AddrZip           nvarchar(50)              = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Provider(ProviderID,
                         ProviderName,
                         ActiveFlg,
                         ProviderWeb,
                         ProviderNotes,
                         Instructor,
                         AddrLine1,
                         AddrLine2,
                         AddrLine3,
                         AddrCity,
                         AddrState,
                         AddrZip)
    VALUES(@ProviderID,
           @ProviderName,
           @ActiveFlg,
           @ProviderWeb,
           @ProviderNotes,
           @Instructor,
           @AddrLine1,
           @AddrLine2,
           @AddrLine3,
           @AddrCity,
           @AddrState,
           @AddrZip)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ProviderInsProc: Cannot insert because primary key value not found in Provider '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('ProviderInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE ProviderInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE ProviderInsProc >>>'
go


/* 
 * PROCEDURE: ProviderUpdProc 
 */

CREATE PROCEDURE ProviderUpdProc
(
    @ProviderID        nvarchar(50),
    @ProviderName      nvarchar(100)             = NULL,
    @ActiveFlg         bit                       = NULL,
    @ProviderWeb       nvarchar(100)             = NULL,
    @ProviderNotes     nvarchar(2000)            = NULL,
    @Instructor        nvarchar(100)             = NULL,
    @AddrLine1         nvarchar(50)              = NULL,
    @AddrLine2         nvarchar(50)              = NULL,
    @AddrLine3         nvarchar(50)              = NULL,
    @AddrCity          nvarchar(50)              = NULL,
    @AddrState         char(50)                  = NULL,
    @AddrZip           nvarchar(50)              = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Provider
       SET ProviderName       = @ProviderName,
           ActiveFlg          = @ActiveFlg,
           ProviderWeb        = @ProviderWeb,
           ProviderNotes      = @ProviderNotes,
           Instructor         = @Instructor,
           AddrLine1          = @AddrLine1,
           AddrLine2          = @AddrLine2,
           AddrLine3          = @AddrLine3,
           AddrCity           = @AddrCity,
           AddrState          = @AddrState,
           AddrZip            = @AddrZip
     WHERE ProviderID = @ProviderID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ProviderUpdProc: Cannot update  in Provider '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('ProviderUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE ProviderUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE ProviderUpdProc >>>'
go


/* 
 * PROCEDURE: ProviderDelProc 
 */

CREATE PROCEDURE ProviderDelProc
(
    @ProviderID        nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Provider
     WHERE ProviderID = @ProviderID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ProviderDelProc: Cannot delete because foreign keys still exist in Provider '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('ProviderDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE ProviderDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE ProviderDelProc >>>'
go


/* 
 * PROCEDURE: ProviderSelProc 
 */

CREATE PROCEDURE ProviderSelProc
(
    @ProviderID        nvarchar(50))
AS
BEGIN
    SELECT ProviderID,
           ProviderName,
           ActiveFlg,
           ProviderWeb,
           ProviderNotes,
           Instructor,
           AddrLine1,
           AddrLine2,
           AddrLine3,
           AddrCity,
           AddrState,
           AddrZip
      FROM Provider
     WHERE ProviderID = @ProviderID

    RETURN(0)
END
go
IF OBJECT_ID('ProviderSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE ProviderSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE ProviderSelProc >>>'
go


/* 
 * PROCEDURE: RequiredCourseInsProc 
 */

CREATE PROCEDURE RequiredCourseInsProc
(
    @UserLoginID     nvarchar(50),
    @CourseID        nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO RequiredCourse(UserLoginID,
                               CourseID)
    VALUES(@UserLoginID,
           @CourseID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'RequiredCourseInsProc: Cannot insert because primary key value not found in RequiredCourse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('RequiredCourseInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE RequiredCourseInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE RequiredCourseInsProc >>>'
go



/* 
 * PROCEDURE: RequiredCourseDelProc 
 */

CREATE PROCEDURE RequiredCourseDelProc
(
    @UserLoginID     nvarchar(50),
    @CourseID        nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM RequiredCourse
     WHERE UserLoginID = @UserLoginID
       AND CourseID    = @CourseID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'RequiredCourseDelProc: Cannot delete because foreign keys still exist in RequiredCourse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('RequiredCourseDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE RequiredCourseDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE RequiredCourseDelProc >>>'
go


/* 
 * PROCEDURE: RequiredCourseSelProc 
 */

CREATE PROCEDURE RequiredCourseSelProc
(
    @UserLoginID     nvarchar(50),
    @CourseID        nvarchar(80))
AS
BEGIN
    SELECT UserLoginID,
           CourseID
      FROM RequiredCourse
     WHERE UserLoginID = @UserLoginID
       AND CourseID    = @CourseID

    RETURN(0)
END
go
IF OBJECT_ID('RequiredCourseSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE RequiredCourseSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE RequiredCourseSelProc >>>'
go


/* 
 * PROCEDURE: UsersInsProc 
 */

CREATE PROCEDURE UsersInsProc
(
    @UserLoginID     nvarchar(50),
    @UserEmail       nvarchar(80)             = NULL,
    @FirstName       nvarchar(50)             = NULL,
    @MiddleName      nvarchar(50)             = NULL,
    @LastName        nvarchar(50)             = NULL,
    @CellPhone       nvarchar(50)             = NULL,
    @OfficePhone     nvarchar(50)             = NULL,
    @AddrLine1       nvarchar(100)            = NULL,
    @AddrLine2       nvarchar(100)            = NULL,
    @AddrLine3       nvarchar(100)            = NULL,
    @AddrCity        nvarchar(50)             = NULL,
    @AddrState       char(2)                  = NULL,
    @AddrZip         nvarchar(50)             = NULL,
    @AddrCountry     nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Users(UserLoginID,
                      UserEmail,
                      FirstName,
                      MiddleName,
                      LastName,
                      CellPhone,
                      OfficePhone,
                      AddrLine1,
                      AddrLine2,
                      AddrLine3,
                      AddrCity,
                      AddrState,
                      AddrZip,
                      AddrCountry)
    VALUES(@UserLoginID,
           @UserEmail,
           @FirstName,
           @MiddleName,
           @LastName,
           @CellPhone,
           @OfficePhone,
           @AddrLine1,
           @AddrLine2,
           @AddrLine3,
           @AddrCity,
           @AddrState,
           @AddrZip,
           @AddrCountry)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'UsersInsProc: Cannot insert because primary key value not found in Users '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('UsersInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE UsersInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE UsersInsProc >>>'
go


/* 
 * PROCEDURE: UsersUpdProc 
 */

CREATE PROCEDURE UsersUpdProc
(
    @UserLoginID     nvarchar(50),
    @UserEmail       nvarchar(80)             = NULL,
    @FirstName       nvarchar(50)             = NULL,
    @MiddleName      nvarchar(50)             = NULL,
    @LastName        nvarchar(50)             = NULL,
    @CellPhone       nvarchar(50)             = NULL,
    @OfficePhone     nvarchar(50)             = NULL,
    @AddrLine1       nvarchar(100)            = NULL,
    @AddrLine2       nvarchar(100)            = NULL,
    @AddrLine3       nvarchar(100)            = NULL,
    @AddrCity        nvarchar(50)             = NULL,
    @AddrState       char(2)                  = NULL,
    @AddrZip         nvarchar(50)             = NULL,
    @AddrCountry     nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Users
       SET UserEmail        = @UserEmail,
           FirstName        = @FirstName,
           MiddleName       = @MiddleName,
           LastName         = @LastName,
           CellPhone        = @CellPhone,
           OfficePhone      = @OfficePhone,
           AddrLine1        = @AddrLine1,
           AddrLine2        = @AddrLine2,
           AddrLine3        = @AddrLine3,
           AddrCity         = @AddrCity,
           AddrState        = @AddrState,
           AddrZip          = @AddrZip,
           AddrCountry      = @AddrCountry
     WHERE UserLoginID = @UserLoginID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'UsersUpdProc: Cannot update  in Users '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('UsersUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE UsersUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE UsersUpdProc >>>'
go


/* 
 * PROCEDURE: UsersDelProc 
 */

CREATE PROCEDURE UsersDelProc
(
    @UserLoginID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Users
     WHERE UserLoginID = @UserLoginID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'UsersDelProc: Cannot delete because foreign keys still exist in Users '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('UsersDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE UsersDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE UsersDelProc >>>'
go


/* 
 * PROCEDURE: UsersSelProc 
 */

CREATE PROCEDURE UsersSelProc
(
    @UserLoginID     nvarchar(50))
AS
BEGIN
    SELECT UserLoginID,
           UserEmail,
           FirstName,
           MiddleName,
           LastName,
           CellPhone,
           OfficePhone,
           AddrLine1,
           AddrLine2,
           AddrLine3,
           AddrCity,
           AddrState,
           AddrZip,
           AddrCountry
      FROM Users
     WHERE UserLoginID = @UserLoginID

    RETURN(0)
END
go
IF OBJECT_ID('UsersSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE UsersSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE UsersSelProc >>>'
go


