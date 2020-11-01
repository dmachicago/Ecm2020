
/****** Object:  Login [wmiller]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'wmiller'
)
    CREATE LOGIN [wmiller] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [ECM.Library.FS], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [wmiller] enable;
GO

/****** Object:  Login [NT SERVICE\Winmgmt]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'NT SERVICE\Winmgmt'
)
    CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
GO

/****** Object:  Login [NT SERVICE\SQLWriter]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'NT SERVICE\SQLWriter'
)
    CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
GO

/****** Object:  Login [NT SERVICE\SQLTELEMETRY]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'NT SERVICE\SQLTELEMETRY'
)
    CREATE LOGIN [NT SERVICE\SQLTELEMETRY] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
GO

/****** Object:  Login [NT SERVICE\SQLSERVERAGENT]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'NT SERVICE\SQLSERVERAGENT'
)
    CREATE LOGIN [NT SERVICE\SQLSERVERAGENT] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
GO

/****** Object:  Login [NT SERVICE\ReportServer]    Script Date: 10/21/2019 2:13:04 PM ******/

--IF NOT EXISTS
--(
--    SELECT *
--    FROM sys.server_principals
--    WHERE name = N'NT SERVICE\ReportServer'
--)
--    CREATE LOGIN [NT SERVICE\ReportServer] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
--GO

/****** Object:  Login [NT Service\MSSQLSERVER]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'NT Service\MSSQLSERVER'
)
    CREATE LOGIN [NT Service\MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
GO

/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'NT AUTHORITY\SYSTEM'
)
    CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
GO

/****** Object:  Login [NT AUTHORITY\NETWORK SERVICE]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'NT AUTHORITY\NETWORK SERVICE'
)
    CREATE LOGIN [NT AUTHORITY\NETWORK SERVICE] FROM WINDOWS WITH DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english];
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmuser]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'ecmuser'
)
    CREATE LOGIN [ecmuser] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [ECM.Library.FS], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [ecmuser] enable;
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmsys]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'ecmsys'
)
    CREATE LOGIN [ecmsys] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [ECM.Library.FS], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [ecmsys] enable;
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmocr]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'ecmocr'
)
    CREATE LOGIN [ecmocr] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [ECM.Library.FS], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [ecmocr] enable;
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmlogin]    Script Date: 10/21/2019 2:13:04 PM ******/

if not exists (select 1 from sys.syslogins where name = 'ecmlogin')
	CREATE USER [ecmlogin] FOR LOGIN [ecmlogin] WITH DEFAULT_SCHEMA=[dbo]

ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ECMLibrary]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'ECMLibrary'
)
    CREATE LOGIN [ECMLibrary] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [ECM.Library.FS], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [ECMLibrary] enable;
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ecmadmin]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'ecmadmin'
)
    CREATE LOGIN [ecmadmin] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [ECM.Library.FS], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [ecmadmin] enable;
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [dbmgr]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'dbmgr'
)
    CREATE LOGIN [dbmgr] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [ECM.Library.FS], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [dbmgr] enable;
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'##MS_PolicyTsqlExecutionLogin##'
)
    CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] enable;
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 10/21/2019 2:13:04 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.server_principals
    WHERE name = N'##MS_PolicyEventProcessingLogin##'
)
    CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD = N'Junebug1', DEFAULT_DATABASE = [master], DEFAULT_LANGUAGE = [us_english], CHECK_EXPIRATION = OFF, CHECK_POLICY = ON;
GO
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] enable;
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [wmiller];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [wmiller];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\Winmgmt];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLWriter];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLSERVERAGENT];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT Service\MSSQLSERVER];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT AUTHORITY\SYSTEM];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmuser];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmocr];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ECMLibrary];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmadmin];
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [dbmgr];
GO

/****** Object:  User [ecmocr]    Script Date: 10/21/2019 2:13:05 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.database_principals
    WHERE name = N'ecmocr'
)
    CREATE USER [ecmocr] FOR LOGIN [ecmocr] WITH DEFAULT_SCHEMA = [dbo];
GO

/****** Object:  User [ECMLibrary]    Script Date: 10/21/2019 2:13:05 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sys.database_principals
    WHERE name = N'ECMLibrary'
)
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators];
GO
ALTER ROLE [db_owner] ADD MEMBER [ecmocr];
GO

/****** Object:  FullTextCatalog [EM_IMAGE]    Script Date: 10/21/2019 2:13:05 PM ******/

IF NOT EXISTS
(
    SELECT *
    FROM sysfulltextcatalogs ftc
    WHERE ftc.name = N'EM_IMAGE'
)
    CREATE FULLTEXT CATALOG [EM_IMAGE] WITH ACCENT_SENSITIVITY = OFF;
GO
