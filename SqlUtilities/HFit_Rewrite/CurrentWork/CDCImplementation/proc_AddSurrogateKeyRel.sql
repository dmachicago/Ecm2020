
-- use KenticoCMS_Datamart
-- use [KenticoCMS_DataMart_2]

GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_AddSurrogateKey_AllTrackerTables') 
    BEGIN
        DROP PROCEDURE
             proc_AddSurrogateKey_AllTrackerTables;
    END;
GO
PRINT 'Creating PROCEDURE proc_AddSurrogateKey_AllTrackerTables.sql';
-- exec proc_AddSurrogateKey_AllTrackerTables 'YES'
GO
CREATE PROCEDURE proc_AddSurrogateKey_AllTrackerTables (
       @PreviewOnly AS NVARCHAR (10) = 'NO') 
AS
BEGIN

    DECLARE
           @DDL AS NVARCHAR (MAX) = ''
         , @MySql AS NVARCHAR (MAX) = ''
         , @Msg AS NVARCHAR (500) = '';

    SELECT
           'exec proc_AddSurrogateKeyRel KenticoCMS_Datamart, BASE_CMS_user, ' + table_name + ', ' + @PreviewOnly AS DDL
    INTO
         #SurrogateKeyDDL
    FROM information_schema.tables
    WHERE
    table_name LIKE 'BASE_HFit_Tracker%' AND
    table_name NOT LIKE 'BASE_HFit_TrackerCollectionSource' AND
    table_name NOT LIKE 'BASE_HFIT_Tracker' AND
    table_name NOT LIKE '%_DEL' AND
    table_name NOT LIKE '%_CTVerHist';

    IF
           CURSOR_STATUS ('global' , 'CTRACKER') >= -1
        BEGIN
            CLOSE CTRACKER;
            DEALLOCATE CTRACKER;
        END;

    DECLARE CTRACKER CURSOR
        FOR SELECT
                   DDL
            FROM #SurrogateKeyDDL;

    OPEN CTRACKER;
    FETCH NEXT FROM CTRACKER INTO @DDL;

    --Disable all child table triggers
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = @DDL;
            BEGIN TRY
                IF
                       @PreviewOnly = 'YES'
                    BEGIN
                        PRINT '-- ' + @DDL;
                    END;
                ELSE
                    BEGIN
                        PRINT @DDL;
                        EXEC (@MySql) ;
                    END;
            END TRY
            BEGIN CATCH
                SET @Msg = 'ERROR: ' + @DDL;
            END CATCH;
            FETCH NEXT FROM CTRACKER INTO @DDL;
        END;

    CLOSE CTRACKER;
    DEALLOCATE CTRACKER;

END;

-- use KenticoCMS_Datamart
-- use [KenticoCMS_DataMart_2]

--  select * from information_schema.columns where table_name = 'BASE_CMS_user' --	SurrogateKey_cms_user

-- get all existing indexes into a temp table
-- drop the PK index as it exist
-- add the desired 

GO
PRINT 'Executing proc_AddSurrogateKeyRel.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_AddSurrogateKeyRel') 
    BEGIN
        DROP PROCEDURE
             proc_AddSurrogateKeyRel;
    END;
GO

/*------------------------------------------------------------------------------------------------------------------------------
-- use [KenticoCMS_DataMart_2]

select 'exec proc_AddSurrogateKeyRel KenticoCMS_Datamart, BASE_CMS_user, ' + table_name +', YES' from information_schema.tables 
where table_name like 'BASE_HFit_Tracker%'
and table_name not like 'BASE_HFit_TrackerCollectionSource'
and table_name not like 'BASE_HFIT_Tracker'
and table_name not like '%_DEL'
and table_name not like '%_CTVerHist'

exec proc_AddSurrogateKeyRel KenticoCMS_Datamart, BASE_CMS_user, BASE_HFit_TrackerFlexibility, yes
exec proc_AddSurrogateKeyRel KenticoCMS_Datamart, BASE_CMS_user, BASE_HFit_TrackerSugaryDrinks, NO
*/

CREATE PROCEDURE proc_AddSurrogateKeyRel (
       @DBMS AS NVARCHAR (250) 
     , @ParentTbl AS NVARCHAR (250) 
     , @ChildTbl AS NVARCHAR (250) 
     , @PreviewOnly AS NVARCHAR (250) = 'YES') 
AS
BEGIN

    --DECLARE
    --       @DBMS AS NVARCHAR (250) 
    --     , @ParentTbl AS NVARCHAR (250) 
    --     , @ChildTbl AS NVARCHAR (250) 
    --     , @PreviewOnly AS NVARCHAR (250) = 'YES';

    -- set @ParentTbl = 'BASE_CMS_user' ;
    -- set @ChildTbl = 'BASE_HFit_TrackerSugaryDrinks' ;

    DECLARE
           @ParentSKeyName AS NVARCHAR (250) 
         , @ChildSKeyName AS NVARCHAR (250) 
         , @ForeignKeyName AS NVARCHAR (250) 
         , @PKName AS NVARCHAR (250) 
         , @MySql AS NVARCHAR (MAX) 
         , @PKIndex AS NVARCHAR (MAX) 
         , @TrigName AS NVARCHAR (250) 
         , @Msg AS NVARCHAR (4000) 
         , @iCnt AS INT;

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

    EXEC PrintImmediate 'BEGIN TRANSACTION TX001;';
    BEGIN TRANSACTION TX001;
    BEGIN TRY

        SET NOCOUNT ON;

        --SET @DBMS = 'KenticoCMS_Datamart';
        --SET @ParentTbl = 'BASE_CMS_user';
        --SET @ChildTbl = 'BASE_HFit_TrackerBMI';

        -- Get all Foreign Key DDL in the DB
        EXEC ScriptAllForeignKeyConstraints ;
        -- Get all Foreign Key tables and columns
        EXEC proc_GetTableForeignKeys @ChildTbl;

        SET @ForeignKeyName = 'FK00_' + @ParentTbl + '_To_' + @ChildTbl;
        --exec PrintImmediate '@ForeignKeyName : ' + @ForeignKeyName;

        IF EXISTS (SELECT
                          ForeignKeyName
                   FROM ##FK_Constraints
                   WHERE
                          ParentTableName = @ParentTbl AND
                          ForeignKeyName = @ForeignKeyName AND
                          SchemaName = 'dbo') 
            BEGIN
                PRINT 'NOTICE: ' + @ForeignKeyName + ' already exist between ' + @ParentTbl + ' and ' + @ChildTbl + ', aborting.';
                COMMIT TRANSACTION TX001;
                RETURN;
            END;

        IF OBJECT_ID ('TEMPDB..#PKIndexes') IS NOT NULL
            BEGIN
                DROP TABLE
                     #PKIndexes;
            END;

        -- Get all Primary Key indexes and their columns
        SELECT
               i.name AS IndexName
             , OBJECT_NAME (ic.OBJECT_ID) AS TableName
             , COL_NAME (ic.OBJECT_ID , ic.column_id) AS ColumnName
        INTO
             #PKIndexes
        FROM
             sys.indexes AS i
             INNER JOIN sys.index_columns AS ic
             ON
               i.OBJECT_ID = ic.OBJECT_ID AND
               i.index_id = ic.index_id
        WHERE
               i.is_primary_key = 1
        ORDER BY
                 ic.key_ordinal;

        -- select * from #PKIndexes 
        -- select distinct IndexName from #PKIndexes where TableName = 'BASE_HFit_TrackerBloodPressure'

        SET @PKIndex = (SELECT DISTINCT
                               IndexName
                        FROM #PKIndexes
                        WHERE
                               TableName = @ChildTbl) ;
        --PRINT '@PKIndex: ' + @PKIndex;
        IF
               CURSOR_STATUS ('global' , 'C10') >= -1
            BEGIN
                CLOSE C10;
                DEALLOCATE C10;
            END;
        IF
               CURSOR_STATUS ('global' , 'C5') >= -1
            BEGIN
                CLOSE C5;
                DEALLOCATE C5;
            END;
        IF
               CURSOR_STATUS ('global' , 'C') >= -1
            BEGIN
                CLOSE C;
                DEALLOCATE C;
            END;
        IF
               CURSOR_STATUS ('global' , 'C2') >= -1
            BEGIN
                CLOSE C2;
                DEALLOCATE C2;
            END;
        IF OBJECT_ID ('TEMPDB..#PKeys') IS NOT NULL
            BEGIN
                DROP TABLE
                     #PKeys;
            END;
        SELECT
               column_name
        INTO
             #PKeys
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE
               OBJECTPROPERTY (OBJECT_ID (CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME) , 'IsPrimaryKey') = 1 AND
               TABLE_NAME = @ChildTbl AND
               TABLE_SCHEMA = 'dbo'
        ORDER BY
                 Ordinal_Position;

        IF OBJECT_ID ('TEMPDB..#Triggers') IS NOT NULL
            BEGIN
                DROP TABLE
                     #Triggers;
            END;

        SELECT
               so.name AS trigger_name
             , USER_NAME (so.uid) AS trigger_owner
             , USER_NAME (so2.uid) AS table_schema
             , OBJECT_NAME (so.parent_obj) AS table_name
             , OBJECTPROPERTY (so.id , 'ExecIsUpdateTrigger') AS isupdate
             , OBJECTPROPERTY (so.id , 'ExecIsDeleteTrigger') AS isdelete
             , OBJECTPROPERTY (so.id , 'ExecIsInsertTrigger') AS isinsert
             , OBJECTPROPERTY (so.id , 'ExecIsAfterTrigger') AS isafter
             , OBJECTPROPERTY (so.id , 'ExecIsInsteadOfTrigger') AS isinsteadof
             , OBJECTPROPERTY (so.id , 'ExecIsTriggerDisabled') AS disabled INTO
                                                                                 #Triggers
        FROM
             sysobjects AS so
             INNER JOIN sysobjects AS so2
             ON
               so.parent_obj = so2.Id
        WHERE so.type = 'TR';

        --SELECT *
        --       FROM #Triggers
        --       WHERE table_name = @ChildTbl;

        DECLARE C CURSOR
            FOR SELECT
                       trigger_name
                FROM #Triggers
                WHERE
                       table_name = @ChildTbl;

        OPEN C;
        FETCH NEXT FROM C INTO @TrigName;

        --Disable all child table triggers
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = 'DISABLE TRIGGER [' + @TrigName + '] ON dbo.' + @ChildTbl + ';';
                SET @Msg = @MySql + ' --Step 01 of 10: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
                FETCH NEXT FROM C INTO @TrigName;
            END;

        CLOSE C;
        DEALLOCATE C;

        SET @iCnt = CHARINDEX ('BASE_' , @ChildTbl) ;
        IF @iCnt = 0
            BEGIN
                SET @iCnt = CHARINDEX ('FACT_' , @ChildTbl) ;
            END;

        --exec PrintImmediate '@iCnt: ' + CAST (@iCnt AS NVARCHAR (50)) ;
        IF @iCnt > 0
            BEGIN
                SET @ParentSKeyName = 'SurrogateKey_' + SUBSTRING (@ParentTbl , 6 , 999) ;
                SET @ChildSKeyName = 'SurrogateKey_' + SUBSTRING (@ChildTbl , 6 , 999) ;
            END;
        --PRINT '@ChildSKeyName : ' + @ChildSKeyName;

        --Remove all foreign keys
        DECLARE
               @FgnKeyNAME AS NVARCHAR (500) 
             , @GenSql AS NVARCHAR (500) 
             , @ReferencedTable AS NVARCHAR (500) 
             , @ParentTableName AS NVARCHAR (500) ;

        --*****************************************************************************************
        DECLARE C25 CURSOR
            FOR SELECT
                       ForeignKeyNAME
                     , GenSql
                     , ReferencedTable
                     , ParentTableName
                FROM ##FK_Constraints
                WHERE
                       ParentTableName = 'FACT_TrackerData' AND
                       ReferencedTable = @ChildTbl;

        --select * from ##FK_Constraints where ParentTableName = 'FACT_TrackerData'
        --select * from ##FK_Constraints where ReferencedTable = 'FACT_TrackerData'

        OPEN C25;
        FETCH NEXT FROM C25 INTO @FgnKeyNAME , @GenSql , @ReferencedTable , @ParentTableName;

        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = 'ALTER TABLE dbo.' + @ParentTableName + ' DROP CONSTRAINT ' + @FgnKeyNAME + ';';
                SET @msg = @MySql + ' -- STEP 1B: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        --if exists(SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = @FgnKeyNAME)
                        IF EXISTS (SELECT
                                          CONSTRAINT_NAME
                                   FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                   WHERE
                                          CONSTRAINT_NAME = @FgnKeyNAME) 
                            BEGIN
                                EXEC (@MySql) ;
                            END;
                        ELSE
                            BEGIN
                                PRINT 'CONSTRAINT_NAME [' + @FgnKeyNAME + '] missing, skipping.';
                            END;
                    END;
                FETCH NEXT FROM C25 INTO @FgnKeyNAME , @GenSql , @ReferencedTable , @ParentTableName;
            END;

        CLOSE C25;
        DEALLOCATE C25;
        --*****************************************************************************************

        DECLARE C5 CURSOR
            FOR SELECT
                       ForeignKeyNAME
                     , GenSql
                     , ReferencedTable
                     , ParentTableName
                FROM ##FK_Constraints
                WHERE
                       ReferencedTable = @ChildTbl; -- or ReferencedTable ;
        -- ParentTableName = @ChildTbl ; -- or ReferencedTable ;

        OPEN C5;
        FETCH NEXT FROM C5 INTO @FgnKeyNAME , @GenSql , @ReferencedTable , @ParentTableName;

        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                -- ALTER TABLE dbo.BASE_HFit_TrackerSugaryDrinks DROP CONSTRAINT PKey_BASE_HFit_TrackerSugaryDrinks; 
                SET @MySql = 'ALTER TABLE dbo.' + @ParentTableName + ' DROP CONSTRAINT ' + @FgnKeyNAME + ';';
                SET @Msg = @MySql + ' -- STEP 1B: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        IF EXISTS (SELECT
                                          CONSTRAINT_NAME
                                   FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                   WHERE
                                          CONSTRAINT_NAME = @FgnKeyNAME) 
                            BEGIN
                                EXEC (@MySql) ;
                            END;
                        ELSE
                            BEGIN
                                PRINT 'CONSTRAINT_NAME [' + @FgnKeyNAME + '] missing, skipping.';
                            END;
                    END;
                FETCH NEXT FROM C5 INTO @FgnKeyNAME , @GenSql , @ReferencedTable , @ParentTableName;
            END;

        CLOSE C5;
        DEALLOCATE C5;

        --PRINT 'Surrogate key, ' + @ParentSKeyName + ' being added to ' + @ChildTbl;
        -- turn off change tracking
        SET @MySql = 'ALTER TABLE dbo.' + @ChildTbl + ' DISABLE CHANGE_TRACKING' + ';';
        SET @Msg = @MySql + '   --Step 02 of 10: ';
        EXEC PrintImmediate  @Msg;
        IF
               @PreviewOnly != 'YES'
            BEGIN
                BEGIN TRY
                    EXEC (@MySql) ;
                END TRY
                BEGIN CATCH
                    PRINT 'NOTICE: ' + @MySql;
                END CATCH;
            END;

        IF NOT EXISTS (SELECT
                              column_name
                       FROM information_schema.columns
                       WHERE
                              table_name = @ChildTbl AND
                              column_name = @ParentSKeyName) 
            BEGIN

                -- Return the name of primary key.
                SET @PKName = (SELECT
                                      name
                               FROM sys.key_constraints
                               WHERE
                               type = 'PK' AND
                                      OBJECT_NAME (parent_object_id) = @ChildTbl) ;
                --PRINT '@PKName: ' + @PKName;
                -- Remove the existing Primary Key
                SET @MySql = 'ALTER TABLE dbo.' + @ChildTbl + ' DROP CONSTRAINT ' + @PKName + ';';
                SET @Msg = @MySql + '   --Step 03 of 10: ';
                EXEC PrintImmediate  @Msg;

                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        IF EXISTS (SELECT
                                          CONSTRAINT_NAME
                                   FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                   WHERE
                                          CONSTRAINT_NAME = @FgnKeyNAME) 
                            BEGIN
                                EXEC (@MySql) ;
                            END;
                        ELSE
                            BEGIN
                                PRINT 'CONSTRAINT_NAME [' + @FgnKeyNAME + '] missing, skipping.';
                            END;
                    END;

                --PRINT '@ChildTbl: ' + @ChildTbl;
                --PRINT '@ChildSKeyName: ' + @ChildSKeyName;

                SET @MySql = 'alter table ' + @ChildTbl + ' add ' + @ParentSKeyName + ' bigint not null default 0 ;';
                SET @Msg = @MySql + '   --Step 04 of 10: ';
                EXEC PrintImmediate  @Msg;

                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        IF NOT EXISTS (SELECT
                                              column_name
                                       FROM information_schema.columns
                                       WHERE
                                              table_name = @ChildTbl AND
                                              column_name = @ParentSKeyName) 
                            BEGIN
                                EXEC (@MySql) ;
                            END;
                    END;
            END;
        ELSE
            BEGIN
                PRINT '-- Surrogate key, ' + @ParentSKeyName + ' already exist in ' + @ChildTbl;
            END;

        SET @MySql = '';
        SET @MySql = @MySql + 'UPDATE ChildTbl SET ChildTbl.' + @ParentSKeyName + ' = ParentTbl.' + @ParentSKeyName + CHAR (10) ;
        SET @MySql = @MySql + 'FROM ' + CHAR (10) ;
        SET @MySql = @MySql + '    ' + @ChildTbl + ' as ChildTbl ' + CHAR (10) ;
        SET @MySql = @MySql + '    JOIN ' + CHAR (10) ;
        SET @MySql = @MySql + '    ' + @ParentTbl + ' as ParentTbl ON  ' + CHAR (10) ;
        SET @MySql = @MySql + '	   ChildTbl.svr=ParentTbl.svr ' + CHAR (10) ;
        SET @MySql = @MySql + '    and ChildTbl.dbname=ParentTbl.dbname ' + CHAR (10) ;
        SET @MySql = @MySql + '    and ChildTbl.userid=ParentTbl.userid ;' + CHAR (10) ;
        SET @Msg = @MySql + '   --Step 05 of 10: ';
        EXEC PrintImmediate  @Msg;

        IF
               @PreviewOnly != 'YES'
            BEGIN
                EXEC (@MySql) ;
            END;

        DECLARE
               @ActualNumberOfResults AS BIGINT;
        DECLARE
               @rowcount TABLE (
                               Value BIGINT) ;

        --SET @MySql = 'select count(*) from ' + @ChildTbl + ' where SurrogateKey_CMS_user not in (select SurrogateKey_CMS_user from BASE_CMS_user) ;';
        --PRINT @MySql;
        --INSERT INTO @rowcount
        --EXEC (@MySql) ;
        --SELECT
        --       @ActualNumberOfResults = Value
        --FROM @rowcount;
        --PRINT '-- RECORDS Found violating RI: ' + cast (@ActualNumberOfResults AS NVARCHAR (50)) + ', and MUST be removed.';

        --ENABLE all table triggers
        DECLARE C2 CURSOR
            FOR SELECT
                       trigger_name
                FROM #Triggers
                WHERE
                       table_name = @ChildTbl;

        OPEN C2;
        FETCH NEXT FROM C2 INTO @TrigName;
        --Disable all child table triggers
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = 'ENABLE TRIGGER [' + @TrigName + '] ON dbo.' + @ChildTbl + ';';
                SET @Msg = @MySql + '   --Step 10 of 10: ';
                EXEC PrintImmediate  @Msg;

                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
                FETCH NEXT FROM C2 INTO @TrigName;
            END;
        CLOSE C2;
        DEALLOCATE C2;

        DECLARE
               @iOrphans AS BIGINT = 0;

        SET @MySql = 'delete from ' + @ChildTbl + ' where ' + @ParentSKeyName + ' not in (select ' + @ParentSKeyName + ' from ' + @ParentTbl + ') ;';
        SET @Msg = @MySql + '   --Step 05b of 10: ';
        EXEC PrintImmediate  @Msg;
        IF
               @PreviewOnly != 'YES'
            BEGIN
                EXEC (@MySql) ;
                SET @iOrphans = @@RowCount;
                SET @Msg = 'ORPHAN Count: ' + cast (@iOrphans AS NVARCHAR (50)) ;
                EXEC PrintImmediate @Msg;

                INSERT INTO MART_Orphan_Rec_Log (
                       ParentTableName
                     , TableName
                     , LogText
                     , OrphanCnt) 
                VALUES (@ParentTbl , @ChildTbl , 'ORPHANS found.' , @iOrphans) ;

            END;
        --Create NEW Primary Keys on Parent and Child
        --Add the CHILD PKEY
        --SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'BASE_HFit_TrackerBMI' and constraint_name ='PKey_BASE_HFit_TrackerBMI'  AND CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_SCHEMA ='dbo'
        DECLARE
               @PK_ChildNAME AS NVARCHAR (500) = 'PK00_' + @ChildTbl;
        DECLARE
               @PK_Curr AS NVARCHAR (500) = (SELECT
                                                    constraint_name
                                             FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                             WHERE
                                                    TABLE_NAME = @ChildTbl
                                                    --AND constraint_name = @PK_ChildNAME 
                                                    AND
                                                    CONSTRAINT_TYPE = 'PRIMARY KEY' AND
                                                    TABLE_SCHEMA = 'dbo') ;
        IF @PK_Curr IS NOT NULL
            BEGIN
                EXEC PrintImmediate 'RESETTING Primary key to Surrogate key.';
                SET @MySql = 'ALTER TABLE dbo.' + @ChildTbl + ' DROP CONSTRAINT ' + @PK_Curr + ';';
                SET @Msg = @MySql + '   --Step 05c of 10: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        EXEC (@MySql) ;
                    END;

            END;
        ELSE
            BEGIN
                EXEC PrintImmediate 'NO Primary key on Surrogate key, adding';
            END;

        IF NOT EXISTS (SELECT
                              constraint_name
                       FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                       WHERE
                              TABLE_NAME = @ChildTbl AND --constraint_name = @PK_ChildNAME AND
                              CONSTRAINT_TYPE = 'PRIMARY KEY' AND
                              TABLE_SCHEMA = 'dbo') 
            BEGIN
                SET @MySql = 'ALTER TABLE dbo.' + @ChildTbl + ' ADD CONSTRAINT PK00_' + @ChildTbl + ' PRIMARY KEY CLUSTERED (' + @ChildSKeyName + ') ;';
                SET @Msg = @MySql + '   --Step 06 of 10: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
            END;
        --Add the PARENT PKEY
        DECLARE
               @PK_ParentNAME AS NVARCHAR (500) = 'PKEY_' + @ParentTbl;
        IF NOT EXISTS (SELECT
                              *
                       FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                       WHERE
                              CONSTRAINT_TYPE = 'PRIMARY KEY' AND --constraint_name = @PK_ParentNAME AND
                              constraint_name = 'PKEY_BASE_cms_user' AND
                              TABLE_NAME = @ParentTbl AND
                              TABLE_SCHEMA = 'dbo') 
            BEGIN
                SET @MySql = '';
                SET @MySql = @MySql + 'ALTER TABLE dbo.' + @ParentTbl + ' ADD CONSTRAINT PK00_' + @ParentTbl + ' PRIMARY KEY CLUSTERED (' + @ParentSKeyName + ') ;';
                SET @Msg = @MySql + '   --Step 07 of 10: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
            END;

        --Add the FOREIGN KEY
        SET @ForeignKeyName = 'FK00_' + @ParentTbl + '_To_' + @ChildTbl;
        --PRINT '@ForeignKeyName : ' + @ForeignKeyName;

        IF NOT EXISTS (SELECT
                              CONSTRAINT_NAME
                       FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
                       WHERE
                              CONSTRAINT_NAME = @ForeignKeyName) 
            BEGIN
                --ALTER TABLE BASE_HFit_TrackerSugaryDrinks ADD CONSTRAINT FK00_BASE_CMS_user_To_BASE_HFit_TrackerSugaryDrinks FOREIGN KEY(SurrogateKey_CMS_user) REFERENCES BASE_CMS_user (SurrogateKey_CMS_user) ;  --Step 08 of 10: 
                SET @MySql = '';
                SET @MySql = @MySql + 'ALTER TABLE ' + @ChildTbl + ' ADD CONSTRAINT ' + @ForeignKeyName + ' FOREIGN KEY(' + @ParentSKeyName + ') REFERENCES ' + @ParentTbl + ' (' + @ParentSKeyName + ') ;';
                SET @Msg = @MySql + '   --Step 08 of 10: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        EXEC (@MySql) ;
                    END;
            END;

        -- ADD New UNIQUE Primary Key
        DECLARE
               @PK AS NVARCHAR (2000) = NULL
             , @PKX AS NVARCHAR (2000) = NULL;
        EXEC procGetTablePK @DBMS , @ChildTbl , @PK OUT;
        --PRINT '@PK: ' + @PK;

        SET @PKX = 'UK00_' + @ChildTbl;

        SET @MySql = 'CREATE unique NONCLUSTERED INDEX [UK00_' + @ChildTbl + '] ON [dbo].[' + @ChildTbl + '] ';
        SET @MySql = @MySql + '( ';
        SET @MySql = @MySql + @PK;
        SET @MySql = @MySql + ') ;';
        SET @Msg = @MySql + '   --Step 09 of 10: ';
        EXEC PrintImmediate  @Msg;
        IF
               @PreviewOnly != 'YES'
            BEGIN
                IF NOT EXISTS (SELECT
                                      name
                               FROM sys.indexes
                               WHERE name = @PKX) 
                    BEGIN
                        EXEC (@MySql) ;
                    END;
            END;

        DECLARE
               @FgnKeyNAME2 AS NVARCHAR (500) 
             , @GenSql2 AS NVARCHAR (500) ;
        DECLARE C10 CURSOR
            FOR SELECT
                       ForeignKeyNAME
                     , GenSql
                FROM ##FK_Constraints
                WHERE
                       ParentTableName = @ChildTbl;

        OPEN C10;
        FETCH NEXT FROM C10 INTO @FgnKeyNAME2 , @GenSql2;

        --ALTER TABLE [dbo].[BASE_HFit_TrackerBloodPressure] WITH CHECK ADD CONSTRAINT [FK00_BASE_CMS_user_To_BASE_HFit_TrackerBloodPressure] FOREIGN KEY([SurrogateKey_cms_user]) 
        --REFERENCES [dbo].[BASE_cms_user] ([SurrogateKey_cms_user])    --Step 10b of 10: 
        WHILE
               @@FETCH_STATUS = 0
            BEGIN
                SET @MySql = @GenSql2;
                SET @Msg = @MySql + '   --Step 10b of 10: ';
                EXEC PrintImmediate  @Msg;
                IF
                       @PreviewOnly != 'YES'
                    BEGIN
                        IF NOT EXISTS (SELECT
                                              CONSTRAINT_NAME
                                       FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                       WHERE
                                              CONSTRAINT_NAME = @FgnKeyNAME2) 
                            BEGIN
                                EXEC (@MySql) ;
                            END;
                        ELSE
                            BEGIN
                                SET @Msg = @FgnKeyNAME2 + ' already exists, skipping.';
                                EXEC PrintImmediate @Msg;
                            END;
                    END;
                FETCH NEXT FROM C10 INTO @FgnKeyNAME2 , @GenSql2;
            END;

        CLOSE C10;
        DEALLOCATE C10;

        SET @MySql = 'ALTER TABLE dbo.' + @ChildTbl + ' ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = ON) ';
        EXEC PrintImmediate @MySql;

        EXEC @iCnt = proc_ckChangeTracking 'dbo' , @ChildTbl;

        IF
               @PreviewOnly != 'YES'
            BEGIN
                BEGIN TRY
                    IF @iCnt = 0
                        BEGIN
                            EXEC (@MySql) ;
                        END;
                END TRY
                BEGIN CATCH
                    PRINT 'Change Tracking turned on for: ' + @ChildTbl;
                END CATCH;
            END;
        EXEC PrintImmediate 'COMMIT TRANSACTION TX001;';
        COMMIT TRANSACTION TX001;
    END TRY
    BEGIN CATCH
        EXEC usp_GetErrorInfo ;
        SET @msg = 'ERROR: ' + @Mysql;
        EXEC PrintImmediate @msg;
        ROLLBACK TRANSACTION TX001;
    END CATCH;

    SET NOCOUNT ON;
END;
GO
PRINT 'Executed proc_AddSurrogateKeyRel.sql';
GO