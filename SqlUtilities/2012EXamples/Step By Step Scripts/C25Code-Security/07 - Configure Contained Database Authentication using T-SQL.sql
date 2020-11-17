use master
go
exec sp_configure 'contained database authentication', '1';
go
reconfigure;
USE [master]
GO
ALTER DATABASE [SBSContained] SET CONTAINMENT = PARTIAL
GO