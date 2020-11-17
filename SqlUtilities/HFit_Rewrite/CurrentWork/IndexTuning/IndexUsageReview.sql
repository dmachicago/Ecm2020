USE KenticoCMS_ProdStaging
SELECT
	DB_NAME(ius.database_id) DBName,
	OBJECT_NAME(ius.object_id) ObjName,
	i.name,
	ius.user_seeks,
	ius.user_scans,
	ius.user_lookups,
	ius.user_updates
	FROM sys.dm_db_index_usage_stats ius
	INNER JOIN sys.indexes i
	ON ius.object_id = i.object_id AND
	ius.index_id = i.index_id
WHERE
DB_NAME(ius.database_id) = 'KenticoCMS_ProdStaging'

/*Query to analyze goes here*/
USE KenticoCMS_ProdStaging;
SELECT *
FROM view_EDW_HealthAssesment
WHERE ItemModifiedWhen between '2014-08-20 00:00:00.000'  and '2014-08-21 00:00:00.000'

SELECT
	DB_NAME(ius.database_id) DBName,
	OBJECT_NAME(ius.object_id) ObjName,
	i.name,
	ius.user_seeks,
	ius.user_scans,
	ius.user_lookups,
	ius.user_updates
	FROM sys.dm_db_index_usage_stats ius
	INNER JOIN sys.indexes i
	ON ius.object_id = i.object_id AND
	ius.index_id = i.index_id
WHERE
DB_NAME(ius.database_id) = 'KenticoCMS_ProdStaging'  --  
  --  
GO 
print('***** FROM: IndexUsageReview.sql'); 
GO 
