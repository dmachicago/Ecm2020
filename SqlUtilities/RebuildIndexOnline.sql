/*Rebuild index online: This operation will work only in the Enterprise or Developer Edition*/
ALTER INDEX PK_Tracker_EDW_Metadata ON [dbo].[Tracker_EDW_Metadata]
REBUILD WITH (ONLINE = ON)
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
