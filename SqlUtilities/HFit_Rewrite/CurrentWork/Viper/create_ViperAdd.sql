

USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ViperAdd]    Script Date: 4/24/2016 11:09:35 AM ******/
CREATE LOGIN [ViperAdd] WITH PASSWORD=N'Junebug1', DEFAULT_DATABASE=[viper], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

ALTER LOGIN [ViperAdd] ENABLE
GO

ALTER SERVER ROLE dbcreator ADD MEMBER [ViperAdd]
go

USE [Viper]
GO

/****** Object:  User [ViperAdd]    Script Date: 4/24/2016 11:07:36 AM ******/
CREATE USER [ViperAdd] FOR LOGIN [ViperAdd] WITH DEFAULT_SCHEMA=[dbo]
GO
GRANT SELECT, INSERT, DELETE, UPDATE on SCHEMA::dbo to ViperAdd --often DBO for Schema
go





