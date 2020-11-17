USE [AdventureWorks2012]
GO
CREATE ROLE [DBControlTable_reader] AUTHORIZATION [sa]
GO
USE [AdventureWorks2012]
GO
ALTER ROLE [DBControlTable_reader] ADD MEMBER [edustl\jdoe]
GO
use [AdventureWorks2012]
GO
GRANT SELECT ON [dbo].[DatabaseLog] TO [DBControlTable_reader]
GO
use [AdventureWorks2012]
GO
GRANT SELECT ON [dbo].[AWBuildVersion] TO [DBControlTable_reader]
GO
use [AdventureWorks2012]
GO
GRANT SELECT ON [dbo].[ErrorLog] TO [DBControlTable_reader]
GO