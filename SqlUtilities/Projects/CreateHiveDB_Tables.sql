/*
 * DMA Chicago SQL Code Generation Tool
 * Company :      DMA Limited of Chicago
 * Project :      Hive.Version1.dm1
 * Author :       Susan Miller / Dale Miller
 *
 * Date Created : Tuesday, June 01, 2010 07:58:27
 * Target DBMS : Microsoft SQL Server 2005/2008
 */

/* 
 * TABLE: HIVEAuth 
 */

CREATE TABLE HIVEAuth(
    AuthCode       nvarchar(18)      NOT NULL,
    Description    nvarchar(2000)    NULL,
    CONSTRAINT PK7 PRIMARY KEY CLUSTERED (AuthCode)
)
go



IF OBJECT_ID('HIVEAuth') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVEAuth >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVEAuth >>>'
go

/* 
 * TABLE: HIVEConns 
 */

CREATE TABLE HIVEConns(
    Rel1Guid         uniqueidentifier    NOT NULL,
    Rel2Guid         uniqueidentifier    NOT NULL,
    ViewGenerated    bit                 NULL,
    RelStatement     nvarchar(max)       NULL,
    CONSTRAINT PK4 PRIMARY KEY CLUSTERED (Rel1Guid, Rel2Guid)
)
go



IF OBJECT_ID('HIVEConns') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVEConns >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVEConns >>>'
go

/* 
 * TABLE: HiveController 
 */

CREATE TABLE HiveController(
    HiveName          nvarchar(50)        NOT NULL,
    MachineName       nvarchar(254)       NOT NULL,
    InternalHiveID    nvarchar(50)        NOT NULL,
    EntryDate         datetime            CONSTRAINT [ControllerCurrDate] DEFAULT getdate() NULL,
    LastModDate       datetime            CONSTRAINT [ModDate] DEFAULT getdate() NULL,
    HiveGuid          uniqueidentifier    NOT NULL,
    CONSTRAINT HIVE_PK1 PRIMARY KEY CLUSTERED (HiveGuid)
)
go



IF OBJECT_ID('HiveController') IS NOT NULL
    PRINT '<<< CREATED TABLE HiveController >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HiveController >>>'
go

/* 
 * TABLE: HIVEDatatypeCode 
 */

CREATE TABLE HIVEDatatypeCode(
    DatatypeCode    nvarchar(25)      NOT NULL,
    description     nvarchar(2000)    NULL,
    CONSTRAINT PK10 PRIMARY KEY NONCLUSTERED (DatatypeCode)
)
go



IF OBJECT_ID('HIVEDatatypeCode') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVEDatatypeCode >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVEDatatypeCode >>>'
go

/* 
 * TABLE: HiveDBMS 
 */

CREATE TABLE HiveDBMS(
    DbmsCode           nvarchar(25)      NOT NULL,
    DbmsDescription    nvarchar(2000)    NULL,
    CONSTRAINT PK11 PRIMARY KEY CLUSTERED (DbmsCode)
)
go



IF OBJECT_ID('HiveDBMS') IS NOT NULL
    PRINT '<<< CREATED TABLE HiveDBMS >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HiveDBMS >>>'
go

/* 
 * TABLE: HIVEProfileItem 
 */

CREATE TABLE HIVEProfileItem(
    ItemCode       nvarchar(18)      NOT NULL,
    description    nvarchar(2000)    NULL,
    CONSTRAINT PK9 PRIMARY KEY NONCLUSTERED (ItemCode)
)
go



IF OBJECT_ID('HIVEProfileItem') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVEProfileItem >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVEProfileItem >>>'
go

/* 
 * TABLE: HIVERepo 
 */

CREATE TABLE HIVERepo(
    ConnectionName               nvarchar(50)        NULL,
    ServerName                   nvarchar(80)        NOT NULL,
    ActiveRepository             bit                 DEFAULT 0 NOT NULL,
    EncryptedConnectionString    nvarchar(2000)      NOT NULL,
    RepoLicense                  nvarchar(2000)      NULL,
    MachineName                  nvarchar(254)       NULL,
    DbmsCode                     nvarchar(25)        NOT NULL,
    RepositoryGuid               uniqueidentifier    NOT NULL,
    HiveGuid                     uniqueidentifier    NULL,
    CONSTRAINT PK3 PRIMARY KEY CLUSTERED (RepositoryGuid),
    CONSTRAINT UK_HiveRepo01  UNIQUE (ServerName),
    CONSTRAINT UK02_ConnectionName  UNIQUE (ConnectionName)
)
go



IF OBJECT_ID('HIVERepo') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVERepo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVERepo >>>'
go

/* 
 * TABLE: HIVERepoUser 
 */

CREATE TABLE HIVERepoUser(
    AssignedRepo      bit                 DEFAULT 0 NOT NULL,
    CurrentRepo       bit                 DEFAULT 0 NOT NULL,
    RepositoryGuid    uniqueidentifier    NOT NULL,
    UserID            nvarchar(50)        NOT NULL,
    EmailAddress      nvarchar(254)       NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY CLUSTERED (RepositoryGuid, UserID, EmailAddress)
)
go



IF OBJECT_ID('HIVERepoUser') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVERepoUser >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVERepoUser >>>'
go

/* 
 * TABLE: HIVESubHive 
 */

CREATE TABLE HIVESubHive(
    HiveGuid       uniqueidentifier    NOT NULL,
    SubHiveGuid    uniqueidentifier    NOT NULL,
    EntryDate      datetime            CONSTRAINT [CurrDate] DEFAULT getdate() NULL,
    CONSTRAINT PK2 PRIMARY KEY CLUSTERED (HiveGuid, SubHiveGuid)
)
go



IF OBJECT_ID('HIVESubHive') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVESubHive >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVESubHive >>>'
go

/* 
 * TABLE: HIVEUserProfile 
 */

CREATE TABLE HIVEUserProfile(
    ItemValue       nvarchar(25)     NULL,
    ItemCode        nvarchar(18)     NOT NULL,
    DatatypeCode    nvarchar(25)     NOT NULL,
    UserID          nvarchar(50)     NOT NULL,
    EmailAddress    nvarchar(254)    NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (ItemCode, UserID, EmailAddress)
)
go



IF OBJECT_ID('HIVEUserProfile') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVEUserProfile >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVEUserProfile >>>'
go

/* 
 * TABLE: HIVEUsers 
 */

CREATE TABLE HIVEUsers(
    UserLoginID     nvarchar(50)     NULL,
    EmailAddress    nvarchar(254)    NOT NULL,
    AuthCode        nvarchar(18)     NOT NULL,
    UserPassword    nvarchar(254)    NULL,
    Admin           nchar(1)         NULL,
    ClientOnly      bit              CONSTRAINT [ClientOnlyfalse] DEFAULT 0 NOT NULL,
    UserID          nvarchar(50)     NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (UserID, EmailAddress)
)
go



IF OBJECT_ID('HIVEUsers') IS NOT NULL
    PRINT '<<< CREATED TABLE HIVEUsers >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HIVEUsers >>>'
go

/* 
 * INDEX: UK_HIVE01 
 */

CREATE UNIQUE INDEX UK_HIVE01 ON HiveController(HiveName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('HiveController') AND name='UK_HIVE01')
    PRINT '<<< CREATED INDEX HiveController.UK_HIVE01 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX HiveController.UK_HIVE01 >>>'
go

/* 
 * INDEX: UK_HiveMaster01 
 */

CREATE UNIQUE INDEX UK_HiveMaster01 ON HiveController(HiveName)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('HiveController') AND name='UK_HiveMaster01')
    PRINT '<<< CREATED INDEX HiveController.UK_HiveMaster01 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX HiveController.UK_HiveMaster01 >>>'
go

/* 
 * INDEX: Ref11 
 */

CREATE INDEX Ref11 ON HIVERepo(HiveGuid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('HIVERepo') AND name='Ref11')
    PRINT '<<< CREATED INDEX HIVERepo.Ref11 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX HIVERepo.Ref11 >>>'
go

/* 
 * INDEX: ChildHiveGuid 
 */

CREATE INDEX ChildHiveGuid ON HIVESubHive(HiveGuid)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('HIVESubHive') AND name='ChildHiveGuid')
    PRINT '<<< CREATED INDEX HIVESubHive.ChildHiveGuid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX HIVESubHive.ChildHiveGuid >>>'
go

/* 
 * INDEX: Ref78 
 */

CREATE INDEX Ref78 ON HIVEUsers(AuthCode)
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('HIVEUsers') AND name='Ref78')
    PRINT '<<< CREATED INDEX HIVEUsers.Ref78 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX HIVEUsers.Ref78 >>>'
go

/* 
 * TABLE: HIVEConns 
 */

ALTER TABLE HIVEConns ADD CONSTRAINT RefHIVERepo13 
    FOREIGN KEY (Rel1Guid)
    REFERENCES HIVERepo(RepositoryGuid) ON DELETE CASCADE ON UPDATE CASCADE
go

ALTER TABLE HIVEConns ADD CONSTRAINT RefHIVERepo15 
    FOREIGN KEY (Rel2Guid)
    REFERENCES HIVERepo(RepositoryGuid) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * TABLE: HIVERepo 
 */

ALTER TABLE HIVERepo ADD CONSTRAINT RefHiveDBMS16 
    FOREIGN KEY (DbmsCode)
    REFERENCES HiveDBMS(DbmsCode) ON UPDATE CASCADE
go

ALTER TABLE HIVERepo ADD CONSTRAINT RefHiveController1 
    FOREIGN KEY (HiveGuid)
    REFERENCES HiveController(HiveGuid) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * TABLE: HIVERepoUser 
 */

ALTER TABLE HIVERepoUser ADD CONSTRAINT RefHIVERepo6 
    FOREIGN KEY (RepositoryGuid)
    REFERENCES HIVERepo(RepositoryGuid) ON DELETE CASCADE
go

ALTER TABLE HIVERepoUser ADD CONSTRAINT RefHIVEUsers7 
    FOREIGN KEY (UserID, EmailAddress)
    REFERENCES HIVEUsers(UserID, EmailAddress) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * TABLE: HIVESubHive 
 */

ALTER TABLE HIVESubHive ADD CONSTRAINT RefHiveController14 
    FOREIGN KEY (SubHiveGuid)
    REFERENCES HiveController(HiveGuid) ON DELETE CASCADE ON UPDATE CASCADE
go

ALTER TABLE HIVESubHive ADD CONSTRAINT ParentHiveGuid 
    FOREIGN KEY (HiveGuid)
    REFERENCES HiveController(HiveGuid) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * TABLE: HIVEUserProfile 
 */

ALTER TABLE HIVEUserProfile ADD CONSTRAINT RefHIVEUsers10 
    FOREIGN KEY (UserID, EmailAddress)
    REFERENCES HIVEUsers(UserID, EmailAddress) ON DELETE CASCADE ON UPDATE CASCADE
go

ALTER TABLE HIVEUserProfile ADD CONSTRAINT RefHIVEProfileItem11 
    FOREIGN KEY (ItemCode)
    REFERENCES HIVEProfileItem(ItemCode)
go

ALTER TABLE HIVEUserProfile ADD CONSTRAINT RefHIVEDatatypeCode12 
    FOREIGN KEY (DatatypeCode)
    REFERENCES HIVEDatatypeCode(DatatypeCode) ON UPDATE CASCADE
go


/* 
 * TABLE: HIVEUsers 
 */

ALTER TABLE HIVEUsers ADD CONSTRAINT RefHIVEAuth8 
    FOREIGN KEY (AuthCode)
    REFERENCES HIVEAuth(AuthCode)
go


/* 
 * PROCEDURE: HIVEAuthInsProc 
 */

CREATE PROCEDURE HIVEAuthInsProc
(
    @AuthCode        nvarchar(18),
    @Description     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVEAuth(AuthCode,
                         Description)
    VALUES(@AuthCode,
           @Description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVEAuthInsProc: Cannot insert because primary key value not found in HIVEAuth '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVEAuthInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEAuthInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEAuthInsProc >>>'
go


/* 
 * PROCEDURE: HIVEAuthUpdProc 
 */

CREATE PROCEDURE HIVEAuthUpdProc
(
    @AuthCode        nvarchar(18),
    @Description     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVEAuth
       SET Description      = @Description
     WHERE AuthCode = @AuthCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVEAuthUpdProc: Cannot update  in HIVEAuth '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEAuthUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEAuthUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEAuthUpdProc >>>'
go


/* 
 * PROCEDURE: HIVEAuthDelProc 
 */

CREATE PROCEDURE HIVEAuthDelProc
(
    @AuthCode        nvarchar(18))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVEAuth
     WHERE AuthCode = @AuthCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVEAuthDelProc: Cannot delete because foreign keys still exist in HIVEAuth '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEAuthDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEAuthDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEAuthDelProc >>>'
go


/* 
 * PROCEDURE: HIVEAuthSelProc 
 */

CREATE PROCEDURE HIVEAuthSelProc
(
    @AuthCode        nvarchar(18))
AS
BEGIN
    SELECT AuthCode,
           Description
      FROM HIVEAuth
     WHERE AuthCode = @AuthCode

    RETURN(0)
END
go
IF OBJECT_ID('HIVEAuthSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEAuthSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEAuthSelProc >>>'
go


/* 
 * PROCEDURE: HIVEConnsInsProc 
 */

CREATE PROCEDURE HIVEConnsInsProc
(
    @Rel1Guid          uniqueidentifier,
    @Rel2Guid          uniqueidentifier,
    @ViewGenerated     bit                         = NULL,
    @RelStatement      nvarchar(max)               = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVEConns(Rel1Guid,
                          Rel2Guid,
                          ViewGenerated,
                          RelStatement)
    VALUES(@Rel1Guid,
           @Rel2Guid,
           @ViewGenerated,
           @RelStatement)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVEConnsInsProc: Cannot insert because primary key value not found in HIVEConns '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVEConnsInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEConnsInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEConnsInsProc >>>'
go


/* 
 * PROCEDURE: HIVEConnsUpdProc 
 */

CREATE PROCEDURE HIVEConnsUpdProc
(
    @Rel1Guid          uniqueidentifier,
    @Rel2Guid          uniqueidentifier,
    @ViewGenerated     bit                         = NULL,
    @RelStatement      nvarchar(max)               = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVEConns
       SET ViewGenerated      = @ViewGenerated,
           RelStatement       = @RelStatement
     WHERE Rel1Guid = @Rel1Guid
       AND Rel2Guid = @Rel2Guid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVEConnsUpdProc: Cannot update  in HIVEConns '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEConnsUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEConnsUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEConnsUpdProc >>>'
go


/* 
 * PROCEDURE: HIVEConnsDelProc 
 */

CREATE PROCEDURE HIVEConnsDelProc
(
    @Rel1Guid          uniqueidentifier,
    @Rel2Guid          uniqueidentifier)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVEConns
     WHERE Rel1Guid = @Rel1Guid
       AND Rel2Guid = @Rel2Guid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVEConnsDelProc: Cannot delete because foreign keys still exist in HIVEConns '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEConnsDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEConnsDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEConnsDelProc >>>'
go


/* 
 * PROCEDURE: HIVEConnsSelProc 
 */

CREATE PROCEDURE HIVEConnsSelProc
(
    @Rel1Guid          uniqueidentifier,
    @Rel2Guid          uniqueidentifier)
AS
BEGIN
    SELECT Rel1Guid,
           Rel2Guid,
           ViewGenerated,
           RelStatement
      FROM HIVEConns
     WHERE Rel1Guid = @Rel1Guid
       AND Rel2Guid = @Rel2Guid

    RETURN(0)
END
go
IF OBJECT_ID('HIVEConnsSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEConnsSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEConnsSelProc >>>'
go


/* 
 * PROCEDURE: HiveControllerInsProc 
 */

CREATE PROCEDURE HiveControllerInsProc
(
    @HiveName           nvarchar(50),
    @MachineName        nvarchar(254),
    @InternalHiveID     nvarchar(50),
    @EntryDate          datetime                    = NULL,
    @LastModDate        datetime                    = NULL,
    @HiveGuid           uniqueidentifier)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HiveController(HiveName,
                               MachineName,
                               InternalHiveID,
                               EntryDate,
                               LastModDate,
                               HiveGuid)
    VALUES(@HiveName,
           @MachineName,
           @InternalHiveID,
           @EntryDate,
           @LastModDate,
           @HiveGuid)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HiveControllerInsProc: Cannot insert because primary key value not found in HiveController '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HiveControllerInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveControllerInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveControllerInsProc >>>'
go


/* 
 * PROCEDURE: HiveControllerUpdProc 
 */

CREATE PROCEDURE HiveControllerUpdProc
(
    @HiveName           nvarchar(50),
    @MachineName        nvarchar(254),
    @InternalHiveID     nvarchar(50),
    @EntryDate          datetime                    = NULL,
    @LastModDate        datetime                    = NULL,
    @HiveGuid           uniqueidentifier)
AS
BEGIN
    BEGIN TRAN

    UPDATE HiveController
       SET HiveName            = @HiveName,
           MachineName         = @MachineName,
           InternalHiveID      = @InternalHiveID,
           EntryDate           = @EntryDate,
           LastModDate         = @LastModDate
     WHERE HiveGuid = @HiveGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HiveControllerUpdProc: Cannot update  in HiveController '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HiveControllerUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveControllerUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveControllerUpdProc >>>'
go


/* 
 * PROCEDURE: HiveControllerDelProc 
 */

CREATE PROCEDURE HiveControllerDelProc
(
    @HiveGuid           uniqueidentifier)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HiveController
     WHERE HiveGuid = @HiveGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HiveControllerDelProc: Cannot delete because foreign keys still exist in HiveController '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HiveControllerDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveControllerDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveControllerDelProc >>>'
go


/* 
 * PROCEDURE: HiveControllerSelProc 
 */

CREATE PROCEDURE HiveControllerSelProc
(
    @HiveGuid           uniqueidentifier)
AS
BEGIN
    SELECT HiveName,
           MachineName,
           InternalHiveID,
           EntryDate,
           LastModDate,
           HiveGuid
      FROM HiveController
     WHERE HiveGuid = @HiveGuid

    RETURN(0)
END
go
IF OBJECT_ID('HiveControllerSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveControllerSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveControllerSelProc >>>'
go


/* 
 * PROCEDURE: HIVEDatatypeCodeInsProc 
 */

CREATE PROCEDURE HIVEDatatypeCodeInsProc
(
    @DatatypeCode     nvarchar(25),
    @description      nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVEDatatypeCode(DatatypeCode,
                                 description)
    VALUES(@DatatypeCode,
           @description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVEDatatypeCodeInsProc: Cannot insert because primary key value not found in HIVEDatatypeCode '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVEDatatypeCodeInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEDatatypeCodeInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEDatatypeCodeInsProc >>>'
go


/* 
 * PROCEDURE: HIVEDatatypeCodeUpdProc 
 */

CREATE PROCEDURE HIVEDatatypeCodeUpdProc
(
    @DatatypeCode     nvarchar(25),
    @description      nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVEDatatypeCode
       SET description       = @description
     WHERE DatatypeCode = @DatatypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVEDatatypeCodeUpdProc: Cannot update  in HIVEDatatypeCode '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEDatatypeCodeUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEDatatypeCodeUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEDatatypeCodeUpdProc >>>'
go


/* 
 * PROCEDURE: HIVEDatatypeCodeDelProc 
 */

CREATE PROCEDURE HIVEDatatypeCodeDelProc
(
    @DatatypeCode     nvarchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVEDatatypeCode
     WHERE DatatypeCode = @DatatypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVEDatatypeCodeDelProc: Cannot delete because foreign keys still exist in HIVEDatatypeCode '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEDatatypeCodeDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEDatatypeCodeDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEDatatypeCodeDelProc >>>'
go


/* 
 * PROCEDURE: HIVEDatatypeCodeSelProc 
 */

CREATE PROCEDURE HIVEDatatypeCodeSelProc
(
    @DatatypeCode     nvarchar(25))
AS
BEGIN
    SELECT DatatypeCode,
           description
      FROM HIVEDatatypeCode
     WHERE DatatypeCode = @DatatypeCode

    RETURN(0)
END
go
IF OBJECT_ID('HIVEDatatypeCodeSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEDatatypeCodeSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEDatatypeCodeSelProc >>>'
go


/* 
 * PROCEDURE: HiveDBMSInsProc 
 */

CREATE PROCEDURE HiveDBMSInsProc
(
    @DbmsCode            nvarchar(25),
    @DbmsDescription     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HiveDBMS(DbmsCode,
                         DbmsDescription)
    VALUES(@DbmsCode,
           @DbmsDescription)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HiveDBMSInsProc: Cannot insert because primary key value not found in HiveDBMS '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HiveDBMSInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveDBMSInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveDBMSInsProc >>>'
go


/* 
 * PROCEDURE: HiveDBMSUpdProc 
 */

CREATE PROCEDURE HiveDBMSUpdProc
(
    @DbmsCode            nvarchar(25),
    @DbmsDescription     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE HiveDBMS
       SET DbmsDescription      = @DbmsDescription
     WHERE DbmsCode = @DbmsCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HiveDBMSUpdProc: Cannot update  in HiveDBMS '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HiveDBMSUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveDBMSUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveDBMSUpdProc >>>'
go


/* 
 * PROCEDURE: HiveDBMSDelProc 
 */

CREATE PROCEDURE HiveDBMSDelProc
(
    @DbmsCode            nvarchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HiveDBMS
     WHERE DbmsCode = @DbmsCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HiveDBMSDelProc: Cannot delete because foreign keys still exist in HiveDBMS '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HiveDBMSDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveDBMSDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveDBMSDelProc >>>'
go


/* 
 * PROCEDURE: HiveDBMSSelProc 
 */

CREATE PROCEDURE HiveDBMSSelProc
(
    @DbmsCode            nvarchar(25))
AS
BEGIN
    SELECT DbmsCode,
           DbmsDescription
      FROM HiveDBMS
     WHERE DbmsCode = @DbmsCode

    RETURN(0)
END
go
IF OBJECT_ID('HiveDBMSSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HiveDBMSSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HiveDBMSSelProc >>>'
go


/* 
 * PROCEDURE: HIVEProfileItemInsProc 
 */

CREATE PROCEDURE HIVEProfileItemInsProc
(
    @ItemCode        nvarchar(18),
    @description     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVEProfileItem(ItemCode,
                                description)
    VALUES(@ItemCode,
           @description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVEProfileItemInsProc: Cannot insert because primary key value not found in HIVEProfileItem '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVEProfileItemInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEProfileItemInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEProfileItemInsProc >>>'
go


/* 
 * PROCEDURE: HIVEProfileItemUpdProc 
 */

CREATE PROCEDURE HIVEProfileItemUpdProc
(
    @ItemCode        nvarchar(18),
    @description     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVEProfileItem
       SET description      = @description
     WHERE ItemCode = @ItemCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVEProfileItemUpdProc: Cannot update  in HIVEProfileItem '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEProfileItemUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEProfileItemUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEProfileItemUpdProc >>>'
go


/* 
 * PROCEDURE: HIVEProfileItemDelProc 
 */

CREATE PROCEDURE HIVEProfileItemDelProc
(
    @ItemCode        nvarchar(18))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVEProfileItem
     WHERE ItemCode = @ItemCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVEProfileItemDelProc: Cannot delete because foreign keys still exist in HIVEProfileItem '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEProfileItemDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEProfileItemDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEProfileItemDelProc >>>'
go


/* 
 * PROCEDURE: HIVEProfileItemSelProc 
 */

CREATE PROCEDURE HIVEProfileItemSelProc
(
    @ItemCode        nvarchar(18))
AS
BEGIN
    SELECT ItemCode,
           description
      FROM HIVEProfileItem
     WHERE ItemCode = @ItemCode

    RETURN(0)
END
go
IF OBJECT_ID('HIVEProfileItemSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEProfileItemSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEProfileItemSelProc >>>'
go


/* 
 * PROCEDURE: HIVERepoInsProc 
 */

CREATE PROCEDURE HIVERepoInsProc
(
    @ConnectionName                nvarchar(50)                = NULL,
    @ServerName                    nvarchar(80),
    @ActiveRepository              bit,
    @EncryptedConnectionString     nvarchar(2000),
    @RepoLicense                   nvarchar(2000)              = NULL,
    @MachineName                   nvarchar(254)               = NULL,
    @DbmsCode                      nvarchar(25),
    @RepositoryGuid                uniqueidentifier,
    @HiveGuid                      uniqueidentifier            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVERepo(ConnectionName,
                         ServerName,
                         ActiveRepository,
                         EncryptedConnectionString,
                         RepoLicense,
                         MachineName,
                         DbmsCode,
                         RepositoryGuid,
                         HiveGuid)
    VALUES(@ConnectionName,
           @ServerName,
           @ActiveRepository,
           @EncryptedConnectionString,
           @RepoLicense,
           @MachineName,
           @DbmsCode,
           @RepositoryGuid,
           @HiveGuid)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVERepoInsProc: Cannot insert because primary key value not found in HIVERepo '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVERepoInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoInsProc >>>'
go


/* 
 * PROCEDURE: HIVERepoUpdProc 
 */

CREATE PROCEDURE HIVERepoUpdProc
(
    @ConnectionName                nvarchar(50)                = NULL,
    @ServerName                    nvarchar(80),
    @ActiveRepository              bit,
    @EncryptedConnectionString     nvarchar(2000),
    @RepoLicense                   nvarchar(2000)              = NULL,
    @MachineName                   nvarchar(254)               = NULL,
    @DbmsCode                      nvarchar(25),
    @RepositoryGuid                uniqueidentifier,
    @HiveGuid                      uniqueidentifier            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVERepo
       SET ConnectionName                 = @ConnectionName,
           ServerName                     = @ServerName,
           ActiveRepository               = @ActiveRepository,
           EncryptedConnectionString      = @EncryptedConnectionString,
           RepoLicense                    = @RepoLicense,
           MachineName                    = @MachineName,
           DbmsCode                       = @DbmsCode,
           HiveGuid                       = @HiveGuid
     WHERE RepositoryGuid = @RepositoryGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVERepoUpdProc: Cannot update  in HIVERepo '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVERepoUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoUpdProc >>>'
go


/* 
 * PROCEDURE: HIVERepoDelProc 
 */

CREATE PROCEDURE HIVERepoDelProc
(
    @RepositoryGuid                uniqueidentifier)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVERepo
     WHERE RepositoryGuid = @RepositoryGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVERepoDelProc: Cannot delete because foreign keys still exist in HIVERepo '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVERepoDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoDelProc >>>'
go


/* 
 * PROCEDURE: HIVERepoSelProc 
 */

CREATE PROCEDURE HIVERepoSelProc
(
    @RepositoryGuid                uniqueidentifier)
AS
BEGIN
    SELECT ConnectionName,
           ServerName,
           ActiveRepository,
           EncryptedConnectionString,
           RepoLicense,
           MachineName,
           DbmsCode,
           RepositoryGuid,
           HiveGuid
      FROM HIVERepo
     WHERE RepositoryGuid = @RepositoryGuid

    RETURN(0)
END
go
IF OBJECT_ID('HIVERepoSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoSelProc >>>'
go


/* 
 * PROCEDURE: HIVERepoUserInsProc 
 */

CREATE PROCEDURE HIVERepoUserInsProc
(
    @AssignedRepo       bit,
    @CurrentRepo        bit,
    @RepositoryGuid     uniqueidentifier,
    @UserID             nvarchar(50),
    @EmailAddress       nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVERepoUser(AssignedRepo,
                             CurrentRepo,
                             RepositoryGuid,
                             UserID,
                             EmailAddress)
    VALUES(@AssignedRepo,
           @CurrentRepo,
           @RepositoryGuid,
           @UserID,
           @EmailAddress)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVERepoUserInsProc: Cannot insert because primary key value not found in HIVERepoUser '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVERepoUserInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoUserInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoUserInsProc >>>'
go


/* 
 * PROCEDURE: HIVERepoUserUpdProc 
 */

CREATE PROCEDURE HIVERepoUserUpdProc
(
    @AssignedRepo       bit,
    @CurrentRepo        bit,
    @RepositoryGuid     uniqueidentifier,
    @UserID             nvarchar(50),
    @EmailAddress       nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVERepoUser
       SET AssignedRepo        = @AssignedRepo,
           CurrentRepo         = @CurrentRepo
     WHERE RepositoryGuid = @RepositoryGuid
       AND UserID         = @UserID
       AND EmailAddress   = @EmailAddress

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVERepoUserUpdProc: Cannot update  in HIVERepoUser '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVERepoUserUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoUserUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoUserUpdProc >>>'
go


/* 
 * PROCEDURE: HIVERepoUserDelProc 
 */

CREATE PROCEDURE HIVERepoUserDelProc
(
    @RepositoryGuid     uniqueidentifier,
    @UserID             nvarchar(50),
    @EmailAddress       nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVERepoUser
     WHERE RepositoryGuid = @RepositoryGuid
       AND UserID         = @UserID
       AND EmailAddress   = @EmailAddress

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVERepoUserDelProc: Cannot delete because foreign keys still exist in HIVERepoUser '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVERepoUserDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoUserDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoUserDelProc >>>'
go


/* 
 * PROCEDURE: HIVERepoUserSelProc 
 */

CREATE PROCEDURE HIVERepoUserSelProc
(
    @RepositoryGuid     uniqueidentifier,
    @UserID             nvarchar(50),
    @EmailAddress       nvarchar(254))
AS
BEGIN
    SELECT AssignedRepo,
           CurrentRepo,
           RepositoryGuid,
           UserID,
           EmailAddress
      FROM HIVERepoUser
     WHERE RepositoryGuid = @RepositoryGuid
       AND UserID         = @UserID
       AND EmailAddress   = @EmailAddress

    RETURN(0)
END
go
IF OBJECT_ID('HIVERepoUserSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVERepoUserSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVERepoUserSelProc >>>'
go


/* 
 * PROCEDURE: HIVESubHiveInsProc 
 */

CREATE PROCEDURE HIVESubHiveInsProc
(
    @HiveGuid        uniqueidentifier,
    @SubHiveGuid     uniqueidentifier,
    @EntryDate       datetime                    = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVESubHive(HiveGuid,
                            SubHiveGuid,
                            EntryDate)
    VALUES(@HiveGuid,
           @SubHiveGuid,
           @EntryDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVESubHiveInsProc: Cannot insert because primary key value not found in HIVESubHive '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVESubHiveInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVESubHiveInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVESubHiveInsProc >>>'
go


/* 
 * PROCEDURE: HIVESubHiveUpdProc 
 */

CREATE PROCEDURE HIVESubHiveUpdProc
(
    @HiveGuid        uniqueidentifier,
    @SubHiveGuid     uniqueidentifier,
    @EntryDate       datetime                    = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVESubHive
       SET EntryDate        = @EntryDate
     WHERE HiveGuid    = @HiveGuid
       AND SubHiveGuid = @SubHiveGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVESubHiveUpdProc: Cannot update  in HIVESubHive '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVESubHiveUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVESubHiveUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVESubHiveUpdProc >>>'
go


/* 
 * PROCEDURE: HIVESubHiveDelProc 
 */

CREATE PROCEDURE HIVESubHiveDelProc
(
    @HiveGuid        uniqueidentifier,
    @SubHiveGuid     uniqueidentifier)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVESubHive
     WHERE HiveGuid    = @HiveGuid
       AND SubHiveGuid = @SubHiveGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVESubHiveDelProc: Cannot delete because foreign keys still exist in HIVESubHive '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVESubHiveDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVESubHiveDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVESubHiveDelProc >>>'
go


/* 
 * PROCEDURE: HIVESubHiveSelProc 
 */

CREATE PROCEDURE HIVESubHiveSelProc
(
    @HiveGuid        uniqueidentifier,
    @SubHiveGuid     uniqueidentifier)
AS
BEGIN
    SELECT HiveGuid,
           SubHiveGuid,
           EntryDate
      FROM HIVESubHive
     WHERE HiveGuid    = @HiveGuid
       AND SubHiveGuid = @SubHiveGuid

    RETURN(0)
END
go
IF OBJECT_ID('HIVESubHiveSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVESubHiveSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVESubHiveSelProc >>>'
go


/* 
 * PROCEDURE: HIVEUserProfileInsProc 
 */

CREATE PROCEDURE HIVEUserProfileInsProc
(
    @ItemValue        nvarchar(25)             = NULL,
    @ItemCode         nvarchar(18),
    @DatatypeCode     nvarchar(25),
    @UserID           nvarchar(50),
    @EmailAddress     nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVEUserProfile(ItemValue,
                                ItemCode,
                                DatatypeCode,
                                UserID,
                                EmailAddress)
    VALUES(@ItemValue,
           @ItemCode,
           @DatatypeCode,
           @UserID,
           @EmailAddress)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVEUserProfileInsProc: Cannot insert because primary key value not found in HIVEUserProfile '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVEUserProfileInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUserProfileInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUserProfileInsProc >>>'
go


/* 
 * PROCEDURE: HIVEUserProfileUpdProc 
 */

CREATE PROCEDURE HIVEUserProfileUpdProc
(
    @ItemValue        nvarchar(25)             = NULL,
    @ItemCode         nvarchar(18),
    @DatatypeCode     nvarchar(25),
    @UserID           nvarchar(50),
    @EmailAddress     nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVEUserProfile
       SET ItemValue         = @ItemValue,
           DatatypeCode      = @DatatypeCode
     WHERE ItemCode     = @ItemCode
       AND UserID       = @UserID
       AND EmailAddress = @EmailAddress

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVEUserProfileUpdProc: Cannot update  in HIVEUserProfile '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEUserProfileUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUserProfileUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUserProfileUpdProc >>>'
go


/* 
 * PROCEDURE: HIVEUserProfileDelProc 
 */

CREATE PROCEDURE HIVEUserProfileDelProc
(
    @ItemCode         nvarchar(18),
    @UserID           nvarchar(50),
    @EmailAddress     nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVEUserProfile
     WHERE ItemCode     = @ItemCode
       AND UserID       = @UserID
       AND EmailAddress = @EmailAddress

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVEUserProfileDelProc: Cannot delete because foreign keys still exist in HIVEUserProfile '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEUserProfileDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUserProfileDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUserProfileDelProc >>>'
go


/* 
 * PROCEDURE: HIVEUserProfileSelProc 
 */

CREATE PROCEDURE HIVEUserProfileSelProc
(
    @ItemCode         nvarchar(18),
    @UserID           nvarchar(50),
    @EmailAddress     nvarchar(254))
AS
BEGIN
    SELECT ItemValue,
           ItemCode,
           DatatypeCode,
           UserID,
           EmailAddress
      FROM HIVEUserProfile
     WHERE ItemCode     = @ItemCode
       AND UserID       = @UserID
       AND EmailAddress = @EmailAddress

    RETURN(0)
END
go
IF OBJECT_ID('HIVEUserProfileSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUserProfileSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUserProfileSelProc >>>'
go


/* 
 * PROCEDURE: HIVEUsersInsProc 
 */

CREATE PROCEDURE HIVEUsersInsProc
(
    @UserLoginID      nvarchar(50)             = NULL,
    @EmailAddress     nvarchar(254),
    @AuthCode         nvarchar(18),
    @UserPassword     nvarchar(254)            = NULL,
    @Admin            nchar(1)                 = NULL,
    @ClientOnly       bit,
    @UserID           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HIVEUsers(UserLoginID,
                          EmailAddress,
                          AuthCode,
                          UserPassword,
                          Admin,
                          ClientOnly,
                          UserID)
    VALUES(@UserLoginID,
           @EmailAddress,
           @AuthCode,
           @UserPassword,
           @Admin,
           @ClientOnly,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'HIVEUsersInsProc: Cannot insert because primary key value not found in HIVEUsers '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('HIVEUsersInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUsersInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUsersInsProc >>>'
go


/* 
 * PROCEDURE: HIVEUsersUpdProc 
 */

CREATE PROCEDURE HIVEUsersUpdProc
(
    @UserLoginID      nvarchar(50)             = NULL,
    @EmailAddress     nvarchar(254),
    @AuthCode         nvarchar(18),
    @UserPassword     nvarchar(254)            = NULL,
    @Admin            nchar(1)                 = NULL,
    @ClientOnly       bit,
    @UserID           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE HIVEUsers
       SET UserLoginID       = @UserLoginID,
           AuthCode          = @AuthCode,
           UserPassword      = @UserPassword,
           Admin             = @Admin,
           ClientOnly        = @ClientOnly
     WHERE EmailAddress = @EmailAddress
       AND UserID       = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'HIVEUsersUpdProc: Cannot update  in HIVEUsers '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEUsersUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUsersUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUsersUpdProc >>>'
go


/* 
 * PROCEDURE: HIVEUsersDelProc 
 */

CREATE PROCEDURE HIVEUsersDelProc
(
    @EmailAddress     nvarchar(254),
    @UserID           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM HIVEUsers
     WHERE EmailAddress = @EmailAddress
       AND UserID       = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'HIVEUsersDelProc: Cannot delete because foreign keys still exist in HIVEUsers '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('HIVEUsersDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUsersDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUsersDelProc >>>'
go


/* 
 * PROCEDURE: HIVEUsersSelProc 
 */

CREATE PROCEDURE HIVEUsersSelProc
(
    @EmailAddress     nvarchar(254),
    @UserID           nvarchar(50))
AS
BEGIN
    SELECT UserLoginID,
           EmailAddress,
           AuthCode,
           UserPassword,
           Admin,
           ClientOnly,
           UserID
      FROM HIVEUsers
     WHERE EmailAddress = @EmailAddress
       AND UserID       = @UserID

    RETURN(0)
END
go
IF OBJECT_ID('HIVEUsersSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE HIVEUsersSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE HIVEUsersSelProc >>>'
go


