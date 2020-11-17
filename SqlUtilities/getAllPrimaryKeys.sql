DROP TABLE #PrimaryKeyDetail ;

   SELECT  KU.CONSTRAINT_NAME, KU.TABLE_NAME, KU.COLUMN_NAME, KU.ORDINAL_POSITION
    into #PrimaryKeyDetail
--SELECT * 
    FROM KenticoCMS_PRD_1.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC 
    INNER JOIN 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU 
    ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY' AND 
    TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME 
    --and ku.table_name=''' + @TblName + '''     
    ORDER BY KU.TABLE_NAME, KU.ORDINAL_POSITION ASC; 

select * from #PrimaryKeyDetail ORDER BY TABLE_NAME , ORDINAL_POSITION


 SELECT 
 'CREATE '+
     CASE WHEN sys.indexes.is_unique = 1 AND sys.indexes.is_primary_key = 0 THEN 'UNIQUE ' ELSE '' END +
     CASE WHEN sys.indexes.type_desc = 'CLUSTERED' THEN 'CLUSTERED ' ELSE 'NONCLUSTERED ' END
 +'INDEX '
 + sys.indexes.name
 + ' ON ' 
 + sys.objects.name
 + ' ( ' + Index_Columns.index_columns_key +' ) '
 + ISNULL('INCLUDE ('+Index_Columns.index_columns_include+')','')
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
     sys.objects.type='u'
     AND sys.objects.is_ms_shipped=0
     AND sys.indexes.type_desc <> 'HEAP'
     AND sys.indexes.is_primary_key = 0
and sys.objects.name = 'CMS_User'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
