USE SBSChp4TSQL;
CREATE TABLE HumanResources.Address
(
AddressID int NOT NULL IDENTITY(1,1),
StreetAddress varchar(125) NOT NULL,
StreetAddress2 varchar(75) NULL,
City varchar(100) NOT NULL,
State char(2) NOT NULL,
EmployeeID int NOT NULL
) ON [SBSTSQLGroup1];