USE [master]
GO
/****** Object:  Database [DMA.UD.License]    Script Date: 5/6/2021 11:48:14 AM ******/
CREATE DATABASE [DMA.UD.License]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DMA.UD.License', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DMA.UD.License.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DMA.UD.License_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DMA.UD.License_log.ldf' , SIZE = 1352KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DMA.UD.License] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DMA.UD.License].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DMA.UD.License] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DMA.UD.License] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DMA.UD.License] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DMA.UD.License] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DMA.UD.License] SET ARITHABORT OFF 
GO
ALTER DATABASE [DMA.UD.License] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DMA.UD.License] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DMA.UD.License] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DMA.UD.License] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DMA.UD.License] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DMA.UD.License] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DMA.UD.License] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DMA.UD.License] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DMA.UD.License] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DMA.UD.License] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DMA.UD.License] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DMA.UD.License] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DMA.UD.License] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DMA.UD.License] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DMA.UD.License] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DMA.UD.License] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DMA.UD.License] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DMA.UD.License] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DMA.UD.License] SET  MULTI_USER 
GO
ALTER DATABASE [DMA.UD.License] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DMA.UD.License] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DMA.UD.License] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DMA.UD.License] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DMA.UD.License] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DMA.UD.License', N'ON'
GO
ALTER DATABASE [DMA.UD.License] SET QUERY_STORE = OFF
GO
USE [DMA.UD.License]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [DMA.UD.License]
GO
/****** Object:  User [ecmuser]    Script Date: 5/6/2021 11:48:14 AM ******/
CREATE USER [ecmuser] FOR LOGIN [ecmuser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ecmsys]    Script Date: 5/6/2021 11:48:14 AM ******/
CREATE USER [ecmsys] FOR LOGIN [ecmsys] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ecmocr]    Script Date: 5/6/2021 11:48:14 AM ******/
CREATE USER [ecmocr] FOR LOGIN [ecmocr] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ECMLibrary]    Script Date: 5/6/2021 11:48:14 AM ******/
CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
GO
/****** Object:  User [ecmadmin]    Script Date: 5/6/2021 11:48:14 AM ******/
CREATE USER [ecmadmin] FOR LOGIN [ecmadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ecmocr]
GO
/****** Object:  FullTextCatalog [EM_IMAGE]    Script Date: 5/6/2021 11:48:14 AM ******/
CREATE FULLTEXT CATALOG [EM_IMAGE] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  Table [dbo].[PgmTrace]    Script Date: 5/6/2021 11:48:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PgmTrace](
	[StmtID] [nvarchar](50) NULL,
	[PgmName] [nvarchar](254) NULL,
	[Stmt] [nvarchar](max) NOT NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConnectiveGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_PgmTrace]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_PgmTrace]
AS
/*
** Select all rows from the PgmTrace table
** and the lookup expressions defined for associated tables
*/
SELECT * FROM [PgmTrace]

GO
/****** Object:  Table [dbo].[ActiveLicense]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveLicense](
	[License] [nvarchar](2000) NOT NULL,
	[InstallDate] [datetime] NOT NULL,
	[LicenseID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [PK_ActiveLicense]    Script Date: 5/6/2021 11:48:15 AM ******/
CREATE UNIQUE CLUSTERED INDEX [PK_ActiveLicense] ON [dbo].[ActiveLicense]
(
	[LicenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[License]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[License](
	[CustomerName] [nvarchar](254) NOT NULL,
	[CustomerID] [nvarchar](50) NOT NULL,
	[LicenseExpireDate] [datetime] NULL,
	[NbrSeats] [int] NULL,
	[NbrSimlUsers] [int] NULL,
	[CompanyResetID] [nvarchar](50) NOT NULL,
	[MasterPW] [nvarchar](50) NOT NULL,
	[LicenseGenDate] [datetime] NULL,
	[License] [nvarchar](max) NOT NULL,
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
	[ServerName] [nvarchar](100) NULL,
	[SqlInstanceName] [varchar](254) NULL,
	[StorageAllotment] [int] NULL,
	[RecNbr] [int] IDENTITY(1,1) NOT NULL,
	[EncryptedLicense] [nvarchar](max) NULL,
	[applied] [int] NULL,
	[LastUpdate] [datetime] NULL,
	[LicenseType] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PK_License]    Script Date: 5/6/2021 11:48:15 AM ******/
CREATE UNIQUE CLUSTERED INDEX [PK_License] ON [dbo].[License]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Programmer]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programmer](
	[ProgrammerID] [int] IDENTITY(1,1) NOT NULL,
	[ProgrammerName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestoreQueueHistory]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestoreQueueHistory](
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UseriD] [nvarchar](50) NULL,
	[MachineID] [nvarchar](80) NULL,
	[FQN] [nvarchar](2500) NULL,
	[FileSize] [int] NULL,
	[ContentType] [varchar](15) NOT NULL,
	[Preview] [bit] NULL,
	[Restore] [bit] NULL,
	[ProcessingCompleted] [bit] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[ProcessedDate] [datetime] NULL,
	[StartDownloadTime] [datetime] NULL,
	[EndDownloadTime] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xLog]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xLog](
	[EntryID] [int] NOT NULL,
	[ErrorText] [nvarchar](2000) NULL,
	[EntryDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI01License_CustName]    Script Date: 5/6/2021 11:48:15 AM ******/
CREATE NONCLUSTERED INDEX [PI01License_CustName] ON [dbo].[License]
(
	[CustomerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PI02_LicenseCustID]    Script Date: 5/6/2021 11:48:15 AM ******/
CREATE NONCLUSTERED INDEX [PI02_LicenseCustID] ON [dbo].[License]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActiveLicense] ADD  CONSTRAINT [DF_ActiveLicense_InstallDate]  DEFAULT (getdate()) FOR [InstallDate]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_LicenseGenDate]  DEFAULT (getdate()) FOR [LicenseGenDate]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_MaxClients]  DEFAULT ((0)) FOR [MaxClients]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_MaxSharePoint]  DEFAULT ((0)) FOR [MaxSharePoint]
GO
ALTER TABLE [dbo].[License] ADD  DEFAULT ((0)) FOR [applied]
GO
ALTER TABLE [dbo].[License] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF_PgmTrace_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT ((0)) FOR [ProcessingCompleted]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (getdate()) FOR [ProcessedDate]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (getdate()) FOR [StartDownloadTime]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[xLog] ADD  DEFAULT (getdate()) FOR [EntryDate]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddDefault]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec sp_AddDefault 'Retention', 'RowGuid'
create procedure [dbo].[sp_AddDefault] (@TBL nvarchar(250), @COL nvarchar(250), @default nvarchar(250))
as
begin
	declare @CMD nvarchar(4000) = '' ;
	set @CMD = 'alter table ' + @TBL + ' ADD DEFAULT('+@default+') FOR ' + @COL +';' ;
	print @CMD ;
	begin try
		exec sp_executesql @CMD ;
	end try
	begin catch
		print 'NOTICE: Default set for ' + @TBL + ' : ' + @COL + ' = ' + @default ;
		print ERROR_MESSAGE() ;
	end catch

end

GO
/****** Object:  StoredProcedure [dbo].[sp_DefaultExists]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--exec sp_DefaultExists 'Retention', 'RowGuid'
create procedure [dbo].[sp_DefaultExists] (@TBL nvarchar(250), @COL nvarchar(250))
as
begin
	declare @I as integer = 0 ;
	set @I = (SELECT count(*)
	FROM sys.default_constraints AS d  
	INNER JOIN sys.columns AS c  
	ON d.parent_object_id = c.object_id
	AND d.parent_column_id = c.column_id  
	WHERE d.parent_object_id = OBJECT_ID(@TBL, N'U')  
	AND c.name = @COL);  
	print @I;
	return @I;
end
GO
/****** Object:  StoredProcedure [dbo].[sp_setPasswords]    Script Date: 5/6/2021 11:48:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_setPasswords]
AS
    BEGIN
        IF OBJECT_ID('tempdb..#pw') IS NOT NULL
            BEGIN
                DROP TABLE #pw
        END;
        CREATE TABLE #pw ( 
                     UserID NVARCHAR(250) , 
                     pw     NVARCHAR(250) ,
                         );
        CREATE INDEX pwtemp ON #pw ( UserID
                                   );
/*
SET THE PERMANENT PASSWORDS HERE 
*/

        INSERT INTO #pw
        VALUES ( 'ECMLibrary' , 'Junebug1'
               );
        INSERT INTO #pw
        VALUES ( 'ecmocr' , 'Junebug2'
               );
        INSERT INTO #pw
        VALUES ( 'ecmuser' , 'Junebug3'
               );
        INSERT INTO #pw
        VALUES ( 'ecmadmin' , 'Junebug4'
               );
        INSERT INTO #pw
        VALUES ( 'ecmsys' , 'Junebug5'
               );
        INSERT INTO #pw
        VALUES ( 'wmiller' , 'Junebug6'
               );
        INSERT INTO #pw
        VALUES ( 'ecmlogin' , 'Junebug7'
               );
        INSERT INTO #pw
        VALUES ( 'dbmgr' , 'Junebug8'
               );
        INSERT INTO #pw
        VALUES ( '##MS_PolicyTsqlExecutionLogin##' , 'Junebug9'
               );
        INSERT INTO #pw
        VALUES ( '##MS_PolicyEventProcessingLogin##' , 'Junebug10'
               );
        DECLARE @cmd NVARCHAR(200)= '';
        DECLARE @ECMLibraryPW NVARCHAR(250)= ( SELECT pw
                                               FROM #pw
                                               WHERE UserID = 'ECMLibraryPW'
                                             );
        DECLARE @ecmocr NVARCHAR(250)= ( SELECT pw
                                         FROM #pw
                                         WHERE UserID = 'ecmocr'
                                       );
        DECLARE @ecmuser NVARCHAR(250)= ( SELECT pw
                                          FROM #pw
                                          WHERE UserID = 'ecmuser'
                                        );
        DECLARE @ecmadmin NVARCHAR(250)= ( SELECT pw
                                           FROM #pw
                                           WHERE UserID = 'ecmadmin'
                                         );
        DECLARE @ecmsys NVARCHAR(250)= ( SELECT pw
                                         FROM #pw
                                         WHERE UserID = 'ecmsys'
                                       );
        DECLARE @wmiller NVARCHAR(250)= ( SELECT pw
                                          FROM #pw
                                          WHERE UserID = 'wmiller'
                                        );
        DECLARE @ecmlogin NVARCHAR(250)= ( SELECT pw
                                           FROM #pw
                                           WHERE UserID = '@ecmlogin'
                                         );
        DECLARE @dbmgr NVARCHAR(250)= ( SELECT pw
                                        FROM #pw
                                        WHERE UserID = 'dbmgr'
                                      );
        DECLARE @MS_PolicyTsqlExecutionLogin NVARCHAR(250)= ( SELECT pw
                                                              FROM #pw
                                                              WHERE UserID = '##MS_PolicyTsqlExecutionLogin##'
                                                            );
        DECLARE @MS_PolicyEventProcessingLogin NVARCHAR(250)= ( SELECT pw
                                                                FROM #pw
                                                                WHERE UserID = '##MS_PolicyEventProcessingLogin##'
                                                              );
        DECLARE @UserID NVARCHAR(250);
        DECLARE @pw NVARCHAR(250);
        DECLARE db_cursor CURSOR
        FOR SELECT UserID , pw
            FROM #pw;
        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO @UserID , @pw;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT 'DB: ' + DB_NAME() + ' / UserID: ' + @UserID + ' / PW: ' + @pw;
                IF SUSER_ID(@UserID) IS NULL
                    BEGIN
                        SET @cmd = 'IF SUSER_ID(''' + @UserID + ''') IS NULL' + CHAR(10) + '    CREATE USER ' + @UserID + ' FOR LOGIN ' + @UserID + ';';
                        PRINT @cmd;
                END;
                SET @cmd = 'ALTER LOGIN ' + @UserID + ' WITH PASSWORD = ''' + @pw + '''';
                PRINT @cmd;
                --exec sp_executesql @cmd ;

                FETCH NEXT FROM db_cursor INTO @UserID , @pw;
            END;
        CLOSE db_cursor;
        DEALLOCATE db_cursor;
    END;
GO
USE [master]
GO
ALTER DATABASE [DMA.UD.License] SET  READ_WRITE 
GO
