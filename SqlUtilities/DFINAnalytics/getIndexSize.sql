-- select top 10 * from sys.partitions;
-- select top 10 * from sys.allocation_units;

SELECT OBJECT_NAME(i.OBJECT_ID) AS TableName, 
  i.name AS IndexName, 
  i.index_id AS IndexID, 
  8 * SUM(a.used_pages) AS 'Indexsize(KB)', 
  a.total_pages, 
  a.used_pages, 
  a.data_pages, 
  p.[rows] AS RowCnt
FROM   sys.indexes AS i
JOIN sys.partitions AS p
    ON p.OBJECT_ID = i.OBJECT_ID
  AND p.index_id = i.index_id
JOIN sys.allocation_units AS a
    ON a.container_id = p.partition_id
--WHERE  OBJECT_NAME(i.OBJECT_ID) IN('IssuerCaption', 'IssuerCaptionStaging', 'SecurityIssuer', 'IssuerLibrary', 'Staging_DataLoadBatchOptions', 'Staging_HoldingsLoad', 'DataloadBatchOptions', 'HoldingsLoad')
GROUP BY i.OBJECT_ID, 
  i.index_id, 
  i.name, 
  a.total_pages, 
  a.used_pages, 
  a.data_pages, 
  p.[rows]
ORDER BY OBJECT_NAME(i.OBJECT_ID), 
  i.index_id;
