--Creating a foreign key using T-SQL
USE SBSChp4TSQL;
ALTER TABLE HumanResources.Address
ADD CONSTRAINT FK_Employee_To_Address_On_EmployeeID
FOREIGN KEY (EmployeeID)
REFERENCES HumanResources.Employee(EmployeeID);