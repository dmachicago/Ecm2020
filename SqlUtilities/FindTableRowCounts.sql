SELECT  SchemaName = schemas.[name],
        TableName = tables.[name],
        IndexName = indexes.[name],
        IndexType =
            CASE indexes.type
                WHEN 0 THEN 'Heap'
                WHEN 1 THEN 'Clustered'
            END,
        IndexPartitionCount = partition_info.PartitionCount,
        IndexTotalRows = partition_info.TotalRows
FROM    sys.tables
        JOIN sys.indexes
            ON  tables.object_id = indexes.object_id
                AND indexes.type IN ( 0, 1 )
        JOIN (  SELECT object_id, index_id, PartitionCount = COUNT(*), TotalRows = SUM(rows)
                FROM sys.partitions
                GROUP BY object_id, index_id
        ) partition_info
            ON  indexes.object_id = partition_info.object_id
                AND indexes.index_id = partition_info.index_id
        JOIN sys.schemas ON tables.schema_id = schemas.schema_id
ORDER BY IndexTotalRows, SchemaName, TableName ;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
