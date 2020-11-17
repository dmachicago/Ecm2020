USE AdventureWorks2012;
SET IDENTITY_INSERT HumanResources.Department ON
INSERT INTO HumanResources.Department(DepartmentID, Name, GroupName, ModifiedDate)
VALUES(18, 'International Marketing', 'Sales and Marketing', '5/26/2012');
SET IDENTITY_INSERT HumanResources.Department OFF