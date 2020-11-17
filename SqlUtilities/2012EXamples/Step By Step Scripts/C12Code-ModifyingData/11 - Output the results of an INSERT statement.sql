USE AdventureWorks2012;
INSERT INTO HumanResources.Department
OUTPUT inserted.DepartmentID, inserted.Name, inserted.GroupName, inserted.
ModifiedDate
VALUES('International Marketing', 'Sales and Marketing', '5/26/2012');