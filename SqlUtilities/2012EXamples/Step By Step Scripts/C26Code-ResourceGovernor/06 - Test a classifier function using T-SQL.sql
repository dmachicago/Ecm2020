USE [master]
GO
--This script creates a database user
CREATE LOGIN [jdoe]
WITH PASSWORD=N'pass@word1',
DEFAULT_DATABASE=[AdventureWorks2012],
CHECK_EXPIRATION=OFF,
CHECK_POLICY=OFF
GO
USE [AdventureWorks2012]
GO
CREATE USER [jdoe] FOR LOGIN [jdoe]
GO
USE [AdventureWorks2012]
GO
ALTER ROLE [db_datareader] ADD MEMBER [jdoe]
GO

--Selects data
USE AdventureWorks2012;
SELECT *
FROM HumanResources.Department

--Identifies which resource governor workgoup a sessoin is placed in
SELECT
s.group_id,
CAST(g.name as nvarchar(20)) ResourceGroup,
s.session_id,
s.login_name,
s.login_time,
CAST(s.host_name as nvarchar(20)) HostName,
CAST(s.program_name AS nvarchar(20)) ProgramName
FROM sys.dm_exec_sessions s
INNER JOIN sys.dm_resource_governor_workload_groups g
ON g.group_id = s.group_id
WHERE
g.name = 'sbsSSMSgroup'
ORDER BY
g.name
GO