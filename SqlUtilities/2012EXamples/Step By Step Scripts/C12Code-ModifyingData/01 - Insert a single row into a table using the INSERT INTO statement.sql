USE AdventureWorks2012;
INSERT INTO HumanResources.Department(Name, GroupName, ModifiedDate)
VALUES('Payroll', 'Executive General and Administration', '6/12/2012');

USE AdventureWorks2012;
SELECT
DepartmentID, Name, GroupName, ModifiedDate
FROM HumanResources.Department
ORDER BY DepartmentID DESC;