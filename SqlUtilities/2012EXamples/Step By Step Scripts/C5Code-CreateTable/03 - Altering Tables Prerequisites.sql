--This script is a prerequisite to the Adding column to an existing table using SSMS Steps in the Alterting Table Section
USE SBSChp4TSQL;
CREATE TABLE HumanResources.Employee
(
EmployeeID int NOT NULL IDENTITY(1,1),
FirstName varchar(50) NOT NULL,
MiddleName varchar(50) NULL,
LastName varchar(50) NOT NULL
) ON [SBSTSQLGroup1]; USE SBSChp4SSMS;CREATE TABLE HumanResources.Employee
(
EmployeeID int NOT NULL IDENTITY(1,1),
FirstName varchar(50) NOT NULL,
MiddleName varchar(50) NULL,
LastName varchar(50) NOT NULL
) ON [SBSSSMSGroup1];