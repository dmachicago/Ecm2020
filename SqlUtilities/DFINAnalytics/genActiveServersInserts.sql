

/*
Run this select statement against all SQL Servers to be monitored. It will 
create the insert statements to be run against the MASTER DFINAnalytics server.
Modify as needed to get acess to the target server.
*/
select 'INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           (''dfintest'',''' + @@servername + ''',''N'',''' + [name] + ''',''sa'',''Junebug1'',''' + cast(newid() as nvarchar(50)) + ''', 1);' + char(10) + 'GO'
from sys.databases
where name not in ('masterdb', 'msdb', 'model', 'tempdb')

/*
Once the ActiveServers is fully populated, run this query against it.
This will create the input data for D:\dev\SQL\DFINAnalytics\ControlFiles\AllInstances.txt
This data file is used by the PowerShell routines.
*/
select distinct isAzure +'|' + SvrName + '|' + DBName +'|' + isnull(UserID,'') + '|' + isnull(pwd,'') as [DATA]
from [dbo].[ActiveServers]


/*
select * from [dbo].[ActiveServers] 
delete from [dbo].[ActiveServers]  where SvrName = 'SVR2016'
*/

INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','AW_VMWARE','sa','Junebug1','C584FFCB-5E84-4BDC-939A-DB3E838331FF', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','DFINAnalytics','sa','Junebug1','9E4BBBDA-6556-48DD-81D5-4FE23EF2BE4C', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','DFS','sa','Junebug1','ADFA6CD5-56C1-408B-95BA-3FC0A96A0772', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','master','sa','Junebug1','74884703-1D2A-4CCB-B330-E9C4F65498D7', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','MstrData','sa','Junebug1','24B6B2EB-2B4B-4CF5-88D0-7DBD8A7730FE', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','MstrLog','sa','Junebug1','082AD2AA-56E8-4B8A-B449-06C6CD96ACF6', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','MstrPort','sa','Junebug1','EE6E9389-5595-4418-B253-4FDA3A1CA73C', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','ReportServer','sa','Junebug1','F698B67E-30DE-4B25-8245-BBE837546AE0', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','ReportServerTempDB','sa','Junebug1','195B35EC-92E6-40F1-8994-28989F6D7869', 1);
GO
INSERT INTO [dbo].[ActiveServers] ([GroupName],[SvrName],[isAzure],[DBName],[UserID],[pwd],[UID],[Enable])
     VALUES
           ('dfintest','SVR2016','N','TestXml','sa','Junebug1','A48FBBF9-ED1D-4912-B671-1463985F9B28', 1);
GO