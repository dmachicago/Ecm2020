USE KenticoCMS_Prod1;
 
GO

DBCC SQLPERF( logspace );

go
checkpoint;
go

SELECT file_id, name 
FROM sys.database_files; 
GO 

--*************************************************************************
Alter database KenticoCMS_Prod1
 
SET RECOVERY SIMPLE;
 
Go
 
--DBCC SHRINKFILE (KenticoCMS_PRD_log);
DBCC SHRINKFILE (2, TRUNCATEONLY);
 
GO
 
Alter database KenticoCMS_Prod1
 
SET RECOVERY FULL;
 
Go
--*************************************************************************
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
