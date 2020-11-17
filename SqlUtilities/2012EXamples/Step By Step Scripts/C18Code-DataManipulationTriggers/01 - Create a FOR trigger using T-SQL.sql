USE AdventureWorks2012;
GO
CREATE TRIGGER HumanResources.iCheckModifedDate
ON HumanResources.Department
FOR INSERT
AS
BEGIN
DECLARE @modifieddate datetime, @DepartmentID int
SELECT @modifieddate = modifieddate, @DepartmentID = departmentid FROM inserted;
IF(DATEDIFF(Day, @modifiedDate, getdate()) > 0)
BEGIN
UPDATE HumanResources.Department
SET ModifiedDate = GETDATE()
WHERE DepartmentID = @DepartmentID
END
END

USE AdventureWorks2012;
INSERT INTO HumanResources.Department
VALUES('Executive Marketing', 'Executive General and Administration', '2/12/2011');
SELECT *
FROM HumanResources.Department