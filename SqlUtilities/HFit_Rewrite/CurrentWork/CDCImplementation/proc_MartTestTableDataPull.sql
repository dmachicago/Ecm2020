
-- Use KenticoCMS_Datamart_2
GO
PRINT 'Executing proc_MartTestTableDataPull.sql';
GO

IF EXISTS (SELECT *
             FROM sys.procedures
             WHERE name = 'proc_MartTestTableDataPull') 
    BEGIN
        DROP PROCEDURE proc_MartTestTableDataPull;
    END;
GO
IF EXISTS (SELECT *
             FROM sys.procedures
             WHERE name = 'proc_MartTestTableDataPullMASTER') 
    BEGIN
        DROP PROCEDURE proc_MartTestTableDataPullMASTER;
    END;
GO
-- Use KenticoCMS_Datamart_2
-- truncate table MART_CT_Test_History
-- select * from MART_CT_Test_History
-- exec proc_MartTestTableDataPullMASTER 10, 1
-- exec proc_MartTestTableDataPullMASTER 25, 0
CREATE PROCEDURE proc_MartTestTableDataPullMASTER (@MaxTablesToProcess AS int = NULL , 
                                                   @PreviewOnly AS bit = 0 , 
                                                   @SkipToNumber AS int = 0 , 
                                                   @SkipIfTested AS int = 1) 
AS
BEGIN
    SET NOCOUNT ON;

    IF CURSOR_STATUS ('global' , 'CTESTGEN') >= -1
        BEGIN
            CLOSE CTESTGEN;
            DEALLOCATE CTESTGEN;
        END;
    --HFit_RewardAboutInfoItem
    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'MART_CT_Test_TablesToSkip') 
        BEGIN
            CREATE TABLE MART_CT_Test_TablesToSkip (TblName nvarchar (100) NOT NULL) ;
        END;
    -- insert into MART_CT_Test_TablesToSkip (TblName) values ( 'BASE_HFit_RewardAboutInfoItem')



    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'MART_CT_Test_Completed') 
        BEGIN
            CREATE TABLE MART_CT_Test_Completed (DBNAME nvarchar (100) NOT NULL , 
                                                 TblName nvarchar (100) NOT NULL , 
                                                 RecCount bigint NULL , 
                                                 InsCount bigint NULL , 
                                                 DelCount bigint NULL , 
                                                 UpdtCount bigint NULL , 
                                                 HistCount bigint NULL , 
                                                 StartDate datetime NOT NULL
                                                                    DEFAULT GETDATE () , 
                                                 EndDate datetime NULL , 
                                                 CMD nvarchar (4000) NULL , 
                                                 RowID uniqueidentifier DEFAULT NEWID ()) ;
        END;

    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'MART_CT_Test_History') 
        BEGIN
            CREATE TABLE MART_CT_Test_History (DBNAME nvarchar (100) NOT NULL , 
                                               TblName nvarchar (100) NOT NULL , 
                                               RecCount bigint NULL , 
                                               StartDate datetime NOT NULL
                                                                  DEFAULT GETDATE () , 
                                               EndDate datetime NULL , 
                                               RowID uniqueidentifier DEFAULT NEWID ()) ;
        END;
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = 'PKI_MART_CT_Test_History') 
        BEGIN
            CREATE UNIQUE CLUSTERED INDEX PKI_MART_CT_Test_History ON MART_CT_Test_History (TblName , RowID) ;
        END;

    DECLARE
          @MySql AS nvarchar (max) , 
          @UID AS uniqueidentifier , 
          @TotCnt AS bigint , 
          @i AS int = 0 , 
          @Table_Name AS nvarchar (250) , 
          @DBNAME AS nvarchar (250) , 
          @CMD AS nvarchar (max) = '' , 
          @Msg AS nvarchar (max) = '';

    SET @TotCnt = (SELECT COUNT (*)
                     FROM information_schema.tables
                     WHERE table_name LIKE 'BASE_%'
                       AND table_name NOT LIKE '%_DEL'
                       AND table_name NOT LIKE '%_VerHist'
                       AND table_name NOT LIKE '%_view_%'
                       AND table_name NOT LIKE 'View_%'
                       AND table_name NOT LIKE '%_TESTDATA') * 3;
    PRINT @TotCnt;
    DECLARE CTESTGEN CURSOR
        FOR SELECT 'KenticoCMS_1' AS DBNAME , 
                   table_name , 
                   'exec proc_MartTestTableDataPull "KenticoCMS_1","' + table_name + '" , 10, ' + CAST (@PreviewOnly AS nvarchar (10)) AS CMD
              FROM information_schema.tables
              WHERE table_name LIKE 'BASE_%'
                AND table_name NOT LIKE '%_DEL'
                AND table_name NOT LIKE '%_VerHist'
                AND table_name NOT LIKE '%_view_%'
                AND table_name NOT LIKE 'View_%'
                AND table_name NOT LIKE '%_TESTDATA'
            UNION
            SELECT 'KenticoCMS_2' AS DBNAME , 
                   table_name , 
                   'exec proc_MartTestTableDataPull "KenticoCMS_2","' + table_name + '" , 10,  ' + CAST (@PreviewOnly AS nvarchar (10)) AS CMD
              FROM information_schema.tables
              WHERE table_name LIKE 'BASE_%'
                AND table_name NOT LIKE '%_DEL'
                AND table_name NOT LIKE '%_VerHist'
                AND table_name NOT LIKE '%_view_%'
                AND table_name NOT LIKE 'View_%'
                AND table_name NOT LIKE '%_TESTDATA'
            UNION
            SELECT 'KenticoCMS_3' AS DBNAME , 
                   table_name , 
                   'exec proc_MartTestTableDataPull "KenticoCMS_3","' + table_name + '" , 10,  ' + CAST (@PreviewOnly AS nvarchar (10)) AS CMD
              FROM information_schema.tables
              WHERE table_name LIKE 'BASE_%'
                AND table_name NOT LIKE '%_DEL'
                AND table_name NOT LIKE '%_VerHist'
                AND table_name NOT LIKE '%_view_%'
                AND table_name NOT LIKE 'View_%'
                AND table_name NOT LIKE '%_TESTDATA';

    OPEN CTESTGEN;
    FETCH NEXT FROM CTESTGEN INTO @DBNAME , @Table_Name , @CMD;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @i = @i + 1;
            SET @UID = NEWID () ;

            IF EXISTS (SELECT TblName
                         FROM MART_CT_Test_TablesToSkip
                         WHERE TblName = @Table_Name) 
                BEGIN
				SET @Msg = @DBNAME + '.' + @Table_Name + ' contained in REJECT LIST, skipping.';
                    EXEC PrintImmediate @Msg;
                    GOTO GETNEXT
                END;

            IF EXISTS (SELECT TblName
                         FROM MART_CT_Test_Completed
                         WHERE DBNAME = @DBNAME
                           AND TblName = @Table_Name
                           AND EndDate IS NOT NULL)
           AND @SkipIfTested = 1
                BEGIN
                    SET @Msg = @DBNAME + '.' + @Table_Name + ' previously tested, skipping.';
                    EXEC PrintImmediate @Msg;
                    GOTO GETNEXT;
                END;
            ELSE
                BEGIN
                    INSERT INTO MART_CT_Test_Completed (DBNAME , 
                                                        TblName , 
                                                        StartDate , 
                                                        EndDate , 
                                                        RowID) 
                    VALUES (@DBNAME , 
                            @Table_Name , 
                            GETDATE () , 
                            NULL , 
                            @UID) ;
                END;

            IF @SkipToNumber > 0
                BEGIN
                    IF @SkipToNumber > @i
                        BEGIN
                            GOTO GETNEXT;
                        END;
                END;
            IF @MaxTablesToProcess IS NOT NULL
                BEGIN
                    IF @i > @MaxTablesToProcess
                        BEGIN
                            SET @Msg = '--******************************************************************************************';
                            EXEC PrintImmediate @Msg;
                            PRINT 'RUN COMPLETE - Max Tables to Process encountered, exiting.';
                            EXEC PrintImmediate @Msg;
                            RETURN;
                        END;
                END;

            IF NOT EXISTS (SELECT TblName
                             FROM MART_CT_Test_Completed
                             WHERE DBNAME = @DBNAME
                               AND TblName = @Table_Name) 
                BEGIN
                    INSERT INTO MART_CT_Test_Completed (DBNAME , 
                                                        TblName , 
                                                        StartDate , 
                                                        EndDate , 
                                                        RowID) 
                    VALUES (@DBNAME , 
                            @Table_Name , 
                            GETDATE () , 
                            NULL , 
                            @UID) ;
                END;

            SET @Msg = '--******************************************************************************************';
            EXEC PrintImmediate @Msg;
            SET @Msg = 'Processing: ' + @DBNAME + ' / ' + @Table_Name + ' : ' + CAST (@i AS nvarchar (50)) + ' of ' + CAST (@TotCnt AS nvarchar (50)) ;
            EXEC PrintImmediate @Msg;
            SET @Msg = 'START TIME: ' + CAST (GETDATE () AS nvarchar (50)) ;
            EXEC PrintImmediate @Msg;

            IF @PreviewOnly = 0
                BEGIN
                    INSERT INTO MART_CT_Test_History (DBNAME , 
                                                      TblName , 
                                                      StartDate , 
                                                      EndDate , 
                                                      RowID) 
                    VALUES (@DBNAME , 
                            @Table_Name , 
                            GETDATE () , 
                            NULL , 
                            @UID) ;
                END;

            IF @PreviewOnly = 1
                BEGIN EXEC PrintImmediate @CMD;
                END;
            ELSE
                BEGIN
                    IF EXISTS (SELECT TblName
                                 FROM MART_CT_Test_Completed
                                 WHERE DBNAME = @DBNAME
                                   AND TblName = @Table_Name) 
                        BEGIN
                            UPDATE MART_CT_Test_Completed
                              SET CMD = @CMD
                              WHERE RowID = @UID;
                        END;
                    --*************************
                    EXEC (@CMD) ;
                --*************************
                END;

            SET @Msg = 'END TIME: ' + CAST (GETDATE () AS nvarchar (50)) ;
            EXEC PrintImmediate @Msg;

            IF @PreviewOnly = 0
                BEGIN
                    UPDATE MART_CT_Test_History
                      SET EndDate = GETDATE ()
                      WHERE RowID = @UID;

                    IF EXISTS (SELECT TblName
                                 FROM MART_CT_Test_Completed
                                 WHERE DBNAME = @DBNAME
                                   AND TblName = @Table_Name) 
                        BEGIN
                            UPDATE MART_CT_Test_Completed
                              SET EndDate = GETDATE ()
                              WHERE RowID = @UID;
                        END;
                END;

            GETNEXT:
            FETCH NEXT FROM CTESTGEN INTO @DBNAME , @Table_Name , @CMD;
        END;

    CLOSE CTESTGEN;
    DEALLOCATE CTESTGEN;
    SET NOCOUNT OFF;
END;
GO

/**************************************************************************************************************
 Use KenticoCMS_datamart_2

--Use this to generate TEST commands
select 'exec proc_MartTestTableDataPull "KenticoCMS_3","'  + table_name + '" , 10, 1' + char(10) + 'GO'  as CMD
from information_schema.tables 
where table_name like 'BASE_%'
and table_name not like '%_DEL'
and table_name not like '%_VerHist'
and table_name not like '%_view_%'
and table_name not like 'View_%'
and table_name not like '%_TESTDATA'

--Use this to generate TEST commands
select * from information_schema.tables where table_name like '%_TESTDATA'
**************************************************************************************************************/

CREATE PROCEDURE proc_MartTestTableDataPull (@InstanceName AS nvarchar (250) , 
                                             @TblName AS nvarchar (250) , 
                                             @NbrRecsToUpdate int = 2 , 
                                             @PreviewOnly AS bit = 0 , 
                                             @RowID AS uniqueidentifier = NULL) 
AS
BEGIN
    -- AUthor:	 W. Dale Miller
    -- Contact: wdalemiller@gmail.com
    -- Date:	 03.17.2016
    -- Parms:
    --		 @InstanceName	  - database name
    --		 @TblName		  - table to test and associated procedures
    --		 @NbrRecsToUpdate- how many records to modify in the test
    --		 @PreviewOnly	  - Set to 1 to ONLY proint the statements that will execute.
    -- Use:	 exec proc_MartTestTableDataPull 'KenticoCMS_1', 'BASE_HFit_HealthAssesmentUserStarted', 100, 1	 

    SET NOCOUNT ON;
    DECLARE
          @i AS int = 0 , 
          @MySql nvarchar (max) = '' , 
          @TSql nvarchar (max) = '' , 
          @Fqn nvarchar (max) = '' , 
          @Type nvarchar (50) = '' , 
          @ProcNameInsert nvarchar (250) = '' , 
          @ProcNameDel nvarchar (250) = '' , 
          @ProcNameApply nvarchar (250) = '' , 
          @ExecCTApplySQL nvarchar (250) = '' , 
          @SrcTbl nvarchar (250) = '' , 
          @VerTbl nvarchar (250) = '' , 
          @IdentCol nvarchar (250) = '' , 
          @ViewName nvarchar (250) = '' , 
          @ColToUpdate nvarchar (250) = '' , 
          @TestTblName nvarchar (250) = '' , 
          @VerNbr bigint = 0 , 
          @ContainsItemID bit = 0 , 
          @LastModifiedDate AS datetime = GETDATE () ;

    SET @TestTblName = @TblName + '_TESTDATA';

    PRINT '-- USE KenticoCMS_Datamart_2 ';
    PRINT '-- Number of ROWS to test: ' + CAST (@NbrRecsToUpdate AS nvarchar (50)) ;
    PRINT '-- STEP 1 - remove existing ' + @TestTblName + '.';
    IF @PreviewOnly = 1
        BEGIN
            PRINT 'IF EXISTS (SELECT name FROM sys.tables WHERE name = ''' + @TestTblName + ''')';
            PRINT '     drop table ' + @TestTblName;
        END;

    IF EXISTS (SELECT name
                 FROM sys.tables
                 WHERE name = @TestTblName) 
        BEGIN
            SET @MySQl = 'DROP TABLE ' + @TestTblName;
            EXEC (@MySql) ;
        END;

    SET @i = (SELECT COUNT (*)
                FROM information_schema.tables
                WHERE table_name = 'MART_Tests_Criteria'
                  AND TABLE_TYPE = 'BASE TABLE') ;
    IF @i = 0
        BEGIN
            CREATE TABLE MART_Tests_Criteria (ParentName nvarchar (250) , 
                                              TestSql nvarchar (max) , 
                                              TestDate datetime DEFAULT GETDATE () , 
                                              RowID int IDENTITY (1 , 1) 
                                                        NOT NULL) ;
            CREATE UNIQUE CLUSTERED INDEX PKIDX_MART_Tests_Criteria ON MART_Tests_Criteria (ParentName , RowID) ;
        END;

    SET @Type = (SELECT TABLE_TYPE
                   FROM information_schema.tables
                   WHERE table_name = @TblName) ;
    IF @Type IS NULL
        BEGIN
            PRINT @TblName + ': DOES NOT EXIST, Aborting.';
            RETURN;
        END;

    SET @SrcTbl = SUBSTRING (@TblName , 6 , 99999) ;
    SET @Fqn = @InstanceName + '.dbo.' + @SrcTbl;

    IF @Type = 'BASE TABLE'
        BEGIN
            SET @ProcNameApply = 'PROC_' + @TblName + '_' + @InstanceName + '_' + 'ApplyCT';
        END;
    ELSE
        BEGIN
            IF @Type = 'VIEW'
                BEGIN
                    --proc_view_EDW_CoachingDefinition_KenticoCMS_1
                    --BASE_view_ToDoCoachingEnrollment
                    SET @ViewName = SUBSTRING (@TblName , 6 , 999) ;
                    SET @ProcNameApply = 'PROC_' + SUBSTRING (@TblName , 6 , 999) + '_' + @InstanceName;
                END;
            ELSE
                BEGIN
                    PRINT @TblName + ', DOES NOT seem to be a table or view, aborting';
                    RETURN;
                END;
        END;

    SET @ExecCTApplySQL = 'EXEC ' + @ProcNameApply;

    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @ProcNameApply) 
        BEGIN
            PRINT 'PROC ' + @ProcNameApply + ', DOES NOT EXISTS, Aborting';
            RETURN;
        END;

    --** INSERT NEW DATA INTO TEST TABLE
    SET @MySql = 'select top ' + CAST (@NbrRecsToUpdate AS nvarchar (50)) + ' * into ' + @TestTblName + ' from ' + @InstanceName + '.dbo.' + @SrcTbl;

    IF @PreviewOnly = 1
        BEGIN
            PRINT '-- STEP 1a - INSERT NEW DATA INTO TEST TABLE';
            PRINT @MySQl;
        END;

    --******************************************************
    EXEC (@MySql) ;
    EXEC proc_RemoveNotNullCols @TestTblName;
    EXEC proc_RemoveIdentityCols @TestTblName;
    --******************************************************

    DECLARE
          @TIdenCol AS TABLE (ColName nvarchar (250)) ;

    SET @MySql = 'select top 1 column_name from ' + @InstanceName + '.information_schema.KEY_COLUMN_USAGE where table_name = ''' + @SrcTbl + '''';
    IF @PreviewONly = 1
        BEGIN
            PRINT '-- STEP 2 - find IDENT col name in PROD table';
            PRINT @MySql;
        END;

    INSERT INTO @TIdenCol
    EXEC (@MySql) ;
    SET @IdentCol = (SELECT TOP 1 ColName
                       FROM @TIdenCol) ;
    IF @PreviewOnly = 1
        BEGIN
            PRINT '-- STEP 3 - Max Ident COL NAME';
            PRINT '-- @IdentCol: ' + @IdentCol;
        END;

    IF @Type = 'BASE TABLE'
        BEGIN

            DECLARE
                  @KeyDataTypeCnt AS int = 0;
            DECLARE
                  @KeyDataType AS nvarchar (50) = '';
            DECLARE
                  @DT_SQL AS nvarchar (1000) = '';
            CREATE TABLE #DTYPE (DT nvarchar (50)) ;

            SET @DT_SQL = 'insert into #DTYPE SELECT cols.DATA_TYPE FROM KenticoCMS_1.INFORMATION_SCHEMA.columns COLS
join ' + @InstanceName + '.INFORMATION_SCHEMA.KEY_COLUMN_USAGE CONS
    on COLS.Table_name = CONS.Table_name 
    and COLS.column_name = CONS.column_name
    AND COLS.TABLE_NAME = ''' + @SrcTbl + ''' AND COLS.TABLE_SCHEMA =''dbo'' ';

            PRINT '@DT_SQL: ';
            PRINT @DT_SQL;
            EXEC (@DT_SQL) ;

            SET @KeyDataTypeCnt = (SELECT COUNT (*) FROM #DTYPE) ;

            IF @KeyDataTypeCnt = 0
                BEGIN
                    SET @KeyDataType = NULL;
                END;
            ELSE
                BEGIN
                    IF @KeyDataTypeCnt = 1
                        BEGIN
                            SET @KeyDataType = (SELECT TOP 1 * FROM #DTYPE) ;
                        END;
                END;

            DECLARE
                  @QSql AS nvarchar (500) = '';
            SET @QSql = 'SELECT TOP 1 column_name FROM information_Schema.columns
                                WHERE table_name = ''' + @TblName + ''' AND data_type IN (''char'', ''nchar'', ''varchar'', ''nvarchar'') 
						  AND column_name NOT LIKE ''Action'' ';

            PRINT '@QSql: ' + @QSql;

            CREATE TABLE #TempCol (ColName varchar (250)) ;
            INSERT INTO #TempCol
            EXEC sp_executeSQL @QSql;
            SET @ColToUpdate = (SELECT * FROM #TempCol) ;

            PRINT '-- @ColToUpdate: ' + @ColToUpdate;

            DROP TABLE #TempCol;

            --SET @ColToUpdate = (SELECT TOP 1
            --                           column_name
            --                    FROM information_Schema.columns
            --                    WHERE
            --                           table_name = @TblName AND data_type IN ('char', 'nchar', 'varchar', 'nvarchar') AND column_name NOT LIKE 'Action') ;

            IF @ColToUpdate IS NULL
                BEGIN
                    PRINT '+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+';
                    PRINT 'WARNING: No character column found in ' + @SrcTbl + ', aborting test.';
                    PRINT '+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+';
                    RETURN;
                END;
            IF EXISTS (SELECT column_name
                         FROM information_Schema.columns
                         WHERE table_name = @TblName
                           AND column_name = 'ItemiD') 
                BEGIN
                    SET @ContainsItemID = 1;
                    SET @MySql = 'Update ' + @InstanceName + '.dbo.' + @SrcTbl + ' set ' + @ColToUpdate + ' = upper(' + @ColToUpdate + ') where ItemId in (select top ' + CAST (@NbrRecsToUpdate AS nvarchar (50)) + ' ItemID from ' + @InstanceName + '.dbo.' + @SrcTbl + ') ';
                END;
            ELSE
                BEGIN
                    IF @IdentCol IS NOT NULL
                        BEGIN
                            SET @ContainsItemID = 0;
                            SET @MySql = 'Update ' + @InstanceName + '.dbo.' + @SrcTbl + ' set ' + @ColToUpdate + ' = upper(' + @ColToUpdate + ') where ' + @IdentCol + ' in (select top ' + CAST (@NbrRecsToUpdate AS nvarchar (50)) + ' ' + @IdentCol + ' from ' + @InstanceName + '.dbo.' + @SrcTbl + ') ';
                        END;
                    ELSE
                        BEGIN
                            SET @ContainsItemID = 0;
                            SET @MySql = 'Update ' + @InstanceName + '.dbo.' + @SrcTbl + ' set ' + @ColToUpdate + ' = upper(' + @ColToUpdate + ') where ItemId in (select top ' + CAST (@NbrRecsToUpdate AS nvarchar (50)) + ' ' + @ColToUpdate + ' from ' + @InstanceName + '.dbo.' + @SrcTbl + ') ';
                        END;
                END;

            PRINT '-- STEP 4 - UPDATE THE PROD DATA';
            PRINT @MySql;
            IF @PreviewOnly = 0
                BEGIN EXEC (@MySql) ;
                END;
            SET @MySql = 'Exec ' + @ProcNameApply;
            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 5 - EXECUTE THE PULL PROC';
                    PRINT @MySql;
                END;
            IF @PreviewOnly != 1
                BEGIN
                    PRINT '-- STEP 5a - READ THE NEW UPDATES';
                    EXEC (@MySql) ;
                    PRINT '-- STEP 5b - SAVE the test criteria';
                    INSERT INTO MART_Tests_Criteria (ParentName , 
                                                     TestSql , 
                                                     TestDate) 
                    VALUES (@TblName , 
                            @MySql , 
                            GETDATE ()) ;
                END;

            --***************************** PERFORM DELETE *****************************
            SET @MySql = 'Delete from ' + @fqn + ' where ' + @IdentCol + ' in (select ' + @IdentCol + ' from ' + @TestTblName + ')';
            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 5c - DELETE DATA FROM PROD TABLE ';
                    PRINT @MySql;
                    SET @MySql = 'Exec ' + @ProcNameApply;
                    PRINT @MySql;
                END;
            ELSE
                BEGIN
                    PRINT '-- STEP 5d - READ THE NEW DELETES';
                    PRINT @MySql;
                    SET @MySql = 'Exec ' + @ProcNameApply;
                    EXEC (@MySql) ;
                END;

            --**************************** GET THE LARGET IDENTITY ***************************
            DECLARE
                  @S1 AS nvarchar (max) = '';
            DECLARE
                  @HiIdentity AS bigint = 0;
            SET @S1 = 'select max(' + @IdentCol + ') from ' + @Fqn;
            DECLARE
                  @out TABLE (out int) ;
            INSERT INTO @out
            EXEC (@S1) ;
            SET @HiIdentity = (SELECT * FROM @out) ;
            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 6 - Get the HIGHEST PROD Identity';
                    PRINT @S1;
                    PRINT '-- @HiIdentity: ' + CAST (@HiIdentity AS nvarchar (50)) ;
                END;
            SET @HiIdentity = @HiIdentity + 10000;
            --**************************** REMOVE THE IDENTITY COL ***************************		
            IF @KeyDataType != 'uniqueidentifier'
                BEGIN
                    SET @TSql = 'UPDATE ' + @TestTblName + ' SET ' + @IdentCol + ' = NULL ';
                    IF @PreviewOnly = 1
                        BEGIN
                            PRINT '-- STEP 7 - Remove the identity column';
                            PRINT 'EXEC proc_RemoveIdentityCols "' + @TestTblName + '"';
                            PRINT @TSql;
                        END;
                    ELSE
                        BEGIN EXEC proc_RemoveIdentityCols @TestTblName;
                            EXEC (@TSql) ;
                        END;
                    -- SELECT MAX (itemid) FROM KenticoCMS_1.dbo.HFit_UserGoal;

                    SET @TSql = 'ALTER TABLE ' + @TestTblName + ' DROP COLUMN ' + @IdentCol;
                    IF @PreviewOnly = 1
                        BEGIN
                            PRINT '-- STEP 8 - Remove the identity column';
                            PRINT @TSql;
                        END;
                    ELSE
                        BEGIN EXEC (@TSql) ;
                        END;

                    SET @TSql = 'ALTER TABLE ' + @TestTblName + ' ADD ' + @IdentCol + ' INT NOT NULL IDENTITY (' + CAST (@HiIdentity AS nvarchar (50)) + ', 10) ';
                    IF @PreviewOnly = 1
                        BEGIN
                            PRINT '-- STEP 9 - ADD NEW identity column values ';
                            PRINT @TSql;
                        END;
                    ELSE
                        BEGIN EXEC (@TSql) ;
                        END;
                END;
            ELSE
                BEGIN
                    PRINT '-- STEP 7 - Remove the uniqueidentifier primary key column';
                    --DECLARE @pkey_CONSTRAINT_NAME NVARCHAR(250) = '' ;
                    --SET @pkey_CONSTRAINT_NAME  = (SELECT CONSTRAINT_NAME
                    --    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                    --    WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
                    --    AND TABLE_NAME = @TestTblName AND TABLE_SCHEMA = 'dbo')

                    --SET @MySql = 'ALTER TABLE '+@TestTblName+' DROP CONSTRAINT ' + @pkey_CONSTRAINT_NAME  ;
                    --exec (@MySql ) ;

                    PRINT '-- STEP 8 - Remove the uniqueidentifier column';
                    --SET @MySql = 'ALTER TABLE '+@TestTblName+' DROP column ' + @IdentCol  ;
                    --exec (@MySql ) ;
                    PRINT '-- STEP 9 - ADD NEW uniqueidentifier column values ';
                    --SET @MySql = 'ALTER TABLE '+@TestTblName+' add ' + @IdentCol + ' uniqueidentifier default newid() ' ;
                    --exec (@MySql ) ;
                    SET @MySql = 'Update ' + @TestTblName + ' set ' + @IdentCol + ' = newid() ';
                    EXEC (@MySql) ;
                END;
            --**************************** GENERATE INSERT DLL ***************************
            DECLARE
                  @InsertDDL AS nvarchar (max) ;
            EXEC proc_genSelectInto @InstanceName , @TestTblName , @SrcTbl , DDL;
            SET @InsertDDL = (SELECT DDL
                                FROM ##TEMP_InsertDDL) ;
            --select @InsertDDL 

            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 10 - Get the INSERT DDL';
                    PRINT '/*';
                    PRINT @InsertDDL;
                    PRINT '*/';
                    IF LEN (@InsertDDL) > 2000
                        BEGIN
                            SELECT @InsertDDL AS InsertDDL;
                        END;
                END;
            --***************************** PERFORM INSERT  *****************************			 
            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 11 - EXECUTE THE INSERT and put the data back into the PROD table';
                    SET @MySql = 'SET IDENTITY_INSERT ' + @fqn + ' ON';
                    PRINT @MySql;
                    PRINT @InsertDDL;
                    SET @MySql = 'SET IDENTITY_INSERT ' + @fqn + ' OFF';
                    PRINT @MySql;
                    SET @MySql = 'Exec ' + @ProcNameApply;
                    PRINT @MySql;
                END;
            ELSE
                BEGIN
                    PRINT '-- STEP 11a - READ THE NEW INSERTS';
                    SET @MySql = 'Exec ' + @ProcNameApply;
                    PRINT @MySql;
                    EXEC (@MySql) ;
                END;
            --***************************** CHECK FOR CHANGES TO BASE TABLE *****************************			 
            SET @MySQl = 'Select count(*) as ChangeCnt from ' + @TblName + ' where LastModifiedDate > ''' + CAST (@LastModifiedDate AS nvarchar (50)) + '''';
            DECLARE
                  @BT_CNT AS bigint = 0;
            DECLARE
                  @out2 TABLE (out int) ;
            INSERT INTO @out2
            EXEC (@MySQl) ;
            SET @BT_CNT = (SELECT * FROM @out2) ;


            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 12 - Number of changes found in base table: ' + @TblName + ' after ' + CAST (@LastModifiedDate AS nvarchar (50)) + ' = ' + CAST (@BT_CNT AS nvarchar (50)) ;
                    PRINT @MySQl;
                END;
            ELSE
                BEGIN
                    PRINT 'Number of changes found in base table: ' + @TblName + ' after ' + CAST (@LastModifiedDate AS nvarchar (50)) + ' = ' + CAST (@BT_CNT AS nvarchar (50)) ;
                    IF @RowID IS NOT NULL
                        BEGIN
                            UPDATE MART_CT_Test_Completed
                              SET UpdtCount = @BT_CNT
                              WHERE RowID = @RowID;
                        END;
                END;
            --***************************** CHECK FOR CHANGES TO BASE HISTORY TABLE *****************************
            DECLARE
                  @HIST_TBL AS nvarchar (250) = @TblName + '_DEL';
            SET @MySQl = 'Select count(*) as HistChangeCnt from ' + @HIST_TBL + ' where LastModifiedDate > ''' + CAST (@LastModifiedDate AS nvarchar (50)) + '''';
            DECLARE
                  @HT_CNT AS bigint = 0;
            DECLARE
                  @out3 TABLE (out int) ;
            INSERT INTO @out3
            EXEC (@MySQl) ;
            SET @HT_CNT = (SELECT * FROM @out3) ;

            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 13 - Number of changes found in hist base table: ' + @HIST_TBL + ' after ' + CAST (@LastModifiedDate AS nvarchar (50)) + ' = ' + CAST (@HT_CNT AS nvarchar (50)) ;
                    PRINT @MySQl;
                END;
            ELSE
                BEGIN
                    PRINT 'Number of changes found in hist base table: ' + @HIST_TBL + ' after ' + CAST (@LastModifiedDate AS nvarchar (50)) + ' = ' + CAST (@HT_CNT AS nvarchar (50)) ;
                    IF @RowID IS NOT NULL
                        BEGIN
                            UPDATE MART_CT_Test_Completed
                              SET HistCount = @HT_CNT
                              WHERE RowID = @RowID;
                        END;
                END;
            --***************************** CHECK FOR CHANGES TO BASE HISTORY TABLE *****************************
            SET @MySQl = 'Select count(*) as HistChangeCnt from ' + @TblName + ' where ' + @IdentCol + ' in (select ' + @IdentCol + ' FROM ' + @TestTblName + ') ';
            DECLARE
                  @NEW_CNT AS bigint = 0;
            DECLARE
                  @out3a TABLE (out int) ;
            INSERT INTO @out3a
            EXEC (@MySQl) ;
            SET @NEW_CNT = (SELECT * FROM @out3a) ;

            IF @PreviewOnly = 1
                BEGIN
                    PRINT '-- STEP 14 - Number of inserts found in HIST table: ' + @TblName + ' after ' + CAST (@LastModifiedDate AS nvarchar (50)) + ' = ' + CAST (@NEW_CNT AS nvarchar (50)) ;
                    PRINT @MySQl;
                END;
            ELSE
                BEGIN
                    PRINT 'Number of inserts found in base table: ' + @TblName + ' after ' + CAST (@LastModifiedDate AS nvarchar (50)) + ' = ' + CAST (@NEW_CNT AS nvarchar (50)) ;
                    IF @RowID IS NOT NULL
                        BEGIN
                            UPDATE MART_CT_Test_Completed
                              SET InsCount = @NEW_CNT
                              WHERE RowID = @RowID;
                        END;
                END;
        --***************************************************************************************************
        END;
    ELSE
        BEGIN
            PRINT @TblName + ' appears to be a view.... add code here.';
        END;

    --SELECT TOP 10 HALastSectionCompleted , * FROM KenticoCMS_1.dbo.HFit_HealthAssesmentUserStarted where ItemId in (select top 10 ItemID from BASE_HFit_HealthAssesmentUserStarted) 
    --SELECT TOP 10 HALastSectionCompleted , * FROM base_HFit_HealthAssesmentUserStarted where ItemId in (select top 10 ItemID from BASE_HFit_HealthAssesmentUserStarted) 
    SET NOCOUNT OFF;
END; -- PROC

GO
PRINT 'Executed proc_MartTestTableDataPull.sql';
GO
