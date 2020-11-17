
IF EXISTS
(
    SELECT *
    FROM sys.key_constraints sc
         INNER JOIN sys.indexes si ON sc.unique_index_id = si.index_id
                                      AND si.object_id = OBJECT_ID('DAtaSOurce')
         INNER JOIN
    (
        SELECT *, 
               COUNT(*) OVER(PARTITION BY index_id, 
                                          object_id) AS ColCount
        FROM sys.index_columns
    ) ic ON ic.index_id = si.index_id
            AND ic.object_id = si.object_id
         INNER JOIN sys.columns c ON c.column_id = ic.column_id
                                     AND c.object_id = ic.object_id
                                     AND c.is_rowguidcol = 1
                                     AND c.is_nullable = 0
    WHERE is_unique_constraint = 1
          OR (is_primary_key = 1
              AND ColCount = 1)
)
    BEGIN
        PRINT 'Specified table can have FILESTREAM columns; it is having ';
END;
    ELSE
    BEGIN
        PRINT 'You should modify the table to have UNIQUEIDENTIFIER column, currently it is not ready to have FILESTREAM columns';
END;