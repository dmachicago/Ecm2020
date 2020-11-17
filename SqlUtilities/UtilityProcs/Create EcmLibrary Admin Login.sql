/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [sa]    Script Date: 05/15/2010 19:17:38 ******/
CREATE LOGIN [EcmLibrary] WITH PASSWORD=N'Junebug1', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

EXEC sys.sp_addsrvrolemember @loginame = N'EcmLibrary', @rolename = N'sysadmin'
GO


