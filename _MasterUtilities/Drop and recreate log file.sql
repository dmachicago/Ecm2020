--SELECT TYPE_DESC, NAME, size, max_size, growth, is_percent_growth FROM sys.database_files;
DECLARE @FileName sysname = N'ECM.Library.FS_log';

-- Script to drop and recreate log file
USE master;  
go

ALTER DATABASE [ECM.Library.FS]
SET SINGLE_USER;  
GO  
ALTER DATABASE [ECM.Library.FS] REMOVE FILE [ECM.Library.FS_log]

exec sp_detach_db @dbname='ECM.Library.FS' , @keepfulltextindexfile='true';   

go

declare @LogFile nvarchar(200) = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ECM.Library.FS_log.ldf' 
EXEC master.sys.xp_delete_files @LogFile
--Remove [ECM.Library.FS] log file
ALTER DATABASE [ECM.Library.FS] REMOVE FILE [ECM.Library.FS_log];

go
USE [master]
GO
CREATE DATABASE [ECM.Library.FS] ON 
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ECM.Library.FS.mdf' ),
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ECM.Library.FS_log.ldf' )
 FOR ATTACH
GO


-- VERIFY THE NAME OF THE DATABASE FILE AS IT EXISTS ON YOUR SYSTEM
EXEC sp_attach_db @dbname = N'ECM.Llibrary.FS',   
    @filename1 = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data\ECM.Llibrary.FS_Data.mdf'

-- OR MAY REQUIRE THIS STATEMENT
EXECUTE sp_attach_single_file_db 
@dbname='ECM.Llibrary.FS',
@physname=N'C:\ProgramFiles\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ECM.Llibrary.FS_Data.mdf'

go
ALTER DATABASE [ECM.Llibrary.FS]
SET MULTI_USER
