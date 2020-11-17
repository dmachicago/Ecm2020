USE MASTER 
GO

ALTER DATABASE K3 
SET multi_user WITH ROLLBACK IMMEDIATE
GO

-- Now put it into single_user mode and drop it. Use Rollback Immediate to disconnect any sessions and rollback their transactions. Safe since you are about to drop the DB.
ALTER DATABASE K3
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE K3
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
