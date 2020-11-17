--- SCRIPT TO GENERATE THE CREATION SCRIPT ALL PK AND UNIQUE CONSTRAINTS.
DECLARE
       @SchemaName VARCHAR (100) ,
       @TableName VARCHAR (256) ,
       @IndexName VARCHAR (256) ,
       @ColumnName VARCHAR (100),
       @is_unique_constraint VARCHAR (100) ,
       @IndexTypeDesc VARCHAR (100) ,
       @FileGroupName VARCHAR (100) ,
       @is_disabled VARCHAR (100) ,
       @IndexOptions VARCHAR (MAX) ,
       @IsDescendingKey INT,
       @IsIncludedColumn INT,
       @TSQLScripCreationIndex VARCHAR (MAX) ,
       @TSQLScripDisableIndex VARCHAR (MAX) ,
       @is_primary_key VARCHAR (100) ;

DECLARE CursorIndex CURSOR
    FOR
        SELECT
               schema_name (t.schema_id) AS schema_name
             , t.name
             , ix.name
             ,CASE
                  WHEN
               ix.is_unique_constraint = 1
                      THEN ' UNIQUE '
                  ELSE ''
              END
             , CASE
                   WHEN
               ix.is_primary_key = 1
                       THEN ' PRIMARY KEY '
                   ELSE ''
               END
             , ix.type_desc
             ,CASE
                  WHEN ix.is_padded = 1
                      THEN 'PAD_INDEX = ON, '
                  ELSE 'PAD_INDEX = OFF, '
              END + CASE
                        WHEN
               ix.allow_page_locks = 1
                            THEN 'ALLOW_PAGE_LOCKS = ON, '
                        ELSE 'ALLOW_PAGE_LOCKS = OFF, '
                    END + CASE
                              WHEN
               ix.allow_row_locks = 1
                                  THEN  'ALLOW_ROW_LOCKS = ON, '
                              ELSE 'ALLOW_ROW_LOCKS = OFF, '
                          END + CASE
                                    WHEN
               INDEXPROPERTY (t.object_id , ix.name , 'IsStatistics') = 1
                                        THEN 'STATISTICS_NORECOMPUTE = ON, '
                                    ELSE 'STATISTICS_NORECOMPUTE = OFF, '
                                END + CASE
                                          WHEN
               ix.ignore_dup_key = 1
                                              THEN 'IGNORE_DUP_KEY = ON, '
                                          ELSE 'IGNORE_DUP_KEY = OFF, '
                                      END + 'SORT_IN_TEMPDB = OFF, FILLFACTOR =' + CAST (ix.fill_factor AS VARCHAR (3)) AS IndexOptions
             , FILEGROUP_NAME (ix.data_space_id) AS FileGroupName
        FROM sys.tables AS t
             INNER JOIN sys.indexes AS ix
             ON
               t.object_id = ix.object_id
        WHERE
              ix.type > 0 AND
              (
              ix.is_primary_key = 1 OR
               ix.is_unique_constraint = 1) --and schema_name(tb.schema_id)= @SchemaName and tb.name=@TableName
              AND
               t.is_ms_shipped = 0 AND
               t.name <> 'sysdiagrams'
        ORDER BY
                 schema_name (t.schema_id) , t.name , ix.name;
OPEN CursorIndex;
FETCH NEXT FROM CursorIndex INTO  @SchemaName , @TableName , @IndexName , @is_unique_constraint , @is_primary_key , @IndexTypeDesc , @IndexOptions , @FileGroupName;
WHILE
       @@fetch_status = 0
    BEGIN
        DECLARE
               @IndexColumns VARCHAR (MAX) ;
        DECLARE
               @IncludedColumns VARCHAR (MAX) ;
        SET @IndexColumns = '';
        SET @IncludedColumns = '';
        DECLARE CursorIndexColumn CURSOR
            FOR
                SELECT
                       col.name
                     , ixc.is_descending_key
                     , ixc.is_included_column
                FROM sys.tables AS tb
                     INNER JOIN sys.indexes AS ix
                     ON
                       tb.object_id = ix.object_id
                     INNER JOIN sys.index_columns AS ixc
                     ON
                       ix.object_id = ixc.object_id AND
                       ix.index_id = ixc.index_id
                     INNER JOIN sys.columns AS col
                     ON
                       ixc.object_id = col.object_id AND
                       ixc.column_id = col.column_id
                WHERE
                      ix.type > 0 AND
                      (
                      ix.is_primary_key = 1 OR
                       ix.is_unique_constraint = 1) AND
                       schema_name (tb.schema_id) = @SchemaName AND
                       tb.name = @TableName AND
                       ix.name = @IndexName
                ORDER BY
                         ixc.index_column_id;
        OPEN CursorIndexColumn;
        FETCH NEXT FROM CursorIndexColumn INTO  @ColumnName , @IsDescendingKey , @IsIncludedColumn;
        WHILE
               @@fetch_status = 0
            BEGIN
                IF
                       @IsIncludedColumn = 0
                    BEGIN
                        SET @IndexColumns = @IndexColumns + @ColumnName + CASE
                                                                              WHEN
                               @IsDescendingKey = 1
                                                                                  THEN ' DESC, '
                                                                              ELSE  ' ASC, '
                                                                          END;
                    END
                ELSE
                    BEGIN
                        SET @IncludedColumns = @IncludedColumns + @ColumnName + ', ';
                    END;

                FETCH NEXT FROM CursorIndexColumn INTO @ColumnName , @IsDescendingKey , @IsIncludedColumn;
            END;
        CLOSE CursorIndexColumn;
        DEALLOCATE CursorIndexColumn;
        SET @IndexColumns = substring (@IndexColumns , 1 , len (@IndexColumns) - 1) ;
        SET @IncludedColumns = CASE
                                   WHEN
               len (@IncludedColumns) > 0
                                       THEN substring (@IncludedColumns , 1 , len (@IncludedColumns) - 1) 
                                   ELSE ''
                               END;
        --  print @IndexColumns
        --  print @IncludedColumns

        SET @TSQLScripCreationIndex = '';
        SET @TSQLScripDisableIndex = '';
        SET  @TSQLScripCreationIndex = 'ALTER TABLE ' + QUOTENAME (@SchemaName) + '.' + QUOTENAME (@TableName) + ' ADD CONSTRAINT ' + QUOTENAME (@IndexName) + @is_unique_constraint + @is_primary_key + +@IndexTypeDesc + '(' + @IndexColumns + ') ' + CASE
                                                                                                                                                                                                                                                            WHEN
               len (@IncludedColumns) > 0
                                                                                                                                                                                                                                                                THEN CHAR (13) + 'INCLUDE (' + @IncludedColumns + ')'
                                                                                                                                                                                                                                                            ELSE ''
                                                                                                                                                                                                                                                        END + CHAR (13) + 'WITH (' + @IndexOptions + ') ON ' + QUOTENAME (@FileGroupName) + ';';

        PRINT @TSQLScripCreationIndex;
        PRINT @TSQLScripDisableIndex;

        FETCH NEXT FROM CursorIndex INTO  @SchemaName , @TableName , @IndexName , @is_unique_constraint , @is_primary_key , @IndexTypeDesc , @IndexOptions , @FileGroupName;

    END;
CLOSE CursorIndex;
DEALLOCATE CursorIndex;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

