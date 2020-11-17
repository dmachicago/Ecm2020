USE [master]
ALTER DATABASE [KenticoCMS_DataMart] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [KenticoCMS_DataMart] FROM  DISK = N'z:\backups\KenticoCMS_DataMart.bak' WITH  FILE = 1,REPLACE,  NOUNLOAD,  STATS = 5
ALTER DATABASE [KenticoCMS_DataMart] SET MULTI_USER

GO


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
