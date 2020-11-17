USE AdventureWorks2012
GO
IF(OBJECT_ID('dbo.States')) IS NOT NULL
	DROP TABLE dbo.States
GO
CREATE TABLE dbo.States
(
	StateID int PRIMARY KEY,
	StateName varchar(50),
	StateAbbrev char(2)
)
GO

USE AdventureWorks2012
GO
CREATE SEQUENCE dbo.StateSeq
AS int
START WITH 1
INCREMENT BY 1
GO

USE AdventureWorks2012
GO
INSERT INTO dbo.States(StateID, StateAbbrev, StateName)
VALUES	(NEXT VALUE FOR dbo.StateSeq, 'LA', 'Louisiana')
INSERT INTO dbo.States(StateID, StateAbbrev, StateName)
VALUES  (NEXT VALUE FOR dbo.StateSeq, 'TX', 'Texas')
INSERT INTO dbo.States(StateID, StateAbbrev, StateName)	
VALUES  (NEXT VALUE FOR dbo.StateSeq, 'FL', 'Florida')
GO
SELECT * FROM dbo.States
