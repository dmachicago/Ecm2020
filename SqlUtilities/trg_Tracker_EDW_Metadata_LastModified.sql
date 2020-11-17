CREATE TRIGGER trg_Tracker_EDW_Metadata_LastModified
ON dbo.Tracker_EDW_Metadata
AFTER UPDATE
AS
    UPDATE dbo.Tracker_EDW_Metadata
    SET LastModifiedDate = GETDATE()
    WHERE ID IN (SELECT DISTINCT ID FROM Inserted)


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
