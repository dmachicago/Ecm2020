USE AdventureWorks2012;
GO
CREATE TABLE dbo.Department_Audit
(
DepartmentID int NOT NULL,
Name nvarchar(50) NOT NULL,
GroupName nvarchar(50) NOT NULL,
DeletedDate datetime NOT NULL
CONSTRAINT DF_Department_Audit_DeletedDate_Today DEFAULT(GETDATE())
)
GO

USE AdventureWorks2012;
DELETE FROM dbo.Department
OUTPUT deleted.Departmentid, deleted.Name, deleted.GroupName
INTO dbo.Department_Audit(DepartmentID, Name, GroupName)
WHERE DepartmentID = 16;

USE AdventureWorks2012;
SELECT *
FROM dbo.Department_Audit