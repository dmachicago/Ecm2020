ALTER DATABASE KenticoCMSCloudtst2 SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE
GO

RESTORE DATABASE KenticoCMSCloudtst2 FROM DATABASE_SNAPSHOT = 'KenticoCMSCloudtst2_ss20151104_1524';
GO

ALTER DATABASE KenticoCMSCloudtst2 SET MULTI_USER
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
