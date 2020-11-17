--Adding a Column using TSQL
USE SBSChp4TSQL;
ALTER TABLE HumanResources.Employee
ADD CONSTRAINT PK_HumanResourcesEmployee_EmployeeID
PRIMARY KEY (EmployeeID);
ALTER TABLE HumanResources.[Address]
ADD CONSTRAINT PK_HumanResourcesAddress_AddressID
PRIMARY KEY (AddressID);ALTER TABLE HumanResources.Employee
ADD CONSTRAINT DF_HumanResourcesEmployee_Active_True DEFAULT(1) FOR Active;
ALTER TABLE HumanResources.Employee
ADD CONSTRAINT UQ_HumanResourcesEmployee_SocialSecurityNumber
UNIQUE (SocialSecurityNumber);