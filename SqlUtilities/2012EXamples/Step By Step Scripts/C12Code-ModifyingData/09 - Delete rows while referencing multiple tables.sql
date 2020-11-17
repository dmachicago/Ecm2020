USE AdventureWorks2012;
DELETE FROM HumanResources.Department
FROM HumanResources.Department d
LEFT OUTER JOIN HumanResources.EmployeeDepartmentHistory ed
ON d.DepartmentID = ed.DepartmentID
WHERE ed.DepartmentID IS NULL