USE AdventureWorks2012
GO
--Create table that will store data from trigger
IF(OBJECT_ID('dbo.TableAudits')) IS NOT NULL
DROP TABLE dbo.TableAudits
CREATE TABLE dbo.TableAudits
(
UserName nvarchar(100),
AuditEvent nvarchar(100),
TSQLStateent nvarchar(2000),
AuditDate datetime
)
GO

--Create Data Definition trigger
USE AdventureWorks2012;
GO
IF EXISTS (SELECT * FROM sys.triggers
WHERE parent_class = 0 AND name = 'trAuditTableChanges')
DROP TRIGGER trAuditTableChanges
ON DATABASE;
GO
CREATE TRIGGER trAuditTableChanges
ON DATABASE
FOR ALTER_TABLE
AS
DECLARE @Data XML
SET @Data = EventData()
INSERT TableAudits (AuditDate, UserName, AuditEvent, TSQLStateent)
VALUES
(GETDATE(),
CONVERT(NVARCHAR(100), CURRENT_USER),
@Data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),
@Data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') ) ;
GO

--Script to Alter TAble
USE AdventureWorks2012
GO
ALTER TABLE HumanResources.Employee
ADD Age int;


--Select from audit table to view capture data
USE AdventureWorks2012
GO
SELECT *
FROM dbo.TableAudits