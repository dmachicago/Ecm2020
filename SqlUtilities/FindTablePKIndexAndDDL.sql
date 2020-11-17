SELECT 'DROP INDEX [' + i.name + '] ON [' + SCHEMA_NAME(schema_id) + '].[' + t.name + ']' + char(10) + 'GO' [DropUnique], 
       'ALTER TABLE ' + t.name + ' ADD CONSTRAINT PK_' + t.name + ' PRIMARY KEY (' +
(
    SELECT STUFF(
    (
        SELECT ',' + QUOTENAME([name]) + CASE
                                             WHEN is_descending_key = 0
                                             THEN ' ASC'
                                             ELSE ' DESC'
                                         END
        FROM sys.index_columns ic
             INNER JOIN sys.columns c ON ic.object_id = c.object_id
                                         AND ic.column_id = c.column_id
        WHERE ic.object_id = i.object_id
              AND ic.index_id = i.index_id FOR XML PATH('')
    ), 1, 1, ' ')
) + ')'+ char(10) + 'GO' [AddPK]
FROM sys.indexes i
     INNER JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.is_unique = 1
      AND i.is_primary_key = 0;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
