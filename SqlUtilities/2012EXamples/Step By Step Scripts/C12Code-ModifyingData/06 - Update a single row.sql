-- Update a single row
USE AdventureWorks2012;
UPDATE HumanResources.Department
SET Name = Name +' Europe'
WHERE DepartmentID = 19

--Update a single row with a Like clause
USE AdventureWorks2012;
UPDATE HumanResources.Department
SET Name = Name +' Europe'
WHERE DepartmentID = 19
AND NAME NOT LIKE '% Europe'