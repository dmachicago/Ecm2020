USE [master]
GO
EXEC master.dbo.sp_addlinkedserver @server = N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @srvproduct=N'SQL Server'

exec sp_dropserver 'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', 'droplogins';

GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'collation compatible', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'data access', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'dist', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'pub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'rpc', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'rpc out', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'sub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'connect timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'collation name', @optvalue=null
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'lazy schema validation', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'query timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'use remote collation', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO
USE [master]
GO
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @locallogin = NULL , @useself = N'False'
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
