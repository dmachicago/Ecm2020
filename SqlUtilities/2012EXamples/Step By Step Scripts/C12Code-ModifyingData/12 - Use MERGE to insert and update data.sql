USE AdventureWorks2012;
MERGE dbo.Department destination
USING HumanResources.Department source
ON destination.Name = source.Name
WHEN MATCHED THEN
UPDATE
SET destination.Name = source.Name,
destination.GroupName = source.GroupName,
destination.ModifiedDate = source.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
INSERT (Name, GroupName, ModifiedDate)
VALUES (source.Name, source.GroupName, source.ModifiedDate);