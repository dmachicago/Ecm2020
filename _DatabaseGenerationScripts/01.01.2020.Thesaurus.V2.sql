USE [master]
GO
/****** Object:  Database [ECM.Thesaurus]    Script Date: 9/3/2019 9:23:28 AM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ECM.Thesaurus')
BEGIN
CREATE DATABASE [ECM.Thesaurus]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ECM.Thesaurus', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ECM.Thesaurus.mdf' , SIZE = 144640KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ECM.Thesaurus_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ECM.Thesaurus_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [ECM.Thesaurus] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECM.Thesaurus].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECM.Thesaurus] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECM.Thesaurus] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECM.Thesaurus] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET RECURSIVE_TRIGGERS OFF 
GO
--ALTER DATABASE [ECM.Thesaurus] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ECM.Thesaurus] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
--ALTER DATABASE [ECM.Thesaurus] SET DATE_CORRELATION_OPTIMIZATION OFF 
--GO
ALTER DATABASE [ECM.Thesaurus] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECM.Thesaurus] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECM.Thesaurus] SET RECOVERY FULL 
GO
ALTER DATABASE [ECM.Thesaurus] SET  MULTI_USER 
GO
ALTER DATABASE [ECM.Thesaurus] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECM.Thesaurus] SET DB_CHAINING OFF 
GO
--ALTER DATABASE [ECM.Thesaurus] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
--GO
ALTER DATABASE [ECM.Thesaurus] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ECM.Thesaurus] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ECM.Thesaurus', N'ON'
GO
ALTER DATABASE [ECM.Thesaurus] SET QUERY_STORE = on
GO
USE [ECM.Thesaurus]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
/****** Object:  Login [WS2016\Administrator]    Script Date: 9/3/2019 9:23:29 AM ******/
--IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'WS2016\Administrator')
--CREATE LOGIN [WS2016\Administrator] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
--GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [wmiller]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'wmiller')
CREATE LOGIN [wmiller] WITH PASSWORD=N'hf+nYKYhYLQ/v97oYWhJJexpO/JmA5ELQtvVcnVCHOc=', DEFAULT_DATABASE=[ECM.Library.FS], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [wmiller] DISABLE
GO
/****** Object:  Login [NT SERVICE\Winmgmt]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\Winmgmt')
CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\SQLWriter]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\SQLWriter')
CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\SQLTELEMETRY]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\SQLTELEMETRY')
CREATE LOGIN [NT SERVICE\SQLTELEMETRY] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\SQLSERVERAGENT]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\SQLSERVERAGENT')
CREATE LOGIN [NT SERVICE\SQLSERVERAGENT] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\ReportServer]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\ReportServer')
CREATE LOGIN [NT SERVICE\ReportServer] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT SERVICE\MSSQLSERVER]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT SERVICE\MSSQLSERVER')
CREATE LOGIN [NT SERVICE\MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT AUTHORITY\NETWORK SERVICE]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE')
CREATE LOGIN [NT AUTHORITY\NETWORK SERVICE] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [jlou]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'jlou')
CREATE LOGIN [jlou] WITH PASSWORD=N'l5r6l9rivyVcwTUpWas/2JPi4/Cx+mCMy8942kBYjV8=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [jlou] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmuser]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ecmuser')
CREATE LOGIN [ecmuser] WITH PASSWORD=N'ImGExLcGvXiLrZ/5kHKM4bYX8wW9ID0VqZNNVqmyAj8=', DEFAULT_DATABASE=[ECM.Library.FS], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [ecmuser] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmsys]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ecmsys')
CREATE LOGIN [ecmsys] WITH PASSWORD=N'+SMG+SIi2Ul51tcCXkdjO+bDV6mzFOUEXZnnh3s+7II=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [ecmsys] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmocr]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ecmocr')
CREATE LOGIN [ecmocr] WITH PASSWORD=N'aImttB+K+juaVpLnb0/HtGt1fZ/rkG5t574tDz34ucg=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [ecmocr] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmlogin]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ecmlogin')
CREATE LOGIN [ecmlogin] WITH PASSWORD=N'CH4aPNgMcL+mQMF2eDnON6eT5rFEMURYRnN81n6JJAk=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [ecmlogin] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmlibrary]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ecmlibrary')
CREATE LOGIN [ecmlibrary] WITH PASSWORD=N'e3xbx6PchmEpUIDIbjmYWiKHjVtd8ejQbxXcFBeOmAQ=', DEFAULT_DATABASE=[ECM.Library.FS], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [ecmlibrary] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [dbmgr]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'dbmgr')
CREATE LOGIN [dbmgr] WITH PASSWORD=N'C80wkLmVaOu2bVRa+hVrnjkyJnqNW8z0XyUltQJUBUM=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [dbmgr] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyTsqlExecutionLogin##')
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=N'Ct8wBERdAjErHpn4e4Q45XXviRUD/70iRPGDDvoL0oQ=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'##MS_PolicyEventProcessingLogin##')
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=N'D6+m+UPw4HtqgkyOq1cz8Axt1gLzvhDSfDjKEtwkyVg=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] DISABLE
GO
ALTER AUTHORIZATION ON DATABASE::[ECM.Thesaurus] TO [sa]
GO
--ALTER SERVER ROLE [sysadmin] ADD MEMBER [WS2016\Administrator]
--GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [wmiller]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\Winmgmt]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLWriter]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLSERVERAGENT]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\MSSQLSERVER]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmuser]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmlibrary]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [dbmgr]
GO
USE [ECM.Thesaurus]
GO
/****** Object:  User [ECMUser]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ECMUser')
CREATE USER [ECMUser] FOR LOGIN [ecmuser] WITH DEFAULT_SCHEMA=[ECMUser]
GO
/****** Object:  User [EcmLibrary]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'EcmLibrary')
CREATE USER [EcmLibrary] FOR LOGIN [ecmlibrary] WITH DEFAULT_SCHEMA=[EcmLibrary]
GO
ALTER ROLE [db_owner] ADD MEMBER [ECMUser]
GO
/****** Object:  Schema [EcmLibrary]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'EcmLibrary')
EXEC sys.sp_executesql N'CREATE SCHEMA [EcmLibrary] AUTHORIZATION [EcmLibrary]'
GO
/****** Object:  Schema [ECMUser]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'ECMUser')
EXEC sys.sp_executesql N'CREATE SCHEMA [ECMUser] AUTHORIZATION [ECMUser]'
GO
/****** Object:  Table [dbo].[Calssonomy]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Calssonomy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Calssonomy](
	[CalssonomyName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Calssonomy] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_Calssonomy]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Calssonomy]') AND name = N'PK_Calssonomy')
CREATE UNIQUE CLUSTERED INDEX [PK_Calssonomy] ON [dbo].[Calssonomy]
(
	[CalssonomyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassonomyData]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClassonomyData](
	[CalssonomyName] [nvarchar](50) NOT NULL,
	[GroupID] [nvarchar](50) NOT NULL,
	[Token] [nvarchar](250) NOT NULL,
	[EntryDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[ClassonomyData] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_ClassonomyData]    Script Date: 9/3/2019 9:23:29 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PK_ClassonomyData')
CREATE UNIQUE CLUSTERED INDEX [PK_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[GroupID] ASC,
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KbItem]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbItem](
	[ProductName] [nvarchar](50) NOT NULL,
	[Subject] [nvarchar](250) NOT NULL,
	[FullDescription] [ntext] NULL,
	[EmailAddr] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](15) NULL,
	[ItemEntryDate] [datetime] NULL,
	[KbItemNbr] [int] NOT NULL,
	[KBGuid] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[KbItem] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[KbItemGraphic]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbItemGraphic]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbItemGraphic](
	[KbGraphic] [image] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[KbGraphicGuid] [uniqueidentifier] NOT NULL,
	[KBGuid] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[KbItemGraphic] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[KbProduct]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbProduct](
	[ProductName] [nvarchar](50) NOT NULL,
	[Productdescription] [nvarchar](2000) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[KbProduct] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[KbResp]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbResp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbResp](
	[PresentationOrder] [int] NULL,
	[Response] [ntext] NOT NULL,
	[KBGuid] [uniqueidentifier] NOT NULL,
	[RespGuid] [uniqueidentifier] NOT NULL,
	[RespNbr] [int] NOT NULL,
	[RespDate] [datetime] NULL,
	[LastModDate] [datetime] NULL,
	[EmailAddr] [nvarchar](50) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[KbResp] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[KbRespGraphic]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbRespGraphic]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbRespGraphic](
	[Title] [nvarchar](100) NULL,
	[KbRespGraphic] [image] NOT NULL,
	[KbRespGraphicGuid] [uniqueidentifier] NOT NULL,
	[RespGuid] [uniqueidentifier] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[KbRespGraphic] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[KbToken]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbToken]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbToken](
	[KBGuid] [uniqueidentifier] NOT NULL,
	[TokenID] [int] NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[KbToken] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[kbUser]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[kbUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[kbUser](
	[EmailAddr] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[UserName] [nvarchar](80) NOT NULL,
	[Phone] [nvarchar](80) NULL,
	[Company] [nvarchar](80) NULL,
	[Ecm] [bit] NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[kbUser] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[License]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[License]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[License](
	[CompanyID] [nvarchar](50) NOT NULL,
	[LicenseID] [nvarchar](18) NOT NULL,
	[PurchasedMachines] [int] NULL,
	[PurchasedUsers] [int] NULL,
	[SupportActive] [bit] NULL,
	[SupportActiveDate] [datetime] NULL,
	[SupportInactiveDate] [nvarchar](50) NULL,
	[LicenseText] [nvarchar](2000) NULL,
	[LicenseTypeCode] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](50) NULL,
	[Applied] [bit] NULL,
	[EncryptedLicense] [nvarchar](4000) NULL,
	[InstalledDate] [datetime] NULL,
	[LastUpdate] [datetime] NULL,
	[ckSdk] [bit] NULL,
	[ckLease] [bit] NULL,
	[MaxClients] [int] NULL,
	[MaxSharePoint] [int] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[License] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[LicenseType]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LicenseType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LicenseType](
	[LicenseTypeCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[LicenseType] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[LoadProfile]    Script Date: 9/3/2019 9:23:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoadProfile](
	[ProfileName] [nvarchar](50) NOT NULL,
	[ProfileDesc] [nvarchar](254) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[LoadProfile] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[LoadProfileItem]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoadProfileItem](
	[ProfileName] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[LoadProfileItem] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Machine]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Machine]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Machine](
	[MachineID] [nvarchar](50) NOT NULL,
	[OperatingSystem] [nvarchar](50) NULL,
	[NbrCpu] [int] NULL,
	[AmtMemory] [float] NULL,
	[ProcessorType] [nvarchar](18) NULL,
	[CompanyID] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Machine] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[RecordedStats]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecordedStats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RecordedStats](
	[StatCode] [nvarchar](50) NULL,
	[StatVal] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[CompanyID] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[RecordedStats] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[RegisteredUser]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RegisteredUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RegisteredUser](
	[CompanyID] [nvarchar](50) NOT NULL,
	[UserGuidID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[EMail] [nvarchar](100) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[YourName] [nvarchar](100) NULL,
	[YourCompany] [nvarchar](50) NULL,
	[PassWord] [nvarchar](50) NULL,
	[JoinDate] [datetime] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[RegisteredUser] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Response]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Response]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Response](
	[Response] [ntext] NULL,
	[ResponseDate] [datetime] NOT NULL,
	[StatusCode] [nvarchar](50) NOT NULL,
	[ResponseID] [int] NOT NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[EMail] [nvarchar](100) NOT NULL,
	[IssueTitle] [nvarchar](400) NOT NULL,
	[IssueID] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Response] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[RespToken]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RespToken]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RespToken](
	[RespGuid] [uniqueidentifier] NOT NULL,
	[TokenID] [int] NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[RespToken] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Retention]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Retention]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Retention](
	[RetentionCode] [nvarchar](50) NOT NULL,
	[RetentionDesc] [nvarchar](18) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Retention] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[RootChildren]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RootChildren](
	[Token] [nvarchar](100) NOT NULL,
	[TokenID] [int] NOT NULL,
	[RootID] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[RootChildren] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PKI_RootChildren]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'PKI_RootChildren')
CREATE UNIQUE CLUSTERED INDEX [PKI_RootChildren] ON [dbo].[RootChildren]
(
	[Token] ASC,
	[TokenID] ASC,
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rootword]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rootword]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Rootword](
	[RootToken] [nvarchar](100) NOT NULL,
	[RootID] [nvarchar](50) NULL,
	[ThesaurusID] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Rootword] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PKI_Root]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Rootword]') AND name = N'PKI_Root')
CREATE UNIQUE CLUSTERED INDEX [PKI_Root] ON [dbo].[Rootword]
(
	[RootToken] ASC,
	[ThesaurusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Search1]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Search1]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Search1](
	[tgtGuid] [uniqueidentifier] NULL,
	[LoginID] [nvarchar](50) NULL,
	[Createdate] [datetime] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Search1] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Search2]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Search2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Search2](
	[tgtGuid] [uniqueidentifier] NULL,
	[LoginID] [nvarchar](50) NULL,
	[Createdate] [datetime] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Search2] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Severity]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Severity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Severity](
	[SeverityCode] [nvarchar](50) NOT NULL,
	[CodeDesc] [nvarchar](18) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Severity] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[SkipToken]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SkipToken]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SkipToken](
	[Token] [nvarchar](100) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[SkipToken] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[SourceType]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceType](
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[StoreExternal] [bit] NULL,
	[SourceTypeDesc] [nvarchar](254) NULL,
	[Indexable] [bit] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[SourceType] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Status]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Status]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Status](
	[StatusCode] [nvarchar](50) NOT NULL,
	[CodeDesc] [nvarchar](18) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Status] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Subject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Subject](
	[SubjectName] [nvarchar](20) NOT NULL,
	[SubjectDesc] [nvarchar](2000) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Subject] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[SupportRequest]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupportRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SupportRequest](
	[ProblemDescription] [ntext] NULL,
	[RequestDate] [datetime] NULL,
	[EMail] [nvarchar](100) NULL,
	[UserName] [nvarchar](50) NULL,
	[RequestID] [int] NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[SupportRequest] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[SupportResponse]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupportResponse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SupportResponse](
	[EMail] [nvarchar](100) NOT NULL,
	[Response] [ntext] NULL,
	[RequestID] [int] NOT NULL,
	[ResponseDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[SupportResponse] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[SupportUser]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupportUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SupportUser](
	[EMail] [nvarchar](100) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[YourName] [nvarchar](100) NULL,
	[YourCompany] [nvarchar](50) NULL,
	[PassWord] [nvarchar](50) NULL,
	[JoinDate] [datetime] NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[SupportUser] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Synonyms]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Synonyms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Synonyms](
	[ParentTokenID] [int] NOT NULL,
	[ChildTokenID] [int] NOT NULL,
	[ThesaurusID] [int] NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Synonyms] TO  SCHEMA OWNER 
GO
/****** Object:  Index [PK_Synonyms]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Synonyms]') AND name = N'PK_Synonyms')
CREATE UNIQUE CLUSTERED INDEX [PK_Synonyms] ON [dbo].[Synonyms]
(
	[ParentTokenID] ASC,
	[ChildTokenID] ASC,
	[ThesaurusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemParms]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemParms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SystemParms](
	[SysParm] [nvarchar](50) NULL,
	[SysParmDesc] [nvarchar](250) NULL,
	[SysParmVal] [nvarchar](250) NULL,
	[isDirectory] [nchar](1) NULL,
	[isEmailFolder] [nchar](1) NULL,
	[flgActive] [nchar](1) NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[SystemParms] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[SystemUser]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SystemUser](
	[LoginID] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[ClientID] [nvarchar](50) NOT NULL,
	[AuthorityCode] [nvarchar](15) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[SystemUser] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[TempGuids]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TempGuids]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TempGuids](
	[tgtGuid] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[TempGuids] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Thesaurus]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Thesaurus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Thesaurus](
	[ThesaurusName] [nvarchar](100) NOT NULL,
	[ThesaurusID] [nvarchar](50) NOT NULL,
	[ThesaurusSeqID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Thesaurus] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI_Thesaurus]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Thesaurus]') AND name = N'PI_Thesaurus')
CREATE UNIQUE CLUSTERED INDEX [PI_Thesaurus] ON [dbo].[Thesaurus]
(
	[ThesaurusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThesaurusTokens]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThesaurusTokens]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ThesaurusTokens](
	[ThesaurusID] [int] NOT NULL,
	[TokenID] [int] NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[ThesaurusTokens] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Token]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Token]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Token](
	[Token] [nvarchar](80) NOT NULL,
	[TokenID] [int] NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Token] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Tokens]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tokens]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tokens](
	[Token] [nvarchar](250) NOT NULL,
	[TokenID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[Tokens] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK01_Tokens]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Tokens]') AND name = N'UK01_Tokens')
CREATE UNIQUE CLUSTERED INDEX [UK01_Tokens] ON [dbo].[Tokens]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xLog]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[xLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[xLog](
	[EntryID] [int] NOT NULL,
	[ErrorText] [nvarchar](2000) NULL,
	[EntryDate] [datetime] NULL
) ON [PRIMARY]
END
GO
ALTER AUTHORIZATION ON [dbo].[xLog] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI01_ClassonomyData]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PI01_ClassonomyData')
CREATE NONCLUSTERED INDEX [PI01_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI02_ClassonomyData]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PI02_ClassonomyData')
CREATE NONCLUSTERED INDEX [PI02_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI03_ClassonomyData]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PI03_ClassonomyData')
CREATE NONCLUSTERED INDEX [PI03_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref12]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'Ref12')
CREATE NONCLUSTERED INDEX [Ref12] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref81]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'Ref81')
CREATE NONCLUSTERED INDEX [Ref81] ON [dbo].[ClassonomyData]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_ClassonomyData]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'UK_ClassonomyData')
CREATE UNIQUE NONCLUSTERED INDEX [UK_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [_dta_index_RootChildren_19_277576027__K3]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'_dta_index_RootChildren_19_277576027__K3')
CREATE NONCLUSTERED INDEX [_dta_index_RootChildren_19_277576027__K3] ON [dbo].[RootChildren]
(
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI_02]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'PI_02')
CREATE NONCLUSTERED INDEX [PI_02] ON [dbo].[RootChildren]
(
	[Token] ASC,
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI01_RootChildren]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'PI01_RootChildren')
CREATE NONCLUSTERED INDEX [PI01_RootChildren] ON [dbo].[RootChildren]
(
	[TokenID] ASC,
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Rootword]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Rootword]') AND name = N'UK_Rootword')
CREATE UNIQUE NONCLUSTERED INDEX [UK_Rootword] ON [dbo].[Rootword]
(
	[RootToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PI01_Synonyms]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Synonyms]') AND name = N'PI01_Synonyms')
CREATE NONCLUSTERED INDEX [PI01_Synonyms] ON [dbo].[Synonyms]
(
	[ParentTokenID] ASC,
	[ChildTokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Thesaurus]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Thesaurus]') AND name = N'UK_Thesaurus')
CREATE UNIQUE NONCLUSTERED INDEX [UK_Thesaurus] ON [dbo].[Thesaurus]
(
	[ThesaurusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TT]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ThesaurusTokens]') AND name = N'PK_TT')
CREATE UNIQUE NONCLUSTERED INDEX [PK_TT] ON [dbo].[ThesaurusTokens]
(
	[ThesaurusID] ASC,
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UK02_Tokens]    Script Date: 9/3/2019 9:23:30 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Tokens]') AND name = N'UK02_Tokens')
CREATE UNIQUE NONCLUSTERED INDEX [UK02_Tokens] ON [dbo].[Tokens]
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Classonomy_EntryDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ClassonomyData] ADD  CONSTRAINT [DF_Classonomy_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Classonomy_LastModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ClassonomyData] ADD  CONSTRAINT [DF_Classonomy_LastModifiedDate]  DEFAULT (getdate()) FOR [LastModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Rootword_RootID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Rootword] ADD  CONSTRAINT [DF_Rootword_RootID]  DEFAULT (newid()) FOR [RootID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Thesaurus_ThesaurusID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Thesaurus] ADD  CONSTRAINT [DF_Thesaurus_ThesaurusID]  DEFAULT (newid()) FOR [ThesaurusID]
END
GO
/****** Object:  StoredProcedure [dbo].[CalssonomySelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CalssonomySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CalssonomySelProc] AS' 
END
GO


/* 
 * PROCEDURE: CalssonomySelProc 
 */

ALTER PROCEDURE [dbo].[CalssonomySelProc]
(
    @CalssonomyName     nvarchar(50))
AS
BEGIN
    SELECT CalssonomyName
      FROM Calssonomy
     WHERE CalssonomyName = @CalssonomyName

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[CalssonomySelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[CalssonomySelProc] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[ClassonomyDataSelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyDataSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ClassonomyDataSelProc] AS' 
END
GO


/* 
 * PROCEDURE: ClassonomyDataSelProc 
 */

ALTER PROCEDURE [dbo].[ClassonomyDataSelProc]
(
    @CalssonomyName       nvarchar(50),
    @Token                nvarchar(250))
AS
BEGIN
    SELECT CalssonomyName,
           GroupID,
           Token,
           EntryDate,
           LastModifiedDate
      FROM ClassonomyData
     WHERE CalssonomyName = @CalssonomyName
       AND Token          = @Token

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[ClassonomyDataSelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[ClassonomyDataSelProc] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[RootChildrenSelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RootChildrenSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RootChildrenSelProc] AS' 
END
GO


/* 
 * PROCEDURE: RootChildrenSelProc 
 */

ALTER PROCEDURE [dbo].[RootChildrenSelProc]
(
    @Token       nvarchar(100),
    @TokenID     int,
    @RootID      nvarchar(50))
AS
BEGIN
    SELECT Token,
           TokenID,
           RootID
      FROM RootChildren
     WHERE Token   = @Token
       AND TokenID = @TokenID
       AND RootID  = @RootID

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[RootChildrenSelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[RootChildrenSelProc] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[RootwordSelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RootwordSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RootwordSelProc] AS' 
END
GO


/* 
 * PROCEDURE: RootwordSelProc 
 */

ALTER PROCEDURE [dbo].[RootwordSelProc]
(
    @RootToken       nvarchar(100))
AS
BEGIN
    SELECT RootToken,
           RootID,
           ThesaurusID
      FROM Rootword
     WHERE RootToken = @RootToken

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[RootwordSelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[RootwordSelProc] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[spIndexUsage]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spIndexUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spIndexUsage] AS' 
END
GO

/**
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
IndexUsage
By W. Dale Miller

Reports index stats, index size+rows, member seek + include columns as two comma separated output columns, and index usage 
stats for one or more tables and/or schemas.  Flexible parameterized sorting.
Has all the output of Util_ListIndexes plus the usage stats.

Required Input Parameters
	none

Optional
	@SchemaName sysname=''		Filters schemas.  Can use LIKE wildcards.  All schemas if blank.  Accepts LIKE 

Wildcards.
	@TableName sysname=''		Filters tables.  Can use LIKE wildcards.  All tables if blank.  Accepts LIKE 

Wildcards.
	@Sort Tinyint=5				Determines what to sort the results by:
									Value	Sort Columns
									1		Score DESC, user_seeks DESC, 

user_scans DESC
									2		Score ASC, user_seeks ASC, 

user_scans ASC
									3		SchemaName ASC, TableName ASC, 

IndexName ASC
									4		SchemaName ASC, TableName ASC, 

Score DESC
									5		SchemaName ASC, TableName ASC, 

Score ASC
	@Delimiter VarChar(1)=','	Delimiter for the horizontal delimited seek and include column listings.

Usage:
	EXECUTE Util_IndexUsage 'dbo', 'order%', 5, '|'

Copyright:
	Licensed under the L-GPL - a weak copyleft license - you are permitted to use this as a component of a proprietary 

database and call this from proprietary software.
	Copyleft lets you do anything you want except plagarize, conceal the source, proprietarize modifications, or 

prohibit copying & re-distribution of this script/proc.

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    see <http://www.fsf.org/licensing/licenses/lgpl.html> for the license text.

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
**/

ALTER PROCEDURE [dbo].[spIndexUsage]
	@SchemaName SysName='',
	@TableName SysName='',
	@Sort tinyint=5,
	@Delimiter VarChar(1)=','
AS

SELECT
	sys.schemas.schema_id, sys.schemas.name AS schema_name,
	sys.objects.object_id, sys.objects.name AS object_name,
	sys.indexes.index_id, ISNULL(sys.indexes.name, '---') AS index_name,
	partitions.Rows, partitions.SizeMB, IndexProperty(sys.objects.object_id,
	sys.indexes.name, 'IndexDepth') AS IndexDepth,
	sys.indexes.type, sys.indexes.type_desc, sys.indexes.fill_factor,
	sys.indexes.is_unique, sys.indexes.is_primary_key, sys.indexes.is_unique_constraint,
	ISNULL(Index_Columns.index_columns_key, '---') AS index_columns_key,
	ISNULL(Index_Columns.index_columns_include, '---') AS index_columns_include,
	ISNULL(sys.dm_db_index_usage_stats.user_seeks,0) AS user_seeks,
	ISNULL(sys.dm_db_index_usage_stats.user_scans,0) AS user_scans,
	ISNULL(sys.dm_db_index_usage_stats.user_lookups,0) AS user_lookups,
	ISNULL(sys.dm_db_index_usage_stats.user_updates,0) AS user_updates,
	sys.dm_db_index_usage_stats.last_user_seek, sys.dm_db_index_usage_stats.last_user_scan,
	sys.dm_db_index_usage_stats.last_user_lookup, sys.dm_db_index_usage_stats.last_user_update,
	ISNULL(sys.dm_db_index_usage_stats.system_seeks,0) AS system_seeks,
	ISNULL(sys.dm_db_index_usage_stats.system_scans,0) AS system_scans,
	ISNULL(sys.dm_db_index_usage_stats.system_lookups,0) AS system_lookups,
	ISNULL(sys.dm_db_index_usage_stats.system_updates,0) AS system_updates,
	sys.dm_db_index_usage_stats.last_system_seek, sys.dm_db_index_usage_stats.last_system_scan,
	sys.dm_db_index_usage_stats.last_system_lookup, sys.dm_db_index_usage_stats.last_system_update,
	(
		(
			(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT(Numeric(19,6), 

ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
			+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
			+ 1
		)
		/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
	) AS Score
FROM
	sys.objects
	JOIN sys.schemas ON sys.objects.schema_id=sys.schemas.schema_id
	JOIN sys.indexes ON sys.indexes.object_id=sys.objects.object_id
	JOIN (
		SELECT
			object_id, index_id, SUM(row_count) AS Rows,
			CONVERT(numeric(19,3), CONVERT(numeric(19,3), SUM(in_row_reserved_page_count

+lob_reserved_page_count+row_overflow_reserved_page_count))/CONVERT(numeric(19,3), 128)) AS SizeMB
		FROM sys.dm_db_partition_stats
		GROUP BY object_id, index_id
	) AS partitions ON sys.indexes.object_id=partitions.object_id AND sys.indexes.index_id=partitions.index_id
	CROSS APPLY (
		SELECT
			LEFT(index_columns_key, LEN(index_columns_key)-1) AS index_columns_key,
			LEFT(index_columns_include, LEN(index_columns_include)-1) AS index_columns_include
		FROM
			(
				SELECT
					(
						SELECT sys.columns.name + @Delimiter + ' '
						FROM
							sys.index_columns
							JOIN sys.columns ON
								sys.index_columns.column_id=sys.columns.column_id
								AND sys.index_columns.object_id=sys.columns.object_id
						WHERE
							sys.index_columns.is_included_column=0
							AND sys.indexes.object_id=sys.index_columns.object_id
							AND sys.indexes.index_id=sys.index_columns.index_id
						ORDER BY key_ordinal
						FOR XML PATH('')
					) AS index_columns_key,
					(
						SELECT sys.columns.name + @Delimiter + ' '
						FROM
							sys.index_columns
							JOIN sys.columns ON
								sys.index_columns.column_id=sys.columns.column_id
								AND sys.index_columns.object_id=sys.columns.object_id
						WHERE
							sys.index_columns.is_included_column=1
							AND sys.indexes.object_id=sys.index_columns.object_id
							AND sys.indexes.index_id=sys.index_columns.index_id
						ORDER BY index_column_id
						FOR XML PATH('')
					) AS index_columns_include
			) AS Index_Columns
	) AS Index_Columns
	LEFT OUTER JOIN sys.dm_db_index_usage_stats ON
		sys.indexes.index_id=sys.dm_db_index_usage_stats.index_id
		AND sys.indexes.object_id=sys.dm_db_index_usage_stats.object_id
		AND sys.dm_db_index_usage_stats.database_id=DB_ID()
WHERE
	sys.objects.type='u'
	AND sys.schemas.name LIKE CASE WHEN @SchemaName='' THEn sys.schemas.name ELSE @SchemaName END
	AND sys.objects.name LIKE CASE WHEN @TableName='' THEn sys.objects.name ELSE @TableName END
ORDER BY
	CASE @Sort
		WHEN 1 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)*-1
		WHEN 2 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)
		ELSE NULL
	END,
	CASE @Sort
		WHEN 3 THEN sys.schemas.name
		WHEN 4 THEN sys.schemas.name
		WHEN 5 THEN sys.schemas.name
		ELSE NULL
	END,
	CASE @Sort
		WHEN 1 THEN CONVERT(VarChar(10), sys.dm_db_index_usage_stats.user_seeks*-1)
		WHEN 2 THEN CONVERT(VarChar(10), sys.dm_db_index_usage_stats.user_seeks)
		ELSE NULL
	END,
	CASE @Sort
		WHEN 3 THEN sys.objects.name
		WHEN 4 THEN sys.objects.name
		WHEN 5 THEN sys.objects.name
		ELSE NULL
	END,
	CASE @Sort
		WHEN 1 THEN sys.dm_db_index_usage_stats.user_scans*-1
		WHEN 2 THEN sys.dm_db_index_usage_stats.user_scans
		WHEN 4 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)*-1
		WHEN 5 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)
		ELSE NULL
	END,
	CASE @Sort
		WHEN 3 THEN sys.indexes.name
		ELSE NULL
	END

GO
ALTER AUTHORIZATION ON [dbo].[spIndexUsage] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[spIndexUsage] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[SynonymsSelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SynonymsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SynonymsSelProc] AS' 
END
GO


/* 
 * PROCEDURE: SynonymsSelProc 
 */

ALTER PROCEDURE [dbo].[SynonymsSelProc]
(
    @ParentTokenID     int,
    @ChildTokenID      int,
    @ThesaurusID       int)
AS
BEGIN
    SELECT ParentTokenID,
           ChildTokenID,
           ThesaurusID
      FROM Synonyms
     WHERE ParentTokenID = @ParentTokenID
       AND ChildTokenID  = @ChildTokenID
       AND ThesaurusID   = @ThesaurusID

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[SynonymsSelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[SynonymsSelProc] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[ThesaurusSelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThesaurusSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ThesaurusSelProc] AS' 
END
GO


/* 
 * PROCEDURE: ThesaurusSelProc 
 */

ALTER PROCEDURE [dbo].[ThesaurusSelProc]
(
    @ThesaurusID        nvarchar(50))
AS
BEGIN
    SELECT ThesaurusName,
           ThesaurusID,
           ThesaurusSeqID
      FROM Thesaurus
     WHERE ThesaurusID = @ThesaurusID

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[ThesaurusSelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[ThesaurusSelProc] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[ThesaurusTokensSelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThesaurusTokensSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ThesaurusTokensSelProc] AS' 
END
GO


/* 
 * PROCEDURE: ThesaurusTokensSelProc 
 */

ALTER PROCEDURE [dbo].[ThesaurusTokensSelProc]
(
    @ThesaurusID     int,
    @TokenID         int)
AS
BEGIN
    SELECT ThesaurusID,
           TokenID
      FROM ThesaurusTokens
     WHERE ThesaurusID = @ThesaurusID
       AND TokenID     = @TokenID

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[ThesaurusTokensSelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[ThesaurusTokensSelProc] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[TokensSelProc]    Script Date: 9/3/2019 9:23:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TokensSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[TokensSelProc] AS' 
END
GO


/* 
 * PROCEDURE: TokensSelProc 
 */

ALTER PROCEDURE [dbo].[TokensSelProc]
(
    @Token       nvarchar(250))
AS
BEGIN
    SELECT Token,
           TokenID
      FROM Tokens
     WHERE Token = @Token

    RETURN(0)
END
GO
ALTER AUTHORIZATION ON [dbo].[TokensSelProc] TO  SCHEMA OWNER 
GO
ALTER AUTHORIZATION ON [dbo].[TokensSelProc] TO  SCHEMA OWNER 
GO
USE [master]
GO
ALTER DATABASE [ECM.Thesaurus] SET  READ_WRITE 
GO
