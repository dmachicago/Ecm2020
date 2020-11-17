CREATE FUNCTION tableVarTrackItemsModified(@minId int)
RETURNS @trackingItems TABLE (
   Id       int      NOT NULL,
   Issued   date     NOT NULL,
   Category int      NOT NULL,
   Modified datetime NULL
) 
AS
BEGIN
   INSERT INTO @trackingItems (Id, Issued, Category)
   SELECT ti.Id, ti.Issued, ti.Category 
   FROM   TrackingItem ti
   WHERE  ti.Id >= @minId; 
   
   UPDATE @trackingItems
   SET Category = Category + 1,
       Modified = GETDATE()
   WHERE Category%2 = 0;
  
   RETURN;
END;

GO

--USE:
SELECT * FROM tableVarTrackItemsModified(2);
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
