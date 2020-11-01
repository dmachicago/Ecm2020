
--C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.DMA.UD.License.script.sql
USE [DMA.UD.License];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ActiveLicense]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE dbo.ActiveLicense
        (License     NVARCHAR(2000) NOT NULL, 
         InstallDate DATETIME NOT NULL, 
         LicenseID   INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
END;
GO

/****** Object:  Index [PK_ActiveLicense]    Script Date: 10/23/2019 11:02:06 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[ActiveLicense]')
          AND name = N'PK_ActiveLicense'
)
    BEGIN
        CREATE UNIQUE CLUSTERED INDEX PK_ActiveLicense ON dbo.ActiveLicense(LicenseID ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
END;
GO

/****** Object:  Table [dbo].[License]    Script Date: 10/23/2019 11:02:06 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[License]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE dbo.License
        (CustomerName         NVARCHAR(254) NOT NULL, 
         CustomerID           NVARCHAR(50) NOT NULL, 
         LicenseExpireDate    DATETIME NULL, 
         NbrSeats             INT NULL, 
         NbrSimlUsers         INT NULL, 
         CompanyResetID       NVARCHAR(50) NOT NULL, 
         MasterPW             NVARCHAR(50) NOT NULL, 
         LicenseGenDate       DATETIME NULL, 
         License              NVARCHAR(MAX) NOT NULL, 
         LicenseID            INT NOT NULL, 
         ContactName          NVARCHAR(254) NULL, 
         ContactEmail         NVARCHAR(254) NULL, 
         ContactPhoneNbr      NVARCHAR(50) NULL, 
         CompanyStreetAddress NVARCHAR(254) NULL, 
         CompanyCity          NVARCHAR(254) NULL, 
         CompanyState         NVARCHAR(50) NULL, 
         CompanyZip           NVARCHAR(50) NULL, 
         MaintExpireDate      DATETIME NULL, 
         CompanyCountry       NVARCHAR(50) NULL, 
         MachineID            NVARCHAR(50) NULL, 
         LicenseTypeCode      NVARCHAR(50) NULL, 
         ckSdk                BIT NULL, 
         ckLease              BIT NULL, 
         MaxClients           INT NULL, 
         MaxSharePoint        INT NULL, 
         ServerName           NVARCHAR(100) NULL, 
         SqlInstanceName      VARCHAR(254) NULL, 
         StorageAllotment     INT NULL, 
         RecNbr               INT IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
END;
GO

/****** Object:  Table [dbo].[PgmTrace]    Script Date: 10/23/2019 11:02:06 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[PgmTrace]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE dbo.PgmTrace
        (StmtID         NVARCHAR(50) NULL, 
         PgmName        NVARCHAR(254) NULL, 
         Stmt           NVARCHAR(MAX) NOT NULL, 
         RowID          INT IDENTITY(1, 1) NOT NULL, 
         CreateDate     DATETIME NULL, 
         ConnectiveGuid NVARCHAR(50) NULL, 
         UserID         NVARCHAR(50) NULL
        )
        ON [PRIMARY];
	END;
GO

/****** Object:  Table [dbo].[Programmer]    Script Date: 10/23/2019 11:02:06 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[Programmer]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE dbo.Programmer
        (ProgrammerID   INT IDENTITY(1, 1) NOT NULL, 
         ProgrammerName NVARCHAR(50) NULL
        )
        ON [PRIMARY];
END;
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [PI01License_CustName]    Script Date: 10/23/2019 11:02:07 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[License]')
          AND name = N'PI01License_CustName'
)
    BEGIN
        CREATE NONCLUSTERED INDEX PI01License_CustName ON dbo.License(CustomerName ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
END;
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [PI02_LicenseCustID]    Script Date: 10/23/2019 11:02:07 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[License]')
          AND name = N'PI02_LicenseCustID'
)
    BEGIN
        CREATE NONCLUSTERED INDEX PI02_LicenseCustID ON dbo.License(CustomerID ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
END;
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [PK_License]    Script Date: 10/23/2019 11:02:07 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[License]')
          AND name = N'PK_License'
)
    BEGIN
        CREATE UNIQUE NONCLUSTERED INDEX PK_License ON dbo.License(CustomerID ASC, CustomerName ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActiveLicense_InstallDate]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE dbo.ActiveLicense
        ADD CONSTRAINT DF_ActiveLicense_InstallDate DEFAULT GETDATE() FOR InstallDate;
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_LicenseGenDate]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE dbo.License
        ADD CONSTRAINT DF_License_LicenseGenDate DEFAULT GETDATE() FOR LicenseGenDate;
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_MaxClients]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE dbo.License
        ADD CONSTRAINT DF_License_MaxClients DEFAULT 0 FOR MaxClients;
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_MaxSharePoint]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE dbo.License
        ADD CONSTRAINT DF_License_MaxSharePoint DEFAULT 0 FOR MaxSharePoint;
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_PgmTrace_CreateDate]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE dbo.PgmTrace
        ADD CONSTRAINT DF_PgmTrace_CreateDate DEFAULT GETDATE() FOR CreateDate;
END;
GO

Print 'License DB created' ;
