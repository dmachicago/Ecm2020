--Use this code to add the Gender column to the Employee table
USE SBSChp4TSQL;
ALTER TABLE HumanResources.Employee
ADD FullName AS LastName+', '+FirstName;