--Prerequisites to creating foreign key constraints using SSMS
USE SBSChp4SSMS
ALTER TABLE HumanResources.Address
ADD CONSTRAINT PK_HumanResourcesAddress_AddressID
PRIMARY KEY (AddressID);