


USE [ECM.SecureLogin];
GO

/****** Object:  User [ECMLibrary]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.database_principals
    WHERE name = N'ECMLibrary'
)
    CREATE USER [ECMLibrary] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [ECMLibrary];
GO

/****** Object:  User [ecmlogin]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.database_principals
    WHERE name = N'ecmlogin'
)
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators];
GO

/****** Object:  User [ECMUser]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.database_principals
    WHERE name = N'ECMUser'
)
    CREATE USER [ECMUser] FOR LOGIN [ecmuser] WITH DEFAULT_SCHEMA = [ECMUser];
GO
ALTER ROLE [db_owner] ADD MEMBER [ECMLibrary];
GO
ALTER ROLE [db_datareader] ADD MEMBER [ECMLibrary];
GO
ALTER ROLE [db_datawriter] ADD MEMBER [ECMLibrary];
GO
ALTER ROLE [db_owner] ADD MEMBER [ECMUser];
GO
ALTER ROLE [db_datareader] ADD MEMBER [ECMUser];
GO
ALTER ROLE [db_datawriter] ADD MEMBER [ECMUser];
GO

/****** Object:  Table [dbo].[ActiveLogin]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ActiveLogin]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE [dbo].[ActiveLogin]
        ([ActiveGuid]   [UNIQUEIDENTIFIER] NULL, 
         [ActiveConnID] [INT] NULL, 
         [UserID]       [NVARCHAR](50) NULL, 
         [CompanyID]    [NVARCHAR](100) NULL, 
         [ReporID]      [NVARCHAR](100) NULL
        )
        ON [PRIMARY];
END;
GO

/****** Object:  Index [PK_ActiveLogin]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[ActiveLogin]')
          AND name = N'PK_ActiveLogin'
)
    CREATE UNIQUE CLUSTERED INDEX [PK_ActiveLogin] ON [dbo].[ActiveLogin]([ActiveGuid] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[ActiveSession]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[ActiveSession]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE [dbo].[ActiveSession]
        ([SessionGuid] [UNIQUEIDENTIFIER] NOT NULL, 
         [Parm]        [NVARCHAR](50) NOT NULL, 
         [InitDate]    [DATETIME] NOT NULL, 
         [ParmVal]     [NVARCHAR](2000) NULL
        )
        ON [PRIMARY];
END;
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [PK_ActiveSession]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[ActiveSession]')
          AND name = N'PK_ActiveSession'
)
    CREATE UNIQUE CLUSTERED INDEX [PK_ActiveSession] ON [dbo].[ActiveSession]([SessionGuid] ASC, [Parm] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[SecureAttach]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[SecureAttach]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE [dbo].[SecureAttach]
        ([CompanyID]              [NVARCHAR](100) NOT NULL, 
         [EncPW]                  [NVARCHAR](200) NOT NULL, 
         [RepoID]                 [NVARCHAR](100) NOT NULL, 
         [CS]                     [NVARCHAR](2000) NOT NULL, 
         [Disabled]               [BIT] NULL, 
         [RowID]                  [INT] IDENTITY(1, 1) NOT NULL, 
         [isThesaurus]            [BIT] NULL, 
         [CSRepo]                 [NVARCHAR](2000) NULL, 
         [CSThesaurus]            [NVARCHAR](2000) NULL, 
         [CSHive]                 [NVARCHAR](2000) NULL, 
         [CSDMALicense]           [NVARCHAR](2000) NULL, 
         [CSGateWay]              [NVARCHAR](2000) NULL, 
         [CSTDR]                  [NVARCHAR](2000) NULL, 
         [CSKBase]                [NVARCHAR](2000) NULL, 
         [CreateDate]             [DATETIME] NULL, 
         [LastModDate]            [DATETIME] NULL, 
         [SVCFS_Endpoint]         [VARCHAR](2000) NULL, 
         [SVCGateway_Endpoint]    [VARCHAR](2000) NULL, 
         [SVCCLCArchive_Endpoint] [VARCHAR](2000) NULL, 
         [SVCSearch_Endpoint]     [VARCHAR](2000) NULL, 
         [SVCDownload_Endpoint]   [NVARCHAR](2000) NULL, 
         [SVCFS_CS]               [NVARCHAR](2000) NULL, 
         [SVCGateway_CS]          [NVARCHAR](2000) NULL, 
         [SVCSearch_CS]           [NVARCHAR](2000) NULL, 
         [SVCDownload_CS]         [NVARCHAR](2000) NULL, 
         [SVCThesaurus_CS]        [NVARCHAR](2000) NULL, 
         [SvrName]                [NVARCHAR](100) NOT NULL, 
         [DBName]                 [NVARCHAR](100) NOT NULL, 
         [InstanceName]           [NVARCHAR](100) NOT NULL, 
         [LoginID]                [NVARCHAR](500) NOT NULL, 
         [LoginPW]                [NVARCHAR](500) NOT NULL, 
         [ConnTimeout]            [NVARCHAR](100) NOT NULL, 
         [ckWinAuth]              [BIT] NOT NULL
        )
        ON [PRIMARY];
END;
GO

/****** Object:  Table [dbo].[SessionID]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[SessionID]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE [dbo].[SessionID]
        ([UserID]     [NVARCHAR](100) NOT NULL, 
         [SessionID]  [NVARCHAR](50) NOT NULL, 
         [CreateDate] [DATETIME2](7) NOT NULL, 
         [RowNbr]     [INT] IDENTITY(1, 1) NOT NULL
        )
        ON [PRIMARY];
END;
GO

/****** Object:  Table [dbo].[User]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[User]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE [dbo].[User]
        ([UserID]     [NVARCHAR](50) NOT NULL, 
         [UserPW]     [NVARCHAR](50) NOT NULL, 
         [CreateDate] [DATETIME] NULL, 
         [isActive]   [CHAR](1) NULL
        )
        ON [PRIMARY];
END;
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [PK_User]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[User]')
          AND name = N'PK_User'
)
    CREATE UNIQUE CLUSTERED INDEX [PK_User] ON [dbo].[User]([UserID] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[UserRepo]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[UserRepo]')
          AND type IN(N'U')
)
    BEGIN
        CREATE TABLE [dbo].[UserRepo]
        ([CompanyID]    [NVARCHAR](50) NOT NULL, 
         [UserID]       [NVARCHAR](50) NOT NULL, 
         [SvrName]      [NVARCHAR](100) NOT NULL, 
         [DBName]       [NVARCHAR](100) NOT NULL, 
         [InstanceName] [NVARCHAR](100) NULL, 
         [CreateDate]   [DATETIME] NULL, 
         [LastUpdate]   [DATETIME] NULL, 
         [RepoID]       [NVARCHAR](100) NULL, 
         [PW]           [NVARCHAR](100) NULL
        )
        ON [PRIMARY];
END;
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [PK_UserRepo]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[UserRepo]')
          AND name = N'PK_UserRepo'
)
    CREATE UNIQUE CLUSTERED INDEX [PK_UserRepo] ON [dbo].[UserRepo]([CompanyID] ASC, [UserID] ASC, [SvrName] ASC, [DBName] ASC, [InstanceName] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [UI_ActiveLogin]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[ActiveLogin]')
          AND name = N'UI_ActiveLogin'
)
    CREATE UNIQUE NONCLUSTERED INDEX [UI_ActiveLogin] ON [dbo].[ActiveLogin]([UserID] ASC, [CompanyID] ASC, [ReporID] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
SET ANSI_PADDING ON;
GO

/****** Object:  Index [PK_SecureAttach]    Script Date: 11/2/2019 10:14:58 AM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'[dbo].[SecureAttach]')
          AND name = N'PK_SecureAttach'
)
    CREATE UNIQUE NONCLUSTERED INDEX [PK_SecureAttach] ON [dbo].[SecureAttach]([CompanyID] ASC, [SvrName] ASC, [DBName] ASC, [InstanceName] ASC) WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_ActiveSession_InitDate]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[ActiveSession]
        ADD CONSTRAINT [DF_ActiveSession_InitDate] DEFAULT(GETDATE()) FOR [InitDate];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__Creat__07020F21]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD CONSTRAINT [DF__SecureAtt__Creat__07020F21] DEFAULT(GETDATE()) FOR [CreateDate];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__LastM__07F6335A]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD CONSTRAINT [DF__SecureAtt__LastM__07F6335A] DEFAULT(GETDATE()) FOR [LastModDate];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__SvrNa__2A4B4B5E]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD DEFAULT('NA') FOR [SvrName];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__DBNam__2B3F6F97]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD DEFAULT('NA') FOR [DBName];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__Insta__2C3393D0]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD DEFAULT('NA') FOR [InstanceName];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__Login__2D27B809]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD DEFAULT('NA') FOR [LoginID];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__Login__2E1BDC42]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD DEFAULT('NA') FOR [LoginPW];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__ConnT__2F10007B]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD DEFAULT('30') FOR [ConnTimeout];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__SecureAtt__ckWin__300424B4]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SecureAttach]
        ADD DEFAULT((1)) FOR [ckWinAuth];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_SessionID_CreateDate]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[SessionID]
        ADD CONSTRAINT [DF_SessionID_CreateDate] DEFAULT(GETDATE()) FOR [CreateDate];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF_User_CreateDate]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[User]
        ADD CONSTRAINT [DF_User_CreateDate] DEFAULT(GETDATE()) FOR [CreateDate];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__UserRepo__Instan__32E0915F]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[UserRepo]
        ADD DEFAULT('') FOR [InstanceName];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__UserRepo__Create__33D4B598]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[UserRepo]
        ADD DEFAULT(GETDATE()) FOR [CreateDate];
END;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[DF__UserRepo__LastUp__34C8D9D1]')
          AND type = 'D'
)
    BEGIN
        ALTER TABLE [dbo].[UserRepo]
        ADD DEFAULT(GETDATE()) FOR [LastUpdate];
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_GenRandomNbr]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[sp_GenRandomNbr]')
          AND type IN(N'P', N'PC')
)
    BEGIN
        EXEC dbo.sp_executesql 
             @statement = N'CREATE PROCEDURE [dbo].[sp_GenRandomNbr] AS';
END;
GO
ALTER PROCEDURE [dbo].[sp_GenRandomNbr]
AS
     DECLARE @maxRandomValue TINYINT= 100, @minRandomValue TINYINT= 0;
     SELECT CAST(((@maxRandomValue + 1) - @minRandomValue) * RAND() + @minRandomValue AS TINYINT) AS 'randomNumber';
GO

/****** Object:  StoredProcedure [dbo].[sp_Mintes]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[sp_Mintes]')
          AND type IN(N'P', N'PC')
)
    BEGIN
        EXEC dbo.sp_executesql 
             @statement = N'CREATE PROCEDURE [dbo].[sp_Mintes] AS';
END;
GO
ALTER PROCEDURE [dbo].[sp_Mintes]
AS
     SELECT [Total Minutes] = ((DATEPART(hh, GETDATE()) * 3600) + (DATEPART(mi, GETDATE()) * 60) + DATEPART(ss, GETDATE())) / 60;
GO

/****** Object:  StoredProcedure [dbo].[sp_Minutes]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[sp_Minutes]')
          AND type IN(N'P', N'PC')
)
    BEGIN
        EXEC dbo.sp_executesql 
             @statement = N'CREATE PROCEDURE [dbo].[sp_Minutes] AS';
END;
GO
ALTER PROCEDURE [dbo].[sp_Minutes]
AS
     SELECT [Total Minutes] = ((DATEPART(hh, GETDATE()) * 3600) + (DATEPART(mi, GETDATE()) * 60) + DATEPART(ss, GETDATE())) / 60;
GO

/****** Object:  StoredProcedure [dbo].[sp_Seconds]    Script Date: 11/2/2019 10:14:58 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[sp_Seconds]')
          AND type IN(N'P', N'PC')
)
    BEGIN
        EXEC dbo.sp_executesql 
             @statement = N'CREATE PROCEDURE [dbo].[sp_Seconds] AS';
END;
GO
ALTER PROCEDURE [dbo].[sp_Seconds]
AS
     SELECT [Total Seconds] = (DATEPART(hh, GETDATE()) * 3600) + (DATEPART(mi, GETDATE()) * 60) + DATEPART(ss, GETDATE());
GO



