/*=============================================================
SCRIPT HEADER

VERSION:   1.01.0001
DATE:      07-17-2017 07:38:25
SERVER:    10.0.0.12

DATABASE:	ECM.Language
	Roles:
		db_owner
	Schemas:
		db_accessadmin, db_backupoperator, db_datareader, db_datawriter
		db_ddladmin, db_denydatareader, db_denydatawriter, db_owner, db_securityadmin
		dbo, guest, INFORMATION_SCHEMA, sys
	Tables:
		EcmStrings, Language
	Users:
		ECMUser


=============================================================*/
USE [master]
GO
/****** Object:  Database [ECM.Language]    Script Date: 9/3/2019 5:57:27 PM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ECM.Language')
BEGIN
CREATE DATABASE [ECM.Language]
END
GO
ALTER DATABASE [ECM.Language] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECM.Language].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECM.Language] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECM.Language] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECM.Language] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECM.Language] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECM.Language] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECM.Language] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ECM.Language] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECM.Language] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECM.Language] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECM.Language] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECM.Language] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECM.Language] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECM.Language] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECM.Language] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ECM.Language] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ECM.Language] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ECM.Language] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECM.Language] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECM.Language] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECM.Language] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECM.Language] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECM.Language] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECM.Language] SET RECOVERY FULL 
GO
ALTER DATABASE [ECM.Language] SET  MULTI_USER 
GO
ALTER DATABASE [ECM.Language] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECM.Language] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ECM.Language] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ECM.Language] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ECM.Language] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ECM.Language', N'ON'
GO
ALTER DATABASE [ECM.Language] SET QUERY_STORE = OFF
GO
USE [ECM.Language]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [wmiller]    Script Date: 9/3/2019 5:57:27 PM ******/
USE [ECM.Language]
GO
/****** Object:  Table [dbo].[EcmStrings]    Script Date: 9/5/2019 2:04:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmStrings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EcmStrings](
	[LangID] [nchar](3) NOT NULL,
	[StringID] [nvarchar](50) NOT NULL,
	[Phrase] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_EcmStrings] PRIMARY KEY CLUSTERED 
(
	[LangID] ASC,
	[StringID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Language]    Script Date: 9/5/2019 2:04:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Language](
	[LangID] [nchar](3) NOT NULL,
	[LangDesc] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EcmStrings_Language]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmStrings]'))
ALTER TABLE [dbo].[EcmStrings]  WITH CHECK ADD  CONSTRAINT [FK_EcmStrings_Language] FOREIGN KEY([LangID])
REFERENCES [dbo].[Language] ([LangID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_EcmStrings_Language]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmStrings]'))
ALTER TABLE [dbo].[EcmStrings] CHECK CONSTRAINT [FK_EcmStrings_Language]
GO
