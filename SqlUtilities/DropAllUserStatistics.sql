--DropAllUserStatistics

print('Generating drop all USER statistics statements') ;
GO

SELECT 'DROP STATISTICS ' + Schema_NAME(d.Schema_id) + '.' + 
OBJECT_NAME(a.object_id) + '.' + 
a.name colum_name
FROM sys.stats a
INNER JOIN sys.Objects d ON d.Object_id = a.object_id
WHERE auto_created = 0 AND User_Created = 1

--Recreate single-column statistics on all eligible columns in the current database.
--EXEC sp_createstats;

--create single-column statistics on all eligible columns that are already in an index and are not the first column in the index.
--EXEC sp_createstats 'indexonly';
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
