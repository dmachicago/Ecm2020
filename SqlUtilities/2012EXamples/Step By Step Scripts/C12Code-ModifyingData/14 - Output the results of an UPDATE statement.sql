USE AdventureWorks2012;
UPDATE HumanResources.Department
SET Name = Name +' Europe'
OUTPUT
deleted.Name AS OldName,
inserted.Name AS UpdateValue
WHERE DepartmentID = 25