
declare @TableName nvarchar(100) = 'DataSource' ;
SELECT 'If Not Exist(select 1 from sys.indexes where name = ''' +i.name+ ''') ' +char(10) + 'CREATE ' + CASE
                       WHEN i.is_unique = 1
                       THEN 'UNIQUE '
                       ELSE ''
                   END + (i.type_desc COLLATE SQL_Latin1_General_CP1_CI_AS) + ' INDEX ' + QUOTENAME(i.[name]) + ' ON ' + QUOTENAME(SCHEMA_NAME(t.schema_id)) + '.' + QUOTENAME(t.[name]) + 
				   REPLACE(REPLACE(REPLACE(
(
    SELECT QUOTENAME(COL_NAME(object_id, column_id)) + CASE
                                                           WHEN c.[is_descending_key] = 1
                                                           THEN ' DESC'
                                                           ELSE ' ASC'
                                                       END 
    FROM [sys].[index_columns] c
    WHERE c.[object_id] = i.[object_id]
          AND c.[index_id] = i.[index_id]
          AND c.[is_included_column] = 0
    ORDER BY c.[index_column_id] FOR XML PATH('')
), '', ', '), '', ')'), '', '(') + COALESCE(' INCLUDE ' + REPLACE(REPLACE(REPLACE(
(
    SELECT QUOTENAME(COL_NAME(object_id, column_id)) + CASE
                                                           WHEN c.[is_descending_key] = 1
                                                           THEN ' DESC'
                                                           ELSE ' ASC'
                                                       END x
    FROM [sys].[index_columns] c
    WHERE c.[object_id] = i.[object_id]
          AND c.[index_id] = i.[index_id]
          AND c.[is_included_column] = 1
    ORDER BY c.[index_column_id] FOR XML PATH('')
), '', ', '), '', ')'), '', '('), '') + ' WITH (' + CASE
                                                        WHEN i.is_padded = 1
                                                        THEN 'PAD_INDEX = ON, '
                                                        ELSE 'PAD_INDEX = OFF, '
                                                    END + CASE
                                                              WHEN i.[allow_page_locks] = 1
                                                              THEN 'ALLOW_PAGE_LOCKS = ON, '
                                                              ELSE 'ALLOW_PAGE_LOCKS = OFF, '
                                                          END + CASE
                                                                    WHEN i.[allow_row_locks] = 1
                                                                    THEN 'ALLOW_ROW_LOCKS = ON,  '
                                                                    ELSE 'ALLOW_ROW_LOCKS = OFF,  '
                                                                END + CASE
                                                                          WHEN INDEXPROPERTY(t.object_id, i.[name], 'IsStatistics') = 1
                                                                          THEN 'STATISTICS_NORECOMPUTE = ON, '
                                                                          ELSE 'STATISTICS_NORECOMPUTE = OFF, '
                                                                      END + CASE
                                                                                WHEN i.[ignore_dup_key] = 1
                                                                                THEN 'IGNORE_DUP_KEY = ON, '
                                                                                ELSE 'IGNORE_DUP_KEY = OFF, '
                                                                            END + 'SORT_IN_TEMPDB = OFF, FILLFACTOR =' + CAST(i.fill_factor AS VARCHAR(3)) + ') ON ' + QUOTENAME(FILEGROUP_NAME(i.data_space_id)) + ';', 
       SCHEMA_NAME(t.schema_id) [schema_name], 
       t.[name] as TableName , 
       i.[name] as IndexName,
       CASE
           WHEN i.is_unique = 1
           THEN 'UNIQUE '
           ELSE ''
       END, 
       i.type_desc,
       CASE
           WHEN i.is_padded = 1
           THEN 'PAD_INDEX = ON, '
           ELSE 'PAD_INDEX = OFF, '
       END + CASE
                 WHEN i.[allow_page_locks] = 1
                 THEN 'ALLOW_PAGE_LOCKS = ON, '
                 ELSE 'ALLOW_PAGE_LOCKS = OFF, '
             END + CASE
                       WHEN i.[allow_row_locks] = 1
                       THEN 'ALLOW_ROW_LOCKS = ON,  '
                       ELSE 'ALLOW_ROW_LOCKS = OFF,  '
                   END + CASE
                             WHEN INDEXPROPERTY(t.object_id, i.[name], 'IsStatistics') = 1
                             THEN 'STATISTICS_NORECOMPUTE = ON, '
                             ELSE 'STATISTICS_NORECOMPUTE = OFF, '
                         END + CASE
                                   WHEN i.[ignore_dup_key] = 1
                                   THEN 'IGNORE_DUP_KEY = ON, '
                                   ELSE 'IGNORE_DUP_KEY = OFF, '
                               END + 'SORT_IN_TEMPDB = OFF, FILLFACTOR =' + CAST(i.fill_factor AS VARCHAR(3)) AS IndexOptions, 
       i.is_disabled, 
       FILEGROUP_NAME(i.data_space_id) FileGroupName
FROM [sys].[tables] t
     JOIN [sys].[indexes] i ON t.object_id = i.object_id
WHERE i.[type] > 0
      AND i.is_primary_key = 0
      AND i.is_unique_constraint = 0 --AND schema_name(t.schema_id)= @SchemaName AND t.is_ms_shipped=0 AND t.name<>'sysdiagrams'
	  AND t.name=@TableName 
ORDER BY SCHEMA_NAME(t.schema_id), 
         t.[name], 
         i.[name];