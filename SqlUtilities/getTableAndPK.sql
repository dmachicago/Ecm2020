DECLARE @TBLS TABLE
([schema_name] VARCHAR(250), 
 [table_name]  VARCHAR(250), 
 [pk_name]     VARCHAR(250), 
 [columns]     VARCHAR(2000),
 UNIQUE NONCLUSTERED([schema_name], [table_name])
);
INSERT INTO @TBLS
       SELECT SCHEMA_NAME(tab.schema_id) AS [schema_name], 
              tab.[name] AS table_name, 
              pk.[name] AS pk_name, 
              SUBSTRING(column_names, 1, LEN(column_names) - 1) AS [columns]
       FROM sys.tables tab
            LEFT OUTER JOIN sys.indexes pk ON tab.object_id = pk.object_id
                                              AND pk.is_primary_key = 1
            CROSS APPLY
       (
           SELECT col.[name] + ', '
           FROM sys.index_columns ic
                INNER JOIN sys.columns col ON ic.object_id = col.object_id
                                              AND ic.column_id = col.column_id
           WHERE ic.object_id = tab.object_id
                 AND ic.index_id = pk.index_id
           ORDER BY col.column_id FOR XML PATH('')
       ) D(column_names)
       ORDER BY SCHEMA_NAME(tab.schema_id), 
                tab.[name];
UPDATE @TBLS
  SET 
      [pk_name] = '@'
WHERE [pk_name] IS NULL;
SELECT *
FROM @TBLS;