

--CMS_ClassSite
GO
PRINT 'Executing ShowKeys.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'ShowKeys') 
    BEGIN
        DROP PROCEDURE ShowKeys;
    END;
    GO


-- exec ShowKeys BASE_CMS_ClassSite
-- exec ShowKeys BASE_CMS_User
CREATE PROCEDURE ShowKeys (@BaseTblName nvarchar (250)) 
AS
BEGIN

    -- declare @BaseTblName nvarchar(250) = 'BASE_CMS_ClassSite' ;

    SET @BaseTblName = SUBSTRING (@BaseTblName , 6 , 9999) ;
    DECLARE
          @IdxName nvarchar (250) = 'CI_DBPK_' + @BaseTblName;

    PRINT 'Keys for: ' + @BaseTblName + ' / ' + @IdxName;

    SELECT TableName = t.name , 
           IndexName = ind.name , 
           ColumnName = col.name , 
           ColumnId = ic.index_column_id , 
           IndexId = ind.index_id,
           'AND BT.' + col.name + ' = ' + 'CT.' + col.name AS Joins
    --ind.*,
    --ic.*,
    --col.* 
      FROM
           sys.indexes AS ind
           INNER JOIN sys.index_columns AS ic
           ON ind.object_id = ic.object_id
          AND ind.index_id = ic.index_id
           INNER JOIN sys.columns AS col
           ON ic.object_id = col.object_id
          AND ic.column_id = col.column_id
           INNER JOIN sys.tables AS t
           ON ind.object_id = t.object_id
      WHERE ind.is_primary_key = 0
        AND ind.is_unique = 0
        AND ind.is_unique_constraint = 0
        AND t.is_ms_shipped = 0
        AND ind.name LIKE @IdxName
      ORDER BY t.name , ind.name , ind.index_id , ic.index_column_id;


    DECLARE
          @MySql AS nvarchar (max) = '';
    DECLARE
          @cols AS nvarchar (max) = '';
    DECLARE
          @DBNAME AS nvarchar (250) = 'KenticoCMS_2';
    DECLARE
          @TCols AS nvarchar (250) = '';
    DECLARE
          @T AS TABLE (stmt nvarchar (max) NULL) ;

    DECLARE C CURSOR
        FOR SELECT COLUMN_NAME
              FROM INFORMATION_SCHEMA.columns
              WHERE table_name = 'BASE_' + @BaseTblName order by ORDINAL_POSITION;
    OPEN C;

    FETCH NEXT FROM C INTO @TCols;

    SET @cols = '';
    SELECT @cols = @cols + 'AND ' + 'BT.'+col.name + ' = CT.' + col.name + char(10) 
     FROM
           sys.indexes AS ind
           INNER JOIN sys.index_columns AS ic
           ON ind.object_id = ic.object_id
          AND ind.index_id = ic.index_id
           INNER JOIN sys.columns AS col
           ON ic.object_id = col.object_id
          AND ic.column_id = col.column_id
           INNER JOIN sys.tables AS t
           ON ind.object_id = t.object_id
      WHERE ind.is_primary_key = 0
        AND ind.is_unique = 0
        AND ind.is_unique_constraint = 0
        AND t.is_ms_shipped = 0
        AND ind.name LIKE @IdxName
      ORDER BY t.name , ind.name , ind.index_id , ic.index_column_id;	 

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = @MySql + ',' + @TCols + CHAR (10) ;
            FETCH NEXT FROM C INTO @TCols;
        END;
    SET @MySql = SUBSTRING (@MySql , 2 , 9999) ;
    SET @MySql = 'SELECT ' + CHAR (10) + @MySql;
    SET @MySql = @MySql + 'FROM ' + 'BASE_' + @BaseTblName + ' AS BT ' + char(10) ;
    SET @MySql = @MySql + 'join <TABLE> as CT on ' +char(10) + substring(@cols,5,9999) ;
    PRINT char(10) + @MySql;
    CLOSE C;
    DEALLOCATE C;

    SELECT @MySql ;

END;

	GO
PRINT 'Executed ShowKeys.sql';
GO
