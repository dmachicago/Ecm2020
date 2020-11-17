--Use this query to alias a table and column
USE AdventureWorks2012;
SELECT
DepartmentID,
Name AS DepartmentName,
GroupName AS DepartmentGroupName
FROM HumanResources.Department AS d