DECLARE @temp_table TABLE
(DBNAME           VARCHAR(MAX), 
 TABLE_Name       VARCHAR(MAX), 
 table_schema     VARCHAR(MAX), 
 row_count        INT, 
 TABLE_Size_in_kb NUMERIC(10, 2)
);
INSERT INTO @temp_table
EXECUTE master.sys.sp_MSforeachdb 
        'USE [?]; SELECT 
    ''?'',
    t.NAME AS TableName,
    s.Name AS SchemaName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB 
    from
      sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE ''dt%'' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows';
SELECT *
FROM @temp_table
WHERE DBNAME NOT IN('master', 'model', 'msdb', 'tempdb')
ORDER BY 1, 
         2, 
         3;