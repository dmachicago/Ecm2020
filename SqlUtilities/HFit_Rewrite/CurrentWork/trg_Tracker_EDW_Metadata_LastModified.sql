CREATE TRIGGER trg_Tracker_EDW_Metadata_LastModified
ON dbo.Tracker_EDW_Metadata
AFTER UPDATE
AS
    UPDATE dbo.Tracker_EDW_Metadata
    SET LastModifiedDate = GETDATE()
    WHERE ID IN (SELECT DISTINCT ID FROM Inserted)

  --  
  --  
GO 
print('***** FROM: trg_Tracker_EDW_Metadata_LastModified.sql'); 
GO 
