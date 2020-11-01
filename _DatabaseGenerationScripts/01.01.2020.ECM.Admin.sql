USE [master]
GO
/****** Object:  Database [ECM.Admin]    Script Date: 9/3/2019 11:48:22 AM ******/
ALTER DATABASE [ECM.Admin] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECM.Admin].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECM.Admin] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECM.Admin] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECM.Admin] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECM.Admin] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECM.Admin] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECM.Admin] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ECM.Admin] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [ECM.Admin] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECM.Admin] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECM.Admin] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECM.Admin] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECM.Admin] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECM.Admin] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECM.Admin] SET RECURSIVE_TRIGGERS OFF 
GO
--ALTER DATABASE [ECM.Admin] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ECM.Admin] SET AUTO_UPDATE_STATISTICS_ASYNC ON 
GO
--ALTER DATABASE [ECM.Admin] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECM.Admin] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECM.Admin] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECM.Admin] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECM.Admin] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECM.Admin] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECM.Admin] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ECM.Admin] SET  MULTI_USER 
GO
ALTER DATABASE [ECM.Admin] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECM.Admin] SET DB_CHAINING OFF 
GO
USE [ECM.Admin]
GO
/****** Object:  Schema [aspnet_Membership_BasicAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Membership_BasicAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Membership_BasicAccess]'
GO
/****** Object:  Schema [aspnet_Membership_FullAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Membership_FullAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Membership_FullAccess]'
GO
/****** Object:  Schema [aspnet_Membership_ReportingAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Membership_ReportingAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Membership_ReportingAccess]'
GO
/****** Object:  Schema [aspnet_Personalization_BasicAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Personalization_BasicAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Personalization_BasicAccess]'
GO
/****** Object:  Schema [aspnet_Personalization_FullAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Personalization_FullAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Personalization_FullAccess]'
GO
/****** Object:  Schema [aspnet_Personalization_ReportingAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Personalization_ReportingAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Personalization_ReportingAccess]'
GO
/****** Object:  Schema [aspnet_Profile_BasicAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Profile_BasicAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Profile_BasicAccess]'
GO
/****** Object:  Schema [aspnet_Profile_FullAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Profile_FullAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Profile_FullAccess]'
GO
/****** Object:  Schema [aspnet_Profile_ReportingAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Profile_ReportingAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Profile_ReportingAccess]'
GO
/****** Object:  Schema [aspnet_Roles_BasicAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Roles_BasicAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Roles_BasicAccess]'
GO
/****** Object:  Schema [aspnet_Roles_FullAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Roles_FullAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Roles_FullAccess]'
GO
/****** Object:  Schema [aspnet_Roles_ReportingAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_Roles_ReportingAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_Roles_ReportingAccess]'
GO
/****** Object:  Schema [aspnet_WebEvent_FullAccess]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'aspnet_WebEvent_FullAccess')
EXEC sys.sp_executesql N'CREATE SCHEMA [aspnet_WebEvent_FullAccess]'
GO
/****** Object:  Table [dbo].[aspnet_Applications]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Applications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_Applications](
	[ApplicationName] [nvarchar](256) NOT NULL,
	[LoweredApplicationName] [nvarchar](256) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Applications_Index]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Applications]') AND name = N'aspnet_Applications_Index')
CREATE CLUSTERED INDEX [aspnet_Applications_Index] ON [dbo].[aspnet_Applications]
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_Applications]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_Applications]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_Applications]
  AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
  FROM [dbo].[aspnet_Applications]
  ' 
GO
/****** Object:  Table [dbo].[aspnet_Membership]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Membership]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_Membership](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[MobilePIN] [nvarchar](16) NULL,
	[Email] [nvarchar](256) NULL,
	[LoweredEmail] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
	[Comment] [ntext] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Membership_index]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Membership]') AND name = N'aspnet_Membership_index')
CREATE CLUSTERED INDEX [aspnet_Membership_index] ON [dbo].[aspnet_Membership]
(
	[ApplicationId] ASC,
	[LoweredEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Users]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[MobileAlias] [nvarchar](16) NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Users_Index]    Script Date: 9/5/2019 1:43:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Users]') AND name = N'aspnet_Users_Index')
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index] ON [dbo].[aspnet_Users]
(
	[ApplicationId] ASC,
	[LoweredUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_MembershipUsers]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_MembershipUsers]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
  AS SELECT [dbo].[aspnet_Membership].[UserId],
            [dbo].[aspnet_Membership].[PasswordFormat],
            [dbo].[aspnet_Membership].[MobilePIN],
            [dbo].[aspnet_Membership].[Email],
            [dbo].[aspnet_Membership].[LoweredEmail],
            [dbo].[aspnet_Membership].[PasswordQuestion],
            [dbo].[aspnet_Membership].[PasswordAnswer],
            [dbo].[aspnet_Membership].[IsApproved],
            [dbo].[aspnet_Membership].[IsLockedOut],
            [dbo].[aspnet_Membership].[CreateDate],
            [dbo].[aspnet_Membership].[LastLoginDate],
            [dbo].[aspnet_Membership].[LastPasswordChangedDate],
            [dbo].[aspnet_Membership].[LastLockoutDate],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
            [dbo].[aspnet_Membership].[Comment],
            [dbo].[aspnet_Users].[ApplicationId],
            [dbo].[aspnet_Users].[UserName],
            [dbo].[aspnet_Users].[MobileAlias],
            [dbo].[aspnet_Users].[IsAnonymous],
            [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Membership] INNER JOIN [dbo].[aspnet_Users]
      ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId]
  ' 
GO
/****** Object:  Table [dbo].[aspnet_Profile]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Profile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_Profile](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [ntext] NOT NULL,
	[PropertyValuesString] [ntext] NOT NULL,
	[PropertyValuesBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[vw_aspnet_Profiles]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_Profiles]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_Profiles]
  AS SELECT [dbo].[aspnet_Profile].[UserId], [dbo].[aspnet_Profile].[LastUpdatedDate],
      [DataSize]=  DATALENGTH([dbo].[aspnet_Profile].[PropertyNames])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary])
  FROM [dbo].[aspnet_Profile]
  ' 
GO
/****** Object:  Table [dbo].[aspnet_Roles]    Script Date: 9/5/2019 1:43:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
	[LoweredRoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Roles_index1]    Script Date: 9/5/2019 1:43:05 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Roles]') AND name = N'aspnet_Roles_index1')
CREATE UNIQUE CLUSTERED INDEX [aspnet_Roles_index1] ON [dbo].[aspnet_Roles]
(
	[ApplicationId] ASC,
	[LoweredRoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_Roles]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_Roles]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_Roles]
  AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], [dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], [dbo].[aspnet_Roles].[Description]
  FROM [dbo].[aspnet_Roles]
  ' 
GO
/****** Object:  View [dbo].[vw_aspnet_Users]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_Users]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_Users]
  AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], [dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], [dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Users]
  ' 
GO
/****** Object:  Table [dbo].[aspnet_UsersInRoles]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_UsersInRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[vw_aspnet_UsersInRoles]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_UsersInRoles]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
  AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
  FROM [dbo].[aspnet_UsersInRoles]
  ' 
GO
/****** Object:  Table [dbo].[aspnet_Paths]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Paths]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_Paths](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NOT NULL,
	[Path] [nvarchar](256) NOT NULL,
	[LoweredPath] [nvarchar](256) NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aspnet_Paths_index]    Script Date: 9/5/2019 1:43:05 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Paths]') AND name = N'aspnet_Paths_index')
CREATE UNIQUE CLUSTERED INDEX [aspnet_Paths_index] ON [dbo].[aspnet_Paths]
(
	[ApplicationId] ASC,
	[LoweredPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Paths]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_WebPartState_Paths]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
  AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], [dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
  FROM [dbo].[aspnet_Paths]
  ' 
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationAllUsers]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationAllUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers](
	[PathId] [uniqueidentifier] NOT NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Shared]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_WebPartState_Shared]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
  AS SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]), [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationAllUsers]
  ' 
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationPerUser]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser](
	[Id] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Index [aspnet_PersonalizationPerUser_index1]    Script Date: 9/5/2019 1:43:05 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]') AND name = N'aspnet_PersonalizationPerUser_index1')
CREATE UNIQUE CLUSTERED INDEX [aspnet_PersonalizationPerUser_index1] ON [dbo].[aspnet_PersonalizationPerUser]
(
	[PathId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_User]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_aspnet_WebPartState_User]'))
EXEC dbo.sp_executesql @statement = N'
  CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
  AS SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId], [dbo].[aspnet_PersonalizationPerUser].[UserId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]), [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationPerUser]
  ' 
GO
/****** Object:  Table [dbo].[ActiveLicense]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActiveLicense]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ActiveLicense](
	[License] [nvarchar](2000) NOT NULL,
	[InstallDate] [datetime] NOT NULL,
	[LicenseID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AppliedDbUpdates]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AppliedDbUpdates](
	[CompanyID] [nvarchar](50) NOT NULL,
	[FixID] [int] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[ReturnMsg] [nvarchar](2000) NULL,
	[ApplyDate] [datetime] NULL,
 CONSTRAINT [PK23] PRIMARY KEY NONCLUSTERED 
(
	[CompanyID] ASC,
	[FixID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[aspnet_SchemaVersions]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_SchemaVersions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_SchemaVersions](
	[Feature] [nvarchar](128) NOT NULL,
	[CompatibleSchemaVersion] [nvarchar](128) NOT NULL,
	[IsCurrentVersion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Feature] ASC,
	[CompatibleSchemaVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[aspnet_WebEvent_Events]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_WebEvent_Events]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[aspnet_WebEvent_Events](
	[EventId] [char](32) NOT NULL,
	[EventTimeUtc] [datetime] NOT NULL,
	[EventTime] [datetime] NOT NULL,
	[EventType] [nvarchar](256) NOT NULL,
	[EventSequence] [decimal](19, 0) NOT NULL,
	[EventOccurrence] [decimal](19, 0) NOT NULL,
	[EventCode] [int] NOT NULL,
	[EventDetailCode] [int] NOT NULL,
	[Message] [nvarchar](1024) NULL,
	[ApplicationPath] [nvarchar](256) NULL,
	[ApplicationVirtualPath] [nvarchar](256) NULL,
	[MachineName] [nvarchar](256) NOT NULL,
	[RequestUrl] [nvarchar](1024) NULL,
	[ExceptionType] [nvarchar](256) NULL,
	[Details] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AssignableUserParameters]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssignableUserParameters]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssignableUserParameters](
	[ParmName] [nchar](50) NOT NULL,
	[isPerm] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AttachmentType]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AttachmentType](
	[AttachmentCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](254) NULL,
	[isZipFormat] [bit] NULL,
 CONSTRAINT [PK29] PRIMARY KEY CLUSTERED 
(
	[AttachmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AttributeDatatype]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeDatatype]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AttributeDatatype](
	[AttributeDataType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK109] PRIMARY KEY CLUSTERED 
(
	[AttributeDataType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Attributes](
	[AttributeName] [nvarchar](50) NOT NULL,
	[AttributeDataType] [nvarchar](50) NOT NULL,
	[AttributeDesc] [nvarchar](2000) NULL,
	[AssoApplication] [nvarchar](50) NULL,
 CONSTRAINT [PK36] PRIMARY KEY CLUSTERED 
(
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AuthorityDesc]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuthorityDesc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AuthorityDesc](
	[AuthorityCode] [nvarchar](15) NOT NULL,
	[AuthorityDesc] [nvarchar](80) NULL,
 CONSTRAINT [ECMPK5] PRIMARY KEY NONCLUSTERED 
(
	[AuthorityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AvailFileTypes]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AvailFileTypes](
	[ExtCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKI7] PRIMARY KEY CLUSTERED 
(
	[ExtCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Calssonomy]    Script Date: 9/5/2019 1:43:05 PM ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_Calssonomy]    Script Date: 9/5/2019 1:43:05 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Calssonomy]') AND name = N'PK_Calssonomy')
CREATE UNIQUE CLUSTERED INDEX [PK_Calssonomy] ON [dbo].[Calssonomy]
(
	[CalssonomyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[catalogOfUpdates]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[catalogOfUpdates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[catalogOfUpdates](
	[UpdatedSystem] [nvarchar](50) NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[DescOfUpdate] [nvarchar](max) NOT NULL,
	[UpdateSeqNo] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_CatalogOfUpdates]    Script Date: 9/5/2019 1:43:05 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[catalogOfUpdates]') AND name = N'PK_CatalogOfUpdates')
CREATE UNIQUE CLUSTERED INDEX [PK_CatalogOfUpdates] ON [dbo].[catalogOfUpdates]
(
	[UpdatedSystem] ASC,
	[LastUpdate] ASC,
	[UpdateSeqNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[CategoryName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK11] PRIMARY KEY CLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClassonomyData]    Script Date: 9/5/2019 1:43:05 PM ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_ClassonomyData]    Script Date: 9/5/2019 1:43:05 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PK_ClassonomyData')
CREATE UNIQUE CLUSTERED INDEX [PK_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[GroupID] ASC,
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmAssociate]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmAssociate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmAssociate](
	[AssociateID] [nvarchar](25) NOT NULL,
	[Password] [nvarchar](25) NULL,
 CONSTRAINT [cmPK4] PRIMARY KEY CLUSTERED 
(
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cmContact]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmContact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmContact](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[Company_Name] [varchar](100) NULL,
	[Address] [varchar](100) NULL,
	[City] [varchar](100) NULL,
	[ZIP_Code] [varchar](15) NULL,
	[ZIP_Four] [varchar](10) NULL,
	[Phone_Number_Combined] [varchar](15) NULL,
	[AssociateID] [nvarchar](25) NOT NULL,
	[FirstCallDate] [datetime] NULL,
	[CallBackDate] [datetime] NULL,
	[InterestLevel] [nvarchar](25) NULL,
	[LastEditDate] [datetime] NULL,
	[CreationDate] [datetime] NULL,
 CONSTRAINT [cmPK1] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UI01] UNIQUE NONCLUSTERED 
(
	[Company_Name] ASC,
	[Address] ASC,
	[City] ASC,
	[ZIP_Code] ASC,
	[ZIP_Four] ASC,
	[Phone_Number_Combined] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cmContact_Tombstone]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmContact_Tombstone]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmContact_Tombstone](
	[ContactID] [int] NOT NULL,
	[DeletionDate] [datetime] NULL,
 CONSTRAINT [PKDEL_cmContact_Tombstone_ContactID] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cmContactCallList]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmContactCallList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmContactCallList](
	[Person_Name] [varchar](80) NOT NULL,
	[Person_Phone] [nvarchar](20) NULL,
	[Person_Email] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
	[ContactID] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cmHistory]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmHistory](
	[EntryDate] [datetime] NULL,
	[EntryNote] [varchar](2000) NULL,
	[EntrySeq] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK6_cmHistory] PRIMARY KEY CLUSTERED 
(
	[EntrySeq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cmInterestLevel]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmInterestLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmInterestLevel](
	[InterestLevel] [nvarchar](25) NOT NULL,
 CONSTRAINT [cmPK5] PRIMARY KEY CLUSTERED 
(
	[InterestLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cmMetadata]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmMetadata]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmMetadata](
	[ContactID] [int] NOT NULL,
	[ColumnName] [varchar](50) NOT NULL,
	[ColumnValue] [varchar](4000) NULL,
 CONSTRAINT [cmPK2] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC,
	[ColumnName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[cmNotes]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cmNotes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cmNotes](
	[Note] [varchar](max) NULL,
	[NoteDate] [datetime] NULL,
	[NoteSeq] [int] IDENTITY(1,1) NOT NULL,
	[ContactID] [int] NOT NULL,
	[AssociateID] [nvarchar](25) NULL,
 CONSTRAINT [cmPK3] PRIMARY KEY CLUSTERED 
(
	[NoteSeq] ASC,
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Company]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Company]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Company](
	[CompanyID] [nvarchar](50) NOT NULL,
	[CompanyName] [nvarchar](18) NOT NULL,
 CONSTRAINT [PK16] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CompanyAttr]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanyAttr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CompanyAttr](
	[AttrName] [nvarchar](15) NOT NULL,
	[CompanyID] [nvarchar](50) NOT NULL,
	[CompanyAddr] [nvarchar](2000) NOT NULL,
	[ContactName] [nvarchar](80) NOT NULL,
	[ContactPhone] [nvarchar](80) NOT NULL,
	[ContactEmail] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK_CompanyAttr] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC,
	[AttrName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DataTypeCodes]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypeCodes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataTypeCodes](
	[FileType] [nvarchar](255) NULL,
	[VerNbr] [nvarchar](255) NULL,
	[Publisher] [nvarchar](255) NULL,
	[Definition] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DB_UpdateHist]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdateHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DB_UpdateHist](
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DB_Updates]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_Updates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DB_Updates](
	[SqlStmt] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] IDENTITY(1,1) NOT NULL,
	[FixDescription] [nvarchar](4000) NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Index [PK_DB_Updates]    Script Date: 9/5/2019 1:43:05 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DB_Updates]') AND name = N'PK_DB_Updates')
CREATE UNIQUE CLUSTERED INDEX [PK_DB_Updates] ON [dbo].[DB_Updates]
(
	[FixID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EcmIssue]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmIssue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EcmIssue](
	[IssueTitle] [nvarchar](250) NOT NULL,
	[IssueDescription] [nvarchar](max) NULL,
	[CreationDate] [nvarchar](50) NULL,
	[StatusCode] [nvarchar](50) NOT NULL,
	[SeverityCode] [nvarchar](50) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[EMail] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK25] PRIMARY KEY CLUSTERED 
(
	[IssueTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[EcmResponse]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmResponse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EcmResponse](
	[IssueTitle] [nvarchar](250) NOT NULL,
	[Response] [nvarchar](max) NULL,
	[CreateDate] [nvarchar](50) NULL,
	[LastModDate] [datetime] NULL,
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[EMail] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK26] PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC,
	[IssueTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[EcmUser]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EcmUser](
	[EMail] [nvarchar](100) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[YourName] [nvarchar](100) NULL,
	[YourCompany] [nvarchar](50) NULL,
	[PassWord] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[Authority] [nchar](1) NULL,
 CONSTRAINT [PK8] PRIMARY KEY CLUSTERED 
(
	[EMail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FAQ]    Script Date: 9/5/2019 1:43:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAQ]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FAQ](
	[Question] [nvarchar](max) NOT NULL,
	[Response] [nvarchar](max) NULL,
	[FAQ_ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK6] PRIMARY KEY CLUSTERED 
(
	[FAQ_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Graphics]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Graphics]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Graphics](
	[GraphicID] [int] IDENTITY(1,1) NOT NULL,
	[Graphic] [image] NULL,
	[ResponseID] [int] NOT NULL,
	[EMail] [nvarchar](100) NOT NULL,
	[IssueTitle] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK5] PRIMARY KEY CLUSTERED 
(
	[GraphicID] ASC,
	[IssueTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HelpText]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HelpText]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HelpText](
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HelpTextUser]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HelpTextUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HelpTextUser](
	[UserID] [nvarchar](50) NOT NULL,
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[EmailAddress] [nvarchar](50) NULL
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_HelpTextUser]    Script Date: 9/5/2019 1:43:06 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[HelpTextUser]') AND name = N'PK_HelpTextUser')
CREATE UNIQUE CLUSTERED INDEX [PK_HelpTextUser] ON [dbo].[HelpTextUser]
(
	[ScreenName] ASC,
	[WidgetName] ASC,
	[CompanyID] ASC,
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImageTypeCodes]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImageTypeCodes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ImageTypeCodes](
	[ImageTypeCode] [nvarchar](50) NULL,
	[ImageTypeCodeDesc] [nvarchar](250) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Issue]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Issue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Issue](
	[CategoryName] [nvarchar](50) NOT NULL,
	[IssueDescription] [nvarchar](max) NULL,
	[EntryDate] [datetime] NULL,
	[SeverityCode] [nvarchar](50) NULL,
	[StatusCode] [nvarchar](50) NULL,
	[EMail] [nvarchar](100) NOT NULL,
	[IssueTitle] [nvarchar](400) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[IssueID] [int] IDENTITY(1,1) NOT NULL,
	[Reviewer] [nvarchar](50) NULL,
 CONSTRAINT [PK1] PRIMARY KEY CLUSTERED 
(
	[IssueTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Item]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Item](
	[SubjectName] [nvarchar](20) NULL,
	[LocatorID] [nvarchar](15) NULL,
	[IntroPhrase] [nvarchar](60) NULL,
	[Keywords] [nvarchar](100) NULL,
	[Narrative] [nvarchar](4000) NULL,
	[EntryDate] [datetime] NULL,
	[ItemEntryID] [int] IDENTITY(1,1) NOT NULL,
	[LoginID] [nvarchar](50) NOT NULL,
 CONSTRAINT [ECMPK2] PRIMARY KEY CLUSTERED 
(
	[ItemEntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ItemAttachments]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemAttachments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemAttachments](
	[AttachmentName] [nvarchar](100) NOT NULL,
	[AttachmentImage] [image] NOT NULL,
	[AttachmentID] [uniqueidentifier] NOT NULL,
	[ItemEntryID] [int] NOT NULL,
 CONSTRAINT [ECMPK6] PRIMARY KEY NONCLUSTERED 
(
	[AttachmentID] ASC,
	[ItemEntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ItemHistory]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemHistory](
	[Remarks] [nvarchar](max) NULL,
	[EntryDate] [datetime] NULL,
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[ItemEntryID] [int] NULL,
	[LoginID] [nvarchar](50) NOT NULL,
 CONSTRAINT [ECMPK3] PRIMARY KEY NONCLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[KbItem]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbItem](
	[ProductName] [nvarchar](50) NOT NULL,
	[Subject] [nvarchar](250) NOT NULL,
	[FullDescription] [nvarchar](max) NULL,
	[EmailAddr] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](15) NULL,
	[ItemEntryDate] [datetime] NULL,
	[KbItemNbr] [int] IDENTITY(1,1) NOT NULL,
	[KBGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PKII1] PRIMARY KEY NONCLUSTERED 
(
	[KBGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UI_KbItem] UNIQUE NONCLUSTERED 
(
	[Subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[KbItemGraphic]    Script Date: 9/5/2019 1:43:06 PM ******/
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
	[KBGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PKII8] PRIMARY KEY CLUSTERED 
(
	[KbGraphicGuid] ASC,
	[KBGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[KbProduct]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbProduct](
	[ProductName] [nvarchar](50) NOT NULL,
	[Productdescription] [nvarchar](2000) NULL,
 CONSTRAINT [PKI10] PRIMARY KEY CLUSTERED 
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[KbResp]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbResp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbResp](
	[PresentationOrder] [int] NULL,
	[Response] [nvarchar](max) NOT NULL,
	[KBGuid] [uniqueidentifier] NOT NULL,
	[RespGuid] [uniqueidentifier] NOT NULL,
	[RespNbr] [int] IDENTITY(1,1) NOT NULL,
	[RespDate] [datetime] NULL,
	[LastModDate] [datetime] NULL,
	[EmailAddr] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKI2] PRIMARY KEY NONCLUSTERED 
(
	[RespGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[KbRespGraphic]    Script Date: 9/5/2019 1:43:06 PM ******/
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
	[RespGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PKI9] PRIMARY KEY CLUSTERED 
(
	[KbRespGraphicGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[KbToken]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KbToken]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KbToken](
	[KBGuid] [uniqueidentifier] NOT NULL,
	[TokenID] [int] NOT NULL,
 CONSTRAINT [PKI6] PRIMARY KEY NONCLUSTERED 
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[kbUser]    Script Date: 9/5/2019 1:43:06 PM ******/
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
	[Ecm] [bit] NOT NULL,
 CONSTRAINT [PKI5] PRIMARY KEY NONCLUSTERED 
(
	[EmailAddr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[License]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[License]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[License](
	[CustomerName] [nvarchar](254) NOT NULL,
	[CustomerID] [nvarchar](50) NOT NULL,
	[LicenseExpireDate] [datetime] NULL,
	[NbrSeats] [int] NULL,
	[NbrSimlUsers] [int] NULL,
	[CompanyResetID] [nvarchar](50) NOT NULL,
	[MasterPW] [nvarchar](50) NOT NULL,
	[LicenseGenDate] [datetime] NULL,
	[License] [nvarchar](2000) NOT NULL,
	[LicenseID] [int] NOT NULL,
	[ContactName] [nvarchar](254) NULL,
	[ContactEmail] [nvarchar](254) NULL,
	[ContactPhoneNbr] [nvarchar](50) NULL,
	[CompanyStreetAddress] [nvarchar](254) NULL,
	[CompanyCity] [nvarchar](254) NULL,
	[CompanyState] [nvarchar](50) NULL,
	[CompanyZip] [nvarchar](50) NULL,
	[MaintExpireDate] [datetime] NULL,
	[CompanyCountry] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[LicenseTypeCode] [nvarchar](50) NULL,
	[ckSdk] [bit] NULL,
	[ckLease] [bit] NULL,
	[MaxClients] [int] NULL,
	[MaxSharePoint] [int] NULL,
	[RecNbr] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](100) NULL,
	[SqlInstanceName] [varchar](254) NULL,
	[StorageAllotment] [int] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[EncryptedLicense] [nvarchar](3000) NULL,
	[Applied] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[InstalledDate] [datetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LicenseType]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LicenseType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LicenseType](
	[LicenseTypeCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK20] PRIMARY KEY CLUSTERED 
(
	[LicenseTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LoadProfile]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoadProfile](
	[ProfileName] [nvarchar](50) NOT NULL,
	[ProfileDesc] [nvarchar](254) NULL,
 CONSTRAINT [PK101] PRIMARY KEY CLUSTERED 
(
	[ProfileName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LoadProfileItem]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoadProfileItem](
	[ProfileName] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK102] PRIMARY KEY NONCLUSTERED 
(
	[ProfileName] ASC,
	[SourceTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Machine]    Script Date: 9/5/2019 1:43:06 PM ******/
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
	[CompanyID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK18] PRIMARY KEY NONCLUSTERED 
(
	[CompanyID] ASC,
	[MachineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PgmTrace]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PgmTrace]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PgmTrace](
	[StmtID] [nvarchar](50) NULL,
	[PgmName] [nvarchar](254) NULL,
	[Stmt] [nvarchar](max) NOT NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConnectiveGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Programmer]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Programmer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Programmer](
	[ProgrammerID] [int] IDENTITY(1,1) NOT NULL,
	[ProgrammerName] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RecordedStats]    Script Date: 9/5/2019 1:43:06 PM ******/
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
	[CompanyID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK22] PRIMARY KEY NONCLUSTERED 
(
	[MachineID] ASC,
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RegisteredUser]    Script Date: 9/5/2019 1:43:06 PM ******/
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
	[JoinDate] [datetime] NULL,
 CONSTRAINT [PK8_1_1] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC,
	[UserGuidID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Response]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Response]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Response](
	[Response] [nvarchar](max) NULL,
	[ResponseDate] [datetime] NOT NULL,
	[StatusCode] [nvarchar](50) NOT NULL,
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[EMail] [nvarchar](100) NOT NULL,
	[IssueTitle] [nvarchar](400) NOT NULL,
	[IssueID] [int] NOT NULL,
 CONSTRAINT [PK3] PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC,
	[EMail] ASC,
	[IssueTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RespToken]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RespToken]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RespToken](
	[RespGuid] [uniqueidentifier] NOT NULL,
	[TokenID] [int] NOT NULL,
 CONSTRAINT [PKI07] PRIMARY KEY NONCLUSTERED 
(
	[RespGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Retention]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Retention]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Retention](
	[RetentionCode] [nvarchar](50) NOT NULL,
	[RetentionDesc] [nvarchar](18) NULL,
 CONSTRAINT [PK1621] PRIMARY KEY CLUSTERED 
(
	[RetentionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RootChildren]    Script Date: 9/5/2019 1:43:06 PM ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [PKI_RootChildren]    Script Date: 9/5/2019 1:43:06 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'PKI_RootChildren')
CREATE UNIQUE CLUSTERED INDEX [PKI_RootChildren] ON [dbo].[RootChildren]
(
	[Token] ASC,
	[TokenID] ASC,
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rootword]    Script Date: 9/5/2019 1:43:06 PM ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [PKI_Root]    Script Date: 9/5/2019 1:43:06 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Rootword]') AND name = N'PKI_Root')
CREATE UNIQUE CLUSTERED INDEX [PKI_Root] ON [dbo].[Rootword]
(
	[RootToken] ASC,
	[ThesaurusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Search1]    Script Date: 9/5/2019 1:43:06 PM ******/
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
/****** Object:  Table [dbo].[Search2]    Script Date: 9/5/2019 1:43:06 PM ******/
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
/****** Object:  Table [dbo].[Severity]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Severity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Severity](
	[SeverityCode] [nvarchar](50) NOT NULL,
	[CodeDesc] [nvarchar](18) NULL,
 CONSTRAINT [PK2] PRIMARY KEY CLUSTERED 
(
	[SeverityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SkipToken]    Script Date: 9/5/2019 1:43:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SkipToken]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SkipToken](
	[Token] [nvarchar](100) NOT NULL,
 CONSTRAINT [PKI4] PRIMARY KEY NONCLUSTERED 
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SourceType]    Script Date: 9/5/2019 1:43:06 PM ******/
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
	[Indexable] [bit] NULL,
 CONSTRAINT [PK34] PRIMARY KEY CLUSTERED 
(
	[SourceTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Status]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Status]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Status](
	[StatusCode] [nvarchar](50) NOT NULL,
	[CodeDesc] [nvarchar](18) NULL,
 CONSTRAINT [PK4] PRIMARY KEY CLUSTERED 
(
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Subject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Subject](
	[SubjectName] [nvarchar](20) NOT NULL,
	[SubjectDesc] [nvarchar](2000) NOT NULL,
 CONSTRAINT [ECMPK1] PRIMARY KEY CLUSTERED 
(
	[SubjectName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SupportRequest]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupportRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SupportRequest](
	[ProblemDescription] [nvarchar](max) NULL,
	[RequestDate] [datetime] NULL,
	[EMail] [nvarchar](100) NULL,
	[UserName] [nvarchar](50) NULL,
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK7] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SupportResponse]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupportResponse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SupportResponse](
	[EMail] [nvarchar](100) NOT NULL,
	[Response] [nvarchar](max) NULL,
	[RequestID] [int] NOT NULL,
	[ResponseDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK10] PRIMARY KEY NONCLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SupportUser]    Script Date: 9/5/2019 1:43:07 PM ******/
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
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK8_1] PRIMARY KEY CLUSTERED 
(
	[EMail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Synonyms]    Script Date: 9/5/2019 1:43:07 PM ******/
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
/****** Object:  Index [PK_Synonyms]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Synonyms]') AND name = N'PK_Synonyms')
CREATE UNIQUE CLUSTERED INDEX [PK_Synonyms] ON [dbo].[Synonyms]
(
	[ParentTokenID] ASC,
	[ChildTokenID] ASC,
	[ThesaurusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemParms]    Script Date: 9/5/2019 1:43:07 PM ******/
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
/****** Object:  Table [dbo].[SystemUser]    Script Date: 9/5/2019 1:43:07 PM ******/
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
	[AuthorityCode] [nvarchar](15) NOT NULL,
 CONSTRAINT [ECMPK4] PRIMARY KEY NONCLUSTERED 
(
	[LoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TempGuids]    Script Date: 9/5/2019 1:43:07 PM ******/
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
/****** Object:  Table [dbo].[Thesaurus]    Script Date: 9/5/2019 1:43:07 PM ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI_Thesaurus]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Thesaurus]') AND name = N'PI_Thesaurus')
CREATE UNIQUE CLUSTERED INDEX [PI_Thesaurus] ON [dbo].[Thesaurus]
(
	[ThesaurusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThesaurusTokens]    Script Date: 9/5/2019 1:43:07 PM ******/
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
/****** Object:  Table [dbo].[Token]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Token]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Token](
	[Token] [nvarchar](80) NOT NULL,
	[TokenID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PKI3] PRIMARY KEY CLUSTERED 
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Token] UNIQUE NONCLUSTERED 
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Tokens]    Script Date: 9/5/2019 1:43:07 PM ******/
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK01_Tokens]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Tokens]') AND name = N'UK01_Tokens')
CREATE UNIQUE CLUSTERED INDEX [UK01_Tokens] ON [dbo].[Tokens]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttAdmin]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttAdmin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttAdmin](
	[AdminID] [nvarchar](25) NOT NULL,
	[AdminPW] [nvarchar](25) NOT NULL,
 CONSTRAINT [ttPK11] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttAssociate]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttAssociate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttAssociate](
	[AssociateID] [varchar](50) NOT NULL,
	[AssoPW] [nvarchar](25) NULL,
	[AssociateName] [varchar](80) NULL,
	[Admin] [bit] NULL,
 CONSTRAINT [ttPK1] PRIMARY KEY CLUSTERED 
(
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttClient]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttClient]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttClient](
	[ClientName] [varchar](100) NOT NULL,
	[ClientAddress] [varchar](254) NULL,
	[ClientPhone] [varchar](50) NULL,
	[ClientContact] [varchar](50) NULL,
 CONSTRAINT [ttPK2] PRIMARY KEY CLUSTERED 
(
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttExpenses]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttExpenses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttExpenses](
	[ProjectName] [varchar](50) NOT NULL,
	[ClientName] [varchar](100) NOT NULL,
	[AssociateID] [varchar](50) NOT NULL,
	[ExpDate] [datetime] NOT NULL,
	[ExpDesc] [varchar](254) NOT NULL,
	[ExpAmt] [money] NOT NULL,
	[Receipt] [bit] NULL,
	[ExpCode] [nvarchar](25) NOT NULL,
 CONSTRAINT [ttPK7] PRIMARY KEY CLUSTERED 
(
	[ProjectName] ASC,
	[ClientName] ASC,
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttExpType]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttExpType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttExpType](
	[ExpCode] [nvarchar](25) NOT NULL,
	[ExpDesc] [nvarchar](500) NULL,
 CONSTRAINT [PK9] PRIMARY KEY CLUSTERED 
(
	[ExpCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttProject]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttProject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttProject](
	[ProjectName] [varchar](50) NOT NULL,
	[ClientName] [varchar](100) NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [ttPK4] PRIMARY KEY CLUSTERED 
(
	[ProjectName] ASC,
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttProjectAssociate]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttProjectAssociate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttProjectAssociate](
	[ProjectName] [varchar](50) NOT NULL,
	[ClientName] [varchar](100) NOT NULL,
	[AssociateID] [varchar](50) NOT NULL,
 CONSTRAINT [ttPK6] PRIMARY KEY CLUSTERED 
(
	[ProjectName] ASC,
	[ClientName] ASC,
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttProjectDocuments]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttProjectDocuments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttProjectDocuments](
	[DocName] [varchar](254) NOT NULL,
	[Document] [image] NULL,
	[ProjectName] [varchar](50) NOT NULL,
	[ClientName] [varchar](100) NOT NULL,
 CONSTRAINT [ttPK8] PRIMARY KEY CLUSTERED 
(
	[DocName] ASC,
	[ProjectName] ASC,
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] --TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttProjectRate]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttProjectRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttProjectRate](
	[HourlyRate] [money] NULL,
	[ProjectName] [varchar](50) NULL,
	[ClientName] [varchar](100) NULL,
	[AssociateID] [varchar](50) NULL,
	[CompanyPct] [decimal](5, 2) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttTaskClass]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttTaskClass]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttTaskClass](
	[TaskCode] [nvarchar](25) NOT NULL,
	[TaskCodeDesc] [nvarchar](500) NULL,
 CONSTRAINT [ttPK10] PRIMARY KEY CLUSTERED 
(
	[TaskCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ttTimeSheet]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ttTimeSheet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ttTimeSheet](
	[TaskID] [int] IDENTITY(1,1) NOT NULL,
	[TaskDate] [datetime] NULL,
	[TaskHours] [decimal](10, 2) NULL,
	[TaskDesc] [varchar](1000) NULL,
	[ProjectName] [varchar](50) NULL,
	[ClientName] [varchar](100) NULL,
	[AssociateID] [varchar](50) NULL,
	[TaskCode] [nvarchar](25) NOT NULL,
 CONSTRAINT [ttPK3] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[xLog]    Script Date: 9/5/2019 1:43:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[xLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[xLog](
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorText] [nvarchar](2000) NULL,
	[EntryDate] [datetime] NULL,
 CONSTRAINT [PKI11] PRIMARY KEY CLUSTERED 
(
	[EntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Index [aspnet_PersonalizationPerUser_ncindex2]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]') AND name = N'aspnet_PersonalizationPerUser_ncindex2')
CREATE UNIQUE NONCLUSTERED INDEX [aspnet_PersonalizationPerUser_ncindex2] ON [dbo].[aspnet_PersonalizationPerUser]
(
	[UserId] ASC,
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_Users_Index2]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_Users]') AND name = N'aspnet_Users_Index2')
CREATE NONCLUSTERED INDEX [aspnet_Users_Index2] ON [dbo].[aspnet_Users]
(
	[ApplicationId] ASC,
	[LastActivityDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_UsersInRoles_index]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[aspnet_UsersInRoles]') AND name = N'aspnet_UsersInRoles_index')
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index] ON [dbo].[aspnet_UsersInRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI01_ClassonomyData]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PI01_ClassonomyData')
CREATE NONCLUSTERED INDEX [PI01_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI02_ClassonomyData]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PI02_ClassonomyData')
CREATE NONCLUSTERED INDEX [PI02_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI03_ClassonomyData]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'PI03_ClassonomyData')
CREATE NONCLUSTERED INDEX [PI03_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_ClassonomyData]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ClassonomyData]') AND name = N'UK_ClassonomyData')
CREATE UNIQUE NONCLUSTERED INDEX [UK_ClassonomyData] ON [dbo].[ClassonomyData]
(
	[CalssonomyName] ASC,
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Person]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[cmContactCallList]') AND name = N'UK_Person')
CREATE UNIQUE NONCLUSTERED INDEX [UK_Person] ON [dbo].[cmContactCallList]
(
	[ContactID] ASC,
	[Person_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Ref11]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[cmMetadata]') AND name = N'Ref11')
CREATE NONCLUSTERED INDEX [Ref11] ON [dbo].[cmMetadata]
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref21]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Issue]') AND name = N'Ref21')
CREATE NONCLUSTERED INDEX [Ref21] ON [dbo].[Issue]
(
	[SeverityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref42]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Issue]') AND name = N'Ref42')
CREATE NONCLUSTERED INDEX [Ref42] ON [dbo].[Issue]
(
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI01License_CustName]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[License]') AND name = N'PI01License_CustName')
CREATE NONCLUSTERED INDEX [PI01License_CustName] ON [dbo].[License]
(
	[CustomerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI02_LicenseCustID]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[License]') AND name = N'PI02_LicenseCustID')
CREATE NONCLUSTERED INDEX [PI02_LicenseCustID] ON [dbo].[License]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_License]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[License]') AND name = N'PK_License')
CREATE UNIQUE NONCLUSTERED INDEX [PK_License] ON [dbo].[License]
(
	[CustomerID] ASC,
	[LicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [_dta_index_RootChildren_19_277576027__K3]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'_dta_index_RootChildren_19_277576027__K3')
CREATE NONCLUSTERED INDEX [_dta_index_RootChildren_19_277576027__K3] ON [dbo].[RootChildren]
(
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI_02]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'PI_02')
CREATE NONCLUSTERED INDEX [PI_02] ON [dbo].[RootChildren]
(
	[Token] ASC,
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI01_RootChildren]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RootChildren]') AND name = N'PI01_RootChildren')
CREATE NONCLUSTERED INDEX [PI01_RootChildren] ON [dbo].[RootChildren]
(
	[TokenID] ASC,
	[RootID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Rootword]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Rootword]') AND name = N'UK_Rootword')
CREATE UNIQUE NONCLUSTERED INDEX [UK_Rootword] ON [dbo].[Rootword]
(
	[RootToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PI01_Synonyms]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Synonyms]') AND name = N'PI01_Synonyms')
CREATE NONCLUSTERED INDEX [PI01_Synonyms] ON [dbo].[Synonyms]
(
	[ParentTokenID] ASC,
	[ChildTokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PITempGuids]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TempGuids]') AND name = N'PITempGuids')
CREATE NONCLUSTERED INDEX [PITempGuids] ON [dbo].[TempGuids]
(
	[tgtGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Thesaurus]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Thesaurus]') AND name = N'UK_Thesaurus')
CREATE UNIQUE NONCLUSTERED INDEX [UK_Thesaurus] ON [dbo].[Thesaurus]
(
	[ThesaurusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_TT]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ThesaurusTokens]') AND name = N'PK_TT')
CREATE UNIQUE NONCLUSTERED INDEX [PK_TT] ON [dbo].[ThesaurusTokens]
(
	[ThesaurusID] ASC,
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UK02_Tokens]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Tokens]') AND name = N'UK02_Tokens')
CREATE UNIQUE NONCLUSTERED INDEX [UK02_Tokens] ON [dbo].[Tokens]
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref66]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ttExpenses]') AND name = N'Ref66')
CREATE NONCLUSTERED INDEX [Ref66] ON [dbo].[ttExpenses]
(
	[ProjectName] ASC,
	[ClientName] ASC,
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref21]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ttProject]') AND name = N'Ref21')
CREATE NONCLUSTERED INDEX [Ref21] ON [dbo].[ttProject]
(
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref13]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ttProjectAssociate]') AND name = N'Ref13')
CREATE NONCLUSTERED INDEX [Ref13] ON [dbo].[ttProjectAssociate]
(
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref42]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ttProjectAssociate]') AND name = N'Ref42')
CREATE NONCLUSTERED INDEX [Ref42] ON [dbo].[ttProjectAssociate]
(
	[ProjectName] ASC,
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref64]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ttProjectRate]') AND name = N'Ref64')
CREATE NONCLUSTERED INDEX [Ref64] ON [dbo].[ttProjectRate]
(
	[ProjectName] ASC,
	[ClientName] ASC,
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ref65]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ttTimeSheet]') AND name = N'Ref65')
CREATE NONCLUSTERED INDEX [Ref65] ON [dbo].[ttTimeSheet]
(
	[ProjectName] ASC,
	[ClientName] ASC,
	[AssociateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PI01_LOG]    Script Date: 9/5/2019 1:43:07 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[xLog]') AND name = N'PI01_LOG')
CREATE UNIQUE NONCLUSTERED INDEX [PI01_LOG] ON [dbo].[xLog]
(
	[EntryDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActiveLicense_InstallDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ActiveLicense] ADD  CONSTRAINT [DF_ActiveLicense_InstallDate]  DEFAULT (getdate()) FOR [InstallDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Ap__Appli__540C7B00]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_Applications] ADD  DEFAULT (newid()) FOR [ApplicationId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Me__Passw__55009F39]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_Membership] ADD  DEFAULT ((0)) FOR [PasswordFormat]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Pa__PathI__55F4C372]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_Paths] ADD  DEFAULT (newid()) FOR [PathId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Perso__Id__56E8E7AB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] ADD  DEFAULT (newid()) FOR [Id]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Ro__RoleI__57DD0BE4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_Roles] ADD  DEFAULT (newid()) FOR [RoleId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Us__UserI__58D1301D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (newid()) FOR [UserId]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Us__Mobil__59C55456]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (NULL) FOR [MobileAlias]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__aspnet_Us__IsAno__5AB9788F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT ((0)) FOR [IsAnonymous]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_AssignableUserParameters_isPerm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssignableUserParameters] ADD  CONSTRAINT [DF_AssignableUserParameters_isPerm]  DEFAULT ((0)) FOR [isPerm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttachmentType_isZipFormat]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttachmentType] ADD  CONSTRAINT [DF_AttachmentType_isZipFormat]  DEFAULT ((0)) FOR [isZipFormat]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_AttributeDataType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_AttributeDataType]  DEFAULT ('nvarchar') FOR [AttributeDataType]
END
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_cmContact_LastEditDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[cmContact] ADD  CONSTRAINT [DF_cmContact_LastEditDate]  DEFAULT (getutcdate()) FOR [LastEditDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_cmContact_CreationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[cmContact] ADD  CONSTRAINT [DF_cmContact_CreationDate]  DEFAULT (getutcdate()) FOR [CreationDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__cmContact__Entry__625A9A57]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[cmContactCallList] ADD  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__cmHistory__Entry__634EBE90]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[cmHistory] ADD  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__cmNotes__NoteDat__6442E2C9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[cmNotes] ADD  DEFAULT (getdate()) FOR [NoteDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_DB_Updates_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DB_Updates] ADD  CONSTRAINT [DF_DB_Updates_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__EcmIssue__Creati__662B2B3B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EcmIssue] ADD  DEFAULT (getdate()) FOR [CreationDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_EcmUser_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF_EcmUser_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__EcmUser__LastUpd__681373AD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EcmUser] ADD  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__EcmUser__Authori__690797E6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EcmUser] ADD  DEFAULT ('U') FOR [Authority]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FAQ_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FAQ] ADD  CONSTRAINT [DF_FAQ_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FAQ__LastUpdate__6AEFE058]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FAQ] ADD  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpText_DisplayHelpText]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_DisplayHelpText]  DEFAULT ((1)) FOR [DisplayHelpText]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpText_LastUpdate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpText_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Issue__EntryDate__07020F21]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Issue] ADD  CONSTRAINT [DF__Issue__EntryDate__07020F21]  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Issue__LastUpdat__2BFE89A6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Issue] ADD  CONSTRAINT [DF__Issue__LastUpdat__2BFE89A6]  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Issue__CreateDat__2CF2ADDF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Issue] ADD  CONSTRAINT [DF__Issue__CreateDat__2CF2ADDF]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Item__EntryDate__719CDDE7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Item] ADD  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ItemHisto__Entry__72910220]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ItemHistory] ADD  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[KbItem] ADD  CONSTRAINT [ItemStatus]  DEFAULT ('OPEN') FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntryDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[KbItem] ADD  CONSTRAINT [EntryDate]  DEFAULT (getdate()) FOR [ItemEntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newKbGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[KbItem] ADD  CONSTRAINT [newKbGuid]  DEFAULT (newid()) FOR [KBGuid]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[newRespGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[KbResp] ADD  CONSTRAINT [newRespGuid]  DEFAULT (newid()) FOR [RespGuid]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RespEnterDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[KbResp] ADD  CONSTRAINT [RespEnterDate]  DEFAULT (getdate()) FOR [RespDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RespLastUpdate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[KbResp] ADD  CONSTRAINT [RespLastUpdate]  DEFAULT (getdate()) FOR [LastModDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmEmployee]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[kbUser] ADD  CONSTRAINT [EcmEmployee]  DEFAULT ((0)) FOR [Ecm]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_LicenseGenDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_LicenseGenDate]  DEFAULT (getdate()) FOR [LicenseGenDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_MaxClients]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_MaxClients]  DEFAULT ((0)) FOR [MaxClients]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_MaxSharePoint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_MaxSharePoint]  DEFAULT ((0)) FOR [MaxSharePoint]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_PgmTrace_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF_PgmTrace_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_JoinDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RegisteredUser] ADD  CONSTRAINT [DF_JoinDate]  DEFAULT (getdate()) FOR [JoinDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CurrDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Response] ADD  CONSTRAINT [CurrDate]  DEFAULT (getdate()) FOR [ResponseDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Response__LastUp__2DE6D218]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Response] ADD  CONSTRAINT [DF__Response__LastUp__2DE6D218]  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Response__Create__2EDAF651]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Response] ADD  CONSTRAINT [DF__Response__Create__2EDAF651]  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Rootword_RootID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Rootword] ADD  CONSTRAINT [DF_Rootword_RootID]  DEFAULT (newid()) FOR [RootID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Search1__Created__02C769E9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Search1] ADD  DEFAULT (getdate()) FOR [Createdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Search2__Created__03BB8E22]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Search2] ADD  DEFAULT (getdate()) FOR [Createdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FALSE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [FALSE]  DEFAULT ((0)) FOR [StoreExternal]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TRUE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [TRUE]  DEFAULT ((1)) FOR [Indexable]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SupportRe__Reque__59063A47]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportRequest] ADD  CONSTRAINT [DF__SupportRe__Reque__59063A47]  DEFAULT (getdate()) FOR [RequestDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SupportRe__LastU__078C1F06]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportRequest] ADD  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SupportRe__Creat__0880433F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportRequest] ADD  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SupportResponse_ResponseDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportResponse] ADD  CONSTRAINT [DF_SupportResponse_ResponseDate]  DEFAULT (getdate()) FOR [ResponseDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SupportRe__LastU__0A688BB1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportResponse] ADD  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SupportRe__Creat__0B5CAFEA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportResponse] ADD  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SupportUser_JoinDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportUser] ADD  CONSTRAINT [DF_SupportUser_JoinDate]  DEFAULT (getdate()) FOR [JoinDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SupportUs__LastU__0D44F85C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportUser] ADD  DEFAULT (getdate()) FOR [LastUpdate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SupportUs__Creat__0E391C95]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SupportUser] ADD  DEFAULT (getdate()) FOR [CreateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Thesaurus_ThesaurusID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Thesaurus] ADD  CONSTRAINT [DF_Thesaurus_ThesaurusID]  DEFAULT (newid()) FOR [ThesaurusID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__ttProject__Compa__10216507]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ttProjectRate] ADD  DEFAULT ((30)) FOR [CompanyPct]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[kLogEntryDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[xLog] ADD  CONSTRAINT [kLogEntryDate]  DEFAULT (getdate()) FOR [EntryDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCompany22]') AND parent_object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdates]'))
ALTER TABLE [dbo].[AppliedDbUpdates]  WITH CHECK ADD  CONSTRAINT [RefCompany22] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Company] ([CompanyID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCompany22]') AND parent_object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdates]'))
ALTER TABLE [dbo].[AppliedDbUpdates] CHECK CONSTRAINT [RefCompany22]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDB_Updates23]') AND parent_object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdates]'))
ALTER TABLE [dbo].[AppliedDbUpdates]  WITH CHECK ADD  CONSTRAINT [RefDB_Updates23] FOREIGN KEY([FixID])
REFERENCES [dbo].[DB_Updates] ([FixID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDB_Updates23]') AND parent_object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdates]'))
ALTER TABLE [dbo].[AppliedDbUpdates] CHECK CONSTRAINT [RefDB_Updates23]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Me__Appli__13F1F5EB]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Membership]'))
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Me__Appli__49E3F248]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Membership]'))
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Me__UserI__14E61A24]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Membership]'))
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Me__UserI__4AD81681]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Membership]'))
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pa__Appli__15DA3E5D]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Paths]'))
ALTER TABLE [dbo].[aspnet_Paths]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pa__Appli__4BCC3ABA]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Paths]'))
ALTER TABLE [dbo].[aspnet_Paths]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pe__PathI__16CE6296]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationAllUsers]'))
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pe__PathI__4CC05EF3]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationAllUsers]'))
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pe__PathI__17C286CF]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]'))
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pe__PathI__4DB4832C]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]'))
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pe__UserI__18B6AB08]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]'))
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pe__UserI__4EA8A765]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]'))
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pr__UserI__19AACF41]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Profile]'))
ALTER TABLE [dbo].[aspnet_Profile]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Pr__UserI__4F9CCB9E]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Profile]'))
ALTER TABLE [dbo].[aspnet_Profile]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Ro__Appli__1A9EF37A]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Roles]'))
ALTER TABLE [dbo].[aspnet_Roles]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Ro__Appli__5090EFD7]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Roles]'))
ALTER TABLE [dbo].[aspnet_Roles]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Us__Appli__1B9317B3]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Users]'))
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Us__Appli__51851410]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_Users]'))
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Us__RoleI__1C873BEC]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_UsersInRoles]'))
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[aspnet_Roles] ([RoleId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Us__RoleI__52793849]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_UsersInRoles]'))
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[aspnet_Roles] ([RoleId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Us__UserI__1D7B6025]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_UsersInRoles]'))
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__aspnet_Us__UserI__536D5C82]') AND parent_object_id = OBJECT_ID(N'[dbo].[aspnet_UsersInRoles]'))
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmAssociate3]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmContact]'))
ALTER TABLE [dbo].[cmContact]  WITH CHECK ADD  CONSTRAINT [RefcmAssociate3] FOREIGN KEY([AssociateID])
REFERENCES [dbo].[cmAssociate] ([AssociateID])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmAssociate3]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmContact]'))
ALTER TABLE [dbo].[cmContact] CHECK CONSTRAINT [RefcmAssociate3]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmContact5]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmContactCallList]'))
ALTER TABLE [dbo].[cmContactCallList]  WITH CHECK ADD  CONSTRAINT [RefcmContact5] FOREIGN KEY([ContactID])
REFERENCES [dbo].[cmContact] ([ContactID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmContact5]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmContactCallList]'))
ALTER TABLE [dbo].[cmContactCallList] CHECK CONSTRAINT [RefcmContact5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmContact1]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmMetadata]'))
ALTER TABLE [dbo].[cmMetadata]  WITH CHECK ADD  CONSTRAINT [RefcmContact1] FOREIGN KEY([ContactID])
REFERENCES [dbo].[cmContact] ([ContactID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmContact1]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmMetadata]'))
ALTER TABLE [dbo].[cmMetadata] CHECK CONSTRAINT [RefcmContact1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmContact2]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmNotes]'))
ALTER TABLE [dbo].[cmNotes]  WITH CHECK ADD  CONSTRAINT [RefcmContact2] FOREIGN KEY([ContactID])
REFERENCES [dbo].[cmContact] ([ContactID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefcmContact2]') AND parent_object_id = OBJECT_ID(N'[dbo].[cmNotes]'))
ALTER TABLE [dbo].[cmNotes] CHECK CONSTRAINT [RefcmContact2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCategory29]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue]  WITH CHECK ADD  CONSTRAINT [RefCategory29] FOREIGN KEY([CategoryName])
REFERENCES [dbo].[Category] ([CategoryName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCategory29]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue] CHECK CONSTRAINT [RefCategory29]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser30]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue]  WITH CHECK ADD  CONSTRAINT [RefEcmUser30] FOREIGN KEY([EMail])
REFERENCES [dbo].[EcmUser] ([EMail])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser30]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue] CHECK CONSTRAINT [RefEcmUser30]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSeverity28]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue]  WITH CHECK ADD  CONSTRAINT [RefSeverity28] FOREIGN KEY([SeverityCode])
REFERENCES [dbo].[Severity] ([SeverityCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSeverity28]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue] CHECK CONSTRAINT [RefSeverity28]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStatus27]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue]  WITH CHECK ADD  CONSTRAINT [RefStatus27] FOREIGN KEY([StatusCode])
REFERENCES [dbo].[Status] ([StatusCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStatus27]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmIssue]'))
ALTER TABLE [dbo].[EcmIssue] CHECK CONSTRAINT [RefStatus27]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmIssue26]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmResponse]'))
ALTER TABLE [dbo].[EcmResponse]  WITH CHECK ADD  CONSTRAINT [RefEcmIssue26] FOREIGN KEY([IssueTitle])
REFERENCES [dbo].[EcmIssue] ([IssueTitle])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmIssue26]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmResponse]'))
ALTER TABLE [dbo].[EcmResponse] CHECK CONSTRAINT [RefEcmIssue26]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser31]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmResponse]'))
ALTER TABLE [dbo].[EcmResponse]  WITH CHECK ADD  CONSTRAINT [RefEcmUser31] FOREIGN KEY([EMail])
REFERENCES [dbo].[EcmUser] ([EMail])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser31]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmResponse]'))
ALTER TABLE [dbo].[EcmResponse] CHECK CONSTRAINT [RefEcmUser31]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefIssue4]') AND parent_object_id = OBJECT_ID(N'[dbo].[Graphics]'))
ALTER TABLE [dbo].[Graphics]  WITH CHECK ADD  CONSTRAINT [RefIssue4] FOREIGN KEY([IssueTitle])
REFERENCES [dbo].[Issue] ([IssueTitle])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefIssue4]') AND parent_object_id = OBJECT_ID(N'[dbo].[Graphics]'))
ALTER TABLE [dbo].[Graphics] CHECK CONSTRAINT [RefIssue4]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefResponse11]') AND parent_object_id = OBJECT_ID(N'[dbo].[Graphics]'))
ALTER TABLE [dbo].[Graphics]  WITH CHECK ADD  CONSTRAINT [RefResponse11] FOREIGN KEY([ResponseID], [EMail], [IssueTitle])
REFERENCES [dbo].[Response] ([ResponseID], [EMail], [IssueTitle])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefResponse11]') AND parent_object_id = OBJECT_ID(N'[dbo].[Graphics]'))
ALTER TABLE [dbo].[Graphics] CHECK CONSTRAINT [RefResponse11]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCategory12]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD  CONSTRAINT [RefCategory12] FOREIGN KEY([CategoryName])
REFERENCES [dbo].[Category] ([CategoryName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCategory12]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue] CHECK CONSTRAINT [RefCategory12]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser6]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD  CONSTRAINT [RefEcmUser6] FOREIGN KEY([EMail])
REFERENCES [dbo].[EcmUser] ([EMail])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser6]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue] CHECK CONSTRAINT [RefEcmUser6]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSeverity1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD  CONSTRAINT [RefSeverity1] FOREIGN KEY([SeverityCode])
REFERENCES [dbo].[Severity] ([SeverityCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSeverity1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue] CHECK CONSTRAINT [RefSeverity1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStatus2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD  CONSTRAINT [RefStatus2] FOREIGN KEY([StatusCode])
REFERENCES [dbo].[Status] ([StatusCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStatus2]') AND parent_object_id = OBJECT_ID(N'[dbo].[Issue]'))
ALTER TABLE [dbo].[Issue] CHECK CONSTRAINT [RefStatus2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[EnteredBY]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [EnteredBY] FOREIGN KEY([LoginID])
REFERENCES [dbo].[SystemUser] ([LoginID])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[EnteredBY]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [EnteredBY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSubject1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [RefSubject1] FOREIGN KEY([SubjectName])
REFERENCES [dbo].[Subject] ([SubjectName])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSubject1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [RefSubject1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefItem6]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemAttachments]'))
ALTER TABLE [dbo].[ItemAttachments]  WITH CHECK ADD  CONSTRAINT [RefItem6] FOREIGN KEY([ItemEntryID])
REFERENCES [dbo].[Item] ([ItemEntryID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefItem6]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemAttachments]'))
ALTER TABLE [dbo].[ItemAttachments] CHECK CONSTRAINT [RefItem6]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefItem2]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemHistory]'))
ALTER TABLE [dbo].[ItemHistory]  WITH CHECK ADD  CONSTRAINT [RefItem2] FOREIGN KEY([ItemEntryID])
REFERENCES [dbo].[Item] ([ItemEntryID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefItem2]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemHistory]'))
ALTER TABLE [dbo].[ItemHistory] CHECK CONSTRAINT [RefItem2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSystemUser4]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemHistory]'))
ALTER TABLE [dbo].[ItemHistory]  WITH CHECK ADD  CONSTRAINT [RefSystemUser4] FOREIGN KEY([LoginID])
REFERENCES [dbo].[SystemUser] ([LoginID])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSystemUser4]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemHistory]'))
ALTER TABLE [dbo].[ItemHistory] CHECK CONSTRAINT [RefSystemUser4]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbProduct111]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbItem]'))
ALTER TABLE [dbo].[KbItem]  WITH CHECK ADD  CONSTRAINT [RefKbProduct111] FOREIGN KEY([ProductName])
REFERENCES [dbo].[KbProduct] ([ProductName])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbProduct111]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbItem]'))
ALTER TABLE [dbo].[KbItem] CHECK CONSTRAINT [RefKbProduct111]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefkbUser11]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbItem]'))
ALTER TABLE [dbo].[KbItem]  WITH CHECK ADD  CONSTRAINT [RefkbUser11] FOREIGN KEY([EmailAddr])
REFERENCES [dbo].[kbUser] ([EmailAddr])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefkbUser11]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbItem]'))
ALTER TABLE [dbo].[KbItem] CHECK CONSTRAINT [RefkbUser11]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbItem101]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbItemGraphic]'))
ALTER TABLE [dbo].[KbItemGraphic]  WITH CHECK ADD  CONSTRAINT [RefKbItem101] FOREIGN KEY([KBGuid])
REFERENCES [dbo].[KbItem] ([KBGuid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbItem101]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbItemGraphic]'))
ALTER TABLE [dbo].[KbItemGraphic] CHECK CONSTRAINT [RefKbItem101]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbItem61]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbResp]'))
ALTER TABLE [dbo].[KbResp]  WITH CHECK ADD  CONSTRAINT [RefKbItem61] FOREIGN KEY([KBGuid])
REFERENCES [dbo].[KbItem] ([KBGuid])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbItem61]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbResp]'))
ALTER TABLE [dbo].[KbResp] CHECK CONSTRAINT [RefKbItem61]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefkbUser131]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbResp]'))
ALTER TABLE [dbo].[KbResp]  WITH CHECK ADD  CONSTRAINT [RefkbUser131] FOREIGN KEY([EmailAddr])
REFERENCES [dbo].[kbUser] ([EmailAddr])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefkbUser131]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbResp]'))
ALTER TABLE [dbo].[KbResp] CHECK CONSTRAINT [RefkbUser131]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbResp71]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbRespGraphic]'))
ALTER TABLE [dbo].[KbRespGraphic]  WITH CHECK ADD  CONSTRAINT [RefKbResp71] FOREIGN KEY([RespGuid])
REFERENCES [dbo].[KbResp] ([RespGuid])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbResp71]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbRespGraphic]'))
ALTER TABLE [dbo].[KbRespGraphic] CHECK CONSTRAINT [RefKbResp71]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbItem21]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbToken]'))
ALTER TABLE [dbo].[KbToken]  WITH CHECK ADD  CONSTRAINT [RefKbItem21] FOREIGN KEY([KBGuid])
REFERENCES [dbo].[KbItem] ([KBGuid])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbItem21]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbToken]'))
ALTER TABLE [dbo].[KbToken] CHECK CONSTRAINT [RefKbItem21]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefToken121]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbToken]'))
ALTER TABLE [dbo].[KbToken]  WITH CHECK ADD  CONSTRAINT [RefToken121] FOREIGN KEY([TokenID])
REFERENCES [dbo].[Token] ([TokenID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefToken121]') AND parent_object_id = OBJECT_ID(N'[dbo].[KbToken]'))
ALTER TABLE [dbo].[KbToken] CHECK CONSTRAINT [RefToken121]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCompany16]') AND parent_object_id = OBJECT_ID(N'[dbo].[Machine]'))
ALTER TABLE [dbo].[Machine]  WITH CHECK ADD  CONSTRAINT [RefCompany16] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Company] ([CompanyID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCompany16]') AND parent_object_id = OBJECT_ID(N'[dbo].[Machine]'))
ALTER TABLE [dbo].[Machine] CHECK CONSTRAINT [RefCompany16]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefMachine21]') AND parent_object_id = OBJECT_ID(N'[dbo].[RecordedStats]'))
ALTER TABLE [dbo].[RecordedStats]  WITH CHECK ADD  CONSTRAINT [RefMachine21] FOREIGN KEY([CompanyID], [MachineID])
REFERENCES [dbo].[Machine] ([CompanyID], [MachineID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefMachine21]') AND parent_object_id = OBJECT_ID(N'[dbo].[RecordedStats]'))
ALTER TABLE [dbo].[RecordedStats] CHECK CONSTRAINT [RefMachine21]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCompany15]') AND parent_object_id = OBJECT_ID(N'[dbo].[RegisteredUser]'))
ALTER TABLE [dbo].[RegisteredUser]  WITH CHECK ADD  CONSTRAINT [RefCompany15] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Company] ([CompanyID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCompany15]') AND parent_object_id = OBJECT_ID(N'[dbo].[RegisteredUser]'))
ALTER TABLE [dbo].[RegisteredUser] CHECK CONSTRAINT [RefCompany15]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser25]') AND parent_object_id = OBJECT_ID(N'[dbo].[Response]'))
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [RefEcmUser25] FOREIGN KEY([EMail])
REFERENCES [dbo].[EcmUser] ([EMail])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEcmUser25]') AND parent_object_id = OBJECT_ID(N'[dbo].[Response]'))
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [RefEcmUser25]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStatus5]') AND parent_object_id = OBJECT_ID(N'[dbo].[Response]'))
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [RefStatus5] FOREIGN KEY([StatusCode])
REFERENCES [dbo].[Status] ([StatusCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStatus5]') AND parent_object_id = OBJECT_ID(N'[dbo].[Response]'))
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [RefStatus5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbResp41]') AND parent_object_id = OBJECT_ID(N'[dbo].[RespToken]'))
ALTER TABLE [dbo].[RespToken]  WITH CHECK ADD  CONSTRAINT [RefKbResp41] FOREIGN KEY([RespGuid])
REFERENCES [dbo].[KbResp] ([RespGuid])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefKbResp41]') AND parent_object_id = OBJECT_ID(N'[dbo].[RespToken]'))
ALTER TABLE [dbo].[RespToken] CHECK CONSTRAINT [RefKbResp41]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefToken51]') AND parent_object_id = OBJECT_ID(N'[dbo].[RespToken]'))
ALTER TABLE [dbo].[RespToken]  WITH CHECK ADD  CONSTRAINT [RefToken51] FOREIGN KEY([TokenID])
REFERENCES [dbo].[Token] ([TokenID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefToken51]') AND parent_object_id = OBJECT_ID(N'[dbo].[RespToken]'))
ALTER TABLE [dbo].[RespToken] CHECK CONSTRAINT [RefToken51]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCategory13]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportRequest]'))
ALTER TABLE [dbo].[SupportRequest]  WITH CHECK ADD  CONSTRAINT [RefCategory13] FOREIGN KEY([CategoryName])
REFERENCES [dbo].[Category] ([CategoryName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCategory13]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportRequest]'))
ALTER TABLE [dbo].[SupportRequest] CHECK CONSTRAINT [RefCategory13]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSupportUser7]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportRequest]'))
ALTER TABLE [dbo].[SupportRequest]  WITH CHECK ADD  CONSTRAINT [RefSupportUser7] FOREIGN KEY([EMail])
REFERENCES [dbo].[SupportUser] ([EMail])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSupportUser7]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportRequest]'))
ALTER TABLE [dbo].[SupportRequest] CHECK CONSTRAINT [RefSupportUser7]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSupportRequest9]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportResponse]'))
ALTER TABLE [dbo].[SupportResponse]  WITH CHECK ADD  CONSTRAINT [RefSupportRequest9] FOREIGN KEY([RequestID])
REFERENCES [dbo].[SupportRequest] ([RequestID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSupportRequest9]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportResponse]'))
ALTER TABLE [dbo].[SupportResponse] CHECK CONSTRAINT [RefSupportRequest9]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSupportUser10]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportResponse]'))
ALTER TABLE [dbo].[SupportResponse]  WITH CHECK ADD  CONSTRAINT [RefSupportUser10] FOREIGN KEY([EMail])
REFERENCES [dbo].[SupportUser] ([EMail])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSupportUser10]') AND parent_object_id = OBJECT_ID(N'[dbo].[SupportResponse]'))
ALTER TABLE [dbo].[SupportResponse] CHECK CONSTRAINT [RefSupportUser10]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAuthorityDesc5]') AND parent_object_id = OBJECT_ID(N'[dbo].[SystemUser]'))
ALTER TABLE [dbo].[SystemUser]  WITH CHECK ADD  CONSTRAINT [RefAuthorityDesc5] FOREIGN KEY([AuthorityCode])
REFERENCES [dbo].[AuthorityDesc] ([AuthorityCode])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAuthorityDesc5]') AND parent_object_id = OBJECT_ID(N'[dbo].[SystemUser]'))
ALTER TABLE [dbo].[SystemUser] CHECK CONSTRAINT [RefAuthorityDesc5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttExpType8]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttExpenses]'))
ALTER TABLE [dbo].[ttExpenses]  WITH CHECK ADD  CONSTRAINT [RefttExpType8] FOREIGN KEY([ExpCode])
REFERENCES [dbo].[ttExpType] ([ExpCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttExpType8]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttExpenses]'))
ALTER TABLE [dbo].[ttExpenses] CHECK CONSTRAINT [RefttExpType8]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProjectAssociate6]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttExpenses]'))
ALTER TABLE [dbo].[ttExpenses]  WITH CHECK ADD  CONSTRAINT [RefttProjectAssociate6] FOREIGN KEY([ProjectName], [ClientName], [AssociateID])
REFERENCES [dbo].[ttProjectAssociate] ([ProjectName], [ClientName], [AssociateID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProjectAssociate6]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttExpenses]'))
ALTER TABLE [dbo].[ttExpenses] CHECK CONSTRAINT [RefttProjectAssociate6]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttClient1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProject]'))
ALTER TABLE [dbo].[ttProject]  WITH CHECK ADD  CONSTRAINT [RefttClient1] FOREIGN KEY([ClientName])
REFERENCES [dbo].[ttClient] ([ClientName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttClient1]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProject]'))
ALTER TABLE [dbo].[ttProject] CHECK CONSTRAINT [RefttClient1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttAssociate3]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectAssociate]'))
ALTER TABLE [dbo].[ttProjectAssociate]  WITH CHECK ADD  CONSTRAINT [RefttAssociate3] FOREIGN KEY([AssociateID])
REFERENCES [dbo].[ttAssociate] ([AssociateID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttAssociate3]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectAssociate]'))
ALTER TABLE [dbo].[ttProjectAssociate] CHECK CONSTRAINT [RefttAssociate3]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProject2]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectAssociate]'))
ALTER TABLE [dbo].[ttProjectAssociate]  WITH CHECK ADD  CONSTRAINT [RefttProject2] FOREIGN KEY([ProjectName], [ClientName])
REFERENCES [dbo].[ttProject] ([ProjectName], [ClientName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProject2]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectAssociate]'))
ALTER TABLE [dbo].[ttProjectAssociate] CHECK CONSTRAINT [RefttProject2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProject7]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectDocuments]'))
ALTER TABLE [dbo].[ttProjectDocuments]  WITH CHECK ADD  CONSTRAINT [RefttProject7] FOREIGN KEY([ProjectName], [ClientName])
REFERENCES [dbo].[ttProject] ([ProjectName], [ClientName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProject7]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectDocuments]'))
ALTER TABLE [dbo].[ttProjectDocuments] CHECK CONSTRAINT [RefttProject7]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProjectAssociate4]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectRate]'))
ALTER TABLE [dbo].[ttProjectRate]  WITH CHECK ADD  CONSTRAINT [RefttProjectAssociate4] FOREIGN KEY([ProjectName], [ClientName], [AssociateID])
REFERENCES [dbo].[ttProjectAssociate] ([ProjectName], [ClientName], [AssociateID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProjectAssociate4]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttProjectRate]'))
ALTER TABLE [dbo].[ttProjectRate] CHECK CONSTRAINT [RefttProjectAssociate4]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProjectAssociate5]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttTimeSheet]'))
ALTER TABLE [dbo].[ttTimeSheet]  WITH CHECK ADD  CONSTRAINT [RefttProjectAssociate5] FOREIGN KEY([ProjectName], [ClientName], [AssociateID])
REFERENCES [dbo].[ttProjectAssociate] ([ProjectName], [ClientName], [AssociateID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttProjectAssociate5]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttTimeSheet]'))
ALTER TABLE [dbo].[ttTimeSheet] CHECK CONSTRAINT [RefttProjectAssociate5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttTaskClass9]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttTimeSheet]'))
ALTER TABLE [dbo].[ttTimeSheet]  WITH CHECK ADD  CONSTRAINT [RefttTaskClass9] FOREIGN KEY([TaskCode])
REFERENCES [dbo].[ttTaskClass] ([TaskCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefttTaskClass9]') AND parent_object_id = OBJECT_ID(N'[dbo].[ttTimeSheet]'))
ALTER TABLE [dbo].[ttTimeSheet] CHECK CONSTRAINT [RefttTaskClass9]
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'AssignableUserParameters', N'COLUMN',N'ParmName'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This is a list of ASSIGNABLE user parameters - it takes admin authority to assign these.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AssignableUserParameters', @level2type=N'COLUMN',@level2name=N'ParmName'
GO
