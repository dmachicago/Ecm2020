--Possible bad Indexes (writes > reads)
SELECT
	OBJECT_NAME(s.object_id) AS 'TblName'
  , i.name                   AS 'IdxName'
  , i.index_id
  , user_updates                                              AS 'TotWrites'
  , user_seeks   + user_scans + user_lookups                  AS 'TotReads'
  , user_updates - ( user_seeks + user_scans + user_lookups ) AS 'Difference'
FROM
	sys.dm_db_index_usage_stats AS s WITH ( NOLOCK )
	INNER JOIN
		sys.indexes AS i WITH ( NOLOCK )
		ON
			s.object_id    = i.object_id
			AND i.index_id = s.index_id
WHERE
	OBJECTPROPERTY(s.object_id, 'IsUserTable') = 1
	AND s.database_id                          = DB_ID()
	AND user_updates                           > ( user_seeks + user_scans + user_lookups )
	AND i.index_id                             > 1
ORDER BY
	'Difference' DESC
  , 'TotWrites' DESC
  , 'TotReads' ASC
;

-- Index Read/Write stats for a single table
SELECT
	OBJECT_NAME(s.object_id) AS 'TableName'
  , i.name                   AS 'IndexName'
  , i.index_id
  , SUM(user_seeks)                             AS 'UserSeeks'
  , SUM(user_scans)                             AS 'UserScans'
  , SUM(user_lookups)                           AS 'UserLookups'
  , SUM(user_seeks + user_scans + user_lookups) AS 'TotReads'
  , SUM(user_updates)                           AS 'TotWrites'
FROM
	sys.dm_db_index_usage_stats AS s
	INNER JOIN
		sys.indexes AS i
		ON
			s.object_id    = i.object_id
			AND i.index_id = s.index_id
WHERE
	OBJECTPROPERTY(s.object_id, 'IsUserTable') = 1
	AND s.database_id                          = DB_ID()
	AND OBJECT_NAME(s.object_id)               = 'AccountTransaction'
GROUP BY
	OBJECT_NAME(s.object_id)
  , i.name
  , i.index_id
ORDER BY
	'TotWrites' DESC
  , 'TotReads' DESC
;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
