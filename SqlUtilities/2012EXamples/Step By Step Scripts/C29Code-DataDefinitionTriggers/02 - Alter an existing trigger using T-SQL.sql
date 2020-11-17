USE AdventureWorks2012
GO
ALTER TRIGGER trAuditTableChanges
ON DATABASE
FOR ALTER_TABLE
AS
DECLARE @Data XML
SET @Data = EventData()
INSERT TableAudits (AuditDate, UserName, AuditEvent, TSQLStateent)
VALUES
(GETDATE(),
CONVERT(NVARCHAR(100), SYSTEM_USER),
@Data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),
@Data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') ) ;