--- SCRIPT TO GENERATE THE CREATION SCRIPT OF ALL FOREIGN KEY CONSTRAINTS
DECLARE
       @ForeignKeyID INT
     , @ForeignKeyName VARCHAR (4000) 
     , @ParentTableName VARCHAR (4000) 
     , @ParentColumn VARCHAR (4000) 
     , @ReferencedTable VARCHAR (4000) 
     , @ReferencedColumn VARCHAR (4000) 
     , @StrParentColumn VARCHAR (MAX) 
     , @StrReferencedColumn VARCHAR (MAX) 
     , @ParentTableSchema VARCHAR (4000) 
     , @ReferencedTableSchema VARCHAR (4000) 
     , @TSQLCreationFK VARCHAR (MAX) ;

DECLARE CursorFK CURSOR
    FOR SELECT
               object_id--, name, object_name( parent_object_id) 
        FROM sys.foreign_keys;
OPEN CursorFK;
FETCH NEXT FROM CursorFK INTO @ForeignKeyID;
WHILE
       @@FETCH_STATUS = 0
    BEGIN
        SET @StrParentColumn = '';
        SET @StrReferencedColumn = '';
        DECLARE CursorFKDetails CURSOR
            FOR
                SELECT
                       fk.name AS ForeignKeyName
                     , schema_name (t1.schema_id) AS ParentTableSchema
                     , object_name (fkc.parent_object_id) AS ParentTable
                     , c1.name AS ParentColumn
                     , schema_name (t2.schema_id) AS ReferencedTableSchema
                     , object_name (fkc.referenced_object_id) AS ReferencedTable
                     , c2.name AS ReferencedColumn
                FROM --sys.tables t inner join 
                sys.foreign_keys AS fk
                     INNER JOIN sys.foreign_key_columns AS fkc
                     ON
                       fk.object_id = fkc.constraint_object_id
                     INNER JOIN sys.columns AS c1
                     ON
                       c1.object_id = fkc.parent_object_id AND
                       c1.column_id = fkc.parent_column_id
                     INNER JOIN sys.columns AS c2
                     ON
                       c2.object_id = fkc.referenced_object_id AND
                       c2.column_id = fkc.referenced_column_id
                     INNER JOIN sys.tables AS t1
                     ON
                       t1.object_id = fkc.parent_object_id
                     INNER JOIN sys.tables AS t2
                     ON
                       t2.object_id = fkc.referenced_object_id
                WHERE
                       fk.object_id = @ForeignKeyID;
        OPEN CursorFKDetails;
        FETCH NEXT FROM CursorFKDetails INTO  @ForeignKeyName , @ParentTableSchema , @ParentTableName , @ParentColumn , @ReferencedTableSchema , @ReferencedTable , @ReferencedColumn;
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @StrParentColumn = @StrParentColumn + ', ' + quotename (@ParentColumn) ;
                SET @StrReferencedColumn = @StrReferencedColumn + ', ' + quotename (@ReferencedColumn) ;

                FETCH NEXT FROM CursorFKDetails INTO  @ForeignKeyName , @ParentTableSchema , @ParentTableName , @ParentColumn , @ReferencedTableSchema , @ReferencedTable , @ReferencedColumn;
            END;
        CLOSE CursorFKDetails;
        DEALLOCATE CursorFKDetails;

        SET @StrParentColumn = substring (@StrParentColumn , 2 , len (@StrParentColumn) - 1) ;
        SET @StrReferencedColumn = substring (@StrReferencedColumn , 2 , len (@StrReferencedColumn) - 1) ;
        SET @TSQLCreationFK = 'ALTER TABLE ' + quotename (@ParentTableSchema) + '.' + quotename (@ParentTableName) + ' WITH CHECK ADD CONSTRAINT ' + quotename (@ForeignKeyName) + ' FOREIGN KEY(' + ltrim (@StrParentColumn) + ') ' + char (13) + 'REFERENCES ' + quotename (@ReferencedTableSchema) + '.' + quotename (@ReferencedTable) + ' (' + ltrim (@StrReferencedColumn) + ') ' + char (13) + 'GO';

        PRINT @TSQLCreationFK;

        FETCH NEXT FROM CursorFK INTO @ForeignKeyID;
    END;
CLOSE CursorFK;
DEALLOCATE CursorFK;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
