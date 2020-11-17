

GO
PRINT 'Executing proc_BigintToInt.sql';
GO
/*
The primary key constraint 'PK_CMS_UserSettings' on table 'CMS_UserSettings' cannot be dropped because change tracking is enabled on the table. Change tracking requires a primary key constraint on the table. 
Disable change tracking before dropping the constraint.

An explicit DROP INDEX is not allowed on index 'CMS_UserSettings.PK_CMS_UserSettings'. It is being used for PRIMARY KEY constraint enforcement.
*/
IF NOT EXISTS (SELECT
                      NAME
                      FROM SYS.PROCEDURES
                      WHERE NAME = 'usp_GetErrorInfo') 
    BEGIN
        DECLARE @s AS NVARCHAR (1000) = 'CREATE PROCEDURE usp_GetErrorInfo
AS
SELECT
    ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage; ';
        EXEC (@s) ;
    END;
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_BigintToInt') 
    BEGIN
        DROP PROCEDURE
             proc_BigintToInt;
    END;
GO

/* CORRECTIVE DDL

ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] DROP CONSTRAINT [FK_HAUserQuestionGroupResultsRiskAreaItemID]

ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestionGroupResults]  WITH CHECK ADD  CONSTRAINT [FK_HAUserQuestionGroupResultsRiskAreaItemID] FOREIGN KEY([HARiskAreaItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserRiskArea] ([ItemID])
ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] CHECK CONSTRAINT [FK_HAUserQuestionGroupResultsRiskAreaItemID]



ALTER TABLE [dbo].[HFit_HealthAssesmentUserAnswers] DROP CONSTRAINT [FK_HAQuestionItemID]

ALTER TABLE [dbo].[HFit_HealthAssesmentUserAnswers]  WITH CHECK ADD  CONSTRAINT [FK_HAQuestionItemID] FOREIGN KEY([HAQuestionItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserQuestion] ([ItemID])
ALTER TABLE [dbo].[HFit_HealthAssesmentUserAnswers] CHECK CONSTRAINT [FK_HAQuestionItemID]


ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskCategory] DROP CONSTRAINT [FK_HAModuleItemID]
ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskCategory]  WITH CHECK ADD  CONSTRAINT [FK_HAModuleItemID] FOREIGN KEY([HAModuleItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserModule] ([ItemID])
ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskCategory] CHECK CONSTRAINT [FK_HAModuleItemID]


ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestion] DROP CONSTRAINT [FK_HARiskAreaItemID]

ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestion]  WITH CHECK ADD  CONSTRAINT [FK_HARiskAreaItemID] FOREIGN KEY([HARiskAreaItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserRiskArea] ([ItemID])
ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestion] CHECK CONSTRAINT [FK_HARiskAreaItemID]

ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskArea] DROP CONSTRAINT [FK_HARiskCategoryItemID]

ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskArea]  WITH CHECK ADD  CONSTRAINT [FK_HARiskCategoryItemID] FOREIGN KEY([HARiskCategoryItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserRiskCategory] ([ItemID])
ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskArea] CHECK CONSTRAINT [FK_HARiskCategoryItemID]


*/

/*
ALTER TABLE HFit_HealthAssesmentUserRiskCategory DISABLE CHANGE_TRACKING; 
ALTER TABLE HFit_HealthAssesmentUserRiskCategory DROP CONSTRAINT PK_HFit_HealthAssesmentUserRiskCategory

ALTER TABLE HFit_HealthAssesmentUserRiskArea DISABLE CHANGE_TRACKING; 
ALTER TABLE HFit_HealthAssesmentUserRiskArea DROP CONSTRAINT PK_HFit_HealthAssesmentUserRiskArea


HFit_HealthAssesmentUserQuestion
ALTER TABLE HFit_HealthAssesmentUserQuestion DISABLE CHANGE_TRACKING; 

ALTER TABLE HFit_HealthAssesmentUserQuestion DROP CONSTRAINT PK_HFit_HealthAssesmentUserQuestion

ALTER TABLE dbo.HFit_HealthAssesmentUserModule DISABLE CHANGE_TRACKING; 
ALTER TABLE dbo.HFit_HealthAssesmentUserModule DROP CONSTRAINT PK_HFit_HealthAssesmentUserModule
The constraint 'PK_HFit_HealthAssesmentUserModule' is being referenced by table 'HFit_HealthAssesmentUserRiskCategory', foreign key constraint 'FK_HAModuleItemID'.

ALTER TABLE HFit_HealthAssesmentUserStarted DISABLE CHANGE_TRACKING; 
ALTER TABLE HFit_HealthAssesmentUserStarted DROP CONSTRAINT PK_HFit_HealthAssesmentUserStarted


    exec proc_BigintToInt @PreviewOnly = 'YES'
    exec proc_BigintToInt @PreviewOnly = 'NO'
*/
CREATE PROCEDURE proc_BigintToInt (
       @PreviewOnly AS NVARCHAR (10) = 'YES') 
AS
BEGIN
    --declare @PreviewOnly AS NVARCHAR (10) = 'YES' ;
    BEGIN TRANSACTION TX01;
    SET NOCOUNT ON;
    --ROLLBACK TRANSACTION TX01;
    BEGIN TRY
	   
IF EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_HARiskAreaItemID]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[HFit_HealthAssesmentUserQuestion]'))
BEGIN
    ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestion] DROP CONSTRAINT [FK_HARiskAreaItemID] ;
END

IF EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_HAQuestionItemID]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[HFit_HealthAssesmentUserAnswers]'))
BEGIN
    ALTER TABLE dbo.HFit_HealthAssesmentUserAnswers DROP CONSTRAINT FK_HAQuestionItemID;
END
	          
IF EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_HAModuleItemID]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[HFit_HealthAssesmentUserRiskCategory]'))
BEGIN
    ALTER TABLE dbo.HFit_HealthAssesmentUserRiskCategory DROP CONSTRAINT FK_HAModuleItemID;
END 
        
IF EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[PK_HFit_HealthAssesmentUserRiskArea]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[HFit_HealthAssesmentUserRiskArea]'))
BEGIN
    ALTER TABLE HFit_HealthAssesmentUserRiskArea DROP CONSTRAINT PK_HFit_HealthAssesmentUserRiskArea ;
END 
	
IF EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_HAUserQuestionGroupResultsRiskAreaItemID]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[HFit_HealthAssesmentUserQuestionGroupResults]'))
BEGIN
    ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] DROP CONSTRAINT [FK_HAUserQuestionGroupResultsRiskAreaItemID] ;
END    


IF EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_HARiskCategoryItemID]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[HFit_HealthAssesmentUserRiskArea]'))
BEGIN
    ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskArea] DROP CONSTRAINT [FK_HARiskCategoryItemID];
END    

IF EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_HAStartedItemID]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[HFit_HealthAssesmentUserModule]'))
BEGIN
    ALTER TABLE [dbo].[HFit_HealthAssesmentUserModule] DROP CONSTRAINT [FK_HAStartedItemID]
END    


        --**********************************************************************
        -- CLEAN UP THE TEMP TABLES IF THEY EXIST.
        --**********************************************************************	  
        BEGIN TRY
            CLOSE CChgTrack;
            DEALLOCATE CChgTrack;
        END TRY
        BEGIN CATCH
            PRINT 'Cleaned up CChgTrack';
        END CATCH;

        BEGIN TRY
            CLOSE CDropIdx;
            DEALLOCATE CDropIdx;
        END TRY
        BEGIN CATCH
            PRINT 'Cleaned up CDropIdx';
        END CATCH;
        BEGIN TRY
            CLOSE CBigint;
            DEALLOCATE CBigint;
        END TRY
        BEGIN CATCH
            PRINT 'Cleaned up CBigint';
        END CATCH;

        BEGIN TRY
            DROP TABLE
                 #ListOfIndexes;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #ListOfIndexes ';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #TMP;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #TMP';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #ListOfSuspectTables;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #ListOfSuspectTables';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #IndexSqlStatement;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #IndexSqlStatement';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #IndexDetail;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #IndexDetail';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #TblPriKeyDDL;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #TblPriKeyDDL';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #PrimaryKeyDetail;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #PrimaryKeyDetail';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #IndexDDL;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #IndexDDL';
        END CATCH;
        BEGIN TRY
            DROP TABLE
                 #CT_Tables;
        END TRY
        BEGIN CATCH
            PRINT 'Recreate #CT_Tables;';
        END CATCH;

        DECLARE @IDX AS NVARCHAR (100) = '';
        DECLARE @CT_Name AS NVARCHAR (100) = '';
        DECLARE @CT_NEEDED AS NVARCHAR (100) = 'N';
        DECLARE @MySql AS NVARCHAR (MAX) = '';
        DECLARE @iCnt AS INT = 0;
        DECLARE @TableName AS NVARCHAR (100) = ''
              , @IndexName  AS NVARCHAR (100) = ''
                --      , @IdxSQL AS NVARCHAR (MAX) = ''
              , @S AS NVARCHAR (MAX) = '';

        DECLARE @i AS INT = 0;
        DECLARE @CurrConstraint AS NVARCHAR (100) = '';
        DECLARE @PrevConstraint AS NVARCHAR (100) = '~~';
        DECLARE @CurrTable AS NVARCHAR (100) = '';
        DECLARE @PrevTable AS NVARCHAR (100) = '~~';
        DECLARE @CurrIDX AS NVARCHAR (100) = '';
        DECLARE @PrevIDX AS NVARCHAR (100) = '~~';
        DECLARE @IdxSQL AS NVARCHAR (MAX) = NULL;
        DECLARE @IndexCols AS NVARCHAR (MAX) = NULL;
        DECLARE @Includes AS NVARCHAR (MAX) = NULL;
        DECLARE @DDL  AS NVARCHAR (MAX) = NULL;
        DECLARE @iColCnt AS INT = 0;

        --**********************************************************************
        -- GET ALL INDEXS' DETAIL ATTRIBUTES IN CASE WE NEED THEM LATER.
        --**********************************************************************
        SELECT
               OBJECT_SCHEMA_NAME (T.object_id, DB_ID ()) AS [Schema]
             , T.name AS table_name
             , I.name AS index_name
             , AC.name AS column_name
             , I.type_desc
             , I.is_unique
             , I.data_space_id
             , I.ignore_dup_key
             , I.is_primary_key
             , I.is_unique_constraint
             , I.fill_factor
             , I.is_padded
             , I.is_disabled
             , I.is_hypothetical
             , I.allow_row_locks
             , I.allow_page_locks
             , IC.is_descending_key
             , IC.is_included_column
        INTO
             #IndexDetail
               FROM sys.tables AS T
                        INNER JOIN sys.indexes AS I
                            ON T.object_id = I.object_id
                        INNER JOIN sys.index_columns AS IC
                            ON I.object_id = IC.object_id
                        INNER JOIN sys.all_columns AS AC
                            ON T.object_id = AC.object_id
                           AND IC.column_id = AC.column_id
               WHERE T.is_ms_shipped = 0
                 AND I.type_desc <> 'HEAP'
               ORDER BY
                        T.name, I.index_id, IC.key_ordinal;

        --**********************************************************************
        -- GET THE LIST OF TABLES THAT MIGHT HAVE ISSUES
        --**********************************************************************
        -- select * from #ListOfSuspectTables
        SELECT
               table_name
             , column_name
             , is_nullable
        INTO
             #ListOfSuspectTables
               FROM information_Schema.columns
               WHERE
               data_type = 'bigint'
           AND column_name != 'SYS_CHANGE_VERSION';
        --**********************************************************************
        -- GET THE PRIMARY KEY INDEXS / CONSTRAINTS
        --**********************************************************************
        SELECT DISTINCT
               KU.CONSTRAINT_NAME
             , KU.TABLE_NAME
             , KU.COLUMN_NAME
             , KU.ORDINAL_POSITION
        INTO
             #PrimaryKeyDetail
               FROM KenticoCMS_PRD_1.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
                        INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
                            ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
                           AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
                        INNER JOIN #ListOfSuspectTables AS S
                            ON KU.TABLE_NAME = S.table_name
               ORDER BY
                        KU.TABLE_NAME, KU.ORDINAL_POSITION ASC;

        --SELECT * FROM #PrimaryKeyDetail ORDER BY TABLE_NAME, ORDINAL_POSITION ASC;
        --**********************************************************************
        -- GENERATE THE NON-PRIMARY KEY INDEX DDL
        --**********************************************************************
        SELECT
               sys.objects.name AS Table_Name
             , sys.indexes.name AS IndexName
             , 'CREATE ' + CASE WHEN sys.indexes.is_unique = 1
                                 AND sys.indexes.is_primary_key = 0
                                   THEN 'UNIQUE '
                               ELSE ''
                           END + CASE WHEN sys.indexes.type_desc = 'CLUSTERED'
                                         THEN 'CLUSTERED '
                                     ELSE 'NONCLUSTERED '
                                 END + 'INDEX ' + sys.indexes.name + ' ON ' + sys.objects.name + ' ( ' + Index_Columns.index_columns_key + ' ) ' + ISNULL ('INCLUDE (' + Index_Columns.index_columns_include + ')', '') AS IndexDDL
        INTO
             #IndexDDL
               FROM sys.objects
                        JOIN sys.schemas
                            ON sys.objects.schema_id = sys.schemas.schema_id
                        JOIN sys.indexes
                            ON sys.indexes.object_id = sys.objects.object_id
                        INNER JOIN #ListOfSuspectTables AS S
                            ON sys.objects.name = S.table_name CROSS APPLY(
            SELECT
                   LEFT (index_columns_key, LEN (index_columns_key) - 1) AS index_columns_key
                 , LEFT (index_columns_include, LEN (index_columns_include) - 1) AS index_columns_include
                   FROM(
            SELECT
                   (
            SELECT
                   sys.columns.name + ','
                   FROM sys.index_columns
                            JOIN sys.columns
                                ON sys.index_columns.column_id = sys.columns.column_id
                               AND sys.index_columns.object_id = sys.columns.object_id
                   WHERE sys.index_columns.is_included_column = 0
                     AND sys.indexes.object_id = sys.index_columns.object_id
                     AND sys.indexes.index_id = sys.index_columns.index_id
                   ORDER BY
                            key_ordinal
                   FOR
                   XML PATH (''))AS index_columns_key
                 , (
            SELECT
                   sys.columns.name + ','
                   FROM sys.index_columns
                            JOIN sys.columns
                                ON sys.index_columns.column_id = sys.columns.column_id
                               AND sys.index_columns.object_id = sys.columns.object_id
                   WHERE sys.index_columns.is_included_column = 1
                     AND sys.indexes.object_id = sys.index_columns.object_id
                     AND sys.indexes.index_id = sys.index_columns.index_id
                   ORDER BY
                            index_column_id
                   FOR
                   XML PATH (''))AS index_columns_include)AS Index_Columns)AS Index_Columns
               WHERE
               sys.objects.type = 'u'
           AND sys.objects.is_ms_shipped = 0
           AND sys.indexes.type_desc <> 'HEAP'
           AND sys.indexes.is_primary_key = 0
               ORDER BY
                        sys.objects.name, sys.indexes.name;

        -- SELECT * FROM #IndexDDL;

        --**********************************************************************
        -- BUILD A TEMP TABLE TO HOLD THE PRIMARY KEY DDL FOR SUSPECT TABLES.
        -- LEAVE THE DDL STATEMENT BLANK SO IT CAN BE POPULATED LATER.
        --**********************************************************************
        SELECT DISTINCT
               P.table_name
             , constraint_name
             , REPLICATE (' ', 4000) AS IdxSQL
        INTO
             #TblPriKeyDDL
               FROM #PrimaryKeyDetail AS P
                        INNER JOIN #ListOfSuspectTables AS S
                            ON P.table_name = S.table_name;
        -- select * from #TblPriKeyDDL

        -- drop table #IndexSqlStatement
        SELECT DISTINCT
               I.table_name AS TableName
             , index_name AS IndexName
             , REPLICATE (' ', 4000) AS IdxSQL
        INTO
             #IndexSqlStatement
               FROM #IndexDetail AS I
                        INNER JOIN #ListOfSuspectTables AS S
                            ON I.table_name = S.table_name;

        --select * from #IndexSqlStatement;

        --**********************************************************************
        -- BUILD A TEMP TABLE TO HOLD THE PRIMARY KEY DDL FOR SUSPECT TABLES.
        -- AND NOW, POPULATE THE DDL.
        --**********************************************************************
        -- select * from #PrimaryKeyDetail
        DECLARE
        @CONSTRAINT_NAME NVARCHAR (128) 
      , @table_name  NVARCHAR (128) 
      , @column_name NVARCHAR (128) 
      , @ORDINAL_POSITION INT;

        DECLARE C1 CURSOR
            FOR
                SELECT DISTINCT
                       CONSTRAINT_NAME
                     , table_name
                     , column_name
                     , ORDINAL_POSITION
                       FROM #PrimaryKeyDetail
                       ORDER BY
                                table_name, CONSTRAINT_NAME, ORDINAL_POSITION;
        OPEN C1;

        truncate TABLE #TblPriKeyDDL;
        -- select top 100 * from temp_ListOfIndexes
        -- DBCC FREEPROCCACHE

        FETCH NEXT FROM C1 INTO @CONSTRAINT_NAME, @table_name, @column_name, @ORDINAL_POSITION;
        WHILE
        @@FETCH_STATUS <> -1
            BEGIN

                SET @CurrTable = @table_name;

                IF @i = 0
                OR @PrevConstraint <> @CONSTRAINT_NAME
                    BEGIN
                        SET @i = @i + 1;
                        IF LEN (@IdxSQL) > 0
                            BEGIN
                                SET @DDL = @IdxSQL + @IndexCols + ')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]';
                                INSERT INTO #TblPriKeyDDL (
                                       table_name
                                     , constraint_name
                                     , IdxSQL) 
                                VALUES (
                                       @table_name, @PrevConstraint, @DDL) ;
                            END;
                        SET @PrevConstraint = @CurrConstraint;
                        SET @IdxSQL = 'ALTER TABLE ' + @CurrTable + ' ADD CONSTRAINT [' + @CONSTRAINT_NAME + '] primary key clustered ';
                        SET @iColCnt = 1;
                        SET @IndexCols = '(';
                    END;

                IF @iColCnt = 1
                    BEGIN
                        SET @IndexCols = @IndexCols + @column_name;
                    END;
                ELSE
                    BEGIN
                        SET @IndexCols = @IndexCols + ', ' + @column_name;
                    END;

                SET @PrevConstraint = @CONSTRAINT_NAME;
                FETCH NEXT FROM C1 INTO @CONSTRAINT_NAME, @table_name, @column_name, @ORDINAL_POSITION;
                SET @PrevTable = @table_name;
                SET @iColCnt = @iColCnt + 1;
            END;

        IF LEN (@IdxSQL) > 0
            BEGIN
                SET @DDL = @IdxSQL + @IndexCols + ')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]';
                INSERT INTO #TblPriKeyDDL (
                       table_name
                     , constraint_name
                     , IdxSQL) 
                VALUES (
                       @table_name, @PrevConstraint, @DDL) ;
            END;
        CLOSE C1;
        DEALLOCATE C1;

        -- SELECT * FROM #TblPriKeyDDL;

        --**********************************************************************
        -- CHANGE TRACKING MUST BE DISABLED FOR ALL TABLES    
        --**********************************************************************
        --drop table #CT_Tables ;
        SELECT
               t.name
        INTO
             #CT_Tables
               FROM sys.change_tracking_tables AS tr
                        INNER JOIN sys.tables AS t
                            ON t.object_id = tr.object_id
                        INNER JOIN sys.schemas AS s
                            ON s.schema_id = t.schema_id;

        DECLARE CCT CURSOR
            FOR
                SELECT DISTINCT
                       name
                       FROM #CT_Tables AS I
                                INNER JOIN #ListOfSuspectTables AS S
                                    ON I.NAME = S.table_name;
        OPEN CCT;

        FETCH NEXT FROM CCT INTO @TableName;

        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = 'ALTER TABLE ' + @TableName + ' DISABLE CHANGE_TRACKING; ';
                PRINT 'Disable CT: ' + @MySql;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
                FETCH NEXT FROM CCT INTO @TableName;
            END;
        CLOSE CCT;
        DEALLOCATE CCT;

        --**********************************************************************
        -- INDEXES MUST BE DROPPED SO THAT AN ALTER TABLE CAN BE ACCOMPLISHED.
        -- ONCE THIS IS DONE, CALL THE PROCEDURE TO CHANGE BIGINT TO INT.
        --**********************************************************************
        -- select * from #IndexSqlStatement        
        -- select * from information_Schema.columns where table_name = 'BASE_HFit_HealthAssesmentUserStarted' 
        -- drop table #IndexSqlStatement

        DECLARE CDropIdx CURSOR
            FOR
                SELECT DISTINCT
                       TableName
                     , IndexName
                --, IdxSQL
                       FROM #IndexSqlStatement AS I
                                INNER JOIN #ListOfSuspectTables AS S
                                    ON I.TABLENAME = S.table_name
                EXCEPT
                SELECT
                       TABLE_NAME
                     , CONSTRAINT_NAME
                       FROM  #TblPriKeyDDL
                       ORDER BY
                                I.TableName, I.IndexName;

        --SELECT * FROM #IndexSqlStatement;

        OPEN CDropIdx;

        FETCH NEXT FROM CDropIdx
        --INTO @TableName, @IndexName, @IdxSQL;
        INTO @TableName, @IndexName;

        WHILE @@FETCH_STATUS = 0
            BEGIN

                SET @IDX = (SELECT
                                   constraint_name
                                   FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                   WHERE CONSTRAINT_TYPE = 'PRIMARY KEY'
                                     AND TABLE_NAME = @TableName
                                     AND constraint_name = @IndexName );

                IF @IDX IS NOT NULL
                    BEGIN
                        SET @S = 'ALTER TABLE ' + @TableName + ' DROP CONSTRAINT ' + @IndexName;
                        PRINT 'ALTER INDEX: ' + @S;
                    END;
                ELSE
                    BEGIN
                        SET @S = 'Drop index [' + @IndexName + '] ON ' + @TableName;
                        PRINT 'Drop INDEX: ' + @S;
                    END;

                IF @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@S) ;
                    END;
                FETCH NEXT FROM CDropIdx
                --INTO @TableName, @IndexName, @IdxSQL;
                INTO @TableName, @IndexName;
            END;
        CLOSE CDropIdx;
        DEALLOCATE CDropIdx;

        --**********************************************************************
        -- THE INDEXES HAVE BEEN DROPPED.
        -- CALL THE PROCEDURE TO CHANGE BIGINT TO INT ON EACH SUSPECT TABLE.
        --**********************************************************************
        DECLARE CBigint CURSOR
            FOR
                SELECT DISTINCT
                       TableName
                       FROM #IndexSqlStatement AS I
                                INNER JOIN #ListOfSuspectTables AS S
                                    ON I.TABLENAME = S.table_name;
        OPEN CBigint;

        FETCH NEXT FROM CBigint INTO @TableName;

        WHILE @@FETCH_STATUS = 0
            BEGIN

                SET @S = 'EXEC proc_ConvertBigintToInt ' + @TableName;
                PRINT 'CONVERT BigInt: ' + @S;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@S) ;
                    END;
                FETCH NEXT FROM CBigint INTO @TableName;
            END;
        CLOSE CBigint;
        DEALLOCATE CBigint;

        --**********************************************************************
        -- Recreate the indexes, both primary key and non-key indexes.
        -- LOOP THRU THE Standard INDEXES AND CREATE ON EACH TABLE.
        --**********************************************************************
        -- select * from #IndexDDL
        DECLARE CIndexDDL CURSOR
            FOR
                SELECT DISTINCT
                       I.Table_Name
                     , IndexName
                     , IndexDDL
                       FROM #IndexDDL AS I
                                INNER JOIN #ListOfSuspectTables AS S
                                    ON I.Table_Name = S.table_name;

        OPEN CIndexDDL;

        FETCH NEXT FROM CIndexDDL
        INTO @TableName, @IndexName, @IdxSQL;

        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @S = 'EXEC (' + @IdxSQL + ');';
                PRINT 'CREATE IDX: ' + @S;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@S) ;
                    END;
                FETCH NEXT FROM CIndexDDL
                INTO @TableName, @IndexName, @IdxSQL;
            END;
        CLOSE CIndexDDL;
        DEALLOCATE CIndexDDL;

        --**********************************************************************
        -- LOOP THRU THE PRIMARY KEY INDEXES AND REBUILD ON EACH TABLE.
        --**********************************************************************
        DECLARE CPkeyDDL CURSOR
            FOR
                SELECT DISTINCT
                       I.Table_Name
                     , I.Constraint_name AS IndexName
                     , IdxSQL AS IndexDDL
                       FROM #TblPriKeyDDL AS I
                                INNER JOIN #ListOfSuspectTables AS S
                                    ON I.Table_Name = S.table_name;

        OPEN CPkeyDDL;

        FETCH NEXT FROM CPkeyDDL
        INTO @TableName, @IndexName, @IdxSQL;

        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @S = 'EXEC (' + @IdxSQL + ');';
                PRINT 'ADD PK: ' + @S;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@S) ;
                    END;
                FETCH NEXT FROM CPkeyDDL
                INTO @TableName, @IndexName, @IdxSQL;
            END;
        CLOSE CPkeyDDL;
        DEALLOCATE CPkeyDDL;
        --**********************************************************************
        -- LOOP THRU THE PRIMARY KEY INDEXES AND REBUILD ON EACH TABLE.
        --**********************************************************************
        DECLARE CChgTrack CURSOR
            FOR
                SELECT DISTINCT
                       name
                       FROM #CT_Tables AS I
                                INNER JOIN #ListOfSuspectTables AS S
                                    ON I.NAME = S.table_name;

        OPEN CChgTrack;

        FETCH NEXT FROM CChgTrack INTO @TableName;

        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = 'ALTER TABLE ' + @TableName + ' ENABLE CHANGE_TRACKING; ';
                PRINT 'ENABLE CT : ' + @MySql;

                IF @PreviewOnly = 'NO'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
                FETCH NEXT FROM CChgTrack INTO @TableName;
            END;
        CLOSE CChgTrack;
        DEALLOCATE CChgTrack;

        ALTER TABLE dbo.HFit_HealthAssesmentUserAnswers
                WITH CHECK
        ADD
                     CONSTRAINT FK_HAQuestionItemID FOREIGN KEY (HAQuestionItemID) 
                     REFERENCES dbo.HFit_HealthAssesmentUserQuestion (
                                ItemID) ;
        ALTER TABLE dbo.HFit_HealthAssesmentUserAnswers CHECK CONSTRAINT
                    FK_HAQuestionItemID;

        ALTER TABLE dbo.HFit_HealthAssesmentUserRiskCategory
                WITH CHECK
        ADD
                     CONSTRAINT FK_HAModuleItemID FOREIGN KEY (HAModuleItemID) 
                     REFERENCES dbo.HFit_HealthAssesmentUserModule (
                                ItemID) ;
        ALTER TABLE dbo.HFit_HealthAssesmentUserRiskCategory CHECK CONSTRAINT
                    FK_HAModuleItemID;

ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestion]  WITH CHECK ADD  CONSTRAINT [FK_HARiskAreaItemID] FOREIGN KEY([HARiskAreaItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserRiskArea] ([ItemID]) ;
ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestion] CHECK CONSTRAINT [FK_HARiskAreaItemID] ;

ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestionGroupResults]  WITH CHECK ADD  CONSTRAINT [FK_HAUserQuestionGroupResultsRiskAreaItemID] FOREIGN KEY([HARiskAreaItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserRiskArea] ([ItemID]) ;
ALTER TABLE [dbo].[HFit_HealthAssesmentUserQuestionGroupResults] CHECK CONSTRAINT [FK_HAUserQuestionGroupResultsRiskAreaItemID] ;

ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskArea]  WITH CHECK ADD  CONSTRAINT [FK_HARiskCategoryItemID] FOREIGN KEY([HARiskCategoryItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserRiskCategory] ([ItemID]) ;
ALTER TABLE [dbo].[HFit_HealthAssesmentUserRiskArea] CHECK CONSTRAINT [FK_HARiskCategoryItemID] ;

ALTER TABLE [dbo].[HFit_HealthAssesmentUserModule]  WITH CHECK ADD  CONSTRAINT [FK_HAStartedItemID] FOREIGN KEY([HAStartedItemID])
    REFERENCES [dbo].[HFit_HealthAssesmentUserStarted] ([ItemID]) ;
ALTER TABLE [dbo].[HFit_HealthAssesmentUserModule] CHECK CONSTRAINT [FK_HAStartedItemID] ;

        SET NOCOUNT OFF;
        COMMIT TRANSACTION TX01;
        PRINT 'PROCESSING COMPLETE.';
    END TRY
    BEGIN CATCH
        PRINT 'ERRORS DETECTED, ROLLING BACK - PLEASE STANDBY.';
        EXECUTE usp_GetErrorInfo;
        ROLLBACK TRANSACTION TX01;
    END CATCH;
END;
--SELECT * FROM #IndexDDL;
--SELECT * FROM #TblPriKeyDDL;
GO
PRINT 'Executed proc_BigintToInt.sql';
GO
