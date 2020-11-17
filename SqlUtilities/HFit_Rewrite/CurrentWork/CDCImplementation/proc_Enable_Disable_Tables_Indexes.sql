
--ALTER INDEX IHash_view_EDW_Eligibility ON dbo.BASE_view_EDW_Eligibility DISABLE;
--DISABLE TRIGGER TRIG_DEL_BASE_view_EDW_Eligibility ON BASE_view_EDW_Eligibility;

--ALTER INDEX IHash_view_EDW_Eligibility ON dbo.BASE_view_EDW_Eligibility REBUILD;
--ENABLE TRIGGER TRIG_DEL_BASE_view_EDW_Eligibility ON BASE_view_EDW_Eligibility;
--GO

GO
PRINT 'Executing proc_Enable_Disable_Tables_Indexes.sql';
GO
PRINT 'CREATING Disable_TableINDEXES.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'Disable_TableINDEXES') 
    BEGIN
        DROP PROCEDURE
             Disable_TableINDEXES
    END;
GO
-- exec Disable_TableINDEXES 'BASE_view_EDW_Eligibility', 1
CREATE PROCEDURE dbo.Disable_TableINDEXES (
       @TblName AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0) 
--@Type INT
AS
BEGIN
    DECLARE
           @Schema_TableName NVARCHAR (MAX) 
         , @IndexName NVARCHAR (MAX) 
         , @MySql VARCHAR (MAX) ;

    SELECT DISTINCT
           OBJECT_SCHEMA_NAME (T.object_id , DB_ID ()) AS [Schema]
         , T.name AS table_name
         , I.name AS index_name
    INTO
         #TempTableIndex
    FROM sys.tables AS T
         INNER JOIN sys.indexes AS I
         ON
           T.object_id = I.object_id
         INNER JOIN sys.index_columns AS IC
         ON
           I.object_id = IC.object_id
         INNER JOIN sys.all_columns AS AC
         ON
           T.object_id = AC.object_id AND
           IC.column_id = AC.column_id
    WHERE
           T.is_ms_shipped = 0 AND
           I.type_desc <> 'HEAP' AND
           OBJECT_SCHEMA_NAME (T.object_id , DB_ID ()) = 'DBO' AND
           T.name = @TblName;

    DECLARE IndexCursor CURSOR
        FOR
            SELECT
                   [Schema] + '.' + Quotename (table_name) AS SchemaTableName
                 , Quotename (index_name) 
            FROM #TempTableIndex;

    OPEN IndexCursor;
    FETCH NEXT FROM IndexCursor INTO @Schema_TableName , @IndexName;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = 'ALTER INDEX ' + @IndexName + ' ON ' + @Schema_TableName + ' DISABLE;';
            IF @PreviewOnly = 1
                BEGIN
                    PRINT @MySql;
                END
            ELSE
                BEGIN
                    EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;
            FETCH NEXT FROM IndexCursor INTO @Schema_TableName , @IndexName;
        END;

    CLOSE IndexCursor;
    DEALLOCATE IndexCursor;
END;
GO
PRINT 'CREATING Enable_TableINDEXES.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'Enable_TableINDEXES') 
    BEGIN
        DROP PROCEDURE
             Enable_TableINDEXES
    END;
GO
-- exec Enable_TableINDEXES 'FACT_TrackerData', 1
CREATE PROCEDURE dbo.Enable_TableINDEXES (
       @TblName AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0) 
--@Type INT
AS
BEGIN
    DECLARE
           @Schema_TableName NVARCHAR (MAX) 
         , @IndexName NVARCHAR (MAX) 
         , @MySql VARCHAR (MAX) ;

    SELECT DISTINCT
           OBJECT_SCHEMA_NAME (T.object_id , DB_ID ()) AS [Schema]
         ,T.name AS table_name
         , I.name AS index_name
    INTO
         #TempTableIndex
    FROM sys.tables AS T
         INNER JOIN sys.indexes AS I
         ON
           T.object_id = I.object_id
         INNER JOIN sys.index_columns AS IC
         ON
           I.object_id = IC.object_id
         INNER JOIN sys.all_columns AS AC
         ON
           T.object_id = AC.object_id AND
           IC.column_id = AC.column_id
    WHERE
           T.is_ms_shipped = 0 AND
           I.type_desc <> 'HEAP' AND
           OBJECT_SCHEMA_NAME (T.object_id , DB_ID ()) = 'DBO' AND
           T.name = @TblName;

    DECLARE IndexCursor CURSOR
        FOR

            SELECT
                   [Schema] + '.' + Quotename (table_name) AS SchemaTableName
                 , Quotename (index_name) 
            FROM #TempTableIndex;

    OPEN IndexCursor;
    FETCH NEXT FROM IndexCursor INTO @Schema_TableName , @IndexName;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = 'ALTER INDEX ' + @IndexName + ' ON ' + @Schema_TableName + ' REBUILD;';
            IF @PreviewOnly = 1
                BEGIN
                    PRINT @MySql;
                END
            ELSE
                BEGIN
                    EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;
            FETCH NEXT FROM IndexCursor INTO @Schema_TableName , @IndexName;
        END;

    CLOSE IndexCursor;
    DEALLOCATE IndexCursor;
END;

GO
PRINT 'Executed proc_Enable_Disable_Tables_Indexes.sql';
GO
