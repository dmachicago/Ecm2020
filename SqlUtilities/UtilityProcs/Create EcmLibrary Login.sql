USE [master]
GO
CREATE LOGIN [EcmLibrary] WITH PASSWORD=N'Junebug1', DEFAULT_DATABASE=[ECM.Library]
GO
EXEC master..sp_addsrvrolemember @loginame = N'EcmLibrary', @rolename = N'serveradmin'
GO
