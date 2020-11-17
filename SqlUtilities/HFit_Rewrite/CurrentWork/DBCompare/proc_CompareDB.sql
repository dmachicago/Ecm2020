
--****************************************************************************
-- Author: W. Dale Miller
-- 02.24.2015 (WDM) 
--****************************************************************************

--****************************************************************************
-- LINK THE SERVERS
--****************************************************************************
EXEC DFINAnalytics.dbo.sp_addlinkedserver @server = N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @srvproduct=N'SQL Server';

--Execute the following code to test the connection to the linked server. This example the returns the names of the databases on the linked server.
declare @iCnt as int = (SELECT count(*) FROM [HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)].master.sys.databases);
--EXEC DFINAnalytics.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', @locallogin = NULL , @useself = N'False'

print('#Databases in linked server: ' + cast (@iCnt as nvarchar(50))) ;

CREATE SYNONYM SVR_Child FOR [HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)] ;


select * 
into #ColsLeft
from information_schema.columns
order by table_name, column_name;

select * 
into #ColsRight
from [HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)].KenticoCMS_DEV..information_schema.columns
order by table_name, column_name;


exec sp_dropserver 'HFIT-SQLDEVTST.CLOUDAPP.NET,2 = YELLOW (TEST)', 'droplogins';