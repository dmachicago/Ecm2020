

SELECT
name AS FileName,
size*1.0/128 AS FileSizeinMB,
CASE max_size
WHEN 0 THEN 'Autogrowth is off.'
WHEN -1 THEN 'Autogrowth is on.'
ELSE 'Log file will grow to a maximum size of 2 TB.'
END AutogrowthStatus,
growth AS 'GrowthValue',
'GrowthIncrement' =
CASE
WHEN growth = 0 THEN 'Size is fixed and will not grow.'
WHEN growth > 0
AND is_percent_growth = 0
THEN 'Growth value is in 8-KB pages.'
ELSE 'Growth value is a percentage.'
END
FROM tempdb.sys.database_files;
GO
--******************************************************************************
print '****************************************************************************** ' 
print 'STARTING SHRINK' ;
print getdate() ;
CHECKPOINT;
DBCC DROPCLEANBUFFERS;
print 'DROPCLEANBUFFERS' ;
GO
DBCC FREEPROCCACHE;
print 'FREEPROCCACHE' ;
GO
DBCC FREESYSTEMCACHE ('ALL');
print 'FREESYSTEMCACHE' ;
GO
DBCC FREESESSIONCACHE;
print 'FREESESSIONCACHE' ;
GO
DBCC SHRINKFILE (TEMPDEV, 20480);   --- New file size in MB
print 'SHRINKFILE COMPLETE' ;
print getdate() ;
print '****************************************************************************** ' 
GO

--******************************************************************************
SELECT
name AS FileName,
size*1.0/128 AS FileSizeinMB,
CASE max_size
WHEN 0 THEN 'Autogrowth is off.'
WHEN -1 THEN 'Autogrowth is on.'
ELSE 'Log file will grow to a maximum size of 2 TB.'
END AutogrowthStatus,
growth AS 'GrowthValue',
'GrowthIncrement' =
CASE
WHEN growth = 0 THEN 'Size is fixed and will not grow.'
WHEN growth > 0
AND is_percent_growth = 0
THEN 'Growth value is in 8-KB pages.'
ELSE 'Growth value is a percentage.'
END
FROM tempdb.sys.database_files;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
