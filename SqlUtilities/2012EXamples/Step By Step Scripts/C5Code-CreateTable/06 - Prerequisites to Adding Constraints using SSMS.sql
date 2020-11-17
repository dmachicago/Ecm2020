--Prerequisites to Adding Constraints using SSMS
USE SBSChp4TSQL;
ALTER TABLE HumanResources.Employee
ADD Active bit NOT NULL;
ALTER TABLE HumanResources.Employee
ADD SocialSecurityNumber varchar(10) NOT NULL;
USE SBSChp4SSMS;
ALTER TABLE HumanResources.Employee
ADD Active bit NOT NULL;
ALTER TABLE HumanResources.Employee
ADD SocialSecurityNumber varchar(10) NOT NULL;