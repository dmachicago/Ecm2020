USE [AdventureWorks2012]
GO
CREATE USER [domaim\jdoe] FOR LOGIN [domaim\jdoe] WITH DEFAULT_SCHEMA=[dbo]
GO
use [AdventureWorks2012]
GO
GRANT DELETE ON [dbo].[DatabaseLog] TO [domaim\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT INSERT ON [dbo].[DatabaseLog] TO [domaim\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT SELECT ON [dbo].[DatabaseLog] TO [domaim\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT UPDATE ON [dbo].[DatabaseLog] TO [domaim\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT DELETE ON [dbo].[AWBuildVersion] TO [domaim\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT INSERT ON [dbo].[AWBuildVersion] TO [domaim\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT SELECT ON [dbo].[AWBuildVersion] TO [domaim\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT UPDATE ON [dbo].[AWBuildVersion] TO [domaim\jdoe]
GO