-- W. Dale Miller @ 2016
--Although SQL Server automatically maintains indexes after any INSERT, UPDATE, DELETE, or MERGE operation, some index maintenance activities on your databases may still be required, mostly due to index fragmentation. Fragmentation happens when the logical order of pages in an index does not match the physical order in the data file. Because fragmentation can affect the performance of some queries, you need to monitor the fragmentation level of your indexes and, if required, perform re-organize or rebuild operations on them.
--It is also worth clarifying that fragmentation may affect only queries performing scans or range scans; queries performing index seeks may not be affected at all. The query optimizer does not consider fragmentation either, so the plans it produces will be the same whether you have high fragmentation or no fragmentation at all. That is, the query optimizer does not consider whether the pages in an index are in physical order or not. However, one of the inputs for the query optimizer is the number of pages used by a table or index, and this number of pages may increase when there is a lot of unused space.

-- Use the sys.dm_db_index_physical_stats DMF to analyze the fragmentation 
-- level of your indexes, where you can query this information for a specific 
-- partition or index, or look at all the indexes on a table, database, or 
-- even the entire SQL Server instance. The following example will return 
-- fragmentation information for the <schema>.<table> of the <database>:

select a.index_id, name, avg_fragmentation_in_percent, fragment_count, avg_fragment_size_in_pages
from sys.dm_db_index_physical_stats (DB_ID('AdventureWorks2012'), object_id('Sales.SalesOrderDetail'), NULL, NULL, NULL) as a
join sys.indexes as b on a.object_id = b.object_id and a.index_id = b.index_id


--In case you need to reorganize the index, which is not the case here, 
--you can use a command like this:
ALTER INDEX ALL ON Sales.SalesOrderDetail REORGANIZE


SELECT dbschemas.[name] as 'Schema',
dbtables.[name] as 'Table',
dbindexes.[name] as 'Index',
indexstats.avg_fragmentation_in_percent,
indexstats.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
INNER JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
INNER JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.database_id = DB_ID()
ORDER BY indexstats.avg_fragmentation_in_percent desc