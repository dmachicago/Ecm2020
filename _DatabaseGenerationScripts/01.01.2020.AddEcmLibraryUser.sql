
USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [sa]    Script Date: 9/18/2019 9:47:59 AM ******/
IF NOT EXISTS (SELECT 1 FROM master.sys.server_principals where name = 'ECMLibrary')
Begin
	CREATE LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
	ALTER LOGIN [ECMLibrary] ENABLE
	ALTER SERVER ROLE [sysadmin] ADD MEMBER [ECMLibrary]
end
GO

IF NOT EXISTS (SELECT 1 FROM master.sys.server_principals where name = 'ecmocr')
Begin
CREATE LOGIN [ecmocr] WITH PASSWORD=N'Junebug1', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [ecmocr] ENABLE
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmocr]
end
GO


IF NOT EXISTS (SELECT 1 FROM master.sys.server_principals where name = 'ecmuser')
Begin
CREATE LOGIN [ecmuser] WITH PASSWORD=N'Junebug1', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [ecmuser] ENABLE
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmuser]
end
GO


IF NOT EXISTS (SELECT 1 FROM master.sys.server_principals where name = 'ecmadmin')
Begin
CREATE LOGIN [ecmadmin] WITH PASSWORD=N'Junebug1', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
ALTER LOGIN [ecmadmin] ENABLE
ALTER SERVER ROLE [sysadmin] ADD MEMBER [ecmadmin]
end
GO


go
USE [ECM.Hive]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE 

USE [TDR]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE 

USE [DMA.UD.License]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE 

USE [ECM.Init]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE 

USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE 

USE [ECM.Library.FS]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE 

USE [ECM.SecureLogin]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE 

USE [ECM.Thesaurus]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ECMLibrary')
Begin
    CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ECMLibrary] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ECMLibrary] ENABLE;

/**********************************************************************************************/
go
USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

USE [TDR]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

USE [DMA.UD.License]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

USE [ECM.Init]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

USE [ECM.Library.FS]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

USE [ECM.SecureLogin]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

USE [ECM.Thesaurus]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmlogin')
Begin
    CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmlogin] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmlogin] ENABLE 

/**********************************************************************************************/
go
USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

USE [TDR]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

USE [DMA.UD.License]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

USE [ECM.Init]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

USE [ECM.Library.FS]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

USE [ECM.SecureLogin]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

USE [ECM.Thesaurus]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmocr')
Begin
    CREATE USER [ecmocr] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmocr] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmocr] ENABLE

/**********************************************************************************************/
go
USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE

USE [TDR]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE
USE [DMA.UD.License]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE

USE [ECM.Init]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE

USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE

USE [ECM.Library.FS]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE

USE [ECM.SecureLogin]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE

USE [ECM.Thesaurus]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmsys')
Begin
    CREATE USER [ecmsys] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmsys] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmsys] ENABLE

/**********************************************************************************************/
go
USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE
USE [TDR]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE

USE [DMA.UD.License]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE

USE [ECM.Init]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE

USE [ECM.Language]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE

USE [ECM.Library.FS]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE

USE [ECM.SecureLogin]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE

USE [ECM.Thesaurus]
GO
IF NOT EXISTS (SELECT * FROM [sys].[database_principals] where name = 'ecmuser')
Begin
    CREATE USER [ecmuser] FOR LOGIN [BUILTIN\Administrators]
end
ALTER LOGIN [ecmuser] WITH PASSWORD=N'Junebug1'
ALTER LOGIN [ecmuser] ENABLE
