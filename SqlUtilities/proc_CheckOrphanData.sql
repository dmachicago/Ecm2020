

-- use KenticoCMS_Datamart
-- use [KenticoCMS_DataMart_2]

GO
PRINT 'Executing proc_CheckOrphanData.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_CheckOrphanData') 
    BEGIN
        DROP PROCEDURE
             proc_CheckOrphanData;
    END;
GO

IF NOT EXISTS (SELECT
                      NAME
               FROM SYS.PROCEDURES
               WHERE
                      NAME = 'usp_GetErrorInfo') 
    BEGIN
        DECLARE
               @S AS NVARCHAR (1000) = 'CREATE PROCEDURE usp_GetErrorInfo AS SELECT ERROR_NUMBER() AS ErrorNumber,ERROR_SEVERITY() AS ErrorSeverity,ERROR_STATE() AS ErrorState,ERROR_PROCEDURE() AS ErrorProcedure,ERROR_LINE() AS ErrorLine,ERROR_MESSAGE() AS ErrorMessage; ';
        EXEC (@S) ;
    END;
GO

/*--------------------------------------------------------------------------------------------------------------
select 'exec proc_CheckOrphanData BASE_CMS_User, ' + table_name + char(10) + 'GO' from information_schema.tables
where (table_name like '%tracker%' or table_name like 'BASE_hfit_PPTEligibility')
and table_name not like '%_DEL' 
--and table_name not like 'FACT_%' 
and table_name not like '%_CTVerHIST'
and table_type = 'BASE TABLE'

select * from MART_Orphan_Rec_Log order by CreateDate desc

exec proc_CheckOrphanData BASE_CMS_User, BASE_HFit_TrackerStress
exec proc_CheckOrphanData BASE_CMS_User, BASE_HFit_TrackerSitLess
*/
CREATE PROCEDURE proc_CheckOrphanData (
       @PTbl NVARCHAR (250) 
     , @CTbl NVARCHAR (250) 
     , @PreviewOnly NVARCHAR (5) = 'NO') 
AS
BEGIN
    --DECLARE
    --       @PTbl NVARCHAR (250) 
    --     , @CTbl NVARCHAR (250) ;

    --SET @PTbl = 'BASE_CMS_User';
    --SET @CTbl = 'BASE_HFit_TrackerStress';

    DECLARE
           @MySql NVARCHAR (2500) 
         , @SKey NVARCHAR (250) 
         , @iCnt INTEGER;

    --FACT_HFit_TrackerStrength
    --HFit_TrackerStrength

    SET @iCnt = charindex ('FACT_' , @CTbl) ;

    PRINT @CTbl;
    IF @iCnt = 0
        BEGIN
            SET @iCnt = charindex ('_' , @CTbl) ;
            SET @SKey = substring (@CTbl , @iCnt + 1 , 999) ;
        END;
    ELSE
        BEGIN
            SET @SKey = @CTbl;
        END;

    PRINT @SKey;

    SET NOCOUNT ON;
    IF
           CURSOR_STATUS ('global' , 'C5') >= -1
        BEGIN
            CLOSE C5;
            DEALLOCATE C5;
        END;
    IF
           CURSOR_STATUS ('global' , 'C10') >= -1
        BEGIN
            CLOSE C10;
            DEALLOCATE C10;
        END;

    DECLARE
           @i AS INT = 0;
    EXEC @i = proc_TableContainsAllCols @CTbl , 'SVR,DBNAME,UserID';
    IF @i = 0
        BEGIN
            INSERT INTO MART_Orphan_Rec_Log (
                   ParentTableName
                 , TableName
                 , LogText
                 , OrphanCnt) 
            VALUES (@PTbl , @CTbl , 'Does not contain required colmns (SVR,DBNAME,UserID) - aborting.' , 0) ;
            PRINT @CTbl + 'Does not contain required colmns (SVR,DBNAME,UserID) - aborting.';
            RETURN;
        END;

    -- select * From ##FK_Constraints
    EXEC ScriptAllForeignKeyConstraints ;

    IF NOT EXISTS (SELECT
                          table_name
                   FROM information_schema.tables
                   WHERE
                          table_name = 'MART_Orphan_Rec_Log') 
        BEGIN
            CREATE TABLE MART_Orphan_Rec_Log
            (
                         ParentTableName NVARCHAR (250) NOT NULL
                       , TableName NVARCHAR (250) NOT NULL
                       , LogText NVARCHAR (MAX) NULL
                       , OrphanCnt INT NULL
                       , CreateDate DATETIME2 DEFAULT getdate () 
                       , RowNumber INT IDENTITY (1 , 2) 
                                       NOT NULL
            );
        END;

    IF OBJECT_ID ('TEMPDB..#TableColumns') IS NOT NULL
        BEGIN
            DROP TABLE
                 #TableColumns;
        END;

    SELECT
           table_name
         , column_name
    INTO
         #TableColumns
    FROM information_Schema.columns
    WHERE
           table_name = @CTbl;

    IF NOT EXISTS (SELECT
                          column_name
                   FROM #TableColumns
                   WHERE
                   column_name LIKE 'Surrogate%') 
        BEGIN
            PRINT @CTbl + ' does not contain A surrogate KEY - aborting.';
            INSERT INTO MART_Orphan_Rec_Log (
                   ParentTableName
                 , TableName
                 , LogText
                 , OrphanCnt) 
            VALUES (@PTbl , @CTbl , 'NO surrogate KEY - aborting.' , 0) ;
            RETURN;
        END;
    IF NOT EXISTS (SELECT
                          column_name
                   FROM #TableColumns
                   WHERE
                          column_name = 'SVR') 
        BEGIN
            INSERT INTO MART_Orphan_Rec_Log (
                   ParentTableName
                 , TableName
                 , LogText
                 , OrphanCnt) 
            VALUES (@PTbl , @CTbl , 'NO SVR KEY - aborting.' , 0) ;

            PRINT @CTbl + ' does not contain column SVR - aborting.';
            RETURN;
        END;
    IF NOT EXISTS (SELECT
                          column_name
                   FROM #TableColumns
                   WHERE
                          column_name = 'DBNAME') 
        BEGIN
            INSERT INTO MART_Orphan_Rec_Log (
                   ParentTableName
                 , TableName
                 , LogText
                 , OrphanCnt) 
            VALUES (@PTbl , @CTbl , 'NO DBNAME KEY - aborting.' , 0) ;

            PRINT @CTbl + ' does not contain column DBNAME - aborting.';
            RETURN;
        END;
    IF NOT EXISTS (SELECT
                          column_name
                   FROM #TableColumns
                   WHERE
                          column_name = 'UserID') 
        BEGIN
            INSERT INTO MART_Orphan_Rec_Log (
                   ParentTableName
                 , TableName
                 , LogText
                 , OrphanCnt) 
            VALUES (@PTbl , @CTbl , 'NO UserID KEY - aborting.' , 0) ;

            PRINT @CTbl + ' does not contain column UserID - aborting.';
            RETURN;
        END;

    IF OBJECT_ID ('TEMPDB..#ChildIndexes') IS NOT NULL
        BEGIN
            DROP TABLE
                 #ChildIndexes;
        END;

    SELECT
           i.name AS index_name
         , COL_NAME (ic.object_id , ic.column_id) AS column_name
         , ic.index_column_id
         , ic.key_ordinal
         , ic.is_included_column
    INTO
         #ChildIndexes
    FROM
         sys.indexes AS i
         INNER JOIN sys.index_columns AS ic
         ON
           i.object_id = ic.object_id AND
           i.index_id = ic.index_id
    WHERE
           i.object_id = OBJECT_ID (@CTbl) ;

    BEGIN TRANSACTION TRX001;

    BEGIN TRY

        IF OBJECT_ID ('TEMPDB..#MissingKeys') IS NOT NULL
            BEGIN
                PRINT 'DROPPED Table #MissingKeys';
                DROP TABLE
                     #MissingKeys;
            END;

        CREATE TABLE #MissingKeys (
                     SurrogateKeyID BIGINT) ;

        --SET @MySql = 'set @iCnt = (SELECT count(*) FROM ' + @CTbl + ' AS T LEFT OUTER JOIN ' + @PTbl + ' AS C ON C.SVR = T.SVR AND C.DBNAME = T.DBNAME AND C.UserID = T.UserID WHERE T.UserID IS NULL)  ';
        --PRINT @MySql;
        --EXEC (@MySql) ;
        --print @iCnt ;

        SET @MySql = 'insert into #MissingKeys (SurrogateKeyID) ' + char (10) ;
        SET @MySql = @MySql + ' SELECT SurrogateKey_' + @SKey + char (10) ;
        SET @MySql = @MySql + ' FROM ' + @CTbl + ' AS T LEFT OUTER JOIN BASE_CMS_User AS C ON C.SVR = T.SVR AND C.DBNAME = T.DBNAME AND C.UserID = T.UserID WHERE C.UserID IS NULL;  ';

        --SET @MySql = 'SELECT SurrogateKey_' + @SKey + ' INTO #MissingKeys FROM ' + @CTbl + ' AS T LEFT OUTER JOIN ' + @PTbl + ' AS C ON C.SVR = T.SVR AND C.DBNAME = T.DBNAME AND C.UserID = T.UserID WHERE C.UserID IS NULL;  ';
        PRINT @MySql;
        EXEC (@MySql) ;

        IF OBJECT_ID ('TEMPDB..#MissingKeys') IS NULL
            BEGIN
                INSERT INTO MART_Orphan_Rec_Log (
                       ParentTableName
                     , TableName
                     , LogText
                     , OrphanCnt) 
                VALUES (@PTbl , @CTbl , '1- No Orphans found.' , 0) ;
                PRINT '@1 No records to process, returning.';
                COMMIT TRANSACTION TRX001;
                RETURN;
            END;

        SET @iCnt = (SELECT
                            count (*) 
                     FROM #MissingKeys) ;
        IF @iCnt = 0
            BEGIN
                INSERT INTO MART_Orphan_Rec_Log (
                       ParentTableName
                     , TableName
                     , LogText
                     , OrphanCnt) 
                VALUES (@PTbl , @CTbl , '2- No Orphans found.' , 0) ;
                PRINT '@2 No records to process, returning.';
                COMMIT TRANSACTION TRX001;
                RETURN;
            END;
        ELSE
            BEGIN
                INSERT INTO MART_Orphan_Rec_Log (
                       ParentTableName
                     , TableName
                     , LogText
                     , OrphanCnt) 
                VALUES (@PTbl , @CTbl , 'ORPHANS found.' , @iCnt) ;
                PRINT 'ORPHAN RECORDS FOUND: ' + cast (@iCnt AS NVARCHAR (50)) ;
            END;
        --select * FROM #MissingKeys;

        SET @MySql = 'disable trigger [TRIG_DEL_' + @CTbl + '] on [' + @CTbl + '] ; ';
        PRINT @MySql;
        EXEC (@MySql) ;
        SET @MySql = 'disable trigger [TRIG_UPDT_' + @CTbl + '] on [' + @CTbl + ']; ';
        PRINT @MySql;
        EXEC (@MySql) ;

        --*****************************************************************************************
        DECLARE
               @FgnKeyNAME AS NVARCHAR (500) 
             , @GenSql AS NVARCHAR (500) 
             , @ReferencedTable AS NVARCHAR (500) 
             , @ParentTableName AS NVARCHAR (500) ;

        DECLARE C5 CURSOR
            FOR SELECT
                       ForeignKeyNAME
                     , GenSql
                     , ReferencedTable
                     , ParentTableName
                FROM ##FK_Constraints
                WHERE
                       ParentTableName = 'FACT_TrackerData' AND
                       ReferencedTable = @CTbl;

        --select * from ##FK_Constraints where ParentTableName = 'FACT_TrackerData'
        --select * from ##FK_Constraints where ReferencedTable = 'FACT_TrackerData'

        OPEN C5;
        FETCH NEXT FROM C5 INTO @FgnKeyNAME , @GenSql , @ReferencedTable , @ParentTableName;

        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = 'ALTER TABLE dbo.' + @ParentTableName + ' DROP CONSTRAINT ' + @FgnKeyNAME + ';';
                PRINT  @MySql + ' -- STEP 1B: ';
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
                FETCH NEXT FROM C5 INTO @FgnKeyNAME , @GenSql , @ReferencedTable , @ParentTableName;
            END;

        CLOSE C5;
        DEALLOCATE C5;
        --*****************************************************************************************

        SET @MySql = 'Delete from ' + @CTbl + ' where SurrogateKey_' + @SKey + ' in (select SurrogateKeyID from #MissingKeys) ; ';
        IF
               @PreviewOnly != 'YES'
            BEGIN
                PRINT @MySql;
                EXEC (@MySql) ;
            END;
        ELSE
            BEGIN
                PRINT 'PREVIEW ONLY: ' + @MySql;
            END;

        --*************************************************************************************************
        DECLARE
               @FgnKeyNAME2 AS NVARCHAR (500) 
             , @GenSql2 AS NVARCHAR (500) ;
        DECLARE C10 CURSOR
            FOR SELECT
                       ForeignKeyNAME
                     , GenSql
                FROM ##FK_Constraints
                --WHERE ParentTableName = @CTbl
                WHERE
                       ParentTableName = 'FACT_TrackerData' AND
                       ReferencedTable = @CTbl;

        OPEN C10;
        FETCH NEXT FROM C10 INTO @FgnKeyNAME2 , @GenSql2;

        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @iCnt = (SELECT
                                    object_ID (@FgnKeyNAME2)) ;
                IF @iCnt IS NOT NULL
                    BEGIN
                        SET @MySql = @GenSql2;
                        PRINT @MySql + '  --STEP 10B: ';
                        IF
                               @PreviewOnly != 'YES'
                            BEGIN
                                EXEC (@MySql) ;
                            END;
                    END;
                ELSE
                    BEGIN
                        PRINT 'NOTICE: ' + @FgnKeyNAME2 + ', already exists, skipping.';
                    END;
                FETCH NEXT FROM C10 INTO @FgnKeyNAME2 , @GenSql2;
            END;

        CLOSE C10;
        DEALLOCATE C10;
        --*************************************************************************************************

        SET @MySql = 'enable trigger [TRIG_DEL_' + @CTbl + '] on [' + @CTbl + '] ;';
        PRINT @MySql;
        EXEC (@MySql) ;
        PRINT @MySql;
        SET @MySql = 'enable trigger [TRIG_UPDT_' + @CTbl + '] on [' + @CTbl + '] ;';
        EXEC (@MySql) ;
        COMMIT TRANSACTION TRX001;
        SET NOCOUNT OFF;
    END TRY
    BEGIN CATCH
        EXECUTE dbo.USP_GETERRORINFO;
        PRINT 'ERROR: RollBack - ' + @MySql;
        ROLLBACK TRANSACTION TRX001;
    END CATCH;

END;
GO
PRINT 'Executed proc_CheckOrphanData.sql';
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
