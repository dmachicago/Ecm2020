USE AdventureWorks2012;
--Disable a Trigger with T-SQL
DISABLE TRIGGER HumanResources.iCheckModifedDate
ON HumanResources.Department;
--Enable a Trigger with T-SQL
ENABLE TRIGGER HumanResources.iCheckModifedDate
ON HumanResources.Department;
