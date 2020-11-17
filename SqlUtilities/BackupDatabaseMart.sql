
exec sp_who2
dbcc inputbuffer (74)


USE [KenticoCMS_Datamart_X];
GO
DBCC SHRINKDATABASE (N'KenticoCMS_Datamart_X') ;
GO

USE [KenticoCMS_Datamart_X];
GO
DBCC SHRINKFILE (N'KenticoCMS_Datamart_X' , 100000) ;
GO

BACKUP DATABASE KenticoCMS_Datamart_X 
    TO  DISK = N'Z:\Backups\KenticoCMS_Datamart_X.bak' 
    WITH NOFORMAT, 
    INIT, NAME = N'KenticoCMS_Datamart_X-Full Database Backup', 
    SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 10;
GO


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
