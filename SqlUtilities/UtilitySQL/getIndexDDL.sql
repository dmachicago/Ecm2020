
 SELECT 
'CREATE '+
    CASE WHEN sys.indexes.is_unique = 1 AND sys.indexes.is_primary_key = 0 THEN 'UNIQUE ' ELSE '' END +
    CASE WHEN sys.indexes.type_desc = 'CLUSTERED' THEN 'CLUSTERED ' ELSE 'NONCLUSTERED ' END
+'INDEX '
+ sys.indexes.name
+ ' ON ' 
+ sys.objects.name
+ ' ( ' + Index_Columns.index_columns_key +' ) '
+ ISNULL('INCLUDE ('+Index_Columns.index_columns_include+')','') as MySQL
FROM
    sys.objects
    JOIN sys.schemas ON sys.objects.schema_id=sys.schemas.schema_id
    JOIN sys.indexes ON sys.indexes.object_id=sys.objects.object_id
    CROSS APPLY (
       SELECT
         LEFT(index_columns_key, LEN(index_columns_key)-1) AS index_columns_key,
         LEFT(index_columns_include, LEN(index_columns_include)-1) AS index_columns_include
       FROM
         (
          SELECT
              (
                 SELECT sys.columns.name + ','
                 FROM
                   sys.index_columns
                   JOIN sys.columns ON
                    sys.index_columns.column_id=sys.columns.column_id
                    AND sys.index_columns.object_id=sys.columns.object_id
                 WHERE
                   sys.index_columns.is_included_column=0
                   AND sys.indexes.object_id=sys.index_columns.object_id AND sys.indexes.index_id=sys.index_columns.index_id
                 ORDER BY key_ordinal
                 FOR XML PATH('')
              ) AS index_columns_key,
              (
                 SELECT sys.columns.name + ','
                 FROM
                   sys.index_columns
                   JOIN sys.columns ON
                    sys.index_columns.column_id=sys.columns.column_id
                    AND sys.index_columns.object_id=sys.columns.object_id
                 WHERE
                   sys.index_columns.is_included_column=1
                   AND sys.indexes.object_id=sys.index_columns.object_id AND sys.indexes.index_id=sys.index_columns.index_id
                 ORDER BY index_column_id
                 FOR XML PATH('')
              ) AS index_columns_include
         ) AS Index_Columns
    ) AS Index_Columns
WHERE
    --sys.objects.type='u'
    --AND sys.objects.is_ms_shipped=0
    --AND sys.indexes.type_desc <> 'HEAP'
    --AND sys.indexes.is_primary_key = 0
	sys.indexes.name like '%IX_View_CMS_Tree_Joined_Regular_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture%'