SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
--     ind.is_primary_key = 0			-- when looking for performance indexes, do not include primary keys
--     AND ind.is_unique = 0			-- a unique index may or may not be included here
--     AND ind.is_unique_constraint = 0 -- a unique constraint may or may not be included here
		t.is_ms_shipped = 0 
--		and (col.name = 'ProductAssemblyID' or col.name = 'ComponentID')	-- fill in to check for a set of columns within an index
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id;