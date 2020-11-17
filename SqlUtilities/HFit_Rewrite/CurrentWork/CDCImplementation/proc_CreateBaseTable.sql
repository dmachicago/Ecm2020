
-- use DataMartPlatform

GO
PRINT 'Executing proc_CreateBaseTable.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CreateBaseTable') 
    BEGIN
        DROP PROCEDURE proc_CreateBaseTable;
    END;
GO

-- EXEC proc_CreateBaseTable 'KenticoCMS_1', 'CMS_MembershipUser', 0
-- EXEC proc_CreateBaseTable 'KenticoCMS_2', 'CMS_MembershipUser', 1
-- EXEC proc_CreateBaseTable 'KenticoCMS_3', 'CMS_MembershipUser', 1

CREATE PROCEDURE proc_CreateBaseTable (@DBNAME AS nvarchar (200) 
                                     , @TblName AS nvarchar (200) 
                                     , @SkipIfExists AS bit = 1
                                     , @AddTableDefaults AS nvarchar (20) = 'NO'
                                     , @JustModTheProcs AS bit = 0) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
           @tsql AS nvarchar (max) = ''
         , @RC AS int = 0
         , @StartTime AS datetime = GETDATE () 
         , @rowcount int
         , @TS AS nvarchar (500) = 'select count(*) from ' + @DBNAME + '.information_schema.tables where table_name = ''' + @TblName + '''';

    DECLARE
           @zout TABLE (zout int) ;
    INSERT INTO @zout
    EXEC (@TS) ;
    SET @rowcount = (SELECT zout
                       FROM @zout) ;

    IF @rowcount = 0
        BEGIN
            PRINT @DBNAME + '.' + @TblName + ' not found, aborting.';
            PRINT 'ENDING TIME: ';
            PRINT GETDATE () ;
            RETURN;
        END;
    ELSE
        BEGIN
            PRINT 'BEGINNING PROCESS of: ' + @DBNAME + '.' + @TblName;
            PRINT 'STARTING TIME: ';
            PRINT @StartTime;
        END;

    DECLARE
           @tcnt AS int = 0;
    EXEC @tcnt = isPrimaryKeyExists @DBNAME, @TblName;

    IF @tcnt = 0
        BEGIN
            DECLARE
                   @xcolname AS nvarchar (500) = @TblName + '_GuidID';
            DECLARE
                   @pkname AS nvarchar (500) = 'PKey_CT_' + @TblName;
            SET @tsql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' ADD ' + @xcolname + ' uniqueidentifier not null default newid() ';
            EXEC (@tsql) ;
            SET @tsql = 'ALTER TABLE ' + @DBNAME + '.dbo.' + @TblName + ' ADD CONSTRAINT ' + @pkname + ' PRIMARY KEY (' + @xcolname + ') ';
            EXEC (@tsql) ;
        END;

    -- Each table tracked for changes requires:
    --	   3 stored procedures to track and apply changes
    --	   3 Tables FACT/DIM/HIST (_DEL)
    --	   1 Hist Delete Trigger 
    --	   1 Hist Update Trigger 

    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'CT_CONTROL_MASTER') 
        BEGIN
            CREATE TABLE CT_CONTROL_MASTER (run_action char (1) NULL) ;
        END;
    DECLARE
           @RunControl AS char (1) 
         , @Msg nvarchar (max) ;
    SET @RunControl = (SELECT TOP 1 run_action
                         FROM CT_CONTROL_MASTER) ;

    --Check RUN CONTROL and if "Q", quit the run.

    IF @RunControl = 'Q'
        BEGIN
            SET @Msg = 'CT_CONTROL_MASTER run_action set to "Q" - aborting: ' + @TblName;
            EXEC PRintImmediate @Msg;
            EXEC proc_SetDefaultTrackerName;
            EXEC proc_SetDefaultRowDataUpdated;
            PRINT 'ENDING TIME: ';
            PRINT GETDATE () ;
            RETURN;
        END;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    PRINT 'Inside proc_CreateBaseTable: ' + @DBNAME + ' / ' + @TblName;
    DECLARE
           @S AS nvarchar (2000) = ''
         , @BASETable AS nvarchar (100) = 'BASE_' + @TblName
         , @DelTable AS nvarchar (100) = 'BASE_' + @TblName + '_DEL'
         , @r varchar (max) ;
    IF @SkipIfExists = 1
        BEGIN
            IF EXISTS (SELECT TABLE_NAME
                         FROM INFORMATION_SCHEMA.TABLES
                         WHERE TABLE_NAME = @BASETable) 
                BEGIN
                    PRINT 'Skipping Table Exists: ' + @BASETable;
                    GOTO VERIFYCOLS;
                END;
        END;
    IF EXISTS (SELECT TABLE_NAME
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_NAME = @BASETable) 
        BEGIN
            PRINT 'REPLACING table: ' + @BASETable;
            SET @S = ' drop table ' + @BASETable;
            --SET @S = ' exec proc_MatchChildToSvrSideTable ''' + @DBNAME + ''', '''+@TblName+''',0' ;
            PRINT @s;
            EXEC (@S) ;
        END;
    PRINT 'Creating table: ' + @BASETable;
    SET @S = ' SELECT top 10 * INTO ' + @BASETable + ' FROM ' + @DBNAME + '.DBO.' + @TblName;
    EXEC (@S) ;
    IF EXISTS (SELECT name
                 FROM sys.key_constraints
                 WHERE type = 'PK'
                   AND OBJECT_NAME (parent_object_id) = @BASETable) 
        BEGIN
            DECLARE
                   @CNAME AS nvarchar (250) = (SELECT name
                                                 FROM sys.key_constraints
                                                 WHERE type = 'PK'
                                                   AND OBJECT_NAME (parent_object_id) = @BASETable) ;
            PRINT 'EXISTING PRIMARY KEY FOUND: ' + @CNAME;

            -- Delete the primary key constraint.

            DECLARE
                   @MySql AS nvarchar (max) = '';
            SET @MySql = 'ALTER TABLE dbo.' + @BASETable + ' DROP CONSTRAINT ' + @CNAME;
            EXEC (@MySql) ;
        END;
    ELSE
        BEGIN
            PRINT 'NO EXISTING PRIMARY KEY FOUND';
        END;
    SET @S = ' Truncate table ' + @BASETable;
    EXEC (@S) ;
    EXEC proc_RemoveIdentityCols @BASETable, 1;

    --**********************************************************************
    --Convert all DATETIME to DATETIME2 here
    --SKIP IF ALREADY DONE

    PRINT '#1 proc_ConvertAllDatetimeToDatetime2 : ' + @BASETable;
    EXEC proc_ConvertAllDatetimeToDatetime2 @BASETable;

    --**********************************************************************
    --CONVERT ALL BIGINT TO INT 
    --SKIP IF ALREADY DONE

    PRINT '#1 proc_ConvertBigintToInt: ' + @BASETable;
    EXEC proc_ConvertBigintToInt @BASETable;

    --**********************************************************************

    VERIFYCOLS:
    IF EXISTS (SELECT TABLE_NAME
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_NAME = @DelTable) 
        BEGIN
            IF @SkipIfExists = 1
                BEGIN
                    --SET @S = ' exec proc_MatchChildToSvrSideTable ''' + @DBNAME + ''', '''+@TblName+''',0' ;
                    GOTO SkipDelTable;
                END;
            SET @Msg = 'REPLACING table: ' + @DelTable;
            EXEC PrintImmediate @Msg;
            SET @S = ' drop table ' + @DelTable;
            --SET @S = ' exec proc_MatchChildToSvrSideTable ''' + @DBNAME + ''', '''+@TblName+''',0' ;
            PRINT @s;
            EXEC (@S) ;
        END;
    SET @Msg = 'Creating table: ' + @DelTable;
    EXEC PrintImmediate @Msg;

    --SET  @S = ' SELECT top 1 * INTO ' + @DelTable + ' FROM ' + @DBNAME + '.DBO.' + @TblName;

    SET @S = ' SELECT top 1 * INTO ' + @DelTable + ' FROM ' + @BASETable;
    EXEC (@S) ;
    SET @S = ' Truncate table ' + @DelTable;
    EXEC (@S) ;

    --**********************************************************************    

    IF @JustModTheProcs = 1
        BEGIN
            GOTO JustModTheProcs;
        END;

    PRINT '#2 proc_ConvertAllDatetimeToDatetime2 : ' + @BASETable;

    --Convert all DATETIME to DATETIME2 here`
    --SKIP IF ALREADY DONE

    EXEC proc_ConvertAllDatetimeToDatetime2 @DelTable;
    BEGIN TRY
        --set @S = 'if not exists(select column_name from information_schema.columns where table_name = ''' + @DelTable + ''' and column_name = ''Action'')' + char(10) ;
        SET @S = @S + ' Alter table ' + @DelTable + ' add Action char(1) null ';
        EXEC (@S) ;
        PRINT 'Added Action to ' + @DelTable;
    END TRY
    BEGIN CATCH
        PRINT 'Action exists in ' + @DelTable;
    END CATCH;
    BEGIN TRY
        SET @S = ' Alter table ' + @BASETable + ' add Action char(1) null ';
        EXEC (@S) ;
        PRINT 'Added Action to ' + @BASETable;
    END TRY
    BEGIN CATCH
        PRINT 'Action exists in ' + @BASETable;
    END CATCH;
    BEGIN TRY
        SET @S = ' Alter table ' + @DelTable + ' add ActionDate datetime2 default getdate() ';
        EXEC (@S) ;
        PRINT 'Added ActionDate to ' + @DelTable;
    END TRY
    BEGIN CATCH
        PRINT 'ActionDate exists in ' + @DelTable;
    END CATCH;

    --**********************************************************************
    --CONVERT ALL BIGINT TO INT 

    PRINT '#2 proc_ConvertBigintToInt ';
    EXEC proc_ConvertBigintToInt @DelTable;

    --**********************************************************************
    EXEC proc_RemoveIdentityCols @DelTable;    
    --**********************************************************************
    --**** GENERATE THE INSERT TRIGGER ON THE BASE TABLE
    EXEC proc_GenInsertTrigger @DelTable;
    --**********************************************************************

    SkipDelTable:
    DECLARE
           @SQL AS nvarchar (100) = ''
         , @ChgTable AS nvarchar (100) = @BASETable + '_CTVerHIST';
    IF EXISTS (SELECT TABLE_NAME
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_NAME = @ChgTable) 
        BEGIN
            IF @SkipIfEXists = 1
                BEGIN
                    GOTO SkipChangeTbl;
                END;
            SET @SQL = 'drop table ' + @ChgTable;
            EXEC (@SQL) ;
        END;
    IF NOT EXISTS (SELECT TABLE_NAME
                     FROM INFORMATION_SCHEMA.TABLES
                     WHERE TABLE_NAME = @ChgTable) 
        BEGIN
            PRINT 'CREATING table: ' + @ChgTable;
            SET @S = ' CREATE TABLE [dbo].[' + @ChgTable + '](' + CHAR (10) ;
            SET @S = @S + '[SYS_CHANGE_VERSION] [bigint] NOT NULL, ' + CHAR (10) ;
            SET @S = @S + '[DBMS] nvarchar(250) NOT NULL, ' + CHAR (10) ;
            SET @S = @S + 'CONSTRAINT [PK_' + @ChgTable + '] PRIMARY KEY CLUSTERED  ' + CHAR (10) ;
            SET @S = @S + '(' + CHAR (10) ;
            SET @S = @S + '	[DBMS] ASC ' + CHAR (10) ;
            SET @S = @S + '	,[SYS_CHANGE_VERSION] ASC ' + CHAR (10) ;
            SET @S = @S + ')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY] ' + CHAR (10) ;
            SET @S = @S + ') ON [PRIMARY] ' + CHAR (10) ;
            PRINT 'CREATED table: ' + @ChgTable;
            EXEC (@S) ;
        END;

    --**********************************************************************
    --Convert all DATETIME to DATETIME2 here

    PRINT '#3 proc_ConvertAllDatetimeToDatetime2 : ' + @BASETable;
    EXEC proc_ConvertAllDatetimeToDatetime2 @ChgTable;

    --**********************************************************************
    --Set the LATEST version number for the table here.
    EXEC proc_ResetTableCTVersionToLatest 'PROD', @DBNAME, @TblName, 0;
    
    --******************************************************************************

    SkipChangeTbl:
    DECLARE
           @SurrogateKeyName AS nvarchar (100) = '';
    SET @SurrogateKeyName = 'SurrogateKey_' + @TblName;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = @SurrogateKeyName
                       AND TABLE_NAME = @BASETable) 
        BEGIN
            SET @msg = 'Adding Column ' + @SurrogateKeyName + ' to ' + @BASETable;
            EXEC PrintImmediate @msg;
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD ' + @SurrogateKeyName + ' bigint identity (1,1) not NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = @SurrogateKeyName
                       AND TABLE_NAME = @DelTable) 
        BEGIN
            SET @msg = 'Adding Column ' + @SurrogateKeyName + 'to ' + @DelTable;
            EXEC PrintImmediate @msg;
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD ' + @SurrogateKeyName + ' bigint NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;

    --******************************************************************************

    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'SYS_CHANGE_VERSION'
                       AND TABLE_NAME = @BASETable) 
        BEGIN EXEC PrintImmediate 'Adding Column SYS_CHANGE_VERSION';
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD SYS_CHANGE_VERSION bigint not NULL default 0  ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'SYS_CHANGE_VERSION'
                       AND TABLE_NAME = @DelTable) 
        BEGIN EXEC PrintImmediate 'Adding Column SYS_CHANGE_VERSION';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD SYS_CHANGE_VERSION bigint NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'LastModifiedDate'
                       AND TABLE_NAME = @BASETable) 
        BEGIN EXEC PrintImmediate 'Adding Column LastModifiedDate';
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD LASTMODIFIEDDATE datetime2 NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'LastModifiedDate'
                       AND TABLE_NAME = @DelTable) 
        BEGIN EXEC PrintImmediate 'Adding Column LastModifiedDate';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD LASTMODIFIEDDATE datetime2 NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'HashCode'
                       AND TABLE_NAME = @BASETable) 
        BEGIN EXEC PrintImmediate 'Adding Column HashCode';
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD HashCode nvarchar(75) NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'HashCode'
                       AND TABLE_NAME = @DelTable) 
        BEGIN EXEC PrintImmediate 'Adding Column HashCode';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD HashCode nvarchar(75) NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;

    --*********************************************************************************************
    -- use DataMartPlatform

    SET @Msg = '11X - Verifying CT cols in ' + @BASETable;
    EXEC PrintImmediate @Msg;
    EXEC mart_GenObjVarBitFlgAlterStmts @DBNAME, @TblName, @r OUTPUT;

    --SELECT @r ;

    IF NOT EXISTS (SELECT column_name
                     FROM information_schema.columns
                     WHERE table_name = @BASETable
                       AND column_name = 'CT_RowDataUpdated') 
        BEGIN
            SET @mysql = 'Alter table ' + @BASETable + ' add CT_RowDataUpdated bit null default 1';
        END;

    --*********************************************************************************************
    EXEC mart_AddMissingColumns @BASETable, @DelTable;
    --*********************************************************************************************

    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'SVR'
                       AND TABLE_NAME = @BASETable) 
        BEGIN EXEC PrintImmediate 'Adding Column SVR';
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD SVR nvarchar (100) NOT NULL default @@SERVERNAME ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'SVR'
                       AND TABLE_NAME = @DelTable) 
        BEGIN EXEC PrintImmediate 'Adding Column SVR';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD SVR nvarchar (100) NOT NULL default @@SERVERNAME ';
            PRINT @s;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @DelTable + ' contains column DBNAME.';
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'DBNAME'
                       AND TABLE_NAME = @BASETable) 
        BEGIN EXEC PrintImmediate 'Adding Column DBNAME';
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD DBNAME nvarchar (100) NOT NULL default DB_NAME() ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'DBNAME'
                       AND TABLE_NAME = @DelTable) 
        BEGIN EXEC PrintImmediate 'Adding Column DBNAME';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD DBNAME nvarchar (100) NOT NULL default DB_NAME() ';
            PRINT @s;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @DelTable + ' contains column DBNAME.';
        END;
    IF @SkipIfExists != 1
        BEGIN
            SET @S = 'UPDATE ' + @BASETable + ' SET SVR = @@SERVERNAME where SVR is null ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF @SkipIfExists != 1
        BEGIN
            SET @S = 'UPDATE ' + @DelTable + ' SET SVR = @@SERVERNAME where SVR is null ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'DBNAME'
                       AND TABLE_NAME = @BASETable) 
        BEGIN EXEC PrintImmediate 'DOES not contain Column DBNAME';
            SET @S = 'ALTER TABLE ' + @BASETable + ' ADD DBNAME nvarchar (100) not NULL default ''-'' ';
            PRINT @s;
            EXEC (@S) ;
        END;
    ELSE
        BEGIN
            PRINT @BASETable + ' contain column DBNAME.';
        END;
    IF NOT EXISTS (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE COLUMN_NAME = 'DBNAME'
                       AND TABLE_NAME = @DelTable) 
        BEGIN EXEC PrintImmediate 'Adding Column DBNAME';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD DBNAME nvarchar (100) not NULL default ''-'' ';
            PRINT @s;
            EXEC (@S) ;
        END;

    --Verify CT Columns are in the BASE table

    IF EXISTS (SELECT TABLE_NAME
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_NAME = @BASETable) 
        BEGIN
            SET @Msg = 'Verifying CT cols in ' + @BASETable;
            EXEC PrintImmediate @Msg;

            --ADD CT Columns to the BASE table

            EXEC mart_GenObjVarBitFlgAlterStmts @DBNAME, @TblName, @r OUTPUT;

        --SELECT @r ;

        END;

    --*************************************************************************************

    IF @SkipIfExists != 1
        BEGIN
            SET @S = 'UPDATE ' + @BASETable + ' SET DBNAME = ''' + @DBNAME + '''' + ' where DBNAME = ''-'' ';
            PRINT '001: ' + @s;
            EXEC (@S) ;
            SET @S = 'UPDATE ' + @DelTable + ' SET DBNAME = ''' + @DBNAME + '''' + ' where DBNAME = ''-'' ';
            PRINT '002: ' + @s;
            EXEC (@S) ;
        END;
    DECLARE
           @TblKeys AS nvarchar (2000) = '';
    DECLARE
           @PK AS nvarchar (2000) = NULL;
    EXEC @TblKeys = procGetTablePK @DBNAME, @TblName, @PK OUT;
    SET @TblKeys = @PK;
    PRINT @TblKeys;
    DECLARE
           @NewPkCols AS nvarchar (2000) = 'SVR, DBNAME, ' + @TblKeys;
    SET @mysql = '';
    DECLARE
           @IdxName AS nvarchar (2000) = 'UKI_' + @BASETable + ' ';
    SET @IdxName = 'CI_' + @BASETable + ' ';
    IF NOT EXISTS (SELECT name
                     FROM sys.indexes
                     WHERE name = @IdxName) 
        BEGIN
            DECLARE

            --@CICols AS NVARCHAR (2000) = replace (@NewPkCols , 'SYS_CHANGE_VERSION,' , '') ;

                   @CICols AS nvarchar (2000) = @NewPkCols;
        END;
    BEGIN
        PRINT 'Creating Index: ' + @IdxName;
        SET @mysql = 'CREATE NONCLUSTERED INDEX [' + @IdxName + '] ON [dbo].[' + @BASETable + '] ' + CHAR (10) ;
        SET @mysql+='(' + CHAR (10) ;
        SET @mysql+=@CICols + CHAR (10) ;
        SET @mysql+=')' + CHAR (10) ;
        SET @mysql+=' INCLUDE (LastModifiedDate, HashCode) ' + CHAR (10) ;
        EXEC (@mysql) ;
        PRINT 'Created: ' + @IdxName;
        PRINT @mysql;
    END;

    --ALTER TABLE ConstraintTable ADD CONSTRAINT Ct_ID PRIMARY KEY (ID)
    --SYS_CHANGE_VERSION,

    SET @Msg = 'ADDING PK to: ' + @BASETable + '  - KEY: ' + @NewPkCols;
    EXEC PrintImmediate @Msg;
    DECLARE
           @ConstName AS nvarchar (200) = 'PKEY_' + @BASETable;
    IF EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
                 WHERE CONSTRAINT_NAME = @ConstName) 
        BEGIN
            PRINT 'drop primary key if it exists HERE';
        END;
    IF NOT EXISTS (SELECT *
                     FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
                     WHERE CONSTRAINT_NAME = @ConstName) 
        BEGIN
            PRINT 'PK Constraint: ' + @IdxName;
            BEGIN TRY
                SET @MySql = 'ALTER TABLE ' + @BASETable + ' ADD CONSTRAINT ' + @ConstName + ' PRIMARY KEY CLUSTERED (' + @SurrogateKeyName + ') ';
                EXEC (@MySql) ;
                PRINT 'Added Primary Key: ' + @ConstName + ' ON ' + @SurrogateKeyName;
            END TRY
            BEGIN CATCH
                PRINT '!!! WARNING ON : Primary Key: ' + @ConstName + ' ON ' + @NewPkCols;

            --EXECUTE usp_GetErrorInfo;

            END CATCH;
        END;
    PRINT 'ADDING Change Tracking to: ' + @DBNAME + '.' + @TblName;
    EXEC proc_ChangeTracking @DBNAME, @TblName, 1;

    --*********************************
    -- ADD THE STANDARD COLUMNS

    BEGIN TRY
        SET @S = ' Alter table ' + @DelTable + ' add Action char(1) null ';
        EXEC (@S) ;
    END TRY
    BEGIN CATCH
        PRINT 'Column Action already in ' + @DelTable;
    END CATCH;
    BEGIN TRY
        SET @S = ' Alter table ' + @BASETable + ' add Action char(1) null ';
        EXEC (@S) ;
    END TRY
    BEGIN CATCH
        PRINT 'Column Action already in ' + @BASETable;
    END CATCH;
    BEGIN TRY
        SET @S = ' Alter table ' + @BASETable + ' add DBNAME nvarchar(100) null ';
        EXEC (@S) ;
    END TRY
    BEGIN CATCH
        PRINT 'Column DBNAME already in ' + @BASETable;
    END CATCH;

    --**********************************************************************
    -- GENERATE THE TRIGGERS
    EXEC regen_CT_Triggers @BASETable;
    --**** GENERATE THE INSERT TRIGGER ON THE BASE TABLE
    EXEC proc_GenInsertTrigger @DelTable;
    --**********************************************************************
   
    --***********************************************************************************************
    DECLARE
           @OUT nvarchar (max) 
         , @DDL nvarchar (max) 
         , @HISTPROC AS nvarchar (100) = 'proc_' + @TBLNAME + '_' + @DBNAME + '_CTHist';
    IF NOT EXISTS (SELECT name
                     FROM sys.procedures
                     WHERE name = @HISTPROC) 
        BEGIN
            PRINT '00 - CREATING PROC: ' + @HISTPROC;
            SET @OUT = '';
            SET @DDL = '';

            --**************************** EXEC *****************************************

            EXEC proc_GenCT_HistProcedure @DBNAME, @TBLNAME, @ChgTable, @DDL OUTPUT;

            --**************************** EXEC *****************************************

            SET @OUT = (SELECT @DDL) ;
            EXEC (@OUT) ;
            PRINT 'CREATED HISTORY TRACKING PROC: ' + @HISTPROC;
        END;
    --***********************************************************************************************

    PRINT 'Adding CT to ' + @BASETable;
    DECLARE
           @DBMSNAME AS nvarchar (100) = DB_NAME () ;
    PRINT 'ADDING CT TO: ' + @DBMSNAME + '.' + @BASETable;
    EXEC proc_ChangeTracking @DBMSNAME, @BASETable, 1;
    PRINT 'Added CT: ' + @BASETable;
    SET @DDL = '';

    JustModTheProcs:
    SET @Msg = '12X - Verifying CT cols in ' + @BASETable;
    EXEC PrintImmediate @Msg;
    EXEC mart_GenObjVarBitFlgAlterStmts @DBNAME, @TblName, @r OUTPUT;
    EXEC mart_AddMissingColumns @BaseTableName = @BASETable, @TgtName = @DelTable;
    SET @Msg = 'Starting proc_genPullChangesProc: ' + CAST (GETDATE () AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;
    --****************************--------*****************************************    
    --****************************--------*****************************************        
    EXEC @RC = proc_genPullChangesProc @DBNAME, @TblName;
    IF @RC < 0
        BEGIN
            PRINT 'ERROR: proc_genPullChangesProc ' + @DBNAME + ' / ' + @TblName + ', ABORTING...';
            RETURN;
        END; 
    --****************************--------*****************************************    
    --****************************--------*****************************************    
    SET @Msg = 'Finished proc_genPullChangesProc: ' + CAST (GETDATE () AS nvarchar (50)) ;
    EXEC PrintImmediate @Msg;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    IF @AddTableDefaults = 'YES'
        BEGIN
            SET @msg = 'ADDING Defaults to ' + @BASETable;
            EXEC PrintImmediate @Msg;

            --**************************** EXEC *****************************************
            -- CREATE THE INIT DEFAULT PROC            

            EXEC proc_GenBaseTableDefaults @BASETable, 'NO';
            EXEC proc_SetBaseTableNoNulls @BASETable;

            -- CREATE THE VIEW THAT RETURNS DATA WITHOUT ANY NULLS

            EXEC proc_GenBaseViewNoNulls @BASETable;

        --**************************** EXEC *****************************************

        END;
    ELSE
        BEGIN
            SET @msg = 'NOT ADDING Defaults to ' + @BASETable;
            EXEC PrintImmediate @Msg;
        END;

    --**************************** EXEC *****************************************
    SET @Msg = 'Executing: proc_SetDefaultTrackerName ' + @BASETable;
    EXEC PrintImmediate @msg;
    PRINT GETDATE () ;
    IF CHARINDEX ('tracker', @BASETable) > 0
        BEGIN EXEC proc_SetDefaultTrackerName;
        END;

    SET @Msg = 'Executing: proc_SetDefaultRowDataUpdated ' + @BASETable;
    EXEC PrintImmediate @msg;
    PRINT GETDATE () ;

    DECLARE
           @vcnt AS int = 0;
    SET @vcnt = (SELECT COUNT (*)
                   FROM information_schema.columns
                   WHERE column_name = 'CT_RowDataUpdated'
                     AND TABLE_SCHEMA = 'dbo'
                     AND table_name = @BASETable
                     AND column_default IS NULL
                     AND table_name NOT LIKE '%_DEL') ;

    IF @vcnt > 0
        BEGIN EXEC proc_SetDefaultRowDataUpdated;
        END;

    SET @Msg = 'Executing: proc_SetPrimaryKeyToSurrogateKey' + @BASETable;
    EXEC PrintImmediate @msg;
    PRINT GETDATE () ;
    EXEC proc_SetPrimaryKeyToSurrogateKey @BASETable;
    SET @Msg = 'Completed: proc_SetPrimaryKeyToSurrogateKey' + @BASETable;
    EXEC PrintImmediate @msg;
    PRINT GETDATE () ;
    
    --**************************** POPULATE THE INITAL DELTA DATA *****************************************
    EXEC proc_InitializeDelTableData @BASETable, 0;
    --**************************** EXEC *****************************************

    SET NOCOUNT OFF;
    PRINT 'STARTING TIME: ';
    PRINT @StartTime;
    PRINT 'ENDING TIME: ';
    PRINT GETDATE () ;

    PRINT '************************ COMPLETED ' + @DBNAME + ' / ' + @TblName + ' ********************************************';
END;
GO
PRINT 'Executed proc_CreateBaseTable.sql';
GO


