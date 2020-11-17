USE AdventureWorks2012;
SELECT
DepartmentID, Name, GroupName, ModifiedDate
INTO dbo.Department
FROM HumanResources.Department